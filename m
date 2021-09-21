Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5939412BB9
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 04:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhIUC1K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 22:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhIUB5X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 21:57:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072FAC09394C;
        Mon, 20 Sep 2021 17:36:27 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y8so17785292pfa.7;
        Mon, 20 Sep 2021 17:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cniUdreHiCHMT5ns8G46HdG+OfudgFB1AyPe8/gK+pc=;
        b=CqpdsuCBg3qTRIgmSSlMVT681A/+nouy/1Gu0HK2B/zO9vag5j+25tmMkvKxuQS8cJ
         svqRxuEtQAFYIez+h4tkiI8sOJMeFgMLLTFQtFphGFwKn6yJo59ohkwXFkCbRBzNbsBO
         4fqEdg9/Lmj8P8xDob586/zXmZI/Gsycr87c30Z8kCZR7hylvvSfRu4LBOH32FhmLZcy
         PZh00LhH1ZIkTZ2jFAV9+4IyWISyVJwgc9PYH8msZW03HYzdZojpFM+ryX2yMlmf9j4X
         xwWrn79hMnMOabr9HYplZ+YC//nQ5q4eT2rWRAMuD/0CuAev00SMsBP2Ubs4Ps9zgeGa
         kpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cniUdreHiCHMT5ns8G46HdG+OfudgFB1AyPe8/gK+pc=;
        b=jkC3+IfuvTTcgnYQAqbIKnrXbQTweMYRECHHbINnHF4HbQ8hD0iH/3qcvkv4GcYk8B
         FZLLybbEYKCadcyvWKYTTVnzoPkiGNN8Pzi6NjnHFPFXfIh7GlZtluV+q1ggYuUMaOIW
         gBbNmQI4blgKw2GzWguGcv5I+kP0GfkRXFGjotk3qnIVEmQoQwOrPTfN8lvgbPnP8uZv
         IPhEkJOVwNWjxUbQjEHh+8ec5+Ay604n36dZLxlNwaesocB/IniewEZr4ty/SIjaiHju
         qGhYLdqAeL/iu0N9cOfM5JN/5pIbzpZVdFyNTNKyqDtRTZeAprUJ2+GT02InRkMhgmE6
         kx4g==
X-Gm-Message-State: AOAM530x7bO7/ptNCY13Xxd5vgjhdH1b3pOW6DCajFYpRSpNySKIjPUo
        SoZqHp1Jk5SVBDPcnyUhfbM=
X-Google-Smtp-Source: ABdhPJyg5fA3YNTfw25nTy+yPCOcWknuGFdupmOQNRk87gm9M0Z3GCy1Vvg+Q+iurulnVxTK6BdLIw==
X-Received: by 2002:a65:6084:: with SMTP id t4mr25815700pgu.25.1632184586371;
        Mon, 20 Sep 2021 17:36:26 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id cl16sm525639pjb.23.2021.09.20.17.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 17:36:25 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:36:21 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Tim Gardner <tim.gardner@canonical.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] counter: Add default statement to switch() in
 quad8_function_read()
Message-ID: <YUkpBU8mN4yrDfu5@shinobu>
References: <20210920173737.21445-1-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HythAOZC1Hzy03vF"
Content-Disposition: inline
In-Reply-To: <20210920173737.21445-1-tim.gardner@canonical.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--HythAOZC1Hzy03vF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2021 at 11:37:37AM -0600, Tim Gardner wrote:
> v2: Add the correct Cc's
>=20
> Coverity complains of a possible use of an uninitialized variable
> in quad8_action_read().
>=20
> CID 119643 (#1 of 1): Uninitialized scalar variable (UNINIT)
> 4. uninit_use: Using uninitialized value function.
> 346        switch (function) {
>=20
> The call to quad8_function_read() could theoretically return without
> assigning a value to '*function', thus causing the use of an
> ininitialized variable 'function' in quad8_action_read().
>=20
> Fix this by adding a default statement to the switch in
> quad8_function_read() and returning an error.
>=20
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>

Hello Tim,

The possible values of quadrature_scale are hardcoded in
quad8_function_write() so we should never have scale value greater than
2. But it would be a good idea to provide a default statement here to
pacify the warning, or at least mitigate shooting ourselves in the foot
in the future if this part of the code is changed.

Please add a comment similar to the default statement in
quad8_function_write() indicating that we should never reach this path,
and also return a more informative error code such as -EINVAL.

William Breathitt Gray

> ---
>  drivers/counter/104-quad-8.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index c587f295d720..3a69d35b82ea 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -215,6 +215,8 @@ static int quad8_function_read(struct counter_device =
*counter,
>  		case 2:
>  			*function =3D COUNTER_FUNCTION_QUADRATURE_X4;
>  			break;
> +		default:
> +			return -1;
>  		}
>  	else
>  		*function =3D COUNTER_FUNCTION_PULSE_DIRECTION;
> --=20
> 2.33.0
>=20

--HythAOZC1Hzy03vF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFJKPsACgkQhvpINdm7
VJIiZhAA2rg9z3AEU70ox2VvMtYi6XHJmVlxpWLMeyMtXg0TJEe/a+U/dt7YyCnG
ThB1GAUTO/YbzlMhnZH66Btczttvp67tDZ10fzgXxpHIdbxou/SuP5RR42TWZ1GL
MwYpUML9+765jb9jKtVnys1ovewol4Ks0enEKWYKHgz2iQKbYZP9q3g8ky9zHA9S
7u4KZbW0z5wCNDLoQ6GtF/sc7Soxjn51pDLQgZL8njN9ERdSQlqNSrxIL/DekeKy
Om+G/hWbIIOO1VY2FInnvdGisidXarDLsJWzhNbxj9TjBIhbVnstrDjGkgtpfeY6
AX0kk6osuRQBJ6eFRzZJulH1q7k6QfmtCZ8vWGhyfPNScJaqVIpf3n2tZmhDkvfk
9xXmGC/rQytVzQE5r6H+1xXbIuurmG/UbH/BBd7aCSz5SPkil7gYjgcgy1c3Qri8
JARzG/REVSx6kR/B2XINJthOkKx7EZcA1pc+eevwjxEBLpP9Dsg1HKkSpEsm7JWX
yCtbOfzHgSMqA7n8CkMlwFc0if2CTEuBxEawV8sdsisFIAGtkNO9cxKeCY27v2HJ
i5HqWfKvMrmafRCt+E3fxgNp0WI2zpRaoXiUFl3V16PfpZjn32IMkCIuKgdHZLh0
KxpUMRbK2Fm8sORr+VUIj2IveVkxwSH1NpjL4/kLG1oKnoH8rls=
=ZR16
-----END PGP SIGNATURE-----

--HythAOZC1Hzy03vF--
