Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E739566BF97
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 14:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjAPNUY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 08:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjAPNUF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 08:20:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3E1EFFC
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 05:19:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23D3B60FAA
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 13:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308CDC433EF;
        Mon, 16 Jan 2023 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673875171;
        bh=Mp8TAjq633+3BxLiporCJS8PTNVc/gTIIpz6Ov6bWtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAKZvInVOFsrMgW7UPRCvvP766sLFmps+ClDb2DFpGwook23puIeA3YmhruQ9Gibv
         azpd+2btbJg3vV50rtboJ/di0e5+gFjx3MZiTwtVXgeJJhkmCNS3RrAS5bj+BfLI+Y
         56YHaiaabeRf4x52NaGqkhECz4MyH626JSWyQR2tVsoYqVTVMxLe/GwiOxiChSEPZ7
         +b6fFsTvZkLKr0mAE/afWzCgQqbu4DMz58FdrGVJXRgtsOaRLr635Fhn400lHisELP
         y0hCe8O6BfBOMsTmX3Xc+y86ni0QgKE0VmrfsZb5hezWgtaNZ14/CdlWLnptYiZYGr
         TmS0Zh9pX4spg==
Date:   Mon, 16 Jan 2023 14:19:27 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Philippe De Muyter <Philippe.DeMuyter@macq.eu>
Cc:     linux-iio@vger.kernel.org, Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH v2 2/2] iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs
 entry to gyro channel.
Message-ID: <Y8VO38sQ80l0BBch@lore-desk>
References: <1673874434-30750-1-git-send-email-Philippe.DeMuyter@macq.eu>
 <1673874434-30750-3-git-send-email-Philippe.DeMuyter@macq.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C4cnZN8jqttA8C2i"
Content-Disposition: inline
In-Reply-To: <1673874434-30750-3-git-send-email-Philippe.DeMuyter@macq.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--C4cnZN8jqttA8C2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Philippe De Muyter <phdm@macqel.be>
>=20
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

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

--C4cnZN8jqttA8C2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8VO3wAKCRA6cBh0uS2t
rIUJAPwPsgXzT9CfKHeN1ZDHPv+6dBgDy9Oo0j/s098pAEbR4gD/caUWfxTQtukh
kZbrw/BDx7PT+6GPgDX+/pWRSWbzfQE=
=/KXU
-----END PGP SIGNATURE-----

--C4cnZN8jqttA8C2i--
