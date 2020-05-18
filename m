Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706381D7AEF
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 16:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgEROT0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 10:19:26 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:53618 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgEROTZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 10:19:25 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IEGDdS020188;
        Mon, 18 May 2020 07:19:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=/mvXl6FRgY8Q9gqL7HFNFJCQzHQL2OVGEUS+r5+6ibI=;
 b=PJFI2k1+KllDOzYzWur06LNQvobXKG+I8Gbf78NOhZIJS+Gr19DEL6vSCQlfDXSWHY+4
 XMUv1RcsEvGQl1gQqXC3x+EhStG1dkQ/DhPMm4iKlixc301BKVKt6UFbK0UxVnHaibMU
 /oYx2RfYap69+s6hzepWcZCxSRideSCusUVZ9SpmfwaPmjv0ZFg3aicakjuZdB9m79on
 1bJfWCkGxarLNjpYj7pctzf493FnI/oZBTumlqckMWGGUK1dl5jkPRgP8KKWAOBKxfPs
 tkiQ3vUXP6340r4wakMmuwwe4qSydNHwx19ofu+0rptdv9aCS7DhbMuFjXyc2SALGsr6 nQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00328301.pphosted.com with ESMTP id 313dph89cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 07:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0WWy8CWE9R/O2u4+0m0FjESXcTwPcuq2jzmRvBTo6TVSnFi5GohnD5x9x4YVI72afMmOz55qoAcjMLUdRAL7yA/p1mj4rXBKC8GKygkK73c97GuDlFDFnqvY8OcULWZqV938A3KWMBPgaw+lQy9mTJurGSBoowHsCu5llQ5pW1lnPvUNILaBodUOC6adyJH9ST7Xwtv1MWttC4CIn4Ot7SQ4SNxogJ9oLSKUWN7T5OSWERg6HJwcpGaQuqhPiGlljesbnAADddCEU6RSDGjGcHxsxxxfPQyvthKY3iHj3L9ArlORUkvWP+CXmHVZ6ip7ZKG8dBSqnphNWit5PzIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mvXl6FRgY8Q9gqL7HFNFJCQzHQL2OVGEUS+r5+6ibI=;
 b=l3yR+RB5RhBCbx7apjld4HtaDWpYQ+WIO+2QUv+lIu/0HNojHz1O50f/izzVCaMhpoDGw2TKrJXk/F8F9yBYXHAyy7hc2+CQfPC7bAKdNLedixp3oDp9aIewoJRRnhPENjIO+bGZ6iL5k8s/rwZyGmKVI+zGqvyvHDBeacJIs/MEQpBOZBu9RI0jHP5/jt4lvnZeq1BPzyuc/KApsDbo5FjkT8RS0t6pZulBr7Elje/YTJcCOoBpb1j4RzPW23UsykeG1BXFmyBGDVUYg/oXphGXJafvag4eh7tqMvSWikm1o8xs5EyU6dU3oZIHPel1HD77pBtDsBmTTn90He+VdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mvXl6FRgY8Q9gqL7HFNFJCQzHQL2OVGEUS+r5+6ibI=;
 b=RjUV+d1mLSfTKTzqaZcB8sYX7bQBrr4HnnjHKAMdaCFWlYUdD2NbGktEF/ljWMonkoH7oxKPQjCsIT3DOFzaaGOKX8kC3Rk1iG78VIHxt2KvmmjEs0tv73jxfhz4aSkZnInzOzHggONwQyG2ZvlW7yI+wkSHUqHbk/YuuNJ45eU=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3024.namprd12.prod.outlook.com (2603:10b6:208:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 14:19:12 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%9]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 14:19:12 +0000
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
Subject: Re: [PATCH 02/12] iio: imu: inv_icm42600: add I2C driver for
 inv_icm42600 driver
Thread-Topic: [PATCH 02/12] iio: imu: inv_icm42600: add I2C driver for
 inv_icm42600 driver
Thread-Index: AQHWJH3TU9A+QBaj5keevnu+4z6GAaieNIAAgA/AQeE=
Date:   Mon, 18 May 2020 14:19:11 +0000
Message-ID: <MN2PR12MB44228DAD29335621D4047260C4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-3-jmaneyrol@invensense.com>,<20200508144406.00006b8c@Huawei.com>
In-Reply-To: <20200508144406.00006b8c@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a4144f8-a9ca-4544-d34c-08d7fb366ff1
x-ms-traffictypediagnostic: MN2PR12MB3024:
x-microsoft-antispam-prvs: <MN2PR12MB30243D9F1C4998CFC6C399D9C4B80@MN2PR12MB3024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siacFDI+toxRDwOrt3Wyh0yblU28x2OXHq1uXG26bEJcrjhwFcduD8IyrpjWnGBjByArvaLRiABKttxOZNB+eg8Z8kvVC+ENTcVsgK3kDhGz8GaH5ZrAOTaw0O02a451d0yY/5HxFZbGEZ2zNh0kRKGfmGOj2GU1y7S+dEnnPhupamTH7Y7MyH/FZ00MzNsAPYdBn5oHrLp74yVU5Lj47lYC0tMs9v9aR/xV4bM6KOuEKTThfR+f8seFfBDP3ULxn08y9yNmSMpIqNuF2j6p46KpD9eZ3Wy8C7bNisXJmqlhu4z1hNLIn0+Hu58YdP7pbWKqOR+cg9aQaGDbAqXslpye2hXSetZjUAKus4mPFj77oZUrdEL42rAOQJeI7DIkD7Nx962KdQ+xiUFR+oCT5UsVG9nNV2fz077FyX1reT4CLUR0K5Oi9rWKoAQ/ly9v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(39850400004)(136003)(346002)(366004)(71200400001)(55016002)(478600001)(6916009)(26005)(7416002)(186003)(7696005)(53546011)(5660300002)(86362001)(2906002)(6506007)(4326008)(66446008)(33656002)(64756008)(66476007)(52536014)(76116006)(66946007)(8936002)(54906003)(8676002)(316002)(9686003)(91956017)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4BoPDW0J9sTvq7eYcVGxebyuRcBEPiAHwkNgrmup3s9L1mT5h0jlqifoM1eRnpqOV4cVRGGVQafXrH0evKfP5gzVQT8q86JIQqUJPyY+JsXxrSgwqRuevPD5SEvz15G2SivHH4VCCt9qOwCuMwBBqiUaMGoaML01siSrCeGkYpjeS5UXnvRzYcjB/sTEt5iQXMii8oustBENsNyr6IXnRkDAMuhoGTJJo+bT/HOoHkiBF0V7FKkY4S+ithwJ8vzW75LMjRUrnBKeITocwtYUcqmY5BZENz35N6CN5AieQak+1BZRFzZLgkftpkhD7aPr9dRi9lbJcgIXdVRb0ZAySIwiU5rrnCkW8gZoAWIvS5Hct/b4Tt6sTwIhto5VlNDVeRzQkeJuPsXvkIFRg0mHcT9cmkUc7OIm/FWAT4bwnzPaxYeqjAV8kM1nr4NcGguO71s2EvDuxzXsRAbUvJ36ce/5nNnw18lcwOCjrbzu92s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4144f8-a9ca-4544-d34c-08d7fb366ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 14:19:11.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4jLTi4HTeVDQERg5miEmnS3vK77cNk+75uLR0Lt7obKXvxZ93BJ5wEpsFHfDqgH4c8o0wSFCCUHyrV6kC36eYDlzbsqZa5S2s/fkNOwLFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 cotscore=-2147483648 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
I am using generic device_get_match_data because I was thinking it was now =
the way to go. But since only of is supported with the driver, I can switch=
 to using of_device_get_match_data instead.=0A=
=0A=
Tell me what do you think is better.=0A=
=0A=
I could definitely use the new probe interface indeed, good idea.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
=0A=
Sent: Friday, May 8, 2020 15:44=0A=
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
Subject: Re: [PATCH 02/12] iio: imu: inv_icm42600: add I2C driver for inv_i=
cm42600 driver=0A=
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
On Thu, 7 May 2020 16:42:12 +0200=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Add I2C driver for InvenSense ICM-426xxx devices.=0A=
=0A=
> =0A=
=0A=
> Configure bus signal slew rates as indicated in the datasheet.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Some incoherent rambling inline. + a few comments=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c=A0=A0 | 117 ++++++++++++++=
++++=0A=
=0A=
>=A0 1 file changed, 117 insertions(+)=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..b61f993beacf=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
=0A=
> @@ -0,0 +1,117 @@=0A=
=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
=0A=
> +/*=0A=
=0A=
> + * Copyright (C) 2020 InvenSense, Inc.=0A=
=0A=
> + */=0A=
=0A=
> +=0A=
=0A=
> +#include <linux/device.h>=0A=
=0A=
> +#include <linux/module.h>=0A=
=0A=
> +#include <linux/i2c.h>=0A=
=0A=
> +#include <linux/regmap.h>=0A=
=0A=
> +#include <linux/of_device.h>=0A=
=0A=
=0A=
=0A=
Why?=A0 Looks like you need the table and the device property stuff neither=
=0A=
=0A=
of which are in that file.=0A=
=0A=
=0A=
=0A=
linux/mod_devicetable.h=0A=
=0A=
linux/property.h=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
> +#include "inv_icm42600.h"=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int mask, val;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* setup interface registers */=0A=
=0A=
> +=A0=A0=A0=A0 mask =3D INV_ICM42600_INTF_CONFIG6_MASK;=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_INTF_CONFIG6_I3C_EN;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_C=
ONFIG6,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 mask, val);=0A=
=0A=
=0A=
=0A=
I'd put the values inline where they are simple like these rather than=0A=
=0A=
using local variables.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mask =3D INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY;=0A=
=0A=
> +=A0=A0=A0=A0 val =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_C=
ONFIG4,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 mask, val);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* set slew rates for I2C and SPI */=0A=
=0A=
> +=A0=A0=A0=A0 mask =3D INV_ICM42600_DRIVE_CONFIG_I2C_MASK |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_DRIVE_CONFIG_SPI_MASK;=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_DRIVE_CONFIG_I2C(INV_ICM42600_SLEW_RAT=
E_12_36NS) |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_DRIVE_CONFIG_SPI(INV_ICM4260=
0_SLEW_RATE_12_36NS);=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_DRIVE_=
CONFIG,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 mask, val);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* disable SPI bus */=0A=
=0A=
> +=A0=A0=A0=A0 mask =3D INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK;=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS;=0A=
=0A=
> +=A0=A0=A0=A0 return regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CO=
NFIG0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 mask, val);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_probe(struct i2c_client *client,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 const struct i2c_device_id *id)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 const void *match;=0A=
=0A=
> +=A0=A0=A0=A0 enum inv_icm42600_chip chip;=0A=
=0A=
> +=A0=A0=A0=A0 struct regmap *regmap;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBU=
S_I2C_BLOCK))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOTSUPP;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 match =3D device_get_match_data(&client->dev);=0A=
=0A=
=0A=
=0A=
Hmm. Annoyingly if one were to call the of specific option=0A=
=0A=
of i2c_of_match_device it would handle the old style i2c match just fine wi=
thout=0A=
=0A=
needing special handling.=A0 However, it would fail to handle PRP0001 ACPI.=
=0A=
=0A=
=0A=
=0A=
Rather feels like there should be something similar for=0A=
=0A=
device_get_match_data so we could use the probe_new version of i2c device=
=0A=
=0A=
probing.=0A=
=0A=
=0A=
=0A=
Oh well. I guess thats a separate question for another day ;)=0A=
=0A=
=0A=
=0A=
Mind you can we actually probe this driver via the sysfs route?=0A=
=0A=
If not why do we need to handle the non firmware case at all?=0A=
=0A=
=A0=0A=
=0A=
> +=A0=A0=A0=A0 if (match)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip =3D (enum inv_icm42600_chip)ma=
tch;=0A=
=0A=
> +=A0=A0=A0=A0 else if (id)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip =3D (enum inv_icm42600_chip)id=
->driver_data;=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 regmap =3D devm_regmap_init_i2c(client, &inv_icm42600_regma=
p_config);=0A=
=0A=
> +=A0=A0=A0=A0 if (IS_ERR(regmap))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(regmap);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return inv_icm42600_core_probe(regmap, chip,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_i2c_bus_setup);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static const struct of_device_id inv_icm42600_of_matches[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm4260=
0",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_CHIP_ICM42600=
,=0A=
=0A=
> +=A0=A0=A0=A0 }, {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm4260=
2",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_CHIP_ICM42602=
,=0A=
=0A=
> +=A0=A0=A0=A0 }, {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm4260=
5",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_CHIP_ICM42605=
,=0A=
=0A=
> +=A0=A0=A0=A0 }, {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm4262=
2",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_CHIP_ICM42622=
,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +=A0=A0=A0=A0 {}=0A=
=0A=
> +};=0A=
=0A=
> +MODULE_DEVICE_TABLE(of, inv_icm42600_of_matches);=0A=
=0A=
> +=0A=
=0A=
> +static const struct i2c_device_id inv_icm42600_ids[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 {"icm42600", INV_CHIP_ICM42600},=0A=
=0A=
> +=A0=A0=A0=A0 {"icm42602", INV_CHIP_ICM42602},=0A=
=0A=
> +=A0=A0=A0=A0 {"icm42605", INV_CHIP_ICM42605},=0A=
=0A=
> +=A0=A0=A0=A0 {"icm42622", INV_CHIP_ICM42622},=0A=
=0A=
> +=A0=A0=A0=A0 {}=0A=
=0A=
> +};=0A=
=0A=
> +MODULE_DEVICE_TABLE(i2c, inv_icm42600_ids);=0A=
=0A=
> +=0A=
=0A=
> +static struct i2c_driver inv_icm42600_driver =3D {=0A=
=0A=
> +=A0=A0=A0=A0 .probe =3D inv_icm42600_probe,=0A=
=0A=
> +=A0=A0=A0=A0 .id_table =3D inv_icm42600_ids,=0A=
=0A=
> +=A0=A0=A0=A0 .driver =3D {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .of_match_table =3D inv_icm42600_of=
_matches,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "inv-icm42600-i2c",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .pm =3D &inv_icm42600_pm_ops,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +};=0A=
=0A=
> +module_i2c_driver(inv_icm42600_driver);=0A=
=0A=
> +=0A=
=0A=
> +MODULE_AUTHOR("InvenSense, Inc.");=0A=
=0A=
> +MODULE_DESCRIPTION("InvenSense ICM-426xx I2C driver");=0A=
=0A=
> +MODULE_LICENSE("GPL");=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
