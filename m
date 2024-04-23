Return-Path: <linux-iio+bounces-4453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BA28ADE49
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983531F22F87
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1595546BA6;
	Tue, 23 Apr 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi1xz5Bv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391461CAA2;
	Tue, 23 Apr 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857543; cv=none; b=gHESaUnM4JCpSfKiCzIXgaOBcIRjf5YlOKwP+WUNa9CAjuPt3m9lIbwonGxDbIfs8wAjm9i5Et0BT340X3svZdaxwRrLY/6IYV+piPdqcOOTqku7M32qJSQwIlD7q7sIoB+bKoDToDBAZP560zXZAudYlyduavUyvzfjkgghP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857543; c=relaxed/simple;
	bh=bcBp6DWGtt7dWcmR7loPAQT27sspDMrmpCTT0tAuqZs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fp+eRb5l+TGC/ba34cRPKThF2ii8sZ17F6KvL+ixiPsl+b8HpVY8dnTyGCnz5fZfaJNYWjAtehevq8fYGBUZmHMRL9LdjwPMZFylf4OWZooX+hqb9vgtfrXHlgWZgC0yL2tGQOcYoskk0kxevGwf0klUXAJjdzwr8F7bzT5b8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi1xz5Bv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso17640395e9.3;
        Tue, 23 Apr 2024 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713857540; x=1714462340; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZAH7WgOxeVyI3YcODqwjTEPynCvzY38zuDJVlgkVtcE=;
        b=Fi1xz5BvYLEzCDx1Jq6CswJXe61cIdgaGswmZUbnnyjrdPi1bm1mrL1k3tagpaIh5V
         78S6X/8R+mKADCs1DhSGnCqIow1ZKhLa7rHBKalpcLHft3UwIzTrNCItyJgCpniEkphy
         yO1mhdBFu8dJOO+L6L4A0VHaZjoMg4GdVsc25ORQ44F7KXcV26WudwrowaZRNrfP/Mbd
         f7IPhD5nT6I3q6ErLHmQNeZYslUSutWGXNwNIgv1uis0qJ+I6QeQ7EOvPGmAOZ+3OoRu
         i/0iSsrujHF6BMLJvJIBVXov4ERy2za6e0iFmyGvRAWmWa9Wi7BRPYHEqRLZA95jsks3
         ZS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713857540; x=1714462340;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAH7WgOxeVyI3YcODqwjTEPynCvzY38zuDJVlgkVtcE=;
        b=kTufw9iGeCf7cJB99VRvtqqWu+cizgUHkMHdhhgyDcGC5yd47d5WrzW+8XCYPgTmwg
         jc6fqmkkpvxQvzfVklFRo/OvdgHPT0X7hnrpR+hm1UyEYx5oCDRIXttRZbc8IpDZv7Fc
         Km5VRegzSiqZ8fSx7B4P9oThCGC6ZWLLHU7x591ljeO2hJ/lVN3v1YNkXXIcnqYK2C1g
         +qwerj6v88lyBHbqYbCNFzIF+faB1G9/KCiBCw8xHbsw8bj0qXDUBDh5p1AtGGGekMHt
         8JX5G1v6ywLyrCuxYdP/UHANS/K8Bra7tO0PnQGDt9sZxMcBiqW+scpan3cmkgZppoIV
         lzFA==
X-Forwarded-Encrypted: i=1; AJvYcCVhJLA5xErd73XTCYnsEhQ9DIdr038ZX/CX7HXpfg374aAjwT4zFZUgCOonURGDd2QFeHio4KJ4L6wpqnIaTEAUGo+bshvSth3mFYFWeS9hfwN2xZ5i1oNTrX5QeWo9euAIboze5Q==
X-Gm-Message-State: AOJu0Yz5il0Et84NyuT5b7achvHI1kIr8Km00imbWRZ8cyi/AYeLrdAu
	phqw8v8RsGnCto0M5mSIGCUmdeMYTlxxg8Kc8Nm3/hjlsN37A/yh
X-Google-Smtp-Source: AGHT+IGxbWusbPdgDAXMaZpC+JGvnEiO7D+oD9uR1HYs2aYXeNS8qxk40FYkD8HCG0krVDG2uIs3Pg==
X-Received: by 2002:adf:e4ca:0:b0:348:42f3:3d37 with SMTP id v10-20020adfe4ca000000b0034842f33d37mr9925380wrm.20.1713857540308;
        Tue, 23 Apr 2024 00:32:20 -0700 (PDT)
Received: from ?IPv6:2001:a61:3481:2201:6106:96db:d27b:d2c2? ([2001:a61:3481:2201:6106:96db:d27b:d2c2])
        by smtp.gmail.com with ESMTPSA id s15-20020adfe00f000000b0034b03d0b94csm5181356wrh.74.2024.04.23.00.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:32:19 -0700 (PDT)
Message-ID: <a7c371ffffa18f49702590147642ed248977224f.camel@gmail.com>
Subject: Re: [PATCH 8/8] iio: adc: ad9467: support digital interface
 calibration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Tue, 23 Apr 2024 09:32:19 +0200
In-Reply-To: <20240420163404.0fc01ed5@jic23-huawei>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	 <20240419-ad9467-new-features-v1-8-3e7628ff6d5e@analog.com>
	 <20240420163404.0fc01ed5@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-20 at 16:34 +0100, Jonathan Cameron wrote:
> On Fri, 19 Apr 2024 17:36:51 +0200
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > To make sure that we have the best timings on the serial data interface
> > we should calibrate it. This means going through the device supported
> > values and see for which ones we get a successful result. To do that, w=
e
> > use a prbs test pattern both in the IIO backend and in the frontend
> > devices. Then for each of the test points we see if there are any
> > errors. Note that the backend is responsible to look for those errors.
> >=20
> > As calibrating the interface also requires that the data format is disa=
bled
> > (the one thing being done in ad9467_setup()), ad9467_setup() was remove=
d
> > and configuring the data fomat is now part of the calibration process.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Trivial comments inline.
>=20
> Jonathan
>=20
> > ---
> > =C2=A0drivers/iio/adc/ad9467.c | 337 ++++++++++++++++++++++++++++++++++=
+++++++------
> > =C2=A01 file changed, 296 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > index 7db87ccc1ea4..44552dd6f4c6 100644
> > --- a/drivers/iio/adc/ad9467.c
> > +++ b/drivers/iio/adc/ad9467.c
> > @@ -4,6 +4,9 @@
> > =C2=A0 *
> > =C2=A0 * Copyright 2012-2020 Analog Devices Inc.
> > =C2=A0 */
> > +
> > +#include <linux/bitmap.h>
> > +#include <linux/bitops.h>
> > =C2=A0#include <linux/cleanup.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/mutex.h>
> > @@ -100,6 +103,8 @@
> > =C2=A0#define AD9467_DEF_OUTPUT_MODE		0x08
> > =C2=A0#define AD9467_REG_VREF_MASK		0x0F
> > =C2=A0
> > +#define AD9647_MAX_TEST_POINTS		32
> > +
> > =C2=A0struct ad9467_chip_info {
> > =C2=A0	const char		*name;
> > =C2=A0	unsigned int		id;
> > @@ -110,6 +115,8 @@ struct ad9467_chip_info {
> > =C2=A0	unsigned long		max_rate;
> > =C2=A0	unsigned int		default_output_mode;
> > =C2=A0	unsigned int		vref_mask;
> > +	unsigned int		num_lanes;
> > +	bool			has_dco;
>=20
> What is dco?=C2=A0 Perhaps a comment, or expand the naming somewhat.
>=20

data clock output.. will add a comment

> > =C2=A0};
>=20
> > =C2=A0
> > +static void ad9467_dump_table(const unsigned long *err_map, unsigned i=
nt size,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool invert)
> > +{
> > +#ifdef DEBUG
> > +	unsigned int bit;
> > +
> > +	pr_debug("Dump calibration table:\n");
>=20
> If it's useful, poke it in debugfs, otherwise, drop this code.

From our experience, it's useful to dump the table in the tuning process. B=
ut I guess
I can also just save the bitmap and dump it on demand (on debugfs).

>=20
> > +	for (bit =3D 0; bit < size; bit++) {
> > +		if (bit =3D=3D size / 2) {
> > +			if (!invert)
> > +				break;
> > +			pr_cont("\n");
> > +		}
> > +
> > +		pr_cont("%c", test_bit(bit, err_map) ? 'x' : 'o');
> > +	}
> > +#endif
> > +}
> > +
>=20
> > +static int ad9467_calibrate_apply(const struct ad9467_state *st,
> > +				=C2=A0 unsigned int val)
> > +{
> > +	unsigned int lane;
> > +	int ret;
> > +
> > +	if (st->info->has_dco) {
> > +		int ret;
> Shadowing ret above.
>=20

ups...

> > +
> > +		ret =3D ad9467_spi_write(st->spi, AN877_ADC_REG_OUTPUT_DELAY,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
> > +					AN877_ADC_TRANSFER_SYNC);
> > +	}
> > +
> > +	for (lane =3D 0; lane < st->info->num_lanes; lane++) {
> > +		ret =3D iio_backend_iodelay_set(st->back, lane, val);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> > +
> > +static int ad9467_calibrate(const struct ad9467_state *st)
>=20
> Some docs on the sequence or a reference would be good.

I can point into the datasheets..

- Nuno S=C3=A1


