Return-Path: <linux-iio+bounces-5306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E3D8CF252
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 02:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0FC281685
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC4C652;
	Sun, 26 May 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZI9ZL8F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2C7E2;
	Sun, 26 May 2024 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716683393; cv=none; b=rFgqrbBHYULsSJ/pmdQkICyVbK2q16wyb3nQ6Mlh5HtyA21aO4h7/FVyGeGaIrQZJGqihi8hKG3BAqqLjMpqMGS28MYZPmPLDmemYMCrNqlzPGLdVkeAbacTaJR6VNrEAVeoLPiv19tA0SpliSzJm3eew2WjzQZpdQkPjFk+b3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716683393; c=relaxed/simple;
	bh=q1Jhkpl3iDvcAU4fBElGK4J5v4FGJ5LX4ANgAjn4C8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9IujbuHMxFuZ+SOo6UP0jVq9ZXoF4AyR6VUAan/ZOBOfc+uWFWX9yikie+IQK9RIX+zw8RkGkZF7U4+lVnImHgxFVCP8HPbM4YSfmGK+VVgcCXGIzl9Dn5Q+XCjTJB5JOhJy1BaD/qxjwgVUdtBE+QwG683Z0QkvPGJ6iIWg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZI9ZL8F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f8e98784b3so1650169b3a.1;
        Sat, 25 May 2024 17:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716683391; x=1717288191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+5YmaJeNF7VkilJwtRMH480JqWzFXOSu6W99rW8D4c=;
        b=LZI9ZL8F1zQeZDG7U7FEoFNNwOaRSPSeAbAyuwnZ87rO/VL96wxCQo0tilo1+nw5jV
         n1uZlQS1DxPy7HE2jQEb8GO4Ige+nsly5tAc1edEVaQCF3wotKxrafVfeeqz1JpncS7w
         OCOPiYH7iY6FiONpVDgd2TyXML6iQHWitzjIMC339hqiyS1wgnTXlWG3RlDH1EG5kWw6
         nT436AoTVec2b3NmRkA5Z8DX+OfgS5jRe21/Bh4b4qnZzz9NsMbP/WwkbTHnoybiF4AN
         GQmQzs0iiGTYLIEYiNvJvmkq6uS+gDJVbJN4584+3dQf/SaT3vswtd409u9VRZFeVQuW
         5+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716683391; x=1717288191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+5YmaJeNF7VkilJwtRMH480JqWzFXOSu6W99rW8D4c=;
        b=uOfxhNuMynR/3FVtfQ1T0nXTS79aWGANwhaXglcBmkvwwsjbro8j0uHQWs3zPhsd3s
         Jzam7vxWghLumjH761nVu0U5gJCApKP+N2tp1lWzsiFWo5+mjGoE9M4qTqIros0GB+MR
         TjWEwXGrDBxBFSN23vTJAAGiehTODOvUhKc9+4ChdK06iC+NswqCzuf/2Xy/G7/aw3wd
         70RaeUZd2m4gXCKjQPYaxDJ1yuVxtM1Rkk+I9IAKZc98FFsLTb/wMnyBpoZtbcnJAeqU
         9/eAc4okouzBMu0oXMvJPbRl4wzxlheZwqAeibscGFOTrKHMiesd5ivoVCVs1E3KBwLZ
         peZA==
X-Forwarded-Encrypted: i=1; AJvYcCWreRrynOfujJnVlngSeXHQUv2C9fAIP1YBkgDuoZBh+410fjEcaKXa7rITacDBB4b8Ukt+nG2w6nkbX2llYZ5v0RWUucuCangSSenp5ZbqFo6xI+XEyhL1pHBKF5LrE/cdzXxO1LAeNr0Zauj6vezfdcvb5w0atJ+thT7Ht74A3Hv9MA==
X-Gm-Message-State: AOJu0YzId354hvj/lL4KE7YTqvWWOyuB/qDmUrvGLKPf16DHLt/lNEFb
	WCzvD+kKE0mFkamHnRS9Sk5WBNUs8XiOHuASMZ04ItdEt++mzP23
X-Google-Smtp-Source: AGHT+IGUZjdlXPa7clpLDcvEVhq+KdFx2TGsH1Y7xC6ULI6j5cpmdRyve+7RmvGBNhWtnAjJ18gVIw==
X-Received: by 2002:a05:6a00:2917:b0:6f8:c1b6:d06a with SMTP id d2e1a72fcca58-6f8f3d84ba1mr6078678b3a.29.1716683390933;
        Sat, 25 May 2024 17:29:50 -0700 (PDT)
Received: from archlinux ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822073f067sm3410868a12.5.2024.05.25.17.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 17:29:50 -0700 (PDT)
Date: Sat, 25 May 2024 21:29:42 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lars@metafoo.de, christophe.jaillet@wanadoo.fr, gerald.loacker@wolfvision.net, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: chemical: add driver for ENS160 sensor
Message-ID: <wsaoofbe3gvwyejkhkqv3xx4q36a6wupn2yr7ntyklzwxovxhs@s6s2fcy5yebg>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
 <20240512210444.30824-4-gustavograzs@gmail.com>
 <20240519150151.291a21dc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519150151.291a21dc@jic23-huawei>

Hi Jonathan,

Thank you for your review. I've got a few questions inline.

On Sun, May 19, 2024 at 03:01:51PM GMT, Jonathan Cameron wrote:
> On Sun, 12 May 2024 18:04:39 -0300
> Gustavo Silva <gustavograzs@gmail.com> wrote:
> 
> > ScioSense ENS160 is a digital metal oxide multi-gas sensor, designed
> > for indoor air quality monitoring. The driver supports readings of
> > CO2 and VOC, and can be accessed via both SPI and I2C.
> > 
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> 
> > +
> > +static int ens160_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	struct ens160_data *data = iio_priv(indio_dev);
> > +	__le16 buf;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = regmap_bulk_read(data->regmap, chan->address,
> > +					&buf, sizeof(buf));
> 
> As below, should use a DMA safe buffer.
> 
> > +static int ens160_chip_init(struct ens160_data *data)
> > +{
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	u8 fw_version[3];
> > +	__le16 part_id;
> > +	unsigned int status;
> > +	int ret;
> > +
> > +	ret = ens160_set_mode(data, ENS160_REG_MODE_RESET);
> > +	if (ret)
> > +		return ret;
> 
> No docs that I can see on what this means for access to registers etc.
> Good to add a comment if you have info on this.
> 
Performing a reset at this point isn't strictly necessary. When we reach
this point the chip should be in idle state because:

a) it was just powered on

b) the driver had been previously removed

This is documented in the state diagram on page 24 of the datasheet.

I'll remove this reset.

> > +
> > +	ret = regmap_bulk_read(data->regmap, ENS160_REG_PART_ID, &part_id,
> > +			       sizeof(part_id));
> 
> Ah. So this is a fun corner case.  Currently regmap makes not guarantees
> to always bounce buffer things (though last time I checked it actually did
> do so - there are optimisations that may make sense where it will again
> not do so).  So given we have an SPI bus involved, we should ensure that
> only DMA safe buffers are used. These need to ensure that no other data
> that might be changed concurrently with DMA is in the same IIO_DMA_MINALIGN
> of aligned data (traditionally a cacheline but it gets more complex in some
> systems and is less in others).  Upshot is that if you are are doing
> bulk accesses you need to use a buffer that is either on the heap (kzalloc etc)
> or carefully placed at the end of the iio_priv() structure marked
> __align(IIO_DMA_MINALIGN). Lots of examples of that in tree.
> If you are curious, wolfram did a good talk on the i2c equivalent of this
> a few years back. 
> https://www.youtube.com/watch?v=JDwaMClvV-s I think.
>
Interesting. Thank you for the detailed info.

> > +	if (ret)
> > +		return ret;
> > +
> > +	if (le16_to_cpu(part_id) != ENS160_PART_ID)
> > +		return -ENODEV;
> > +
> > +	ret = ens160_set_mode(data, ENS160_REG_MODE_IDLE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> > +			   ENS160_REG_COMMAND_CLRGPR);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> > +			   ENS160_REG_COMMAND_GET_APPVER);
> > +	if (ret)
> > +		return ret;
> > +
> > +	msleep(ENS160_BOOTING_TIME_MS);
> 
> Why here?  Not obviously associated with a boot command?
> A comment might make this easier to follow.  I 'think' it is
> because this next read is the first time it matters. If so that
> isn't obvious.  Also, there is an existing sleep in the mode set,
> so I'm not sure why we need another one.
>
The usage of booting time is not documented in the datasheet. From
ScioSense's arduino driver the booting time is necessary after setting
the operation mode. I performed some tests that confirm this.

In this case in particular it is not necessary. Maybe I forgot to remove
it after some testing.
> > +
> > +	ret = regmap_bulk_read(data->regmap, ENS160_REG_GPR_READ4,
> > +			       fw_version, sizeof(fw_version));
> 
Does this bulk read also need to be made DMA safe? I'm guessing in this
case it would be best to devm_kzalloc() a buffer of three bytes?

> The first datasheet that google provided me has this 
> GPR_READ0/GPR_READ1 and only 2 bytes. I hope they have maintained backwards
> compatibility with that earlier doc!
> 
> When you do a separate DT binding in v2, make sure to include a link
> to the datasheet you are using.  Also use a Datasheet: tag
> in this patch to make it easy to find that.
> I dug a little deeper and found the one on sciosense own website
> - ah, you do have it in the comments.  Add to the commit message
> and DT binding as well.
> 
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	msleep(ENS160_BOOTING_TIME_MS);
> Why again?
Again, not needed. I'll remove it.

> > +	data = iio_priv(indio_dev);
> > +	dev_set_drvdata(dev, indio_dev);
> 
> After you've moved to devm_add_action_or_reset() for the unwind of
> ens160_chip_init() you probably don't need to set the drvdata.
> 
I don't get it. Could you please elaborate on why it isn't needed to
set drvdata after the change?

> > +	data->regmap = regmap;
> > +
> > +	indio_dev->name = name;
> > +	indio_dev->info = &ens160_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = ens160_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
> > +
> > +	ret = ens160_chip_init(data);
> > +	if (ret) {
> > +		dev_err_probe(dev, ret, "chip initialization failed\n");
> > +		return ret;
> 		return dev_err_probe();
> 
> > +	}
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +EXPORT_SYMBOL_NS(ens160_core_probe, IIO_ENS160);
> > +
> > +void ens160_core_remove(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct ens160_data *data = iio_priv(indio_dev);
> > +
> > +	ens160_set_mode(data, ENS160_REG_MODE_IDLE);
> 
> This looks to be mixing devm and manual cleanup.
> My guess is this is the unwind for code in ens160_chip_init()
> If so that unwind should definitely happen after we unregister
> the userspace intefaces in the unwind of devm_iio_device_register().
> Currently it happens before this.
> 
> This is an even stronger reason to use devm_add_action_or_reset()
> for this than tidying up as mentioned below (note I tend to
> review backwards through patches so my comments may make more
> sense read that way around).
>
The intention was to transition the chip into idle mode upon driver
removal, ensuring the sensor ceased data readings.
I'll use devm_add_action_or_reset() as suggested.


