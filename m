Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843C63E333
	for <lists+linux-iio@lfdr.de>; Wed, 30 Nov 2022 23:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK3WLm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Nov 2022 17:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiK3WLk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2022 17:11:40 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE87D8D665
        for <linux-iio@vger.kernel.org>; Wed, 30 Nov 2022 14:11:38 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13bd19c3b68so100241fac.7
        for <linux-iio@vger.kernel.org>; Wed, 30 Nov 2022 14:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pCusU2BJ3AKcUs3H3Y2D3hgYCxdx4f+iS/Ul4LVuyU=;
        b=olgD+zuE0H+I4nks8M+HL18aR6YwnxVl/XgX1xdITkFmdalzZCLz/w40bEle8BJYyE
         smuiwpALu4k30KMf+QUSyGk8AXGCOBdhkAYXDWljd+ML+2FFgUp2UvI3xST3XM74lbJ4
         xIVHpORo10eZ4f6GYMmFnFEqKPfLWAF4C0R7juSjQHASET9lcVPC8Ni+xQYezTkXly05
         WFOdvphGwz+/95JJRfPWHyljZAQtkY2ncpoo7JYDnLVm1w496tJ0dorpAFmdOissrVrk
         mzIbSe1WvtHtqvzjpFfDx66TQ4qGZgc2SLZOEHXHkq/nUfCf2PRFDK4PU5XJUpo/5ysj
         /8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pCusU2BJ3AKcUs3H3Y2D3hgYCxdx4f+iS/Ul4LVuyU=;
        b=nl4jCyg97e8Zd2bp6+moRQlsZonSFlHDL+FYAVBYTfv74dvWREuF6AbC+uY0UmTuhE
         qC2ioPdOpdk/D5STYUvrS+VgRuDgsfDMmFogpPLjPRZ5zU1CB4ATmC6s5GfZqx78q1J4
         OxBnFoNEBmwLRPIY/GBR8aF5dWe3N2lbgg3cgorPN1aEaEMafzseNGeDgJJzMo8I1hBR
         vD4USFd8OgRjka2f5D1GaGXy09/F96ApMZ5M68QFkcGTT1eFeqNdjEpdXMvV0rjcTKMd
         PvMp0cYEed5V13kAaeSHnjpz3KDSlexgWk/9sQ675hVkCr8AwVIp/qyO+I6RYb2dgJnw
         KGaw==
X-Gm-Message-State: ANoB5pkxKV2pUZ5pLvv2MBiZbzEUHziPujJ9mjfbjF7na6jrQ1p9R4tg
        tlhFvfJHdcLeIsG19EowukUWSkLfp/ZOUw==
X-Google-Smtp-Source: AA0mqf5zf/1QpNqzGWYrGkedQ2NDVBMvpc2HmLZ9CMm4xVmsOqD1pcdFEngAa7tDxhMcrNIT6tePLQ==
X-Received: by 2002:a05:6870:805:b0:13b:f163:2732 with SMTP id fw5-20020a056870080500b0013bf1632732mr24537280oab.192.1669846298072;
        Wed, 30 Nov 2022 14:11:38 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id y6-20020a544d86000000b00359af7ea8fdsm1094236oix.34.2022.11.30.14.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 14:11:37 -0800 (PST)
Date:   Tue, 22 Nov 2022 09:12:22 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 3/5] Documentation: ABI: sysfs-bus-counter: add
 cascade_enable and external_input_phase_clock_select
Message-ID: <Y3zYxtelBVrdbQ9g@fedora>
References: <20221124170018.3150687-1-biju.das.jz@bp.renesas.com>
 <20221124170018.3150687-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0GvAFZQ6lniQ9bB2"
Content-Disposition: inline
In-Reply-To: <20221124170018.3150687-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0GvAFZQ6lniQ9bB2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2022 at 05:00:16PM +0000, Biju Das wrote:
> This commit adds cascade_enable and external_input_phase_clock_
> select items to counter ABI file.
> (e.g. for Renesas MTU3 hardware used for phase counting).
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

I have a few comments below left for this patch. Assuming these are
resolved, then I expect to ack this patch in the next submission.

> ---
> v6->v7:
>  * Replaced long_word_access_ctrl_mode->cascade_enable
>  * Updated Kernel version
> v5->v6:
>  * No change
> v5:
>  * New patch
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index ff83320b4255..abc691b13b0f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -215,6 +215,22 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		This attribute indicates the number of overflows of count Y.
> =20
> +What:		/sys/bus/counter/devices/counterX/cascade_enable

It's possible that in the future we might cascading other things as
well, so let's make this name more specific: "cascade_counts_enable".

> +KernelVersion:	6.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute indicates the cascading of counts on
> +		counter X.

Add a line stating this is a boolean attribute: "Valid attribute values
are boolean."

> +
> +What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_sele=
ct
> +KernelVersion:	6.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute selects the external clock pin for phase
> +		counting mode of counter X.

This is a driver-specific enum attribute so it needs a corresponding
*_available entry. Take a look at the count_mode_available entry in this
file and use that as a template to create a new entry block for
external_input_phase_clock_select_available.

> +
> +What:		/sys/bus/counter/devices/counterX/cascade_enable
> +What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_sele=
ct

These two lines are missing the '_id' suffix: "cascade_enable_id" and
"external_input_phase_clock_select_id".

William Breathitt Gray

>  What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
> --=20
> 2.25.1
>=20

--0GvAFZQ6lniQ9bB2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3zYxgAKCRC1SFbKvhIj
Kz9oAP9F+PSra8JOBHkj/x7nPzOH8BvL4duP8H2D0Mj2FWLipgEA36dRN5SqoW+G
yI4n7OrXnodaMagkzEINkf0c26muSgM=
=+Yh7
-----END PGP SIGNATURE-----

--0GvAFZQ6lniQ9bB2--
