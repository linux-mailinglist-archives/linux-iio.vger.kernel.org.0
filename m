Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1276E96DD
	for <lists+linux-iio@lfdr.de>; Thu, 20 Apr 2023 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDTOS4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Apr 2023 10:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjDTOSi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Apr 2023 10:18:38 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5F6A69
        for <linux-iio@vger.kernel.org>; Thu, 20 Apr 2023 07:18:02 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-552ae3e2cbeso42405367b3.13
        for <linux-iio@vger.kernel.org>; Thu, 20 Apr 2023 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682000244; x=1684592244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4OthiTQi5MIchWRHYG+fyP1OoqMBojWRgyyG0qq6qA=;
        b=fNW/7REMOGl8bXgyhZlXFxndSbuVW9aF1h8gobbj0hcW8289ZHmg8kT8EwDokrFtmF
         Q9XO4QA0y9hbP6q/6B8OIEzPU7jnRWYVL2KqJTWGAWPPF5MBlClRBjk/NFco5ni8m0x9
         Ej1ojUdxTh+kCXHKfaciBYHdPqUeHfORVu7nJCKShbiKzRWQZZ2TFkq9/bK/TDPmDnaD
         M76Fbbq9sQDdMD/o0/xOOxxXS/kgSFoG/vD0HmVWTzkrOSw/wZ6v/1+00nsfWENwcyyJ
         u5IHQNpTmPD/xADC7PYd0t57m1K6Cqj9ltSXO1Arkmp3gCowgAk5qiYodovOkO0mw50w
         0NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000244; x=1684592244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4OthiTQi5MIchWRHYG+fyP1OoqMBojWRgyyG0qq6qA=;
        b=aYD1N2LQAoVdOxUPho0ttfQ4O5yCEZJsGMuqlyFz0vlrbwCVwFZ0nvXwSMRZlABlKB
         bmlTUaG4m/wsd1Ios9H+AGGY36PekEBJbaf84uObIzcQXmMndWDTLuaOyDofSgP3RbTw
         zqtu5amCvsvy0ALWIqw/36qZcy85zYHbDmlIdIC6c2TJqEC1TZITsYuj5BUND8gsSLlo
         ASlie0RYVJosj3n5f4Kczsm+HDjsXAg73ZtK4vbFVmOMu+0C0QrTysKN7oE76usCw8co
         L6Lm8GO2zxZnINflvC7ONgPmvQ3NYfY/DmWENkMTE4hOqe3O0fUaesVPWKIBSigXLRdt
         zk4w==
X-Gm-Message-State: AAQBX9fFT1nmgNSja6zqfKHtkYKmSOoEmNMWEdIqZiwyfJjME6omiYSU
        oCmEgV5wVaF3gV0WOmCncWYQmQ==
X-Google-Smtp-Source: AKy350YfTTxwKL6uu24U8dl2ICwdqz7fY1800aEL2ixgQRNkC5iEJHvea1OVRyMV0W4j0bKrCTmjGw==
X-Received: by 2002:a0d:e442:0:b0:54b:fe8c:350 with SMTP id n63-20020a0de442000000b0054bfe8c0350mr806084ywe.19.1682000244204;
        Thu, 20 Apr 2023 07:17:24 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h185-20020a0dc5c2000000b005463f6ae720sm356978ywd.68.2023.04.20.07.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:17:23 -0700 (PDT)
Date:   Thu, 20 Apr 2023 10:17:21 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, Lee Jones <lee@kernel.org>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] counter: rz-mtu3-cnt: Unlock on error in
 rz_mtu3_count_write()
Message-ID: <ZEFJcak7Gd/Xygf7@fedora>
References: <93ec19d1-3b74-4644-9f67-b88c08e79752@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uEJ5we3pG0TuqLXx"
Content-Disposition: inline
In-Reply-To: <93ec19d1-3b74-4644-9f67-b88c08e79752@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--uEJ5we3pG0TuqLXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2023 at 05:23:55PM +0300, Dan Carpenter wrote:
> The return -ERANGE error paths need to call mutex_unlock(&priv->lock);
> before returning.
>=20
> Fixes: 25d21447d896 ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

The changes in this patch are for rz_mtu3_count_ceiling_write(), so the
title of this patch should be fixed.

> ---
>  drivers/counter/rz-mtu3-cnt.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
> index a371bab68499..aeadce5e2853 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -358,19 +358,23 @@ static int rz_mtu3_count_ceiling_write(struct count=
er_device *counter,
>  	switch (count->id) {
>  	case RZ_MTU3_16_BIT_MTU1_CH:
>  	case RZ_MTU3_16_BIT_MTU2_CH:
> -		if (ceiling > U16_MAX)
> -			return -ERANGE;
> +		if (ceiling > U16_MAX) {
> +			ret =3D -ERANGE;
> +			goto unlock;
> +		}
>  		priv->mtu_16bit_max[ch_id] =3D ceiling;
>  		break;
>  	case RZ_MTU3_32_BIT_CH:
> -		if (ceiling > U32_MAX)
> -			return -ERANGE;
> +		if (ceiling > U32_MAX) {
> +			ret =3D -ERANGE;
> +			goto unlock;
> +		}
>  		priv->mtu_32bit_max =3D ceiling;
>  		break;
>  	default:
>  		/* should never reach this path */
> -		mutex_unlock(&priv->lock);
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto unlock;
>  	}

Normally, I like "goto unlock" patterns, but I think in this context it
makes the flow of code confusing with the mix-match of the switch cases;
default case jumps with a goto, but RZ_MTU3_* cases passes will break,
yet RZ_MUT3_* failures have a goto path. Rather than a "goto unlock"
pattern, I'd prefer to see simply mutex_lock() called for these ceiling
checks. That also has the benefit of reducing the number of changes we
have to make for this fix.

William Breathitt Gray

> =20
>  	pm_runtime_get_sync(ch->dev);
> @@ -381,9 +385,9 @@ static int rz_mtu3_count_ceiling_write(struct counter=
_device *counter,
> =20
>  	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
>  	pm_runtime_put(ch->dev);
> +unlock:
>  	mutex_unlock(&priv->lock);
> -
> -	return 0;
> +	return ret;
>  }
> =20
>  static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
> --=20
> 2.39.2
>=20

--uEJ5we3pG0TuqLXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZEFJcQAKCRC1SFbKvhIj
KwaWAQDrtAE9A2EV+jVUpAgaX49P4TZY3wFhb63I7ZQGEAxUbQD/fM/ZD3XvATwM
+l3FQ5J1LbG7YkKqDg+eF1CuSsNB/wc=
=+Bjj
-----END PGP SIGNATURE-----

--uEJ5we3pG0TuqLXx--
