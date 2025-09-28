Return-Path: <linux-iio+bounces-24524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D7BA6E90
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 12:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3597A985F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86DC2DC32B;
	Sun, 28 Sep 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb/JdSgg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1202D9787
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053768; cv=none; b=Lj0uWr6NaXVan/3pmKBOhJ1BWv0UM8GGL9+Zis3a8jWsJay5qaos5z/iPISsSZTUH4KUgOPAhfs7cYFZruVE3xb3cuMwMPouq1LlEDYQTq4EagaZARqRh3weleKaier+nq9ZWUd84udoICb4Vi1WVtKqZoMsJRgWYykVy98ccHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053768; c=relaxed/simple;
	bh=78ydDTlSyrjJOkPvGJQwHWhr9uH0sp5/F+TZ7Qdwv7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHUSQ5EDeA8qNFVF2mO10GaUWGAOLd3cfRMAT1Uo0TwHvPg+fvic9+CgCF6BrhmmzbXKx+W4dEgzYNxPw5bhxtXYCus+0m5tAfagMgaKU/GH0azgWrz1cWaz/RI8hXBmbcv7SYzXgHC9aASHpOqx3oYFROAPTN5C4sMB0fLMhX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb/JdSgg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so2794062f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759053765; x=1759658565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q98QgJcf4F+OVtl+HgPaDln5BYWLexWdfH2vz7b7KF4=;
        b=Mb/JdSggfAwngPcmHA2JJtjr1uxvtLqFNHMgA7BzSq8DngnyN3PuRlMnCzwS3lCgxg
         6l/B2CrospWaiaFbrPeArsohpCbVZ0swe6QzEUaMpDk6B58aLtp1cwoOQ4rG3bLaCWxz
         5LmSEpaUf1Lwo9O9ZoQbwPB8HkcM0cAki3EIzC0Xu16vZhEGLUJ2gAL/ZzKnJb2sdwnF
         7FxVHm+z6kG/hB6NH3NRAU1JPS//NjFAmsjLFGaANAqEIFtPEupI4ean4Lsz9cJza8LM
         RJe3J8VanPIdX9BCGbTj6i2NKvNNLlygTALfOXyjE45FmPrm+okydvKEIvqz/0PV2CNb
         o/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759053765; x=1759658565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q98QgJcf4F+OVtl+HgPaDln5BYWLexWdfH2vz7b7KF4=;
        b=N7orjPkB68ePRftnWbCTvjhyCNdgm2njQuHERTMxauNYF9YGraY4Gmo3NDyxH2b4VK
         5FEKFmuZpbnFDbyDlgjvydFsO8+YuAXofCj2M66QdoNSzpVcisS+Ccd9bBawOf3VkoBR
         yQZ1+to6wPHmVVw7mQgcZ7IHFYOQc4u70c3yBmldtcSWbPeWHqujKa3gley8jngDLDU8
         ZoIgv+BWIqgr9MX4Q9nXWFlyoFMp23w6ZsyrqCS1xLA0nEiTkKye1xoH93x3pUz+RoeW
         RBfX67dHewE0uzPL+6AHDqudvIdlchWycFUJy2xu75trWqM91K8uukE3JikB2Az/uSiV
         98GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI6u0kC79fUZk+zFdy5X9dkKqzat/TTu6fcfHXWY0siVf3ZaMYpmixbly40bVuHqGJRS+rLjD/qfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaBkGYmy7X+XXBRr7IeXiOGvOd5VhRbVpVdVC4H/9LWMehx1c
	qAH1c/P8MGg67OUbZoRgMgwgG3/UosY8Rl5w/g517Uxau2N1uRiXyCIy
X-Gm-Gg: ASbGncsVdohRjooy0T/7cBpVLMu8ajOHd+HCra6aNLH637UCH39jagF+BgFXhm7+xWc
	0yt7iBIDyH4P65Vi9+29wwha+JW3gndGxL7y5qdaNkDJgpiEWulYIJJhsRBz1OGMnr5bzgi5p5t
	XNaZQFWvmUTIS5WcWCLhXKHGk77Ka4iF+LHZHXWgNi5H3v7RV1VnAnBpnVTxMh02+WSGDAeHD5D
	Ud1zL9d48qDL3igOpKvvTN2mbCarfMStGa4BfCEZ7BlMOioi11YFJT8sXu4OyzIQyApFwVvCAvA
	QmS0Mf+f1O/1W9k2QhuPsL3SbAWl+MNmJjlXTjjaEmZ8+hQGWzLiiUX0uAZXx/wq3JwsDH2lu8W
	uGvTEjhsZnst25ltBZoY68olojYfO5SbhIUjpSfdeQ4zETSSe7ymeeeKemVgMD15tpTc=
X-Google-Smtp-Source: AGHT+IGNDGGpUUgwE1A4em6qPk3AFyAAijOjsNFgqyp5N5U4tSNnPU///ZgZlhSXAK7uqAHe5yA/hQ==
X-Received: by 2002:a05:6000:26c7:b0:410:9b07:483b with SMTP id ffacd0b85a97d-418057299f8mr4820468f8f.15.1759053764900;
        Sun, 28 Sep 2025 03:02:44 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.212.233.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996c03sm184506585e9.3.2025.09.28.03.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 03:02:44 -0700 (PDT)
Date: Sun, 28 Sep 2025 12:02:32 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org
Cc: conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com, michal.simek@amd.com,
	grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 3/4] iio: mpl3115: add support for DRDY interrupt
Message-ID: <20250928100232.tafcimfsoljdq6nt@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
 <20250926220150.22560-4-apokusinski01@gmail.com>
 <20250927175125.66bcc18c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927175125.66bcc18c@jic23-huawei>

On Sat, Sep 27, 2025 at 05:51:25PM +0100, Jonathan Cameron wrote:
> On Sat, 27 Sep 2025 00:01:49 +0200
> Antoni Pokusinski <apokusinski01@gmail.com> wrote:
> 
> > MPL3115 sensor features a "data ready" interrupt which indicates the
> > presence of new measurements.
> > 
> > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> Various comments inline.  Main ones are more on the guard() usage combined
> with gotos and split out he renames as a precursor patch so only the main
> change occurs in this one.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/pressure/mpl3115.c | 197 ++++++++++++++++++++++++++++++---
> >  1 file changed, 184 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> > index 80af672f65c6..13c8b338a15e 100644
> > --- a/drivers/iio/pressure/mpl3115.c
> > +++ b/drivers/iio/pressure/mpl3115.c
> 
> >  
> >  #define MPL3115_DEVICE_ID 0xc4
> >  
> >  #define MPL3115_STATUS_PRESS_RDY BIT(2)
> >  #define MPL3115_STATUS_TEMP_RDY BIT(1)
> >  
> > -#define MPL3115_CTRL_RESET BIT(2) /* software reset */
> > -#define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
> > -#define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
> > -#define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */
> > +#define MPL3115_INT_SRC_DRDY BIT(7)
> > +
> > +#define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
> > +
> > +#define MPL3115_CTRL1_RESET BIT(2) /* software reset */
> > +#define MPL3115_CTRL1_OST BIT(1) /* initiate measurement */
> > +#define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */
> 
> Precursor patch should make the renames to CTRL1
> That will reduce the noise in this patch.
>
Sure, will add a separate patch in v4 with all the renames.
> > +#define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
> > +
> > +#define MPL3115_CTRL3_IPOL1 BIT(5)
> > +#define MPL3115_CTRL3_IPOL2 BIT(1)
> > +
> > +#define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
> > +
> > +#define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
> > +
> > +#define MPL3115_INT2 BIT(2) /* flag that indicates INT2 in use */
> >  
> >  struct mpl3115_data {
> >  	struct i2c_client *client;
> > +	struct iio_trigger *drdy_trig;
> >  	struct mutex lock;
> >  	u8 ctrl_reg1;
> >  };
> >  
> > +enum mpl3115_irq_type {
> > +	INT2_ACTIVE_LOW  = MPL3115_INT2 | IRQF_TRIGGER_FALLING,
> > +	INT2_ACTIVE_HIGH = MPL3115_INT2 | IRQF_TRIGGER_RISING,
> > +	INT1_ACTIVE_LOW  = (!MPL3115_INT2) | IRQF_TRIGGER_FALLING,
> > +	INT1_ACTIVE_HIGH = (!MPL3115_INT2) | IRQF_TRIGGER_RISING,
> This mixing and matching of IRQF_ definitions with locally defined
> additional flags is fragile because it is more than possible
> a future kernel wide change will change the IRQF_ values.
> 
> So keep them separate.
> 
> > +};
> > +
> >  static int mpl3115_request(struct mpl3115_data *data)
> >  {
> >  	int ret, tries = 15;
> >  
> >  	/* trigger measurement */
> >  	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > -		data->ctrl_reg1 | MPL3115_CTRL_OST);
> > +		data->ctrl_reg1 | MPL3115_CTRL1_OST);
> More renames that shouldn't be in this patch.
> 
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -58,7 +86,7 @@ static int mpl3115_request(struct mpl3115_data *data)
> >  		if (ret < 0)
> >  			return ret;
> >  		/* wait for data ready, i.e. OST cleared */
> > -		if (!(ret & MPL3115_CTRL_OST))
> > +		if (!(ret & MPL3115_CTRL1_OST))
> More renames for the precursor patch.
> 
> >  			break;
> >  		msleep(20);
> >  	}
> > @@ -166,9 +194,11 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
> >  	int ret, pos = 0;
> >  
> >  	scoped_guard(mutex, &data->lock) {
> > -		ret = mpl3115_request(data);
> > -		if (ret < 0)
> > -			goto done;
> > +		if (!(data->ctrl_reg1 & MPL3115_CTRL1_ACTIVE)) {
> > +			ret = mpl3115_request(data);
> > +			if (ret < 0)
> > +				goto done;
> This follows on from comment in earlier patch.
> 
> > +		}
> >
> > +
> > +static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
> > +{
> > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +	u8 ctrl_reg1 = data->ctrl_reg1;
> > +
> > +	if (state)
> > +		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> > +	else
> > +		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> > +
> > +	guard(mutex)(&data->lock);
> As in earlier patch, don't mix guard() or anything from cleanup.h with
> code doing gotos as scope can be very weirdly defined when you do.
> 
> This is actually bug free (I think), but doesn't match the guidance notes in cleanup.h
> 
> Various options.
> 1. Don't use guard here
> 2. Factor out the stuff under the lock.  The helper function has clearly defined
>    separate scope so that can contain the goto reg1_cleanup.h bit.
> 
Ok, in here I'd try to factor this out and have something like:

  guard(mutex)(&data->lock);

  return mpl3115_set_interrupt_state(data, ctrl_reg1);

> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > +					ctrl_reg1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
> > +					state ? MPL3115_CTRL4_INT_EN_DRDY : 0);
> > +	if (ret < 0)
> > +		goto reg1_cleanup;
> > +
> > +	data->ctrl_reg1 = ctrl_reg1;
> > +
> > +	return 0;
> > +
> > +reg1_cleanup:
> > +	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > +				  data->ctrl_reg1);
> > +	return ret;
> > +}
> 
> >  
> > +static int mpl3115_trigger_probe(struct mpl3115_data *data,
> > +				 struct iio_dev *indio_dev)
> > +{
> > +	struct fwnode_handle *fwnode = dev_fwnode(&data->client->dev);
> > +	int ret, irq, irq_type, irq_cfg_flags = 0;
> > +
> > +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> > +	if (irq < 0) {
> > +		irq = fwnode_irq_get_byname(fwnode, "INT2");
> > +		if (irq < 0)
> > +			return 0;
> > +
> > +		irq_cfg_flags |= MPL3115_INT2;
> > +	}
> > +
> > +	irq_type = irq_get_trigger_type(irq);
> > +	if (irq_type != IRQF_TRIGGER_RISING && irq_type != IRQF_TRIGGER_FALLING)
> > +		return -EINVAL;
> > +
> > +	irq_cfg_flags |= irq_type;
> Commented on this before, but mixing flags that are local to this driver
> with those that are global provides not guarantees against future changes
> of the global ones to overlap with your local values.
> 
> So just track these as two separate values rather than combining them.
>

So you mean 2 separate variables, one for INT1/INT2 and one for the
trigger RISING/FALLING, am I right?
This was the approach in v1, but the code for writing the regs CTRL3 and
CTRL5 should be improved, I was thinking something like:

if (irq_pin == MPL3115_IRQ_INT1) {
    write_byte_data(REG5, INT_CFG_DRDY);
    if (irq_type == IRQF_TRIGGER_RISING)
        write_byte_data(REG3, IPOL1);
} else if (irq_type == IRQF_TRIGGER_RISING) {
    write_byte_data(REG3, IPOL2);
}

This is perhaps a bit less readable than the switch(int_cfg_flags) with 4
cases... but IMO it's still quite ok and it's less verbose since we do not
duplicate the write_byte_data(REG5, INT_CFG_DRDY).

> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_PT_DATA_CFG,
> > +					MPL3115_PT_DATA_EVENT_ALL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	switch (irq_cfg_flags) {
> > +	case INT2_ACTIVE_HIGH:
> > +		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3,
> > +						MPL3115_CTRL3_IPOL2);
> > +		if (ret)
> > +			return ret;
> > +
> > +		break;
> > +	case INT2_ACTIVE_LOW:
> > +		break;
> > +	case INT1_ACTIVE_HIGH:
> > +		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG5,
> > +						MPL3115_CTRL5_INT_CFG_DRDY);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3,
> > +						MPL3115_CTRL3_IPOL1);
> > +		if (ret)
> > +			return ret;
> > +
> > +		break;
> > +	case INT1_ACTIVE_LOW:
> > +		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG5,
> > +						MPL3115_CTRL5_INT_CFG_DRDY);
> > +		if (ret)
> > +			return ret;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	data->drdy_trig = devm_iio_trigger_alloc(&data->client->dev,
> > +						 "%s-dev%d",
> > +						 indio_dev->name,
> > +						 iio_device_id(indio_dev));
> > +	if (!data->drdy_trig)
> > +		return -ENOMEM;
> > +
> > +	data->drdy_trig->ops = &mpl3115_trigger_ops;
> > +	iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> > +	ret = devm_iio_trigger_register(&data->client->dev, data->drdy_trig);
> 
> Whilst unlikely the race matters. It is this call that creates the infrastructure
> that might allow the interrupt generation to be triggered via userspace controls.
> So the handler should probably be in place firsts.  I.e. do the devm_request_threaded_irq
> before this.
>
Will fix in v4
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->trig = iio_trigger_get(data->drdy_trig);
> > +
> > +	return devm_request_threaded_irq(&data->client->dev, irq,
> > +					 NULL,
> > +					 mpl3115_interrupt_handler,
> > +					 IRQF_ONESHOT,
> > +					 "mpl3115_irq",
> > +					 indio_dev);
> 
> wrap closer to 80 chars by combining some of those lines.
>
Will fix in v4
> > +}
> > +
> >  static int mpl3115_probe(struct i2c_client *client)
> >  {
> >  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> > @@ -258,15 +425,19 @@ static int mpl3115_probe(struct i2c_client *client)
> >  
> >  	/* software reset, I2C transfer is aborted (fails) */
> >  	i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
> > -		MPL3115_CTRL_RESET);
> > +		MPL3115_CTRL1_RESET);
> >  	msleep(50);
> >  
> > -	data->ctrl_reg1 = MPL3115_CTRL_OS_258MS;
> > +	data->ctrl_reg1 = MPL3115_CTRL1_OS_258MS;
> As elsewhere.  Do the rename as a precursor patch so that we reduce
> the noise around the real changes in here and make that bit easier to review.
> 
> >  	ret = i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
> >  		data->ctrl_reg1);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	ret = mpl3115_trigger_probe(data, indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> >  		mpl3115_trigger_handler, NULL);
> >  	if (ret < 0)
> > @@ -285,7 +456,7 @@ static int mpl3115_probe(struct i2c_client *client)
> >  static int mpl3115_standby(struct mpl3115_data *data)
> >  {
> >  	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > -		data->ctrl_reg1 & ~MPL3115_CTRL_ACTIVE);
> > +		data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
> As above. This isn't part of the main change here so should have been in a separate
> precursor patch
> 
> >  }
> >  
> >  static void mpl3115_remove(struct i2c_client *client)
> 
Kind regards,
Antoni


