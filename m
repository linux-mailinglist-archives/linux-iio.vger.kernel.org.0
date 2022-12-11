Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF29649647
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 21:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLKUgd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 15:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLKUgb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 15:36:31 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18ED9FC4
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 12:36:29 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id o12so7008176qvn.3
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vG+5rr9tS7KMp34Zo+sRtclbrynw/kq0IjiPJ9285U=;
        b=Eet1IO2GXAb9+/ZLZ4/qqchJjru43+Luj++NAsNW6cjo+jBz8YwRp0AaOQEnND/Tbw
         7t16Is2s+p/2aRcFwEI7C9iCXiW18YtQcVVyni+FysSqpih9C3aGhECwV/pS8MawbXbq
         QHrYWdK9UsO0EyIXxLrUk/1t9FgDtCesXAsO43bnNA/gaKqFWs3l7mwpKBXES4xCM2L1
         7GhuELgszR2zpHJejbaO7+Q1AjIIXo//wTmyszWeSVtZ0tgX28eF9yXEyr/XFiXqJA26
         qHgoVimQahUdOm4NyFbkRuqt4VoFhImi3RlPG0lmKoTnXmdydFlm3mukCrX/4eZ1cauQ
         9W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vG+5rr9tS7KMp34Zo+sRtclbrynw/kq0IjiPJ9285U=;
        b=y20ZxAglGHJojACj6UmAPHj9qCohVsdc7MWby34Ugoec7X/mQkO1NV9w7rELAv3lC4
         i5EHW2qrx2QVx5ozRSRQzwgWIGJydeHk2QHvKzS73QBsTrP5BXIzR2rMq6f62BJp8WvD
         ZACrNJttiiRFOAcZ0qYYm/Zeasf8mD0jUVKc7PRUyg5kcqsE7OU9HOZ8nKSpy59vPJeo
         tCoIolY9X7NZvn9QH9vAv8PMl77+m+MLK0kQQNWyVAYmvFEt6A7k3VgxmPQENEOhv9OG
         /fsAnciV6bhdnGFCGDw70foStTvx9EcoRhKOw56TCND4B87p7t0m8KfD0dXtduXuo5uZ
         jVVQ==
X-Gm-Message-State: ANoB5pmCquRxbNVXy0lyOWf4op4XrlJVzJypW0fOyXBqPThNvI1DyA1D
        nh7WzUGuhVRr9kq6LJFtHxuY9HBXsi3ltR3m
X-Google-Smtp-Source: AA0mqf5aGG11Z3W6tnoD/LRxhe/5ligFDMRFx7UARA4dyT3VRPU6u/sJmOLcTg8Rs58MZDSsEB7AOg==
X-Received: by 2002:a0c:aa09:0:b0:4c6:b65d:599a with SMTP id d9-20020a0caa09000000b004c6b65d599amr17016547qvb.35.1670790988996;
        Sun, 11 Dec 2022 12:36:28 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a424400b006a6ebde4799sm4515064qko.90.2022.12.11.12.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 12:36:28 -0800 (PST)
Date:   Sun, 11 Dec 2022 11:38:12 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y5YHdKvn6AY0o9Gc@fedora>
References: <20221210102110.443043-1-biju.das.jz@bp.renesas.com>
 <20221210102110.443043-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tcAAV/t5wr+DAqmn"
Content-Disposition: inline
In-Reply-To: <20221210102110.443043-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--tcAAV/t5wr+DAqmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 10, 2022 at 10:21:09AM +0000, Biju Das wrote:
> Add RZ/G2L MTU3a counter driver. This IP supports the following
> phase counting modes on MTU1 and MTU2 channels
>=20
> 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
>=20
> This patch adds 3 counter value channels.
> 	count0: 16-bit phase counter value channel on MTU1
> 	count1: 16-bit phase counter value channel on MTU2
> 	count2: 32-bit phase counter value channel by cascading
>                 MTU1 and MTU2 channels.
>=20
> The external input phase clock pin for the counter value channels
> are as follows:
> 	count0: "MTCLKA-MTCLKB"
> 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
>=20
> Use the sysfs variable "external_input_phase_clock_select" to select the
> external input phase clock pin and "cascade_counts_enable" to enable/
> disable cascading of channels.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Hi Biju,

I see you use rz_mtu3_request_channel()/rz_mtu3_release_channel() to
share access to the channels between the drivers. The Counter sysfs
attributes can still be accessed when a channel is released, so should
ch->is_busy be checked before every Counter callback to ensure we do not
try to access a busy channel?

> +static inline struct rz_mtu3_channel *
> +rz_mtu3_get_ch(struct counter_device *counter, int id)

I'm not sure why this is split between two lines but you can put it all
on one.

> +static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter, in=
t id)

It doesn't look like you're using the 'id' parameter in this function so
you might as well remove it.

> +	switch (id) {
> +	case RZ_MTU3_16_BIT_MTU1_CH:
> +	case RZ_MTU3_16_BIT_MTU2_CH:
> +		if (!rz_mtu3_request_channel(ch))
> +			return -EBUSY;
> +
> +		rz_mtu3_16bit_cnt_setting(counter, id);
> +
> +		break;
> +	case RZ_MTU3_32_BIT_CH:
> +		/*
> +		 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit
> +		 * cascade counter.
> +		 */
> +		if (!rz_mtu3_request_channel(ch1))
> +			return -EBUSY;
> +
> +		if (!rz_mtu3_request_channel(ch2)) {
> +			rz_mtu3_release_channel(ch1);
> +			return -EBUSY;
> +		}
> +
> +		rz_mtu3_32bit_cnt_setting(counter, id);
> +		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Instead of the two 'break' statements in the switch block above, replace
them both with 'return 0' and then you can get rid of this 'return 0'
at the end.

> +		if ((mtclkc_mtclkd && (synapse->signal->id =3D=3D SIGNAL_A_ID ||
> +				       synapse->signal->id =3D=3D SIGNAL_B_ID)) ||
> +		    (!mtclkc_mtclkd && (synapse->signal->id =3D=3D SIGNAL_C_ID ||
> +					synapse->signal->id =3D=3D SIGNAL_D_ID))) {

That's a lot of expressions to evaluate, so it's easy for someone to get
lost in what's happening here. It'll be good to refactor by spinning off
the signal check to a bool variable. For example:

    const bool is_signal_ab =3D (synapse->signal->id =3D=3D SIGNAL_A_ID) ||
                              (synapse->signal->id =3D=3D SIGNAL_B_ID);
    ...
    if ((mtclkc_mtclkd && is_signal_ab) ||
        (!mtclkc_mtclkd && !is_signal_ab)) {
            mutex_unlock(&priv->lock
	    return 0;
    }

William Breathitt Gray

--tcAAV/t5wr+DAqmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY5YHdAAKCRC1SFbKvhIj
K978AP4rlJF+CMEqeNhH0JEnBp+Uwnu8f52O3yHyerzIyFQc4wEA2FMTJn5KkCUa
owLllJviCULXVTtnDRUaAqI3u7fwaQk=
=P9x0
-----END PGP SIGNATURE-----

--tcAAV/t5wr+DAqmn--
