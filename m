Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3381D7D62
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 17:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgERPvz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 11:51:55 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:40328 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgERPvx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 11:51:53 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IFlvNp012831;
        Mon, 18 May 2020 08:48:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=Sob4bJkx+QlUoBeCTib0o+l/Fhk+BT2ZP076JxiKg8E=;
 b=BvKlMzU2+pqY/Cf96MQyuRvKLrBuvKYVgnvZIubVfdqmsBwsv8nysveY8tgUhjjxY9OV
 OYoNtHQNjpgeYQWECZHbm41mS3PCY6560/e5KUpucA5wwJf9XD5IQ2Zk5mc6VhC3I8Bk
 TYAA39+uv6niUuChVDKnV9p3IC9XJSTm5ZjCiHdJGIJx+t0dkD6M571k/5//vZpHX3s6
 W4l/uYxnFVm8/rNQcA3w5Ou8bYCnu+kD22HO40S/NJCVL1p6cosESd6rrOnAvx/2StXF
 Gpwc1PvH2WbRMpvSDP9Py00ZS3R+Qqrr6QUITuHsJ3tRDbiTH1rd+8UNgka47NwD+lUn 6Q== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00328301.pphosted.com with ESMTP id 312c4pgqy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 08:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMJBvMDhYX7m1PmlCvk0v287GkmK+iPZEGikZTRs3p05BuAhUI/lEW5M+Mhy47J2LHXurfs1LwKccCutqqq02nrxmqFWLR9F7smFfSMV0IkW9hJeZpXqzWo0goLktxnjiw72tnD3RwxPD+UVOXZ/PLcZ525T1dQuOLpie4eh5fkj64Qy0mW/RSWoeyrYPl1/KCvsvk6BINd+t+Y9C0vDTZbaGZYAJPgZOwCy4EQPpkw4qvmruwP8DA+cV1pXdNIfpGVBjJuxtGZyAZkZ+ErT5qcqw2OoYob/A/0G8e1QPwV8svNlNcL+ktK6tmiCslCbucMvzpyLlkYOWWbL5ayZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sob4bJkx+QlUoBeCTib0o+l/Fhk+BT2ZP076JxiKg8E=;
 b=Nb6yO17dR3jSKVUOWFQu7bTG1XECJssXyub+70P1eRqO/1PKj+N0jZFr/KbHaiq8xqCkxjnqvysGxB5MwQEj/zx+WraTG+8o93YRR1vXw4LXxyOXdxpxdMs6n0nb5fd3Ka73/FyOrw2+n46k4/Byo/ZK18MRCiJyAnHhsLquCTWuYrBvlmaEBOce3b6DU5PQU2colXvLQJlA0XczJPKAUA7Du+troxqbji7y9zq1WdWficwZ6/8atiw1ZlvT/ZHVh1JtglYrd5Vq5hggFwOdOnvayQhf8uvgMUm+VmL5mxxS7nLLdxqVnSLVhQVFVb8LJLBZiIMf1sL9sun4Na7yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sob4bJkx+QlUoBeCTib0o+l/Fhk+BT2ZP076JxiKg8E=;
 b=QOmQitiAC952fCueSXN2KlgChRcR1S3TIYN2arxSUOGjXsX10hmRmCyHx9XDyj38C3grNJuFGa88RovKlSSHIEcW1eZEZYspVTwvz6BMn8gK1RPMTW1HS6ZFTX8YTcKeUUM8Zi1y7AlkgO0tdA+2rNz2IV4ffJxEeuWl4whbKe4=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3469.namprd12.prod.outlook.com (2603:10b6:208:ca::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 15:48:00 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%9]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 15:48:00 +0000
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
Subject: Re: [PATCH 10/12] iio: imu: inv_icm42600: add accurate timestamping
Thread-Topic: [PATCH 10/12] iio: imu: inv_icm42600: add accurate timestamping
Thread-Index: AQHWJH3dACgNnLgoLkCbW7sSh7VR8aieROWAgA/IDUs=
Date:   Mon, 18 May 2020 15:48:00 +0000
Message-ID: <MN2PR12MB44222D115E943070E196AD42C4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-11-jmaneyrol@invensense.com>,<20200508154247.00007599@Huawei.com>
In-Reply-To: <20200508154247.00007599@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42917864-9e8f-427a-ba1c-08d7fb42d7e0
x-ms-traffictypediagnostic: MN2PR12MB3469:
x-microsoft-antispam-prvs: <MN2PR12MB3469E71BF3C5A3D505F4C265C4B80@MN2PR12MB3469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYjashb2s3hfyUZNfLxz0Z2zoMZSs1GoqM3YQQOPf3WDAD/D1Pq0hImvoxzi9xDwIcQ5OWCUuaKD5qU84WqwCTSKgRxGGtpUoz8qVgeFCFMXpcBl2xeLA+/ALYO+i4McMFlsi+ik4HMJ/AafmIxPSJs3gFts9erSpAIHrAdnm3e0nwfslkWbgSM10ZlBQOylWo9Kf3j2XWKpfra0YrpV+2noJ04TPa8W+NIjRdLxR2w6GKwiK03XihNEmQPbdYYBWYkclMFWEhDNssnevYA3SmqyYtU/4QWt6UO+5yAkr/+qcLwyl7UU8LVu6p8EEnYeFd/nG3Na+cyNwoJGyd1uvzH7gkpQCBkrwKBUDk90rVJ+gLNgi9qu9D70j9mciEz3s7KRXCQ0nJZc0WhMLPZ3wPTqVmy5PAKDx4Ma6NUKfZkmzBlMSG4eLEzJNz/BA60P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(366004)(39850400004)(346002)(376002)(7696005)(53546011)(478600001)(6506007)(316002)(4326008)(26005)(33656002)(54906003)(7416002)(52536014)(186003)(2906002)(71200400001)(5660300002)(8936002)(30864003)(8676002)(66446008)(6916009)(9686003)(66946007)(86362001)(91956017)(76116006)(66476007)(66556008)(64756008)(55016002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qhSK1jL96YaGIu2fvjYJuZOHUl7v/ghLOhvB6ShG7F5V2bDh47MYvcNYoZVqeAkW+SYOSt/0o9YVl4I7jEeaOEx1JahHM+OaeqbWtQRu1p3+FI48dj86gD943IuGGf2VKLOgm4/hCf+hq657JMyRe0h5FBZXQY/eSSMtkTBLkINWC6yQU0Q3C5nh776Fppx8WwHYtuJrG9h6bPZzkMLEjnQ2m+1yWepXPUyO4fYsPB0lN2YM5aOojrgB3kbcgXkvX3yQFAN8NZZm10d2FewGQLhj0bq/X3sAphPfCD4cnkMBaf0jAGiRPgOow/QWswBsS4a9kBsGFFL8qV3zxI2gbFygntHWcqDjw6qu7ys8rwZRtthI6yOLvNbd1V4HKO0dIdUT8Qgep+/yW9oVJUQQuL9agfyBvwrNQEWix4mYToGwnCSr+x8fy2IX/0umzRJQxHKFAwKgMza901BWmlFW34mHZyMhXjb4StvGuuaRHPU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42917864-9e8f-427a-ba1c-08d7fb42d7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 15:48:00.3202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKBExpM0xivaWeaAgW9IIeWOUOORZxyLO2L4XjC3oNlYQNPtnc3rlqT3n3+9rq7WEdwQZGPIGRzWPEnatOBRPbTKYbTCbu5ZnUrQp0wSajY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3469
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180135
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
reading timestamp register is here mainly because we can do it, and this is=
 the only way to have the full 20 bits resolution.=0A=
But it is not very useful indeed. I will delete it.=0A=
=0A=
I am not using timestamp stored inside the FIFO, because it is only present=
 when having both accel and gyro on. There is no timestamp data for a singl=
e sensor, which is really too bad. That would have been helpful.=0A=
=0A=
I will add more documentation about it. It is not that tricky, but need mor=
e deep explanations.=0A=
=0A=
New series V2 is in preparation. And again my apologizes for ruining the ma=
il text formatting.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
=0A=
Sent: Friday, May 8, 2020 16:42=0A=
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
Subject: Re: [PATCH 10/12] iio: imu: inv_icm42600: add accurate timestampin=
g=0A=
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
On Thu, 7 May 2020 16:42:20 +0200=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Add a timestamp channel with processed value that returns full=0A=
=0A=
> precision 20 bits timestamp.=0A=
=0A=
> =0A=
=0A=
> Add a timestamping mechanism for buffer that provides accurate=0A=
=0A=
> event timestamps when using watermark. This mechanism estimates=0A=
=0A=
> device internal clock by comparing FIFO interrupts delta time and=0A=
=0A=
> corresponding device elapsed time computed by parsing FIFO data.=0A=
=0A=
=0A=
=0A=
Yikes. That is complex.=A0 Hmm. I always get lost in the maths in these=0A=
=0A=
timestamp patches so my review may be a little superficial.=0A=
=0A=
=0A=
=0A=
However a bit more in the way of docs would be good here.=0A=
=0A=
=0A=
=0A=
The sysfs read of timestamp is unusual and I'm not really sure what it is f=
or.=0A=
=0A=
The delays in a sysfs read of that value are likely to be enough that it's=
=0A=
=0A=
that useful for anything.=0A=
=0A=
=0A=
=0A=
Also, do we make use of the timestamps within the fifo records?=0A=
=0A=
=0A=
=0A=
J=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/Makefile=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =
1 +=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0 |=A0 10 +-=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |=A0 32 ++-=0A=
=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_buffer.c=A0=A0=A0 |=A0 28 +-=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 |=A0=A0 6 +=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c=A0 |=A0 32 ++-=0A=
=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 246 ++++++++++++++++++=
=0A=
=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_timestamp.h |=A0 82 ++++++=0A=
=0A=
>=A0 8 files changed, 421 insertions(+), 16 deletions(-)=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp=
.c=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp=
.h=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_=
icm42600/Makefile=0A=
=0A=
> index d6732118010c..1197b545a682 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/Makefile=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/Makefile=0A=
=0A=
> @@ -7,6 +7,7 @@ inv-icm42600-y +=3D inv_icm42600_accel.o=0A=
=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_temp.o=0A=
=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_trigger.o=0A=
=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_buffer.o=0A=
=0A=
> +inv-icm42600-y +=3D inv_icm42600_timestamp.o=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 obj-$(CONFIG_INV_ICM42600_I2C) +=3D inv-icm42600-i2c.o=0A=
=0A=
>=A0 inv-icm42600-i2c-y +=3D inv_icm42600_i2c.o=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h=0A=
=0A=
> index 947ca4dd245b..e15eddafe009 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
> @@ -16,6 +16,7 @@=0A=
=0A=
>=A0 #include <linux/iio/trigger.h>=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #include "inv_icm42600_buffer.h"=0A=
=0A=
> +#include "inv_icm42600_timestamp.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 enum inv_icm42600_chip {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42600,=0A=
=0A=
> @@ -127,6 +128,7 @@ struct inv_icm42600_suspended {=0A=
=0A=
>=A0=A0 *=A0 @indio_accel:=A0=A0=A0 accelerometer IIO device.=0A=
=0A=
>=A0=A0 *=A0 @trigger:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device =
internal interrupt trigger=0A=
=0A=
>=A0=A0 *=A0 @fifo:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIFO management structure=
.=0A=
=0A=
> + *=A0 @timestamp:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 timestamp manag=
ement structure.=0A=
=0A=
>=A0=A0 */=0A=
=0A=
>=A0 struct inv_icm42600_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
=0A=
> @@ -142,6 +144,10 @@ struct inv_icm42600_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_accel;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_trigger *trigger;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_fifo fifo;=0A=
=0A=
> +=A0=A0=A0=A0 struct {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_timestamp gyro;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_timestamp accel=
;=0A=
=0A=
> +=A0=A0=A0=A0 } timestamp;=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /* Virtual register addresses: @bank on MSB (4 upper bits), @address o=
n LSB */=0A=
=0A=
> @@ -382,11 +388,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, =
int chip, int irq,=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);=0A=
=0A=
>=A0 =0A=
=0A=
> -int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts);=
=0A=
=0A=
> +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st);=0A=
=0A=
>=A0 =0A=
=0A=
> -int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts)=
;=0A=
=0A=
> +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 int irq_type);=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
=0A=
> index 4206be54d057..ac140c824c03 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
=0A=
> @@ -17,6 +17,7 @@=0A=
=0A=
>=A0 #include "inv_icm42600.h"=0A=
=0A=
>=A0 #include "inv_icm42600_temp.h"=0A=
=0A=
>=A0 #include "inv_icm42600_buffer.h"=0A=
=0A=
> +#include "inv_icm42600_timestamp.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> @@ -66,7 +67,7 @@ static const struct iio_chan_spec inv_icm42600_accel_ch=
annels[] =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCE=
L_SCAN_Z,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_accel_ext_infos),=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP)=
,=0A=
=0A=
> -=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_TIMESTAMP_CHAN(INV_ICM42600_ACCEL_SCAN_TIMESTA=
MP),=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /* IIO buffer data */=0A=
=0A=
> @@ -94,14 +95,20 @@ static irqreturn_t inv_icm42600_accel_handler(int irq=
, void *_data)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_poll_func *pf =3D _data;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev =3D pf->indio_dev;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drv=
data(indio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_timestamp *ts =3D &st->timestamp.accel;=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const size_t fifo_nb =3D st->fifo.nb.total;=0A=
=0A=
> +=A0=A0=A0=A0 const size_t accel_nb =3D st->fifo.nb.accel;=0A=
=0A=
> +=A0=A0=A0=A0 const uint32_t fifo_period =3D st->fifo.period;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* exit if no sample */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (fifo_nb =3D=3D 0)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 ret =3D inv_icm42600_accel_parse_fifo(indio_dev, pf->timest=
amp);=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_timestamp_interrupt(ts, fifo_period, fifo_nb, =
accel_nb,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pf->timestamp);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_accel_parse_fifo(indio_dev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st=
->map), "accel fifo error %d\n",=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret)=
;=0A=
=0A=
> @@ -143,6 +150,7 @@ static int inv_icm42600_accel_update_scan_mode(struct=
 iio_dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* update data FIFO write and FIFO watermark */=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_timestamp_apply_odr(&st->timestamp.accel, 0, 0=
, 0);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, fifo_en =
| st->fifo.en);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> @@ -347,6 +355,7 @@ static int inv_icm42600_accel_write_odr(struct inv_ic=
m42600_state *st,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 conf.odr =3D inv_icm42600_accel_odr_conv[idx / 2];=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_accel_conf(st, &conf, NULL)=
;=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_timestamp_update_odr(&st->timestamp.accel, con=
f.odr);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_buffer_update_fifo_period(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_buffer_update_watermark(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> @@ -502,6 +511,9 @@ static int inv_icm42600_accel_read_raw(struct iio_dev=
 *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_TEMP:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_temp_rea=
d_raw(indio_dev, chan, val, val2,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 mask);=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_TIMESTAMP:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_timestamp_read_=
raw(indio_dev, chan, val,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 val2, mask);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 default:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> @@ -694,13 +706,18 @@ int inv_icm42600_accel_init(struct inv_icm42600_sta=
te *st)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return devm_iio_device_register(dev, st->indio_accel=
);=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts)=
=0A=
=0A=
> +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drv=
data(indio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_timestamp *ts =3D &st->timestamp.accel;=
=0A=
=0A=
> +=A0=A0=A0=A0 const size_t fifo_nb =3D st->fifo.nb.total;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const size_t accel_nb =3D st->fifo.nb.accel;=0A=
=0A=
> +=A0=A0=A0=A0 const uint32_t fifo_period =3D st->fifo.period;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ssize_t i, size;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int no;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const void *accel, *gyro, *temp, *timestamp;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int odr;=0A=
=0A=
> +=A0=A0=A0=A0 int64_t ts_val;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_accel_buffer buffer;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* exit if no accel sample */=0A=
=0A=
> @@ -708,7 +725,7 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *ind=
io_dev, int64_t ts)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* parse all fifo packets */=0A=
=0A=
> -=A0=A0=A0=A0 for (i =3D 0; i < st->fifo.count; i +=3D size) {=0A=
=0A=
> +=A0=A0=A0=A0 for (i =3D 0, no =3D 0; i < st->fifo.count; i +=3D size, ++=
no) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D inv_icm42600_fifo_d=
ecode_packet(&st->fifo.data[i],=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 &accel, &gyro, &temp, &timestamp, &odr);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(regmap_get_device(st=
->map), "accel packet size =3D %zd\n",=0A=
=0A=
> @@ -721,9 +738,14 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *in=
dio_dev, int64_t ts)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_=
dbg(regmap_get_device(st->map), "skip accel data\n");=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cont=
inue;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* update odr */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (odr & INV_ICM42600_SENSOR_ACCEL=
)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm4260=
0_timestamp_apply_odr(ts, fifo_period,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 fifo_nb, no);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.accel, accel,=
 sizeof(buffer.accel));=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.temp, temp, s=
izeof(buffer.temp));=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timestamp(=
indio_dev, &buffer, ts);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts_val =3D inv_icm42600_timestamp_g=
et(ts);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timestamp(=
indio_dev, &buffer, ts_val);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
=0A=
> index b428abdc92ee..bea4c9810da7 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
=0A=
> @@ -15,6 +15,7 @@=0A=
=0A=
>=A0 #include <linux/iio/trigger_consumer.h>=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #include "inv_icm42600.h"=0A=
=0A=
> +#include "inv_icm42600_timestamp.h"=0A=
=0A=
>=A0 #include "inv_icm42600_buffer.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state =
*st)=0A=
=0A=
> @@ -194,14 +195,17 @@ static int inv_icm42600_buffer_postdisable(struct i=
io_dev *indio_dev)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int *watermark;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM4260=
0_SENSOR_CONF_INIT;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int sleep =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_timestamp *ts;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (indio_dev =3D=3D st->indio_gyro) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sensor =3D INV_ICM42600_SENS=
OR_GYRO;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D &st->fifo.wate=
rmark.gyro;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &st->timestamp.gyro;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 } else if (indio_dev =3D=3D st->indio_accel) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sensor =3D INV_ICM42600_SENS=
OR_ACCEL;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D &st->fifo.wate=
rmark.accel;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &st->timestamp.accel;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> @@ -223,6 +227,8 @@ static int inv_icm42600_buffer_postdisable(struct iio=
_dev *indio_dev)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 else=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_acc=
el_conf(st, &conf, &sleep);=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_timestamp_reset(ts);=0A=
=0A=
> +=0A=
=0A=
>=A0 out_unlock:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (sleep)=0A=
=0A=
> @@ -316,11 +322,25 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm=
42600_state *st,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (st->fifo.nb.total =3D=3D 0)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro, ts_gyr=
o);=0A=
=0A=
> -=A0=A0=A0=A0 if (ret)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 if (st->fifo.nb.gyro > 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_timestamp_interrupt(&s=
t->timestamp.gyro,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.period, st->fi=
fo.nb.total,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.gyro, ts_gy=
ro);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_parse_fif=
o(st->indio_gyro);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 return inv_icm42600_accel_parse_fifo(st->indio_accel, ts_ac=
cel);=0A=
=0A=
> +=A0=A0=A0=A0 if (st->fifo.nb.accel > 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_timestamp_interrupt(&s=
t->timestamp.accel,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.period, st->fi=
fo.nb.total,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.accel, ts_a=
ccel);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_accel_parse_fi=
fo(st->indio_accel);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 int inv_icm42600_buffer_init(struct inv_icm42600_state *st)=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> index 689089065ff9..563c4348de01 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> @@ -15,6 +15,7 @@=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #include "inv_icm42600.h"=0A=
=0A=
>=A0 #include "inv_icm42600_buffer.h"=0A=
=0A=
> +#include "inv_icm42600_timestamp.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] =3D =
{=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=0A=
=0A=
> @@ -516,6 +517,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, i=
nt chip, int irq,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* initialize timestamping */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_timestamp_init(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* setup FIFO buffer */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_init(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
=0A=
> index dafb104abc77..1245588170bd 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
=0A=
> @@ -17,6 +17,7 @@=0A=
=0A=
>=A0 #include "inv_icm42600.h"=0A=
=0A=
>=A0 #include "inv_icm42600_temp.h"=0A=
=0A=
>=A0 #include "inv_icm42600_buffer.h"=0A=
=0A=
> +#include "inv_icm42600_timestamp.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> @@ -66,7 +67,7 @@ static const struct iio_chan_spec inv_icm42600_gyro_cha=
nnels[] =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_=
SCAN_Z,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 inv_icm42600_gyro_ext_infos),=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),=
=0A=
=0A=
> -=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_GYRO_SCAN_TIMESTAMP),=
=0A=
=0A=
=0A=
=0A=
Interrupt timestamp was pretty much garbage, so I'd just not register that =
in the=0A=
=0A=
first place.=A0 Introduce the timestamp for the first time in this patch.=
=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_TIMESTAMP_CHAN(INV_ICM42600_GYRO_SCAN_TIMESTAM=
P),=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /* IIO buffer data */=0A=
=0A=
> @@ -94,14 +95,20 @@ static irqreturn_t inv_icm42600_gyro_handler(int irq,=
 void *_data)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_poll_func *pf =3D _data;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev =3D pf->indio_dev;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drv=
data(indio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_timestamp *ts =3D &st->timestamp.gyro;=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const size_t fifo_nb =3D st->fifo.nb.total;=0A=
=0A=
> +=A0=A0=A0=A0 const size_t gyro_nb =3D st->fifo.nb.gyro;=0A=
=0A=
> +=A0=A0=A0=A0 const uint32_t fifo_period =3D st->fifo.period;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* exit if no sample */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (fifo_nb =3D=3D 0)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_parse_fifo(indio_dev, pf->timesta=
mp);=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_timestamp_interrupt(ts, fifo_period, fifo_nb, =
gyro_nb,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pf->timestamp);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_parse_fifo(indio_dev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st=
->map), "gyro fifo error %d\n",=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret)=
;=0A=
=0A=
> @@ -143,6 +150,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct =
iio_dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* update data FIFO write and FIFO watermark */=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_timestamp_apply_odr(&st->timestamp.gyro, 0, 0,=
 0);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, fifo_en =
| st->fifo.en);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> @@ -359,6 +367,7 @@ static int inv_icm42600_gyro_write_odr(struct inv_icm=
42600_state *st,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 conf.odr =3D inv_icm42600_gyro_odr_conv[idx / 2];=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, NULL);=
=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_timestamp_update_odr(&st->timestamp.gyro, conf=
.odr);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_buffer_update_fifo_period(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_buffer_update_watermark(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> @@ -514,6 +523,9 @@ static int inv_icm42600_gyro_read_raw(struct iio_dev =
*indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_TEMP:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_temp_rea=
d_raw(indio_dev, chan, val, val2,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 mask);=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_TIMESTAMP:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_timestamp_read_=
raw(indio_dev, chan, val,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 val2, mask);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 default:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> @@ -706,13 +718,18 @@ int inv_icm42600_gyro_init(struct inv_icm42600_stat=
e *st)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return devm_iio_device_register(dev, st->indio_gyro)=
;=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts)=
=0A=
=0A=
> +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drv=
data(indio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_timestamp *ts =3D &st->timestamp.gyro;=
=0A=
=0A=
> +=A0=A0=A0=A0 const size_t fifo_nb =3D st->fifo.nb.total;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const size_t gyro_nb =3D st->fifo.nb.gyro;=0A=
=0A=
> +=A0=A0=A0=A0 const uint32_t fifo_period =3D st->fifo.period;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ssize_t i, size;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int no;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const void *accel, *gyro, *temp, *timestamp;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int odr;=0A=
=0A=
> +=A0=A0=A0=A0 int64_t ts_val;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_gyro_buffer buffer;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* exit if no gyro sample */=0A=
=0A=
> @@ -720,7 +737,7 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indi=
o_dev, int64_t ts)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* parse all fifo packets */=0A=
=0A=
> -=A0=A0=A0=A0 for (i =3D 0; i < st->fifo.count; i +=3D size) {=0A=
=0A=
> +=A0=A0=A0=A0 for (i =3D 0, no =3D 0; i < st->fifo.count; i +=3D size, ++=
no) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D inv_icm42600_fifo_d=
ecode_packet(&st->fifo.data[i],=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 &accel, &gyro, &temp, &timestamp, &odr);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(regmap_get_device(st=
->map), "gyro packet size =3D %zd\n",=0A=
=0A=
> @@ -733,9 +750,14 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *ind=
io_dev, int64_t ts)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_=
dbg(regmap_get_device(st->map), "skip gyro data\n");=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cont=
inue;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* update odr */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (odr & INV_ICM42600_SENSOR_GYRO)=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm4260=
0_timestamp_apply_odr(ts, fifo_period,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 fifo_nb, no);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.gyro, gyro, s=
izeof(buffer.gyro));=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.temp, temp, s=
izeof(buffer.temp));=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timestamp(=
indio_dev, &buffer, ts);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts_val =3D inv_icm42600_timestamp_g=
et(ts);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timestamp(=
indio_dev, &buffer, ts_val);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/driv=
ers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..79cf777e2e84=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
=0A=
> @@ -0,0 +1,246 @@=0A=
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
> +#include <linux/mutex.h>=0A=
=0A=
> +#include <linux/pm_runtime.h>=0A=
=0A=
> +#include <linux/regmap.h>=0A=
=0A=
> +#include <linux/math64.h>=0A=
=0A=
> +#include <linux/iio/iio.h>=0A=
=0A=
> +=0A=
=0A=
> +#include "inv_icm42600.h"=0A=
=0A=
> +#include "inv_icm42600_timestamp.h"=0A=
=0A=
> +=0A=
=0A=
> +/* internal chip period is 32kHz, 31250ns */=0A=
=0A=
> +#define INV_ICM42600_TIMESTAMP_PERIOD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 31250=0A=
=0A=
> +/* allow a jitter of +/- 2% */=0A=
=0A=
> +#define INV_ICM42600_TIMESTAMP_JITTER=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 2=0A=
=0A=
> +/* compute min and max periods accepted */=0A=
=0A=
> +#define INV_ICM42600_TIMESTAMP_MIN_PERIOD(_p)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 (((_p) * (100 - INV_ICM42600_TIMESTAMP_JITTER)) / 100)=0A=
=0A=
> +#define INV_ICM42600_TIMESTAMP_MAX_PERIOD(_p)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 (((_p) * (100 + INV_ICM42600_TIMESTAMP_JITTER)) / 100)=0A=
=0A=
> +=0A=
=0A=
> +static void inv_update_acc(struct inv_icm42600_timestamp_acc *acc, uint3=
2_t val)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 uint64_t sum =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 size_t i;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 acc->values[acc->idx++] =3D val;=0A=
=0A=
> +=A0=A0=A0=A0 if (acc->idx >=3D ARRAY_SIZE(acc->values))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 acc->idx =3D 0;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(acc->values); ++i) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (acc->values[i] =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sum +=3D acc->values[i];=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 acc->val =3D div_u64(sum, i);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_timestamp_read(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t *ts)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 __le32 raw;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_=
RESET,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IN=
V_ICM42600_SIGNAL_PATH_RESET_TMST_STROBE);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto exit;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* Read timestamp value 3 registers little-endian */=0A=
=0A=
> +=A0=A0=A0=A0 raw =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->map, INV_ICM42600_REG_TMSTVAL,=
 &raw, 3);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto exit;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 *ts =3D (uint32_t)le32_to_cpu(raw);=0A=
=0A=
> +exit:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_timestamp_read_raw(struct iio_dev *indio_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2, long mask)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t ts;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_TIMESTAMP)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (mask) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_PROCESSED:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_mod=
e(indio_dev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_timestamp_read=
(st, &ts);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indi=
o_dev);=0A=
=0A=
=0A=
=0A=
Unusual to expose it as a readable channel.=A0 Why would you want to do thi=
s?=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D ts * 1000;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static void inv_icm42600_init_ts(struct inv_icm42600_timestamp *ts,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 struct device *dev, uint32_t period)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 /* initial odr for sensor is 1kHz */=0A=
=0A=
> +=A0=A0=A0=A0 const uint32_t default_period =3D 1000000;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ts->dev =3D dev;=0A=
=0A=
> +=A0=A0=A0=A0 ts->mult =3D default_period / INV_ICM42600_TIMESTAMP_PERIOD=
;=0A=
=0A=
> +=A0=A0=A0=A0 ts->new_mult =3D period / INV_ICM42600_TIMESTAMP_PERIOD;=0A=
=0A=
> +=A0=A0=A0=A0 ts->period =3D default_period;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* use theoretical value for chip period */=0A=
=0A=
> +=A0=A0=A0=A0 inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PER=
IOD);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_timestamp_init(struct inv_icm42600_state *st)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int val;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_init_ts(&st->timestamp.gyro, regmap_get_device=
(st->map),=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 inv_icm42600_odr_to_period(st->conf.gyro.odr));=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_init_ts(&st->timestamp.accel, regmap_get_devic=
e(st->map),=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 inv_icm42600_odr_to_period(st->conf.accel.odr));=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* enable timestamp register */=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_TMST_CONFIG_TMST_EN;=0A=
=0A=
> +=A0=A0=A0=A0 return regmap_update_bits(st->map, INV_ICM42600_REG_TMST_CO=
NFIG,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 INV_ICM42600_TMST_CONFIG_MASK, val);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +void inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int odr)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t period;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 period =3D inv_icm42600_odr_to_period(odr);=0A=
=0A=
> +=A0=A0=A0=A0 ts->new_mult =3D period / INV_ICM42600_TIMESTAMP_PERIOD;=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(ts->dev, "ts new mult: %u\n", ts->new_mult);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static bool inv_validate_period(uint32_t period, uint32_t mult)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 const uint32_t chip_period =3D INV_ICM42600_TIMESTAMP_PERIO=
D;=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t period_min, period_max;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* check that time interval between interrupts is acceptabl=
e */=0A=
=0A=
> +=A0=A0=A0=A0 period_min =3D INV_ICM42600_TIMESTAMP_MIN_PERIOD(chip_perio=
d) * mult;=0A=
=0A=
> +=A0=A0=A0=A0 period_max =3D INV_ICM42600_TIMESTAMP_MAX_PERIOD(chip_perio=
d) * mult;=0A=
=0A=
> +=A0=A0=A0=A0 if (period > period_min && period < period_max)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return true;=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t mult, uint32_t period)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t new_chip_period;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (!inv_validate_period(period, mult))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* update chip internal period estimation */=0A=
=0A=
> +=A0=A0=A0=A0 new_chip_period =3D period / mult;=0A=
=0A=
> +=A0=A0=A0=A0 inv_update_acc(&ts->chip_period, new_chip_period);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(ts->dev, "ts chip period: %u - val %u\n", new_chip_=
period,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->chip_period.val);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return true;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t fifo_period, size_t fifo_nb,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t sensor_nb, int64_t timestamp)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_timestamp_interval *it;=0A=
=0A=
> +=A0=A0=A0=A0 int64_t delta, interval;=0A=
=0A=
> +=A0=A0=A0=A0 const uint32_t fifo_mult =3D fifo_period / INV_ICM42600_TIM=
ESTAMP_PERIOD;=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t period =3D ts->period;=0A=
=0A=
> +=A0=A0=A0=A0 int32_t m;=0A=
=0A=
> +=A0=A0=A0=A0 bool valid =3D false;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (fifo_nb =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* update interrupt timestamp and compute chip and sensor p=
eriods */=0A=
=0A=
> +=A0=A0=A0=A0 it =3D &ts->it;=0A=
=0A=
> +=A0=A0=A0=A0 it->lo =3D it->up;=0A=
=0A=
> +=A0=A0=A0=A0 it->up =3D timestamp;=0A=
=0A=
> +=A0=A0=A0=A0 delta =3D it->up - it->lo;=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(ts->dev, "ts it: %lld - %lld - %lld\n", it->lo, it-=
>up, delta);=0A=
=0A=
> +=A0=A0=A0=A0 if (it->lo !=3D 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D div_s64(delta, fifo_nb);=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 valid =3D inv_compute_chip_period(t=
s, fifo_mult, period);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (valid)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->period =
=3D ts->mult * ts->chip_period.val;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* no previous data, compute theoritical value from interru=
pt */=0A=
=0A=
> +=A0=A0=A0=A0 if (ts->timestamp =3D=3D 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interval =3D (int64_t)ts->period * =
(int64_t)sensor_nb;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->timestamp =3D it->up - interval=
;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(ts->dev, "ts start: %lld\n"=
, ts->timestamp);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* if interrupt interval is valid, sync with interrupt time=
stamp */=0A=
=0A=
> +=A0=A0=A0=A0 if (valid) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute real fifo_period */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_period =3D fifo_mult * ts->chi=
p_period.val;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D it->lo - ts->timestamp;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 while (delta >=3D (fifo_period * 3 =
/ 2))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta -=3D =
fifo_period;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute maximal adjustment value=
 */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m =3D INV_ICM42600_TIMESTAMP_MAX_PE=
RIOD(ts->period) - ts->period;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (delta > m)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D m=
;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (delta < -m)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D -=
m;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(ts->dev, "ts adj: %lld\n", =
delta);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->timestamp +=3D delta;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t fifo_period, size_t fifo_nb,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int fifo_no)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 int64_t interval;=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t fifo_mult;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ts->mult =3D ts->new_mult;=0A=
=0A=
> +=A0=A0=A0=A0 ts->period =3D ts->mult * ts->chip_period.val;=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(ts->dev, "ts mult: %u\n", ts->mult);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (ts->timestamp !=3D 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute real fifo period */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_mult =3D fifo_period / INV_ICM=
42600_TIMESTAMP_PERIOD;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_period =3D fifo_mult * ts->chi=
p_period.val;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute timestamp from current i=
nterrupt after ODR change */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interval =3D (int64_t)(fifo_nb - fi=
fo_no) * (int64_t)fifo_period;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->timestamp =3D ts->it.up - inter=
val;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(ts->dev, "ts new: %lld\n", =
ts->timestamp);=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +}=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/driv=
ers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..c865e1a9a7c8=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h=0A=
=0A=
> @@ -0,0 +1,82 @@=0A=
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
> +#ifndef INV_ICM42600_TIMESTAMP_H_=0A=
=0A=
> +#define INV_ICM42600_TIMESTAMP_H_=0A=
=0A=
> +=0A=
=0A=
> +#include <linux/device.h>=0A=
=0A=
> +#include <linux/iio/iio.h>=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_state;=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_timestamp_interval {=0A=
=0A=
> +=A0=A0=A0=A0 int64_t lo;=0A=
=0A=
> +=A0=A0=A0=A0 int64_t up;=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_timestamp_acc {=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t val;=0A=
=0A=
> +=A0=A0=A0=A0 size_t idx;=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t values[32];=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_timestamp {=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_timestamp_interval it;=0A=
=0A=
> +=A0=A0=A0=A0 int64_t timestamp;=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t mult;=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t new_mult;=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t period;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_timestamp_acc chip_period;=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_TIMESTAMP_CHAN(_index)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TIMESTAMP,=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_CHA=
N_INFO_PROCESSED),=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D _index,=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_type =3D {=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .sign =3D '=
s',=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .realbits =
=3D 64,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .storagebit=
s =3D 64,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_timestamp_read_raw(struct iio_dev *indio_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2, long mask);=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_timestamp_init(struct inv_icm42600_state *st);=0A=
=0A=
> +=0A=
=0A=
> +void inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int odr);=0A=
=0A=
> +=0A=
=0A=
> +void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t fifo_period, size_t fifo_nb,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t sensor_nb, int64_t timestamp);=0A=
=0A=
> +=0A=
=0A=
> +static inline int64_t=0A=
=0A=
> +inv_icm42600_timestamp_get(struct inv_icm42600_timestamp *ts)=0A=
=0A=
=0A=
=0A=
Perhaps timestamp_pop?=A0 Kind of indicates that you are destructively=0A=
=0A=
retrieving a timetamp.=0A=
=0A=
=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 ts->timestamp +=3D ts->period;=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(ts->dev, "ts: %lld\n", ts->timestamp);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ts->timestamp;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t fifo_period, size_t fifo_nb,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int fifo_no);=0A=
=0A=
> +=0A=
=0A=
> +static inline void=0A=
=0A=
> +inv_icm42600_timestamp_reset(struct inv_icm42600_timestamp *ts)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 const struct inv_icm42600_timestamp_interval interval_init =
=3D {0LL, 0LL};=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ts->it =3D interval_init;=0A=
=0A=
> +=A0=A0=A0=A0 ts->timestamp =3D 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +#endif=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
