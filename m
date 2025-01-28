Return-Path: <linux-iio+bounces-14676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C803A20C3A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 15:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520C418887D3
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 14:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB071A9B3E;
	Tue, 28 Jan 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZLbxRsQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4761B1F941;
	Tue, 28 Jan 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738075600; cv=none; b=FLsnug+rNweRgqRkKyTGQLpIcE0MZCiSGNSvU4PtYftpMMuyxhRxyniEchbw7hMw5+J0BpzFtzBYLLbegVLEjHs8riQ2yAeg68QUMeeD4+/QicMtTvTspm1I4KY2mmGbdQQgu1Q4YfSMoqsDOVN980w4xJ8ZxvP4Tl2gr3Uc1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738075600; c=relaxed/simple;
	bh=TMKBSvfn5/GT6OAMP+fNl+t6nD8Y3WtphDtUzfAQvOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUzcg2w5/Z20v0Fm9tXp4WqLV5WdCYkT6LAq079C+n0TQIFb/FZLNTomFZ8Ih7PTQbyZ/5Jn0kgr+xiNCrg4TQHEpQbNHHWIbdKffvYtSvKdeKTpnh44FK4g5N+Cd28pBAkRchIxPD/c/VrVqAYAZstPsyZWbmxqCr0J0x8f+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZLbxRsQ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dfa69e6922so4606616d6.2;
        Tue, 28 Jan 2025 06:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738075597; x=1738680397; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVoDKOM/CFF4Gq1x+pQHYnWEi1/8gsZaBTHdmO+nTx4=;
        b=EZLbxRsQ2noXNQvpcl/JygdHQ4QBCIXoMF4tthgE2M3V573XtVgptA6HbEnXhX3QJP
         PU4y7MAuVLJ7SGMiTOXLIWiK0H24vCd9we91M78BJho6virdAomopLWkM1ledIhYaAC7
         B1EK2U5oaC6plSvf/VXOS2mLQDNAx7Q8WzMgUV+mWfFxwJFAEYOsfM9tFoRUlxIK5+cY
         mLlAAA0Ni90FfIzd7FDYo7YEwY/F4cmrfeQy0hz9yXItGWmWxULY8YZ2F6816hRZRHr8
         2Ii+wBihGB+AsG2y5KaXHyYL4U42U4yGbhS5uDs8rQlPcstwuZ+KSsyZsbO+HXhiAd7O
         cLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738075597; x=1738680397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVoDKOM/CFF4Gq1x+pQHYnWEi1/8gsZaBTHdmO+nTx4=;
        b=AaST9+YB3Fln5PxIOblz0hlvGNhO0tBTunGiDgAbOV7F56jFONgsEdrOIVSLLhVqSB
         g0BJNgiZvFn0+vVUG8MLOPp3gEfBOJvbK1Vlh9QfFKqemyIxFchsoIDzMiU1OaDNW4yn
         Dpi4mOHSLXgC4LYAG4A+JdoxJ3+cZkpKs6ACZl5HlvBmtrzNPmmkj8Jn5fv/TXX/HNJg
         qBmXjrHuPIE8g/omImh5LXX+jPBPDSRpD9yer1QXjMje3ZpuJ4Rlu438WRKA0d2pCirN
         gPz/YQmG6n4XdmFybZjs3T3cOL3KuBe7S/7HTyE57U5LwhtujCGDcqs4DIX80EJ9Y1om
         7lkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXh6p6UopU5oabs4MON1RbvPRO65X6KZ4YIMcsrsrX8rljK6RGMC+21yqwaBVdiAocNEUMbXjFaCdr@vger.kernel.org, AJvYcCXXfnTxOwEaG5P78k/65pVX+nDTN2zJJTlHgeqZ93kDAXlTMb/kYmGK/ZZaNKsWPR1j340VTs4maxhZQGcc@vger.kernel.org, AJvYcCXaVPWrUYIRXmNfaw5IbmnOcX99Q1SuKEAED7mNGVsQN3vJDWShyWPIZaSYQMw83wZ/jnlqQ1F6UkUD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/r4XKEVxPfQNaC0XSrB9WwNxSrGUQsKlFFnADPbWPaogdO+PG
	TkdP9NUIMRrrj64SVWiUgYgpE6dntxLMDOBpacsJHuGcfsIp33zd
X-Gm-Gg: ASbGncs+qruBzTTr84gspqedbQb4fdJ6QVqWIUKx8D9gEP67N8UxlIiKiBOCh7p6CEG
	GrQ5bZUDpuwhmfyzMDwrFPceVV4zQ8w/7gOHhW8wifNyqIz2i6ziaPldDEFZaP2FEfkJzDs6xV5
	e9nhBBU9rTYvY+pNGxrhE7LhUxIzEE99mtUObLpbzqXmW5sKA3wFe8Gd5n9BY8k9XS97B2YUsjp
	zZ6+OAzJ9UEwWLImpXvuGJSap5dRLPKV1rLsxodY6MuxNIH+bfyIR61RplK0DYTLA6uY5hgCZf1
	OFeB9a5kfs00Z/IKzLV3jJ1ZDEkJYsrkEOLB
X-Google-Smtp-Source: AGHT+IEtQp9NOZ/VMk06BIVh8q0gQlYolmtiw5IY5I84NQnRbgvHCA0jvrBL7QgRWEt/xTZfeKlgIQ==
X-Received: by 2002:a05:6214:5197:b0:6c3:5dbd:449c with SMTP id 6a1803df08f44-6e1b2140c0dmr264199256d6.1.1738075596918;
        Tue, 28 Jan 2025 06:46:36 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20525b0ebsm45932836d6.61.2025.01.28.06.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:46:36 -0800 (PST)
Date: Tue, 28 Jan 2025 11:46:31 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 07/16] iio: adc: ad7768-1: convert driver to use regmap
Message-ID: <Z5jtx6QaSMxBXoyk@JSANTO12-L01.ad.analog.com>
Reply-To: 648eedbee0e7702eda10034531de4611597cd9f2.camel@gmail.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <0968f9cfc55c5ac80492a88bbe95fc8ff7208fa5.1737985435.git.Jonathan.Santos@analog.com>
 <9b8204f2-107a-477e-a822-c1649af12d02@baylibre.com>
 <648eedbee0e7702eda10034531de4611597cd9f2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <648eedbee0e7702eda10034531de4611597cd9f2.camel@gmail.com>

On 01/28, Nuno Sá wrote:
> On Mon, 2025-01-27 at 19:29 -0600, David Lechner wrote:
> > On 1/27/25 9:12 AM, Jonathan Santos wrote:
> > > Convert the AD7768-1 driver to use the regmap API for register
> > > access. This change simplifies and standardizes register interactions,
> > > reducing code duplication and improving maintainability.
> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > > v2 Changes:
> > > * New patch in v2.
> > > ---
> > >  drivers/iio/adc/ad7768-1.c | 82 +++++++++++++++++++++++++++-----------
> > >  1 file changed, 58 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > > index 95ba89435652..fb8d6fae5f8a 100644
> > > --- a/drivers/iio/adc/ad7768-1.c
> > > +++ b/drivers/iio/adc/ad7768-1.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/gpio/consumer.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > > +#include <linux/regmap.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/sysfs.h>
> > >  #include <linux/spi/spi.h>
> > > @@ -153,6 +154,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
> > >  
> > >  struct ad7768_state {
> > >  	struct spi_device *spi;
> > > +	struct regmap *regmap;
> > >  	struct regulator *vref;
> > >  	struct mutex lock;
> > >  	struct clk *mclk;
> > > @@ -176,12 +178,17 @@ struct ad7768_state {
> > >  	} data __aligned(IIO_DMA_MINALIGN);
> > >  };
> > >  
> > > -static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
> > > -			       unsigned int len)
> > > +static int ad7768_spi_reg_read(void *context, unsigned int addr,
> > > +			       unsigned int *val)
> > >  {
> > > -	unsigned int shift;
> > > +	struct iio_dev *dev = context;
> > > +	struct ad7768_state *st;
> > > +	unsigned int shift, len;
> > >  	int ret;
> > >  
> > > +	st = iio_priv(dev);
> > 
> > This can be combined with the variable declaration.
> > 
> > > +	/* Regular value size is 1 Byte, but 3 Bytes for ADC data */
> > 
> > Probably not currently needed but COEFF_DATA register is also 3 bytes.
> > 
> > > +	len = (addr == AD7768_REG_ADC_DATA) ? 3 : 1;
> > >  	shift = 32 - (8 * len);
> > >  	st->data.d8[0] = AD7768_RD_FLAG_MSK(addr);
> > >  
> > > @@ -190,13 +197,19 @@ static int ad7768_spi_reg_read(struct ad7768_state
> > > *st, unsigned int addr,
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > -	return (be32_to_cpu(st->data.d32) >> shift);
> > > +	*val = be32_to_cpu(st->data.d32) >> shift;
> > > +
> > > +	return 0;
> > >  }
> > >  
> > > -static int ad7768_spi_reg_write(struct ad7768_state *st,
> > > +static int ad7768_spi_reg_write(void *context,
> > >  				unsigned int addr,
> > >  				unsigned int val)
> > >  {
> > > +	struct iio_dev *dev = context;
> > > +	struct ad7768_state *st;
> > > +
> > > +	st = iio_priv(dev);
> > >  	st->data.d8[0] = AD7768_WR_FLAG_MSK(addr);
> > >  	st->data.d8[1] = val & 0xFF;
> > >  
> > > @@ -206,16 +219,16 @@ static int ad7768_spi_reg_write(struct ad7768_state
> > > *st,
> > >  static int ad7768_set_mode(struct ad7768_state *st,
> > >  			   enum ad7768_conv_mode mode)
> > >  {
> > > -	int regval;
> > > +	int regval, ret;
> > >  
> > > -	regval = ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
> > > -	if (regval < 0)
> > > -		return regval;
> > > +	ret = regmap_read(st->regmap, AD7768_REG_CONVERSION, &regval);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > >  	regval &= ~AD7768_CONV_MODE_MSK;
> > >  	regval |= AD7768_CONV_MODE(mode);
> > >  
> > > -	return ad7768_spi_reg_write(st, AD7768_REG_CONVERSION, regval);
> > > +	return regmap_write(st->regmap, AD7768_REG_CONVERSION, regval);
> > >  }
> > >  
> > >  static int ad7768_scan_direct(struct iio_dev *indio_dev)
> > > @@ -234,9 +247,10 @@ static int ad7768_scan_direct(struct iio_dev
> > > *indio_dev)
> > >  	if (!ret)
> > >  		return -ETIMEDOUT;
> > >  
> > > -	readval = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> > > -	if (readval < 0)
> > > -		return readval;
> > > +	ret = regmap_read(st->regmap, AD7768_REG_ADC_DATA, &readval);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	/*
> > >  	 * Any SPI configuration of the AD7768-1 can only be
> > >  	 * performed in continuous conversion mode.
> > > @@ -258,13 +272,11 @@ static int ad7768_reg_access(struct iio_dev
> > > *indio_dev,
> > >  
> > >  	mutex_lock(&st->lock);
> > >  	if (readval) {
> > > -		ret = ad7768_spi_reg_read(st, reg, 1);
> > > -		if (ret < 0)
> > > +		ret = regmap_read(st->regmap, reg, readval);
> > > +		if (ret)
> > >  			goto err_unlock;
> > 
> > Can drop the if and goto.
> > 
> > > -		*readval = ret;
> > > -		ret = 0;
> > >  	} else {
> > > -		ret = ad7768_spi_reg_write(st, reg, writeval);
> > > +		ret = regmap_write(st->regmap, reg, writeval);
> > >  	}
> > >  err_unlock:
> > >  	mutex_unlock(&st->lock);
> > > @@ -283,7 +295,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
> > >  	else
> > >  		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
> > >  
> > > -	ret = ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER, mode);
> > > +	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > @@ -320,7 +332,7 @@ static int ad7768_set_freq(struct ad7768_state *st,
> > >  	 */
> > >  	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
> > >  		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
> > > -	ret = ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK, pwr_mode);
> > > +	ret = regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, pwr_mode);
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > @@ -447,11 +459,11 @@ static int ad7768_setup(struct ad7768_state *st)
> > >  	 * to 10. When the sequence is detected, the reset occurs.
> > >  	 * See the datasheet, page 70.
> > >  	 */
> > > -	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x3);
> > > +	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x2);
> > > +	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > @@ -509,18 +521,19 @@ static int ad7768_buffer_postenable(struct iio_dev
> > > *indio_dev)
> > >  	 * continuous read mode. Subsequent data reads do not require an
> > >  	 * initial 8-bit write to query the ADC_DATA register.
> > >  	 */
> > > -	return ad7768_spi_reg_write(st, AD7768_REG_INTERFACE_FORMAT, 0x01);
> > > +	return regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
> > >  }
> > >  
> > >  static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
> > >  {
> > >  	struct ad7768_state *st = iio_priv(indio_dev);
> > > +	unsigned int regval;
> > 
> > Intention could be more clear by calling this "unused". Otherwise, it can look
> > like a bug if you don't fully understand what the comment below means.
> > 
> > >  
> > >  	/*
> > >  	 * To exit continuous read mode, perform a single read of the
> > > ADC_DATA
> > >  	 * reg (0x2C), which allows further configuration of the device.
> > >  	 */
> > > -	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> > > +	return regmap_read(st->regmap, AD7768_REG_ADC_DATA, &regval);
> > >  }
> > >  
> > >  static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
> > > @@ -563,6 +576,20 @@ static int ad7768_set_channel_label(struct iio_dev
> > > *indio_dev,
> > >  	return 0;
> > >  }
> > >  
> > > +static const struct regmap_bus ad7768_regmap_bus = {
> > > +	.reg_write = ad7768_spi_reg_write,
> > > +	.reg_read = ad7768_spi_reg_read,
> > > +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> > > +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> > 
> > The bus read function is calling be32_to_cpu(), so we probably want to remove
> > that or change the default here.
> > 
> > > +};
> > > +
> > > +static const struct regmap_config ad7768_regmap_config = {
> > > +	.name = "ad7768-1",
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > 
> > Should this be 24 since the largest registers are 24-bit?
> > 
> > Another option could be to just use a regular spi_*() API for that register
> > instead of regmap_*() and avoid trying to do something that regmap doesn't
> > really handle.
> > 
> > Or we could possibly use regmap_bulk_read(), but that feels a bit hacky too
> > since it isn't actually how that function was intended to be used.
> > 
> 
> Hmm I might be missing something but looking at the register map, It seems we do
> have 8bit registers? We do have values that span multiple registers (3 for the
> 24bit values) and regmap_bulk_read() should actually fit right? I mean, looking
> at the docs:
> 
> "regmap_bulk_read() - Read multiple sequential registers from the device"
>

Isn't regmap_bulk_*() for reading a value spread in sequential registers,
like the offset calibration (registers 0x22, 0x23 and 0x24, 8 bits value
for each reg)? For the ADC data (0x2C) we have a 24 bits value in only one
register, so I beleive this does not apply.

> But I do agree that what we have right now does not make much sense. If we need
> to do
> 
> len = (addr == AD7768_REG_ADC_DATA) ? 3 : 1;
> 
> for supporting regmap, then I have to question using it. Also note that we have
> things like gain and offset that are also 3 bytes which means that our custom
> read would need to become more questionable if we add support for it.
> 

For those cases the regmap_bulk_*() works.

> Jonathan, did you tried to use plain regmap (without the custom bus)? Assuming
> bulk reads work, I'm not seeing an apparent reason for the custom bus... I would
> also suspect that if bulk reads don't work out of the box, providing a regmap
> cache would make it work but relying on implementation details is not a very
> good practice.
> 

Yes, i tried and only works for the register with 8-bits value. David
suggested using regular spi_*() functions for the unsual registers with
24-bits value, such as the ADC data (0x2C). That is the only way of
having the default spi bus interface using regmap. Otherwise we should
drop the regmap. 

> Anyways, I would try would normal regmap and if bulk reads don't work I would
> either:
> 
> 1) Just do three regmap_reads() for 3byte values;
Also does not work.
> 2) Or do what David suggests and use normal spi_*() and forget about regmap.
> 
Either that or using spi_*() only for ADC data and regmap for the rest
of the registers.
> Either way is fine to me. 
> 
> - Nuno Sá
> > 
> 
> 

