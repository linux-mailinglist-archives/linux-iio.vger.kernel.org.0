Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE160B8B33
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437414AbfITGmW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 02:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437394AbfITGmV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Sep 2019 02:42:21 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.30.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451C72080F;
        Fri, 20 Sep 2019 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568961740;
        bh=Sabga27MBD0jDp1gbmpKNv7xzx4Jo73O+QTIB1fYnT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2dBN9476YP915ampBa6z/aoRQX+fhfS7cnZR4uc+94tjUv0A2Mm6Aes3gFG7nrEN
         sqx5vfNYu6SJh3zqcU/9ruilH70c0Ji9n1fsvYjVpH3wkrfsT/DmB8rMPSutwBb3Ky
         dn8tazGfMUCzVOvVD/qu1g2Pl2UxAoiF9l1N79m0=
Date:   Fri, 20 Sep 2019 08:42:14 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Bobby Jones <rjones@gateworks.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: LSM9DS1 testing with st_lsm6dsx driver
Message-ID: <20190920064214.GA31900@lore-desk-wlan.lan>
References: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo and Martin,

Hi Bobby,

LSM9DS1 does not support hw FIFO for the moment. Are you trying to enable
buffered reading?
Could you please try if the following patch helps? (just compiled)

Regards,
Lorenzo

iio: imu: st_lsm6dsx: do not configure the fifo if not supported

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index b65a6ca775e0..90a0e5ce44e5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1572,7 +1572,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int=
 hw_id,
 			return err;
 	}
=20
-	if (hw->irq > 0) {
+	if (hw->irq > 0 && hw->settings->fifo_ops.update_fifo) {
 		err =3D st_lsm6dsx_fifo_setup(hw);
 		if (err < 0)
 			return err;
--=20
2.21.0


>=20
> I'm testing the LSM9DS1 support recently added to the st_lsm6dsx
> iio/imu driver and I'm encountering a device tree problem related to
> interrupt config.
>=20
> Here's the exception I'm seeing:
> [    4.172529] irq 277: nobody cared (try booting with the "irqpoll" opti=
on)
> [    4.179341] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 5.3.0-rc5-00322-g792b824-dirty #7
> [    4.187359] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    4.193920] [<c0112750>] (unwind_backtrace) from [<c010d018>]
> (show_stack+0x10/0x14)
> [    4.201690] [<c010d018>] (show_stack) from [<c0c2bfc8>]
> (dump_stack+0xd8/0x10c)
> [    4.209027] [<c0c2bfc8>] (dump_stack) from [<c01923fc>]
> (__report_bad_irq+0x24/0xc0)
> [    4.216793] [<c01923fc>] (__report_bad_irq) from [<c0192820>]
> (note_interrupt+0x27c/0x2dc)
> [    4.225078] [<c0192820>] (note_interrupt) from [<c018f174>]
> (handle_irq_event_percpu+0x54/0x7c)
> [    4.233793] [<c018f174>] (handle_irq_event_percpu) from
> [<c018f1d4>] (handle_irq_event+0x38/0x5c)
> [    4.242681] [<c018f1d4>] (handle_irq_event) from [<c0193664>]
> (handle_level_irq+0xc8/0x154)
> [    4.251051] [<c0193664>] (handle_level_irq) from [<c018df58>]
> (generic_handle_irq+0x20/0x34)
> [    4.259510] [<c018df58>] (generic_handle_irq) from [<c053c348>]
> (mxc_gpio_irq_handler+0xc4/0xf8)
> [    4.268313] [<c053c348>] (mxc_gpio_irq_handler) from [<c053c3e0>]
> (mx3_gpio_irq_handler+0x64/0xb8)
> [    4.277287] [<c053c3e0>] (mx3_gpio_irq_handler) from [<c018df58>]
> (generic_handle_irq+0x20/0x34)
> [    4.286089] [<c018df58>] (generic_handle_irq) from [<c018e550>]
> (__handle_domain_irq+0x64/0xe0)
> [    4.294810] [<c018e550>] (__handle_domain_irq) from [<c0529610>]
> (gic_handle_irq+0x4c/0xa0)
> [    4.303181] [<c0529610>] (gic_handle_irq) from [<c0101a70>]
> (__irq_svc+0x70/0x98)
> [    4.310675] Exception stack(0xc1301f10 to 0xc1301f58)
> [    4.315744] 1f00:                                     00000001
> 00000006 00000000 c130c340
> [    4.323937] 1f20: c1300000 c1308928 00000001 c1308960 00000000
> c12b9db0 c1308908 00000000
> [    4.332128] 1f40: 00000000 c1301f60 c0182010 c0109508 20000013 ffffffff
> [    4.338762] [<c0101a70>] (__irq_svc) from [<c0109508>]
> (arch_cpu_idle+0x20/0x3c)
> [    4.346180] [<c0109508>] (arch_cpu_idle) from [<c015ed70>]
> (do_idle+0x1bc/0x2bc)
> [    4.353594] [<c015ed70>] (do_idle) from [<c015f204>]
> (cpu_startup_entry+0x18/0x1c)
> [    4.361183] [<c015f204>] (cpu_startup_entry) from [<c1200e68>]
> (start_kernel+0x440/0x504)
> [    4.369378] [<c1200e68>] (start_kernel) from [<00000000>] (0x0)
> [    4.375309] handlers:
> [    4.377645] [<62052c0d>] st_lsm6dsx_handler_irq threaded
> [<f2004b92>] st_lsm6dsx_handler_thread
> [    4.386484] Disabling IRQ #277
>=20
> Here is the associated device tree node:
> lsm9ds1_ag@6a {
>     compatible =3D "st,lsm9ds1-imu";
>     reg =3D <0x6a>;
>     st,drdy-int-pin =3D <1>;
>     pinctrl-names =3D "default";
>     pinctrl-0 =3D <&pinctrl_acc_gyro>;
>     interrupt-parent =3D <&gpio7>;
>     interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
> };
>=20
> Let me know if I can provide any more information.
>=20
> Thanks,
> Bobby Jones

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXYR0wgAKCRA6cBh0uS2t
rJt2AQCq5r8yB8qhdDvDPyDdcPN29jIiuhSCUIXh/OlO07oNXQD/bm2QSAkanPUj
hcMO04cUaRm194/h2e9+2XQptrPvfAo=
=c0sM
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
