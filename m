Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F6266BB93
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 11:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjAPKUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 05:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjAPKUC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 05:20:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BA91ABD5
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 02:19:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30B9B60F51
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 10:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38803C433EF;
        Mon, 16 Jan 2023 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673864392;
        bh=mxxZsys6KhoBEdsUlZZIFx4x7tLmU7mG3YU4qL90bDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VkrHbtqDEJiBG9Fyi5B2d3DUO4q4DJSuHUozYZqajrEB5a4do6NOp+J/66mgW4eEM
         vnmgZCFPxkuU0UUWM4PEKzMmtp6wCU04KfRlvp+fw7F+4vClJsA8CWRGFL9UcBBTBP
         UaZz52fKD6/CGl4JYl2FRnQ4wIyYTtOB2XMOeY6UbYu+4HTV+kqDDaoLrIRDk4N7Er
         nhFsKPk9XkUPgpV2BDeiQEj10b6pJW9SN2HFG2ysYBvKk87q1M4ephDlmsvHBGHxz4
         i6l3rzY3jv0ucTvULisaqbGtXyvcNjVaNRPgqlB/6kgJ0qrqTLv/DSrxf+Gs05zty3
         KkjW5cuuvs0uA==
Date:   Mon, 16 Jan 2023 11:19:48 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Philippe De Muyter <Philippe.DeMuyter@macq.eu>
Cc:     linux-iio@vger.kernel.org, Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: fix naming of 'struct
 iio_info'.
Message-ID: <Y8UkxDgfeH7z3q7g@lore-desk>
References: <1673862685-29308-1-git-send-email-Philippe.DeMuyter@macq.eu>
 <1673862685-29308-2-git-send-email-Philippe.DeMuyter@macq.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IzweJGXuJF6t+Aj2"
Content-Disposition: inline
In-Reply-To: <1673862685-29308-2-git-send-email-Philippe.DeMuyter@macq.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--IzweJGXuJF6t+Aj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Philippe De Muyter <phdm@macqel.be>
>=20
> We need the name 'st_lsm6dsx_ext_info' for the actual 'iio_chan_spec_ext_=
info'.
> Rename the 'struct iio_info' to 'st_lsm6dsx_info' like in all other drive=
rs.
>=20
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_shub.c
> index f2b64b4956a3..43304b198040 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -714,7 +714,7 @@ static const struct attribute_group st_lsm6dsx_ext_at=
tribute_group =3D {
>  	.attrs =3D st_lsm6dsx_ext_attributes,
>  };
> =20
> -static const struct iio_info st_lsm6dsx_ext_info =3D {
> +static const struct iio_info st_lsm6dsx_info =3D {

maybe st_lsm6dsx_shub_info is a better name, what do you think?
Moreover you can even rename:
s/st_lsm6dsx_ext_attributes/st_lsm6dsx_shub_attributes/
s/st_lsm6dsx_ext_attribute_group/st_lsm6dsx_shub_attribute_group/

Regards,
Lorenzo

>  	.attrs =3D &st_lsm6dsx_ext_attribute_group,
>  	.read_raw =3D st_lsm6dsx_shub_read_raw,
>  	.write_raw =3D st_lsm6dsx_shub_write_raw,
> @@ -737,7 +737,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  		return NULL;
> =20
>  	iio_dev->modes =3D INDIO_DIRECT_MODE;
> -	iio_dev->info =3D &st_lsm6dsx_ext_info;
> +	iio_dev->info =3D &st_lsm6dsx_info;
> =20
>  	sensor =3D iio_priv(iio_dev);
>  	sensor->id =3D id;
> --=20
> 2.31.1
>=20

--IzweJGXuJF6t+Aj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8UkxAAKCRA6cBh0uS2t
rA2WAQDlTxu278C/9KBclR/VRyK11e4QKPNCUueJTecu0Ei9/wD/fpq9MJM5gTjP
34xjz8CS3KcPtF3/YtoVfrKyrLlr8AI=
=CffA
-----END PGP SIGNATURE-----

--IzweJGXuJF6t+Aj2--
