Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7805A6013AB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJQQk6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 12:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJQQk4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 12:40:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E806EF13
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 09:40:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id o64so12703837oib.12
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0cKR3KD0RCU5iLYxLy6W7xc1yzczG+IYMwWhTv8Fxo=;
        b=kZwCQbQSRNdgSf7dXV8jx1hNHKQWlTToA6o+vifggGCImtIHpci5z8o+RnDr8R4ow2
         7FHonqXPZyn4uhs2cnPI13ZkV69FfH5/x9eAiGq7leGNHSa9xdy3r5Q1ycGRBFcCu3fX
         8d+Rfq4xOglzr+F7hb9UM/0d76Z7CmBCAwTa8xEaSyO+j+H0cxaD4gjU0LPyd2qi7qkm
         Xv4XzyCw22duBThpS+VxZl1Y8z0MLgNWHIMAPNODx6zpSx3m8d3L8vxvOd91rUgr1BTX
         8AW1/CG4xz3/F2Tp9tKKx9Kb66ASuCusRjulZiW+EG9XRbJA2uc8vyLEYo80hZEJNUQT
         F6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0cKR3KD0RCU5iLYxLy6W7xc1yzczG+IYMwWhTv8Fxo=;
        b=unbKQzhcI984IuI12uL0OnHm24YJiNt7aRirWoWbd51oaZhLOt9AU67zfbYkHnY6V5
         QJE5Av8em9pWf9CCJcgogCvAbc/pAqdHfUtTCZciAryHQOmOVyl5zE9Dwh1joN8051OU
         OvU8dRoLvfCKM14NZH4fKucMuVgQ8bGWcXYzF3PtucOn8jxflu6l27ZsWGwxf63+rm/L
         xrlao+YL/lIhTO3Cj2gO5LDGQ2E9XMywtuFw4d5+os8bYrZulFayFX16SxHrSiXPwK4G
         jt5y27gB490hyv7NrkKPSAV1K8lqh2Ryk9vwnNf0YvV2J1gaRmUHaNCnn0FEt8IrKO2Q
         d09A==
X-Gm-Message-State: ACrzQf322dIoRB1soFs61w2bra271msTTydW0ZP8iq9SMOc6A7u4FufQ
        wkM7hARm7f81OVIGjV0l8Xwjtw==
X-Google-Smtp-Source: AMsMyM5SZeXKGCxALmNnZ3YqeUyPK0FV7SN0idFsa+iPJnN5l6fAMSNs/Za85Guk+uzKqoA/lC3zhw==
X-Received: by 2002:a05:6808:3007:b0:351:5ea9:83d1 with SMTP id ay7-20020a056808300700b003515ea983d1mr5169637oib.150.1666024853717;
        Mon, 17 Oct 2022 09:40:53 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i9-20020aca2b09000000b00354b1edb60fsm4476750oik.32.2022.10.17.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:40:52 -0700 (PDT)
Date:   Mon, 17 Oct 2022 12:40:50 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/4] mfd: Add RZ/G2L MTU3 counter driver
Message-ID: <Y02FksmG22a03bcS@fedora>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4DB8XTZ3HluUNltT"
Content-Disposition: inline
In-Reply-To: <20221010145222.1047748-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--4DB8XTZ3HluUNltT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 03:52:21PM +0100, Biju Das wrote:
> Add RZ/G2L MTU3 counter driver. This IP supports the following
> phase counting modes on MTU1 and MTU2 channels
>=20
> 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> 2) 32-bit phase counting mode by cascading MTU1 and MTU2.
>=20
> This patch adds 3 counters by creating 3 logical channels
> 	counter0: 16-bit phase counter on MTU1 channel
> 	counter1: 16-bit phase counter on MTU2 channel
> 	counter2: 32-bit phase counter by cascading MTU1 and MTU2
> 		  channels.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Hello Biju,

We discussed some changes already for v5, but I have some additional
comments and questions below.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 7329971a3bdf..fa88056224c9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1986,6 +1986,14 @@ config MFD_RZ_MTU3
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rz-mtu3.
> =20
> +config MFD_RZ_MTU3_CNT
> +	tristate "RZ/G2L MTU3 counter driver"

This is a nitpick, but include the manufacturer name in the tristate
string for the sake of clarity: "Renesas RZ/G2L MTU3 counter driver".

> +	depends on MFD_RZ_MTU3 || COMPILE_TEST

I noticed you include <linux/of.h> in the rz-mtu3-cnt.c file; do you
need to depend on OF here in the Kconfig as well?

> +static int rz_mtu3_count_read(struct counter_device *counter,
> +			      struct counter_count *count, u64 *val)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		*val =3D rz_mtu3_32bit_ch_read(priv->ch[0], RZ_MTU3_TCNTLW);
> +	else
> +		*val =3D rz_mtu3_16bit_ch_read(priv->ch[count->id], RZ_MTU3_TCNT);

After considering this again, I think it'll be better to match the
structure of the rest of the functions in this driver for consistency.
Rather than hardcoding priv->ch[0], determine the ch_id first and pass
that instead::


    const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);

    if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
            *val =3D rz_mtu3_32bit_ch_read(priv->ch[ch_id], RZ_MTU3_TCNTLW);
    else
            *val =3D rz_mtu3_16bit_ch_read(priv->ch[ch_id], RZ_MTU3_TCNT);

> +static int rz_mtu3_count_write(struct counter_device *counter,
> +			       struct counter_count *count, const u64 val)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +	u32 ceiling;
> +
> +	mutex_lock(&priv->lock);
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		ceiling =3D priv->mtu_32bit_max;
> +	else
> +		ceiling =3D priv->mtu_16bit_max[ch_id];
> +
> +	if (val > ceiling) {
> +		mutex_unlock(&priv->lock);
> +		return -ERANGE;
> +	}
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		rz_mtu3_32bit_ch_write(priv->ch[0], RZ_MTU3_TCNTLW, val);

Like in count_read(), use ch_id here instead of 0 for the sake of
consistency.

> +static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       u64 ceiling)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +
> +	switch (count->id) {
> +	case RZ_MTU3_16_BIT_MTU1_CH:
> +	case RZ_MTU3_16_BIT_MTU2_CH:
> +		if (ceiling > U16_MAX)
> +			return -ERANGE;
> +		priv->mtu_16bit_max[ch_id] =3D ceiling;
> +		break;
> +	case RZ_MTU3_32_BIT_CH:
> +		if (ceiling > U32_MAX)
> +			return -ERANGE;
> +		priv->mtu_32bit_max =3D ceiling;
> +		break;
> +	}
> +
> +	mutex_lock(&priv->lock);
> +	if (ceiling =3D=3D 0) {
> +		/* Disable counter clear source */
> +		rz_mtu3_8bit_ch_write(priv->ch[ch_id], RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_NONE);

Refer to our discussions in the v3 review thread regarding ceiling set
to 0; in particular, don't disable the count value ceiling but rather
limit it to a maximum value of 0.

> +static int rz_mtu3_count_enable_write(struct counter_device *counter,
> +				      struct counter_count *count, u8 enable)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +	struct rz_mtu3_channel *ch =3D priv->ch[ch_id];
> +	int ret =3D 0;
> +
> +	if (enable) {
> +		pm_runtime_get_sync(ch->dev);
> +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> +	} else {
> +		rz_mtu3_terminate_counter(counter, count->id);
> +		pm_runtime_put(ch->dev);
> +	}
Refer to our discussions in the v3 review thread regarding the "enable"
Count extension; in particular, "enable" pauses/unpauses counting.

> +static int rz_mtu3_action_read(struct counter_device *counter,
> +			       struct counter_count *count,
> +			       struct counter_synapse *synapse,
> +			       enum counter_synapse_action *action)
> +{
> +	const size_t signal_a_id =3D count->synapses[0].signal->id;
> +	const size_t signal_b_id =3D count->synapses[1].signal->id;
> +	size_t signal_c_id;
> +	size_t signal_d_id;
> +	enum counter_function function;
> +	int err;
> +
> +	if (count->id !=3D RZ_MTU3_16_BIT_MTU1_CH) {
> +		signal_c_id =3D count->synapses[2].signal->id;
> +		signal_d_id =3D count->synapses[3].signal->id;
> +	}

The Signal ids are constants so you remove them from this function and
use preprocessor defines instead to represent SIGNAL_A_ID, SIGNAL_B_ID,
SIGNAL_C_ID, and SIGNAL_D_ID. Remember to set the Signal ids in the
rz_mtu3_signals[] array accordingly.

> +static struct counter_signal rz_mtu3_signals[] =3D {
> +	RZ_MTU3_PHASE_SIGNAL(0, "MTU1 MTCLKA"),
> +	RZ_MTU3_PHASE_SIGNAL(1, "MTU1 MTCLKB"),
> +	RZ_MTU3_PHASE_SIGNAL(2, "MTU2 MTCLKC"),
> +	RZ_MTU3_PHASE_SIGNAL(3, "MTU2 MTCLKD"),
> +};

The relationship of these Signals still has me somewhat confused so I'm
hoping you can help me properly ironed out my understanding. This is how
I currently understand it, so please point out any mistakes I have:

MTU1 (Channel 1):
 * Pulse-Direction mode:
   - MTCLKA updates count
   - MTCLKB determines direction
 * Quadrature x2 B:
   - MTCLKA is quadrature phase A
   - MTCLKB is quadrature phase B
   - Any state transition on MTCLKB updates count
 * Quadrature x4:
   - MTCLKA is quadrature phase A
   - MTCLKB is quadrature phase B
   - Any state transition on either MTCLKA or MTCLKB updates count

MTU2 (Channel 2):
 - Same as MTU1, but optionally can select MTCLKC and MTCLKD instead of
   MTCLKA and MTCLKB respectively
 * Pulse-Direction mode:
   - MTCLKA(C) updates count
   - MTCLKB(D) determines direction
 * Quadrature x2 B:
   - MTCLKA(C) is quadrature phase A
   - MTCLKB(D) is quadrature phase B
   - Any state transition on MTCLKB updates count
 * Quadrature x4:
   - MTCLKA(C) is quadrature phase A
   - MTCLKB(D) is quadrature phase B
   - Any state transition on either MTCLKA(C) or MTCLKB(D) updates count

MTU3 (Channel 1 and 2 cascading):
 - Same as MTU2 (but count is now 32-bit)
 * Pulse-Direction mode:
   - MTCLKA(C) updates count
   - MTCLKB(D) determines direction
 * Quadrature x2 B:
   - MTCLKA(C) is quadrature phase A
   - MTCLKB(D) is quadrature phase B
   - Any state transition on MTCLKB updates count
 * Quadrature x4:
   - MTCLKA(C) is quadrature phase A
   - MTCLKB(D) is quadrature phase B
   - Any state transition on either MTCLKA(C) or MTCLKB(D) updates count

Is my understanding correct here? Is the selection between MTCLKA/MTCLKB
and MTCLKC/MTCLKD done in software, and should we expose it in sysfs?

William Breathitt Gray

--4DB8XTZ3HluUNltT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY02FkgAKCRC1SFbKvhIj
K67cAP4o2be9ZTz9c53rpLFHZMS508l0vWb9BqFy8rDKf6Uz0wD+MMgAu30duNJW
Wkhz+LZpAcgZFWBHpbrNXsFcodSiFwA=
=Vk0j
-----END PGP SIGNATURE-----

--4DB8XTZ3HluUNltT--
