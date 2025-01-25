Return-Path: <linux-iio+bounces-14579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF9EA1C3CF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3763A6779
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B2B22612;
	Sat, 25 Jan 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7xBWSom"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C2B673;
	Sat, 25 Jan 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737816330; cv=none; b=W3tSUjUZIHhhyjzc+slX/FaVo6N9qwHDdK4pWyLhrxMhMpDgBlIAAW6OJH6jA/ZtXCRRJy1ScKZyDXPpAQAcB1b5iYFRXBecgYQdhKYOGtYe35UUpLNX2mnMdkSkt7GyhiQcnWyts2+2pkZAZSs93REHTGeaJVhKn3X+k3nPEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737816330; c=relaxed/simple;
	bh=A1M+b7fl1aFY1u4SPA4AC80OuWd11IBx2v48vUrGqXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGDjneKW3115nLKgE0A1OnS0hc99q10qM2ARWnfS6tkoGr5bJ7q+TGtUfUE+4Rsmv1dTm0xmQ5nrkw//Yk4WNeMwSAFPcrNrqNJBC2FmIZKvsZpNlZm2hlaoYV1czdl1lJqptqRn/a092KGG3Ob8iUZOiaedG2uBzr9TLpeM4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7xBWSom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B648C4CED6;
	Sat, 25 Jan 2025 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737816329;
	bh=A1M+b7fl1aFY1u4SPA4AC80OuWd11IBx2v48vUrGqXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T7xBWSom9BOxnGSW4vAiZMWZaUH8GTE+iFPYgoG/gPKG2UmAKKanLtjptQW6lt6Us
	 lPMt8EyrTtvNVZu+zwXjKksAOfuftDEVQr/PQrEELINeUhj3NUmG9mlzCM8zrJaP4E
	 hTVhy8Cg8VB7lkC2HnJet3Qlg/p3nQz/8u4xMIZXGoNIsOCpI0DnVJx94Po3cFenNw
	 zkrFVBk6RlSrWfet5CysvjHWxJGYvNSu/MJ75m/WDtH1QAyWKKkWii9tcGF90ea1Yr
	 UF/f7DCNHFgA255QRC0OSIlD5JINeJyZPhuf/k8XO9Ma+6aa3tlNYt/mOXTFK6J/2s
	 ArZylr+8Zb6sA==
Date: Sat, 25 Jan 2025 14:45:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Guillaume Ranquet <granquet@baylibre.com>, Lars-Peter Clausen 
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ad7173: add openwire detection support
 for single conversions
Message-ID: <20250125144522.60a9d4e4@jic23-huawei>
In-Reply-To: <105894947f288f0b877f69d58e5d9b4a095e6e2b.camel@gmail.com>
References: <20250120-ad4111_openwire-v4-0-e647835dbe62@baylibre.com>
	<20250120-ad4111_openwire-v4-2-e647835dbe62@baylibre.com>
	<105894947f288f0b877f69d58e5d9b4a095e6e2b.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jan 2025 17:07:24 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-01-20 at 15:10 +0100, Guillaume Ranquet wrote:
> > Some chips of the ad7173 family supports open wire detection.
> >=20
> > Generate a level fault event whenever an external source is disconnected
> > from the system input on single conversions.
> >=20
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > --- =20
>=20
> LGTM... Just one small nit. In any case:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/adc/ad7173.c | 166
> > +++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A01 file changed, 166 insertions(+)
> >=20
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index
> > 11ff148cb5a315d32485acf04b8d6f7d0fb6e5fa..a2ea8f7ae8e61f1f3cdfba795551d=
e2db96b
> > 8d60 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -35,6 +35,7 @@
> > =C2=A0#include <linux/units.h>
> > =C2=A0
> > =C2=A0#include <linux/iio/buffer.h>
> > +#include <linux/iio/events.h>
> > =C2=A0#include <linux/iio/iio.h>
> > =C2=A0#include <linux/iio/trigger_consumer.h>
> > =C2=A0#include <linux/iio/triggered_buffer.h>
> > @@ -102,6 +103,7 @@
> > =C2=A0
> > =C2=A0#define AD7173_GPIO_PDSW	BIT(14)
> > =C2=A0#define AD7173_GPIO_OP_EN2_3	BIT(13)
> > +#define AD4111_GPIO_GP_OW_EN	BIT(12)
> > =C2=A0#define AD7173_GPIO_MUX_IO	BIT(12)
> > =C2=A0#define AD7173_GPIO_SYNC_EN	BIT(11)
> > =C2=A0#define AD7173_GPIO_ERR_EN	BIT(10)
> > @@ -149,6 +151,7 @@
> >  =20
>=20
> ...
>=20
> >=20
> > +
> > =C2=A0static int ad7173_fw_parse_channel_config(struct iio_dev *indio_d=
ev)
> > =C2=A0{
> > =C2=A0	struct ad7173_channel *chans_st_arr, *chan_st_priv;
> > @@ -1375,6 +1528,7 @@ static int ad7173_fw_parse_channel_config(struct =
iio_dev
> > *indio_dev)
> > =C2=A0		chan_st_priv->cfg.bipolar =3D false;
> > =C2=A0		chan_st_priv->cfg.input_buf =3D st->info->has_input_buf;
> > =C2=A0		chan_st_priv->cfg.ref_sel =3D AD7173_SETUP_REF_SEL_INT_REF;
> > +		chan_st_priv->cfg.openwire_comp_chan =3D -1;
> > =C2=A0		st->adc_mode |=3D AD7173_ADC_MODE_REF_EN;
> > =C2=A0		if (st->info->data_reg_only_16bit)
> > =C2=A0			chan_arr[chan_index].scan_type =3D ad4113_scan_type;
> > @@ -1442,6 +1596,7 @@ static int ad7173_fw_parse_channel_config(struct =
iio_dev
> > *indio_dev)
> > =C2=A0		chan_st_priv->chan_reg =3D chan_index;
> > =C2=A0		chan_st_priv->cfg.input_buf =3D st->info->has_input_buf;
> > =C2=A0		chan_st_priv->cfg.odr =3D 0;
> > +		chan_st_priv->cfg.openwire_comp_chan =3D -1;
> > =C2=A0
> > =C2=A0		chan_st_priv->cfg.bipolar =3D fwnode_property_read_bool(child,
> > "bipolar");
> > =C2=A0		if (chan_st_priv->cfg.bipolar)
> > @@ -1456,6 +1611,17 @@ static int ad7173_fw_parse_channel_config(struct
> > iio_dev *indio_dev)
> > =C2=A0			chan_st_priv->cfg.input_buf =3D st->info- =20
> > >has_input_buf; =20
> > =C2=A0			chan->channel2 =3D ain[1];
> > =C2=A0			chan_st_priv->ain =3D AD7173_CH_ADDRESS(ain[0],
> > ain[1]);
> > +			if (st->info->has_openwire_det &&
> > +			=C2=A0=C2=A0=C2=A0 ad7173_validate_openwire_ain_inputs(st, chan- =20
> > >differential, ain[0], ain[1])) { =20
> > +				chan->event_spec =3D ad4111_events;
> > +				chan->num_event_specs =3D
> > ARRAY_SIZE(ad4111_events);
> > +				chan_st_priv->cfg.openwire_thrsh_raw =3D
> > +					BIT(chan->scan_type.realbits -
> > !!(chan_st_priv->cfg.bipolar))
> > +					* AD4111_OW_DET_THRSH_MV
> > +					/ ad7173_get_ref_voltage_milli(st,
> > chan_st_priv->cfg.ref_sel);
> > +				if (chan->channel < st->info- =20
> > >num_voltage_in_div) =20
> > +					chan_st_priv->cfg.openwire_thrsh_raw
> > /=3D AD4111_DIVIDER_RATIO;
> > +			} =20
>=20
> If you need to send another version for some reason, might be worth it to
> implement a simple helper for the above to improve code readability.
>=20
> Maybe is just me but that 'chan_st_priv->cfg.openwire_thrsh_raw =3D' is f=
airly
> unreadable :)
>=20
This crossed with a set from David and doesn't apply. Please rebase on top
of my testing branch.  Thanks! If the helper function Nuno suggests makes
sense to you feel free to do that as well.

The two patches I have on this driver that aren't upstream yet are:
iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct=20
iio: adc: ad7173: move fwnode_irq_get_byname() call site

Jonathan
> - Nuno S=C3=A1
> >  =20


