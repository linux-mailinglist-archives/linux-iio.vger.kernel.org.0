Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660E1430CE2
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhJQXfu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 19:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhJQXfu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Oct 2021 19:35:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39129C06161C;
        Sun, 17 Oct 2021 16:33:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso13206442pjb.4;
        Sun, 17 Oct 2021 16:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P7aNeUKcIw+FFmjRjLdtQbrg8hRE0vUHKGwmbGg3MsQ=;
        b=LJCSIzns44P4F4e4GNg26v7yJxkermL6x6abN9HokumRULDJTDzPntDXK9xcY1VEou
         eCpJZznzBR8m0UJvJQ9X9PiQKcj8zwVCxqXh6lCK5o2H4k8WRwpFp0RvJwPCGewTdkWV
         BaFMPsa8vn7VH4WL38VKjaN1+55OrYWicP/RSmK1earac9fgMu5+/vcFIiRRtVDpbyt4
         CIoGbGzpC5t/rhtsAiYt/ic/bAEsEJvEoJ2rEELMIVK7+XVNmmg7ZXpnPorxLTnW3R1Y
         91jDoOzESFXMNwmr+gIwJbeVxq0jlviz2p+lWe/idMzmOpIAx+oa72/EPqm5WGKYHonU
         aNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P7aNeUKcIw+FFmjRjLdtQbrg8hRE0vUHKGwmbGg3MsQ=;
        b=uYgDpBEFKzkUNks7TszWb80QPOjxUeEot0Gx7ALGgSVrvBwuErRGVvI14JLqfyvOFY
         VWqhGMqSnax7YRsKD3goc/gcAb8jFO1ykvODoQpIIID6NMmocLGGN4wqzcVJxyb2pml3
         RBtCaCXuiMUdvVkygaVoase3tTROH+63gLGM8Huq+ajcYEbiIlOa/6YItTZAJL3dJ2jM
         r5VN1kD4JJ7e9ETn8CeL/jpST1Q+nW9ti1A/EwXiprXuFle3+YvczhuH0+1F8IIK6bgk
         pSCI/LkvwawZ6/SKpSifgTH3GX0Ki1bFspVy19KkZIsMwbznzQ6JKxiWygrj3CadXBpd
         gzWg==
X-Gm-Message-State: AOAM531VkyESIU6zeOsWhYgjcdZ6cu5Dl5QtmU9I5a7Jqzn7uQAzdcO9
        wbFaFrENkKSC+O+b0iKUdSjDfoLZ4RA=
X-Google-Smtp-Source: ABdhPJz68PwIQIzu5Lj9RNcIxYt3YdlO1S9xwFTW+ltl/3v7cAe4gNoddTizDhk/NRqq9h1g8Ca/Bw==
X-Received: by 2002:a17:90b:1a91:: with SMTP id ng17mr29400856pjb.61.1634513619413;
        Sun, 17 Oct 2021 16:33:39 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id z8sm8122502pgi.45.2021.10.17.16.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 16:33:38 -0700 (PDT)
Date:   Mon, 18 Oct 2021 08:33:34 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] counter/counter-sysfs: use sysfs_emit everywhere
Message-ID: <YWyyzmNGxWKyKiAD@shinobu>
References: <20211017190106.3472645-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t2Zsd0UZjI6gqdqf"
Content-Disposition: inline
In-Reply-To: <20211017190106.3472645-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--t2Zsd0UZjI6gqdqf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 17, 2021 at 02:01:06PM -0500, David Lechner wrote:
> In the counter subsystem, we are already using sysfs_emit(), but there
> were a few places where we were still using sprintf() in *_show()
> functions. For consistency and added protections, use sysfs_emit()
> everywhere.
>=20
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: David Lechner <david@lechnology.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/counter-sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sy=
sfs.c
> index 7bf8882ff54d..8c2d7c29ea59 100644
> --- a/drivers/counter/counter-sysfs.c
> +++ b/drivers/counter/counter-sysfs.c
> @@ -113,7 +113,7 @@ static ssize_t counter_comp_u8_show(struct device *de=
v,
>  		/* data should already be boolean but ensure just to be safe */
>  		data =3D !!data;
> =20
> -	return sprintf(buf, "%u\n", (unsigned int)data);
> +	return sysfs_emit(buf, "%u\n", (unsigned int)data);
>  }
> =20
>  static ssize_t counter_comp_u8_store(struct device *dev,
> @@ -196,7 +196,7 @@ static ssize_t counter_comp_u32_show(struct device *d=
ev,
>  	case COUNTER_COMP_COUNT_MODE:
>  		return sysfs_emit(buf, "%s\n", counter_count_mode_str[data]);
>  	default:
> -		return sprintf(buf, "%u\n", (unsigned int)data);
> +		return sysfs_emit(buf, "%u\n", (unsigned int)data);
>  	}
>  }
> =20
> @@ -300,7 +300,7 @@ static ssize_t counter_comp_u64_show(struct device *d=
ev,
>  	if (err < 0)
>  		return err;
> =20
> -	return sprintf(buf, "%llu\n", (unsigned long long)data);
> +	return sysfs_emit(buf, "%llu\n", (unsigned long long)data);
>  }
> =20
>  static ssize_t counter_comp_u64_store(struct device *dev,
> @@ -539,7 +539,7 @@ static ssize_t counter_comp_id_show(struct device *de=
v,
>  {
>  	const size_t id =3D (size_t)to_counter_attribute(attr)->comp.priv;
> =20
> -	return sprintf(buf, "%zu\n", id);
> +	return sysfs_emit(buf, "%zu\n", id);
>  }
> =20
>  static int counter_comp_id_attr_create(struct device *const dev,
> --=20
> 2.25.1
>=20

--t2Zsd0UZjI6gqdqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFsssMACgkQhvpINdm7
VJKnWw//XOxQqzTAjJZpNCzK9Oj8JxwVCdx5JLfqXZQvFSHPt1+nAPCrMmpBU0DY
aggTZ9uOFk9JYqSDHhqXiraJD5Hk6IN4wqEj9OliiLiukfe+5uPjGqOjTuHoCMBv
eZCtv9jIKYM1OQYzrqPaG+Gm6XDoAtxLEuxgRbF/fmKBoaaVQPC4bcZdmXptknWG
Jr4u4a+E+VnFl1Tukahno0a6ypHg5tSnJ3mYvmdo+XzMHbqImCM7eHPLP7SdS3Qa
QdBDV22/3wUSR7sCuqfolpJCjtBVA8as+grAoM3h/15gNoa8BmGD8ApIMz6JF94K
O0bRaF3wQaYZdho2cuKNhDHjltFw0HKeRM8TfIPkElFQ5it/0npzdrEXulLLvqEF
1Tjs2qAv8evj3qzyRKLm9wWCh5WcxllohkpHCHGPZPzdQhE63a4YKYJyHr/W6NjN
QVoJpjj9bS/nDF9VaR9pCol3Z8aZM0cK2/KB6t7B9l2Y5OBmWdxG+7Vmv8vG0Fa4
OBgZxSdCPBVP8lmenYs4PlwYkAnN31dRuprd4jyym13oFH1HhI3cRN7FI6enkHuT
Rom9wI8Hhr+ditnHS7qhbKGOdn+3gF1of5rxi1rkObURB33BsXLWDi8gVIrKDE73
YJ/+5VxPh9lp2sMnmaWTG81GwwYnzG/X4MB/YZUFFfKWBLPL3eo=
=wExR
-----END PGP SIGNATURE-----

--t2Zsd0UZjI6gqdqf--
