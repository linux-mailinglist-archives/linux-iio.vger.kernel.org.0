Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AD66281AF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Nov 2022 14:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiKNNxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Nov 2022 08:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiKNNxV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2022 08:53:21 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6925C7D
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 05:53:20 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d7so4980012qkk.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 05:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xB/o4S4c1Eq69YwW8XCN+naLCo6m7nKQdgmAZ6JlpPw=;
        b=WLwCl9FT2EPk6Dk6kzO6uHeZf0yxvQIYzbI2s531QWGFvH8AO70rIwTptaQnShrGbE
         LuDT0+KrVqK3+YeMIpYPuHW7/u8uS/hml+nmBYcg3ICwkdNsvI4mJ7zr0L44dExCmAS/
         ITAabEIDHhUzNyrad0y10mfsuQTZe9vw8IVchkap98UBiV2bRyj+jIZReEW9EKZ7eAxh
         r32Q96NcYI0jBfdVNYFgAoYGZQgRcm2YZsjzeTOKiK9ZFP8dEaWGN9R3Q3aaMrdT43Lm
         DwX4Uvze535ZKR5btygfbAnGlJL+l+gN6V1FcrS7Irc+QilZ5CSudnzVqub7hD0tSuPH
         HLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB/o4S4c1Eq69YwW8XCN+naLCo6m7nKQdgmAZ6JlpPw=;
        b=g2ndqjdoYIlsA3tzDc5mFb3FS1mcqJ8v/UrZr2fQjUxNoXc3R2Onc9m4+IyO85OYxe
         XTrGPSdyzW5v+yAeiv+azw+xuSKVXDT/cSYn9u4b+9WZTCqRXnisn6sSt2LHlFNIT9Fv
         SDtKblaBJcGqgCHeKyUQ8iwfDYKet0NcCSvOo6btTkg8nY3+Rv92jeRE3hkase4eLIIG
         x+2ncPAInKmfnM9W+WVvMykfUuLTEbV7wGVOJrx6KhrKtaxcwxNCfEdbu0R3ik2ZZtnW
         CyAPlavJAQFL+6/1G68Sbulk/gGmMs7gbK1rhcFeDCG3M+BEhk97HHkIw5fJJUvkwtrB
         yqqA==
X-Gm-Message-State: ANoB5pnKCyqPCsgrVLd3uwpcgGX3Fja+qYCOBxhi2wRTOaFHteVQV4B4
        xiVSenWLC+xAJIfeAJfBoRQaVA==
X-Google-Smtp-Source: AA0mqf7/tuufp/2ywDwnRwCDrrOhWF0TdfnN/OAQLpoUYtGJ5nPYvMQEbuvqwNQW5o5Lf+uq3gGlWQ==
X-Received: by 2002:a37:8747:0:b0:6fa:faad:2008 with SMTP id j68-20020a378747000000b006fafaad2008mr11047107qkd.668.1668433999853;
        Mon, 14 Nov 2022 05:53:19 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id y14-20020a05620a44ce00b006fb7c42e73asm1930292qkp.21.2022.11.14.05.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:53:19 -0800 (PST)
Date:   Mon, 14 Nov 2022 08:53:16 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y3JITA6sMp12XJmE@fedora>
References: <20221113171545.282457-1-biju.das.jz@bp.renesas.com>
 <20221113171545.282457-5-biju.das.jz@bp.renesas.com>
 <Y3G6Qe0KMdo2PgaG@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j606Cw4Et2h+lrt2"
Content-Disposition: inline
In-Reply-To: <Y3G6Qe0KMdo2PgaG@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--j606Cw4Et2h+lrt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Biju,

I have a few follow-up comments that came to my mind.

On Sun, Nov 13, 2022 at 10:47:13PM -0500, William Breathitt Gray wrote:
> On Sun, Nov 13, 2022 at 05:15:44PM +0000, Biju Das wrote:
> > Add RZ/G2L MTU3a counter driver. This IP supports the following
> > phase counting modes on MTU1 and MTU2 channels
> >=20
> > 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> > 2) 32-bit phase counting mode by cascading MTU1 and MTU2.
> >=20
> > This patch adds 3 counters by creating 3 logical channels
> > 	counter0: 16-bit phase counter on MTU1 channel
> > 	counter1: 16-bit phase counter on MTU2 channel
> > 	counter2: 32-bit phase counter by cascading MTU1 and MTU2
> > 		  channels.
>=20
> Within the context of the Counter subsystem, the term "counter"
> specifically refers to the device (Counts + Synapses + Signals). Instead
> you should use "count" here to refer to the counter value channels (i.e.
> count0, count1, and count2).

Include a brief description of the Signals and their relationship to the
three Counts as well in this commit message. In particular, mention how
"MTCLKA-MTCLKB" and "MTCLKC-MTCLKD" can be toggled for MTU2, etc.

> > +static int rz_mtu3_long_word_access_ctrl_mode_set(struct counter_devic=
e *counter,
> > +						  u32 lwa_ctrl_mode)
> > +{
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u16 val;
> > +
> > +	pm_runtime_get_sync(priv->ch->dev);
> > +	val =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> > +	if (lwa_ctrl_mode)
> > +		val |=3D RZ_MTU3_TMDR3_LWA;
> > +	else
> > +		val &=3D ~RZ_MTU3_TMDR3_LWA;
> > +
> > +	rz_mtu3_shared_reg_write(priv->ch, RZ_MTU3_TMDR3, val);
> > +	pm_runtime_put(priv->ch->dev);
>=20
> When you want to assign a bit to a buffer, you can use __assign_bit() to
> simplify your code:
>=20
>     unsigned long tmdr;
>     ...
>     tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
>     __assign_bit(RZ_MTU3_TMDR3_LWA, &tmdr, !!lwa_ctrl_node);
>     rz_mtu3_shared_reg_write(priv->ch, RZ_MTU3_TMDR3, tmdr);

You should consider implementing a rz_mtu3_shared_reg_update_bits() that
will perform this read =3D> assign bits =3D> write sequence so that you can
reuse this pattern in the rz_mtu3_ext_input_phase_clock_select_set().

> > +static int rz_mtu3_action_read(struct counter_device *counter,
> > +			       struct counter_count *count,
> > +			       struct counter_synapse *synapse,
> > +			       enum counter_synapse_action *action)
> > +{
> > +	enum counter_function function;
> > +	int err;
> > +
> > +	err =3D rz_mtu3_count_function_read(counter, count, &function);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Default action mode */
> > +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;
>=20
> You can exit early here depending on which ext_input_phase_clock mode is
> currently selected: if "MTCLKA-MTCLKB" then return early if id is signal
> C or D, while if "MTCLKC-MTCLKD" return early if id is signal A or B.

IIUC count0 is always "MTCLKA-MTCLKB", so this exit early check won't
apply in that particular case; check count->id to see which Count we're
handling.

William Breathitt Gray

--j606Cw4Et2h+lrt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3JITAAKCRC1SFbKvhIj
K/4uAPwK03T04Ol+4xn3gGkIe2NPkdCoDB/uouz6mzPsfd6VvAEA9npO2cIkO4ic
bBFjP6Yt6UPu2HL/LqPZ4hC8q9VL3QU=
=MBjZ
-----END PGP SIGNATURE-----

--j606Cw4Et2h+lrt2--
