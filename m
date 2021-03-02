Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BADB32B3F9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Mar 2021 05:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbhCCEKR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Mar 2021 23:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbhCBP2W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Mar 2021 10:28:22 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A69C061A2B;
        Tue,  2 Mar 2021 06:56:54 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i10so4825393pfk.4;
        Tue, 02 Mar 2021 06:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U6T9PbU/F4qKp+N/YQtkVMfFVe3qnYSRW1k8rGsnvnk=;
        b=BBmSnXXr+94I6o1ekJr9V+ADvzDVATCFa7BccMr9FAJhc0gsyNi5pLeemmgdQhFhfL
         G9Mso1M/4bzUIVzexYT4ggJhMej38VIoGil1Z4SnggW/LKRm3OKV88h9RKKOh5p5XA5O
         15quSskjfkQTAlyI23i8U7rTHirlIoRTfyHu7ICnbuk7HM83LI1wZX/A7EB0E2imd2iz
         xF1BKS8jaXgWQyxjgf6YgnoiNuZP93gDZhF0xpDURqMZulbVP9RkSeV+hYme0zfuYbLo
         qAF5kB1a3JMgNlJyYknLMlLknaZZX9TduHtqiGBBNyn8KNgdpoQ/dmniWSptZtW5/VNM
         am6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U6T9PbU/F4qKp+N/YQtkVMfFVe3qnYSRW1k8rGsnvnk=;
        b=W3YWnCH501pDu4+z9L8NDRWe0j3Z3tjOU1mZMpTL5KvV3j8Wh+LJkg1GgT/2M1yQ9m
         SX31WuKf1dsXlsVDPdgMKRf3RI8+KadD3sw5pTHuE/wu9U7soz2J7N3N9Gh8kBjGs40f
         YLhLrMrCikD7GRY/dUUCQ0+fTrAH2itLKo5sHnmF0rTk5Oy6h/jdACxJC3Db3pLkPsZs
         97c9oVuv2MIvms5qKQ+NwYZhbwyK9xvcKku0xpUOH5+urJoDjNyYa4ajjffssGEYGRcy
         t15szaBQPNV8iWwzhKdDoo5GcHQBj9CMh2HxIF3h9vx8cMvD9KC4kHWJdFm3TClPUaiT
         j2rQ==
X-Gm-Message-State: AOAM530/w6S7DIdMb8n+7za6OBcteWEw0ltQZQ+pndhYLUBqA4ZQzVvR
        YZ6C8xmYP8OmI95j6w7YmgqlqRlUnJQ2kA==
X-Google-Smtp-Source: ABdhPJzkOHuxJPX9u8w6hzM1eTHou32whD5fTEDPdbRDsHCAUdvnl3kj6FbvUtuDUvEvuW3HZpIemQ==
X-Received: by 2002:a63:e747:: with SMTP id j7mr18301486pgk.235.1614697013985;
        Tue, 02 Mar 2021 06:56:53 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id s138sm22917284pfc.135.2021.03.02.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 06:56:53 -0800 (PST)
Date:   Tue, 2 Mar 2021 23:56:46 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, david@lechnology.com,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        olivier.moysan@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: fix ceiling write max value
Message-ID: <YD5SLrdttn+95M7N@shinobu>
References: <1614696235-24088-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wvX72FUvr+D6FcPx"
Content-Disposition: inline
In-Reply-To: <1614696235-24088-1-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--wvX72FUvr+D6FcPx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2021 at 03:43:55PM +0100, Fabrice Gasnier wrote:
> The ceiling value isn't checked before writing it into registers. The user
> could write a value higher than the counter resolution (e.g. 16 or 32 bits
> indicated by max_arr). This makes most significant bits to be truncated.
> Fix it by checking the max_arr to report a range error [1] to the user.
>=20
> Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
>=20
> [1] https://lkml.org/lkml/2021/2/12/358
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Side question: if priv->ceiling is tracking the current ceiling
configuration, would it make sense to change stm32_count_ceiling_read()
to print the value of priv->ceiling instead of doing a regmap_read()
call?

> ---
>  drivers/counter/stm32-timer-cnt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index ef2a974..2cf0c05 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -32,6 +32,7 @@ struct stm32_timer_cnt {
>  	struct regmap *regmap;
>  	struct clk *clk;
>  	u32 ceiling;
> +	u32 max_arr;
>  	bool enabled;
>  	struct stm32_timer_regs bak;
>  };
> @@ -185,6 +186,9 @@ static ssize_t stm32_count_ceiling_write(struct count=
er_device *counter,
>  	if (ret)
>  		return ret;
> =20
> +	if (ceiling > priv->max_arr)
> +		return -ERANGE;
> +
>  	/* TIMx_ARR register shouldn't be buffered (ARPE=3D0) */
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
>  	regmap_write(priv->regmap, TIM_ARR, ceiling);
> @@ -360,6 +364,7 @@ static int stm32_timer_cnt_probe(struct platform_devi=
ce *pdev)
>  	priv->regmap =3D ddata->regmap;
>  	priv->clk =3D ddata->clk;
>  	priv->ceiling =3D ddata->max_arr;
> +	priv->max_arr =3D ddata->max_arr;
> =20
>  	priv->counter.name =3D dev_name(dev);
>  	priv->counter.parent =3D dev;
> --=20
> 2.7.4
>=20

--wvX72FUvr+D6FcPx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA+UggACgkQhvpINdm7
VJJt3g/+OVZcvByeL/DXkUu5tzYQxQ5xzzfViSO16w54567c2tGJuB8gBEFaK9eG
Q5EzOeM9YaL982A/9OtqQup3CAJVkLizpy65aH1jDlPasA8JKKoelTfd+mAo58Vu
hiwG3DXxwOCZNB7b2/+RaKcYyayviVsKgrl8mHUQ1SY81kM3/cdzSLSnAoxkfD8o
7w1CdXnOxDvvTD6rwcbc4izhSSxgHzvaGHFpKwwYa3gDpmCY44rDKsgXc0CL6F2B
1JRDgvIePdqIStdC8VXcGkUwmlrEVwfSqFgbAtadWuwMSR293AR1PCayvsA4yWyo
49fMudR81RlG5aFyYoOWbAvoKpiq81LlGQspGWFcND4mdbDR7qvEeuZO//0wbTxk
5bNTj/VrQeSyNb7HmDFzOaKwF3waAnYpwZyOcUKVwzVNyAJkRq4nCPn29OKHE3mC
/Pbun8nAcbF0BP5R6QzX++aELtXzuArqJHOCDudTDQas0i7BNH0/+1KNKvisLTbk
6ftDbo0p3M90RUks08LLVpDzrAUGpyWeq7+VmWj1jHj22759PtbkEd/dxXKMkcQk
OwD4+2zRN4yq4J2U8oiofAprHHgidhAXPB+Qvy4GXP1SewZl3q+cXCNn20Se39Xw
uEDiJrNEX2zfbyRHx1V1zjqBlXFvCKIt62uqb8FBMmexuC5fmbc=
=M2Bd
-----END PGP SIGNATURE-----

--wvX72FUvr+D6FcPx--
