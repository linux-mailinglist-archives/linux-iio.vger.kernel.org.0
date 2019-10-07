Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09DCEE42
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 23:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfJGVRD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 17:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbfJGVRD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 17:17:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0966A20867;
        Mon,  7 Oct 2019 21:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570483021;
        bh=7nj9uQY6WqAuYiCgaynFxhnaYKExae7ZbQ7U1gc709g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NakiZhnu9dkcHeFbYC0TI933n5v7qzbrkt+BAZqMDFFIXxamIrH+o8rKz8jKqmMGu
         5Z9kzlmzp1UEU0j3iPgmfFpJiVYXLH76pVgV/Up7L+bPkoPKOyCinpNfJaOGPiENmk
         zWk7rCfuJsGe6vw//JMtnGexU/CCLbO1RlHuKyWA=
Date:   Mon, 7 Oct 2019 22:16:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] iio: imu: adis: add unlocked read/write function
 versions
Message-ID: <20191007221649.4fb1ee25@archlinux>
In-Reply-To: <20191006101201.051f9249@archlinux>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-3-alexandru.ardelean@analog.com>
        <20191006101201.051f9249@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 6 Oct 2019 10:12:01 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 26 Sep 2019 14:18:04 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > This will allow more flexible control to group reads & writes into a single
> > lock (particularly the state_lock).
> > 
> > The end-goal is to remove the indio_dev->mlock usage, and the simplest fix
> > would have been to just add another lock, which would not be a good idea on
> > the long-run.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> Applied to the togreg branch of iio.git and pushed out as testing etc.
> 
> Jonathan
> 
0-day found a potential issue (kind of) in the read functions.

> > ---
> >  drivers/iio/imu/adis.c       |  34 +++++------
> >  include/linux/iio/imu/adis.h | 114 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 128 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> > index 3c2d896e3a96..4f3be011c898 100644
> > --- a/drivers/iio/imu/adis.c
> > +++ b/drivers/iio/imu/adis.c
> > @@ -26,7 +26,14 @@
> >  #define ADIS_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> >  #define ADIS_GLOB_CMD_SW_RESET		BIT(7)
> >  
> > -int adis_write_reg(struct adis *adis, unsigned int reg,
> > +/**
> > + * __adis_write_reg() - write N bytes to register (unlocked version)
> > + * @adis: The adis device
> > + * @reg: The address of the lower of the two registers
> > + * @value: The value to write to device (up to 4 bytes)
> > + * @size: The size of the @value (in bytes)
> > + */
> > +int __adis_write_reg(struct adis *adis, unsigned int reg,
> >  	unsigned int value, unsigned int size)
> >  {
> >  	unsigned int page = reg / ADIS_PAGE_SIZE;
> > @@ -70,8 +77,6 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
> >  		},
> >  	};
> >  
> > -	mutex_lock(&adis->state_lock);
> > -
> >  	spi_message_init(&msg);
> >  
> >  	if (adis->current_page != page) {
> > @@ -96,8 +101,7 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
> >  		adis->tx[3] = value & 0xff;
> >  		break;
> >  	default:
> > -		ret = -EINVAL;
> > -		goto out_unlock;
> > +		return -EINVAL;
> >  	}
> >  
> >  	xfers[size].cs_change = 0;
> > @@ -113,20 +117,18 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
> >  		adis->current_page = page;
> >  	}
> >  
> > -out_unlock:
> > -	mutex_unlock(&adis->state_lock);
> > -
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(adis_write_reg);
> > +EXPORT_SYMBOL_GPL(__adis_write_reg);
> >  
> >  /**
> > - * adis_read_reg() - read 2 bytes from a 16-bit register
> > + * __adis_read_reg() - read N bytes from register (unlocked version)
> >   * @adis: The adis device
> >   * @reg: The address of the lower of the two registers
> >   * @val: The value read back from the device
> > + * @size: The size of the @val buffer
> >   */
> > -int adis_read_reg(struct adis *adis, unsigned int reg,
> > +int __adis_read_reg(struct adis *adis, unsigned int reg,
> >  	unsigned int *val, unsigned int size)
> >  {
> >  	unsigned int page = reg / ADIS_PAGE_SIZE;
> > @@ -188,15 +190,14 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
> >  		spi_message_add_tail(&xfers[3], &msg);
> >  		break;
> >  	default:
> > -		ret = -EINVAL;
> > -		goto out_unlock;
> > +		return -EINVAL;
> >  	}
> >  
> >  	ret = spi_sync(adis->spi, &msg);
> >  	if (ret) {
> >  		dev_err(&adis->spi->dev, "Failed to read register 0x%02X: %d\n",
> >  				reg, ret);
> > -		goto out_unlock;
> > +		return ret;
> >  	} else {
> >  		adis->current_page = page;
> >  	}
> > @@ -210,12 +211,9 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
> >  		break;
> >  	}
> >  
> > -out_unlock:
> > -	mutex_unlock(&adis->state_lock);
> > -
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(adis_read_reg);
> > +EXPORT_SYMBOL_GPL(__adis_read_reg);
> >  
> >  #ifdef CONFIG_DEBUG_FS
> >  
> > diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> > index 3ed5eceaac2d..3a028c40e04e 100644
> > --- a/include/linux/iio/imu/adis.h
> > +++ b/include/linux/iio/imu/adis.h
> > @@ -75,11 +75,121 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
> >  	struct spi_device *spi, const struct adis_data *data);
> >  int adis_reset(struct adis *adis);
> >  
> > -int adis_write_reg(struct adis *adis, unsigned int reg,
> > +int __adis_write_reg(struct adis *adis, unsigned int reg,
> >  	unsigned int val, unsigned int size);
> > -int adis_read_reg(struct adis *adis, unsigned int reg,
> > +int __adis_read_reg(struct adis *adis, unsigned int reg,
> >  	unsigned int *val, unsigned int size);
> >  
> > +/**
> > + * __adis_write_reg_8() - Write single byte to a register (unlocked version)
> > + * @adis: The adis device
> > + * @reg: The address of the register to be written
> > + * @value: The value to write
> > + */
> > +static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
> > +	uint8_t val)
> > +{
> > +	return __adis_write_reg(adis, reg, val, 1);
> > +}
> > +
> > +/**
> > + * __adis_write_reg_16() - Write 2 bytes to a pair of registers (unlocked version)
> > + * @adis: The adis device
> > + * @reg: The address of the lower of the two registers
> > + * @value: Value to be written
> > + */
> > +static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
> > +	uint16_t val)
> > +{
> > +	return __adis_write_reg(adis, reg, val, 2);
> > +}
> > +
> > +/**
> > + * __adis_write_reg_32() - write 4 bytes to four registers (unlocked version)
> > + * @adis: The adis device
> > + * @reg: The address of the lower of the four register
> > + * @value: Value to be written
> > + */
> > +static inline int __adis_write_reg_32(struct adis *adis, unsigned int reg,
> > +	uint32_t val)
> > +{
> > +	return __adis_write_reg(adis, reg, val, 4);
> > +}
> > +
> > +/**
> > + * __adis_read_reg_16() - read 2 bytes from a 16-bit register (unlocked version)
> > + * @adis: The adis device
> > + * @reg: The address of the lower of the two registers
> > + * @val: The value read back from the device
> > + */
> > +static inline int __adis_read_reg_16(struct adis *adis, unsigned int reg,
> > +	uint16_t *val)
> > +{
> > +	unsigned int tmp;
> > +	int ret;
> > +
> > +	ret = __adis_read_reg(adis, reg, &tmp, 2);
Zero day isn't happy that this can use tmp without it actually being set in the
__adis_read_reg.

I've added
	if (ret)
		return ret;
> > +	*val = tmp;
> > +
> > +	return ret;
and changed this to return 0;

Same in the 32bit case below.

Hmm. There are quite a few sparse warnings in the adis16400 if anyone fancies
cleaning them up ;)

Thanks,

Jonathan

> > +}
> > +
> > +/**
> > + * __adis_read_reg_32() - read 4 bytes from a 32-bit register (unlocked version)
> > + * @adis: The adis device
> > + * @reg: The address of the lower of the two registers
> > + * @val: The value read back from the device
> > + */
> > +static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
> > +	uint32_t *val)
> > +{
> > +	unsigned int tmp;
> > +	int ret;
> > +
> > +	ret = __adis_read_reg(adis, reg, &tmp, 4);
> > +	*val = tmp;
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * adis_write_reg() - write N bytes to register
> > + * @adis: The adis device
> > + * @reg: The address of the lower of the two registers
> > + * @value: The value to write to device (up to 4 bytes)
> > + * @size: The size of the @value (in bytes)
> > + */
> > +static inline int adis_write_reg(struct adis *adis, unsigned int reg,
> > +	unsigned int val, unsigned int size)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&adis->state_lock);
> > +	ret = __adis_write_reg(adis, reg, val, size);
> > +	mutex_unlock(&adis->state_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * adis_read_reg() - read N bytes from register
> > + * @adis: The adis device
> > + * @reg: The address of the lower of the two registers
> > + * @val: The value read back from the device
> > + * @size: The size of the @val buffer
> > + */
> > +static int adis_read_reg(struct adis *adis, unsigned int reg,
> > +	unsigned int *val, unsigned int size)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&adis->state_lock);
> > +	ret = __adis_read_reg(adis, reg, val, size);
> > +	mutex_unlock(&adis->state_lock);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * adis_write_reg_8() - Write single byte to a register
> >   * @adis: The adis device  
> 

