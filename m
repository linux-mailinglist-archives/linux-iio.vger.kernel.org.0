Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5FF22C0AC
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGXIaV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 04:30:21 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:9728 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgGXIaV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 04:30:21 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O8QO3I030423;
        Fri, 24 Jul 2020 01:29:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=6ADkOoGfFGTH0hdQxPhYxhC57zeb361YJRXsTgUfjcE=;
 b=ztXDN9Qhn8CGshPMAga7YlGfSrwj5s7sC0xhdc1dfnQuvlsMFcB0BSbCEnnL96X3LA18
 ihGbNCwQUjG5T9SwA3PtbSB8RdzenaBM17Dzc/Umj6SGgUFy5cANWr6WWlablDFniQyv
 1cHiSivMgoXvIV+yxxfxTgoZTYYauBbYlYTrjtSId8G2JBbbPGB9pwM/cYrhjVtZsDnO
 gCXB8gd3NMYJfvPgMGLVnRNEELrHLZ6yvm7K0P2KQ+f0KFyZr6n4wD8P/rRkSCzBzQK9
 XrEQnLnGYwrMEY0F7hjwp862+iz58hg0V1HoivGNYTBNyolLM0+5eWtYZ6vr+FFIa1ZH xw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00328301.pphosted.com with ESMTP id 32bvjnat1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 01:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jftk5zy+06d9wKUujd6fBVeP5ceJMW86a39IJxftx7ezwfWhdw0a8Ejxu95h3yY6yN1NRpXQBZ7HEpF2zxFRXOU83Cg7IppPYLn9mmbxc+qbMawRrAtxXPv4P3vyhNA/niHb9RuIoXSUTzeUSMO+GUWpLYVDCFx623VYTcs3TwPQe60LMbqOQ/ZmiMKg15qloXm4kDWG9sFg6Fl413Aorbiny+JESuWHJ7ilqz0VrdFFeKoGErfMYcouZuWEgFV9c6Eauu0CurstHuhISKUkpCwczlQ3aJDGg4M+RK3Q+gf+3ilY5cfY3lnQwwjlRSGpTzU0tFpIiwVupd+fN4HDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ADkOoGfFGTH0hdQxPhYxhC57zeb361YJRXsTgUfjcE=;
 b=DpFr3a5wYHRLIDhbZWDt4OtbGrL2NQSzVpICSmTmoh61Ysi3UVF68tBD7Px0StSui7v4vq49s7TmlkD2Hlz7L5+bDWbWev/9Ldqj07CRaqIodC9rTG27jJ8QkzwbjJc9u4V8IWjMmmKLKxYm5tNGDWTsZODQ4FDOTwHzZH5KAvuqt2Tt5xruWLgZWjzpLjCt2tATHksLVohKz1gDiS62/pq5sNrTVYDJLsn/1FkN7j7Mw6SnKBqbUeL3ds91xWEHKfPXhlpDUMAx2RA9RWywvbyPfIZ+F2vIDb1WUMFvVqA9lsjPv2VYRxU8PXlJC6SHGjBdvGMxEEtDsaWqyilMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ADkOoGfFGTH0hdQxPhYxhC57zeb361YJRXsTgUfjcE=;
 b=YAr6G/mlAfXOzFEXnL1mWVy6kvxuTNPS+c/K43R+0lALbPjmzlqD9mKjFGJZRHhJwJeoO8PyJWoObMWd8GIuWJYMXnNO8+d3dSDQpWWliBO+KAQLQm5jAQ9xfdwTLe3rizRKnKPfC1Ki4w/yrPusk5ssPLWots60H6XMmAljndE=
Received: from MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 by BL0PR12MB2547.namprd12.prod.outlook.com (2603:10b6:207:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:29:57 +0000
Received: from MN2PR12MB4390.namprd12.prod.outlook.com
 ([fe80::2c88:e0b6:478:a6e8]) by MN2PR12MB4390.namprd12.prod.outlook.com
 ([fe80::2c88:e0b6:478:a6e8%5]) with mapi id 15.20.3216.022; Fri, 24 Jul 2020
 08:29:57 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 18/27] iio:imu:inv_mpu6050: Use regmap_noinc_read for
 fifo reads.
Thread-Topic: [PATCH v3 18/27] iio:imu:inv_mpu6050: Use regmap_noinc_read for
 fifo reads.
Thread-Index: AQHWYEBE3jVA4Y7+JkeixjCixm2BLakWaBid
Date:   Fri, 24 Jul 2020 08:29:56 +0000
Message-ID: <MN2PR12MB43905A2256F98BB5EFCE7DD3C4770@MN2PR12MB4390.namprd12.prod.outlook.com>
References: <20200722155103.979802-1-jic23@kernel.org>,<20200722155103.979802-19-jic23@kernel.org>
In-Reply-To: <20200722155103.979802-19-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [2a01:e0a:2dd:a010:19ad:9472:dcb6:2bcc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe7f9eba-6608-4dde-28de-08d82fabbf71
x-ms-traffictypediagnostic: BL0PR12MB2547:
x-microsoft-antispam-prvs: <BL0PR12MB254791E77025C82DD6F4C4BDC4770@BL0PR12MB2547.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q1F6KDTW5bE/NGFB+XtCieLXW04jAfhrxcMG6rB0hhAQBpCI0zDiviRjznewbIRXoWewFurghgKmmAwt7rau+t/QZwie8J3kPNgnbJms5PlnzL19mBbuLKhDlL4+F/iiPqkwd21lKLED3byabuCHW48DH/K61Ig5tbCbqD5XtDHB7TrEGm0IJfuxzzYXLNvwHSaaeJcsWdDAcxOBGx4BtZmuLbO+Jg0ZckIX/wXUtlU/5qrhmh1iQEHde9y4oR2bA+jMWdNty2WQLHSo5TSowc1KxGFqmYxui4zoedxe3ZEk9Oi/nmB3mgnpP+HpROD/6IpdPiG9hNGXU4JC6FD7zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(39850400004)(346002)(376002)(66556008)(66476007)(64756008)(5660300002)(66446008)(66946007)(478600001)(83380400001)(76116006)(86362001)(71200400001)(7696005)(91956017)(9686003)(55016002)(52536014)(110136005)(8676002)(186003)(8936002)(316002)(2906002)(53546011)(6506007)(33656002)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: URZlAzorj42NqvU3HZoo8e1IggoVkq30zWjRETq2rVHRBod9jtN+//2QvHtd0/uQq1l4aFUcojaAZ3Ag9YDcOAtqxZnGahnscPM1GAPWe781GA0sqVsLK9/7pmSMLfLvNaWde+RXPoi1xzNrrdb6bvY81JbKicoGI5UbLQG4kKp2jnp+ZBdVI8XAPckaI2LiwaW1r7kvBSRaDemHzbjV9Xu9wufdGDWF5ytGSyNPKwyrYNE6viCJOwKABGBU12QOdmVzkWLQqEK5E2UxlbC96lBzlNS0lCWdk6sx8FDE6qlDeo+IltZBttPPn+melbRUAg15BnnJHK0/jDv8v0aYEwxfSya13r8xNfNLyb3cLn9VF8itfj0msrgr2QhJ/pOifJiOcXvRGSGOTwiMRA2M35tCXtTgDTB/Q1gm6a1yTrOFWFW7EP51/EpYL0JYt5WvC50Vxo/i0JhWuKxI7luR7IhIIz4/lkhWWfBi8hecBXvmOvrSLqZ6gDTFxiAIPKCD48tt4lOtuzIz6UWuwG3CfxDF+cy+prK+I9K3X3jdKSw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7f9eba-6608-4dde-28de-08d82fabbf71
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 08:29:57.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PK8svsGX+oLvuOSVWlAZOxS1nCq4vL7yRgFV4716EfZzUjqjNtsKYHkIG/fN7bcCiPgLaBWq7iI+FkoSq9x63wvPVjphjvanJkJj5ZozaWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_02:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240062
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
perfect.=0A=
=0A=
Thanks for the fix,=0A=
JB=0A=
=0A=
Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Wednesday, July 22, 2020 17:50=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Lars-Peter Clausen <lars@m=
etafoo.de>; Peter Meerwald <pmeerw@pmeerw.net>; Jonathan Cameron <Jonathan.=
Cameron@huawei.com>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Subject: [PATCH v3 18/27] iio:imu:inv_mpu6050: Use regmap_noinc_read for fi=
fo reads. =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
We should not be assuming that we are reading a sequence of=0A=
registers as here we are doing a read of a lot of data from=0A=
a single register address.=0A=
=0A=
Suggested-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 4 ++--=0A=
=A01 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_ring.c=0A=
index d8e6b88ddffc..45c37525c2f1 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
@@ -179,8 +179,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 nb =3D fifo_count / bytes_per_datum;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu6050_update_period(st, pf->timestamp, nb);=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < nb; ++i) {=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_bulk_read(st-=
>map, st->reg->fifo_r_w,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->data, bytes_per_datum)=
;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_noinc_read(st=
->map, st->reg->fifo_r_w,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->data, bytes_per_dat=
um);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 go=
to flush_fifo;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* skip first samples if n=
eeded */=0A=
-- =0A=
2.27.0=0A=
