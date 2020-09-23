Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D657274EB4
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 03:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIWBtB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 21:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWBtB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 21:49:01 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30334C061755;
        Tue, 22 Sep 2020 18:49:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so17375207qtv.12;
        Tue, 22 Sep 2020 18:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X9uNPzY+kbe4wa6xwtAwYFztuqUdYMBDLfnDNt+LMK4=;
        b=Iy+cU19p3ID4fWUzJ4+y5RoTaznblfmPAoP2x7nMaeWBjBVug7MB0iwXkCU7sZxkTL
         4S2TzaIJ1W2LnG12r/Kd8h8qR2FDnlIixibHw8JTS2PfOLZhcOKy+sN/Kz3c9Dc7jft3
         2gTL9U7TQnSiaJS2kHnzMIXnkNiS+wBiO4gchFzWXOqUQ9yN6uS2ggvUqE7OxLhfuQfb
         k/4TMg/9NPSZcsxFEY3BKmuIpbUl/pJwK3aPih4wnfbtyUpNqgZrCSCWO/EjNIu3aMn2
         dfwx1/hMeLq+qXxxksF1ZI8oNP1PwphPafhnohWXPp8QI6I8//inJJCpYo8Jm8lizK11
         Xoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X9uNPzY+kbe4wa6xwtAwYFztuqUdYMBDLfnDNt+LMK4=;
        b=XmfYShBYNuNzpHea10DLMx/uoFxV/CUIZ7BwuZkRAmD88YNNLIdYInJckWsgNWLYo2
         a09fDBk5igfAVo02ozogYPwJ4kXSCNieIn/NYe5jPllVi+wzzrdUgmGzVQbS+eK72Sjf
         A73F6C3Fn56O3SaSyFRBA+WKobN1o/Gb2BML9Lep9MUZEOC/jKppqFtkjut9fEmlri6I
         TOZXXwDtKj7eRPvYrBHBEF5GBSmBLxBpdnj6iPKlppBqqEUJ0nTYe3/35u26c9EM4mbk
         L2RMNvwo/GXmwqtFoUtiEs4mO0bWmS9LlR/NZ8eQpwPt4jv9lsGwtSCGBlKGIO/KKWjw
         rCIQ==
X-Gm-Message-State: AOAM532ASg/SzNlxqN1RiwHAnQe7a5oQhpTfpE9qZ4habkoiMKaCDkzk
        WyyaLSOS7zAep0vD8wIazTg=
X-Google-Smtp-Source: ABdhPJxt1iMhkeV3PFsfjQ9tysdSfHw6UxkFzaXZ88od3R2WdGYz2AgC3VYKnrCqgPigtp77o9G9FA==
X-Received: by 2002:aed:2963:: with SMTP id s90mr7801958qtd.381.1600825740262;
        Tue, 22 Sep 2020 18:49:00 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u13sm13550546qtv.57.2020.09.22.18.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:48:59 -0700 (PDT)
Date:   Tue, 22 Sep 2020 21:48:38 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Constify mchp_tc_ops
Message-ID: <20200923014838.GA3267@shinobu>
References: <20200922201941.41328-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20200922201941.41328-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 10:19:41PM +0200, Rikard Falkeborn wrote:
> The only usage of mchp_tc_ops is to assign its address to the ops field
> in the counter_device struct which is a const pointer. Make it const to
> allow the compiler to put it in read-only memory.
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/microchip-tcb-capture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index b7b252c5addf..039c54a78aa5 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -253,7 +253,7 @@ static struct counter_count mchp_tc_counts[] =3D {
>  	},
>  };
> =20
> -static struct counter_ops mchp_tc_ops =3D {
> +static const struct counter_ops mchp_tc_ops =3D {
>  	.signal_read  =3D mchp_tc_count_signal_read,
>  	.count_read   =3D mchp_tc_count_read,
>  	.function_get =3D mchp_tc_count_function_get,
> --=20
> 2.28.0
>=20

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl9qqVQACgkQhvpINdm7
VJKiUA//RCxl+1lEl3ZD7fgozAxc91BtR5k9Yu6UGBtrLNE+0lxJmpOdGyuN0K6X
iqXNMEzyJWvydI5+K/2GUvBrzQRIiufVyeTd8aUygFtJh+8Qysa3fmHrVJz/6SSA
TUKnENMoNKZZi9IzdGRkZN0yXr25RCVT6WXpb21T6Xp3nTAVTDU3GNNB5ytHhArG
AmT2iiNb5qX1fGfzG9jP9S6pf4bVhP5po4cwAWsLbziJTuNvfnp+ByMn3xx+UUw7
JN9WEm6/H36DTO0qNpNP6azWPLyZk8vElHY6tKpDKBvhN5k6UaJ6EXpvbba7DntA
+xgQUAxfE6txDv20uwF/w4CdTdXI0tOBdBhv5Av+naWhu9LFG7n0wveOIF9L0ZXI
KqYZ+ZSV537vZtvych1izHjm6V+LDmm49K6OhJnBkjYp4N36gmNhUbPV8UKhIh5E
UlVyf4eqllRqmzkVwuma/kb6BM6XUKue8lp0vZjovcMXHeTQ4YumYnh7E7igqLWz
V19MlFTEQrzR9h2B0LXbXkzXZm/fAnNQu00YSrOpNJ8Yl9gAIziTWWDxCDsYFORn
eFxRHF5bvisS6srCGTF2JZuAmH3WC+Dgo33OzGCBVgzOP9ZQ7FoSLf2HpIqT7Dgh
mysWnBNBXI9E1L+nNWWiYLpykO9Fru8nuG8cMKc9k/2mcnR/ISI=
=AK/t
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
