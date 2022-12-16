Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D488D64F372
	for <lists+linux-iio@lfdr.de>; Fri, 16 Dec 2022 22:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLPVrx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Dec 2022 16:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLPVrc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Dec 2022 16:47:32 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A581C10574
        for <linux-iio@vger.kernel.org>; Fri, 16 Dec 2022 13:46:59 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z12so3814000qtv.5
        for <linux-iio@vger.kernel.org>; Fri, 16 Dec 2022 13:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ltxYiMcDp/+n0b5TeZV7USHmhTekrJBxIGa3IMg28oc=;
        b=FahQsH14JezFaM0pkbG6xp+fUpdhoF/MegJn8ipY3q+ZqABKAGWoVA4uTh55BtNX6G
         /0Zd0iNYpq+Hyqf2kznXeEWPqsGk4VYOF5iYOiIeACP8f5HtMMRf5H+InMfnvn3RmdiQ
         nB+F9kU/UJEswBtCiObOhZQJQewj770gdUUYp6PshNaqV1UaOVEWb6EuIzo3Ifwn3coD
         e0Gwk9LWavHBYyA+MSZlPBcX53n0lWxk31VJgacWc814I+Mn/VNA2vtqNMs20zXodCBF
         kd+5dWza47pUxh4YqXWnR+LmOXDSG0ATADwS1VSKDL6XUkMQO+gIBs3KtHHZZnE3SiyB
         SssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltxYiMcDp/+n0b5TeZV7USHmhTekrJBxIGa3IMg28oc=;
        b=3W8RPFJZxtiPgU+xRQvBSQo1HPLmp4+nG1tgpKqfMWH1ppEZ8HUHfM9rqCGwAvey6K
         saabPpYXHGaIvImGvFZM+3mD4pBffX5E8F5fvXqm704UDfVbEmwfVr2HVBRCwI4fwdhf
         DmHYxVw+lYY8B4a4duJxU6sHp2n5yjdblxXCVQeCR7ihDZc8uEhvVA7W8Qix2BRfyx1r
         vsObfdqDDEQsrQwKnX0R8jjV7fZfO5gjiXCGoAHhyyqjma4G/WTi/cInZoN5809r9QrW
         +sHyMD3n32bYFxtK8wpJ5UvsM8EJ08vC5SXDNS/7Uwgle+NveFS9Zec9nvC4YQVYgxhr
         3Xow==
X-Gm-Message-State: ANoB5pkuZm0hGXDsa2M5CpCquNl6IjxEWipFyVP4pMFa7l1aMwnjlB5T
        g3IA3hkRqeoOOVhys6HJTpjYRA==
X-Google-Smtp-Source: AA0mqf5ovlRh5SiNY3ALHe/Qy3P0DidhZKB+xJWY18whR+Gr3mEggIDMU1B1sA0b/+jJCzJqx0RbTQ==
X-Received: by 2002:a05:622a:229d:b0:3a6:9793:d4e2 with SMTP id ay29-20020a05622a229d00b003a69793d4e2mr40309138qtb.66.1671227218730;
        Fri, 16 Dec 2022 13:46:58 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h5-20020ac87145000000b003a69225c2cdsm1964770qtp.56.2022.12.16.13.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:46:57 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:45:19 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v10 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y5zm78UPXQMc3gjp@fedora>
References: <20221216205028.340795-1-biju.das.jz@bp.renesas.com>
 <20221216205028.340795-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="riS0ngB9t/Qpq7S3"
Content-Disposition: inline
In-Reply-To: <20221216205028.340795-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--riS0ngB9t/Qpq7S3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2022 at 08:50:27PM +0000, Biju Das wrote:
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

You're missing an entry for this driver in the MAINTAINERS file so
please add one. The code for this version looks good so you're welcome
to add my Rb line.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

I do have a minor suggestion below.

> +static struct counter_count rz_mtu3_counts[] =3D {
> +	{
> +		.id =3D RZ_MTU3_16_BIT_MTU1_CH,
> +		.name =3D "Channel 1 Count",
> +		.functions_list =3D rz_mtu3_count_functions,
> +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> +		.synapses =3D rz_mtu3_mtu1_count_synapses,
> +		.num_synapses =3D ARRAY_SIZE(rz_mtu3_mtu1_count_synapses),
> +		.ext =3D rz_mtu3_count_ext,
> +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> +	},
> +	{
> +		.id =3D RZ_MTU3_16_BIT_MTU2_CH,
> +		.name =3D "Channel 2 Count",
> +		.functions_list =3D rz_mtu3_count_functions,
> +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> +		.synapses =3D rz_mtu3_mtu2_count_synapses,
> +		.num_synapses =3D ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
> +		.ext =3D rz_mtu3_count_ext,
> +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> +	},
> +	{
> +		.id =3D RZ_MTU3_32_BIT_CH,
> +		.name =3D "Channel 1 and 2 (combined) Count",

These channels are actually cascaded, so replacing "combined" with
"cascaded" here would be better.

William Breathitt Gray

--riS0ngB9t/Qpq7S3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY5zm7wAKCRC1SFbKvhIj
K49yAP9awI8QZ+IehAEM+ZvyGlK1CwT7qbO6U3bZs8V9UJMhcgEAkOs4CPLYEJFj
PFabwNpN7aaDnRCf/eNIdiueNpIjyg4=
=mBm0
-----END PGP SIGNATURE-----

--riS0ngB9t/Qpq7S3--
