Return-Path: <linux-iio+bounces-4452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF28ADE36
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 09:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662DF1C21B21
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8B4653A;
	Tue, 23 Apr 2024 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWqnXfh5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC728689;
	Tue, 23 Apr 2024 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857251; cv=none; b=rg7k0/nJ4rOvADZR3lWOOITgxhrBi1+TqEQCpY84mkSP60/6t3KYbiWNq2ml+XW6R3qnEn0zy+CWTmBRbTWpDKyk4JjeUL83bzCIX+gfvKklNHEQh1mywZUxLKrYxiD4Y3+5dqBtnDpEk1obrj9aRH+xEKnH+Q91xUxto3GHKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857251; c=relaxed/simple;
	bh=AHpSLIXDH4msrR6dP/n4IRGTVBGT7Tcb7dFCy+W5iJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VljCiaHR7nWjcO/8ycjPMadZ+u4LrwldRQ6UGlIywzTgDs21hR3aw01EMBU+snnMBUXdssF58ZUZs3CkkfWdB6/dg668P3SmQ6/ON9QYCY1ec8rItAsAhh4gUO41/HYkRaY8R0wYIky2eR/BtT0naPw+vCP+Whe0Tm/g7NWrEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWqnXfh5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4187c47405aso35695335e9.3;
        Tue, 23 Apr 2024 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713857248; x=1714462048; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5QEZWvjglfoxgdLaLh4W5vTyCc9a/E2VrZnD+A3Js6U=;
        b=FWqnXfh5+G183SoEcvWc+Ti/stC94lrzr3IPVbzy/Lk/jzB3AtiiyG543B+42erj0f
         +97tKGyPavkyqXt27knCgI+yYZzmNn13eCNyy+yt0I0OqRYXHpXl2g87q8DjECf/vGgU
         uaxRM73MlJJK1An+S3UfnKT7rEU/Q/o2D50PrcEaUUHoigxQXb5ycvf1krEUApS0jsmd
         W+HQj6tMu6F7YuQSFS1CkVr7TWFu8U+xk6HI7yn+VLyhoWtL+1Otsq0s1m6ryTbQ/Xno
         cTnlcw6oa9Q+Tglm0uPuKQo+X+LC7lJFHBw50j/CAD1EtmwRkvyjyPUdMiKbhIl/phby
         K3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713857248; x=1714462048;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QEZWvjglfoxgdLaLh4W5vTyCc9a/E2VrZnD+A3Js6U=;
        b=DhTr61y2JwoiRir1zLEbRiUtwZ326zwuOpJooiXzxV6OTCHlmDUWGkGrCfCgLZ9fc9
         meqFNAoO07ovzPaOR49awwAXZ1xm9wky7I5K3TyVdhujwlp1E8SJxHUwnay39+gI2C98
         cRRuhThLJipoe15wff+nse4HV86mHtdSWdx2SethMOhojQsgoMZwIoY7p/UBPrqR0ZsJ
         E9vcX2H7QjcTyiCkwAK1LE8Bwj3MK8nHS/EETZRP756WcUDpJZxRJHFC3CUgok2UT5DG
         a0+vY4QbU301VzPh8C+er8RpsKG8wJ3a8lqm6+izxx9K3LtJ35C0CqNZTW2Bj8rRcNde
         fevg==
X-Forwarded-Encrypted: i=1; AJvYcCVqM3F9WSuQ89AFfowtAxAn+7InZ5vXWYvIeS5DB/8ocmU7bj6NtQNoZsT/UxLCxs5rE0ZCEbUPUAKHFWtjBcsLfT4IVJCNMPpZQGt1Vk3AlIjnb2NahbuZlNhvvK2rN63axYjatA==
X-Gm-Message-State: AOJu0YzWCFy1zS+NtZ7hdg5smSNiGN6X6c55fokEbisFqZ84TwKjRHw3
	CXHtNANa6MH0yi133MQ5IT4oFQ8NMA5Lze55EaxUmjPqB1yD/E52
X-Google-Smtp-Source: AGHT+IHqawZgpmlhFauHlQASnH7VbMDlV8+5zvbiZfK9o/LFNdCMLIVvtu3x63lDyyYJ1SkXSTLiow==
X-Received: by 2002:a05:600c:45ce:b0:41a:b110:27c2 with SMTP id s14-20020a05600c45ce00b0041ab11027c2mr692159wmo.19.1713857247732;
        Tue, 23 Apr 2024 00:27:27 -0700 (PDT)
Received: from ?IPv6:2001:a61:3481:2201:6106:96db:d27b:d2c2? ([2001:a61:3481:2201:6106:96db:d27b:d2c2])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b00418db9e4228sm19255071wmg.29.2024.04.23.00.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:27:27 -0700 (PDT)
Message-ID: <96d226df0670cdfc307aacb196bea13e1ad644ad.camel@gmail.com>
Subject: Re: [PATCH 6/8] iio: adc: adi-axi-adc: support digital interface
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
Date: Tue, 23 Apr 2024 09:27:26 +0200
In-Reply-To: <20240420161308.67018515@jic23-huawei>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	 <20240419-ad9467-new-features-v1-6-3e7628ff6d5e@analog.com>
	 <20240420161308.67018515@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-20 at 16:13 +0100, Jonathan Cameron wrote:
> On Fri, 19 Apr 2024 17:36:49 +0200
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Implement the new IIO backend APIs for calibrating the data
> > digital interfaces.
> >=20
> > While at it, removed the tabs in 'struct adi_axi_adc_state' and used
> > spaces for the members.
>=20
> Ideally a precursor patch, but meh, it's 2 lines so I'll just moan about
> it and move on.
>=20
> A few minor things inline.
>=20
>=20
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/adi-axi-adc.c | 113 +++++++++++++++++++++++++++++=
++++++++++++-
> > =C2=A01 file changed, 111 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-ad=
c.c
> > index b312369b7366..d58fa05499c4 100644
> > --- a/drivers/iio/adc/adi-axi-adc.c
> > +++ b/drivers/iio/adc/adi-axi-adc.c
> > @@ -7,11 +7,13 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/clk.h>
> > =C2=A0#include <linux/err.h>
> > =C2=A0#include <linux/io.h>
> > =C2=A0#include <linux/delay.h>
> > =C2=A0#include <linux/module.h>
> > +#include <linux/mutex.h>
> > =C2=A0#include <linux/of.h>
> > =C2=A0#include <linux/platform_device.h>
> > =C2=A0#include <linux/property.h>
> > @@ -37,6 +39,9 @@
> > =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_RSTN_MMCM_RSTN		BIT(1)
> > =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_RSTN_RSTN			BIT(0)
> > =C2=A0
> > +#define ADI_AXI_ADC_REG_CTRL			0x0044
> > +#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> > +
> > =C2=A0/* ADC Channel controls */
> > =C2=A0
> > =C2=A0#define ADI_AXI_REG_CHAN_CTRL(c)		(0x0400 + (c) * 0x40)
> > @@ -51,14 +56,28 @@
> > =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL_PN_TYPE_OWR	BIT(1)
> > =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL_ENABLE		BIT(0)
> > =C2=A0
> > +#define ADI_AXI_ADC_REG_CHAN_STATUS(c)		(0x0404 + (c) * 0x40)
> > +#define=C2=A0=C2=A0 ADI_AXI_ADC_CHAN_STAT_PN_MASK		GENMASK(2, 1)
> > +
> > +#define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
> > +#define=C2=A0=C2=A0 ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
> > +
> > +/* IO Delays */
> > +#define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
> > +#define=C2=A0=C2=A0 AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
> > +
> > +#define ADI_AXI_ADC_MAX_IO_NUM_LANES		15
> > +
> > =C2=A0#define ADI_AXI_REG_CHAN_CTRL_DEFAULTS		\
> > =C2=A0	(ADI_AXI_REG_CHAN_CTRL_FMT_SIGNEXT |	\
> > =C2=A0	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
> > =C2=A0	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
> > =C2=A0
> > =C2=A0struct adi_axi_adc_state {
> > -	struct regmap				*regmap;
> > -	struct device				*dev;
> > +	struct regmap *regmap;
> > +	struct device *dev;
> > +	/* lock to protect multiple accesses to the device registers */
>=20
> Why?=C2=A0 The locking in regmap protects register accesses in general I =
believe.
> I guess this is to prevent accesses during that error detection routine?
> Needs more detail in the comment.

Yes, but if you have, for example, two regmap_*() calls in a row you won't =
have the
complete access protected as regmap only internally protects each call.=C2=
=A0And often,
trying to argue which of these multiple accesses are safe or not is very su=
btle and
prone to issues. That's why I used the "multiple accesses" wording.

As you pointed out, the error detection routine should indeed be atomic. On=
 the
iodelay_set() we also have a read after write and this is one of those case=
s I'm not
sure we could actually have an issue if we have concurrent calls (maybe not=
), But for
correctness, it definitely makes sense for it to be atomic (as we should ch=
eck we
could set the value we just wrote and not something else).

Also, on a second look, the enable/disable() routines should also be protec=
ted (for
correctness). If we think on the theoretical (in practice it should not hap=
pen :))
case of concurrent enable/disable() calls, we should not be able to disable=
 the core
in the middle of enabling (either before or after).

>=20
> > +	struct mutex lock;
> > =C2=A0};
> > =C2=A0
> > =C2=A0static int axi_adc_enable(struct iio_backend *back)
> > @@ -104,6 +123,92 @@ static int axi_adc_data_format_set(struct iio_back=
end *back,
> > unsigned int chan,
> > =C2=A0				=C2=A0 ADI_AXI_REG_CHAN_CTRL_FMT_MASK, val);
> > =C2=A0}
> > =C2=A0
> > +static int axi_adc_data_sample_trigger(struct iio_backend *back,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_sample_trigg=
er trigger)
> > +{
> > +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> > +
> > +	if (trigger =3D=3D IIO_BACKEND_SAMPLE_TRIGGER_EDGE_RISING)
>=20
> It's an enum, so can't have more than one. Hence switch statement is prob=
ably
> more extensible and natural to read.

alright..

>=20
> > +		return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> > +					 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK);
> > +	if (trigger =3D=3D IIO_BACKEND_SAMPLE_TRIGGER_EDGE_FALLING)
> > +		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_=
MASK);
> > +
> > +	return -EINVAL;
> > +}
> > +
>=20
>=20
> > +static int axi_adc_chan_status(struct iio_backend *back, unsigned int =
chan,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_backend_chan_status=
 *status)
> > +{
> > +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> > +	int ret;
> > +	u32 val;
> > +
> > +	guard(mutex)(&st->lock);
> > +	/* reset test bits by setting them */
> > +	ret =3D regmap_write(st->regmap, ADI_AXI_ADC_REG_CHAN_STATUS(chan),
> > +			=C2=A0=C2=A0 ADI_AXI_ADC_CHAN_STAT_PN_MASK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	fsleep(1000);
> Why this particular length sleep?=C2=A0 Is this a case of let it sit a wh=
ile an dsee
> if an error shows up?=C2=A0 If so a comment on that would be good.

Exactly, will add a comment.

- Nuno S=C3=A1
>=20

