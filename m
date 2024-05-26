Return-Path: <linux-iio+bounces-5310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1568CF436
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 14:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C949EB211AC
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AF1DDB2;
	Sun, 26 May 2024 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVmtEots"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D1B676;
	Sun, 26 May 2024 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716726072; cv=none; b=C+qUbz1bXW8uieSk6IKULsHYonhcppWHBweMmOb21rJ0eK0F7jbtH+zQnjJYfIssEDn1iniX6IRT8gJEn+J+fapNKd4UGQBHA2dQRiw03AQOm5Z9z++/XYpOiw1lYfTLf6XsL3SHi4OnEEd9pOx/aWOLdkQggyyLl9ASgeE8y6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716726072; c=relaxed/simple;
	bh=f1kHWS542LSTMfdmWktNiOaMXzRkAj1bsw6jPECvGyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnfzQt+lRwHR2WW9r7pZO7evC0xzpPIC6h1FD9Hesxf7WJy91vQVmig9naH/ouAhIPJqHTvhk4oisRwTAfEFwqge6l1iX9bOgRv2u1TWiveTQ5Y4zBJc0AcnPKGCGHgl/PaQII6MoEe9EGQc6u6exKcK8Z8LVG0RbLjY+6A7a/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVmtEots; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91547C2BD10;
	Sun, 26 May 2024 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716726071;
	bh=f1kHWS542LSTMfdmWktNiOaMXzRkAj1bsw6jPECvGyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cVmtEotsGjCe7Knku67qpVLkurVHkdp0+UAV1/yAg1a3bt+8qw/CwKEFEFqfD/wX2
	 qRt4e7M+tu/Kd97zmNp1iZiCU86Z02895CsbAFlm4qLvI+6pLGYTfcgaz0lPaOUYTx
	 EAmaNKrdlQi0H/JLJDLxz19BFzhxCjST1QY9zVH0qQ4Cre++oI5ULhHErkTQg3yDYK
	 2n+gTJFxut/c/Z1Tjk4x23eSvCS51zZOgTIQmpIi36qFT0Cz2cVKf/acACOMloJgGg
	 kknxXzUQPxFnaxUmEvNAbL0rYq26bukoAYX2bUrPgE3T4FbvxYvhmWdJsCJWYhPxwl
	 3MhZp6lORJIVw==
Date: Sun, 26 May 2024 13:20:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, christophe.jaillet@wanadoo.fr,
 gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: chemical: add driver for ENS160 sensor
Message-ID: <20240526131927.1ab92e13@jic23-huawei>
In-Reply-To: <wsaoofbe3gvwyejkhkqv3xx4q36a6wupn2yr7ntyklzwxovxhs@s6s2fcy5yebg>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
	<20240512210444.30824-4-gustavograzs@gmail.com>
	<20240519150151.291a21dc@jic23-huawei>
	<wsaoofbe3gvwyejkhkqv3xx4q36a6wupn2yr7ntyklzwxovxhs@s6s2fcy5yebg>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 May 2024 21:29:42 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for your review. I've got a few questions inline.
> 
> On Sun, May 19, 2024 at 03:01:51PM GMT, Jonathan Cameron wrote:
> > On Sun, 12 May 2024 18:04:39 -0300
> > Gustavo Silva <gustavograzs@gmail.com> wrote:
> >   
> > > ScioSense ENS160 is a digital metal oxide multi-gas sensor, designed
> > > for indoor air quality monitoring. The driver supports readings of
> > > CO2 and VOC, and can be accessed via both SPI and I2C.
> > > 
> > > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>  
> >   
> > > +
> > > +static int ens160_read_raw(struct iio_dev *indio_dev,
> > > +			   struct iio_chan_spec const *chan,
> > > +			   int *val, int *val2, long mask)
> > > +{
> > > +	struct ens160_data *data = iio_priv(indio_dev);
> > > +	__le16 buf;
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		ret = regmap_bulk_read(data->regmap, chan->address,
> > > +					&buf, sizeof(buf));  
> > 
> > As below, should use a DMA safe buffer.
> >   
> > > +static int ens160_chip_init(struct ens160_data *data)
> > > +{
> > > +	struct device *dev = regmap_get_device(data->regmap);
> > > +	u8 fw_version[3];
> > > +	__le16 part_id;
> > > +	unsigned int status;
> > > +	int ret;
> > > +
> > > +	ret = ens160_set_mode(data, ENS160_REG_MODE_RESET);
> > > +	if (ret)
> > > +		return ret;  
> > 
> > No docs that I can see on what this means for access to registers etc.
> > Good to add a comment if you have info on this.
> >   
> Performing a reset at this point isn't strictly necessary. When we reach
> this point the chip should be in idle state because:
> 
> a) it was just powered on

Maybe but we have no way of telling that
> 
> b) the driver had been previously removed

Maybe or maybe not - the device may have just done a soft reboot and switched
operating system. We have no idea what the hardware state is.
As such the reset is a good idea.
> 
> This is documented in the state diagram on page 24 of the datasheet.
> 
> I'll remove this reset.

Better to keep the reset and provide info on what it means wrt to accessing
registers etc if possible. If there is no information then obviously not
much you can add in the way of documentation!

> 
> > > +
> > > +	ret = regmap_bulk_read(data->regmap, ENS160_REG_PART_ID, &part_id,
> > > +			       sizeof(part_id));  
> > 
> > Ah. So this is a fun corner case.  Currently regmap makes not guarantees
> > to always bounce buffer things (though last time I checked it actually did
> > do so - there are optimisations that may make sense where it will again
> > not do so).  So given we have an SPI bus involved, we should ensure that
> > only DMA safe buffers are used. These need to ensure that no other data
> > that might be changed concurrently with DMA is in the same IIO_DMA_MINALIGN
> > of aligned data (traditionally a cacheline but it gets more complex in some
> > systems and is less in others).  Upshot is that if you are are doing
> > bulk accesses you need to use a buffer that is either on the heap (kzalloc etc)
> > or carefully placed at the end of the iio_priv() structure marked
> > __align(IIO_DMA_MINALIGN). Lots of examples of that in tree.
> > If you are curious, wolfram did a good talk on the i2c equivalent of this
> > a few years back. 
> > https://www.youtube.com/watch?v=JDwaMClvV-s I think.
> >  
> Interesting. Thank you for the detailed info.
> 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (le16_to_cpu(part_id) != ENS160_PART_ID)
> > > +		return -ENODEV;
> > > +
> > > +	ret = ens160_set_mode(data, ENS160_REG_MODE_IDLE);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> > > +			   ENS160_REG_COMMAND_CLRGPR);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> > > +			   ENS160_REG_COMMAND_GET_APPVER);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	msleep(ENS160_BOOTING_TIME_MS);  
> > 
> > Why here?  Not obviously associated with a boot command?
> > A comment might make this easier to follow.  I 'think' it is
> > because this next read is the first time it matters. If so that
> > isn't obvious.  Also, there is an existing sleep in the mode set,
> > so I'm not sure why we need another one.
> >  
> The usage of booting time is not documented in the datasheet. From
> ScioSense's arduino driver the booting time is necessary after setting
> the operation mode. I performed some tests that confirm this.
> 
> In this case in particular it is not necessary. Maybe I forgot to remove
> it after some testing.
> > > +
> > > +	ret = regmap_bulk_read(data->regmap, ENS160_REG_GPR_READ4,
> > > +			       fw_version, sizeof(fw_version));  
> >   
> Does this bulk read also need to be made DMA safe? I'm guessing in this
> case it would be best to devm_kzalloc() a buffer of three bytes?
All bulk accesses need dma safe buffers.
I would take the approach many IIO drivers do of not doing another allocation
(which has overheads etc) but instead just add a suitable __aligned(IIO_DMA_MINALIGN)
buffer to the iio_priv structure.  Note you normally only need to do mark
the first one like that as we don't care if various different DMA buffers
are in the same cacheline as the SPI controller should not cause DMA safety
issues with itself.

> 
> > The first datasheet that google provided me has this 
> > GPR_READ0/GPR_READ1 and only 2 bytes. I hope they have maintained backwards
> > compatibility with that earlier doc!
> > 
> > When you do a separate DT binding in v2, make sure to include a link
> > to the datasheet you are using.  Also use a Datasheet: tag
> > in this patch to make it easy to find that.
> > I dug a little deeper and found the one on sciosense own website
> > - ah, you do have it in the comments.  Add to the commit message
> > and DT binding as well.
> > 
> >   
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	msleep(ENS160_BOOTING_TIME_MS);  
> > Why again?  
> Again, not needed. I'll remove it.
> 
> > > +	data = iio_priv(indio_dev);
> > > +	dev_set_drvdata(dev, indio_dev);  
> > 
> > After you've moved to devm_add_action_or_reset() for the unwind of
> > ens160_chip_init() you probably don't need to set the drvdata.
> >   
> I don't get it. Could you please elaborate on why it isn't needed to
> set drvdata after the change?

No other users.  Only the remove() callback calls the matching get_drvdata()
and that function won't exist once you've added device managed callbacks
to handle everything it does.

Jonathan



