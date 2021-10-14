Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFED42D2CD
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 08:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhJNGku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 02:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhJNGkt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2021 02:40:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67261C061570;
        Wed, 13 Oct 2021 23:38:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g184so4598015pgc.6;
        Wed, 13 Oct 2021 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0yvGAdlGwGjmIyVzlCTH27Niw9ewJoOJO9bhBri9ypA=;
        b=eT60p1AkePaLtDwuzgcfn7CjUMUZJZ2jz79ThxLTJFLdKYKpSSjImi+t6K1d8UZsVn
         uh8juQTXYfJASrN8UFVn9HENYga/fwSoWafGhwR6nGEMzEXz+sAPdLnpD2nXqQrpYJEM
         XF3i188QUXOui+Lw5tZFrhVNxN80QpTyvN8nypoLdc2iuJHLrsC/RbflIODKY5MA3eBr
         KhSE0ymdhusVh/aZMmax8X5D8//UQ1DzvuvnQCNqPMmy1zg4Zsx+28MdA1ZHOItAPztO
         o6xGPPcoZs3S37j2KbGLhkVlDF5TF49BUfuG3m+bl6Z9by7R2iZgXUrrJRXZdKvlDbX5
         s9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0yvGAdlGwGjmIyVzlCTH27Niw9ewJoOJO9bhBri9ypA=;
        b=0nAgsaGXxw1t4tAK2KZuIzipO4nlVDnLh5gwigIzi4B4Q+8qurCzjwUR28dluFXpOn
         d8HgGRrF8BMleVrYrJtaa0RThZVrb1IdHXgJLo6qi9bNpKYVX2B9PCgp8cNYcWjH7wbJ
         oqsL0dk+Bbm/MPyjS/wK88TeOLhfUdH6ocMcuOEXUzOY+QBe2zOchIf9mUoVSS/+HOCJ
         DfZozOqKnTMj6WQ15yG1R35fVR99Z95tGesOx4mD124mGgXLDNd697BwgdOyR/dS1W8y
         FIob+T0S4AsmSVnaRzp+sMmV2AvJzZufGbIP+rMnxtFhzvNxKlURVBQBNoJn+DjvYV3i
         8M5Q==
X-Gm-Message-State: AOAM531tUY7gvXnNDiAKC7lDVTBfZZ/52D80gNmI/c2wo3QgN1hoGAUu
        9+9QLKOt0CX+ydGoNXlGz5E0vh5enlA=
X-Google-Smtp-Source: ABdhPJztN0xFF3yKFMz/iJDeoME1t7GYr6HJYejtr0V32bNkr135zb/V7OOaeOdel1mLvwEq9lSfdw==
X-Received: by 2002:a63:3748:: with SMTP id g8mr2923207pgn.102.1634193524819;
        Wed, 13 Oct 2021 23:38:44 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id s2sm1379433pgd.13.2021.10.13.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 23:38:44 -0700 (PDT)
Date:   Thu, 14 Oct 2021 15:38:39 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YWfQb6O+HYGZf4iE@shinobu>
References: <1634095619-4174-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/acL0IA0evwDpukR"
Content-Disposition: inline
In-Reply-To: <1634095619-4174-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/acL0IA0evwDpukR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2021 at 08:26:59PM -0700, Qing Wang wrote:
> coccicheck complains about the use of snprintf() in sysfs show functions.
>=20
> Fix the following coccicheck warning:
> drivers/counter/stm32-lptimer-cnt.c:265:8-16: WARNING: use scnprintf or s=
printf.
> drivers/counter/stm32-lptimer-cnt.c:176:8-16: WARNING: use scnprintf or s=
printf.
>=20
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>=20
> Signed-off-by: Qing Wang <wangqing@vivo.com>

Hello Qing Wang,

Thank you for your submission. I believe these warnings are already
resolved by commit d70e46af7531 ("counter: Internalize sysfs interface
code") in the linux-next tree. Would you verify whether that is the case
or if we still need to fix this?

Sincerely,

William Breathitt Gray

> ---
>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
>  drivers/counter/stm32-timer-cnt.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-=
lptimer-cnt.c
> index c19d998..6f1113a 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -262,7 +262,7 @@ static ssize_t stm32_lptim_cnt_ceiling_read(struct co=
unter_device *counter,
>  {
>  	struct stm32_lptim_cnt *const priv =3D counter->priv;
> =20
> -	return snprintf(buf, PAGE_SIZE, "%u\n", priv->ceiling);
> +	return sysfs_emit(buf, "%u\n", priv->ceiling);
>  }
> =20
>  static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *coun=
ter,
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index 603b30a..e772586 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -173,7 +173,7 @@ static ssize_t stm32_count_ceiling_read(struct counte=
r_device *counter,
> =20
>  	regmap_read(priv->regmap, TIM_ARR, &arr);
> =20
> -	return snprintf(buf, PAGE_SIZE, "%u\n", arr);
> +	return sysfs_emit(buf, "%u\n", arr);
>  }
> =20
>  static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
> --=20
> 2.7.4
>=20

--/acL0IA0evwDpukR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFn0GIACgkQhvpINdm7
VJLiwxAAuzG/hybrpcaFNKO86nfLbe6lfxCeppv2YSTC+n8uuTMaltvBqX7+y5Vo
HLpnhgSqSQnBUy9lHzILySxYhgMEWjnoWKwakwmk1JMMV6odHcnCQZT5dgs+zihZ
UJqk4iKIZkhWdCxVF/BBtiPSrIvUE+NyJr+GSBwRrWofyiAfl3leI0fURiNscpPZ
tZGZqQ4wL2H46QowHRpXeK7jkg7S97v5llXJPnHjvVsaBVAfEs1wH0Qcv95eMV3M
YeZKe+4I7bne7k65821EkChZdVWBwXgJtefT9mLqmOBxt8B5Bl4YVFvFxpbKU+cX
XIUSq4pod6ywfBHTIUG3F9uD8/rNU9nGvYOLWxdD2wpFu16eFtJ0j6GIxzmEvEi4
wuH34aNLuyx62/MGwmnq3Z55SszgzgfxmTCHQetPajLgryV8m+4iTA+AVthtwVjA
6RL53DX3IhYNINspBdU0JcZcEGMlq8k33t6aBWnUxyv/4dBIdczIBH9lJJnyEUbQ
K9WnWLrj6e2/2IIJZAmVk8hSaMfm2+R0QvrZrGugK8k7JlWt1QGLkLyE2R5pfJvh
+CifKG7/hFrSEABvzi2TPjL3FHFR7XVRcPqV/AnfsvVKSbohx86mDymqwdXbad18
5PsGTsXrSCrZkC2pLBoyydMP4OtMxEqQPgcr1Uvzj0vIkUJXKIg=
=bXhQ
-----END PGP SIGNATURE-----

--/acL0IA0evwDpukR--
