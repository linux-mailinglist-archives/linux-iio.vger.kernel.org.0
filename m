Return-Path: <linux-iio+bounces-24254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46204B852DF
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 16:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3997C561947
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B6630C607;
	Thu, 18 Sep 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huI2qQ0T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A875227599
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204446; cv=none; b=ZWZpBAUEaygS9XdKNWXaa/q2XRgld5RvFgmjICzDyVuP4S1uecwlawL0qK+Lv0IyQZlXKMrYoOszlkrwBLY89lr9P1Fek15rHnoDofdlb7kh0oqhWaLAjf92mu4u4CH+d4/BhiHcH9JJIoNoyZ7zmL7jFruO9y4Ti0M1A/7npDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204446; c=relaxed/simple;
	bh=TtaMkorK6y/ViD3v4dH2n/FXURQ95Hfn288XMWkH4w8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1Z1d5DpsuVdQKr2l4784r7DBfdQG3Z8bwI7ECW4ze03jgKGwsQtRsvqeERZnKj70Xb6AX4jZs9klekxIMehuai1oc9biTxqCBYuPjelsR9+X/L1MsEvtBKTTCVpUCTgjcen0t618pFZvViqsg7gCK7h5C+v4MmjRJpfwXy6TZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huI2qQ0T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso673320f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758204443; x=1758809243; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AeLknM6GuG1stF03g8JSLkIXNteDhdcQSt5KI463r4s=;
        b=huI2qQ0T8x5drdHpdnL1ULCbeumsDk4xhPf1AhgKv2GCNBdTaoxhHsTwuHYWTfwVuD
         U+cOYssW5VbEATCVG+sBjUmosm19BmoPml9k+5P0pooZH11BJTg+XM111wHRMYgmEFtR
         Yg3YSvkXwn7eL2Vu4+iIuVTyYpU9QGoy0dXYNA/X8lXRhUI+AiS776J7zUSaVFfGbj+z
         84LYejpxmt0jK3SYx11ypwCAkMGi/ns4O/aCHh3Pr+LbAcLC5cdh7q7nOF9s60NZIlH9
         3FTYrNObfAIDWeJFQPY9uqVPHCLkWamMIYxuQOYNPTVHEzufpC+2eCInIhwcy3m9BsSD
         pOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204443; x=1758809243;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeLknM6GuG1stF03g8JSLkIXNteDhdcQSt5KI463r4s=;
        b=PwkQKHJDiWa5+rG9rVQD5TgtQsDA8tXqziJbVmXyjvj75gtJUYiT9U7tPHZX6dHQ6L
         z8xcKTknf9iR50dDSN7ZVds+mKCYUIIj4jAFmwfdPcNTJx5fopbWCsvnKvPVxUNHP/6r
         2zBFmFaQy7OtLn9/zkRbmozYe4m/hKHjr9bwDvTzvzPiGtHyEn4Uf4hlpOzrraMOH0L0
         Op+9CRuES5YEWB0PEH7KiGMH5OdLTL3a/RTGwaKIAoHYNC1FxTuxQPaGyCHOCIkxY5J6
         nlq+zzljTwgLBXqu4zH3RrB0f1D+3k2oZ2787D8cUcSCfsoawAsfAU/6tUuiFRjm9BDa
         vV9Q==
X-Gm-Message-State: AOJu0Yx3KeGlmRqHpOfygcVB/qTH3FEeg5mKdzUbfFFfmBxvElo+QH2O
	8Qblc+453q9ShH6pP7ZMEEfZLBIHTG3/p431yggWq9eG2jsb6imxMwbm
X-Gm-Gg: ASbGncu1qRs74w/p28Myh8W15/pET4VHFQqBjVGoFQeU+crMoX7gMr3nKjFAFKyAqbf
	qXk+/c1+snLxExp72QlqyYWUJ713ucbqo7oaTdFawKX+iMr/yw9dq4s1cIdSHByDgoVjn4niLay
	aMdsjScL3+fH/IYXVIiBMQPKIK2hsT1GF7gA2OVqS+tEIOuEZHViQSojCYigdndRcNLSNw6GJGR
	Ski+/sK6sNoLBs3eT1HdxPGJIiQah231VxZew0d3ECEqHqwaWHQgPYH2+fPwJ8Dxf9a5zKOg6zD
	ULVuJxQAZM5/F0vahyVoJ6kN4lv+jcFTm3lyfjHjfC6bAfgQ0yIcDYA6hnNrrwy8L0AJqqNyBQO
	Bq+2cYWDFZYDEpG9wXPAt8z33JedRZbC2boihMIohcFTDuisCJdqX
X-Google-Smtp-Source: AGHT+IHw1wRaMktc687AhwO2IhYmWFpTzAk/5SOs2fVSHYFRb+rEV7EYji2faH3d7fjaCU1a7rGnXw==
X-Received: by 2002:a05:6000:2486:b0:3ec:1fff:3b25 with SMTP id ffacd0b85a97d-3ecdf94a43cmr5556954f8f.0.1758204442546;
        Thu, 18 Sep 2025 07:07:22 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbd64dbsm3658315f8f.50.2025.09.18.07.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:07:22 -0700 (PDT)
Message-ID: <8f412c82cfd511b95d4b19a70d86d151ff666d1b.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: change setup reg allocation strategy
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Sep 2025 15:07:48 +0100
In-Reply-To: <649643ac-525f-4a82-9591-021983b00b70@baylibre.com>
References: 
	<20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com>
	 <c0a22d97282f71b2fb946f877e23d410d485d1be.camel@gmail.com>
	 <649643ac-525f-4a82-9591-021983b00b70@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 08:16 -0500, David Lechner wrote:
> On 9/18/25 7:24 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2025-09-17 at 17:05 -0500, David Lechner wrote:
> > > Change the allocation strategy of the 8 SETUP registers from a least-
> > > recently-used (LRU) to a first-come-first-served basis.
> > >=20
>=20
> ...
>=20
> > > -	/*
> > > -	 * This is just to make sure that the comparison is adapted after
> > > -	 * struct ad7124_channel_config was changed.
> > > -	 */
> > > -	static_assert(sizeof_field(struct ad7124_channel_config,
> > > config_props) =3D=3D
> > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct {
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 enum ad7124_ref_sel refsel;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 bool bipolar;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 bool buf_positive;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 bool buf_negative;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int vref_mv;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int pga_bits;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr_sel_bits;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 enum ad7124_filter_type filter_type;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int calibration_offset;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int calibration_gain;
> > > -			=C2=A0=C2=A0=C2=A0=C2=A0 }));
> > > -
> > > -	for (i =3D 0; i < st->num_channels; i++) {
> > > -		cfg_aux =3D &st->channels[i].cfg;
> > > -
> > > -		if (cfg_aux->live &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->refsel =3D=3D cfg_aux->refsel &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->bipolar =3D=3D cfg_aux->bipolar &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->buf_positive =3D=3D cfg_aux->buf_positive =
&&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->buf_negative =3D=3D cfg_aux->buf_negative =
&&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->vref_mv =3D=3D cfg_aux->vref_mv &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->pga_bits =3D=3D cfg_aux->pga_bits &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->odr_sel_bits =3D=3D cfg_aux->odr_sel_bits =
&&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->filter_type =3D=3D cfg_aux->filter_type &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->calibration_offset =3D=3D cfg_aux-
> > > >calibration_offset &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->calibration_gain =3D=3D cfg_aux->calibrati=
on_gain)
> > > -			return cfg_aux;
> > > -	}
> > > -
> > > -	return NULL;
> > > -}
> > > -
> > > -static int ad7124_find_free_config_slot(struct ad7124_state *st)
> > > -{
> > > -	unsigned int free_cfg_slot;
> > > -
> > > -	free_cfg_slot =3D find_first_zero_bit(&st->cfg_slots_status,
> > > AD7124_MAX_CONFIGS);
> > > -	if (free_cfg_slot =3D=3D AD7124_MAX_CONFIGS)
> > > -		return -1;
> > > -
> > > -	return free_cfg_slot;
> > > -}
> > > -
> > > =C2=A0/* Only called during probe, so dev_err_probe() can be used */
> > > =C2=A0static int ad7124_init_config_vref(struct ad7124_state *st, str=
uct
> > > ad7124_channel_config *cfg)
> > > =C2=A0{
> > > @@ -485,6 +427,21 @@ static int ad7124_init_config_vref(struct
> > > ad7124_state
> > > *st, struct ad7124_channe
> > > =C2=A0	}
> > > =C2=A0}
> > > =C2=A0
> > > +static bool ad7124_config_equal(struct ad7124_channel_config *a,
> > > +				struct ad7124_channel_config *b)
> > > +{
> > > +	return a->refsel =3D=3D b->refsel &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->bipolar =3D=3D b->bipolar &=
&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->buf_positive =3D=3D b->buf_=
positive &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->buf_negative =3D=3D b->buf_=
negative &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->vref_mv =3D=3D b->vref_mv &=
&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->pga_bits =3D=3D b->pga_bits=
 &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->odr_sel_bits =3D=3D b->odr_=
sel_bits &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->filter_type =3D=3D b->filte=
r_type &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->calibration_offset =3D=3D b=
->calibration_offset &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->calibration_gain =3D=3D b->=
calibration_gain;
> > > +}
> >=20
> > Why not keeping the static_assert()? IIRC, Uwe felt fairly strong about
> > having
> > it.
>=20
> I thought by now that we had implemented all of the possible
> values so nothing else would be added so we didn't really need
> the check anymore. But I guess there are a few bits left in the
> CONFIG register that aren't accounted for.
>=20
> TBH, when making the other recent changes it just felt like a
> chore keeping it up to date and not particularly helpful. There
> is already a comment where the fields are declared that was
> enough to remind me to update this as well.

I brought it up because I remember Uwe kind of really wanted it (or maybe i=
t was
requested by someone reviewing). Not sure now :).

I'm fine with removing it anyways.

>=20
> > > +		/* Find the first channel using this slot, if any. */
> > > +		for (j =3D 0; j < st->num_channels; j++) {
> > > +			if (st->channels[j].cfg.cfg_slot !=3D i)
> > > +				continue;
> > > =C2=A0
> > > -	/* mark slot as free */
> > > -	assign_bit(lru_cfg->cfg_slot, &st->cfg_slots_status, 0);
> > > +			/*
> > > +			 * If there is a match, increase the use count
> > > and
> > > share
> > > +			 * the slot with the requesting channel.
> > > +			 */
> > > +			if (ad7124_config_equal(&st->channels[j].cfg,
> > > +						&st-
> > > >channels[channel].cfg))
> > > {
> > > +				st->cfg_slot_use_count[i]++;
> > > +				st->channels[channel].cfg.cfg_slot =3D i;
> > > =C2=A0
> > > -	/* invalidate all other configs that pointed to this one */
> > > -	for (i =3D 0; i < st->num_channels; i++) {
> > > -		cfg =3D &st->channels[i].cfg;
> > > +				dev_dbg(&st->sd.spi->dev,
> > > +					"Re-using config slot %u for
> > > channel
> > > %u, use count now %u\n",
> > > +					i, channel, st-
> > > > cfg_slot_use_count[i]);
> > > +
> > > +				return 0;
> > > +			}
> > > +		}
> > > +	}
> >=20
> > I think we could have the above a bit simpler. Something like:
> >=20
> > for (j =3D 0; j < st->num_channels; j++) {
> > 	if (st->channels[j].cfg.cfg_slot =3D=3D AD7124_CFG_SLOT_UNASSIGNED)
> > 		continue;
> > 	if (!ad7124_config_equal(&st->channels[j].cfg,
> > 	=C2=A0=C2=A0=C2=A0 &st->channels[channel].cfg))
> > 		continue;
> > =09
> > 	i =3D st->channels[j].cfg.cfg_slot;
> > 	st->cfg_slot_use_count[i]++;
> > 	st->channels[channel].cfg.cfg_slot =3D i;
> > }
> >=20
> > Am I missing something?
>=20
> I like it. I should also rename the i and j variables to slot and channel
> to make it a bit more clear.
>=20

Sure...

>=20
- Nuno S=C3=A1

