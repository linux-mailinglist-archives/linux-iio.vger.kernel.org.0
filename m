Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7476069F7AB
	for <lists+linux-iio@lfdr.de>; Wed, 22 Feb 2023 16:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBVPZE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Feb 2023 10:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVPZD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2023 10:25:03 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C4436FE9
        for <linux-iio@vger.kernel.org>; Wed, 22 Feb 2023 07:25:02 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h16so7722506qta.8
        for <linux-iio@vger.kernel.org>; Wed, 22 Feb 2023 07:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZUUszYUBJuIygu5ugPWWKs6MSDP6N1HTGCgT0QkanE=;
        b=S6H/wFmXoBlviglZVoFy2IH4be28n7AjiaGIj86FLOafVA+AMbiR+fHipL4c50v1qS
         WTeTBWvvmNbEiJEhNIydxVMHWcnh14onbjPcvkDOHzaaXqKB9TTM5dC5GW3ozdHmverU
         +YQ80Xu0fW97RHrrRla8zYGDJ6sh7/rNXWcX5guukIMfH6E2uRL7QGE1cFZzqPAk8YHq
         Vkn9F1PIHfKwBkvzIw1hBqfh8SR3h3ZC16qM4fLvXr0l9/dDrHa5IVu+D4G+KPJ7DmwY
         84HoeRlajQErPKePjtvlu8kjHnQc4C4wA5CfcOdQAMAENzMO2FHtCFfG613q6PJ4ipZ7
         Qi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZUUszYUBJuIygu5ugPWWKs6MSDP6N1HTGCgT0QkanE=;
        b=zZSyt5C/9BEzo5m3/9sh/0fumgV2X8YSvvPJg/kQVt9zUAQnrfo0xLKWhBHLkXtAwU
         1tSzOi7ZoMzTqB0jkd5dq+mP8FRSCQJkisUJgA8mo9Fhg9D+YcgFjgp6KNSkW5jH+YKI
         I2I7RywFSyUO6J3LPDgWnPbbwJ2uhCYfH5b4QfV6LVrlZZh7h2g1MV1cX37EyfrXacbT
         QEY0Pz9Dx193Z2FvLWrriIm4sMmqSLl8bV3j01nFgCpUt8aO9mKf0Cd0E5F0yCBfq+4b
         EhAHSeKOKyfL5g9OC/MZ7ZF19F2jXNocS4jokAQd7YleWRvL9kakbSz7hxcQKYmrDQZZ
         BsQQ==
X-Gm-Message-State: AO0yUKXL+5G0BhKLDNyr4hG7c6Hum8KLipxyowRg8/6HNJa0WPRfFyJ0
        8/XC4se3oogJJAYfuX/8iaxZWw==
X-Google-Smtp-Source: AK7set/TATz/WqxT0tVEvNzkZM9liR1Msabe2o1oZhYoAt1GoByzcNgMggq/KodxP8M9gXG1h8dlXw==
X-Received: by 2002:a05:622a:11c8:b0:3b8:691f:271 with SMTP id n8-20020a05622a11c800b003b8691f0271mr2284161qtk.63.1677079501208;
        Wed, 22 Feb 2023 07:25:01 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id m2-20020a375802000000b00725d8d6983asm2170098qkb.61.2023.02.22.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:25:00 -0800 (PST)
Date:   Wed, 22 Feb 2023 10:24:58 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 4/6] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y/YzylOMwUGK/Z0c@fedora>
References: <20230216203830.196632-1-biju.das.jz@bp.renesas.com>
 <20230216203830.196632-5-biju.das.jz@bp.renesas.com>
 <Y/YwzGWKyR4jhoFt@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1E0Qd/fefKwCx88o"
Content-Disposition: inline
In-Reply-To: <Y/YwzGWKyR4jhoFt@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--1E0Qd/fefKwCx88o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 03:12:12PM +0000, Lee Jones wrote:
> On Thu, 16 Feb 2023, Biju Das wrote:
>=20
> > Add RZ/G2L MTU3a counter driver. This IP supports the following
> > phase counting modes on MTU1 and MTU2 channels
> >=20
> > 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> > 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
> >=20
> > This patch adds 3 counter value channels.
> > 	count0: 16-bit phase counter value channel on MTU1
> > 	count1: 16-bit phase counter value channel on MTU2
> > 	count2: 32-bit phase counter value channel by cascading
> >                 MTU1 and MTU2 channels.
> >=20
> > The external input phase clock pin for the counter value channels
> > are as follows:
> > 	count0: "MTCLKA-MTCLKB"
> > 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> > 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> >=20
> > Use the sysfs variable "external_input_phase_clock_select" to select the
> > external input phase clock pin and "cascade_counts_enable" to enable/
> > disable cascading of channels.
> >=20
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> Hey William,
>=20
> Is this a review or an ack?
>=20
> It looks like there are deps on other patches in this set.  It's likely
> that the whole set with to in together via one tree (probably MFD),
> which I can make happen with the appropriate maintainer acks.

I reviewed just this patch in-depth so that's wherefore the Reviewed-by
tag. However, I do approve of these changes so please apply my Ack as
well if so neccessary to pick this up.

Acked-by: William Breathitt Gray <william.gray@linaro.org>

One minor suggestion is to include MAINTAINERS entries for the new
MTU3a core driver and PWM driver, but I'll yield to the respective
subsystem maintainers regarding that matter.

--1E0Qd/fefKwCx88o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY/YzygAKCRC1SFbKvhIj
K6fWAP9j+9UVZvePc+XQIMJ0MDkUSo2nKwEkWr8/dC2SulpjwgD+MLJlp9U2Dbxh
vWx5BbUaTk17vtClMHbc139itOhokwg=
=ZNOX
-----END PGP SIGNATURE-----

--1E0Qd/fefKwCx88o--
