Return-Path: <linux-iio+bounces-24020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F33B552C4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 17:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A761F17A76A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7B31B13A;
	Fri, 12 Sep 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJPtWhqb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB4311C1B
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689818; cv=none; b=ln7iPI1+xnoHHAs7XbdE8HM1cQQM1Guu/dYy12obYx2IGa53WowtiJmSFXkmIkTOs42hS4fM3IoEETJXog4BbiFqxYgx1DYpGdFyQuf899xEjfkY4s9E+3wWHFVYkhHfCzubcpCNKhp4WLKeZJbtJIBZKb1YILYRdaCWTFTGoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689818; c=relaxed/simple;
	bh=EH8Jpbjf3tVpIiReCk8fmBnFNlqArmOcU2ajNR0GzrM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m6oyQ0LnYqIfCdOMdzIcZpQVo+oxaAJSOZFHuFmpJYo/O3+uy4RVFBrRwlkeHBtJ5g3erJ92kqOy64WtM4lG6/8Y8SVSjBxpSc8J3U3I9ztFnfDLb0XN08ea5wKDsfUkNNHAs9Orudknw87g+VIW0sRWV2yBfRCWHtxENsaB7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJPtWhqb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e46fac8421so1656396f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757689815; x=1758294615; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EH8Jpbjf3tVpIiReCk8fmBnFNlqArmOcU2ajNR0GzrM=;
        b=nJPtWhqbjPPD2Nx3MHiLul2qrJQN5Qwvj3VTNUd5tioRXJfFREvUMol/uoBAbJqikN
         1lSx3mOGYDVRV5NQZQVvlPMN+XbhbA4hlx9R/P/6p3K/DfglKaQ/5uCv7hiTAnTVyNi9
         nKgOJMLRqej6muFKUYfT7yYDxOsmVXUqBMcpogty94Yt/QiyOpwCmM0meF0fdFVIpmg/
         8ssCUC2Wu0yVP5PgTeVGwPTGxmgQL5aaTcgJEozMY76Y6MRCucmWUimvhuCydARkwNEQ
         G743Spty4rI/xHLqCbsTkFygsxxNgx7orYw/nYhYEjLi2hwec4J1H1y38E6aggzotUA5
         9i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689815; x=1758294615;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EH8Jpbjf3tVpIiReCk8fmBnFNlqArmOcU2ajNR0GzrM=;
        b=SFjJw/3B+C675S1Lg1O5HTkOmA/95XlhveKGUpKQDYk/N82OUh+8wttnihWTcXYZ8A
         nALaSEceIQDab8lEpR2Ymj0+5N/s3OYZ3iMihxP0uFn30/w5wi7EeaPUMM/Ul0safEBQ
         Zds0+1I/LofXD0IK1f1cK5VGkAnibqD7XXV0nF46X7MRK2c6m9jnPHXpC4FF4EZfBu4N
         TUaBlbQep34xoefkbYSqlKqVipZ7IvdMIZymej44gjTTxQI1oXZxcTI2BicgjmYBipFq
         Fbp9g6xvEt6ximVw5bqvga1LymoT1tAUsacP/zx0V1OmdQXme/nGhqiF+GU1G9e1ol0W
         nBzA==
X-Forwarded-Encrypted: i=1; AJvYcCVFU0usOhXCKOTIgFJVn1OfvnasqL6ZTP1bnMK9KVHa+uGYNpl04/HAPEMEm2sVXdEu4CjApDGegz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxowq14ZKQ4VC0m4j6MNfR3iU0T8P3hlVDc3rxvgcMbmBpU++W
	XSedMkW2EDsmoWQVWSoLd0tx2H/xKJ+WgvjmkH4un+/idhmyB/gQZsmp
X-Gm-Gg: ASbGnctFPvdyqU7wKyz1SiyZOxXdV1Hpa1CAQiD+rKBo850DXFln5dNfvI7Lm0/6qQf
	k0zhqLF/ClIg2Y4+0N3ecoclJtzNfVd+En1ndCE+Ar/o1Ze3h42Lu8xvkbA2GGWqMlezNS6DbSP
	knGLgL0J6irP+9h77hKlS2PSvS/446hTFyzGdp/rX3o9cKfWDS+LdSBUbseLO4zQA3ERtI5YLOJ
	aRAx/hleqKAcpOgMm9oQKoknG/GLn+CvXuifQXKgruaiEBM3CWw1ttVSnClRmPL81sUOQ8DA079
	27mcAlifbVXUEQmhgan+0ueXJLRHqNbnNk5fgp+Hn44fHNKJ2gel5nt8gktsHOgB96D9pSuB1a2
	Xjk/cbNhQCNzkRqEBMDi+YA==
X-Google-Smtp-Source: AGHT+IFBZ7ayZR6As5TqBDPX+xL1vq+uJ+g/MEFjF5Qhn9/NpX91L+SlvU7V18reC2hiHLdmFxq/pg==
X-Received: by 2002:a05:6000:60f:b0:3e7:4835:8ea7 with SMTP id ffacd0b85a97d-3e765780af8mr2560033f8f.8.1757689813723;
        Fri, 12 Sep 2025 08:10:13 -0700 (PDT)
Received: from [10.5.0.2] ([185.128.9.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775b13sm7063783f8f.10.2025.09.12.08.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:13 -0700 (PDT)
Message-ID: <6bf6a282ee8a4e55ebba21d89ec6dcf3fa499188.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Jonathan Cameron	
 <jic23@kernel.org>, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, krzk+dt@kernel.org, linux-iio@vger.kernel.org,
 s32@nxp.com, 	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 chester62515@gmail.com, 	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com
Date: Fri, 12 Sep 2025 16:10:38 +0100
In-Reply-To: <20250912151718.00004cf1@huawei.com>
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
		<20250910155759.75380-3-daniel.lezcano@linaro.org>
		<20250910183212.6640e662@jic23-huawei>
		<b4d2ad54-54d5-4c26-be49-b6ac671683d2@linaro.org>
		<c746e72c-dbd9-4afb-9da4-5d13733fd561@baylibre.com>
	 <20250912151718.00004cf1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-12 at 15:17 +0100, Jonathan Cameron wrote:
> On Thu, 11 Sep 2025 08:26:06 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 9/11/25 7:55 AM, Daniel Lezcano wrote:
> > >=20
> > > Hi Jonathan,
> > >=20
> > > thanks for the review
> > >=20
> > > On 10/09/2025 19:32, Jonathan Cameron wrote:=C2=A0=20
> > > > On Wed, 10 Sep 2025 17:57:56 +0200
> > > > Daniel Lezcano <daniel.lezcano@linaro.org> wrote:=C2=A0=20
> > >=20
> > > [ ... ]
> > > =C2=A0=20
> >=20
> > ...
> >=20
> > > =C2=A0=20
> > > > > +=C2=A0=C2=A0=C2=A0 indio_dev->name =3D dev_name(dev);=C2=A0=20
> > > >=20
> > > > This should be the 'part number'.=C2=A0 That is a little ill define=
d
> > > > for a SoC integrated ADC, but generally not what we get from dev_na=
me()
> > > > on the platform_device.=C2=A0=20
> > >=20
> > > Sorry, I don't get the comment. If I refer to the different drivers t=
here
> > > is not consistency with the iio_dev->name.=C2=A0=20
> >=20
> > dev_name() will be something like adc@12345678 from the devicetree,
> > so not the "part number".
> >=20
> > >=20
> > > rtq6056.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name =3D "rtq6056=
";=C2=A0=20
> >=20
> > This style is preferred if there is only one supported part.
> >=20
> > > rzg2l_adc.c:=C2=A0=C2=A0=C2=A0 indio_dev->name =3D DRIVER_NAME;=C2=A0=
=20
> >=20
> > We try to avoid using a macro for the driver name like this.
> >=20
> > > sc27xx_adc.c:=C2=A0=C2=A0 indio_dev->name =3D dev_name(dev);=C2=A0=
=20
> >=20
> > Looks like we missed catching this one in review.
>=20
> There are a bunch of historical drivers (and maybe some more recent
> ones that snuck in). The risk of changing that ABI seemed too high to fix=
 them
> up.=C2=A0 I guess this happens often enough I should add a comment to the=
 ones
> that still do this about it being wrong but left alone as the ABI was in =
use.
>=20

Yeah, we (at ADI) also had the highly questionable practise of using the OF=
 node
name until we the label property got in. So I would not be surprised if som=
e of
those are still around.

- Nuno S=C3=A1=20

>=20
> >=20
> > > mt6359-auxadc.c:=C2=A0 indio_dev->name =3D adc_dev->chip_info->model_=
name;=C2=A0=20
> >=20
> > This is preferred if there is more than one part supported in the drive=
r.
> >=20
> > > mcp3911.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name =3D spi_get_=
device_id(spi)->name;=C2=A0=20
> >=20
> > This is fine too in cases where there isn't chip_info.
> >=20
> > >=20
> > > Are you suggesting to use the compatible part number ?
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0indio->name =3D "s32g2-sar-adc";
> > > =C2=A0=20
> >=20
> > That works.
> >=20
> >=20
> >=20

