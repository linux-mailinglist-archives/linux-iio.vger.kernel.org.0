Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8680466BB83
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 11:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjAPKRh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 05:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjAPKRK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 05:17:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072D21ABE3
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 02:16:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55C8CCE0FC0
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 10:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E9AC433EF;
        Mon, 16 Jan 2023 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673864206;
        bh=1nb8VgZu1QJLbyKYGPEy9RBNA8JRkrPS0SBTA3ow+Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMQ608K6peVRqNO8B3YNw62PGXO0SZjEAL/GQEXB6rdo4x8LDaVZN8nFPENbjOSEB
         70qp/lgUesx8uhPONpfObFIxbxyXYLJyPC6cXXx0nROEG4SYtVwXGIAFN6SQxf7AAY
         tnCiBMqrTm22DYipnYvgUSlWrE2YW5Xs7+V7Hks8urxO3ctWWX6OYHi/lxNsApW6I+
         ZgRDoB7dut+preY5k/0h2Y6/NnOUfU5g+nyKsXNZ/T98OKIJ8Xdl2oWstfk9SB3/pR
         JbCF48hOCYFmF9zAShFo3MiXWRqiI8nyhwIlQ8SDjA47sEm/hgrKTFVDK0n+V4OkFw
         2ADNkCB2toddQ==
Date:   Mon, 16 Jan 2023 11:16:42 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Philippe De Muyter <Philippe.DeMuyter@macq.eu>
Cc:     linux-iio@vger.kernel.org, Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry
 to gyro channel.
Message-ID: <Y8UkCoAQKXQEHl+c@lore-desk>
References: <1673862685-29308-1-git-send-email-Philippe.DeMuyter@macq.eu>
 <1673862685-29308-3-git-send-email-Philippe.DeMuyter@macq.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WoicOgtj8rwLy6kn"
Content-Disposition: inline
In-Reply-To: <1673862685-29308-3-git-send-email-Philippe.DeMuyter@macq.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--WoicOgtj8rwLy6kn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Philippe De Muyter <phdm@macqel.be>
>=20
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 5b6f195748fc..499fcf8875b4 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -93,7 +93,7 @@ enum st_lsm6dsx_hw_id {
>  		.endianness =3D IIO_LE,					\
>  	},								\
>  	.event_spec =3D &st_lsm6dsx_event,				\
> -	.ext_info =3D st_lsm6dsx_accel_ext_info,				\
> +	.ext_info =3D st_lsm6dsx_ext_info,				\
>  	.num_event_specs =3D 1,						\
>  }
> =20
> @@ -113,6 +113,7 @@ enum st_lsm6dsx_hw_id {
>  		.storagebits =3D 16,					\
>  		.endianness =3D IIO_LE,					\
>  	},								\
> +	.ext_info =3D st_lsm6dsx_ext_info,				\
>  }
> =20
>  struct st_lsm6dsx_reg {
> @@ -528,7 +529,7 @@ st_lsm6dsx_device_set_enable(struct st_lsm6dsx_sensor=
 *sensor, bool enable)
>  }
> =20
>  static const
> -struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_accel_ext_info[]=
 =3D {
> +struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_ext_info[] =3D {
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
>  	{ }
>  };
> --=20
> 2.31.1
>=20

--WoicOgtj8rwLy6kn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8UkCgAKCRA6cBh0uS2t
rLT8AQD0XjZW2Fxp6BoktTmPTKz6b+VnZ0Oe3e8XSQufeCnqjwEA6JkUN7dJeaFE
jgUeQiQbz0DY1Nnlei2KOp0XQk7+eQY=
=i2JJ
-----END PGP SIGNATURE-----

--WoicOgtj8rwLy6kn--
