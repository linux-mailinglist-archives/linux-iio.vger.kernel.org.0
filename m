Return-Path: <linux-iio+bounces-562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BAA802F8C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 11:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340B11F2118A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0643E1EB37;
	Mon,  4 Dec 2023 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCeo5emh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83041EB2B;
	Mon,  4 Dec 2023 10:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33789C433C7;
	Mon,  4 Dec 2023 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701684327;
	bh=TjbVpp0w/mr0UQlKAwP4FFpH3IWzsJ2Rxf+6614AKw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LCeo5emhYBiylF4hn4+CLQjHs53oxcvqzN6JNW4byYOf8eYp9U98no67sD6bozjNo
	 5bdXsgeseUO4kEa6zkVHbKkI7rsY8QbHAj+xI8C0NPgjGJHi4ARMKiNyZin6vzPSOM
	 cQ/9IjtcLf82phzN1tyCG6IYmyF3rcMa6xpdNUBkzmFInDyF2ovoAwtdQbMS+PPPq+
	 DFvxk2tG5Ll7GaA5StWiAF9g1W1PwG4tlKjfbHgu3PXVS8ZvzYtYpD2CYDRqKcWKt3
	 EcAg9hyL+mAXykW5rC5IHjO8lSHVEU4sJqzb7kQz+H1zH61AyrFd+7KZuzKt3tDqA3
	 ZEFenR3p1m8Dg==
Date: Mon, 4 Dec 2023 10:05:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] iio: light: driver for Lite-On ltr390
Message-ID: <20231204100517.30df720e@jic23-huawei>
In-Reply-To: <f6ced6e9-65d2-4bbc-9792-473465bad547@gmail.com>
References: <20231117074554.700970-1-anshulusr@gmail.com>
	<20231117074554.700970-2-anshulusr@gmail.com>
	<20231125140641.08284929@jic23-huawei>
	<f6ced6e9-65d2-4bbc-9792-473465bad547@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +struct ltr390_data {
> >> +	struct regmap *regmap;
> >> +	struct i2c_client *client;
> >> +	struct mutex lock;  
> > 
> > All locks need a comment explaining the scope of data they protect.
> > Note that regmap and the i2c bus will have their own locks by default
> > so I'm not sure you need one here at all as I'm not seeing read modify write
> > cycles or anything like that (I might be missing one though!)  
> 
> My goal with the mutex was to protect the sysfs though that might be
> unnecessary.

Ok.  So, there is nothing stopping multiple parallel sysfs accesses, but
what you'll actually be protecting is either device or driver state, not
sysfs as such.

> 
> >> +};
> >> +
> >> +static const struct regmap_config ltr390_regmap_config = {
> >> +	.name = LTR390_DEVICE_NAME,
> >> +	.reg_bits = 8,
> >> +	.reg_stride = 1,
> >> +	.val_bits = 8,
> >> +};
> >> +


> >> +static int ltr390_probe(struct i2c_client *client)
> >> +{
> >> +	struct ltr390_data *data;
> >> +	struct iio_dev *indio_dev;
> >> +	int ret, part_number;
> >> +
> >> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	data = iio_priv(indio_dev);
> >> +
> >> +	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
> >> +	if (IS_ERR(data->regmap))
> >> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),  
> > There are quite a few &client->dev in here. I'd introduce
> > struct device *dev = &client->dev;
> > as a local variable then use that to shorten all those lines a little.
> >   
> >> +				     "regmap initialization failed\n");
> >> +
> >> +	data->client = client;
> >> +	i2c_set_clientdata(client, indio_dev);  
> > 
> > Why set this? I don' think you are using it.
> >   
> 
> It seems to be necessary for regmap to work properly, I tested without
> it and I get an EREMOTEIO(121) when reading the part id.

That's weird given regmap will have no understanding of an iio_dev.

If you can do some more debugging on where that error is coming from
in regmap that would be great.

I suspect it's coming from down in the bus master which should not
be touching this at all.  What is the i2c master in this case?

Jonathan


> 
> >> [..]  
> 
> Thanks for the review,
> Best regards,
> Anshul


