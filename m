Return-Path: <linux-iio+bounces-25129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D9BE2599
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 11:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F403B9991
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 09:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EDC31618F;
	Thu, 16 Oct 2025 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEpy0kNm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9F325496
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606649; cv=none; b=S5KNG9/cg3cC4Ciaw3XPhaTdXmprhTRFrHd0neFYiSmPEwRVQjnPe1LbmtI8kXm9gYrUxhvDfVZ2BlGxjkdf4WYAfkPA+Q89RYE5TfRmwdm74MM3MiCFxZmtaG9q0ZzvjijhNSs5o9q2U7KZPS+Ei04/BM/Iwu9y+hZFWUBVru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606649; c=relaxed/simple;
	bh=dtdYSFzxl4ZLf2m3mmaBJjWZIDIL1b9t2J/uPFgCe9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufor33pDXouhEJjoVIK8bRdVnXAdFSj/MFIYgK/XOB/1FHu2oMc763HyZ7njIlDJqenQsPNUnvrK3JwQgR/kGJtDvj5w+V4krFIteBszzuvkNgXktUzqfzYbKkmQX8Xb5V8fvk72R4qKCqu8Gefy6/HCcHXQykul4k/VeqRFAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEpy0kNm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so5405735e9.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 02:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760606645; x=1761211445; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wN5GriOc5joXaZ2V++iE2SjCJaPtC87zNIqvbkuQmbs=;
        b=VEpy0kNmDouy4Xnbmr+9VNMHxYXnxEj6hFs9v3DbW7CBRDn+TstTbQpIRNKEwVvcp1
         vbu+HX0tYA59GalQ84mifK8eeLIdcJ1fkFbT4X3oKwyuyagy/T0x40ilBbgI0Tmbp0SP
         +7ZFqLaVxU4nUVe+ECRlCkskVVM5nU2+KRLYkYVmsBRZ9WisdG0gZJS4IYQYakK2H8PC
         7YYG9knKjDTnakYZYyrDdscFiIyCrBwRR5g9dZjPMSxYYgIrgahhJB3oDHVOGFVodQFx
         muAXdy2eIrPuVJwJyI6GPZ+1sbGGJl+/scdLN0XXeEelrC6SlXKv6tnpKOkOm3ohbLSC
         qKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606645; x=1761211445;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wN5GriOc5joXaZ2V++iE2SjCJaPtC87zNIqvbkuQmbs=;
        b=fVk+uev05tXLpZaxVj97I+bn+3jYfAoVs6Qe5AJ1jcnqa/qdSLIJgMVsdGKYcQzfhO
         KiItw2DlF1VO7sLtToBkviGRWzGtHyxK7DUBTUOGtyNT4mFcpYJcI0AxM0HDSOP+Uwhc
         DSx7MNNYZ4dZmynKuHZX+MwoOMrwbW7zVo6UmQtYoonV3t8IchXGDpRRH89zByWmgTm5
         LFfAEgs98aJHyoJlOlxsFf3TfYAdisBB0xplhJHUNPPIfJTfYag0PPYnGdCtqgMWW0A0
         vLC8aw6WfYOeZB0jr8kE1E1Tz2EwyJcI7eB6u6v2g5OwsB3NUSYzp4aelCo4qrPr0Mep
         ZwCA==
X-Forwarded-Encrypted: i=1; AJvYcCUQTHvylkVQOnKfG9mYOEx/Al836jyjmahTXuvokGeeHz2zZbhziRFD0NNzEZxIF2jknQRt7/VTySg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNPcRhhEqeOk1080CeK+L3SgB7bIwXkgmWIsbPgG8n85US91O
	UEybdp8uX6Knqp8a5fkR8Wg2n/RmwI80FlEL/1PFTBKNCAB2JUMVee3M
X-Gm-Gg: ASbGncsQqkPTVXeYp2//uj8Utw5JkO+s5ikSHMATmd7yxY8tEXGMLppVQE2NFCjkJB1
	6t4X4+93V5y/vJ5vsRUrjCC5Be62OMaOFqaxZagpfGlJwmvIlAxEsSC6A4ttBgM+PuZeBGdf5mM
	JUNJ9epIVgjZhCfC4zxo0hmbM1XmHY7mtLykPIv+7TvJnEmaXw+pmQH+e9Q+LqZeb5I9L358f0y
	ueROz7AdkKui3bm2EDvfrnbxApGTkkmIWjIVpW5l3xEYLXphIobYuuVcaWlq/KSDJtatttrecQZ
	o+usbIDGNorwYKVTm4vgVPvw/2KdJheEIwXbETbHBeznGE2h7wbVvKHNx6uO/yILaovoz80+PwH
	iIN4rZ7V7DdiB0o72pl64WVhB/XD1zFtQB6lTo/BwRFPqx55g9jfEQVn6R0WnbEwtb231ApYD7w
	k1lki5DTbN
X-Google-Smtp-Source: AGHT+IFM/eDs5DimbOjgvhNjhvWS6XPVfEwodHiPhgaUg+nD8JwAoHYzOT5T+xC5UzBHiITSk+szgw==
X-Received: by 2002:a05:600c:5028:b0:46e:428a:b4c7 with SMTP id 5b1f17b1804b1-46fa9af2ff1mr222490415e9.23.1760606645180;
        Thu, 16 Oct 2025 02:24:05 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c91sm13762335e9.11.2025.10.16.02.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:24:04 -0700 (PDT)
Message-ID: <de57f5274b2fe0aac3621dc10cb6d4d0d98d3063.camel@gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown	
 <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Date: Thu, 16 Oct 2025 10:24:36 +0100
In-Reply-To: <20251015211420.031c61fa@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	 <20251015142816.1274605-3-herve.codina@bootlin.com>
	 <1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
	 <20251015211420.031c61fa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 21:14 +0200, Herve Codina wrote:
> Hi Nuno,
>=20
> On Wed, 15 Oct 2025 16:21:09 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> ...
> >=20
> > > +static int rzn1_adc_enable(struct rzn1_adc *rzn1_adc)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret =3D rzn1_adc_core_power_on(&rzn1_adc->adc_core[0]);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D rzn1_adc_core_power_on(&rzn1_adc->adc_core[1]);
> > > +	if (ret)
> > > +		goto poweroff_adc_core0;
> > > +
> > > +	ret =3D clk_prepare_enable(rzn1_adc->pclk);
> > > +	if (ret)
> > > +		goto poweroff_adc_core1;
> > > +
> > > +	ret =3D clk_prepare_enable(rzn1_adc->adc_clk);
> > > +	if (ret)
> > > +		goto disable_pclk;
> > > +
> > > +	ret =3D rzn1_adc_power(rzn1_adc, true);
> > > +	if (ret)
> > > +		goto disable_adc_clk;=C2=A0=20
> >=20
> > Can we use devm_actions() on the above to avoid the complex error path =
plus
> > the
> > .remove() callback?
>=20
> rzn1_adc_enable() is used by the driver pm_runtime_resume() function.
>=20
> I don't think that devm_add_actions_or_reset() will help here.
>=20
> In my understanding, devm_* functions are use to perform some operations
> automatically on device removal.
>=20
> The purpose of the error path here is to restore a correct state if
> rzn1_adc_enable() failed when it is called from pm_runtime_resume().
>=20
> In that case no device removal is involved to trig any action set by
> devm_add_actions_or_reset().
>=20
> Maybe I am wrong. Did I miss something?

Nope, I see now what's your intent.

>=20
> >=20
> > > +
> > > +	return 0;
> > > +
> > > +disable_adc_clk:
> > > +	clk_disable_unprepare(rzn1_adc->adc_clk);
> > > +disable_pclk:
> > > +	clk_disable_unprepare(rzn1_adc->pclk);
> > > +poweroff_adc_core1:
> > > +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[1]);
> > > +poweroff_adc_core0:
> > > +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[0]);
> > > +	return ret;
> > > +}
> > > +
>=20
> ...
>=20
> > > +static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
> > > +					 struct iio_dev *indio_dev)
> > > +{
> > > +	int adc_used;
> > > +
> > > +	adc_used =3D rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
> > > +	adc_used |=3D rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
> > > +
> > > +	switch (adc_used) {
> > > +	case 0x01:
> > > +		indio_dev->channels =3D rzn1_adc1_channels;
> > > +		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc1_channels);
> > > +		return 0;
> > > +	case 0x02:
> > > +		indio_dev->channels =3D rzn1_adc2_channels;
> > > +		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc2_channels);
> > > +		return 0;
> > > +	case 0x03:
> > > +		indio_dev->channels =3D rzn1_adc1_adc2_channels;
> > > +		indio_dev->num_channels =3D
> > > ARRAY_SIZE(rzn1_adc1_adc2_channels);
> > > +		return 0;
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > > +	dev_err(rzn1_adc->dev, "Failed to set IIO channels, no ADC core
> > > used\n");
> > > +	return -ENODEV;=C2=A0=20
> >=20
> > dev_err_probe()?
>=20
> Why? the error returned is a well known value: -ENODEV.
>=20
> dev_err_probe() should be involved when -EPROBE_DEFER is a potential erro=
r
> code.
>=20
> IMHO, dev_err() here is correct.

If I'm not missing nothing this function is called during probe so I do thi=
nk
dev_err_probe() should be used. Not only unifies logging style during probe=
 it
also has the small benefit of doing:

return dev_err_probe(...) saving a line of code.

You can see that, at least in IIO, we even have some patches just convertin=
g
drivers probe() to use dev_err_probe().

>=20
> >=20
> > > +}
> > > +
> > > +static int rzn1_adc_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct iio_dev *indio_dev;
> > > +	struct rzn1_adc *rzn1_adc;
> > > +	int ret;
> > > +
> > > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*rzn1_adc));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	rzn1_adc =3D iio_priv(indio_dev);
> > > +	rzn1_adc->dev =3D dev;
> > > +	mutex_init(&rzn1_adc->lock);=C2=A0=20
> >=20
> > devm_mutex_init()
>=20
> Yes, I will update in the next iteration.
>=20
> >=20
> > > +
> > > +	rzn1_adc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(rzn1_adc->regs))
> > > +		return PTR_ERR(rzn1_adc->regs);
> > > +
> > > +	rzn1_adc->pclk =3D devm_clk_get(dev, "pclk");
> > > +	if (IS_ERR(rzn1_adc->pclk))
> > > +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk),
> > > "Failed to
> > > get pclk\n");
> > > +
> > > +	rzn1_adc->adc_clk =3D devm_clk_get(dev, "adc-clk");
> > > +	if (IS_ERR(rzn1_adc->pclk))
> > > +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk),
> > > "Failed to
> > > get adc-clk\n");
> > > +
> > > +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-
> > > >adc_core[0],
> > > +					=C2=A0=C2=A0 "adc1-avdd", "adc1-vref");
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-
> > > >adc_core[1],
> > > +					=C2=A0=C2=A0 "adc2-avdd", "adc2-vref");
> > > +	if (ret)
> > > +		return ret;=C2=A0=20
> >=20
> > Hmm, is avdd really an optional regulator? I mean can the ADC power up =
at
> > all
> > without a supply in AVDD? Even vref seems to be mandatory as we can't
> > properly
> > scale the sample without it.
>=20
> Where do you see that avdd is an optional regulator?

You are using devm_regulator_get_optional(). That's for optional regulators=
.

>=20
> >=20
> > Also, can't we have getting and enabling the regulator together? Then, =
we
> > could
> > use some of the modern helpers to simplify the code (ok I see you use t=
hem
> > in
> > the PM callbacks).
>=20
> Yes, I rely on PM callbacks to handle those regulators.
>=20
> >=20
> > > +
> > > +	platform_set_drvdata(pdev, indio_dev);
> > > +
> > > +	indio_dev->name =3D dev_name(dev);=C2=A0=20
> >=20
> > dev_name() should not be used for the above. It's typically the part na=
me so
> > I
> > guess in here "rzn1-adc" would be the appropriate one.
>=20
> I thought it was more related to the instance and so having a different n=
ame
> for each instance was better.
>=20
> Some other IIO drivers use dev_name() here.
>=20
> But well, if you confirm that a fixed string should be used and so all
> instances have the same string, no problem, I will update my indio_dev->n=
ame.

It is a fixed string, typically the part name. David Lechner not that long =
ago
actually sent some patch or documented somewhere why not to use dev_name().=
 To
identify different instances we have a 'label' property.

>=20
> >=20
> > > +	indio_dev->info =3D &rzn1_adc_info;
> > > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > +	ret =3D rzn1_adc_set_iio_dev_channels(rzn1_adc, indio_dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D rzn1_adc_enable(rzn1_adc);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pm_runtime_set_autosuspend_delay(dev, 500);
> > > +	pm_runtime_use_autosuspend(dev);
> > > +	pm_runtime_get_noresume(dev);
> > > +	pm_runtime_set_active(dev);
> > > +	pm_runtime_enable(dev);=C2=A0=20
> >=20
> > There's a devm_pm_runtime_enable() API now.
>=20
> Will look to use it in the next iteration.
>=20
> >=20
> > > +
> > > +	ret =3D devm_iio_device_register(dev, indio_dev);
> > > +	if (ret)
> > > +		goto disable;
> > > +
> > > +	pm_runtime_mark_last_busy(dev);
> > > +	pm_runtime_put_autosuspend(dev);
> > > +
> > > +	return 0;
> > > +
> > > +disable:
> > > +	pm_runtime_disable(dev);
> > > +	pm_runtime_put_noidle(dev);
> > > +	pm_runtime_set_suspended(dev);
> > > +	pm_runtime_dont_use_autosuspend(dev);
> > > +
> > > +	rzn1_adc_disable(rzn1_adc);
> > > +	return ret;
> > > +}
> > > +
> > > +static void rzn1_adc_remove(struct platform_device *pdev)
> > > +{
> > > +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > > +	struct rzn1_adc *rzn1_adc =3D iio_priv(indio_dev);
> > > +
> > > +	pm_runtime_disable(rzn1_adc->dev);
> > > +	pm_runtime_set_suspended(rzn1_adc->dev);
> > > +	pm_runtime_dont_use_autosuspend(rzn1_adc->dev);
> > > +
> > > +	rzn1_adc_disable(rzn1_adc);
> > > +}=C2=A0=20
> >=20
> > I'm fairly confident we can sanely go without .remove().
>=20
> Will see what I can be do for the next iteration.
>=20
> Maybe I will ask some questions if I need some clarification around
> pm_runtime but let me first try to go further in that direction.

Yeah, maybe you can come up with something but given how you use pm to
enable/disable stuff I'm also not sure the above is easily doable.

- Nuno S=C3=A1

