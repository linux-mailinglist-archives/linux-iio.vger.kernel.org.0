Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8F4A477C
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jan 2022 13:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350849AbiAaMrF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Jan 2022 07:47:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59962 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240768AbiAaMrF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Jan 2022 07:47:05 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20V8q7P0008938;
        Mon, 31 Jan 2022 13:46:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=c/fnF1/4lc2Gc1HnW5Y3heeYAY6TKiR8Ck/ftevMOpQ=;
 b=fI56H8m6wc3ZJvbQTOKeHGZF5DrZCzrvb6RuDg0l3JKKEEuNzb1JaaWIhwHy6jlqGidT
 UORmyG0fidkBKok04X5haJ72bWEC2Q+CD7mdHNCqarTCuDECYh2CQmp/7557pIkYb2Ma
 FRxmBetzsY/3q9QQbC6iJ+YkD/h4KCFg1nMnDYAcyLRS+fiklJf2j5aGWDWIttU27Z7T
 rOCWU1Fr4PMcOEsqpNSUiX2zKfz24HkBV5n+xb3Y5CTQaIhyATBaJI2fCVOqZ9Mc+zzD
 Vw4DoB4K7RqqI/wh6XGph7l+v5Ra1u2x3SJaoT8gQAz5l0SXoDXyxCmsXDo5yPACkcJc Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dwwf3vc73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 13:46:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3F6110002A;
        Mon, 31 Jan 2022 13:46:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E89B1217B91;
        Mon, 31 Jan 2022 13:46:56 +0100 (CET)
Received: from SFHDAG2NODE1.st.com (10.75.127.4) by SFHDAG2NODE1.st.com
 (10.75.127.4) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 31 Jan
 2022 13:46:56 +0100
Received: from SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90]) by
 SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90%20]) with mapi id
 15.00.1497.026; Mon, 31 Jan 2022 13:46:56 +0100
From:   Mario TESI <mario.tesi@st.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: wait for settling time in
 st_lsm6dsx_read_oneshot
Thread-Topic: [PATCH] iio: imu: st_lsm6dsx: wait for settling time in
 st_lsm6dsx_read_oneshot
Thread-Index: AQHYFpL5u4K4s8cQS02ZgX6/YqFBZqx9E5Zk
Date:   Mon, 31 Jan 2022 12:46:56 +0000
Message-ID: <1643633216538.97874@st.com>
References: <6c10e1de14a42eca2d283a9df242b426e371543e.1643627150.git.lorenzo@kernel.org>
In-Reply-To: <6c10e1de14a42eca2d283a9df242b426e371543e.1643627150.git.lorenzo@kernel.org>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_05,2022-01-28_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Tested-by: Mario Tesi <mario.tesi@st.com>=0A=
________________________________________=0A=
Da: Lorenzo Bianconi <lorenzo@kernel.org>=0A=
Inviato: luned=EC 31 gennaio 2022 12:08=0A=
A: jic23@kernel.org=0A=
Cc: lorenzo.bianconi@redhat.com; linux-iio@vger.kernel.org; Mario TESI=0A=
Oggetto: [PATCH] iio: imu: st_lsm6dsx: wait for settling time in st_lsm6dsx=
_read_oneshot=0A=
=0A=
We need to wait for sensor settling time (~ 3/ODR) before reading data=0A=
in st_lsm6dsx_read_oneshot routine in order to avoid corrupted samples.=0A=
=0A=
Reported-by: Mario Tesi <mario.tesi@st.com>=0A=
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>=0A=
---=0A=
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++++-=0A=
 1 file changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c=0A=
index 727b4b6ac696..93f0c6bce502 100644=0A=
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c=0A=
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c=0A=
@@ -1374,8 +1374,12 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx=
_sensor *sensor,=0A=
        if (err < 0)=0A=
                return err;=0A=
=0A=
+       /*=0A=
+        * we need to wait for sensor settling time before=0A=
+        * reading data in order to avoid corrupted samples=0A=
+        */=0A=
        delay =3D 1000000000 / sensor->odr;=0A=
-       usleep_range(delay, 2 * delay);=0A=
+       usleep_range(3 * delay, 4 * delay);=0A=
=0A=
        err =3D st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));=0A=
        if (err < 0)=0A=
--=0A=
2.34.1=0A=
=0A=
