Return-Path: <linux-iio+bounces-10685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73379A261C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 17:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E60B216DB
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64C1DE4DA;
	Thu, 17 Oct 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3/qwWY8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E971DB956;
	Thu, 17 Oct 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177761; cv=none; b=fjZlVGtmkGIZchHy4GcLNV4bntJNf0Yib1b3sltKOPpWzkB9aYMOynXL7sb3jonQpsgLCvkaue2cYSNLBicnt0b7ux5nL+jpXUBOnITAXVm4K3PddmdmhsXJPB5iCSMz7fBu8iH4AzH250mQ34MGVJcLuXjg5i/Jf8GKlKNIOeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177761; c=relaxed/simple;
	bh=Zzw3q2M1tiIZscuWpamIepd8Oz0Ss6THGX+hbiGlW+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sl61iTCrD3jqiJDg3zzmyImJ7pZtUgXtTByuLit0i0IoXPpaHaKzgvuT7XWavanz7U2hh5EDXoWnACn8F51/XtbGemBse4fNkeciNlorjVADO+mvI8QRqRsUjorXf1monF6M14aphQsXLGImtc9ts9BGtLAWzS57o/mIbdMOHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3/qwWY8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43158625112so10337955e9.3;
        Thu, 17 Oct 2024 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729177755; x=1729782555; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mEgu8NxoNG6sAiEHLCUmMF2BTcpfhaYwbNZMN32V5fs=;
        b=c3/qwWY8UWZpyfdOaaVGNOQGS5j/b+CjeuZjdB81RxgRgLlrRFoaFVZrDBBC2WC1XI
         ZgJbTtuAEI6ObQalumnxyNPjQIh/rTdANazxMpo82eAagUtHzQbdfCfZDJO+y4LiRXwA
         vXpB8DoVffXRiiNHl9LcH9gCagEZnVzjp/pgnYkHPYdZlsvy0abKCbzkDjO3p0kquKGz
         pFQFx0fGNGknt4qXPOx62/uXWzVcMEVCPFzSyxl0KSSJnqSN/FOL+fOKovUmwcpPsfNp
         m0H/Zuc6ovB+uq0zYWaM2thEP7b5otbpUILpGEbN23j5EgJmoN9vYIW8GrkKBMPEEBE6
         fhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729177755; x=1729782555;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEgu8NxoNG6sAiEHLCUmMF2BTcpfhaYwbNZMN32V5fs=;
        b=VE8jtR4tnrp+ypqVPISoH0Pi/NcSJKFYHBQc5VqF2puMJghV7EfJgxCHVVW1wj/RP7
         t0K4HZmBF3SWizrJh/nvdubsgSjWiQJYcpR+GFXBnnkUKmq8dY9Au0ZKSLxYmpETHdVZ
         FL+EWVZ8gJXoazpBs67FtJG6aA7dlj41id7xb4jGd5P3qKY2CVapt3Vmq9XSYYzZM916
         62tNvoKcss6kJEUm773cFJ9zZlc9AxkjqL8B2wCsvyE8OzEfSqF08MFqMnSESR4MtlsS
         jqv4nslVunehEATYs9X+Y2i4k/mkD1x6wjRbFvTuQg0lhGnHJGlvF23IiIZCElHJ+guZ
         Nn9A==
X-Forwarded-Encrypted: i=1; AJvYcCUxgBEzAvy+nuljDaW0PORGNJh+d7LvxsVhu9CosjXUeOj1OCj20ck4niLcIHoAdNZoH5z25ujO0X4oifJe@vger.kernel.org, AJvYcCWEFaIJxSuLRSv+0fiCcW0jSEa64P5nlACCwbuotDmym2j4N/oYmkI6uXBmQv/shIuY7xsvfmgvXFOc@vger.kernel.org, AJvYcCWLQhekDu7PaDlV8Wx2GEG145A2lPXqA/ifDE4AhICXZXjz6pTrkInxLjoiicqYT2jG8kyo+YycP71O@vger.kernel.org
X-Gm-Message-State: AOJu0YybEKFRjWu32M1e7+tmQehr8LkBfQiocO7DNOkoaseMK5oK+I7c
	POlJFc7prSDU0fDkk0n/+AQCgMLgaGkfLXIhyTgcqUWOdvi4GiMB
X-Google-Smtp-Source: AGHT+IHn8wAt3ZlgJ/V83i2Qw434nFDf02zDEe+z2KYVXFkPIPIHE0hOwX4EZVHDlPvizKH9tNaSQw==
X-Received: by 2002:a05:600c:58d7:b0:431:54f3:11af with SMTP id 5b1f17b1804b1-43154f312eemr38655935e9.31.1729177754679;
        Thu, 17 Oct 2024 08:09:14 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd? (p200300f6ef1521002c2bbcc5835ec2dd.dip0.t-ipconnect.de. [2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a1a3sm7485277f8f.12.2024.10.17.08.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:09:14 -0700 (PDT)
Message-ID: <fbb79ac45fdf1103fa4e70373c90817b38ad9cfd.camel@gmail.com>
Subject: Re: [PATCH v6 8/8] iio: dac: adi-axi-dac: add registering of child
 fdt node
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>
Date: Thu, 17 Oct 2024 17:13:30 +0200
In-Reply-To: <f7ocoaxapiq56iqutinmlyduuyrfbhbgspxfatgtnwlduaufek@ucj4ymciajqs>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-8-eeef0c1e0e56@baylibre.com>
	 <022be235-f028-4b6e-9589-b0066df5d459@baylibre.com>
	 <df1cdac2c954d9a95b9026a400e68697e177787f.camel@gmail.com>
	 <f7ocoaxapiq56iqutinmlyduuyrfbhbgspxfatgtnwlduaufek@ucj4ymciajqs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 10:32 +0200, Angelo Dureghello wrote:
> On 15.10.2024 08:11, Nuno S=C3=A1 wrote:
> > On Mon, 2024-10-14 at 16:16 -0500, David Lechner wrote:
> > > On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Change to obtain the fdt use case as reported in the
> > > > adi,ad3552r.yaml file in this patchset.
> > > >=20
> > > > The DAC device is defined as a child node of the backend.
> > > > Registering the child fdt node as a platform devices.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 53
> > > > +++++++++++++++++++++++++++++++++++++++++++
> > > > =C2=A01 file changed, 53 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-ax=
i-
> > > > dac.c
> > > > index b887c6343f96..f85e3138d428 100644
> > > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > > @@ -29,6 +29,8 @@
> > > > =C2=A0#include <linux/iio/buffer.h>
> > > > =C2=A0#include <linux/iio/iio.h>
> > > > =C2=A0
> > > > +#include "ad3552r-hs.h"
> > > > +
> > > > =C2=A0/*
> > > > =C2=A0 * Register definitions:
> > > > =C2=A0 *=C2=A0=C2=A0
> > > > https://wiki.analog.com/resources/fpga/docs/axi_dac_ip#register_map
> > > > @@ -738,6 +740,39 @@ static int axi_dac_bus_reg_read(struct iio_bac=
kend
> > > > *back,
> > > > u32 reg, u32 *val,
> > > > =C2=A0	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
> > > > =C2=A0}
> > > > =C2=A0
> > > > +static void axi_dac_child_remove(void *data)
> > > > +{
> > > > +	struct platform_device *pdev =3D data;
> > > > +
> > > > +	platform_device_unregister(pdev);
> >=20
> > Just do platform_device_unregister(data)... Or call the argument pdev f=
or
> > better
> > readability...
> >=20
> > > > +}
> > > > +
> > > > +static int axi_dac_create_platform_device(struct axi_dac_state *st=
,
> > > > +					=C2=A0 struct fwnode_handle *child)
> > > > +{
> > > > +	struct ad3552r_hs_platform_data pdata =3D {
> > > > +		.bus_reg_read =3D axi_dac_bus_reg_read,
> > > > +		.bus_reg_write =3D axi_dac_bus_reg_write,
> > > > +	};
> > > > +	struct platform_device_info pi =3D {
> > > > +		.parent =3D st->dev,
> > > > +		.name =3D fwnode_get_name(child),
> > > > +		.id =3D PLATFORM_DEVID_AUTO,
> > > > +		.fwnode =3D child,
> > > > +		.data =3D &pdata,
> > > > +		.size_data =3D sizeof(pdata),
> > > > +	};
> > > > +	struct platform_device *pdev;
> > > > +
> > > > +	pdev =3D platform_device_register_full(&pi);
> > > > +	if (IS_ERR(pdev))
> > > > +		return PTR_ERR(pdev);
> > > > +
> > > > +	device_set_node(&pdev->dev, child);
> > >=20
> > > Not sure why Nuno suggested adding device_set_node(). It is
> > > redundant since platform_device_register_full() already does
> > > the same thing.
> > >=20
> >=20
> > Indeed... I realized that yesterday when (actually) looking at
> > platform_device_register_full(). You just beat me in replying to the em=
ail.
> > Sorry for
> > the noise...
> >=20
> > > (And setting it after platform_device_register_full() would
> > > be too late anyway since drivers may have already probed.)
> >=20
> > > > +
> > > > +	return devm_add_action_or_reset(st->dev, axi_dac_child_remove,
> > > > pdev);
> > > > +}
> > > > +
> > > > =C2=A0static const struct iio_backend_ops axi_dac_generic_ops =3D {
> > > > =C2=A0	.enable =3D axi_dac_enable,
> > > > =C2=A0	.disable =3D axi_dac_disable,
> > > > @@ -874,6 +909,24 @@ static int axi_dac_probe(struct platform_devic=
e
> > > > *pdev)
> > > > =C2=A0		return dev_err_probe(&pdev->dev, ret,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio
> > > > backend\n");
> > > > =C2=A0
> > > > +	device_for_each_child_node_scoped(&pdev->dev, child) {
> > > > +		int val;
> > > > +
> >=20
> > I'm starting to come around again if some sort of flag (bus_controller =
or an
> > explicit
> > has_child) wouldn't make sense (since you may need to re-spin another
> > version). So we
> > could error out in case someone comes up with child nodes on a device t=
hat
> > does not
> > support them.=C2=A0
> >=20
>=20
> For this, i added a check on io-backend here, that has been asked
> to be removed.

Not sure if it's totally correct but better than the option you suggest bel=
ow.
So if you prefer that (opposed to an explicit flag), maybe then bring back =
the
check for the io-backend presence with a comment to make the intent explici=
t.
Like, "All childs need to point to an io-backend" or something like that. A=
nd if
we ever have a usecase where we can have childs without that property, we c=
an
add an explicit flag for this.

> Without adding other flags, i may use has_dac_clk, could it be ok ?
>=20

I do not think it's related. Even more since that flag is generic enough th=
at
could be used for another versions of the IP which also have additional clo=
cks
on top of the axi one.

- Nuno S=C3=A1
>=20


