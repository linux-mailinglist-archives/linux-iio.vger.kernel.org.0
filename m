Return-Path: <linux-iio+bounces-22122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11292B146D9
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 05:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EDF3BD9FC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 03:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84221D3DC;
	Tue, 29 Jul 2025 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJbBhlPe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E1286A9;
	Tue, 29 Jul 2025 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753759664; cv=none; b=Q2SzjOxecLSDpVSiJts8kq/46it2Qjg5beVekcQWSvhIp4B0CO9IRW+xNy9LYHgD7Z6r7FBnYlvu0if31NDXuZ+VbdaOFGqp+v9wj+2fhVj4QZzAiNPQNqW1YeIPfnQw8u73NZYAeNlk/SVZz6hTSMV2fw+NYo31xAUW4msDIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753759664; c=relaxed/simple;
	bh=ma6mrIr7hYesVEnM2BrZlz6dHOEYkb5jtF8bhuITlNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4zHpLE0pDo/OpGhZnHdJCakUac5b9oBXjimXudwwEdwtC3/OChRvth0vOeBqj6fr3NUm7TH7BAy1TfIjiLP4nLa/yeUanB3teMU6BBC/G5aOgUDkBkqUNopRAD48hL4oc3P3VlZgiN4y9HavRSKONZOXL6MXYKnTjzEkat1kv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJbBhlPe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b27c1481bso3454760b3a.2;
        Mon, 28 Jul 2025 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753759662; x=1754364462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9RLwbjRlWBTlLAuayRgnH4uKjHckhuIXgvBO5QNJ9qg=;
        b=LJbBhlPe6F2XBrk9gM4t7Ak0PBtB337ytrR+3/4W7+EMKwtrNcqLGaXhVfjsgn7OCM
         3eMFAtIt3c2N1LKkaGXSQnqc0PBUem1nsaxWIaSPtzRtw//o7SUlWGBnitg+1T9IHr5p
         XxP/SIaklKGP8nQMVAx508vexsS7YWzrBOkHY89zDDSzwum+ZhO3rqnEKOx9oxfkEYYQ
         1vuXnlDQ2UTSKNQNUMEDooaGEo2Zk1r6nmuBYHFGS/kezTrouVkn/XVXyYtcG1QDN2pb
         4h8e9GLFlQ9HYBtisgSP/PmNBeNojXinpdu64Dog5O5jQ0S/mLXAEbHQaVN827Dr9HLT
         JQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753759662; x=1754364462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RLwbjRlWBTlLAuayRgnH4uKjHckhuIXgvBO5QNJ9qg=;
        b=sKQBRVEakkpNGW8DU4J2bANtxE8+Ez0CpzGEca0dKmEsr+ced43YvWqQG2WPqJQMFX
         dPXYkBvHYNGeQoQoB5d1A9ZSskVb3fTgsmaQJeS2CidGVB76Qd8WBd2kowhwEgRyGTFb
         FeAHl1e9/NgPBN6pFGeh2lCGjt1ggqkznx0p1KWISATriIGsSg75oR4WinDLrp1HiDva
         oMa1hohbh/CZ4ZpbRgUgtGBRVLkXtuWymFfqJWmgH1PSjN2frHrqWLfNBGZBBgylFlcr
         idtog5WT9tnXYEPlb+y1yL0s3ACEfJGS1CIjCbLvuaefVfkS7x10Zj3xL/tWk4afYNRL
         NX9w==
X-Forwarded-Encrypted: i=1; AJvYcCU4B+MCGdp6vOgUXBGKu+Nj2YWPYGaKMFBE40d7M6CauPiBkp6ZZNtJs5E+wOj9oFlbEnsTjLQBneWhHMdC@vger.kernel.org, AJvYcCUmZseU74dlFutlpKKkC631iV/FJbaO0BcMOxqMj0qijnkM0smyF3QgL9UDcef4GHkbeZiT6rvAmnFp@vger.kernel.org, AJvYcCVrTGc2TzuD+RiJ6Ll6N0wb4P2tvkJgVAVs+BwQgYYDKhFkD2E3kBZB1dwZSVv1RdkQAoCuO8DZ+Cv1@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOQI9RCydivIxSpTLkVVno1IYifyA1mxDjsLbCY0ERLw47x8X
	+8hFWXLyPvqoyLxH3Fr+YREWC9welMI4KeiIazUB95eK1Duyhz3NE2Vj
X-Gm-Gg: ASbGncta7WVF5q6YeRuTPEzoazmTTZvlxYdGZNw8miuGv70Sdn9LzwuxiKZMZAaPd6p
	a2ImaMYLDfwyFKnNNMxHR2yTs+VBfzzvM87Al5XEbgo3szUHyvoj1Laf0FgUaC0o+J4TUYOgk4c
	vRy0kVsynL4oE7iEkm91w6sbWLGfref5lJCr3Wk3HSHXWC9qpj0xfKQsLVufQ8cwi9/wtAjryQk
	pVE/14uaALZ0D9uy5ov3h0rlKzQM+RCdzPrZafkk4vwGq3EKAaffGnVa7UN5OqQcJNuRHY8eheC
	tue7fjVmMoFpvAr7IzyWefLGwZ8nRNsNpB69otaMLWG/j/yhLdaxm7wHmz2Q0SuESiBWWt4vD5C
	zSVHrEcKUIwJqZA8k+ML5Jg==
X-Google-Smtp-Source: AGHT+IEJP7yCAUgHeBgsjIkbYNm7LAfIpoKjZ23GfzsiIwC6gnNidAXEywMF+aE5WPqG+8Js/j5A+Q==
X-Received: by 2002:a05:6a00:ad1:b0:757:51d:9dd9 with SMTP id d2e1a72fcca58-763345cd930mr17192773b3a.17.1753759661989;
        Mon, 28 Jul 2025 20:27:41 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:9464:4ee2:7e58:1508:18c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c0115csm6708828b3a.30.2025.07.28.20.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 20:27:39 -0700 (PDT)
Date: Tue, 29 Jul 2025 08:57:30 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <aIg_ohWU7QICMbMy@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
 <141967ee-22f4-4b15-a8da-e8cef25828b4@baylibre.com>
 <20250727133852.371111bc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250727133852.371111bc@jic23-huawei>

On Sun, Jul 27, 2025 at 01:38:52PM +0100, Jonathan Cameron wrote:
> On Sat, 26 Jul 2025 15:44:03 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 7/26/25 4:37 AM, Dixit Parmar wrote:
> > > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > > applications includes joysticks, control elements (white goods,
> > > multifunction knops), or electric meters (anti tampering) and any
> > > other application that requires accurate angular measurements at
> > > low power consumptions.
> > > 
> > > The Sensor is configured over I2C, and as part of Sensor measurement
> > > data it provides 3-Axis magnetic fields and temperature core measurement.
> > > 
> > > The driver supports raw value read and buffered input via external trigger
> > > to allow streaming values with the same sensing timestamp.
> > > 
> > > The device can be configured in to different operating modes by optional
> > > device-tree "mode" property. Also, the temperature sensing part requires
> > > raw offset captured at 25°C and that can be specified by "temp-offset"
> > > optional device-tree property.
> > > 
> > > While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
> > > configurations interrupt(INT) is not recommended, unless timing constraints
> > > between I2C data transfers and interrupt pulses are monitored and aligned.
> > > 
> > > The Sensor's I2C register map and mode information is described in product
> > > User Manual[1].
> > > 
> > > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> > > [1] https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf
> > > 
> > > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> 
> > > +static const struct regmap_config tlv493d_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +	.max_register = TLV493D_RD_REG_RES3,
> > > +	.volatile_table = &tlv493d_volatile_regs,
> > > +};
> > > +
> > > +static int tlv493d_probe(struct i2c_client *client)
> > > +{
> > > +	struct device *dev = &client->dev;
> > > +	struct iio_dev *indio_dev;
> > > +	struct tlv493d_data *data;
> > > +	int ret;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	data = iio_priv(indio_dev);
> > > +	data->dev = dev;
> > > +	data->client = client;
> > > +	i2c_set_clientdata(client, indio_dev);  
> > 
> > There is not i2c_get_clientdata(), so I don't think we need this.
> There's a dev_get_drvdata() that pairs with this in suspend and resume.
> 
> I kind of wish the bus specific accessor would go away but there
> is too much history behind them :(
>
Thank you for the confirmation. Will keep it.
> > > +static int tlv493d_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > > +	struct tlv493d_data *data = iio_priv(indio_dev);
> > > +
> > > +	return tlv493d_set_operating_mode(data, TLV493D_OP_MODE_POWERDOWN);
> > > +}
> > > +
> > > +static int tlv493d_runtime_resume(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > > +	struct tlv493d_data *data = iio_priv(indio_dev);
> > > +
> > > +	return tlv493d_set_operating_mode(data, data->mode);
> > > +}
> > > +
> > > +static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops,
> > > +		tlv493d_runtime_suspend, tlv493d_runtime_resume, NULL);
> > > +
> > > +static const struct i2c_device_id tlv493d_id[] = {
> > > +	{ "tlv493d" },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, tlv493d_id);
> > > +
> > > +static const struct of_device_id tlv493d_of_match[] = {
> > > +	{ .compatible = "infineon,tlv493d-a1b6", },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, tlv493d_of_match);
> > > +
> > > +static struct i2c_driver tlv493d_driver = {
> > > +	.driver = {
> > > +		.name = "tlv493d",
> > > +		.of_match_table = tlv493d_of_match,
> > > +		.pm = pm_ptr(&tlv493d_pm_ops),
> > > +	},
> > > +	.probe = tlv493d_probe,
> > > +	.id_table = tlv493d_id,
> > > +};
> > > +
> > > +module_i2c_driver(tlv493d_driver);
> > > +
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_DESCRIPTION("Infineon TLV493D Low-Power 3D Magnetic Sensor");
> > > +MODULE_AUTHOR("Dixit Parmar <dixitparmar19@gmail.com>");
> > >   
> > 
> 

