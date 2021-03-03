Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E1932C6D4
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 02:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbhCDAaI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Mar 2021 19:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353097AbhCDADM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Mar 2021 19:03:12 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D203C0613EF;
        Wed,  3 Mar 2021 15:42:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d13-20020a17090abf8db02900c0590648b1so3602946pjs.1;
        Wed, 03 Mar 2021 15:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hjgPPmywlf1QSYNfKJW5SMSSqegjS9TRhykusa53eQA=;
        b=dN8ygrrTTwV4ktjEHcHhP03Z9wjYOZjF/ycGhN3zk86kSOtDSrEdVSNc41fhWog3nl
         Akf+Jf7wsMpO711LTcYpfssJjZSkJlYLFoQYRoDG4R7pIZLNveQL3dyhYi1De2wcyqAr
         HbO+Ar1A2au11Fv4Ge8mvwaTOEmv9cmu81fpuFcmGFITNIHUhLzSSTF8Gkmp8L6vC+4s
         faHJMm2eP/PSRQzvOHWMQ2T1cYqR8N+isV3kWv4ZT1kzbpKJRXNjj/DQb1PokclVp0OU
         hG7LQ5lnc81fZfncULV5+aLf8jP8dI4RcvItz6GEsNDXWr2BxW6fo80bNMzxTRAYY97+
         d9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjgPPmywlf1QSYNfKJW5SMSSqegjS9TRhykusa53eQA=;
        b=M/ALvLt7a0ya9+wE1mXkjlhd6syER5+qhwzmROZleqooJ5rJ5R/z0G41AnPAlE+rg5
         olouRe9lcsraiU7VpATiDbx6zuBc97ILw+VyCyZKCM/k6piAVr9Gb9cgcPNzt5YT3vca
         uzjb3xk0CoXpad5DvjsvMYOPNMBp8a2Bduwe6UszVgPYpOsPSaB5MPLYGo9+a9YLaqqD
         IBRXXkx7w1qJHSRuLx+11/daV6kuFGUU1zsmLkgTy4vIgE6043sOyvVHuWIAwhcPpvDf
         RSBcEJnKIALh3wreKeZUaj4ira6mHFQFkKJr6OeZLHXlwQsZ+g7/LsfbPQah8VLOd+fJ
         eUsQ==
X-Gm-Message-State: AOAM533lgH7jfW0d5oEzXlw0szpf4W7Z0yBAgn8ZoMVX1y9r+bcjAtYv
        bxXg7z8/pUcWhSjvp51kdeY=
X-Google-Smtp-Source: ABdhPJxaFhX6y72z2rrx4+W3Hx9RpBqhn1GmJBKZd55ZtXtJoGXyOZDcokuYHn2nQp54M8CAl6d5Qg==
X-Received: by 2002:a17:903:2082:b029:e3:df7c:f30 with SMTP id d2-20020a1709032082b02900e3df7c0f30mr1396147plc.71.1614814928804;
        Wed, 03 Mar 2021 15:42:08 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id h8sm24219343pfv.154.2021.03.03.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:42:08 -0800 (PST)
Date:   Thu, 4 Mar 2021 08:42:03 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, olivier.moysan@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: fix ceiling miss-alignment
 with reload register
Message-ID: <YEAeyyJ+GH10ep7S@shinobu>
References: <1614793789-10346-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="raztPjiYvdctBTkF"
Content-Disposition: inline
In-Reply-To: <1614793789-10346-1-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--raztPjiYvdctBTkF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2021 at 06:49:49PM +0100, Fabrice Gasnier wrote:
> Ceiling value may be miss-aligned with what's actually configured into the
> ARR register. This is seen after probe as currently the ARR value is zero,
> whereas ceiling value is set to the maximum. So:
> - reading ceiling reports zero
> - in case the counter gets enabled without any prior configuration,
>   it won't count.
> - in case the function gets set by the user 1st, (priv->ceiling) is used.
>=20
> Fix it by getting rid of the cached "priv->ceiling" variable. Rather use
> the ARR register value directly by using regmap read or write when needed.
> There should be no drawback on performance as priv->ceiling isn't used in
> performance critical path.
> There's also no point in writing ARR while setting function (sms), so
> it can be safely removed.
>=20
> Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
>=20
> Suggested-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
> Note: this applies on top of:
> - "counter: stm32-timer-cnt: fix ceiling write max value"

Note, if your patch requires prerequisite patches, please provide the
`git patch-id --stable` patch ID for it; this helps make sure the
patches are applied in the correct order. You can have `git
format-patch` generate this automatically for you by using the `--base`
option:
https://git-scm.com/docs/git-format-patch#_base_tree_information

William Breathitt Gray

> ---
>  drivers/counter/stm32-timer-cnt.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index 2295be3..75bc401 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -31,7 +31,6 @@ struct stm32_timer_cnt {
>  	struct counter_device counter;
>  	struct regmap *regmap;
>  	struct clk *clk;
> -	u32 ceiling;
>  	u32 max_arr;
>  	bool enabled;
>  	struct stm32_timer_regs bak;
> @@ -75,8 +74,10 @@ static int stm32_count_write(struct counter_device *co=
unter,
>  			     const unsigned long val)
>  {
>  	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	u32 ceiling;
> =20
> -	if (val > priv->ceiling)
> +	regmap_read(priv->regmap, TIM_ARR, &ceiling);
> +	if (val > ceiling)
>  		return -EINVAL;
> =20
>  	return regmap_write(priv->regmap, TIM_CNT, val);
> @@ -138,10 +139,6 @@ static int stm32_count_function_set(struct counter_d=
evice *counter,
> =20
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> =20
> -	/* TIMx_ARR register shouldn't be buffered (ARPE=3D0) */
> -	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
> -	regmap_write(priv->regmap, TIM_ARR, priv->ceiling);
> -
>  	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
> =20
>  	/* Make sure that registers are updated */
> @@ -199,7 +196,6 @@ static ssize_t stm32_count_ceiling_write(struct count=
er_device *counter,
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
>  	regmap_write(priv->regmap, TIM_ARR, ceiling);
> =20
> -	priv->ceiling =3D ceiling;
>  	return len;
>  }
> =20
> @@ -374,7 +370,6 @@ static int stm32_timer_cnt_probe(struct platform_devi=
ce *pdev)
> =20
>  	priv->regmap =3D ddata->regmap;
>  	priv->clk =3D ddata->clk;
> -	priv->ceiling =3D ddata->max_arr;
>  	priv->max_arr =3D ddata->max_arr;
> =20
>  	priv->counter.name =3D dev_name(dev);
> --=20
> 2.7.4
>=20

--raztPjiYvdctBTkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBAHsEACgkQhvpINdm7
VJI4JRAAg2Y+kgxmuZE/9tSHqFDyqpU5z9TnfxJDAHoWYVt8MfIys2u8zR3ZkbXj
ipa30R9WdJYB4btIdhNKKalhJGO47qYhPE7jw0f4WhRgyVkSIfuYRaXFHbQ7a4+P
OwqKTLDsrSDz6RL17JKkLb7Ks5ROrVHnl9OYAjhRupTY2WMAEza2gcPhcKOwsSo6
9eL6p0rB9/NMUhBi+DRLe/tkwxZH33nm0Re8wI27Ujx59R3rP3ZPzk0vgBpX1upd
JXRKbnsIjxj47waBbDAQx2DQp14NgHNEdPxNgJlzmQMB6bRdSw1xVhR93Z0w9rVK
TGLFiMe2RBvwHB0MuOm75dsOwvlSbg/eLiK3LUS7DDzg8GPmpkPOX387ONmj6EOw
QiI0JaMTLYodBXiD2gwQf0h8m1k3/tlXcnL8/4+8nMNt8TDvxuP1XdGajhEOhMOE
mNeb+SHFZ3D5NPh9/Ce3coLWJrNYcE+UwIhp/BGyfm+gQPuUbDG1lh3a7voQsa9I
jGgzo5tBFWSrUfLzGrV+kqTNMM987H9/ykMkydimcqFTWcj0z7Xy3XEEEarPOg5r
Cu0UvU4+CbIvccsXtLYWs6kjJQuaemL5eX7Oqh9qQunN07o5xbVFLCwH7+g/0AcH
BgC31bYF6EdEBeknuEtMugdRXnKvQYfJVfX8xmNdtDv2+dDVKWo=
=IqtO
-----END PGP SIGNATURE-----

--raztPjiYvdctBTkF--
