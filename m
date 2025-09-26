Return-Path: <linux-iio+bounces-24455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB4BA39BA
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 14:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486446279B8
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145192EB86B;
	Fri, 26 Sep 2025 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD4CupfZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49B2773C0
	for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889597; cv=none; b=RbzMVo+5f7VY6yyIE3VFQzaxoy1XGA2VbeSzM0GoPw3+Fp0AGZdQ0LAJrXJp46oUaUdIAj8doJpznx4m2/+pU3TmyqwdUDwjfhG5vyBTQZ8FjO3O43HNHRFP+u/gsow3IMpdm5EULeiDcdRS5ckpLfAO5X88c7E5YCSSiIU1SNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889597; c=relaxed/simple;
	bh=1ImUhP7adM1d66cJzTZZl0vUu/TLRkdyaiWBTgIFhWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R76cD5ZZbjpC4rBFmeh7fUIeyHGUzpZqLiPlqzkHwSCziGb5wLXC2dnKgSuEcnYPrAmonSkgGny7ZKlS7dggUUZ9XQ9z6Ikah7UWwGpH7IiK7ya/QYzmsMaZKcI2Suj4XfPtyVqWyPBrFJSnve+6XY85e+IPQpsoBwMe9NTYiVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD4CupfZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso6539885e9.2
        for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758889594; x=1759494394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qcj0DMSloRWeUj2m0bhbZUWIklI7grwfskgWb0CPuwY=;
        b=HD4CupfZaOXWPG0HCJtigk/e938VXu7rCAllLaIe74YB8b0AOox3KfffKHiOsIV8QE
         lLG0tf62kul8FQI4tbHz7lomWt3esqtykzQVHg4dcAuIp8TTMZ3BwPPLnYMuI7s76fB6
         0W/Nvv0ioeP7btqk0BoMBnYw7UEcaaysOza3zpjQdpoozrCvW5lF+jvlf5MzaDGrba4k
         RJ8b/x8Aq30GQ229CUnHqCEJGnoiBKS/3pPVhtuX33v+ldfPyUyt003BArQGtxDVS75Z
         r75MPsbzrbYyjt9go6/s2NaV6fiVEz4l+KP+DAdG4K24fIaQYttylMG2p28wF5SwQL2t
         1ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758889594; x=1759494394;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcj0DMSloRWeUj2m0bhbZUWIklI7grwfskgWb0CPuwY=;
        b=IXo3whipo25nb3JOEZ7A0JCManjpPecNVAfWXo/nsRW877iCPWZw3JaWbK77B/gYXv
         b7PmUPIAL7y1dNOqHiWArP2xowhpIm/K+x/t8j9qmpgqIYBan9l6SdyPJlnzspPFJYSj
         vA5wkmwpbtvOhMrHlgZL+8PQgt5VVm0lYq0B5ztvMnU6hXSQa86ZoG1HQOHQlhnw4Tx8
         6jeRd+LH0/9ugW6B008LNGBhtdKXbcgq2AXNlNxYMNyIkXrVr/OnGZADV31XJG9RZXr8
         SAEtYEbOsKyjOsdWhtbhVhaV0VqArrQER92XuheHCplkgtQcRqphpmsqhQXaBYcDM6Yp
         OVGg==
X-Gm-Message-State: AOJu0YyKL+H0AZ7EPZupAD6A5PmbcYitBo6FqsT2aj+L+6tMb8a5V7Xf
	YUeU5iEZWrDvT7Wknx3ObAIja1dMegawIA9s91lRf5JnzLdAV7O15AXf
X-Gm-Gg: ASbGncthll6JNEKr6axzDImKPTzaL7x+C/MxFD4R028h4UyPUz2EtV5GlGvy0e1+/1w
	/LlZAiLHodf63IeAqf3mI6U/6UGxhCg4WbMIbEKLd4FOXWf5X27WdafCEpAxOKO3KNjMoIyfDMv
	DfnaHJ72Bporqj2yUvwymM3ORIGkHybvx0XcpSpmQhtmdK8+2NMb6Ea3gdeuO52HMLd0HaldYgw
	nk1SU8qL7l6ZVlmEoHAoTjIc5Ll/O+GXv+LqRmSpvkV+3GqZWtasYthYQPTPzIbJ6e+EAIbJjZd
	txUZvS1wDbJxNBBegWP/K32C4YbNq+X2+UfVYeobNPNcIX+8GJhOahjwaRF1IhypKTBES80KU2n
	PdKf/SZ4KlDu4y0SOLqBv8FCPr9LGtxU=
X-Google-Smtp-Source: AGHT+IGpWaYD+VuzNn756LLOrQLHBM0RXfBWVhIbLA8LeUV9ljgwcjPnVUVCVMOcYjEYBmg3vlobDw==
X-Received: by 2002:a05:6000:2012:b0:3ec:ea73:a94d with SMTP id ffacd0b85a97d-40e4a05c185mr5234049f8f.37.1758889593350;
        Fri, 26 Sep 2025 05:26:33 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9eabbsm78734115e9.3.2025.09.26.05.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 05:26:33 -0700 (PDT)
Message-ID: <3bbd51983f5bf67b6fd061f28b8b260370beac70.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7124: change setup reg allocation
 strategy
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 26 Sep 2025 13:27:00 +0100
In-Reply-To: <20250923-iio-adc-ad7124-change-setup-reg-allocation-strategy-v2-1-d9bf01bb3ad8@baylibre.com>
References: 
	<20250923-iio-adc-ad7124-change-setup-reg-allocation-strategy-v2-1-d9bf01bb3ad8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-23 at 16:48 -0500, David Lechner wrote:
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
> This new strategy also makes hardware debugging easier since SETUPs are
> now assigned in a deterministic manner and in a logical order.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Hi David,

LGTM

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

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
> Changes in v2:
> - Simplified search algorithm to a single for loop.
> - Renamed loop variable for channels to "other".
> - Removed dev_dbg() statements.
> - Reworded confusing comment.
> - Link to v1:
> https://lore.kernel.org/r/20250917-iio-adc-ad7124-change-setup-reg-alloca=
tion-strategy-v1-1-4e17b3de046b@baylibre.com
> ---
> =C2=A0drivers/iio/adc/ad7124.c | 233 ++++++++++++++++++++----------------=
----------
> -
> =C2=A01 file changed, 100 insertions(+), 133 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index
> 374e39736584f55c1290db3e257dff2c60f884d2..f7bf13ef1c956958569712ed758b707=
3494e
> 8c24 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -111,6 +111,8 @@
> =C2=A0#define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
> =C2=A0#define AD7124_FILTER_FS		GENMASK(10, 0)
> =C2=A0
> +#define AD7124_CFG_SLOT_UNASSIGNED	~0U
> +
> =C2=A0#define AD7124_MAX_CONFIGS	8
> =C2=A0#define AD7124_MAX_CHANNELS	16
> =C2=A0
> @@ -176,14 +178,13 @@ enum ad7124_filter_type {
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
> @@ -215,14 +216,13 @@ struct ad7124_state {
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
> =C2=A0	bool enable_single_cycle;
> =C2=A0};
> =C2=A0
> @@ -367,9 +367,6 @@ static void ad7124_set_channel_odr(struct ad7124_stat=
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
> @@ -404,61 +401,6 @@ static int ad7124_get_3db_filter_factor(struct
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
> @@ -487,6 +429,21 @@ static int ad7124_init_config_vref(struct ad7124_sta=
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
> +
> =C2=A0static int ad7124_write_config(struct ad7124_state *st, struct
> ad7124_channel_config *cfg,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int cfg_slot)
> =C2=A0{
> @@ -495,13 +452,13 @@ static int ad7124_write_config(struct ad7124_state =
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
> @@ -511,7 +468,7 @@ static int ad7124_write_config(struct ad7124_state *s=
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
> @@ -564,7 +521,7 @@ static int ad7124_write_config(struct ad7124_state *s=
t,
> struct ad7124_channel_co
> =C2=A0	 * was requested. It may only be disabled through debugfs for test=
ing
> =C2=A0	 * purposes.
> =C2=A0	 */
> -	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg->cfg_slot), 3,
> +	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg_slot), 3,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_FI=
LTER, filter) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_RE=
J60, rej60) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_PO=
ST_FILTER, post) |
> @@ -573,83 +530,86 @@ static int ad7124_write_config(struct ad7124_state =
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
> +	unsigned int other, slot;
> +	int last_used_slot =3D -1;
> =C2=A0
> -	/*
> -	 * Pop least recently used config from the fifo
> -	 * in order to make room for the new one
> -	 */
> -	ret =3D kfifo_get(&st->live_cfgs_fifo, &lru_cfg);
> -	if (ret <=3D 0)
> -		return NULL;
> +	/* Find another channel with a matching config, if any. */
> +	for (other =3D 0; other < st->num_channels; other++) {
> +		if (other =3D=3D channel)
> +			continue;
> =C2=A0
> -	lru_cfg->live =3D false;
> +		if (st->channels[other].cfg.cfg_slot =3D=3D
> AD7124_CFG_SLOT_UNASSIGNED)
> +			continue;
> =C2=A0
> -	/* mark slot as free */
> -	assign_bit(lru_cfg->cfg_slot, &st->cfg_slots_status, 0);
> +		last_used_slot =3D max_t(int, last_used_slot,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->channels[other].cfg.cfg_slo=
t);
> =C2=A0
> -	/* invalidate all other configs that pointed to this one */
> -	for (i =3D 0; i < st->num_channels; i++) {
> -		cfg =3D &st->channels[i].cfg;
> +		if (!ad7124_config_equal(&st->channels[other].cfg,
> +					 &st->channels[channel].cfg))
> +			continue;
> =C2=A0
> -		if (cfg->cfg_slot =3D=3D lru_cfg->cfg_slot)
> -			cfg->live =3D false;
> +		/* Found a match, re-use that slot. */
> +		slot =3D st->channels[other].cfg.cfg_slot;
> +		st->cfg_slot_use_count[slot]++;
> +		st->channels[channel].cfg.cfg_slot =3D slot;
> +
> +		return 0;
> =C2=A0	}
> =C2=A0
> -	return lru_cfg;
> -}
> +	/* No match, use next free slot. */
> +	slot =3D last_used_slot + 1;
> +	if (slot >=3D AD7124_MAX_CONFIGS)
> +		return -EUSERS;
> =C2=A0
> -static int ad7124_push_config(struct ad7124_state *st, struct
> ad7124_channel_config *cfg)
> -{
> -	struct ad7124_channel_config *lru_cfg;
> -	int free_cfg_slot;
> +	st->cfg_slot_use_count[slot]++;
> +	st->channels[channel].cfg.cfg_slot =3D slot;
> =C2=A0
> -	free_cfg_slot =3D ad7124_find_free_config_slot(st);
> -	if (free_cfg_slot >=3D 0) {
> -		/* push the new config in configs queue */
> -		kfifo_put(&st->live_cfgs_fifo, cfg);
> -	} else {
> -		/* pop one config to make room for the new one */
> -		lru_cfg =3D ad7124_pop_config(st);
> -		if (!lru_cfg)
> -			return -EINVAL;
> +	return ad7124_write_config(st, &st->channels[channel].cfg, slot);
> +}
> =C2=A0
> -		/* push the new config in configs queue */
> -		free_cfg_slot =3D lru_cfg->cfg_slot;
> -		kfifo_put(&st->live_cfgs_fifo, cfg);
> -	}
> +static void ad7124_release_config_slot(struct ad7124_state *st, u8 chann=
el)
> +{
> +	unsigned int slot =3D st->channels[channel].cfg.cfg_slot;
> =C2=A0
> -	/* mark slot as used */
> -	assign_bit(free_cfg_slot, &st->cfg_slots_status, 1);
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
> -	return ad7124_write_config(st, cfg, free_cfg_slot);
> +	st->cfg_slot_use_count[slot]--;
> +	st->channels[channel].cfg.cfg_slot =3D AD7124_CFG_SLOT_UNASSIGNED;
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
> @@ -692,6 +652,8 @@ static int ad7124_disable_one(struct ad_sigma_delta *=
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
> @@ -913,9 +875,6 @@ static int ad7124_write_raw(struct iio_dev *indio_dev=
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
> @@ -1058,7 +1017,11 @@ static int ad7124_syscalib_locked(struct ad7124_st=
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
> @@ -1073,7 +1036,7 @@ static int ad7124_syscalib_locked(struct ad7124_sta=
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
> @@ -1164,7 +1127,6 @@ static int ad7124_set_filter_type_attr(struct iio_d=
ev
> *dev,
> =C2=A0
> =C2=A0	guard(mutex)(&st->cfgs_lock);
> =C2=A0
> -	cfg->live =3D false;
> =C2=A0	cfg->filter_type =3D value;
> =C2=A0	ad7124_set_channel_odr(st, chan->address);
> =C2=A0
> @@ -1483,7 +1445,6 @@ static int ad7124_setup(struct ad7124_state *st)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	INIT_KFIFO(st->live_cfgs_fifo);
> =C2=A0	for (i =3D 0; i < st->num_channels; i++) {
> =C2=A0		struct ad7124_channel_config *cfg =3D &st->channels[i].cfg;
> =C2=A0
> @@ -1491,6 +1452,8 @@ static int ad7124_setup(struct ad7124_state *st)
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0
> +		cfg->cfg_slot =3D AD7124_CFG_SLOT_UNASSIGNED;
> +
> =C2=A0		/* Default filter type on the ADC after reset. */
> =C2=A0		cfg->filter_type =3D AD7124_FILTER_TYPE_SINC4;
> =C2=A0
> @@ -1550,7 +1513,7 @@ static int __ad7124_calibrate_all(struct ad7124_sta=
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
> @@ -1560,7 +1523,11 @@ static int __ad7124_calibrate_all(struct ad7124_st=
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
> base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
> change-id: 20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-
> cd1f6bcd8415
>=20
> Best regards,

