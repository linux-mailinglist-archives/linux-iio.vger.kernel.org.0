Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD5494EE
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 00:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfFQWMK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 18:12:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2614 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728736AbfFQWMK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 18:12:10 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HM9WWJ006192;
        Tue, 18 Jun 2019 00:12:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=jAnmRQW43Qc2vH6nL4QCkLyTRWj7YG93n8QiO+qYZCY=;
 b=HzwPsnamTJBdN8eupFSq6jg2V6ITNK6OwdZ3byyfo10cdopUBP7LKu2foITtFd0b0wfU
 /ulURMyXNEKnlWUdaq1Xg/Yw2iHlhA0e9XHdbvVE7ZkgryCqUIR/yTCBuc97cKIkSRD5
 XwV463XYuqspGsWpjsDYii5zJcme8mBrKQGNpzxR18LI+TDW0z5KnZlVG38ryHtl22kt
 32wQMypiqczCvIenYHil6V9No+VE02EDSvc6RN4pfhgHEspzAoOoe2cXDkGHqTdkDfp9
 UuAWUNAZLSEVVoDQ/6EW8hIxK0vW/L8zemFzbFSrvJsYxUsiiALbtpRvC0yIW8/6TP7A NQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t4peu4jhr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 00:12:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E66531;
        Mon, 17 Jun 2019 22:12:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8537DF14;
        Mon, 17 Jun 2019 22:12:03 +0000 (GMT)
Received: from SFHDAG2NODE1.st.com (10.75.127.4) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Jun
 2019 00:12:02 +0200
Received: from SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90]) by
 SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90%20]) with mapi id
 15.00.1347.000; Tue, 18 Jun 2019 00:12:03 +0200
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH][V3] iio: st_accel: fix
 iio_triggered_buffer_{pre,post}enable positions
Thread-Topic: [PATCH][V3] iio: st_accel: fix
 iio_triggered_buffer_{pre,post}enable positions
Thread-Index: AQHVIp6W+PHSaNTcrEyHcDDTo7MJ/aagbZuA
Date:   Mon, 17 Jun 2019 22:12:02 +0000
Message-ID: <0420c90b027249eb9dd28bd9e266088a@SFHDAG2NODE1.st.com>
References: <20190529135848.11964-1-alexandru.ardelean@analog.com>
 <20190614104725.4535-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190614104725.4535-1-alexandru.ardelean@analog.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_09:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

Looks good to me.

Acked-by: Denis Ciocca <denis.ciocca@st.com>

Thanks,
Denis


-----Original Message-----
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On =
Behalf Of Alexandru Ardelean
Sent: Friday, June 14, 2019 3:47 AM
To: linux-iio@vger.kernel.org
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][V3] iio: st_accel: fix iio_triggered_buffer_{pre,post}enab=
le positions

The iio_triggered_buffer_{predisable,postenable} functions attach/detach th=
e poll functions.

For the predisable hook, the disable code should occur before detaching the=
 poll func, and for the postenable hook, the poll func should be attached b=
efore the enable code.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* record the first error in st_accel_buffer_predisable() and return that=20

Changelog v2 -> v3:
* move iio_triggered_buffer_postenable() after the allocation, but before
  `st_sensors_set_axis_enable()` based on comment from
  `Denis Ciocca <denis.ciocca@st.com>`

 drivers/iio/accel/st_accel_buffer.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_acc=
el_buffer.c
index 7fddc137e91e..802ab7d2d93f 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -46,17 +46,19 @@ static int st_accel_buffer_postenable(struct iio_dev *i=
ndio_dev)
 		goto allocate_memory_error;
 	}
=20
-	err =3D st_sensors_set_axis_enable(indio_dev,
-					(u8)indio_dev->active_scan_mask[0]);
+	err =3D iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
 		goto st_accel_buffer_postenable_error;
=20
-	err =3D iio_triggered_buffer_postenable(indio_dev);
+	err =3D st_sensors_set_axis_enable(indio_dev,
+					(u8)indio_dev->active_scan_mask[0]);
 	if (err < 0)
-		goto st_accel_buffer_postenable_error;
+		goto st_sensors_set_axis_enable_error;
=20
 	return err;
=20
+st_sensors_set_axis_enable_error:
+	iio_triggered_buffer_predisable(indio_dev);
 st_accel_buffer_postenable_error:
 	kfree(adata->buffer_data);
 allocate_memory_error:
@@ -65,20 +67,22 @@ static int st_accel_buffer_postenable(struct iio_dev *i=
ndio_dev)
=20
 static int st_accel_buffer_predisable(struct iio_dev *indio_dev)  {
-	int err;
+	int err, err2;
 	struct st_sensor_data *adata =3D iio_priv(indio_dev);
=20
-	err =3D iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_accel_buffer_predisable_error;
-
 	err =3D st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS)=
;
 	if (err < 0)
 		goto st_accel_buffer_predisable_error;
=20
 	err =3D st_sensors_set_enable(indio_dev, false);
+	if (err < 0)
+		goto st_accel_buffer_predisable_error;
=20
 st_accel_buffer_predisable_error:
+	err2 =3D iio_triggered_buffer_predisable(indio_dev);
+	if (!err)
+		err =3D err2;
+
 	kfree(adata->buffer_data);
 	return err;
 }
--
2.20.1

