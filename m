Return-Path: <linux-iio+bounces-24251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B241B84911
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 14:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA263AE883
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303EC2FB98A;
	Thu, 18 Sep 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtPcppEb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800334BA28
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198274; cv=none; b=AH5f+9udD/pZ9/SWUxeffWo/sgpCRGDTIEWAz6n5FCyqBiVDC0yksKdYFe4iiGEiy9rDnmZxyUdT0Kth4+6El+WKOt6Rd7mvqU756zqhyRHYQEdNATv5X9cSsLZJI2vIqmcmTuzAl8tvg7TsXfIoFOkWUH/umJrnDROme7GufvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198274; c=relaxed/simple;
	bh=697Uw7mOSlCRsVPhg/h2/lghB/aOWtn+52weU3HXt5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJ8PEXfUTjonGcHl5tcWpKlpr34QiKhkAjMGDKzOzDJOuV9EGONbX2FlhS3Hii42tSYGWms0phWdFCc3cNDLWjdOE16xpk5v6o0OO5TXERwaxNis6z/M2OVoQG7Xz9yhH1eZoevwHXXSItgER9ajVc4X1WKxqPc+0Oipj6VjDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtPcppEb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d44d734cabso577593f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758198270; x=1758803070; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IXB7fx7tFoWEdwPvBo5NLvLq0Tw66UYI7AgnjzaUJgQ=;
        b=CtPcppEbCmJKCikDpNnOtWGJL3dY4+BOBKigJNTR7OoJa6Wc/v2PuI5FJgEoRQZtQ1
         ze5bvyQ2+bACa/b63s91kMCwK4To1LwcPOPzBleEYtmr+6AUjMrzQDLy9tTQONkr/oOz
         //qJX4DbeF6Hew4kKW7RZ6FWcaIlknUWaqkrbOlprqWLyoAvAkjWK/s4KHB1w00IT7kD
         iSyiyuiWqaXpdMmHB94TrhfGKtfvQBuHbhV6JoWPbsWrqg0dhj0nTtdOIz/DO5Pofef/
         DIW/wkFFYjizNzedcDZXuJeDqxdtiOWicAVSnI5cXV2M7zY9HNg3oaC3vVOAIG12b4bg
         sQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198270; x=1758803070;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXB7fx7tFoWEdwPvBo5NLvLq0Tw66UYI7AgnjzaUJgQ=;
        b=gfsYGtRl/tlJupO9MJ8+FUY9VWOI+zthy9epeIwVlL+0dQxtv9VIWUWqTn+p9K4LfS
         p7WfrWKDGiUFsNtBUBncq9P759E4dUeLMVLh6IrM0E4bpiXZKStmNGUS+xkCN09GTtXw
         csd7p9c329U1nlyx17VJEvDk+4+zqHN3Ihjjk740icfDSxmjww77WJ4yg3rRySNL0VF9
         7aE7xspaEcPIRtt6R9FZ4kpkqYLLGSFa+affchXvzppdwEG+AZIDtl63+b+6R2J20uiH
         dKDwaGkMCLRPAnqRaWF8hnO4pozdhMed8JFsNYHVJfcQ7fLpLTHFd2IJgxXBv2aHPDkG
         1FVg==
X-Gm-Message-State: AOJu0YwtaGpsRrwagNmf6KiNGiN2GbWSlgBBGvOks75tW3lN96xOdDPn
	Lo71hReNTc+0YMs/Dhb0z6z5A1d8ijJD4XYw/du4tdr6wcUo2EqmJbTG
X-Gm-Gg: ASbGncvzb0hcAuc1yA6MInZ7iBHJD5wlz/QyZhU8Qf5JBMrX25kpUW0KLvOmv6HYHQE
	bcVXh1kuZMiLmPVFGDiqCur0W5/rEV9H8idJsnvYIKyAsrUdfv9lk9DhpjuybJ6qmv59XoMeppI
	PrN2rNPC7AOqZjQ+KXd7VErhfT3ANHeHwLLY0FhHq4mCqfHCI98ZUJTq8Vc/XllbAl3HhXwHhgm
	UqJmD1vesMBKSzwDDS1lh2HZH8Og667NQO2sfc19mGsiOvQaLUYs+DreM8wWlbSM9degOpCfPpN
	cgMhCxtHeYMaewGEu4IKlKM98/m14IL47ON63ce72wVnJFzGQiwRllsCUGVHKWT2WcZUQKNSkxF
	BHo+vYQBArzNF+YgeIyoE5fcfexRgex7/Fwmi+9Ujmw==
X-Google-Smtp-Source: AGHT+IGWogvdtxut2/ffBI9FSP6NrjoGT8rMn4SOoj7b3bDWkvIPqJJ4rnwOm3y15NCo8+37DszOxQ==
X-Received: by 2002:a05:6000:2881:b0:3eb:dcf:bfad with SMTP id ffacd0b85a97d-3ecdfa07585mr5561912f8f.34.1758198269316;
        Thu, 18 Sep 2025 05:24:29 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm61959645e9.3.2025.09.18.05.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:24:28 -0700 (PDT)
Message-ID: <c0a22d97282f71b2fb946f877e23d410d485d1be.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: change setup reg allocation strategy
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Sep 2025 13:24:55 +0100
In-Reply-To: <20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com>
References: 
	<20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 17:05 -0500, David Lechner wrote:
> Change the allocation strategy of the 8 SETUP registers from a least-
> recently-used (LRU) to a first-come-first-served basis.
>=20
> The AD7124 chips can have up to 16 channels enabled at a time in the
> sequencer for buffered reads, but only have 8 SETUP configurations
> (namely the OFFSET, GAIN, CONFIG and FILTER registers) that must be
> shared among the 16 channels.=C2=A0 This means some of the channels must =
use
> the exact same configuration parameters so that they can share a single
> SETUP group of registers.=C2=A0 The previous LRU strategy did not keep tr=
ack
> of how many different configurations were requested at the same time,
> so if there were more than 8 different configurations requested, some
> channels would end up using the incorrect configuration because the slot
> assigned to them would also be assigned to a different configuration
> that wrote over it later.
>=20

Ouch! That's subtle...

> Adding such tracking to solve this would make an already complex
> algorithm even more complex.=C2=A0 Instead we can replace it with a simpl=
er
> first-come-first-serve strategy.=C2=A0 This makes it easy to track how ma=
ny
> different configurations are being requested at the same time.=C2=A0 This
> comes at the expense of slightly longer setup times for buffered reads
> since all setup registers must be written each time when a buffered read
> is enabled.=C2=A0 But this is generally not considered a hot path where
> performance is critical, so should be acceptable.
>=20

Agreed!

> This new strategy also makes hardware debugging easier since SETUPs are
> now assigned in a deterministic manner and in a logical order.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This is something I wish I would have noticed earlier. This is
> addressing the same issue we saw recently in the ad7173 driver [1].
>=20
> However, since we have added a bunch of new features to the ad7124
> driver recently, it seems too late to make a change like the one in the
> link that can be easily backported. So I didn't bother with a Fixes: tag
> here. Given how many other broken things we found in ad7124 recently,
> I'm not too worried about rushing out a fix for backporting anyway.
>=20
> Instead, I implemented the idea I first proposed in [2]. I find it much
> easier to follow and reason about than the LRU implementation. And while
> working on other features, I found the LRU implementation to be annoying
> because I never knew which setup registers would be assigned to which
> channels after tweaking the channel configuration. This made debugging
> more tedious than it could have been. So this seems like an overall
> improvement to me.

Agreed! I feel there was no special reason for the LRU algo. Perhaps just
over-engineering :)

Anyways, I agree with the whole change. I guess this introduces a change in
behavior for userspace (so ABI change) but given it's actually fixing a bug=
...

Some minor notes below

>=20
> B4 is picking up all of the recent patches to the ad7124 driver as
> dependencies, but really the only one that is actually needed for this
> to apply cleanly is the "iio: adc: ad7124: drop nr field" series.
>=20
> [1]:
> https://lore.kernel.org/linux-iio/20250722-iio-adc-ad7173-fix-setup-use-l=
imits-v2-1-8e96bdb72a9c@baylibre.com/
> [2]:
> https://lore.kernel.org/linux-iio/bcf599e1-7816-4580-a2f9-039b0d3c0c99@ba=
ylibre.com/
> ---
> =C2=A0drivers/iio/adc/ad7124.c | 246 ++++++++++++++++++++++--------------=
----------
> -
> =C2=A01 file changed, 114 insertions(+), 132 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index
> 540bd80359763bc94934160e3388621bfe5ba9a1..7be524cba18400988086a34eb581df3=
ecdec
> 0fb2 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -110,6 +110,8 @@
> =C2=A0#define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
> =C2=A0#define AD7124_FILTER_FS		GENMASK(10, 0)
> =C2=A0
> +#define AD7124_CFG_SLOT_UNASSIGNED	~0U
> +
> =C2=A0#define AD7124_MAX_CONFIGS	8
> =C2=A0#define AD7124_MAX_CHANNELS	16
> =C2=A0
> @@ -175,14 +177,13 @@ enum ad7124_filter_type {
> =C2=A0};
> =C2=A0
> =C2=A0struct ad7124_channel_config {
> -	bool live;
> =C2=A0	unsigned int cfg_slot;
> =C2=A0	unsigned int requested_odr;
> =C2=A0	unsigned int requested_odr_micro;
> =C2=A0	/*
> =C2=A0	 * Following fields are used to compare for equality. If you
> =C2=A0	 * make adaptations in it, you most likely also have to adapt
> -	 * ad7124_find_similar_live_cfg(), too.
> +	 * ad7124_config_equal(), too.
> =C2=A0	 */
> =C2=A0	struct_group(config_props,
> =C2=A0		enum ad7124_ref_sel refsel;
> @@ -214,14 +215,13 @@ struct ad7124_state {
> =C2=A0	unsigned int adc_control;
> =C2=A0	unsigned int num_channels;
> =C2=A0	struct mutex cfgs_lock; /* lock for configs access */
> -	unsigned long cfg_slots_status; /* bitmap with slot status (1 means
> it is used) */
> +	u8 cfg_slot_use_count[AD7124_MAX_CONFIGS];
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Stores the power-on reset value for the GAIN(x) registers which
> are
> =C2=A0	 * needed for measurements at gain 1 (i.e. CONFIG(x).PGA =3D=3D 0)
> =C2=A0	 */
> =C2=A0	unsigned int gain_default;
> -	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *,
> AD7124_MAX_CONFIGS);
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad7124_chip_info ad7124_4_chip_info =3D {
> @@ -365,9 +365,6 @@ static void ad7124_set_channel_odr(struct ad7124_stat=
e
> *st, unsigned int channel
> =C2=A0		=C2=A0 cfg->requested_odr_micro * factor / MICRO;
> =C2=A0	odr_sel_bits =3D clamp(DIV_ROUND_CLOSEST(fclk, divisor), 1, 2047);
> =C2=A0
> -	if (odr_sel_bits !=3D st->channels[channel].cfg.odr_sel_bits)
> -		st->channels[channel].cfg.live =3D false;
> -
> =C2=A0	st->channels[channel].cfg.odr_sel_bits =3D odr_sel_bits;
> =C2=A0}
> =C2=A0
> @@ -402,61 +399,6 @@ static int ad7124_get_3db_filter_factor(struct
> ad7124_state *st,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct
> ad7124_state *st,
> -								=C2=A0 struct
> ad7124_channel_config *cfg)
> -{
> -	struct ad7124_channel_config *cfg_aux;
> -	int i;
> -
> -	/*
> -	 * This is just to make sure that the comparison is adapted after
> -	 * struct ad7124_channel_config was changed.
> -	 */
> -	static_assert(sizeof_field(struct ad7124_channel_config,
> config_props) =3D=3D
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct {
> -				=C2=A0=C2=A0=C2=A0=C2=A0 enum ad7124_ref_sel refsel;
> -				=C2=A0=C2=A0=C2=A0=C2=A0 bool bipolar;
> -				=C2=A0=C2=A0=C2=A0=C2=A0 bool buf_positive;
> -				=C2=A0=C2=A0=C2=A0=C2=A0 bool buf_negative;
> -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int vref_mv;
> -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int pga_bits;
> -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr_sel_bits;
> -				=C2=A0=C2=A0=C2=A0=C2=A0 enum ad7124_filter_type filter_type;
> -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int calibration_offset;
> -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int calibration_gain;
> -			=C2=A0=C2=A0=C2=A0=C2=A0 }));
> -
> -	for (i =3D 0; i < st->num_channels; i++) {
> -		cfg_aux =3D &st->channels[i].cfg;
> -
> -		if (cfg_aux->live &&
> -		=C2=A0=C2=A0=C2=A0 cfg->refsel =3D=3D cfg_aux->refsel &&
> -		=C2=A0=C2=A0=C2=A0 cfg->bipolar =3D=3D cfg_aux->bipolar &&
> -		=C2=A0=C2=A0=C2=A0 cfg->buf_positive =3D=3D cfg_aux->buf_positive &&
> -		=C2=A0=C2=A0=C2=A0 cfg->buf_negative =3D=3D cfg_aux->buf_negative &&
> -		=C2=A0=C2=A0=C2=A0 cfg->vref_mv =3D=3D cfg_aux->vref_mv &&
> -		=C2=A0=C2=A0=C2=A0 cfg->pga_bits =3D=3D cfg_aux->pga_bits &&
> -		=C2=A0=C2=A0=C2=A0 cfg->odr_sel_bits =3D=3D cfg_aux->odr_sel_bits &&
> -		=C2=A0=C2=A0=C2=A0 cfg->filter_type =3D=3D cfg_aux->filter_type &&
> -		=C2=A0=C2=A0=C2=A0 cfg->calibration_offset =3D=3D cfg_aux->calibration=
_offset &&
> -		=C2=A0=C2=A0=C2=A0 cfg->calibration_gain =3D=3D cfg_aux->calibration_g=
ain)
> -			return cfg_aux;
> -	}
> -
> -	return NULL;
> -}
> -
> -static int ad7124_find_free_config_slot(struct ad7124_state *st)
> -{
> -	unsigned int free_cfg_slot;
> -
> -	free_cfg_slot =3D find_first_zero_bit(&st->cfg_slots_status,
> AD7124_MAX_CONFIGS);
> -	if (free_cfg_slot =3D=3D AD7124_MAX_CONFIGS)
> -		return -1;
> -
> -	return free_cfg_slot;
> -}
> -
> =C2=A0/* Only called during probe, so dev_err_probe() can be used */
> =C2=A0static int ad7124_init_config_vref(struct ad7124_state *st, struct
> ad7124_channel_config *cfg)
> =C2=A0{
> @@ -485,6 +427,21 @@ static int ad7124_init_config_vref(struct ad7124_sta=
te
> *st, struct ad7124_channe
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static bool ad7124_config_equal(struct ad7124_channel_config *a,
> +				struct ad7124_channel_config *b)
> +{
> +	return a->refsel =3D=3D b->refsel &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->bipolar =3D=3D b->bipolar &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->buf_positive =3D=3D b->buf_posi=
tive &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->buf_negative =3D=3D b->buf_nega=
tive &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->vref_mv =3D=3D b->vref_mv &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->pga_bits =3D=3D b->pga_bits &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->odr_sel_bits =3D=3D b->odr_sel_=
bits &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->filter_type =3D=3D b->filter_ty=
pe &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->calibration_offset =3D=3D b->ca=
libration_offset &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->calibration_gain =3D=3D b->cali=
bration_gain;
> +}

Why not keeping the static_assert()? IIRC, Uwe felt fairly strong about hav=
ing
it.

> +
> =C2=A0static int ad7124_write_config(struct ad7124_state *st, struct
> ad7124_channel_config *cfg,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int cfg_slot)
> =C2=A0{
> @@ -493,13 +450,13 @@ static int ad7124_write_config(struct ad7124_state =
*st,
> struct ad7124_channel_co
> =C2=A0	unsigned int post =3D 0;
> =C2=A0	int ret;
> =C2=A0
> -	cfg->cfg_slot =3D cfg_slot;
> -
> -	ret =3D ad_sd_write_reg(&st->sd, AD7124_OFFSET(cfg->cfg_slot), 3, cfg-
> >calibration_offset);
> +	ret =3D ad_sd_write_reg(&st->sd, AD7124_OFFSET(cfg_slot), 3,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg->calibration_offset);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D ad_sd_write_reg(&st->sd, AD7124_GAIN(cfg->cfg_slot), 3, cfg-
> >calibration_gain);
> +	ret =3D ad_sd_write_reg(&st->sd, AD7124_GAIN(cfg_slot), 3,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg->calibration_gain);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -509,7 +466,7 @@ static int ad7124_write_config(struct ad7124_state *s=
t,
> struct ad7124_channel_co
> =C2=A0		(cfg->buf_negative ? AD7124_CONFIG_AIN_BUFM : 0) |
> =C2=A0		FIELD_PREP(AD7124_CONFIG_PGA, cfg->pga_bits);
> =C2=A0
> -	ret =3D ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg->cfg_slot), 2, val);
> +	ret =3D ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg_slot), 2, val);
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> @@ -561,7 +518,7 @@ static int ad7124_write_config(struct ad7124_state *s=
t,
> struct ad7124_channel_co
> =C2=A0	 * would be 1 and we would get a faster sampling frequency than wh=
at
> =C2=A0	 * was requested.
> =C2=A0	 */
> -	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg->cfg_slot), 3,
> +	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg_slot), 3,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_FI=
LTER, filter) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_RE=
J60, rej60) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_PO=
ST_FILTER, post) |
> @@ -569,83 +526,101 @@ static int ad7124_write_config(struct ad7124_state=
 *st,
> struct ad7124_channel_co
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_FS=
, cfg-
> >odr_sel_bits));
> =C2=A0}
> =C2=A0
> -static struct ad7124_channel_config *ad7124_pop_config(struct ad7124_sta=
te
> *st)
> +/**
> + * ad7124_request_config_slot() - Request a config slot for a given conf=
ig
> + * @st:		Driver instance
> + * @channel:	Channel to request a slot for
> + *
> + * Tries to find a matching config already in use, otherwise finds a fre=
e
> + * slot. If this function returns successfully, the use count for the sl=
ot is
> + * increased and the slot number is stored in cfg->cfg_slot.
> + *
> + * The slot must be released again with ad7124_release_config_slot() whe=
n no
> + * longer needed.
> + *
> + * Returns: 0 if a slot was successfully assigned, -EUSERS if no slot is
> + * available or other error if SPI communication fails.
> + */
> +static int ad7124_request_config_slot(struct ad7124_state *st, u8 channe=
l)
> =C2=A0{
> -	struct ad7124_channel_config *lru_cfg;
> -	struct ad7124_channel_config *cfg;
> -	int ret;
> -	int i;
> +	unsigned int i, j;
> =C2=A0
> -	/*
> -	 * Pop least recently used config from the fifo
> -	 * in order to make room for the new one
> -	 */
> -	ret =3D kfifo_get(&st->live_cfgs_fifo, &lru_cfg);
> -	if (ret <=3D 0)
> -		return NULL;
> +	/* See if we already have a matching config. */
> +	for (i =3D 0; i < AD7124_MAX_CONFIGS; i++) {
> +		if (st->cfg_slot_use_count[i] =3D=3D 0)
> +			continue;
> =C2=A0
> -	lru_cfg->live =3D false;
> +		/* Find the first channel using this slot, if any. */
> +		for (j =3D 0; j < st->num_channels; j++) {
> +			if (st->channels[j].cfg.cfg_slot !=3D i)
> +				continue;
> =C2=A0
> -	/* mark slot as free */
> -	assign_bit(lru_cfg->cfg_slot, &st->cfg_slots_status, 0);
> +			/*
> +			 * If there is a match, increase the use count and
> share
> +			 * the slot with the requesting channel.
> +			 */
> +			if (ad7124_config_equal(&st->channels[j].cfg,
> +						&st->channels[channel].cfg))
> {
> +				st->cfg_slot_use_count[i]++;
> +				st->channels[channel].cfg.cfg_slot =3D i;
> =C2=A0
> -	/* invalidate all other configs that pointed to this one */
> -	for (i =3D 0; i < st->num_channels; i++) {
> -		cfg =3D &st->channels[i].cfg;
> +				dev_dbg(&st->sd.spi->dev,
> +					"Re-using config slot %u for channel
> %u, use count now %u\n",
> +					i, channel, st-
> >cfg_slot_use_count[i]);
> +
> +				return 0;
> +			}
> +		}
> +	}

I think we could have the above a bit simpler. Something like:

for (j =3D 0; j < st->num_channels; j++) {
	if (st->channels[j].cfg.cfg_slot =3D=3D AD7124_CFG_SLOT_UNASSIGNED)
		continue;
	if (!ad7124_config_equal(&st->channels[j].cfg,
	    &st->channels[channel].cfg))
		continue;
=09
	i =3D st->channels[j].cfg.cfg_slot;
	st->cfg_slot_use_count[i]++;
	st->channels[channel].cfg.cfg_slot =3D i;
}

Am I missing something?

> =C2=A0
> -		if (cfg->cfg_slot =3D=3D lru_cfg->cfg_slot)
> -			cfg->live =3D false;
> +	/* Find a free slot and write setup to ADC. */
> +	for (i =3D 0; i < AD7124_MAX_CONFIGS; i++) {
> +		if (st->cfg_slot_use_count[i] =3D=3D 0) {
> +			st->cfg_slot_use_count[i]++;
> +			st->channels[channel].cfg.cfg_slot =3D i;
> +
> +			dev_dbg(&st->sd.spi->dev,
> +				"Allocated config slot %u for channel %u, use
> count now %u\n",
> +				i, channel, st->cfg_slot_use_count[i]);
> +
> +			return ad7124_write_config(st, &st-
> >channels[channel].cfg, i);
> +		}

nit: I tend to prefer

if (st->cfg_slot_use_count[i] !=3D 0) // or omit the !=3D 0 part
	continue;

...

- Nuno S=C3=A1

> =C2=A0	}
> =C2=A0
> -	return lru_cfg;
> +	/* All slots are used with different configurations. */
> +	return -EUSERS;
> =C2=A0}

> =C2=A0
> -static int ad7124_push_config(struct ad7124_state *st, struct
> ad7124_channel_config *cfg)
> +static void ad7124_release_config_slot(struct ad7124_state *st, u8 chann=
el)
> =C2=A0{
> -	struct ad7124_channel_config *lru_cfg;
> -	int free_cfg_slot;
> -
> -	free_cfg_slot =3D ad7124_find_free_config_slot(st);
> -	if (free_cfg_slot >=3D 0) {
> -		/* push the new config in configs queue */
> -		kfifo_put(&st->live_cfgs_fifo, cfg);
> -	} else {
> -		/* pop one config to make room for the new one */
> -		lru_cfg =3D ad7124_pop_config(st);
> -		if (!lru_cfg)
> -			return -EINVAL;
> +	unsigned int slot =3D st->channels[channel].cfg.cfg_slot;
> =C2=A0
> -		/* push the new config in configs queue */
> -		free_cfg_slot =3D lru_cfg->cfg_slot;
> -		kfifo_put(&st->live_cfgs_fifo, cfg);
> -	}
> +	/*
> +	 * All of these conditions can happen at probe when all channels are
> +	 * disabled. Otherwise, they should not happen normally.
> +	 */
> +	if (channel >=3D st->num_channels || slot =3D=3D AD7124_CFG_SLOT_UNASSI=
GNED
> ||
> +	=C2=A0=C2=A0=C2=A0 st->cfg_slot_use_count[slot] =3D=3D 0)
> +		return;
> =C2=A0
> -	/* mark slot as used */
> -	assign_bit(free_cfg_slot, &st->cfg_slots_status, 1);
> +	st->cfg_slot_use_count[slot]--;
> +	st->channels[channel].cfg.cfg_slot =3D AD7124_CFG_SLOT_UNASSIGNED;
> =C2=A0
> -	return ad7124_write_config(st, cfg, free_cfg_slot);
> +	dev_dbg(&st->sd.spi->dev,
> +		"Released config slot %u for channel %u, use count now %u\n",
> +		slot, channel, st->cfg_slot_use_count[slot]);
> =C2=A0}
> =C2=A0
> =C2=A0static int ad7124_prepare_read(struct ad7124_state *st, int address=
)
> =C2=A0{
> =C2=A0	struct ad7124_channel_config *cfg =3D &st->channels[address].cfg;
> -	struct ad7124_channel_config *live_cfg;
> +	int ret;
> =C2=A0
> -	/*
> -	 * Before doing any reads assign the channel a configuration.
> -	 * Check if channel's config is on the device
> -	 */
> -	if (!cfg->live) {
> -		/* check if config matches another one */
> -		live_cfg =3D ad7124_find_similar_live_cfg(st, cfg);
> -		if (!live_cfg)
> -			ad7124_push_config(st, cfg);
> -		else
> -			cfg->cfg_slot =3D live_cfg->cfg_slot;
> -	}
> +	ret =3D ad7124_request_config_slot(st, address);
> +	if (ret)
> +		return ret;
> =C2=A0
> =C2=A0	/* point channel to the config slot and enable */
> -	cfg->live =3D true;
> =C2=A0	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(address), 2,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->channels[address].ain |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_CHANNEL_S=
ETUP, cfg-
> >cfg_slot) |
> @@ -688,6 +663,8 @@ static int ad7124_disable_one(struct ad_sigma_delta *=
sd,
> unsigned int chan)
> =C2=A0{
> =C2=A0	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, =
sd);
> =C2=A0
> +	ad7124_release_config_slot(st, chan);
> +
> =C2=A0	/* The relevant thing here is that AD7124_CHANNEL_ENABLE is cleare=
d.
> */
> =C2=A0	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan), 2, 0);
> =C2=A0}
> @@ -909,9 +886,6 @@ static int ad7124_write_raw(struct iio_dev *indio_dev=
,
> =C2=A0		gain =3D DIV_ROUND_CLOSEST(res, val2);
> =C2=A0		res =3D ad7124_find_closest_match(ad7124_gain,
> ARRAY_SIZE(ad7124_gain), gain);
> =C2=A0
> -		if (st->channels[chan->address].cfg.pga_bits !=3D res)
> -			st->channels[chan->address].cfg.live =3D false;
> -
> =C2=A0		st->channels[chan->address].cfg.pga_bits =3D res;
> =C2=A0		return 0;
> =C2=A0	default:
> @@ -1054,7 +1028,11 @@ static int ad7124_syscalib_locked(struct ad7124_st=
ate
> *st, const struct iio_chan
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0
> -		ret =3D ad_sd_read_reg(&st->sd, AD7124_OFFSET(ch-
> >cfg.cfg_slot), 3,
> +		/*
> +		 * Making the assumption that a single conversion will always
> +		 * use configuration slot 0 for the OFFSET/GAIN registers.
> +		 */
> +		ret =3D ad_sd_read_reg(&st->sd, AD7124_OFFSET(0), 3,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 &ch->cfg.calibration_offset);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> @@ -1069,7 +1047,7 @@ static int ad7124_syscalib_locked(struct ad7124_sta=
te
> *st, const struct iio_chan
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0
> -		ret =3D ad_sd_read_reg(&st->sd, AD7124_GAIN(ch->cfg.cfg_slot),
> 3,
> +		ret =3D ad_sd_read_reg(&st->sd, AD7124_GAIN(0), 3,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 &ch->cfg.calibration_gain);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> @@ -1160,7 +1138,6 @@ static int ad7124_set_filter_type_attr(struct iio_d=
ev
> *dev,
> =C2=A0
> =C2=A0	guard(mutex)(&st->cfgs_lock);
> =C2=A0
> -	cfg->live =3D false;
> =C2=A0	cfg->filter_type =3D value;
> =C2=A0	ad7124_set_channel_odr(st, chan->address);
> =C2=A0
> @@ -1479,7 +1456,6 @@ static int ad7124_setup(struct ad7124_state *st)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	INIT_KFIFO(st->live_cfgs_fifo);
> =C2=A0	for (i =3D 0; i < st->num_channels; i++) {
> =C2=A0		struct ad7124_channel_config *cfg =3D &st->channels[i].cfg;
> =C2=A0
> @@ -1487,6 +1463,8 @@ static int ad7124_setup(struct ad7124_state *st)
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0
> +		cfg->cfg_slot =3D AD7124_CFG_SLOT_UNASSIGNED;
> +
> =C2=A0		/* Default filter type on the ADC after reset. */
> =C2=A0		cfg->filter_type =3D AD7124_FILTER_TYPE_SINC4;
> =C2=A0
> @@ -1546,7 +1524,7 @@ static int __ad7124_calibrate_all(struct ad7124_sta=
te
> *st, struct iio_dev *indio
> =C2=A0			 * ad_sigma_delta_set_channel() ->
> ad7124_set_channel()
> =C2=A0			 * -> ad7124_prepare_read().
> =C2=A0			 */
> -			ret =3D ad_sd_read_reg(&st->sd, AD7124_GAIN(st-
> >channels[i].cfg.cfg_slot), 3,
> +			ret =3D ad_sd_read_reg(&st->sd, AD7124_GAIN(0), 3,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 &st-
> >channels[i].cfg.calibration_gain);
> =C2=A0			if (ret < 0)
> =C2=A0				return ret;
> @@ -1556,7 +1534,11 @@ static int __ad7124_calibrate_all(struct ad7124_st=
ate
> *st, struct iio_dev *indio
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0
> -		ret =3D ad_sd_read_reg(&st->sd, AD7124_OFFSET(st-
> >channels[i].cfg.cfg_slot), 3,
> +		/*
> +		 * Making the assumption that a single conversion will always
> +		 * use configuration slot 0 for the OFFSET/GAIN registers.
> +		 */
> +		ret =3D ad_sd_read_reg(&st->sd, AD7124_OFFSET(0), 3,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 &st-
> >channels[i].cfg.calibration_offset);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
>=20
> ---
> base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
> change-id: 20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-
> cd1f6bcd8415
> prerequisite-change-id: 20250917-iio-adc-ad7124-drop-nr-field-518102218a6=
1:v1
> prerequisite-patch-id: b03f80b570aa51fc82a54806345340d6453be0eb
> prerequisite-patch-id: 48e753e349ffefa570a03e7b1ddf59477d40feec
> prerequisite-patch-id: 819998144ef98c7e4bfae5237eb82a3d064f716e
> prerequisite-patch-id: e9d7d9560259b5aefb9048f02885bfcc43fd05b8
>=20
> Best regards,

