Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54D3667121
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jan 2023 12:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjALLmm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Jan 2023 06:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbjALLld (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2023 06:41:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C71158
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 03:32:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E99316200E
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 11:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65A2C433D2;
        Thu, 12 Jan 2023 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673523135;
        bh=DjfOOxfu9AP5hs6rMKN8V78VppLViwC23mvXwvzDhco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvelgBEORy4kMh3bqynEigytVcFm5NF+dF81NB6GFPQ8hdUZ6PhdlqgbobRtQw9Sn
         8bdbH+84VwJvaP2uSj6jgdU24rjD9b3vsby6Bns8AawDJST1pZAzv024/qu9TOuAgE
         8qOLObtvOvWADqzwdoef5jBEmXy5SK5kOhdVm6oCEr5mEGGK96keLXIpAPZwovJ29y
         Az1hDo4c61awjGbY7a8Y2uGwyAU3IU5AWZDEIS9bTWUGRmAMSNwveNlEGg7793WKy0
         vGAAL30SWp/vEsd30sb9rzOcMJ3bG/v2cgiZdIVLoI2uJJmvd9sPVGNdjixvccUIOV
         03dQ8WsI6fiiw==
Date:   Thu, 12 Jan 2023 12:32:11 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Philippe De Muyter <phdm@macq.eu>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
Message-ID: <Y7/vu7IwRmQS7CSf@lore-desk>
References: <20230111120940.GA23351@frolo.macqel>
 <20230111171732.00006941@Huawei.com>
 <Y7/YB1CmEzbnNogP@lore-desk>
 <20230112112704.GA17933@frolo.macqel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LNZbXS0iqibI0e3w"
Content-Disposition: inline
In-Reply-To: <20230112112704.GA17933@frolo.macqel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--LNZbXS0iqibI0e3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo,
>=20
> On Thu, Jan 12, 2023 at 10:51:03AM +0100, Lorenzo Bianconi wrote:
> > Date: Thu, 12 Jan 2023 10:51:03 +0100
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Philippe De Muyter <phdm@macq.eu>, linux-iio@vger.kernel.org
> > Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
> >=20
> > > On Wed, 11 Jan 2023 13:09:40 +0100
> > > Philippe De Muyter <phdm@macq.eu> wrote:
> > >=20
> > > > Hello Lorenzo and list,
> > > >=20
> > > > I do not find a "*mount_matrix" entry in sysfs for a 'ism330dlc_gyr=
o'
> > > > iio device.
> > > > Is that normal ?
> > > > Is a fix available ?
> > >=20
> > > Looks like the channel definition for the gyro does not include an
> > > appropriate ext_info entry unlike the accelerometer channels which
> > > have one with mount_matrix support.
> > >=20
> > > From a quick glance looks like a simple fix. Add that entry.
> >=20
> > I am not sure if accel and gyro can be mounted with a different orienta=
tion.
> > Do you think we should have a per-sensor mount_matrix?
>=20
> My chip is a 'ism330dlc'.  It's one chip containing an accel and a gyro,
> so the mount_matrix should be the same for the accel and the gyro.
> Unfortunately the accel and the gyro are presented in /sysfs as two
> separate devices, and only the accel one has a 'mount_matrix' entry.
> So a user looking for any gyro will find the gyro entry, but without
> 'mount_matrix'.
>=20
> I have followed Jonathan's proposal and added this simple patch in
> the definition of the ST_LSM6DSX_CHANNEL macro :
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index d80ba2e688ed..9d18145d5041 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -96,6 +96,7 @@ enum st_lsm6dsx_hw_id {
>  		.storagebits =3D 16,                                      \
>  		.endianness =3D IIO_LE,                                   \
> 	},                                                              \
> +	.ext_info =3D st_lsm6dsx_accel_ext_info,                          \
>  }

I am fine with this approach, probably having a per-sensor mount_matrix is
unnecessary. Can you please just rename st_lsm6dsx_accel_ext_info in
st_lsm6dsx_ext_info?

Regards,
Lorenzo

>=20
>  struct st_lsm6dsx_reg {
>=20
> Another fix would be to create only one chip entry in sysfs, but that's
> above my knowledge of this driver.
>=20
> Best regards
>=20
> Philippe

--LNZbXS0iqibI0e3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY7/vuwAKCRA6cBh0uS2t
rAD4AP9qpepUVUs0PF8HVCUywoqw6w/JugHWy36YaveYbfmAIwD/eD7jUrP03GT2
eGSFlhHpdgM/BuhOZcH1PFGZVaC9GgQ=
=UJCt
-----END PGP SIGNATURE-----

--LNZbXS0iqibI0e3w--
