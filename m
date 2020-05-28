Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B174D1E6D35
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 23:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407561AbgE1VHd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 17:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407544AbgE1VHT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 May 2020 17:07:19 -0400
Received: from localhost (unknown [151.48.140.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1342820C56;
        Thu, 28 May 2020 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590700036;
        bh=5aajBRm3+hWw/4fPo4LGO9xfM8WNSj9iZ42Tqb7iPWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7TKj2wrSyVUJ9eBT4bCUPplUy3zJ64Xw43dz7nzi0TlUGq94G6lQo5wJjA1ZAFXv
         k5JcHYHeWWX9Vk/xTx0ZkyJCmX2zM+oomswy8kDOYdHukg1qUwHQ4FPLKyjmGyZxGE
         J0j2wiElKlGxMx/iDBnkBZhTTSdsmMSYB3g2cCgg=
Date:   Thu, 28 May 2020 23:07:11 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <20200528210711.GD5419@localhost.localdomain>
References: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,

Hi Sean,

>=20
> I don't know if it's normal behavior or maybe just a problem related to t=
he
> buffered reads in st_lsm6dsx.
>=20
> But when we have the buffered reads enabled and suspending for x amount of
> time. The iio timestamps is, x amount of time is delayed. As seen here:
>=20
> https://gist.github.com/sknsean/60e20c2fa3a3c6d69ef128c703ed43fc
>=20
> From your own software (but I'm able to reproduce with libiio/iio_readdev)
>=20
> First col is system time,
> Second timestamp is the iio timestamp
>=20
> Could a solution, be to call st_lsm6dsx_reset_hw_ts() in st_lsm6dsx_resum=
e()
> ?

yes, I think so. Could you please try to patch below? Thanks.

Regards,
Lorenzo

>=20
> /Sean

=46rom f4ea9019d3b6fb1ad80747cf378bf1fbdebd3dd8 Mon Sep 17 00:00:00 2001
Message-Id: <f4ea9019d3b6fb1ad80747cf378bf1fbdebd3dd8.1590699935.git.lorenz=
o@kernel.org>
=46rom: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 28 May 2020 23:05:16 +0200
Subject: [PATCH] iio: imu: st_lsm6dsx: reset hw ts after resume

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 +--
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 ++++++++++++-------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_l=
sm6dsx/st_lsm6dsx.h
index b56df409ed0f..529970195b39 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -436,8 +436,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_senso=
r *sensor,
 				u16 watermark);
 int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
-int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
-			     enum st_lsm6dsx_fifo_mode fifo_mode);
+int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *va=
l);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_buffer.c
index afd00daeefb2..7de10bd636ea 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -184,8 +184,8 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6d=
sx_hw *hw)
 	return err;
 }
=20
-int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
-			     enum st_lsm6dsx_fifo_mode fifo_mode)
+static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
+				    enum st_lsm6dsx_fifo_mode fifo_mode)
 {
 	unsigned int data;
=20
@@ -302,6 +302,18 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw=
 *hw)
 	return 0;
 }
=20
+int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw)
+{
+	int err;
+
+	/* reset hw ts counter */
+	err =3D st_lsm6dsx_reset_hw_ts(hw);
+	if (err < 0)
+		return err;
+
+	return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
+}
+
 /*
  * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN/ST_LSM6DSX_MAX_TAGGED_WORD=
_LEN
  * in order to avoid a kmalloc for each bus access
@@ -675,12 +687,7 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *s=
ensor, bool enable)
 		goto out;
=20
 	if (fifo_mask) {
-		/* reset hw ts counter */
-		err =3D st_lsm6dsx_reset_hw_ts(hw);
-		if (err < 0)
-			goto out;
-
-		err =3D st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
+		err =3D st_lsm6dsx_resume_fifo(hw);
 		if (err < 0)
 			goto out;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index 0b776cb91928..b3a08e3e2359 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2458,7 +2458,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct de=
vice *dev)
 	}
=20
 	if (hw->fifo_mask)
-		err =3D st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
+		err =3D st_lsm6dsx_resume_fifo(hw);
=20
 	return err;
 }
--=20
2.26.2


--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXtAn+wAKCRA6cBh0uS2t
rM19AQDaODt2M0yXGWnc+58CwRuIeCxUmNbQgEu3AyjuAD1AHQEA//LoNg/OJFcB
8Xtin76PAcMBUZS3QILuQD5E1snnbg8=
=5wAa
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
