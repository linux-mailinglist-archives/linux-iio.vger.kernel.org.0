Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD001EB80F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgFBJKi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 05:10:38 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:25240 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbgFBJKi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 05:10:38 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0529AXH8027644;
        Tue, 2 Jun 2020 02:10:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=xgdKrfdfLfPCf05PM32G8nOT/TvgN7HuarIPp9v/7QU=;
 b=qUa5R+spuLZScCm0MFbdfbVu0nM+CBTK0A2vBTI6VUgvksufQ3YHIjO1XNmQzmy+avco
 8tDwjEsgcseeFAnf4CL2BanqjBcFz1yJdARWAG45JcsPonE9xusXcF+7nI4O+sStn1RQ
 f7ug4Kl5oyc5cBUY4xkgF3eZvNBKfhknC+o13hDuyJUZgZxoo0CB0IPGKrrenYXP+8RY
 gFaJZWxPMcCcwNMWVkTJ7vEvXn6QOC90EAHlDBsrRejtkOQCLS4wwFGRTUm1GLfDuu1b
 ENDYr1Za+oY6LlM4IHbKQelLd1AAw6NsXyp+PvQZ8ytLuiae4MAroaqSd02+OhI0e+1d FA== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-00328301.pphosted.com with ESMTP id 31c6bv8waw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 02:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmbK9Gzj+smrBgO6H0Q1YRxMa16KXxatFsUTgffhfWWC5TqhlE3PT0b166+jN2+lCIks3wG48VU8ktzcuJ7MnlwggwCWmfisIvd41yNKJJQ5hXtbMhzFmJ3aQAdgMvTBrlJQpdh6Er5RhBG9APXoQ4MKba0xBg+owD87yKEZ0c+biP3H3hFrfEe1RzZKBySuwbVG1Ik1aMocpZIb7dgniTOkFYxxlgwlW5keitKkGx1JpMTSH06dk9GzovKF/dvWLURf9uLa0MTUCjBvdyEDIxFc548YCQJsH8XxJuoBjX96EXxFub+9mdwVilY8dArwWZji/wMjc3MN7O0QnK/gNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgdKrfdfLfPCf05PM32G8nOT/TvgN7HuarIPp9v/7QU=;
 b=cJwmcsQPeCJWosA4iDZxZaIUy6viXMEhPRlHW6qXqWCOVJcRbSmTSepjL1upDLuB3pAOzj1FqKzerw9AqJ0tGq9nUi5uJ9LIMjB+Tf8h8wjT82Mi+9ede4i+J6pcKieaS7+so9msxWuY2mPw9fxGJpVlri/SUwkWSGSTZ2pwyC1Yyk4RoY0sF0UA4LmkNg00fqkCHcqbQOLx3NKG9Pcdp1V+Hoyb8OmUeMAA6kMka7Bbyc0oOhVIDSnb9vekFUXL05hEygmxHTgRh0RnaHmyxcaWu0bQh1kWKT3yJyuoRVFXuHoPILOqC8Bx/Z6tYPxtHxodsP5pspKVDxHZzciPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgdKrfdfLfPCf05PM32G8nOT/TvgN7HuarIPp9v/7QU=;
 b=NXbZybnkimgluNZoJkSqJa30ubtfeKf73/HCea0y2IIUv29CyvZ7PGR73h2rwUAF7B+K7AOfAoxq0jjR1ueuk7XRRpyZliRirSorPZiva3m1QXx1A4cTltGrCjeAJXXW/KxMyWZjAqdLHNsdMf1rKwKPvW/fOZ6q6OwWtk9Jri8=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3709.namprd12.prod.outlook.com (2603:10b6:208:167::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 09:10:30 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.018; Tue, 2 Jun 2020
 09:10:30 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/12] iio: imu: inv_icm42600: add gyroscope IIO device
Thread-Topic: [PATCH v2 04/12] iio: imu: inv_icm42600: add gyroscope IIO
 device
Thread-Index: AQHWNFi1nNopWtCeJECvGSJUgkDfAqjCG7iAgALuYZA=
Date:   Tue, 2 Jun 2020 09:10:29 +0000
Message-ID: <MN2PR12MB4422A323E043F4786E12E18FC48B0@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-5-jmaneyrol@invensense.com>,<20200531125415.6904a94d@archlinux>
In-Reply-To: <20200531125415.6904a94d@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27305413-7ff0-4c0e-f6c0-08d806d4cc1e
x-ms-traffictypediagnostic: MN2PR12MB3709:
x-microsoft-antispam-prvs: <MN2PR12MB3709351DBDB77031D738E788C48B0@MN2PR12MB3709.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sq2JqiAJhRQJaV88fiq6Tupcsm0AFpmFKvMNeojmHKebZp6K6LdvXOWjpVRjO56VXaiyF8BGmHV3F5bk00EH/hIcdxXXuTsH7kbJUDDKlPTT73fXfg43I0+zXqsNeNqNem3yJ6/jURSZehfiYwgPbeiGoiIEa/E+4Pg4WgSMk1PnX9XW6bQwBI3lCzFajYjzeb/0YTWq/NS1EM18ncT9yof6fNji7WhIUl+8ZPC2m68UykRkqjJeoqKkvmfq5wkTL3IdGbswJrIjYA3AIhKB1UFWFpZCC7kCPg3QWBRWOC+rwcJkZvXgPFB8wTcjEN3z99gOLKKxNZxxwEKhclhXRmfya5HlvpJf5RYLMw8NVjbn3fZWDnpk9MPbfbTz9u7h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(346002)(136003)(39850400004)(66946007)(86362001)(8936002)(53546011)(7696005)(91956017)(76116006)(52536014)(33656002)(30864003)(478600001)(66446008)(6506007)(66556008)(66476007)(64756008)(186003)(2906002)(83380400001)(9686003)(5660300002)(71200400001)(8676002)(4326008)(26005)(55016002)(6916009)(54906003)(316002)(3714002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: N+xwdgjhZlRaalWX3w2Agt6isHWVoWbsjmmnhIItnfVSXfOcP4NfBTV+9Az1gGuilBE3tKT9FzkUzeDb4zW2xle7J4D6KE2iyW5gZm4uTZuKgfw4DRZiSMfTSKr2I66vNczv5W5I/nK1FBFLiZpfiE6cUkCfJCRgoz4bdalDN7c3KggvIh2Im7Y5X5Kopj6sqaiMd8cMfFUWDomi9FdM79efMq8xsv5/bLNu0GDoVLNMPT9T8pUWW/Wtz3HVbEIAfovwcybYkI7cJDPZu9I+xfNSObhnJK+ZCSHvazwtA0JW7SN61WSonWLzOaVEoGnqx3ETe759VJ9WFEDCreFi8EiudyLGlnaL16/+cTJKrVB3OXkQDQDPzegmeTWPhgc/h/Vlkec9mwQRgD5DyWG8xzFZGyNCU/Bz4e4bmiKYtgp07vZlMtfRyF/l7QZI5pP358qKt9nvDIwgQJmXWB+uEDc04N/ne9bGw0qE9/sMacA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27305413-7ff0-4c0e-f6c0-08d806d4cc1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 09:10:29.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nkl1C14AFJuHR73I+yGNqWpybSpp3aX8D3/drlXZfjJedyb+If8Cl6Sr4NrvwUjbWGR1Azqo/i5s064nKk3APdGQObLp4gU0xaOzWk/fNc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3709
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_11:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0
 cotscore=-2147483648 suspectscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020061
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
for the calibration bias, value is expressed in g unit, fixed, independant =
from any scale value.=0A=
So I can switch to g instead of SI unit, but this will still not be like ra=
w data which are dependent of the scale value. That's why I used SI units.=
=0A=
=0A=
Another solution, would be to adapt the value depending on the scale settin=
g. So that it will correspond to raw data. But this also invovles complex c=
omputation.=0A=
=0A=
Tell me what you prefer.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, May 31, 2020 13:54=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Cc: robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org <robh@kernel.o=
rg>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; davem@davemloft=
.net <davem@davemloft.net>; gregkh@linuxfoundation.org <gregkh@linuxfoundat=
ion.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree=
@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>=0A=
Subject: Re: [PATCH v2 04/12] iio: imu: inv_icm42600: add gyroscope IIO dev=
ice =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Wed, 27 May 2020 20:57:03 +0200=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
> Add IIO device for gyroscope sensor with data polling interface.=0A=
> Attributes: raw, scale, sampling_frequency, calibbias.=0A=
> =0A=
> Gyroscope in low noise mode.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Unusual to have a calibration offset specified in output units,=0A=
which contributes a lot of the complexity in here.=0A=
Normally those are strictly front end (output of some calibration DAC).=0A=
So if they have units (and often they don't) I'd expect them to be=0A=
the same as _raw.=0A=
=0A=
We need to tidy up the docs on this though as it doesn't express=0A=
any sort of preference.=A0 It's hard to be specific as often the calibratio=
n=0A=
scales are defined - they are just like tweaking a POT on an analog=0A=
sensor board.=0A=
=0A=
A few trivial other things inline, including a suggestion to modify=0A=
the layering of the driver a tiny bit during probe.=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
> ---=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0 |=A0=A0 6 +=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 |=A0=A0 4 +=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c=A0 | 600 ++++++++++++++++=
++=0A=
>=A0 3 files changed, 610 insertions(+)=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h=0A=
> index 14c8ef152418..c1023d59b37b 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> @@ -120,6 +120,8 @@ struct inv_icm42600_suspended {=0A=
>=A0=A0 *=A0 @orientation:=A0=A0=A0 sensor chip orientation relative to mai=
n hardware.=0A=
>=A0=A0 *=A0 @conf:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip sensors configuratio=
ns.=0A=
>=A0=A0 *=A0 @suspended:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 suspended s=
ensors configuration.=0A=
> + *=A0 @indio_gyro:=A0=A0=A0=A0 gyroscope IIO device.=0A=
> + *=A0 @buffer:=A0=A0=A0=A0=A0=A0=A0=A0 data transfer buffer aligned for =
DMA.=0A=
>=A0=A0 */=0A=
>=A0 struct inv_icm42600_state {=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
> @@ -131,6 +133,8 @@ struct inv_icm42600_state {=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix orientation;=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_conf conf;=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_suspended suspended;=0A=
> +=A0=A0=A0=A0 struct iio_dev *indio_gyro;=0A=
> +=A0=A0=A0=A0 uint8_t buffer[2] ____cacheline_aligned;=0A=
>=A0 };=0A=
>=A0 =0A=
>=A0 /* Virtual register addresses: @bank on MSB (4 upper bits), @address o=
n LSB */=0A=
> @@ -369,4 +373,6 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_de=
v, unsigned int reg,=0A=
>=A0 int inv_icm42600_core_probe(struct regmap *regmap, int chip,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_bus_setup bus_setup);=0A=
>=A0 =0A=
> +int inv_icm42600_gyro_init(struct inv_icm42600_state *st);=0A=
> +=0A=
>=A0 #endif=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
> index 81b171d6782c..dccb7bcc782e 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> @@ -510,6 +510,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, i=
nt chip,=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_init(st);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* setup runtime power management */=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D pm_runtime_set_active(dev);=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
> new file mode 100644=0A=
> index 000000000000..9d9672989b23=0A=
> --- /dev/null=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
> @@ -0,0 +1,600 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
> +/*=0A=
> + * Copyright (C) 2020 Invensense, Inc.=0A=
> + */=0A=
> +=0A=
> +#include <linux/kernel.h>=0A=
> +#include <linux/device.h>=0A=
> +#include <linux/mutex.h>=0A=
> +#include <linux/pm_runtime.h>=0A=
> +#include <linux/regmap.h>=0A=
> +#include <linux/delay.h>=0A=
> +#include <linux/math64.h>=0A=
> +#include <linux/iio/iio.h>=0A=
> +=0A=
> +#include "inv_icm42600.h"=0A=
> +=0A=
> +#define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=A0=
=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_ANGL_VEL,=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .modified =3D 1,=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .channel2 =3D _modifier,=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_RAW) |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_CALIBBIAS),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_shared_by_type =3D=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_SCALE),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_shared_by_type_available=
 =3D=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_SCALE) |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_CALIBBIAS),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_shared_by_all =3D=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_SAMP_FREQ),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_shared_by_all_available =
=3D=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_SAMP_FREQ),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D _index,=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_type =3D {=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .sign =3D '=
s',=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .realbits =
=3D 16,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .storagebit=
s =3D 16,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .endianness=
 =3D IIO_BE,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .ext_info =3D _ext_info,=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +enum inv_icm42600_gyro_scan {=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_X,=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_Y,=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_Z,=0A=
> +};=0A=
> +=0A=
> +static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[]=
 =3D {=0A=
> +=A0=A0=A0=A0 IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_=
matrix),=0A=
> +=A0=A0=A0=A0 {},=0A=
> +};=0A=
> +=0A=
> +static const struct iio_chan_spec inv_icm42600_gyro_channels[] =3D {=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_X, INV_ICM42600_GYRO_SCAN_X,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_gyro_ext_infos),=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_Y, INV_ICM42600_GYRO_SCAN_Y,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_gyro_ext_infos),=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_gyro_ext_infos),=0A=
> +};=0A=
> +=0A=
> +static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int16_t *val)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
> +=A0=A0=A0=A0 unsigned int reg;=0A=
> +=A0=A0=A0=A0 __be16 *data;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_GYRO_DATA_=
X;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_GYRO_DATA_=
Y;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_GYRO_DATA_=
Z;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 /* enable gyro sensor */=0A=
> +=A0=A0=A0=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_LOW_NOISE;=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, NULL);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto exit;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* read gyro register data */=0A=
> +=A0=A0=A0=A0 data =3D (__be16 *)&st->buffer[0];=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->map, reg, data, sizeof(*data))=
;=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto exit;=0A=
> +=0A=
> +=A0=A0=A0=A0 *val =3D (int16_t)be16_to_cpup(data);=0A=
> +=A0=A0=A0=A0 if (*val =3D=3D INV_ICM42600_DATA_INVALID)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;=0A=
> +exit:=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +/* IIO format int + nano */=0A=
> +static const int inv_icm42600_gyro_scale[] =3D {=0A=
> +=A0=A0=A0=A0 /* +/- 2000dps =3D> 0.001065264 rad/s */=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_2000DPS] =3D 0,=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_2000DPS + 1] =3D 1065264,=0A=
> +=A0=A0=A0=A0 /* +/- 1000dps =3D> 0.000532632 rad/s */=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_1000DPS] =3D 0,=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_1000DPS + 1] =3D 532632,=0A=
> +=A0=A0=A0=A0 /* +/- 500dps =3D> 0.000266316 rad/s */=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_500DPS] =3D 0,=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_500DPS + 1] =3D 266316,=0A=
> +=A0=A0=A0=A0 /* +/- 250dps =3D> 0.000133158 rad/s */=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_250DPS] =3D 0,=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_250DPS + 1] =3D 133158,=0A=
> +=A0=A0=A0=A0 /* +/- 125dps =3D> 0.000066579 rad/s */=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_125DPS] =3D 0,=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_125DPS + 1] =3D 66579,=0A=
> +=A0=A0=A0=A0 /* +/- 62.5dps =3D> 0.000033290 rad/s */=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_62_5DPS] =3D 0,=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_62_5DPS + 1] =3D 33290,=0A=
> +=A0=A0=A0=A0 /* +/- 31.25dps =3D> 0.000016645 rad/s */=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_31_25DPS] =3D 0,=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_31_25DPS + 1] =3D 16645,=0A=
> +=A0=A0=A0=A0 /* +/- 15.625dps =3D> 0.000008322 rad/s */=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_15_625DPS] =3D 0,=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_15_625DPS + 1] =3D 8322,=0A=
> +};=0A=
> +=0A=
> +static int inv_icm42600_gyro_read_scale(struct inv_icm42600_state *st,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2)=0A=
> +{=0A=
> +=A0=A0=A0=A0 unsigned int idx;=0A=
> +=0A=
> +=A0=A0=A0=A0 idx =3D st->conf.gyro.fs;=0A=
> +=0A=
> +=A0=A0=A0=A0 *val =3D inv_icm42600_gyro_scale[2 * idx];=0A=
> +=A0=A0=A0=A0 *val2 =3D inv_icm42600_gyro_scale[2 * idx + 1];=0A=
> +=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_NANO;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_gyro_write_scale(struct inv_icm42600_state *st,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val, int val2)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
> +=A0=A0=A0=A0 unsigned int idx;=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 for (idx =3D 0; idx < ARRAY_SIZE(inv_icm42600_gyro_scale); =
idx +=3D 2) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (val =3D=3D inv_icm42600_gyro_sc=
ale[idx] &&=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val2 =3D=3D inv_icm4260=
0_gyro_scale[idx + 1])=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0 if (idx >=3D ARRAY_SIZE(inv_icm42600_gyro_scale))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 conf.fs =3D idx / 2;=0A=
> +=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, NULL);=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
> +=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +/* IIO format int + micro */=0A=
> +static const int inv_icm42600_gyro_odr[] =3D {=0A=
> +=A0=A0=A0=A0 /* 12.5Hz */=0A=
> +=A0=A0=A0=A0 12, 500000,=0A=
> +=A0=A0=A0=A0 /* 25Hz */=0A=
> +=A0=A0=A0=A0 25, 0,=0A=
> +=A0=A0=A0=A0 /* 50Hz */=0A=
> +=A0=A0=A0=A0 50, 0,=0A=
> +=A0=A0=A0=A0 /* 100Hz */=0A=
> +=A0=A0=A0=A0 100, 0,=0A=
> +=A0=A0=A0=A0 /* 200Hz */=0A=
> +=A0=A0=A0=A0 200, 0,=0A=
> +=A0=A0=A0=A0 /* 1kHz */=0A=
> +=A0=A0=A0=A0 1000, 0,=0A=
> +=A0=A0=A0=A0 /* 2kHz */=0A=
> +=A0=A0=A0=A0 2000, 0,=0A=
> +=A0=A0=A0=A0 /* 4kHz */=0A=
> +=A0=A0=A0=A0 4000, 0,=0A=
> +};=0A=
> +=0A=
> +static const int inv_icm42600_gyro_odr_conv[] =3D {=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_12_5HZ,=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_25HZ,=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_50HZ,=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_100HZ,=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_200HZ,=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_1KHZ_LN,=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_2KHZ_LN,=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_4KHZ_LN,=0A=
> +};=0A=
> +=0A=
> +static int inv_icm42600_gyro_read_odr(struct inv_icm42600_state *st,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2)=0A=
> +{=0A=
> +=A0=A0=A0=A0 unsigned int odr;=0A=
> +=A0=A0=A0=A0 unsigned int i;=0A=
> +=0A=
> +=A0=A0=A0=A0 odr =3D st->conf.gyro.odr;=0A=
> +=0A=
> +=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(inv_icm42600_gyro_odr_conv); +=
+i) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (inv_icm42600_gyro_odr_conv[i] =
=3D=3D odr)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0 if (i >=3D ARRAY_SIZE(inv_icm42600_gyro_odr_conv))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 *val =3D inv_icm42600_gyro_odr[2 * i];=0A=
> +=A0=A0=A0=A0 *val2 =3D inv_icm42600_gyro_odr[2 * i + 1];=0A=
> +=0A=
> +=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_MICRO;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val, int val2)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
> +=A0=A0=A0=A0 unsigned int idx;=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 for (idx =3D 0; idx < ARRAY_SIZE(inv_icm42600_gyro_odr); id=
x +=3D 2) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (val =3D=3D inv_icm42600_gyro_od=
r[idx] &&=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val2 =3D=3D inv_icm4260=
0_gyro_odr[idx + 1])=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0 if (idx >=3D ARRAY_SIZE(inv_icm42600_gyro_odr))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 conf.odr =3D inv_icm42600_gyro_odr_conv[idx / 2];=0A=
> +=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, NULL);=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
> +=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * Calibration bias values, IIO range format int + nano.=0A=
> + * Value is limited to +/-64dps coded on 12 bits signed. Step is 1/32 dp=
s.=0A=
> + */=0A=
> +static int inv_icm42600_gyro_calibbias[] =3D {=0A=
> +=A0=A0=A0=A0 -1, 117010721,=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* min: -1.117010=
721 rad/s */=0A=
> +=A0=A0=A0=A0 0, 545415,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* step: =
0.000545415 rad/s */=0A=
> +=A0=A0=A0=A0 1, 116465306,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* max: 1.11646=
5306 rad/s */=0A=
> +};=0A=
> +=0A=
> +static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
> +=A0=A0=A0=A0 int64_t val64;=0A=
> +=A0=A0=A0=A0 int32_t bias;=0A=
> +=A0=A0=A0=A0 unsigned int reg;=0A=
> +=A0=A0=A0=A0 int16_t offset;=0A=
> +=A0=A0=A0=A0 uint8_t data[2];=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R0;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R1;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R3;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->map, reg, st->buffer, sizeof(d=
ata));=0A=
> +=A0=A0=A0=A0 memcpy(data, st->buffer, sizeof(data));=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* 12 bits signed value */=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset =3D sign_extend32(((data[1] =
& 0x0F) << 8) | data[0], 11);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset =3D sign_extend32(((data[0] =
& 0xF0) << 4) | data[1], 11);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset =3D sign_extend32(((data[1] =
& 0x0F) << 8) | data[0], 11);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /*=0A=
> +=A0=A0=A0=A0=A0 * convert raw offset to dps then to rad/s=0A=
> +=A0=A0=A0=A0=A0 * 12 bits signed raw max 64 to dps: 64 / 2048=0A=
> +=A0=A0=A0=A0=A0 * dps to rad: Pi / 180=0A=
> +=A0=A0=A0=A0=A0 * result in nano (1000000000)=0A=
> +=A0=A0=A0=A0=A0 * (offset * 64 * Pi * 1000000000) / (2048 * 180)=0A=
> +=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0 val64 =3D (int64_t)offset * 64LL * 3141592653LL;=0A=
> +=A0=A0=A0=A0 /* for rounding, add + or - divisor (2048 * 180) divided by=
 2 */=0A=
> +=A0=A0=A0=A0 if (val64 >=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val64 +=3D 2048 * 180 / 2;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val64 -=3D 2048 * 180 / 2;=0A=
> +=A0=A0=A0=A0 bias =3D div_s64(val64, 2048 * 180);=0A=
> +=A0=A0=A0=A0 *val =3D bias / 1000000000L;=0A=
> +=A0=A0=A0=A0 *val2 =3D bias % 1000000000L;=0A=
> +=0A=
> +=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_NANO;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan=
,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val, int val2)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
> +=A0=A0=A0=A0 int64_t val64, min, max;=0A=
> +=A0=A0=A0=A0 unsigned int reg, regval;=0A=
> +=A0=A0=A0=A0 int16_t offset;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R0;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R1;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R3;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /* inv_icm42600_gyro_calibbias: min - step - max in nano */=
=0A=
> +=A0=A0=A0=A0 min =3D (int64_t)inv_icm42600_gyro_calibbias[0] * 100000000=
0LL +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (int64_t)inv_icm42600_gyro_calibbias[1];=
=0A=
> +=A0=A0=A0=A0 max =3D (int64_t)inv_icm42600_gyro_calibbias[4] * 100000000=
0LL +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (int64_t)inv_icm42600_gyro_calibbias[5];=
=0A=
> +=A0=A0=A0=A0 val64 =3D (int64_t)val * 1000000000LL + (int64_t)val2;=0A=
> +=A0=A0=A0=A0 if (val64 < min || val64 > max)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 /*=0A=
> +=A0=A0=A0=A0=A0 * convert rad/s to dps then to raw value=0A=
> +=A0=A0=A0=A0=A0 * rad to dps: 180 / Pi=0A=
> +=A0=A0=A0=A0=A0 * dps to raw 12 bits signed, max 64: 2048 / 64=0A=
> +=A0=A0=A0=A0=A0 * val in nano (1000000000)=0A=
> +=A0=A0=A0=A0=A0 * val * 180 * 2048 / (Pi * 1000000000 * 64)=0A=
> +=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0 val64 =3D val64 * 180LL * 2048LL;=0A=
> +=A0=A0=A0=A0 /* for rounding, add + or - divisor (3141592653 * 64) divid=
ed by 2 */=0A=
> +=A0=A0=A0=A0 if (val64 >=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val64 +=3D 3141592653LL * 64LL / 2L=
L;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val64 -=3D 3141592653LL * 64LL / 2L=
L;=0A=
> +=A0=A0=A0=A0 offset =3D div64_s64(val64, 3141592653LL * 64LL);=0A=
> +=0A=
> +=A0=A0=A0=A0 /* clamp value limited to 12 bits signed */=0A=
> +=A0=A0=A0=A0 if (offset < -2048)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset =3D -2048;=0A=
> +=A0=A0=A0=A0 else if (offset > 2047)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset =3D 2047;=0A=
> +=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* OFFSET_USER1 register is shared =
*/=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_IC=
M42600_REG_OFFSET_USER1,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &regval);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->buffer[0] =3D offset & 0xFF;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->buffer[1] =3D (regval & 0xF0) |=
 ((offset & 0xF00) >> 8);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* OFFSET_USER1 register is shared =
*/=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_IC=
M42600_REG_OFFSET_USER1,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &regval);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->buffer[0] =3D ((offset & 0xF00)=
 >> 4) | (regval & 0x0F);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->buffer[1] =3D offset & 0xFF;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* OFFSET_USER4 register is shared =
*/=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_IC=
M42600_REG_OFFSET_USER4,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &regval);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->buffer[0] =3D offset & 0xFF;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->buffer[1] =3D (regval & 0xF0) |=
 ((offset & 0xF00) >> 8);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_write(st->map, reg, st->buffer, 2);=0A=
> +=0A=
> +out_unlock:=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2, long mask)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 int16_t data;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 switch (mask) {=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_RAW:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_mod=
e(indio_dev);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_read_sens=
or(st, chan, &data);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indi=
o_dev);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D data;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_gyro_read_scale=
(st, val, val2);=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SAMP_FREQ:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_gyro_read_odr(s=
t, val, val2);=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_CALIBBIAS:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_gyro_read_offse=
t(st, chan, val, val2);=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_gyro_read_avail(struct iio_dev *indio_dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const int **vals,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *type, int *length, long mask)=0A=
> +{=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 switch (mask) {=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *vals =3D inv_icm42600_gyro_scale;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *type =3D IIO_VAL_INT_PLUS_NANO;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *length =3D ARRAY_SIZE(inv_icm42600=
_gyro_scale);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_AVAIL_LIST;=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SAMP_FREQ:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *vals =3D inv_icm42600_gyro_odr;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *type =3D IIO_VAL_INT_PLUS_MICRO;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *length =3D ARRAY_SIZE(inv_icm42600=
_gyro_odr);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_AVAIL_LIST;=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_CALIBBIAS:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *vals =3D inv_icm42600_gyro_calibbi=
as;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *type =3D IIO_VAL_INT_PLUS_NANO;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_AVAIL_RANGE;=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val, int val2, long mask)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 switch (mask) {=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_mod=
e(indio_dev);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_write_sca=
le(st, val, val2);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indi=
o_dev);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SAMP_FREQ:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_gyro_write_odr(=
st, val, val2);=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_CALIBBIAS:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_mod=
e(indio_dev);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_write_off=
set(st, chan, val, val2);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indi=
o_dev);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_gyro_write_raw_get_fmt(struct iio_dev *indio_dev=
,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_s=
pec const *chan,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 long mask)=0A=
> +{=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
> +=A0=A0=A0=A0 switch (mask) {=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_NANO;=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SAMP_FREQ:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_MICRO;=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_CALIBBIAS:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_NANO;=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +}=0A=
> +=0A=
> +static const struct iio_info inv_icm42600_gyro_info =3D {=0A=
> +=A0=A0=A0=A0 .read_raw =3D inv_icm42600_gyro_read_raw,=0A=
> +=A0=A0=A0=A0 .read_avail =3D inv_icm42600_gyro_read_avail,=0A=
> +=A0=A0=A0=A0 .write_raw =3D inv_icm42600_gyro_write_raw,=0A=
> +=A0=A0=A0=A0 .write_raw_get_fmt =3D inv_icm42600_gyro_write_raw_get_fmt,=
=0A=
> +=A0=A0=A0=A0 .debugfs_reg_access =3D inv_icm42600_debugfs_reg,=0A=
> +};=0A=
> +=0A=
> +int inv_icm42600_gyro_init(struct inv_icm42600_state *st)=0A=
=0A=
This feels like the layering would be clearer if this=0A=
returned the struct iio_dev * and the assignment happened in the=0A=
core driver.=0A=
=0A=
Then state parameter can be const and it'll be obvious it has=0A=
no side effects on the state structure.=0A=
=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
> +=A0=A0=A0=A0 const char *name;=0A=
> +=A0=A0=A0=A0 struct iio_dev *indio_dev;=0A=
> +=0A=
> +=A0=A0=A0=A0 name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->nam=
e);=0A=
> +=A0=A0=A0=A0 if (!name)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
> +=0A=
> +=A0=A0=A0=A0 indio_dev =3D devm_iio_device_alloc(dev, 0);=0A=
> +=A0=A0=A0=A0 if (!indio_dev)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
> +=0A=
> +=A0=A0=A0=A0 iio_device_set_drvdata(indio_dev, st);=0A=
> +=A0=A0=A0=A0 indio_dev->dev.parent =3D dev;=0A=
> +=A0=A0=A0=A0 indio_dev->name =3D name;=0A=
> +=A0=A0=A0=A0 indio_dev->info =3D &inv_icm42600_gyro_info;=0A=
> +=A0=A0=A0=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
> +=A0=A0=A0=A0 indio_dev->channels =3D inv_icm42600_gyro_channels;=0A=
> +=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_icm42600_gyro_ch=
annels);=0A=
> +=0A=
> +=A0=A0=A0=A0 st->indio_gyro =3D indio_dev;=0A=
> +=A0=A0=A0=A0 return devm_iio_device_register(dev, st->indio_gyro);=0A=
> +}=0A=
