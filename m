Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A4675C7D6
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jul 2023 15:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjGUNba (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jul 2023 09:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGUNb3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 09:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C6110CE;
        Fri, 21 Jul 2023 06:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA26561B18;
        Fri, 21 Jul 2023 13:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD20C433C9;
        Fri, 21 Jul 2023 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689946287;
        bh=78SLJ7s+HVC5ZGBIlrzH/jG8Q54Wh9HQ5uooRF+P3CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHbMRsycSHz2YX4b9ozqcRuxu26OBr3xp0bWN92jkNvVOcwU9uSI0PJInflT6fNeE
         ZPtyF6hAOUFq38B4yDyAa5tctYVy47ayKQ0qJs+j6xEBDiottYlf5+DtxVy0/Y6rlv
         YTDVQzmaifBcetaAdbZ2C6FX+mE4ESlxLupHCJg6AHNE9q+GRkJ6sn+FGfoV4VJEUG
         to6QNrTgAnIa7hFw9UyDobwuzMDU/mfbWiuFP4FQGiUcdG7vOHITOlP6HZfnYTQC2H
         VJjzwLEFsumh0A7Xc1ZmYkIyPPmf4RzpQXTngF+yILvr3lmMx5uBy2j7g7iB586aWO
         v4BasaqoaKjag==
Date:   Fri, 21 Jul 2023 09:31:24 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] counter: rz-mtu3-cnt: Fix locking order
Message-ID: <ZLqIrNbygFC7Ay+m@ishi>
References: <20230717120738.165765-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DAALZPG1n9vkshXw"
Content-Disposition: inline
In-Reply-To: <20230717120738.165765-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--DAALZPG1n9vkshXw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 01:07:38PM +0100, Biju Das wrote:
> All functions except rz_mtu3_count_enable_write(), calls
> pm_runtime_{get,put} inside the lock. For consistency do the same here.
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235=
=2E183132-6-biju.das.jz@bp.renesas.com/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Is this just a code cleanup for consistency with the rest of the driver,
or does it fix an existing bug? If it's just cleanup, would you resend
with a different title (e.g. "Reorder locking sequence for consistency")
to make it clear this is not addressing a bug.

Thanks,

William Breathitt Gray

> ---
>  drivers/counter/rz-mtu3-cnt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
> index 48c83933aa2f..ee821493b166 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -500,8 +500,8 @@ static int rz_mtu3_count_enable_write(struct counter_=
device *counter,
>  	int ret =3D 0;
> =20
>  	if (enable) {
> -		pm_runtime_get_sync(ch->dev);
>  		mutex_lock(&priv->lock);
> +		pm_runtime_get_sync(ch->dev);
>  		ret =3D rz_mtu3_initialize_counter(counter, count->id);
>  		if (ret =3D=3D 0)
>  			priv->count_is_enabled[count->id] =3D true;
> @@ -510,8 +510,8 @@ static int rz_mtu3_count_enable_write(struct counter_=
device *counter,
>  		mutex_lock(&priv->lock);
>  		rz_mtu3_terminate_counter(counter, count->id);
>  		priv->count_is_enabled[count->id] =3D false;
> -		mutex_unlock(&priv->lock);
>  		pm_runtime_put(ch->dev);
> +		mutex_unlock(&priv->lock);
>  	}
> =20
>  	return ret;
> --=20
> 2.25.1
>=20

--DAALZPG1n9vkshXw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZLqIrAAKCRC1SFbKvhIj
K2MnAQCq0qQ07gzfXxQqyh7sKTkxf26udFIMwHVKZSW8CAwTJgEAkSU59Ovy3Vft
Py4U080ZTSVK/UeS26ZEzz0KUs/I6wE=
=kXv7
-----END PGP SIGNATURE-----

--DAALZPG1n9vkshXw--
