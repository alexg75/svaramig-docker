import logging
import sys

def setup_logger(name: str = 'app_logger') -> logging.Logger:
    logger = logging.getLogger(name)
    logging.basicConfig(filename=f'/var/log/{name}.log', encoding='utf-8', level=logging.INFO)

    # Avoid duplicate handlers if logger is already configured
    if not logger.handlers:
        handler = logging.StreamHandler(sys.stdout)
        formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        )
        handler.setFormatter(formatter)
        logger.addHandler(handler)

    return logger