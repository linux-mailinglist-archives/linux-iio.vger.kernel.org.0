Return-Path: <linux-iio+bounces-4587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D58B4C7C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8E5281B68
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DCF71742;
	Sun, 28 Apr 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArPysbPP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8EB1C2D;
	Sun, 28 Apr 2024 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714319404; cv=none; b=T3wSuc4h5HTrW0lhDo/5cAWZMy/AerXm+uwO6bLocgbNn9gPK4NIt9wicM+zxWRnD1JDTwIm1CQ1PyWuWAk4tdr3Tkfx03pdx6GntOoT0YuxEJVu3fQ5MWhBFd6JWfahQFGa+STDMhKw9186BmphRwbjy8RWQTXodsp1e0OWuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714319404; c=relaxed/simple;
	bh=0i965WhP3Zw9TRmuj4XwhllpfgYYpfX6cq64tiEy6Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PocEiK8hnNzdHh86f/ct2ccxKrWuPswDdaGPCeNpDZ4HVUyY1zF5c4o7vXAiun7TqCRsF83mQCL/lxRRw6C1DeQl6zImyJQe9X63SajY7lYVrCzjpEoafyTqMQ57cvfxGmj6uN8km9sLDwibEJosY78ELyO+XQRWm84udNwHpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArPysbPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96DEC113CC;
	Sun, 28 Apr 2024 15:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714319403;
	bh=0i965WhP3Zw9TRmuj4XwhllpfgYYpfX6cq64tiEy6Y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ArPysbPPyL8Ja6/T//zwC5LSynv5DfuLxTtIIG8kwHivaRtJ38KwXIBFpnwuv1FxQ
	 ldRpEYOKeXMG+WCqOu1jo1kf2vMhUAt+ZtLawyipnR9n5WmhGNft+EzWb61xpQYZht
	 0pBfCcjwnvker/sACKuDdxC6nG/Szr0/pWUcEBqfhnFnRoHQjfpCDDnS0maCxiWEcY
	 wJUTEsv/f6Evz0pm0DefhUez7mTeSbRvm6mMnvvVtqqpxSQyePKIgqt8/2UPffszPC
	 bMSCqqnrCOCrWfJCgu+vYJhQTMRBJE7E1TtpzzleBFgN99EJZYif/aKVNcQCRx0Tm4
	 9Xhp3H+W1sZxA==
Date: Sun, 28 Apr 2024 16:49:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa via B4 Relay  <devnull+nuno.sa.analog.com@kernel.org>,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 6/8] iio: adc: adi-axi-adc: support digital interface
 calibration
Message-ID: <20240428164951.0651845e@jic23-huawei>
In-Reply-To: <96d226df0670cdfc307aacb196bea13e1ad644ad.camel@gmail.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-6-3e7628ff6d5e@analog.com>
	<20240420161308.67018515@jic23-huawei>
	<96d226df0670cdfc307aacb196bea13e1ad644ad.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 09:27:26 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-04-20 at 16:13 +0100, Jonathan Cameron wrote:
> > On Fri, 19 Apr 2024 17:36:49 +0200
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Implement the new IIO backend APIs for calibrating the data
> > > digital interfaces.
> > >=20
> > > While at it, removed the tabs in 'struct adi_axi_adc_state' and used
> > > spaces for the members. =20
> >=20
> > Ideally a precursor patch, but meh, it's 2 lines so I'll just moan about
> > it and move on.
> >=20
> > A few minor things inline.
> >=20
> >  =20
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/adi-axi-adc.c | 113 +++++++++++++++++++++++++++=
++++++++++++++-
> > > =C2=A01 file changed, 111 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-=
adc.c
> > > index b312369b7366..d58fa05499c4 100644
> > > --- a/drivers/iio/adc/adi-axi-adc.c
> > > +++ b/drivers/iio/adc/adi-axi-adc.c
> > > @@ -7,11 +7,13 @@
> > > =C2=A0 */
> > > =C2=A0
> > > =C2=A0#include <linux/bitfield.h>
> > > +#include <linux/cleanup.h>
> > > =C2=A0#include <linux/clk.h>
> > > =C2=A0#include <linux/err.h>
> > > =C2=A0#include <linux/io.h>
> > > =C2=A0#include <linux/delay.h>
> > > =C2=A0#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > =C2=A0#include <linux/of.h>
> > > =C2=A0#include <linux/platform_device.h>
> > > =C2=A0#include <linux/property.h>
> > > @@ -37,6 +39,9 @@
> > > =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_RSTN_MMCM_RSTN		BIT(1)
> > > =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_RSTN_RSTN			BIT(0)
> > > =C2=A0
> > > +#define ADI_AXI_ADC_REG_CTRL			0x0044
> > > +#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> > > +
> > > =C2=A0/* ADC Channel controls */
> > > =C2=A0
> > > =C2=A0#define ADI_AXI_REG_CHAN_CTRL(c)		(0x0400 + (c) * 0x40)
> > > @@ -51,14 +56,28 @@
> > > =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL_PN_TYPE_OWR	BIT(1)
> > > =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL_ENABLE		BIT(0)
> > > =C2=A0
> > > +#define ADI_AXI_ADC_REG_CHAN_STATUS(c)		(0x0404 + (c) * 0x40)
> > > +#define=C2=A0=C2=A0 ADI_AXI_ADC_CHAN_STAT_PN_MASK		GENMASK(2, 1)
> > > +
> > > +#define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
> > > +#define=C2=A0=C2=A0 ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
> > > +
> > > +/* IO Delays */
> > > +#define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
> > > +#define=C2=A0=C2=A0 AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
> > > +
> > > +#define ADI_AXI_ADC_MAX_IO_NUM_LANES		15
> > > +
> > > =C2=A0#define ADI_AXI_REG_CHAN_CTRL_DEFAULTS		\
> > > =C2=A0	(ADI_AXI_REG_CHAN_CTRL_FMT_SIGNEXT |	\
> > > =C2=A0	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
> > > =C2=A0	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
> > > =C2=A0
> > > =C2=A0struct adi_axi_adc_state {
> > > -	struct regmap				*regmap;
> > > -	struct device				*dev;
> > > +	struct regmap *regmap;
> > > +	struct device *dev;
> > > +	/* lock to protect multiple accesses to the device registers */ =20
> >=20
> > Why?=C2=A0 The locking in regmap protects register accesses in general =
I believe.
> > I guess this is to prevent accesses during that error detection routine?
> > Needs more detail in the comment. =20
>=20
> Yes, but if you have, for example, two regmap_*() calls in a row you won'=
t have the
> complete access protected as regmap only internally protects each call.=
=C2=A0And often,
> trying to argue which of these multiple accesses are safe or not is very =
subtle and
> prone to issues. That's why I used the "multiple accesses" wording.

Ah.  You meant protecting a sequence of multiple accesses. I was thinking '=
against'
multiple simultaneous accesses.  I'm fine with your intended meaning. Perha=
ps
we just need to refer to sequences of access or something like that.

>=20
> As you pointed out, the error detection routine should indeed be atomic. =
On the
> iodelay_set() we also have a read after write and this is one of those ca=
ses I'm not
> sure we could actually have an issue if we have concurrent calls (maybe n=
ot), But for
> correctness, it definitely makes sense for it to be atomic (as we should =
check we
> could set the value we just wrote and not something else).
>=20
> Also, on a second look, the enable/disable() routines should also be prot=
ected (for
> correctness). If we think on the theoretical (in practice it should not h=
appen :))
> case of concurrent enable/disable() calls, we should not be able to disab=
le the core
> in the middle of enabling (either before or after).

Protection makes sense, I was just moaning about the meaning of the comment=
 :)

Jonathan


