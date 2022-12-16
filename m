Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70CF64EE9B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Dec 2022 17:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiLPQI6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Dec 2022 11:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiLPQIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Dec 2022 11:08:31 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB08FCF
        for <linux-iio@vger.kernel.org>; Fri, 16 Dec 2022 08:07:45 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s186so2315193oia.5
        for <linux-iio@vger.kernel.org>; Fri, 16 Dec 2022 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wZQdciJ80m6s5UTfdrnt4hMPxOVBONWu09gd90pOFc=;
        b=Smdcg79/uLlu0i32WncU4F46k9VhJzdqawr22drvjTsLJZsLLTGQGq7UrAhaiMaV2S
         ZSya255IGV6HmP/BtT2+pZtPI04G00TIQOqSjO3styncxCeHwdwKJXiwv4hUrFsrYL9N
         MpcRVPan+XoxS8Mln9+mC47OJg8YtC9rSk1EOgcY2/sU8FnBvFAdF3TysHOmbMN4U98J
         uDPJlEUdk+XFz6Mr1ljiB7UgrHnSf5Zb1GdmXwkGU8xb7mYzu2efKWGHprExxI1kbm0S
         Wr7/SpzpI3Xjc/iQvqFKdYLJfg1VuRWKeNyI8hzLkQuXNgjWhmas1YFWhU8V0UnAUgcz
         sR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wZQdciJ80m6s5UTfdrnt4hMPxOVBONWu09gd90pOFc=;
        b=xLcXtxN5tC++6D6K/jsYeTBQWxX54bzki9tkHrLU/MhL9wbarYKr2cp2YHPev9N08D
         +FWQOEzueKHEUbXc9ISW3NI8V++v3cE7QyoZk9LUBsZGjS3e4biKxTFMhkCJBNel12UB
         fTrOXngvbp4AYNk0HZ+hsgOJT5/Q6q+m7AvKglguX8OTpzdjIA9aUTZL/4z0UZfIBrkw
         xjai/d51TIv9GWgV8A7jlu8jzBY5YDrjPKwQmqShgubb1eldrsuNOM+MiKgxU8BNEjVL
         rWn6QATqQQ1yA9Fl4aZXByYfXnXjb6RvXyaEXBgnlzCQcvIMbABDATqMaa0qV4vkC7Gs
         DLQQ==
X-Gm-Message-State: ANoB5pkc+zdliHPhOQtDXdnBC97e3Sa9/4W4qVfAkuTW4oA3iWvmOvA9
        YJAQIC8Gi/Rm+yLPYoZ8KsVqvPa90IsLIHL1
X-Google-Smtp-Source: AA0mqf6ypQ/53tBmHOCEFTyT8QgcoQ6jEDvVItNaXWHtFcQ1UZvmGu8QoFJJW4FaPkJYZENF9tahwA==
X-Received: by 2002:a05:6808:f02:b0:35b:e81d:285b with SMTP id m2-20020a0568080f0200b0035be81d285bmr20540195oiw.28.1671206864683;
        Fri, 16 Dec 2022 08:07:44 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i11-20020a056808030b00b0035468f2d410sm839940oie.55.2022.12.16.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:07:43 -0800 (PST)
Date:   Fri, 16 Dec 2022 11:01:58 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y5yWdiAsMIUn9ehm@fedora>
References: <20221214103136.2493474-1-biju.das.jz@bp.renesas.com>
 <20221214103136.2493474-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m7L7RCD2atf4o9Ml"
Content-Disposition: inline
In-Reply-To: <20221214103136.2493474-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--m7L7RCD2atf4o9Ml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2022 at 10:31:35AM +0000, Biju Das wrote:
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

Hello Biju,

Do you need to take the ch->lock before checking ch->is_busy to ensure
it does not change?

Regardless, I have some race comments below.

> +static int rz_mtu3_count_function_read(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       enum counter_function *function)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u8 timer_mode;
> +
> +	if (ch->is_busy && !priv->count_is_enabled[count->id])
> +		return -EINVAL;

The priv->lock must be taken because count_is_enabled could change
after it's checked here.

However, you'll need to spin up a helper function because you're
currently calling rz_mtu3_count_function_read() in
rz_mtu3_action_read(). So move the implementation of this function to a
new helper function and call that here with the appropriate locks.

> +static int rz_mtu3_count_direction_read(struct counter_device *counter,
> +					struct counter_count *count,
> +					enum counter_count_direction *direction)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u8 tsr;
> +
> +	if (ch->is_busy && !priv->count_is_enabled[count->id])
> +		return -EINVAL;

This needs to be locked for the same reason as above.

William Breathitt Gray

--m7L7RCD2atf4o9Ml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY5yWdgAKCRC1SFbKvhIj
K3qaAQDWDwcdhlK4JJVaRqFOAWS842v0/JYaKZthvt3sNcfBQgD/UT4oONxz4fCX
E7zGBTjeipaBtM0U44jFiv9jPj2mDAI=
=fYL/
-----END PGP SIGNATURE-----

--m7L7RCD2atf4o9Ml--
