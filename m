Return-Path: <linux-iio+bounces-1671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C582D6C5
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 11:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F571282511
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61524101C6;
	Mon, 15 Jan 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyiukfBN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBCF9E5;
	Mon, 15 Jan 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e80046275so804725e9.2;
        Mon, 15 Jan 2024 02:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705313211; x=1705918011; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7jI9wVPYlReOrSFt8sdfuSK2FupjmRCjgJqBjTi+2Q8=;
        b=lyiukfBNj4YATF1b/1Fjf+ujdkenJ5+45xSLvKsICAVgwbbsiAyHSyKIKcy0pvvDIR
         NrQ4zJKqtPJuu82eg38CKotA7kgJdSt/ybC8qhC/TkGytjk6Fh1HW801YyShTjqWlvo2
         cSsDjCF2dI0YwzJwEpLfnub99O2NJ+9BULt07uIHM1ZmohFdLZ6dTjNQccg9Cbqd8MhU
         +zY3ZspSsGk4pJag1soRIkz7tLFXsZKruIB06NktJGAIHtVVoCy0Ox6LSWa6TV1pUsnK
         bZuLbw+AwKMBLiQLfFxOwImLhzpPFICi5RbO5PhGiGTLCO0cLCX4wEuFIVBE1fpLkhht
         a/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313211; x=1705918011;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jI9wVPYlReOrSFt8sdfuSK2FupjmRCjgJqBjTi+2Q8=;
        b=rSxcX+HfreWn77l19cXeBPXNieTFrKB2/ddko/s0r/bgaYwBUXXeiFSThRut1CIjta
         nM8D3cVwpmnmTSntiRdoJeH/GrWY+Yrcwkx2op65TiyXp4XNgbIVejJJyUisengFNO8o
         bjkIsqU0hsfyfjBMBy585swj1g9bQcmIpMCRd6qnduB+hxncXa1fXRvh6p5uib5TFkkw
         Ec/HprwXmlM4U3Rlb6BLdTbh7kQ+vwPBShq9gzjx7VUUYPfGvBnXENt35PoO70Gb4hQF
         VRsY0kEKbWSYEKRfA/fm+ZubbblyM7adT9SZFi3xVoONVZy8pyIcSxBnfRawA2I/mx5T
         NCGQ==
X-Gm-Message-State: AOJu0Yy9N8BxORTu+rkmYirXNLdmPAR+s6Uiv+Uj1kGRToG5jVKi+/bZ
	mQarINDrC2ae/KhkX/d+tKE=
X-Google-Smtp-Source: AGHT+IF3pE4wrAd1LXA3jpyQTNIrf62DSNabks5Z9mNM6HNtoEoRROl4bouy4RW99QGrgG3wAZl3+A==
X-Received: by 2002:a7b:cc8c:0:b0:40e:6cf9:506e with SMTP id p12-20020a7bcc8c000000b0040e6cf9506emr1905934wma.96.1705313210462;
        Mon, 15 Jan 2024 02:06:50 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b0040d91fa270fsm15455681wmb.36.2024.01.15.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:06:50 -0800 (PST)
Message-ID: <ca413e5adb8bca8f18a0387af9676a4b40c538e3.camel@gmail.com>
Subject: Re: [PATCH v5 8/8] iio: adc: adi-axi-adc: move to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Mon, 15 Jan 2024 11:10:02 +0100
In-Reply-To: <20240112173920.000014c6@Huawei.com>
References: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
	 <20240112-iio-backend-v5-8-bdecad041ab4@analog.com>
	 <20240112173920.000014c6@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-12 at 17:39 +0000, Jonathan Cameron wrote:
> On Fri, 12 Jan 2024 17:40:22 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Move to the IIO backend framework. Devices supported by adi-axi-adc now
> > register themselves as backend devices.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> A few quick drive by comments whist I wait for a build to finish...
>=20
> > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-ad=
c.c
> > index 0f21d1d98b9f..741b53c25bb1 100644
> > --- a/drivers/iio/adc/adi-axi-adc.c
> > +++ b/drivers/iio/adc/adi-axi-adc.c
> > @@ -8,6 +8,7 @@
> > > =C2=A0static int adi_axi_adc_probe(struct platform_device *pdev)
> > =C2=A0{
> ...
>=20
> > @@ -390,37 +205,23 @@ static int adi_axi_adc_probe(struct platform_devi=
ce
> > *pdev)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	if (cl->info->version > ver) {
> > +	if (*expected_ver > ver) {
> > =C2=A0		dev_err(&pdev->dev,
> > =C2=A0			"IP core version is too old. Expected %d.%.2d.%c,
> > Reported %d.%.2d.%c\n",
>=20
> Format doesn't match with later.
>=20
> > -			ADI_AXI_PCORE_VER_MAJOR(cl->info->version),
> > -			ADI_AXI_PCORE_VER_MINOR(cl->info->version),
> > -			ADI_AXI_PCORE_VER_PATCH(cl->info->version),
> > +			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
> > +			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
> > +			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
> > =C2=A0			ADI_AXI_PCORE_VER_MAJOR(ver),
> > =C2=A0			ADI_AXI_PCORE_VER_MINOR(ver),
> > =C2=A0			ADI_AXI_PCORE_VER_PATCH(ver));
> > =C2=A0		return -ENODEV;
> > =C2=A0	}
> > =C2=A0
> > -	indio_dev->info =3D &adi_axi_adc_info;
> > -	indio_dev->name =3D "adi-axi-adc";
> > -	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > -	indio_dev->num_channels =3D conv->chip_info->num_channels;
> > -	indio_dev->channels =3D conv->chip_info->channels;
> > -
> > -	ret =3D adi_axi_adc_config_dma_buffer(&pdev->dev, indio_dev);
> > +	ret =3D devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generic,
> > st);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	ret =3D adi_axi_adc_setup_channels(&pdev->dev, st);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> > -	if (ret)
> > -		return ret;
> > -
> > -	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
> > +	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%d) probed\n",
> I'd rip this (I think) unrelated change out to reduce noise in here somew=
hat.
> I'm curious though as it's still %c above.

Oh, just forgot about the above %c... Yeah, the %c format gives a crappy ou=
tput.
That's why I changed it :)

- Nuno S=C3=A1



