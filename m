Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA1271641
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgITRSx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 13:18:53 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:24607 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITRSx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2020 13:18:53 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 13:18:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1600622331;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=U0uTJUmO5m2YxLrCkWj6XrwVLLK9KTkXUi2XeDlVPUg=;
        b=j1htI7DTztP40FxS4ekZ4jgY08KU4H2X0QnBmeG3fg9fTLMQbGHHwNLiyu2ogn88LT
        6XMvVRMP1FAJUl7Q+4mRaqwqWBbAi/DQwS1OW+Vt9lm/TORCbEQ0pgO8ijy0FhHxQ3CY
        VSlxYBsKKRXAoFEQCLH4Jdje6O8hz6GcJiCCmu/bepFSitV+1jI9YZfrDXhljyTvx30g
        rcVqL9WzH0p6kx8QCB6HOo7jqJEWPC+n4KBBYS/U5QNO+TJv/IKjJD5hMaHLoN9sOYCE
        tp0QwiEkfaoNRjjQyBgruGYJ6bijWulZOWRFOHHtUdEBgtrsf1L6jYFqcxaXHPZwvmK2
        x/wA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmAhw47vfM4="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id n03b0dw8KHCmFgx
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sun, 20 Sep 2020 19:12:48 +0200 (CEST)
Subject: Re: [PATCH] iio:magn:hmc5843: Fix passing true where iio_shared_by enum required.
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20200913112546.715624-1-jic23@kernel.org>
Date:   Sun, 20 Sep 2020 19:12:47 +0200
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0CE59F2-8E2A-494C-B6A1-C8B4AA011AC0@goldelico.com>
References: <20200913112546.715624-1-jic23@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> Am 13.09.2020 um 13:25 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> So it's obvious that the code is wrong in passing true, but I'm =
assuming
> that will actually evaluate to 1 and hence IIO_SHARED_BY_TYPE.
> The documentation however has this attribute as IIO_SHARED_BY_ALL.
> My current assumption is the documentation is wrong.
> If anyone knows otherwise please shout out!
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 7247645f6865 ("iio: hmc5843: Move hmc5843 out of staging")
> Cc: H. Nikolaus Schaller <hns@goldelico.com>

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>

on GTA04 (omap3-gta04.dtsi).

> ---
> drivers/iio/magnetometer/hmc5843_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/hmc5843_core.c =
b/drivers/iio/magnetometer/hmc5843_core.c
> index 1474ba63babe..780faea61d82 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -245,7 +245,7 @@ static const struct iio_enum =
hmc5843_meas_conf_enum =3D {
> };
>=20
> static const struct iio_chan_spec_ext_info hmc5843_ext_info[] =3D {
> -	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
> +	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, =
&hmc5843_meas_conf_enum),
> 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
> 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> 	{ }
> @@ -259,7 +259,7 @@ static const struct iio_enum =
hmc5983_meas_conf_enum =3D {
> };
>=20
> static const struct iio_chan_spec_ext_info hmc5983_ext_info[] =3D {
> -	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
> +	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, =
&hmc5983_meas_conf_enum),
> 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
> 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> 	{ }
> --=20
> 2.28.0
>=20

