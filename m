Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40585150362
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 10:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgBCJbf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 04:31:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43711 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgBCJbf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2020 04:31:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id z9so4776025wrs.10;
        Mon, 03 Feb 2020 01:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcK5gX39k7bDP30En74hDz2t8ifbaHw7QATZ4PpRTeU=;
        b=KtRSEtwXUVSItz0gXLeiU6JgXLpbytR/cMLYF08+K1OVet7zsyVcixx6By8m8KND6U
         HQZFPbB1khdN1TLh7pBY8ZXcDOhYcR/92sbzROOCfqe0Ras15mMJ8xL1DJ+9SO+G+Uf1
         Y9IIBtkhn5O8n42Zc+iD2ftQk5LgLp6Hx1WozCqdK5vwYbstkh8/Kri4VkBbJB2KaolS
         5xR0JLTmg2zAfJIhwiI9RKQjYPDGq3NP6eU1XOrJiHbJ0ig70V2yMpcH46pL4klXoZgX
         T1+PbTCf2QLFXLqm7QkLIqKEGaX6VEjNNdtsTu8e3BFuLrIuvdSibmBBbgb0EMzVsqq5
         kh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcK5gX39k7bDP30En74hDz2t8ifbaHw7QATZ4PpRTeU=;
        b=Y9qBqrULCttFpgqJGzMIPHyC7wRH/aWB8dExcWA9+9j2c0Qcr/zrfNQ4mjyb1mFHz4
         h2WZIGc3e6qxpIch28zGrEzNxcLM+tEoxRXPlDDM4GUSuBBazVoEdAecqbaPiaRDjK/5
         W6pbQA6tfX/mzBdbIgrvt4eXr6cObYGwhedCPoXum9FA8TSkVC7RO1GO09Le/J6bKkgR
         HyoTZhC91ShV5ba2odpj4QGqic3qoIE3eowRhyC+DoXR4vshgS9OFHJlns3S8idxItLn
         xJzNOGfgtwPoIjppztzpLBua4oZ+OeOQvVqtLeKNzsZVhY3r9t6xyLaYq4/BU3XWn8aJ
         +uOA==
X-Gm-Message-State: APjAAAVpMwdP0U3xe7/985Oh3hDCAWsXLbxTN3wJbmM3Rij/J/vf3fEO
        e+8SpuYjEOXCMZA6E5U2NdA=
X-Google-Smtp-Source: APXvYqxV7mfK34Grbx0uqjWGjcNDfZA4O8t/SOJ/Lf1ePMmzJ69rW4su3VICqdplhWpnR7qEnYlZVA==
X-Received: by 2002:adf:f4cb:: with SMTP id h11mr14686868wrp.90.1580722291964;
        Mon, 03 Feb 2020 01:31:31 -0800 (PST)
Received: from nsa-Precision-5530 ([91.180.85.7])
        by smtp.googlemail.com with ESMTPSA id z3sm7554609wrs.32.2020.02.03.01.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Feb 2020 01:31:31 -0800 (PST)
Message-ID: <da82db5f81e116c7ecc36f5d9833b90b4f7cd15d.camel@gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: adis: Refactor adis_initial_startup
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, dragos.bogdan@analog.com
Date:   Mon, 03 Feb 2020 10:31:30 +0100
In-Reply-To: <20200201170839.4ab98d8e@archlinux>
References: <20200120142051.28533-1-alexandru.ardelean@analog.com>
         <20200120142051.28533-2-alexandru.ardelean@analog.com>
         <20200201170839.4ab98d8e@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,


On Sat, 2020-02-01 at 17:08 +0000, Jonathan Cameron wrote:
> On Mon, 20 Jan 2020 16:20:49 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > From: Nuno Sá <nuno.sa@analog.com>
> > 
> > All the ADIS devices perform, at the beginning, a self test to make
> > sure
> > the device is in a sane state. Furthermore, some drivers also do a
> > call
> > to `adis_reset()` before the test which is also a good practice.
> > This
> > patch unifies all those operation so that, there's no need for code
> > duplication. Furthermore, the rst pin is also checked to make sure
> > the
> > device is not in HW reset. On top of this, some drivers also read
> > the
> > device product id and compare it with the device being probed to
> > make
> > sure the correct device is being handled. This can also be passed
> > to the
> > library by introducing a variable holding the PROD_ID register of
> > the
> > device.
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/imu/Kconfig      |  1 +
> >  drivers/iio/imu/adis.c       | 63 ++++++++++++++++++++++++++----
> > ------
> >  include/linux/iio/imu/adis.h | 15 ++++++++-
> >  3 files changed, 61 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> > index 60bb1029e759..63036cf473c7 100644
> > --- a/drivers/iio/imu/Kconfig
> > +++ b/drivers/iio/imu/Kconfig
> > @@ -85,6 +85,7 @@ endmenu
> >  
> >  config IIO_ADIS_LIB
> >  	tristate
> > +	depends on GPIOLIB
> >  	help
> >  	  A set of IO helper functions for the Analog Devices ADIS*
> > device family.
> >  
> > diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> > index d02b1911b0f2..1eca5271380e 100644
> > --- a/drivers/iio/imu/adis.c
> > +++ b/drivers/iio/imu/adis.c
> > @@ -7,6 +7,7 @@
> >   */
> >  
> >  #include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/mutex.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> > @@ -365,36 +366,64 @@ static int adis_self_test(struct adis *adis)
> >  }
> >  
> >  /**
> > - * adis_inital_startup() - Performs device self-test
> > + * __adis_initial_startup() - Device initial setup
> >   * @adis: The adis device
> >   *
> > + * This functions makes sure the device is not in reset, via rst
> > pin.
> > + * Furthermore it performs a SW reset (only in the case we are not
> > coming from
> > + * reset already) and a self test. It also compares the product id
> > with the
> > + * device id if the prod_id_reg variable is set.
> > + *
> >   * Returns 0 if the device is operational, a negative error code
> > otherwise.
> >   *
> >   * This function should be called early on in the device
> > initialization sequence
> >   * to ensure that the device is in a sane and known state and that
> > it is usable.
> >   */
> > -int adis_initial_startup(struct adis *adis)
> > +int __adis_initial_startup(struct adis *adis)
> >  {
> >  	int ret;
> > -
> > -	mutex_lock(&adis->state_lock);
> > +	struct gpio_desc *gpio;
> > +	const struct adis_timeout *timeouts = adis->data->timeouts;
> > +	const char *iio_name = spi_get_device_id(adis->spi)->name;
> > +	u16 prod_id, dev_id;
> > +
> > +	/* check if the device has rst pin low */
> > +	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset",
> > GPIOD_ASIS);
> > +	if (IS_ERR(gpio)) {
> > +		return PTR_ERR(gpio);
> 
> Given you are returning here, no need for else to follow
> 
> if (gpio...
> 

Definitely...

> > +	} else if (gpio && gpiod_get_value_cansleep(gpio)) {
> > +		/* bring device out of reset */
> > +		gpiod_set_value_cansleep(gpio, 0);
> 
> Hmm. So is a software reset the best option if we have a hardware
> reset
> line but it's not currently in the reset mode?
> 

Hmm, that's a fair question. Now that I think about it, if we do have a
gpio we should just assume it's in reset and call
`gpiod_set_value_cansleep`. So, I guess we could just ditch the
`gpiod_get_value_cansleep(gpio)` part.

> > +		msleep(timeouts->reset_ms);
> > +	} else {
> > +		ret = __adis_reset(adis);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	ret = adis_self_test(adis);
> > -	if (ret) {
> > -		dev_err(&adis->spi->dev, "Self-test failed, trying
> > reset.\n");
> > -		__adis_reset(adis);
> > -		ret = adis_self_test(adis);
> > -		if (ret) {
> > -			dev_err(&adis->spi->dev, "Second self-test
> > failed, giving up.\n");
> > -			goto out_unlock;
> > -		}
> > -	}
> > +	if (ret)
> > +		return ret;
> >  
> > -out_unlock:
> > -	mutex_unlock(&adis->state_lock);
> > -	return ret;
> > +	if (!adis->data->prod_id_reg)
> > +		return 0;
> > +
> > +	ret = adis_read_reg_16(adis, adis->data->prod_id_reg,
> > &prod_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = sscanf(iio_name, "adis%hu\n", &dev_id);
> 
> Hmm. I have a general dislike of pulling part name strings apart to
> get
> IDs.  It tends to break when someone comes along and adds a part with
> new
> branding.  Perhaps just put it in the relevant device part specific
> structures
> directly?
> 

I'll admit that this to orientated to ADI devices and I basically just
took what all the drivers were doing and placed it inside the
library...

So, you mean passing this to each `chip_info` and then passing it to
the library through `adis_data`?
> > +	if (ret != 1)
> > +		return -EINVAL;
> > +
> > +	if (prod_id != dev_id)
> > +		dev_warn(&adis->spi->dev,
> > +			 "Device ID(%u) and product ID(%u) do not
> > match.",
> > +			 dev_id, prod_id);
> > +
> > +	return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(adis_initial_startup);
> > +EXPORT_SYMBOL_GPL(__adis_initial_startup);
> >  
> >  /**
> >   * adis_single_conversion() - Performs a single sample conversion
> > diff --git a/include/linux/iio/imu/adis.h
> > b/include/linux/iio/imu/adis.h
> > index d21a013d1122..c43e7922ab32 100644
> > --- a/include/linux/iio/imu/adis.h
> > +++ b/include/linux/iio/imu/adis.h
> > @@ -41,6 +41,7 @@ struct adis_timeout {
> >   * @glob_cmd_reg: Register address of the GLOB_CMD register
> >   * @msc_ctrl_reg: Register address of the MSC_CTRL register
> >   * @diag_stat_reg: Register address of the DIAG_STAT register
> > + * @prod_id_reg: Register address of the PROD_ID register
> >   * @self_test_reg: Register address to request self test command
> >   * @status_error_msgs: Array of error messgaes
> >   * @status_error_mask:
> > @@ -54,6 +55,7 @@ struct adis_data {
> >  	unsigned int glob_cmd_reg;
> >  	unsigned int msc_ctrl_reg;
> >  	unsigned int diag_stat_reg;
> > +	unsigned int prod_id_reg;
> >  
> >  	unsigned int self_test_mask;
> >  	unsigned int self_test_reg;
> > @@ -299,6 +301,7 @@ static inline int adis_read_reg_32(struct adis
> > *adis, unsigned int reg,
> >  
> >  int adis_enable_irq(struct adis *adis, bool enable);
> >  int __adis_check_status(struct adis *adis);
> > +int __adis_initial_startup(struct adis *adis);
> >  
> >  static inline int adis_check_status(struct adis *adis)
> >  {
> > @@ -311,7 +314,17 @@ static inline int adis_check_status(struct
> > adis *adis)
> >  	return ret;
> >  }
> >  
> > -int adis_initial_startup(struct adis *adis);
> > +/* locked version of __adis_initial_startup() */
> > +static inline int adis_initial_startup(struct adis *adis)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&adis->state_lock);
> > +	ret = __adis_initial_startup(adis);
> > +	mutex_unlock(&adis->state_lock);
> > +
> > +	return ret;
> > +}
> >  
> >  int adis_single_conversion(struct iio_dev *indio_dev,
> >  	const struct iio_chan_spec *chan, unsigned int error_mask,
> 
> 

