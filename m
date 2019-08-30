Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC3A30E6
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2019 09:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfH3HYC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Aug 2019 03:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfH3HYC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Aug 2019 03:24:02 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8F121897;
        Fri, 30 Aug 2019 07:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567149839;
        bh=Me9i+IID5A/sRRWiWv5IWcnOlQnC4hdR5FRwoGvQzSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNP8uu+jtgODKe6ioAkgTuBpFF2NX80HaP1smzqZ5Jf6+10jO2OigTcyIqe2wtB+s
         ZbpK8g1AJXDpn5jpbTRDxDLoYNnFSHmi1ON/f3tkRRkxAOo1dz8v0lZlcfQuM74PJ3
         gxoUplFJDHIGtfv/VHoQrAZ4O0PNBeSAjufFKb4o=
Date:   Fri, 30 Aug 2019 09:23:54 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Jonathan Cameron <jic23@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org
Subject: Re: [BUG] Re: [PATCH] iio: imu: st_lsm6dsx: remove invalid gain
 value for LSM9DS1
Message-ID: <20190830072354.GA5910@localhost.localdomain>
References: <f2be2f0e064bc7785f9d8f7f6a8598c325b39a45.1566894261.git.lorenzo@kernel.org>
 <20190827210857.718d7f9b@archlinux>
 <37cb0888-50b6-40d2-1289-a78499a90b7c@puri.sm>
 <20190829083714.GA2880@localhost.localdomain>
 <f34694f0-ea7c-0327-532d-7a2904952771@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <f34694f0-ea7c-0327-532d-7a2904952771@puri.sm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 29.08.19 10:37, Lorenzo Bianconi wrote:
> >> On 27.08.19 22:08, Jonathan Cameron wrote:
> >>> On Tue, 27 Aug 2019 10:26:35 +0200
> >>> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >>>
> >>>> Get rid of invalid sensitivity value for LSM9DS1 gyro sensor
> >>>>
> >>>> Fixes: 687a60feb9c6 ("iio: imu: st_lsm6dsx: add support for accel/gy=
ro unit of lsm9ds1")
> >>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>> The zero degree scale is certainly odd otherwise, so good to tidy
> >>> this up.
> >>>
> >>> Applied to the togreg branch of iio.git.
> >>>

[...]

> > struct st_lsm6dsx_fs_table_entry in st_lsm6dsx_settings will always hav=
e 4
> > elements for fs_avl array and since the array is defined as static the
> > uninitialized elements are set to 0.
> >=20
> > Could you please share the ops you are getting?
> >=20
>=20
> How this oops during startup can look like is appended below. I know
> that exactly this change causes it. Can you test this too please?

I did it but I have no issues

>=20
> Given the cleanup nature of this patch, I think it's best to revert it
> in case of any doubt.
>=20
> thanks,
>=20
>                           martin
>=20

is it the full ops? It seems some parts are missing.
Are you running some userspace aps reading in_anglvel_scale_available or re=
ading/writing in in_anglvel_scale?
Could you please double check if the following patch helps? (just compiled)

Regards,
Lorenzo

---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 28 +++++++++++++-------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  3 ++-
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_l=
sm6dsx/st_lsm6dsx.h
index 5e3cd96b0059..a6cd736fd273 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -100,6 +100,7 @@ struct st_lsm6dsx_fs {
 struct st_lsm6dsx_fs_table_entry {
 	struct st_lsm6dsx_reg reg;
 	struct st_lsm6dsx_fs fs_avl[ST_LSM6DSX_FS_LIST_SIZE];
+	int len;
 };
=20
 /**
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index 2d3495560136..37a2aa211757 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -145,6 +145,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] =3D { IIO_G_TO_M_S_2(732), 0x1 },
+				.len =3D 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] =3D {
 				.reg =3D {
@@ -154,6 +155,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[0] =3D {  IIO_DEGREE_TO_RAD(245), 0x0 },
 				.fs_avl[1] =3D {  IIO_DEGREE_TO_RAD(500), 0x1 },
 				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(2000), 0x3 },
+				.len =3D 3,
 			},
 		},
 	},
@@ -215,6 +217,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
+				.len =3D 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] =3D {
 				.reg =3D {
@@ -225,6 +228,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.len =3D 4,
 			},
 		},
 		.decimator =3D {
@@ -327,6 +331,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
+				.len =3D 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] =3D {
 				.reg =3D {
@@ -337,6 +342,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.len =3D 4,
 			},
 		},
 		.decimator =3D {
@@ -448,6 +454,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
+				.len =3D 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] =3D {
 				.reg =3D {
@@ -458,6 +465,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.len =3D 4,
 			},
 		},
 		.decimator =3D {
@@ -563,6 +571,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
+				.len =3D 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] =3D {
 				.reg =3D {
@@ -573,6 +582,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.len =3D 4,
 			},
 		},
 		.batch =3D {
@@ -693,6 +703,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
+				.len =3D 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] =3D {
 				.reg =3D {
@@ -703,6 +714,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.len =3D 4,
 			},
 		},
 		.batch =3D {
@@ -800,6 +812,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] =3D { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] =3D { IIO_G_TO_M_S_2(488), 0x1 },
+				.len =3D 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] =3D {
 				.reg =3D {
@@ -810,6 +823,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sens=
or_settings[] =3D {
 				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.len =3D 4,
 			},
 		},
 		.batch =3D {
@@ -933,11 +947,12 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6ds=
x_sensor *sensor,
 	int i, err;
=20
 	fs_table =3D &sensor->hw->settings->fs_table[sensor->id];
-	for (i =3D 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
+	for (i =3D 0; i < fs_table->len; i++) {
 		if (fs_table->fs_avl[i].gain =3D=3D gain)
 			break;
+	}
=20
-	if (i =3D=3D ST_LSM6DSX_FS_LIST_SIZE)
+	if (i =3D=3D fs_table->len)
 		return -EINVAL;
=20
 	data =3D ST_LSM6DSX_SHIFT_VAL(fs_table->fs_avl[i].val,
@@ -1196,18 +1211,13 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct =
device *dev,
 {
 	struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_get_drvdata(dev));
 	const struct st_lsm6dsx_fs_table_entry *fs_table;
-	enum st_lsm6dsx_sensor_id id =3D sensor->id;
 	struct st_lsm6dsx_hw *hw =3D sensor->hw;
 	int i, len =3D 0;
=20
-	fs_table =3D &hw->settings->fs_table[id];
-	for (i =3D 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++) {
-		if (!fs_table->fs_avl[i].gain)
-			break;
-
+	fs_table =3D &hw->settings->fs_table[sensor->id];
+	for (i =3D 0; i < fs_table->len; i++)
 		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
 				 fs_table->fs_avl[i].gain);
-	}
 	buf[len - 1] =3D '\n';
=20
 	return len;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_shub.c
index 66fbcd94642d..dcf349278e8f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -61,6 +61,7 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6ds=
x_ext_dev_table[] =3D {
 				.gain =3D 1500,
 				.val =3D 0x0,
 			}, /* 1500 uG/LSB */
+			.len =3D 1,
 		},
 		.temp_comp =3D {
 			.addr =3D 0x60,
@@ -555,7 +556,7 @@ static ssize_t st_lsm6dsx_shub_scale_avail(struct devic=
e *dev,
 	int i, len =3D 0;
=20
 	settings =3D sensor->ext_info.settings;
-	for (i =3D 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++) {
+	for (i =3D 0; i < settings->fs_table.len; i++) {
 		u16 val =3D settings->fs_table.fs_avl[i].gain;
=20
 		if (val > 0)
--=20
2.21.0


>=20
>=20
> Feb 14 10:12:00 pureos kernel: [    4.056014] Data abort info:
> Feb 14 10:12:00 pureos kernel: [    4.061361] bq25890-charger 0-006b:
> Capacity for 4184000 is 99%
> Feb 14 10:12:00 pureos kernel: [    4.064751]   ISV =3D 0, ISS =3D 0x0000=
0004
> Feb 14 10:12:00 pureos kernel: [    4.070942]   CM =3D 0, WnR =3D 0
> Feb 14 10:12:00 pureos kernel: [    4.076588] user pgtable: 4k pages,
> 48-bit VAs, pgdp=3D00000000e4fa6000
> Feb 14 10:12:00 pureos kernel: [    4.086256] [0000000000000018]
> pgd=3D0000000000000000
> Feb 14 10:12:00 pureos kernel: [    4.100224] Internal error: Oops:
> 96000004 [#1] PREEMPT SMP
> Feb 14 10:12:00 pureos kernel: [    4.101985] Goodix-TS 2-005d: ID 5688,
> version: 0100
> Feb 14 10:12:00 pureos kernel: [    4.106038] Modules linked in:
> crct10dif_ce(+) st_magn_i2c(+) st_lsm6dsx_i2c(+) st_magn st_lsm6dsx
> snd_soc_sgtl5000(+) st_sensors_i2c st_sensors tcpci
> industrialio_triggered_buffer vcnl4000 kfifo_buf snd_soc_simple_card
> snd_soc_fsl_sai tcpm ghash_ce bq25890_charger snd_soc_gtm601
> snd_soc_simple_card_utils imx_pcm_dma goodix(+) roles snd_soc_core typec
> sha2_ce snd_pcm_dmaengine snd_pcm imx_sdma imx2_wdt sha1_ce snvs_pwrkey
> gpio_vibra qoriq_thermal virt_dma snd_timer watchdog snd soundcore
> usb_f_acm u_serial usb_f_rndis g_multi usb_f_mass_storage u_ether
> libcomposite ip_tables x_tables ipv6 nf_defrag_ipv6 xhci_plat_hcd
> xhci_hcd usbcore dwc3 ulpi udc_core usb_common phy_fsl_imx8mq_usb
> Feb 14 10:12:00 pureos kernel: [    4.113252] Goodix-TS 2-005d: Direct
> firmware load for goodix_5688_cfg.bin failed with error -2
> Feb 14 10:12:00 pureos kernel: [    4.174094] CPU: 2 PID: 341 Comm:
> systemd-udevd Tainted: G        W         5.3.0-rc2-gc652c7f46913 #141
> Feb 14 10:12:00 pureos kernel: [    4.174096] Hardware name: Purism
> Librem 5 devkit (DT)
> Feb 14 10:12:00 pureos kernel: [    4.174100] pstate: 80000005 (Nzcv
> daif -PAN -UAO)
> Feb 14 10:12:00 pureos kernel: [    4.174113] pc :
> st_lsm6dsx_i2c_probe+0x18/0x80 [st_lsm6dsx_i2c]
> Feb 14 10:12:00 pureos kernel: [    4.174124] lr :
> i2c_device_probe+0x1f0/0x2b8
> Feb 14 10:12:00 pureos kernel: [    4.174126] sp : ffff8000a4837970
> Feb 14 10:12:00 pureos kernel: [    4.174128] x29: ffff8000a4837970 x28:
> 0000000000000000
> Feb 14 10:12:00 pureos kernel: [    4.174132] x27: ffff000010b70000 x26:
> ffff8000a4837d68
> Feb 14 10:12:00 pureos kernel: [    4.174135] x25: ffff000010860000 x24:
> ffff000008a94038
> Feb 14 10:12:00 pureos kernel: [    4.174139] x23: ffff000008a94038 x22:
> ffff000008a94000
> Feb 14 10:12:00 pureos kernel: [    4.174142] x21: ffff8000a55a0400 x20:
> ffff000008a92000
> Feb 14 10:12:00 pureos kernel: [    4.174146] x19: ffff8000a55a0400 x18:
> ffffffffffffffff
> Feb 14 10:12:00 pureos kernel: [    4.174149] x17: 0000000000000000 x16:
> 0000000000000000
> Feb 14 10:12:00 pureos kernel: [    4.174152] x15: 0000000000040000 x14:
> 00000000fffffff0
> Feb 14 10:12:00 pureos kernel: [    4.174156] x13: 0000000000000001 x12:
> 0000000000000000
> Feb 14 10:12:00 pureos kernel: [    4.174159] x11: 0000000000000000 x10:
> 0101010101010101
> Feb 14 10:12:00 pureos kernel: [    4.174162] x9 : fffffffffffffffc x8 :
> 0000000000000008
> Feb 14 10:12:00 pureos kernel: [    4.174166] x7 : 0000000000000004 x6 :
> 1e0e1a00f2ade4ef
> Feb 14 10:12:00 pureos kernel: [    4.174169] x5 : 6f642d72001a0e1e x4 :
> 8080808000000000
> Feb 14 10:12:00 pureos kernel: [    4.174173] x3 : 0000000000000000 x2 :
> ffff000008a93000
> Feb 14 10:12:00 pureos kernel: [    4.193031] driver: 'Goodix-TS':
> driver_bound: bound to device '2-005d'
> Feb 14 10:12:00 pureos kernel: [    4.193105] x1 : 0000000000000000 x0 :
> ffff8000a55a0400
> Feb 14 10:12:00 pureos kernel: [    4.199343] bus: 'i2c': really_probe:
> bound device 2-005d to driver Goodix-TS
> Feb 14 10:12:00 pureos kernel: [    4.203445] Call trace:
> Feb 14 10:12:00 pureos kernel: [    4.203456]
> st_lsm6dsx_i2c_probe+0x18/0x80 [st_lsm6dsx_i2c]
> Feb 14 10:12:00 pureos kernel: [    4.203462]  i2c_device_probe+0x1f0/0x2=
b8
> Feb 14 10:12:00 pureos kernel: [    4.203468]  really_probe+0x168/0x368
> Feb 14 10:12:00 pureos kernel: [    4.203471]
> driver_probe_device.part.2+0x10c/0x128
> Feb 14 10:12:00 pureos kernel: [    4.203475]
> device_driver_attach+0x74/0xa0
> Feb 14 10:12:00 pureos kernel: [    4.203478]  __driver_attach+0x84/0x130
> Feb 14 10:12:00 pureos kernel: [    4.203481]  bus_for_each_dev+0x68/0xc8
> Feb 14 10:12:00 pureos kernel: [    4.203484]  driver_attach+0x20/0x28
> Feb 14 10:12:00 pureos kernel: [    4.203487]  bus_add_driver+0xd4/0x1f8
> Feb 14 10:12:00 pureos kernel: [    4.203490]  driver_register+0x60/0x110
> Feb 14 10:12:00 pureos kernel: [    4.203497]  i2c_register_driver+0x44/0=
x98
> Feb 14 10:12:00 pureos kernel: [    4.216908] devices_kset: Moving sound
> to end of list
> Feb 14 10:12:00 pureos kernel: [    4.217738]
> st_lsm6dsx_driver_init+0x1c/0x1000 [st_lsm6dsx_i2c]
> Feb 14 10:12:00 pureos kernel: [    4.217744]  do_one_initcall+0x58/0x1a8
> Feb 14 10:12:00 pureos kernel: [    4.217749]  do_init_module+0x54/0x1d4
> Feb 14 10:12:00 pureos kernel: [    4.217752]  load_module+0x1998/0x1c40
> Feb 14 10:12:00 pureos kernel: [    4.217755]
> __se_sys_finit_module+0xc0/0xd8
> Feb 14 10:12:00 pureos kernel: [    4.217761]
> __arm64_sys_finit_module+0x14/0x20
> Feb 14 10:12:00 pureos kernel: [    4.223515] PM: Moving platform:sound
> to end of list
> Feb 14 10:12:00 pureos kernel: [    4.228823]
> el0_svc_common.constprop.0+0xb0/0x168
> Feb 14 10:12:00 pureos kernel: [    4.228827]  el0_svc_handler+0x18/0x20
> Feb 14 10:12:00 pureos kernel: [    4.228830]  el0_svc+0x8/0xc
> Feb 14 10:12:00 pureos kernel: [    4.228838] Code: d2800003 910003fd
> a90153f3 aa0003f3 (f9400c34)
> Feb 14 10:12:00 pureos kernel: [    4.228843] ---[ end trace
> 4933f7b108d54662 ]---
>=20

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXWjPBwAKCRA6cBh0uS2t
rIGyAQDSUjQ13CSC4OzokR5QpRZJuWWLAgjbi4m/D9UnvEkf9wD/dGEd6jZySQZO
/xGLHSl4MK1ZdlITBWkhhNIERq/QhAE=
=eqDV
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
