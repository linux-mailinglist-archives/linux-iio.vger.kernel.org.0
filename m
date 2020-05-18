Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B971D7AD1
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 16:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgEROPA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 10:15:00 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:8544 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbgEROPA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 10:15:00 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IEETre019523;
        Mon, 18 May 2020 07:14:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=c1CHE4tFjtoIEqt0Cp+OFOnkXDe7cB6mNNtYJGwMI9o=;
 b=gyfTIMgB6SpgeTSlISimYdwuUJNc9Gm09xsPSYzAnNoip4v+r+P5lXhWNSLWLCEeLaAg
 kzPSL1wIQ4fVUb9YcpC4h1adbvS2v5CxMgKEPYJgOTqsz7Agwcr+Oj211Ke3l7xya7wP
 oAR49eLham3V5mwfI3J0PofLgIWxIXrrC0jYd6BZyEWS+DCWZNt3R1b22Btyg3qH4vrg
 85TCVs4R2/ovJgjNnJ6z/ncuUfAAqInRHr2Q8w2Y06w0nVYXPrHbO9WTkCwim9KYd8Tw
 ifIpcUSVx3h5t6UiNT8ZssP7rY7aEBriuyQ4p8rJ2nY2u9USmnL6KXVBqgPxjmoWj7Hx gw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0b-00328301.pphosted.com with ESMTP id 312c4pgp8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 07:14:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIOWJL9Z0G05duLz/UDHx8wtGYYntUs5LSmqSWsnVSwU8fdb3U6xTzU1Hwo2nb82g2XtEOz9kcpiIwA7Y8YzgKG3HyEQ4E9/EMVCvFaIfUsqIYoeVxlmXLAW6Y5S2x68lHu1zqxdMdeATWkYtOOiCWM/Xf8AvuPKSjSi+KtlWbLQYO2syna/cLwq9Z9ahexvQj8FCD3UWLHFJa/+ssdcOm0zTM/mDDSqiMvNUNkaq9SMlO1cqKw0GrB04YKs5skMctQwLwb7f7NIF1jK2x/4+yNWFFkYlHHQzOlNBv76ZhkA/7xk3VfFyl4KsuNqVZdIz9wl2PmsLgHFbE8LW8XEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1CHE4tFjtoIEqt0Cp+OFOnkXDe7cB6mNNtYJGwMI9o=;
 b=V2PYKfpn01Rox+GWEmqtaSCSkLydRN9x0mSXdxR/QD4NqJGEgmZETM1AeptCWg/fgEGUs6yG+9PLaS7gXIzU5lKnuh3FfYfbWgxFMBnvaA8qt2VOEEIiYyf5/VoIZrGQ9bGE0287Qg3X+2p2RhiJnKbhqDCyABNGWoqYTi+ihpcXUh1J+0luAIj3I1peVtPK3KgRfQhgbOTDolbKmRe8ILND3W32xrUko4wFByULwpFW3CmFyUHGxT+Sn9FP/WGzzSLWXm/TlYkA7h+PHgCX9fVKnq9+6wuC6VUWEYV9TwccH3ERlDTim9R4Q69uin169csY3+UQpDsYkApNERnNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1CHE4tFjtoIEqt0Cp+OFOnkXDe7cB6mNNtYJGwMI9o=;
 b=R3tPXPvqQ70dV7htH45kXgryUIAX2uoQGdbxPSAQCg7wKA0savN7cmqrHTXyI/Q3PyDQMcltlY/dU/ak5/mOhrvJJ9NLWHtfNeA1YCUtIkoyAQrtO3vUYgdvhs7w0S56XnKHV7xNa98FmO1dkhMZRK2UsY3hV2dWx0ueW8nW4CI=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3472.namprd12.prod.outlook.com (2603:10b6:208:d2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 14:14:27 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%9]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 14:14:26 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] iio: imu: inv_icm42600: add core of new
 inv_icm42600 driver
Thread-Topic: [PATCH 01/12] iio: imu: inv_icm42600: add core of new
 inv_icm42600 driver
Thread-Index: AQHWJH3SyifSvIhoTUGsMAYLanfJc6ieMBgAgA/CnzQ=
Date:   Mon, 18 May 2020 14:14:26 +0000
Message-ID: <MN2PR12MB44227D5AEA06F37269C03BCBC4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-2-jmaneyrol@invensense.com>,<20200508142820.000057f8@Huawei.com>
In-Reply-To: <20200508142820.000057f8@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 811f8f6d-d790-4e2a-f3b5-08d7fb35c5ef
x-ms-traffictypediagnostic: MN2PR12MB3472:
x-microsoft-antispam-prvs: <MN2PR12MB34726D8AB62FFE7241792399C4B80@MN2PR12MB3472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJoXTKo89nDTA1DmjsQjGx7EIR074xTBSHPTvCbRxoMmr5cnL7vXy4ybFObLFzPMYGZ5OmxSpRq7syMKAdv1rB6zB7ClesRHEl+/iYGor7vazSj3XfUCgrsc/lsnmhUsXTIjq5z1G8cCS+f5Gw0aXhbes7ONcM34zIg+AIM5cKgB0qI/oQQgN+WiSPI4d6Ighk/TbhGcvMbl1P+FtX2ziKLOmVBjMCZ5IdNS249Dkvc81PKNhoHmunYVysCXo8xBz+TTLCaTpOEXocmgj2MTlzUjed4r6tWyIQ12e6dag6sSWTP76Kuv1bahT1+K8N33wFjCVDcM0zsw7NU4SwJwCLitxwtzBgJ/5gVwvzRXr0+fsRMlOiuWlMYyg9p1WQ8dFXDBumcLJt3BtSRs+HzmiXIg6GzwvLBqxWRUODD3xFPtc05n2ShYfyCi5tg7irFU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(366004)(39850400004)(136003)(86362001)(316002)(52536014)(7416002)(6506007)(26005)(53546011)(186003)(7696005)(5660300002)(4326008)(8936002)(6916009)(54906003)(30864003)(66946007)(66556008)(64756008)(2906002)(66446008)(66476007)(8676002)(76116006)(91956017)(33656002)(71200400001)(9686003)(55016002)(478600001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: L1pxySWj8+hcfo8L3rWyPRYArHw9YKJ58jizJ3sy+RUVUVh+d3xyu/FNcT9Lv1GDKWV7NxUg5nZ039UDMb+60fsVhC/CTe8BxSPU2vsWusUgSMBbTHs2b4xJNjasQ8qVvOBGcaecAwtygJ5tL3QWrWQqkIoDwMNXj3XXzrzUu/aruTFlqdmz89aDwi2Gme9CzXh5S9ZLlAvN4cUY6HxzKJE1XzbRHBiY2JNDKpTAYgO8zkCtzNBQJmtMh3v0a1WBjjBB8ItYTDp4AaQI3dbWI6wNDY13cDSz4SOeWxTyUW67VFJI5nB2achaVxlE9XEM32uL3oEse88IejSVWkgS8eXlbSZudkQd8HeziI3zgRm8rn6QcrIXhwu/nyCFRdHnpMQq3H3zA4A6cxfvd3x91P3bM9b2gidWwPLc40ATe8nEmLDndBy4B4YZ86CwlAffWVNxKXDFIIafM/SbVN9JMmqdiVU6ay9gy9aP/72I+mw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811f8f6d-d790-4e2a-f3b5-08d7fb35c5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 14:14:26.6072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XsGsuhuMZm4lo5leoGS/9tIPaN83lrSatv0CCxfQFbrqBgFbb7lgL5xDFS1o0Fekq+ERcgpK70+ZnJUqU7AOlSrDOyB/I34EXq6FZOzaGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3472
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
thanks for the feedbacks, I'm sorry but I will not be able to have a correc=
t email formatting to respond you inline.=0A=
=0A=
No problem with all the comments. For iio_device_get_drvdata, it would make=
 more sense to use a const struct iio_dev * as argument. I am obliged to do=
 the pointer conversion since iio_get_mount_matrix requires the use of a co=
nst struct iio_dev *.=0A=
=0A=
For resume/suspend, I will add commentaries to explain what it is really do=
ing and for which purpose. Sensor states save and restore will remain in th=
is patch, since it makes more sense to have it as a core functionnality, as=
 much as gyro/accel turn on/off.=0A=
=0A=
Thanks.=0A=
JB=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
=0A=
Sent: Friday, May 8, 2020 15:28=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: jic23@kernel.org <jic23@kernel.org>; robh+dt@kernel.org <robh+dt@kernel=
.org>; robh@kernel.org <robh@kernel.org>; mchehab+huawei@kernel.org <mcheha=
b+huawei@kernel.org>; davem@davemloft.net <davem@davemloft.net>; gregkh@lin=
uxfoundation.org <gregkh@linuxfoundation.org>;=0A=
 linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vger.ker=
nel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH 01/12] iio: imu: inv_icm42600: add core of new inv_icm4=
2600 driver=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
On Thu, 7 May 2020 16:42:11 +0200=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Core component of a new driver for InvenSense ICM-426xx devices.=0A=
=0A=
> It includes registers definition, main probe/setup, and device=0A=
=0A=
> utility functions.=0A=
=0A=
> =0A=
=0A=
> ICM-426xx devices are latest generation of 6-axis IMU,=0A=
=0A=
> gyroscope+accelerometer and temperature sensor. This device=0A=
=0A=
> includes a 2K FIFO, supports I2C/I3C/SPI, and provides=0A=
=0A=
> intelligent motion features like pedometer, tilt detection,=0A=
=0A=
> and tap detection.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
=0A=
Hi Jean-Baptiste,=0A=
=0A=
=0A=
=0A=
A few minor things inline.=0A=
=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0 | 372 +++++++++++=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 | 618 ++++++++++++++++=
++=0A=
=0A=
>=A0 2 files changed, 990 insertions(+)=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..8da4c8249aed=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
> @@ -0,0 +1,372 @@=0A=
=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
=0A=
> +/*=0A=
=0A=
> + * Copyright (C) 2020 Invensense, Inc.=0A=
=0A=
> + */=0A=
=0A=
> +=0A=
=0A=
> +#ifndef INV_ICM42600_H_=0A=
=0A=
> +#define INV_ICM42600_H_=0A=
=0A=
> +=0A=
=0A=
> +#include <linux/bits.h>=0A=
=0A=
> +#include <linux/bitfield.h>=0A=
=0A=
> +#include <linux/regmap.h>=0A=
=0A=
> +#include <linux/mutex.h>=0A=
=0A=
> +#include <linux/regulator/consumer.h>=0A=
=0A=
> +#include <linux/pm.h>=0A=
=0A=
> +#include <linux/iio/iio.h>=0A=
=0A=
> +=0A=
=0A=
> +enum inv_icm42600_chip {=0A=
=0A=
> +=A0=A0=A0=A0 INV_CHIP_ICM42600,=0A=
=0A=
> +=A0=A0=A0=A0 INV_CHIP_ICM42602,=0A=
=0A=
> +=A0=A0=A0=A0 INV_CHIP_ICM42605,=0A=
=0A=
> +=A0=A0=A0=A0 INV_CHIP_ICM42622,=0A=
=0A=
> +=A0=A0=A0=A0 INV_CHIP_NB,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +/* serial bus slew rates */=0A=
=0A=
> +enum inv_icm42600_slew_rate {=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SLEW_RATE_20_60NS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SLEW_RATE_12_36NS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SLEW_RATE_6_18NS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SLEW_RATE_4_12NS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SLEW_RATE_2_6NS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SLEW_RATE_INF_2NS,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +enum inv_icm42600_sensor_mode {=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_OFF,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_STANDBY,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_LOW_POWER,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_LOW_NOISE,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_NB,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +/* gyroscope fullscale values */=0A=
=0A=
> +enum inv_icm42600_gyro_fs {=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_FS_2000DPS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_FS_1000DPS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_FS_500DPS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_FS_250DPS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_FS_125DPS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_FS_62_5DPS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_FS_31_25DPS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_FS_15_625DPS,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_FS_NB,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +/* accelerometer fullscale values */=0A=
=0A=
> +enum inv_icm42600_accel_fs {=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ACCEL_FS_16G,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ACCEL_FS_8G,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ACCEL_FS_4G,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ACCEL_FS_2G,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ACCEL_FS_NB,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */=0A=
=0A=
> +enum inv_icm42600_odr {=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_8KHZ_LN =3D 3,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_4KHZ_LN,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_2KHZ_LN,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_1KHZ_LN,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_200HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_100HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_50HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_25HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_12_5HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_6_25HZ_LP,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_3_125HZ_LP,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_1_5625HZ_LP,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_500HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_NB,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +enum inv_icm42600_filter {=0A=
=0A=
> +=A0=A0=A0=A0 /* Low-Noise mode sensor data filter (3rd order filter by d=
efault) */=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_FILTER_BW_ODR_DIV_2,=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* Low-Power mode sensor data filter (averaging) */=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_FILTER_AVG_1X =3D 1,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_FILTER_AVG_16X =3D 6,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_sensor_conf {=0A=
=0A=
> +=A0=A0=A0=A0 int mode;=0A=
=0A=
> +=A0=A0=A0=A0 int fs;=0A=
=0A=
> +=A0=A0=A0=A0 int odr;=0A=
=0A=
> +=A0=A0=A0=A0 int filter;=0A=
=0A=
> +};=0A=
=0A=
> +#define INV_ICM42600_SENSOR_CONF_INIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 {-1, -1, -1, -1}=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_conf {=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf gyro;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf accel;=0A=
=0A=
> +=A0=A0=A0=A0 bool temp_en;=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_suspended {=0A=
=0A=
> +=A0=A0=A0=A0 enum inv_icm42600_sensor_mode gyro;=0A=
=0A=
> +=A0=A0=A0=A0 enum inv_icm42600_sensor_mode accel;=0A=
=0A=
> +=A0=A0=A0=A0 bool temp;=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +/*=0A=
=0A=
/**=0A=
=0A=
=0A=
=0A=
It's valid kernel doc so lets mark it as such.=0A=
=0A=
=0A=
=0A=
> + *=A0 struct inv_icm42600_state - driver state variables=0A=
=0A=
> + *=A0 @lock:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip access lock.=0A=
=0A=
=0A=
=0A=
Nice to be a bit more specific on that.=A0 What about the chip needs=0A=
=0A=
a lock at this level as opposed to bus locks etc?=0A=
=0A=
=0A=
=0A=
> + *=A0 @chip:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip identifier.=0A=
=0A=
> + *=A0 @name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip name.=0A=
=0A=
> + *=A0 @map:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regmap pointer.=0A=
=0A=
> + *=A0 @vdd_supply:=A0=A0=A0=A0 VDD voltage regulator for the chip.=0A=
=0A=
> + *=A0 @vddio_supply:=A0=A0 I/O voltage regulator for the chip.=0A=
=0A=
> + *=A0 @orientation:=A0=A0=A0 sensor chip orientation relative to main ha=
rdware.=0A=
=0A=
> + *=A0 @conf:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip sensors configurations.=
=0A=
=0A=
> + *=A0 @suspended:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 suspended senso=
rs configuration.=0A=
=0A=
> + */=0A=
=0A=
> +struct inv_icm42600_state {=0A=
=0A=
> +=A0=A0=A0=A0 struct mutex lock;=0A=
=0A=
> +=A0=A0=A0=A0 enum inv_icm42600_chip chip;=0A=
=0A=
> +=A0=A0=A0=A0 const char *name;=0A=
=0A=
> +=A0=A0=A0=A0 struct regmap *map;=0A=
=0A=
> +=A0=A0=A0=A0 struct regulator *vdd_supply;=0A=
=0A=
> +=A0=A0=A0=A0 struct regulator *vddio_supply;=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_mount_matrix orientation;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_conf conf;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_suspended suspended;=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +/* Virtual register addresses: @bank on MSB (4 upper bits), @address on =
LSB */=0A=
=0A=
> +=0A=
=0A=
> +/* Bank selection register, available in all banks */=0A=
=0A=
> +#define INV_ICM42600_REG_BANK_SEL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x76=0A=
=0A=
> +#define INV_ICM42600_BANK_SEL_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 GENMASK(2, 0)=0A=
=0A=
> +=0A=
=0A=
> +/* User bank 0 (MSB 0x00) */=0A=
=0A=
> +#define INV_ICM42600_REG_DEVICE_CONFIG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0011=0A=
=0A=
> +#define INV_ICM42600_DEVICE_CONFIG_SOFT_RESET=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(0)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_DRIVE_CONFIG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0013=0A=
=0A=
> +#define INV_ICM42600_DRIVE_CONFIG_I2C_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 GENMASK(5, 3)=0A=
=0A=
> +#define INV_ICM42600_DRIVE_CONFIG_I2C(_rate)=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(INV_ICM42600_DRIVE_CONFI=
G_I2C_MASK, (_rate))=0A=
=0A=
> +#define INV_ICM42600_DRIVE_CONFIG_SPI_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 GENMASK(2, 0)=0A=
=0A=
> +#define INV_ICM42600_DRIVE_CONFIG_SPI(_rate)=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(INV_ICM42600_DRIVE_CONFI=
G_SPI_MASK, (_rate))=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_INT_CONFIG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x0014=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG_INT2_LATCHED=A0=A0=A0=A0=A0=A0=A0=A0 BIT=
(5)=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG_INT2_PUSH_PULL=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(4)=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG_INT2_ACTIVE_HIGH=A0=A0=A0=A0 BIT(3)=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG_INT2_ACTIVE_LOW=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x00=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG_INT1_LATCHED=A0=A0=A0=A0=A0=A0=A0=A0 BIT=
(2)=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG_INT1_PUSH_PULL=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(1)=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG_INT1_ACTIVE_HIGH=A0=A0=A0=A0 BIT(0)=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x00=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_FIFO_CONFIG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x0016=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GENMASK(7, 6)=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG_BYPASS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(INV_ICM42600_FIFO_CONFIG=
_MASK, 0)=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG_STREAM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(INV_ICM42600_FIFO_CONFIG=
_MASK, 1)=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG_STOP_ON_FULL=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(INV_ICM42600_FIFO_CONFIG=
_MASK, 2)=0A=
=0A=
> +=0A=
=0A=
> +/* all sensor data are 16 bits (2 registers wide) in big-endian */=0A=
=0A=
> +#define INV_ICM42600_REG_TEMP_DATA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x001D=0A=
=0A=
> +#define INV_ICM42600_REG_ACCEL_DATA_X=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x001F=0A=
=0A=
> +#define INV_ICM42600_REG_ACCEL_DATA_Y=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0021=0A=
=0A=
> +#define INV_ICM42600_REG_ACCEL_DATA_Z=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0023=0A=
=0A=
> +#define INV_ICM42600_REG_GYRO_DATA_X=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x0025=0A=
=0A=
> +#define INV_ICM42600_REG_GYRO_DATA_Y=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x0027=0A=
=0A=
> +#define INV_ICM42600_REG_GYRO_DATA_Z=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x0029=0A=
=0A=
> +#define INV_ICM42600_DATA_INVALID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 -32768=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_INT_STATUS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x002D=0A=
=0A=
> +#define INV_ICM42600_INT_STATUS_UI_FSYNC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 BIT(6)=0A=
=0A=
> +#define INV_ICM42600_INT_STATUS_PLL_RDY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(5)=0A=
=0A=
> +#define INV_ICM42600_INT_STATUS_RESET_DONE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 BIT(4)=0A=
=0A=
> +#define INV_ICM42600_INT_STATUS_DATA_RDY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 BIT(3)=0A=
=0A=
> +#define INV_ICM42600_INT_STATUS_FIFO_THS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 BIT(2)=0A=
=0A=
> +#define INV_ICM42600_INT_STATUS_FIFO_FULL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 BIT(1)=0A=
=0A=
> +#define INV_ICM42600_INT_STATUS_AGC_RDY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(0)=0A=
=0A=
> +=0A=
=0A=
> +/*=0A=
=0A=
> + * FIFO access registers=0A=
=0A=
> + * FIFO count is 16 bits (2 registers) big-endian=0A=
=0A=
> + * FIFO data is a continuous read register to read FIFO content=0A=
=0A=
> + */=0A=
=0A=
> +#define INV_ICM42600_REG_FIFO_COUNT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x002E=0A=
=0A=
> +#define INV_ICM42600_REG_FIFO_DATA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x0030=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_SIGNAL_PATH_RESET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0x004B=0A=
=0A=
> +#define INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN=A0=A0 BIT(6)=0A=
=0A=
> +#define INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET BIT(5)=0A=
=0A=
> +#define INV_ICM42600_SIGNAL_PATH_RESET_RESET=A0=A0=A0=A0=A0=A0=A0=A0 BIT=
(3)=0A=
=0A=
> +#define INV_ICM42600_SIGNAL_PATH_RESET_TMST_STROBE=A0=A0 BIT(2)=0A=
=0A=
> +#define INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH=A0=A0=A0 BIT(1)=0A=
=0A=
> +=0A=
=0A=
> +/* default configuration: all data big-endian and fifo count in bytes */=
=0A=
=0A=
> +#define INV_ICM42600_REG_INTF_CONFIG0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x004C=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG0_FIFO_HOLD_LAST_DATA=A0=A0=A0=A0=A0=A0=
=A0 BIT(7)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_REC=A0=A0=A0=A0 BIT(6)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_ENDIAN=A0 BIT(5)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN BIT(4)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK=A0=A0 GENMASK(1, 0)=
=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(INV_ICM42600_INTF_CONFIG=
0_UI_SIFS_CFG_MASK, 2)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(INV_ICM42600_INTF_CONFIG=
0_UI_SIFS_CFG_MASK, 3)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_INTF_CONFIG1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x004D=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC=A0=A0=A0 BIT(3)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_PWR_MGMT0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x004E=0A=
=0A=
> +#define INV_ICM42600_PWR_MGMT0_TEMP_DIS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(5)=0A=
=0A=
> +#define INV_ICM42600_PWR_MGMT0_IDLE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 BIT(4)=0A=
=0A=
> +#define INV_ICM42600_PWR_MGMT0_GYRO(_mode)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(GENMASK(3, 2), (_mode))=
=0A=
=0A=
> +#define INV_ICM42600_PWR_MGMT0_ACCEL(_mode)=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(GENMASK(1, 0), (_mode))=
=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_GYRO_CONFIG0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x004F=0A=
=0A=
> +#define INV_ICM42600_GYRO_CONFIG0_FS(_fs)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(GENMASK(7, 5), (_fs))=0A=
=0A=
> +#define INV_ICM42600_GYRO_CONFIG0_ODR(_odr)=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(GENMASK(3, 0), (_odr))=
=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_ACCEL_CONFIG0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0050=0A=
=0A=
> +#define INV_ICM42600_ACCEL_CONFIG0_FS(_fs)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(GENMASK(7, 5), (_fs))=0A=
=0A=
> +#define INV_ICM42600_ACCEL_CONFIG0_ODR(_odr)=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(GENMASK(3, 0), (_odr))=
=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_GYRO_ACCEL_CONFIG0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
x0052=0A=
=0A=
> +#define INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(_f)=A0=A0=A0=A0=A0=A0=
 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(GENMASK(7, 4), (_f))=0A=
=0A=
> +#define INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(_f)=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(GENMASK(3, 0), (_f))=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_TMST_CONFIG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x0054=0A=
=0A=
> +#define INV_ICM42600_TMST_CONFIG_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GENMASK(4, 0)=0A=
=0A=
> +#define INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN=A0=A0=A0=A0 BIT(4)=0A=
=0A=
> +#define INV_ICM42600_TMST_CONFIG_TMST_RES_16US=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(3)=0A=
=0A=
> +#define INV_ICM42600_TMST_CONFIG_TMST_DELTA_EN=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(2)=0A=
=0A=
> +#define INV_ICM42600_TMST_CONFIG_TMST_FSYNC_EN=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(1)=0A=
=0A=
> +#define INV_ICM42600_TMST_CONFIG_TMST_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 BIT(0)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_FIFO_CONFIG1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x005F=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD=A0 BIT(6)=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG1_WM_GT_TH=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 BIT(5)=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG1_TMST_FSYNC_EN=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 BIT(3)=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG1_TEMP_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 BIT(2)=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG1_GYRO_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 BIT(1)=0A=
=0A=
> +#define INV_ICM42600_FIFO_CONFIG1_ACCEL_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 BIT(0)=0A=
=0A=
> +=0A=
=0A=
> +/* FIFO watermark is 16 bits (2 registers wide) in little-endian */=0A=
=0A=
> +#define INV_ICM42600_REG_FIFO_WATERMARK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0060=0A=
=0A=
> +#define INV_ICM42600_FIFO_WATERMARK_VAL(_wm)=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_to_le16((_wm) & GENMASK(11, 0))=
=0A=
=0A=
> +/* FIFO is 2048 bytes, let 12 samples for reading latency */=0A=
=0A=
> +#define INV_ICM42600_FIFO_WATERMARK_MAX=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (2048 - 12 * 16)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_INT_CONFIG1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x0064=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG1_TPULSE_DURATION=A0=A0=A0=A0 BIT(6)=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG1_TDEASSERT_DISABLE=A0=A0 BIT(5)=0A=
=0A=
> +#define INV_ICM42600_INT_CONFIG1_ASYNC_RESET=A0=A0=A0=A0=A0=A0=A0=A0 BIT=
(4)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_INT_SOURCE0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x0065=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE0_UI_FSYNC_INT1_EN=A0=A0=A0 BIT(6)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE0_PLL_RDY_INT1_EN=A0=A0=A0=A0 BIT(5)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE0_RESET_DONE_INT1_EN=A0 BIT(4)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE0_UI_DRDY_INT1_EN=A0=A0=A0=A0 BIT(3)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN=A0=A0=A0 BIT(2)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE0_FIFO_FULL_INT1_EN=A0=A0 BIT(1)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE0_UI_AGC_RDY_INT1_EN=A0 BIT(0)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_WHOAMI=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0075=0A=
=0A=
> +#define INV_ICM42600_WHOAMI_ICM42600=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x40=0A=
=0A=
> +#define INV_ICM42600_WHOAMI_ICM42602=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x41=0A=
=0A=
> +#define INV_ICM42600_WHOAMI_ICM42605=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x42=0A=
=0A=
> +#define INV_ICM42600_WHOAMI_ICM42622=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x46=0A=
=0A=
> +=0A=
=0A=
> +/* User bank 1 (MSB 0x10) */=0A=
=0A=
> +#define INV_ICM42600_REG_SENSOR_CONFIG0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1003=0A=
=0A=
> +#define INV_ICM42600_SENSOR_CONFIG0_ZG_DISABLE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(5)=0A=
=0A=
> +#define INV_ICM42600_SENSOR_CONFIG0_YG_DISABLE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(4)=0A=
=0A=
> +#define INV_ICM42600_SENSOR_CONFIG0_XG_DISABLE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(3)=0A=
=0A=
> +#define INV_ICM42600_SENSOR_CONFIG0_ZA_DISABLE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(2)=0A=
=0A=
> +#define INV_ICM42600_SENSOR_CONFIG0_YA_DISABLE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(1)=0A=
=0A=
> +#define INV_ICM42600_SENSOR_CONFIG0_XA_DISABLE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(0)=0A=
=0A=
> +=0A=
=0A=
> +/* Timestamp value is 20 bits (3 registers) in little-endian */=0A=
=0A=
> +#define INV_ICM42600_REG_TMSTVAL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x1062=0A=
=0A=
> +#define INV_ICM42600_TMSTVAL_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 GENMASK(19, 0)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_INTF_CONFIG4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x107A=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(6)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG4_SPI_AP_4WIRE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(1)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_INTF_CONFIG6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x107C=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG6_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GENMASK(4, 0)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG6_I3C_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 BIT(4)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG6_I3C_IBI_BYTE_EN=A0=A0=A0 BIT(3)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG6_I3C_IBI_EN=A0=A0=A0=A0=A0=A0=A0=A0 BIT=
(2)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG6_I3C_DDR_EN=A0=A0=A0=A0=A0=A0=A0=A0 BIT=
(1)=0A=
=0A=
> +#define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN=A0=A0=A0=A0=A0=A0=A0=A0 BIT=
(0)=0A=
=0A=
> +=0A=
=0A=
> +/* User bank 4 (MSB 0x40) */=0A=
=0A=
> +#define INV_ICM42600_REG_INT_SOURCE8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x404F=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(5)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 BIT(4)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE8_UI_DRDY_IBI_EN=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 BIT(3)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE8_FIFO_THS_IBI_EN=A0=A0=A0=A0 BIT(2)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE8_FIFO_FULL_IBI_EN=A0=A0=A0 BIT(1)=0A=
=0A=
> +#define INV_ICM42600_INT_SOURCE8_AGC_RDY_IBI_EN=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 BIT(0)=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_REG_OFFSET_USER0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x4077=0A=
=0A=
> +#define INV_ICM42600_REG_OFFSET_USER1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x4078=0A=
=0A=
> +#define INV_ICM42600_REG_OFFSET_USER2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x4079=0A=
=0A=
> +#define INV_ICM42600_REG_OFFSET_USER3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x407A=0A=
=0A=
> +#define INV_ICM42600_REG_OFFSET_USER4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x407B=0A=
=0A=
> +#define INV_ICM42600_REG_OFFSET_USER5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x407C=0A=
=0A=
> +#define INV_ICM42600_REG_OFFSET_USER6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x407D=0A=
=0A=
> +#define INV_ICM42600_REG_OFFSET_USER7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x407E=0A=
=0A=
> +#define INV_ICM42600_REG_OFFSET_USER8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x407F=0A=
=0A=
> +=0A=
=0A=
> +/* Sleep times required by the driver */=0A=
=0A=
> +#define INV_ICM42600_POWER_UP_TIME_MS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 100=0A=
=0A=
> +#define INV_ICM42600_RESET_TIME_MS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=0A=
=0A=
> +#define INV_ICM42600_ACCEL_STARTUP_TIME_MS=A0=A0 20=0A=
=0A=
> +#define INV_ICM42600_GYRO_STARTUP_TIME_MS=A0=A0=A0 60=0A=
=0A=
> +#define INV_ICM42600_GYRO_STOP_TIME_MS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 150=0A=
=0A=
> +#define INV_ICM42600_TEMP_STARTUP_TIME_MS=A0=A0=A0 14=0A=
=0A=
> +#define INV_ICM42600_SUSPEND_DELAY_MS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 2000=0A=
=0A=
> +=0A=
=0A=
> +typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);=0A=
=0A=
> +=0A=
=0A=
> +extern const struct regmap_config inv_icm42600_regmap_config;=0A=
=0A=
> +extern const struct dev_pm_ops inv_icm42600_pm_ops;=0A=
=0A=
> +=0A=
=0A=
> +const struct iio_mount_matrix *=0A=
=0A=
> +inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 const struct iio_chan_spec *chan);=0A=
=0A=
> +=0A=
=0A=
> +uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr);=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 struct inv_icm42600_sensor_conf *conf,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 unsigned int *sleep);=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 struct inv_icm42600_sensor_conf *conf,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 unsigned int *sleep);=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enabl=
e,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 unsigned int *sleep);=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 unsigned int writeval, unsigned int *readval);=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 inv_icm42600_bus_setup bus_setup);=0A=
=0A=
> +=0A=
=0A=
> +#endif=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..35bdf4f9d31e=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> @@ -0,0 +1,618 @@=0A=
=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
=0A=
> +/*=0A=
=0A=
> + * Copyright (C) 2020 Invensense, Inc.=0A=
=0A=
> + */=0A=
=0A=
> +=0A=
=0A=
> +#include <linux/device.h>=0A=
=0A=
> +#include <linux/module.h>=0A=
=0A=
> +#include <linux/slab.h>=0A=
=0A=
> +#include <linux/delay.h>=0A=
=0A=
> +#include <linux/interrupt.h>=0A=
=0A=
> +#include <linux/regulator/consumer.h>=0A=
=0A=
> +#include <linux/pm_runtime.h>=0A=
=0A=
> +#include <linux/regmap.h>=0A=
=0A=
> +#include <linux/iio/iio.h>=0A=
=0A=
> +=0A=
=0A=
> +#include "inv_icm42600.h"=0A=
=0A=
> +=0A=
=0A=
> +static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] =3D {=
=0A=
=0A=
> +=A0=A0=A0=A0 {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "user banks",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .range_min =3D 0x0000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .range_max =3D 0x4FFF,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .selector_reg =3D INV_ICM42600_REG_=
BANK_SEL,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .selector_mask =3D INV_ICM42600_BAN=
K_SEL_MASK,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .selector_shift =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .window_start =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .window_len =3D 0x1000,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +const struct regmap_config inv_icm42600_regmap_config =3D {=0A=
=0A=
> +=A0=A0=A0=A0 .reg_bits =3D 8,=0A=
=0A=
> +=A0=A0=A0=A0 .val_bits =3D 8,=0A=
=0A=
> +=A0=A0=A0=A0 .max_register =3D 0x4FFF,=0A=
=0A=
> +=A0=A0=A0=A0 .ranges =3D inv_icm42600_regmap_ranges,=0A=
=0A=
> +=A0=A0=A0=A0 .num_ranges =3D ARRAY_SIZE(inv_icm42600_regmap_ranges),=0A=
=0A=
> +};=0A=
=0A=
> +EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_hw {=0A=
=0A=
> +=A0=A0=A0=A0 uint8_t whoami;=0A=
=0A=
> +=A0=A0=A0=A0 const char *name;=0A=
=0A=
> +=A0=A0=A0=A0 const struct inv_icm42600_conf *conf;=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +/* chip initial default configuration */=0A=
=0A=
> +static const struct inv_icm42600_conf inv_icm42600_default_conf =3D {=0A=
=0A=
> +=A0=A0=A0=A0 .gyro =3D {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .mode =3D INV_ICM42600_SENSOR_MODE_=
OFF,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fs =3D INV_ICM42600_GYRO_FS_2000DP=
S,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .odr =3D INV_ICM42600_ODR_50HZ,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .filter =3D INV_ICM42600_FILTER_BW_=
ODR_DIV_2,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +=A0=A0=A0=A0 .accel =3D {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .mode =3D INV_ICM42600_SENSOR_MODE_=
OFF,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fs =3D INV_ICM42600_ACCEL_FS_16G,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .odr =3D INV_ICM42600_ODR_50HZ,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .filter =3D INV_ICM42600_FILTER_BW_=
ODR_DIV_2,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +=A0=A0=A0=A0 .temp_en =3D false,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static const struct inv_icm42600_hw inv_icm42600_hw[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 [INV_CHIP_ICM42600] =3D {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM42600_WHOAMI_ICM=
42600,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "icm42600",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .conf =3D &inv_icm42600_default_con=
f,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +=A0=A0=A0=A0 [INV_CHIP_ICM42602] =3D {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM42600_WHOAMI_ICM=
42602,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "icm42602",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .conf =3D &inv_icm42600_default_con=
f,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +=A0=A0=A0=A0 [INV_CHIP_ICM42605] =3D {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM42600_WHOAMI_ICM=
42605,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "icm42605",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .conf =3D &inv_icm42600_default_con=
f,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +=A0=A0=A0=A0 [INV_CHIP_ICM42622] =3D {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM42600_WHOAMI_ICM=
42622,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "icm42622",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .conf =3D &inv_icm42600_default_con=
f,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +const struct iio_mount_matrix *=0A=
=0A=
> +inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 const struct iio_chan_spec *chan)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 const struct inv_icm42600_state *st =3D=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_=
get_drvdata((struct iio_dev *)indio_dev);=0A=
=0A=
=0A=
=0A=
Interesting... iio_device_get_drvdata is never going to modify=0A=
=0A=
the struct iio_dev.=A0 Should we just change that to take a=0A=
=0A=
const struct iio_dev * ?=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return &st->orientation;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 static uint32_t odr_periods[INV_ICM42600_ODR_NB] =3D {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* reserved values */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0, 0, 0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 8kHz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 125000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 4kHz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 250000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 2kHz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 500000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 1kHz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1000000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 200Hz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5000000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 100Hz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10000000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 50Hz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20000000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 25Hz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 40000000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 12.5Hz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 80000000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 6.25Hz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 160000000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 3.125Hz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 320000000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 1.5625Hz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 640000000,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* 500Hz */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2000000,=0A=
=0A=
> +=A0=A0=A0=A0 };=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return odr_periods[odr];=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_set_pwr_mgmt0(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum inv_icm42600_sensor_mode gyro,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum inv_icm42600_sensor_mode accel,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool temp, unsigned int *sleep)=0A=
=0A=
=0A=
=0A=
msleep or similar that indicates the units of the sleep time.=0A=
=0A=
=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 enum inv_icm42600_sensor_mode oldgyro =3D st->conf.gyro.mod=
e;=0A=
=0A=
> +=A0=A0=A0=A0 enum inv_icm42600_sensor_mode oldaccel =3D st->conf.accel.m=
ode;=0A=
=0A=
> +=A0=A0=A0=A0 bool oldtemp =3D st->conf.temp_en;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sleepval;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int val;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* if nothing changed, exit */=0A=
=0A=
> +=A0=A0=A0=A0 if (gyro =3D=3D oldgyro && accel =3D=3D oldaccel && temp =
=3D=3D oldtemp)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_PWR_MGMT0_GYRO(gyro) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_PWR_MGMT0_ACCEL(accel);=0A=
=0A=
> +=A0=A0=A0=A0 if (!temp)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val |=3D INV_ICM42600_PWR_MGMT0_TEM=
P_DIS;=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map), "pwr_mgmt0: %#02x\n", v=
al);=0A=
=0A=
=0A=
=0A=
I wonder if you have a little too much in the way of debug prints.=0A=
=0A=
These are internal to the code and so could only be wrong due to a local=0A=
=0A=
bug.=A0 Once you've finished writing the driver I'd hope we won't need thes=
e!=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_PWR_MGMT0, v=
al);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->conf.gyro.mode =3D gyro;=0A=
=0A=
> +=A0=A0=A0=A0 st->conf.accel.mode =3D accel;=0A=
=0A=
> +=A0=A0=A0=A0 st->conf.temp_en =3D temp;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* compute required wait time for sensors to stabilize */=
=0A=
=0A=
> +=A0=A0=A0=A0 sleepval =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 /* temperature stabilization time */=0A=
=0A=
> +=A0=A0=A0=A0 if (temp && !oldtemp) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (sleepval < INV_ICM42600_TEMP_ST=
ARTUP_TIME_MS)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleepval =
=3D INV_ICM42600_TEMP_STARTUP_TIME_MS;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 /* accel startup time */=0A=
=0A=
> +=A0=A0=A0=A0 if (accel !=3D oldaccel && oldaccel =3D=3D INV_ICM42600_SEN=
SOR_MODE_OFF) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* block any register write for at =
least 200 =B5s */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(200, 300);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (sleepval < INV_ICM42600_ACCEL_S=
TARTUP_TIME_MS)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleepval =
=3D INV_ICM42600_ACCEL_STARTUP_TIME_MS;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 if (gyro !=3D oldgyro) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* gyro startup time */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (oldgyro =3D=3D INV_ICM42600_SEN=
SOR_MODE_OFF) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* block an=
y register write for at least 200 =B5s */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_rang=
e(200, 300);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (sleepva=
l < INV_ICM42600_GYRO_STARTUP_TIME_MS)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 sleepval =3D INV_ICM42600_GYRO_STARTUP_TIME_MS;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* gyro stop time */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (gyro =3D=3D INV_ICM42600=
_SENSOR_MODE_OFF) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (sleepva=
l < INV_ICM42600_GYRO_STOP_TIME_MS)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 sleepval =3D=A0 INV_ICM42600_GYRO_STOP_TIME_MS;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* deferred sleep value if sleep pointer is provided or dir=
ect sleep */=0A=
=0A=
> +=A0=A0=A0=A0 if (sleep)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *sleep =3D sleepval;=0A=
=0A=
> +=A0=A0=A0=A0 else if (sleepval)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleepval);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 struct inv_icm42600_sensor_conf *conf,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 unsigned int *sleep)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf *oldconf =3D &st->conf.acce=
l;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int val;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* Sanitize missing values with current values */=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->mode < 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf->mode =3D oldconf->mode;=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->fs < 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf->fs =3D oldconf->fs;=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->odr < 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf->odr =3D oldconf->odr;=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->filter < 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf->filter =3D oldconf->filter;=
=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set ACCEL_CONFIG0 register (accel fullscale & odr) */=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->fs !=3D oldconf->fs || conf->odr !=3D oldconf->od=
r) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_ACCEL_CONFIG0_=
FS(conf->fs) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_ACCE=
L_CONFIG0_ODR(conf->odr);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map),=
 "accel_config0: %#02x\n", val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_ACCEL_CONFIG0, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 oldconf->fs =3D conf->fs;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 oldconf->odr =3D conf->odr;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set GYRO_ACCEL_CONFIG0 register (accel filter) */=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->filter !=3D oldconf->filter) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_GYRO_ACCEL_CON=
FIG0_ACCEL_FILT(conf->filter) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO=
_ACCEL_CONFIG0_GYRO_FILT(st->conf.gyro.filter);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map),=
 "gyro_accel_config0: %#02x\n", val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_GYRO_ACCEL_CONFIG0, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 oldconf->filter =3D conf->filter;=
=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set PWR_MGMT0 register (accel sensor mode) */=0A=
=0A=
> +=A0=A0=A0=A0 return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode, c=
onf->mode,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->conf.temp_en, sleep);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 struct inv_icm42600_sensor_conf *conf,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 unsigned int *sleep)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf *oldconf =3D &st->conf.gyro=
;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int val;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* sanitize missing values with current values */=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->mode < 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf->mode =3D oldconf->mode;=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->fs < 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf->fs =3D oldconf->fs;=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->odr < 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf->odr =3D oldconf->odr;=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->filter < 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf->filter =3D oldconf->filter;=
=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set GYRO_CONFIG0 register (gyro fullscale & odr) */=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->fs !=3D oldconf->fs || conf->odr !=3D oldconf->od=
r) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_GYRO_CONFIG0_F=
S(conf->fs) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO=
_CONFIG0_ODR(conf->odr);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map),=
 "gyro_config0: %#02x\n", val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_GYRO_CONFIG0, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 oldconf->fs =3D conf->fs;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 oldconf->odr =3D conf->odr;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set GYRO_ACCEL_CONFIG0 register (gyro filter) */=0A=
=0A=
> +=A0=A0=A0=A0 if (conf->filter !=3D oldconf->filter) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_GYRO_ACCEL_CON=
FIG0_ACCEL_FILT(st->conf.accel.filter) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO=
_ACCEL_CONFIG0_GYRO_FILT(conf->filter);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map),=
 "gyro_accel_config0: %#02x\n", val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_GYRO_ACCEL_CONFIG0, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 oldconf->filter =3D conf->filter;=
=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set PWR_MGMT0 register (gyro sensor mode) */=0A=
=0A=
> +=A0=A0=A0=A0 return inv_icm42600_set_pwr_mgmt0(st, conf->mode, st->conf.=
accel.mode,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->conf.temp_en, sleep);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enabl=
e,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 unsigned int *sleep)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->conf.accel.mode, enable,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 unsigned int writeval, unsigned int *readval)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (readval)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, reg, r=
eadval);=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, reg, =
writeval);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_set_conf(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 const struct inv_icm42600_conf *conf)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int val;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set PWR_MGMT0 register (gyro & accel sensor mode, temp e=
nabled) */=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_PWR_MGMT0_GYRO(conf->gyro.mode) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_PWR_MGMT0_ACCEL(conf->accel.=
mode);=0A=
=0A=
> +=A0=A0=A0=A0 if (!conf->temp_en)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val |=3D INV_ICM42600_PWR_MGMT0_TEM=
P_DIS;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_PWR_MGMT0, v=
al);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set GYRO_CONFIG0 register (gyro fullscale & odr) */=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_GYRO_CONFIG0_FS(conf->gyro.fs) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO_CONFIG0_ODR(conf->gyro.=
odr);=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_CONFIG0=
, val);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set ACCEL_CONFIG0 register (accel fullscale & odr) */=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_ACCEL_CONFIG0_FS(conf->accel.fs) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_ACCEL_CONFIG0_ODR(conf->acce=
l.odr);=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_ACCEL_CONFIG=
0, val);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set GYRO_ACCEL_CONFIG0 register (gyro & accel filters) *=
/=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(conf->ac=
cel.filter) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT=
(conf->gyro.filter);=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_C=
ONFIG0, val);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* update internal conf */=0A=
=0A=
> +=A0=A0=A0=A0 st->conf =3D *conf;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +/**=0A=
=0A=
> + *=A0 inv_icm42600_setup() - check and setup chip.=0A=
=0A=
=0A=
=0A=
If doing kernel-doc (which is good) you should do it all.=0A=
=0A=
So document the parameters as well.=0A=
=0A=
It's worth running the kernel-doc script over any file where=0A=
=0A=
you put some and fixing up any warnings / errors.=0A=
=0A=
=0A=
=0A=
> + */=0A=
=0A=
> +static int inv_icm42600_setup(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 inv_icm42600_bus_setup bus_setup)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 const struct inv_icm42600_hw *hw =3D &inv_icm42600_hw[st->c=
hip];=0A=
=0A=
> +=A0=A0=A0=A0 const struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int mask, val;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* check chip self-identification value */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_ICM42600_REG_WHOAMI, &val)=
;=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 if (val !=3D hw->whoami) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "invalid whoami %#02x =
expected %#02x (%s)\n",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val, hw->wh=
oami, hw->name);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 dev_info(dev, "found %s (%#02x)\n", hw->name, hw->whoami);=
=0A=
=0A=
=0A=
=0A=
Hmm. I'm never that keen on this sort of log noise.=A0 Why do you need it=
=0A=
=0A=
except for initial debug?=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 st->name =3D hw->name;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* reset to make sure previous state are not there */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_DEVICE_CONFI=
G,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IN=
V_ICM42600_DEVICE_CONFIG_SOFT_RESET);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 msleep(INV_ICM42600_RESET_TIME_MS);=0A=
=0A=
=0A=
=0A=
blank line here to separate two logical blocks of code.=0A=
=0A=
Slightly helps readability.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &=
val);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 if (!(val & INV_ICM42600_INT_STATUS_RESET_DONE)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "reset error, reset do=
ne bit not set\n");=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set chip bus configuration */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D bus_setup(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* sensor data in big-endian (default) */=0A=
=0A=
> +=A0=A0=A0=A0 mask =3D INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN;=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_C=
ONFIG0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 mask, val);=0A=
=0A=
=0A=
=0A=
Long line, but I'd rather you just didn't bother will local variables=0A=
=0A=
in cases like this where you just set them to a constant.=0A=
=0A=
Take the 80 chars thing as guidance not a rule :)=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return inv_icm42600_set_conf(st, hw->conf);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state=
 *st)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regulator_enable(st->vddio_supply);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* wait a little for supply ramp */=0A=
=0A=
> +=A0=A0=A0=A0 usleep_range(3000, 4000);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static void inv_icm42600_disable_regulators(void *_data)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D _data;=0A=
=0A=
> +=A0=A0=A0=A0 const struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regulator_disable(st->vddio_supply);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "failed to disable vdd=
io error %d\n", ret);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regulator_disable(st->vdd_supply);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "failed to disable vdd=
 error %d\n", ret);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static void inv_icm42600_disable_pm(void *_data)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D _data;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_sync(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_disable(dev);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 inv_icm42600_bus_setup bus_setup)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(regmap);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 BUILD_BUG_ON(ARRAY_SIZE(inv_icm42600_hw) !=3D INV_CHIP_NB);=
=0A=
=0A=
=0A=
=0A=
Why not just give the array an explicit size when you define it above?=0A=
=0A=
I guess it would in theory be possible to not instantiate all of the array=
=0A=
=0A=
but relying on different size of a variable length array seems less than=0A=
=0A=
ideal.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 if (chip < 0 || chip >=3D INV_CHIP_NB) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "invalid chip =3D %d\n=
", chip);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st =3D devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);=0A=
=0A=
> +=A0=A0=A0=A0 if (!st)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
=0A=
nitpick: blank line here.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 dev_set_drvdata(dev, st);=0A=
=0A=
> +=A0=A0=A0=A0 mutex_init(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 st->chip =3D chip;=0A=
=0A=
> +=A0=A0=A0=A0 st->map =3D regmap;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D iio_read_mount_matrix(dev, "mount-matrix", &st->ori=
entation);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "failed to retrieve mo=
unting matrix %d\n", ret);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->vdd_supply =3D devm_regulator_get(dev, "vdd");=0A=
=0A=
> +=A0=A0=A0=A0 if (IS_ERR(st->vdd_supply))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(st->vdd_supply);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->vddio_supply =3D devm_regulator_get(dev, "vddio");=0A=
=0A=
> +=A0=A0=A0=A0 if (IS_ERR(st->vddio_supply))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(st->vddio_supply);=
=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regulator_enable(st->vdd_supply);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 msleep(INV_ICM42600_POWER_UP_TIME_MS);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_enable_regulator_vddio(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator_disable(st->vdd_supply);=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D devm_add_action_or_reset(dev, inv_icm42600_disable_=
regulators,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st);=0A=
=0A=
=0A=
=0A=
I'd prefer to see two devm_add_action_or_reset calls. One for each regulato=
r.=0A=
=0A=
That means you don't have to do the extra disable logic above which is=0A=
=0A=
a bit fragile in amongst a whole load of device managed calls.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* setup chip registers */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_setup(st, bus_setup);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* setup runtime power management */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D pm_runtime_set_active(dev);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_get_noresume(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_enable(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_=
DELAY_MS);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_use_autosuspend(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put(dev);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return devm_add_action_or_reset(dev, inv_icm42600_disable_p=
m, dev);=0A=
=0A=
> +}=0A=
=0A=
> +EXPORT_SYMBOL_GPL(inv_icm42600_core_probe);=0A=
=0A=
> +=0A=
=0A=
> +static int __maybe_unused inv_icm42600_suspend(struct device *dev)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->suspended.gyro =3D st->conf.gyro.mode;=0A=
=0A=
> +=A0=A0=A0=A0 st->suspended.accel =3D st->conf.accel.mode;=0A=
=0A=
> +=A0=A0=A0=A0 st->suspended.temp =3D st->conf.temp_en;=0A=
=0A=
> +=A0=A0=A0=A0 if (pm_runtime_suspended(dev)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_=
MODE_OFF,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_OFF, false=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 regulator_disable(st->vddio_supply);=0A=
=0A=
> +=0A=
=0A=
> +out_unlock:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int __maybe_unused inv_icm42600_resume(struct device *dev)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_enable_regulator_vddio(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_disable(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_set_active(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_enable(dev);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* restore sensors state */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, st->suspended.gyro,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended.accel,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended.temp, NULL);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
=0A=
=0A=
You may need this later, but for now it's a bit comic so ideally introduce=
=0A=
=0A=
it only when needed.=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
> +out_unlock:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int __maybe_unused inv_icm42600_runtime_suspend(struct device *de=
v)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* disable all sensors */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_=
MODE_OFF,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_OFF, false=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_unlock;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 regulator_disable(st->vddio_supply);=0A=
=0A=
> +=0A=
=0A=
> +error_unlock:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int __maybe_unused inv_icm42600_runtime_resume(struct device *dev=
)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
Why don't we need to reenable all the sensors we disabled in runtime suspen=
d?=0A=
=0A=
I can guess why we might not, but a comment here to explain would save on=
=0A=
=0A=
possible confusion..=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_enable_regulator_vddio(st);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +const struct dev_pm_ops inv_icm42600_pm_ops =3D {=0A=
=0A=
> +=A0=A0=A0=A0 SET_SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42600_=
resume)=0A=
=0A=
> +=A0=A0=A0=A0 SET_RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in=
v_icm42600_runtime_resume, NULL)=0A=
=0A=
> +};=0A=
=0A=
> +EXPORT_SYMBOL_GPL(inv_icm42600_pm_ops);=0A=
=0A=
> +=0A=
=0A=
> +MODULE_AUTHOR("InvenSense, Inc.");=0A=
=0A=
> +MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");=0A=
=0A=
> +MODULE_LICENSE("GPL");=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
