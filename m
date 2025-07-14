Return-Path: <linux-iio+bounces-21641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61252B0451C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74015175A62
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE98525EFBE;
	Mon, 14 Jul 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqRj8qpT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AD256C9C;
	Mon, 14 Jul 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509482; cv=none; b=NWAjjydOhyHc3IAaqJjAFE7sFzvKULxRcLLnBjqEGODFcFftjuIBygIAMB4YWuaGii5/FPvYpZ0eTq18Fb9o5tllREUY0Ph5Wx/I9ZwzdGHU2QQ4LvVvWId9kLMGfRYa3uGfzNdxEtxqLTnE7dNwKm+z3/cRv1nHZV0wEYazG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509482; c=relaxed/simple;
	bh=nf4vs6nOKYWis7A8F8h4VTZb3Ww/LSePChVIWjjRS4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t3oOKGde9zSQzzpBRO5+3vIPaN30xhBLjT3UXv+76auKnY2szcP4aZAtxNzVJN/Gu2YsWXRDSHQsYaYlvGD+as0qSCc9G0iBqCBqYnkJkov/1v861N2hLfWgNLNiUQBGpDV7jO7zDxojI1AhtZwfZMRkR00R1mQFacXUmbPZAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqRj8qpT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso46829385e9.3;
        Mon, 14 Jul 2025 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752509479; x=1753114279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nf4vs6nOKYWis7A8F8h4VTZb3Ww/LSePChVIWjjRS4Q=;
        b=FqRj8qpTfljob1UkpZE3vtWf+E1l/eArbL7WvKk7mvixVdmNyAQ7ExmDtUUTo8xkoi
         sgD28dgjWzOt3dROnAciSPTVsab0chtDIBb2Hv/EkULo19Ut6gk8Ayg+Q2bQcuBf+NkV
         SfuoAt5yC9C/5zj0vszy67xMk9b84BlHtz7qPfKOHjgvkvF05CEHFr7EFZG/2Di18r1f
         1dgTbiqCBKQIusfjw2qJys92s4QEDBkS7DGZLhHzfzf6m08/dBnOb3IaYe8tOi6TIkEN
         La2mDqkmH/mOSTfdyU3j17izXP2brL/HdJ5uBI5JkhW05pxFa/+SIaPrpTajBQPQAMA0
         /sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509479; x=1753114279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nf4vs6nOKYWis7A8F8h4VTZb3Ww/LSePChVIWjjRS4Q=;
        b=pHNlm29bTa8ZzRLR5RIC6OsYGzOscJihTTPUt1dudGg+7HAwNhb4LDF7MAEhrRDN1E
         gpmq444MwiVmFUX/5IFG7ai7ZaFyBmlzKbLVL+rUDsYRGkburrY9H0puq62MwiuaumEo
         vnnwuyeY3YfADGVYsA66z/+sG/17EPMWvjkVEcrU3eCiUz13JDzlv/HLqg6mekGvD4Tm
         AQ3m4rk5Od2iWvM9PWmECQQe8JWID4cQvFWTW0q8P75x68BOcnMoOwgb+VzOQaBQKPri
         kiiNW8gxYmXCN5b4QVYjTnHu7IiFN0IwZvxHua63MHN/9NVNgdZ6XarYzalVmqaneDCO
         7mTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcHnJLkImaXQUbWQUH6r6LPxP4hupHNM6RmspUhvIe9ic9mFEKHAxLz1qEVSD16vXILyWmc4Gg0AY30MkA@vger.kernel.org, AJvYcCVxlTib/ujdTdahNc+CBxa0jFNEcCS5Tkm6nAlGQm+f0+BDgTfGTCaU9ELGs3lqGOba79xv962+8v7Z@vger.kernel.org, AJvYcCWOlH3jnbveah3de27+K1g2nKfC7yeoNYq23pD786arcL65Yjpin6UhgNS3TC4rdG8EAh0p77zSoR1d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Z9wD6ZfGpk0UW6jzKarWb50Sdi6pHEBfWsOWFUdXQT4po3Pj
	iARE237uHQ38pH4FW2TLsVUwTPxv5a2X4wyzvENt1d6gElI06T8xU+UA
X-Gm-Gg: ASbGncsMqVXGZfoudNBaXLHR5tc6ZwyzoH853xW/fa/W/hLRwOym8wHXiX59yPG60NU
	9fa7bMLP62Lj1ERlsMkUK2n1/8ZsDNWwSzLsCoEEUFQjQpr5i6vycTc+JVSWyu1MNWGqBZzCF6T
	dWcGXTRPSJUUCN97ryxj9CA/1u0uuMHthFdDeXbWl8v27lImPdzn9pNoQnZrgbi0/XWyVCHxTMc
	2sp5nOaA4itmOGams4yrM0FzgbfGMb2+T0OgsCVbLjag9iFWwYHwqPxPlHsh5+GZfY4yEuwhWIQ
	LCqvzQE7HpJS0MbuKKOZN21vKVOJngyD95zDEonIO5tFsNN1GNrrb0qbxvfmKCk8cmmBUJYKcJP
	OvXcI2tCpZ4YhZr0dUgsNfrm6zBJNUA==
X-Google-Smtp-Source: AGHT+IGUpToWdSctfAs3OEHNJr6LLvNw1cbXYajG3U/nqh4JtR7+4OuHXsfmXW0g3MdCYO1qHiV4iA==
X-Received: by 2002:adf:b643:0:b0:3a5:8cc2:10aa with SMTP id ffacd0b85a97d-3b5f188ea13mr9929289f8f.32.1752509478866;
        Mon, 14 Jul 2025 09:11:18 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd163csm12660465f8f.4.2025.07.14.09.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:11:18 -0700 (PDT)
Message-ID: <6b32118a13e9e28b7cf12152af33642c76367c34.camel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Primoz Fiser <primoz.fiser@norik.com>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Haibo Chen
 <haibo.chen@nxp.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer	 <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	upstream@lists.phytec.de, andrej.picej@norik.com
Date: Mon, 14 Jul 2025 17:11:31 +0100
In-Reply-To: <de2c8e15-14e9-4c61-9a13-97ef1ec567a4@norik.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
	 <20250710073905.1105417-2-primoz.fiser@norik.com>
	 <2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
	 <20250713160247.0f22bbfe@jic23-huawei>
	 <de2c8e15-14e9-4c61-9a13-97ef1ec567a4@norik.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-14 at 07:56 +0200, Primoz Fiser wrote:
> Hi all,
>=20
> On 13. 07. 25 17:02, Jonathan Cameron wrote:
> > On Thu, 10 Jul 2025 10:46:44 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >=20
> > > On 7/10/25 2:39 AM, Primoz Fiser wrote:
> > > > From: Andrej Picej <andrej.picej@norik.com>
> > > >=20
> > > > Document i.MX93 ADC calibration properties and how to set them.
> > > >=20
> > > > Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> > > > Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> > > > ---
> > > > =C2=A0.../bindings/iio/adc/nxp,imx93-adc.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 21 +++++++++++++++++++
> > > > =C2=A01 file changed, 21 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-
> > > > adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.=
yaml
> > > > index c2e5ff418920..d1c04cf85fe6 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > > > @@ -52,6 +52,27 @@ properties:
> > > > =C2=A0=C2=A0 "#io-channel-cells":
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> > > > =C2=A0
> > > > +=C2=A0 nxp,calib-avg-en:
> > > > +=C2=A0=C2=A0=C2=A0 default: 1
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable or disable calibration avera=
ging function (AVGEN).
> > > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > > +=C2=A0=C2=A0=C2=A0 enum: [ 0, 1 ]
> > > > +
> > > > +=C2=A0 nxp,calib-nr-samples:
> > > > +=C2=A0=C2=A0=C2=A0 default: 512
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Selects number of samples (NRSMPL) =
to be used during calibration.
> > > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > > +=C2=A0=C2=A0=C2=A0 enum: [ 16, 32, 128, 512 ]
> >=20
> > Allow 1 as a value and drop the enabled above.=C2=A0=C2=A0 Averaging ov=
er 1 sample
> > is same as no averaging and gives simpler binding.
> >=20
> > > > +
> > > > +=C2=A0 nxp,calib-t-sample:
> > > > +=C2=A0=C2=A0=C2=A0 default: 22
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Selects sample time (TSAMP) of cali=
bration conversions in ADC
> > > > clock cycles
> > > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > > +=C2=A0=C2=A0=C2=A0 enum: [ 8, 16, 22, 32 ]
> > > > +
> > > > =C2=A0required:
> > > > =C2=A0=C2=A0 - compatible
> > > > =C2=A0=C2=A0 - reg=C2=A0=20
> > >=20
> > > This seem like things that should be set at runtime rather than
> > > in the devicetree. Unless there is some justification on why
> > > these values depend on how the chip is wired up?
>=20
> It depends how ADC 1.8V Vref is wired up, especially how noisy it is.
>=20
> >=20
> > Further to that, I'd like to see some explanation of why we care
> > to change it at all. Is it ever a bad idea to enable averaging and
> > pick a large number of samples for calibration?
>=20
> This is a snippet from the i.MX93 TRM, chapter Analog-to-Digital
> Converter (SAR_ADC) describing calibration steps:
>=20
> 1. Wait for deassertion of functional reset.
> 2. Configure SAR controller operating clock (MCR[ADCLKSE] =3D 0).
> 3. Bring ADC out of Power-down state (MCR[PWDN] =3D 0).
> 4. Configure desired calibration settings (default values kept for
> highest accuracy maximum time).
> =E2=80=A2 MCR[TSAMP]: Sample time for calibration conversion
> =E2=80=A2 MCR[NRSMPL]: Number of samples in averaging
> =E2=80=A2 MCR[AVGEN]: Averaging function enable in calibration
> 5. Run calibration by writing a one to MCR[CALSTART].
> 6. Check calibration run status in MSR[CALBUSY]=E2=80=94wait until MSR[CA=
LBUSY]
> =3D 0; alternatively, MSR[ADCSTAT] can be
> used to check status.
> 7. Check calibration pass/fail status in MSR[CALFAIL] field. If
> MSR[CALFAIL] =3D 1 then calibration failed. Detailed status
> can be checked in CALSTAT.
>=20
>=20
> See point 4).
>=20
> Not sure why would there be an option to configure i.MX93 ADC
> calibration parameters if one use-case (max accuracy max time) to rule
> them all?
>=20

Sometimes HW guys just want to give you some options. Does not mean we have=
 to
use them all :).

I guess what Jonathan is interested in, is to understand in what conditions=
 the
defaults are no good for the calibration? If we can have a set of values th=
at
should pretty much always work, no need to further complicate the bindings =
or
the driver.

- Nuno S=C3=A1=20
> On the other hand, public TRM doesn't give much more information and
> >=20

