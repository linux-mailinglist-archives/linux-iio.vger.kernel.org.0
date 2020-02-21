Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC82167F8C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 15:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgBUOE3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 09:04:29 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:42832 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbgBUOE3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 09:04:29 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LDqRbb014332;
        Fri, 21 Feb 2020 06:04:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=RcoI9hG4Rj9eMBEkocJcepJYkG4xYpVn322ynu1vbuw=;
 b=HHyxRFNmkYFeoGBuXvymtDMZfryCKMDoSeIB63R9jsKM+6Fe2vrMZR1t/LLjA+ZJ3rgB
 +Yd4qYhi36M1k2EzLUBSAXQ6i0/32HvZBwztWhYytryJ07/mhrw3BnqJgoMRxB7yGpH4
 qQr5VcBR3QI3LZorB0HFLBU6k2yVEcb5x4TzBHd7cC8W4mHJFyFO06SM9WH381D16jrp
 HyFdVkHz10vobaen3mmaSbGRfeSx9JyzXdUx3O8EVQmusMuuPOMgnkiwQeg8shutTYa/
 Zg/mU38+EF6QLdRkBCSsdT6pIrf2mHG71XDirbU43+P0bKRmAd+WzjRBhpOtDCKIaZQN 4g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-00328301.pphosted.com with ESMTP id 2y8uem9dx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 06:04:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMBWuOdSy1sJPgKW3CwNQCFOXsoJGfis6Txh8P6CU2U4UcRl+MXjxleSqudxk7ZwrZ7E+fzE7o/pbDHLZjEjChNpTi9Q2JX5ub3PoGT9rExophvsZuI0KBGLjIggvycwdRBiiMH8TWj2/QwBEF8fjU9Mjzh4S9KoTs2dGBDkHFYC2xCT3lO4U5e3Jc/5KJVsnxPTfTsoTu/NE8bWsrQ+0B+wNaZ2/HK9+DP+WkJaY0lr/7PVpodJHeCmW+vUvLY3jLnTLnFHgvu75Lgc0R24ZZZJy2EBcqbD/FsFJrRrsmyfAf01X+KHKEIlGxqAAWnaO66suXSwrBSR0navoUu0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcoI9hG4Rj9eMBEkocJcepJYkG4xYpVn322ynu1vbuw=;
 b=hwoTcsDPetgCnhI7okV/rVG1FfsS7miwlz9dDfLazs17ebUjwJzhIErYdAGIK8XkTA7BLzCPpcYhxR3/XeMi8/4Dr9nyAkKMWywj9aU8nnxVxjQmocUWQihg8GIlsiEBLsSNrjV22316ldEaCDf4srbQVZgcF71TbEPl62NEYryKgYW+Ws5ZsZaDVJmG9uIa/0y7IMWKV7b2OwlMBeI7uZUST17/utru+cSsDcsi008I+/4tLxzxG/qvoxXAtueJP7URopw5Lk9617MGvsFTNLbSjgg71n2CqrLJMj0kUGcDqyFPPvsuoU21Rs8SjnkUgJWt0WZ2hrRxaDTGD9lhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcoI9hG4Rj9eMBEkocJcepJYkG4xYpVn322ynu1vbuw=;
 b=BE+TsISlgLKJpiKooB6VSbI2r5lTiy6jWPWuEt0FbDlknWRVUgBQK+dWrihnsUc4GfKRys0MHiIw+Y9oc8ykvk71WHV4OS5k2WAndAddP0pDbdnxCmE4zWx2msF02DXoitloQpZ0dKGMCy4IhSYXTGGRN5wKrq7u9KsDD5MX+k4=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Fri, 21 Feb
 2020 14:04:21 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.021; Fri, 21 Feb 2020
 14:04:21 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 12/13] iio: imu: inv_mpu6050: use runtime pm with
 autosuspend
Thread-Topic: [PATCH v2 12/13] iio: imu: inv_mpu6050: use runtime pm with
 autosuspend
Thread-Index: AQHV5zKiPKrK9DXwykeLcHDQk3kYfKgljQWAgAAkFI8=
Date:   Fri, 21 Feb 2020 14:04:20 +0000
Message-ID: <CH2PR12MB41812024EE950EB2D3649648C4120@CH2PR12MB4181.namprd12.prod.outlook.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-13-jmaneyrol@invensense.com>,<20200221115445.6a535ead@archlinux>
In-Reply-To: <20200221115445.6a535ead@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6cd15b6-a42c-4ae8-12df-08d7b6d6f2de
x-ms-traffictypediagnostic: CH2PR12MB4071:
x-microsoft-antispam-prvs: <CH2PR12MB4071C8CA3399D82B31030388C4120@CH2PR12MB4071.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(396003)(346002)(376002)(366004)(199004)(189003)(5660300002)(52536014)(91956017)(76116006)(64756008)(66556008)(66476007)(6916009)(66446008)(30864003)(26005)(6506007)(66946007)(7696005)(186003)(71200400001)(53546011)(8676002)(316002)(81166006)(2906002)(81156014)(33656002)(8936002)(4326008)(55016002)(478600001)(86362001)(9686003)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4071;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqrlWDs/faiJoyO7Be03t50Rbo2s8Umatt1/y0IqQhHFXSl3OSlJ1hYYFZd58FHzc2WSiHhkYW3mKwMoTL/XpN0E966U5S3PZNELEZGoLjsY9Hra3zcm1h1DlWv4hUenr2L/Bbns6hEUQu0Q2lFCmeR0jxyhwFq2B9HaOHMUADwAZOCxJ55Ybi+STuv7V7AnXLptsEqNy3ToOX/Dyiolfr5mfNkInrVFEWNXTwwvTsYFGWU3EFSdDMZGf1byLHzfoyyfuThEaDuSzCEdYEGDfF7RyC/SCiUcHOHxOI16XpIoAdTdmn5BKDtOWcB4sAjeUDYe6/GWSMj+X4FL+FFvnCdwDKfCc3uR20S+7uSOx9n+xffmuK3LYDX7yERQ9Rk+FLmfAtie1w4pvMh4afj9dehoWtK97We6E8OQEs0HXkzl6051t1jiok9g07Zf0SXT
x-ms-exchange-antispam-messagedata: bYBlfadZ00No3zKYKsr6HvNRmIbCrsfd+3b4W5vVZwhhFjab4QZD4Go8imaGzlK3tWlWyRXDz8gkpo4CodoDpoe5SE5LdekQvUoDV373zjkl0PZCOOE+9VmnSIbVqaIBsmtKYCVQtcelb8C1L2CReg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cd15b6-a42c-4ae8-12df-08d7b6d6f2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 14:04:20.8010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZWTaoFHtsJlLfHjkB8S0mvlWh59Ng7cwbu1Ub4HEjoFLxIE/GVLHq4Q+N0/zLLWM14NjXnt/1uGFxlusjrwiZRFxBZqqlft/wN7ve1xSDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_04:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002210106
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks for catching this up.=0A=
JB=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Sent: Friday, February 21, 2020 12:54=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH v2 12/13] iio: imu: inv_mpu6050: use runtime pm with au=
tosuspend=0A=
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
On Wed, 19 Feb 2020 15:39:57 +0100=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Use runtime power management for handling chip power and=0A=
=0A=
> sensor engines on/off. Simplifies things a lot since pm=0A=
=0A=
> runtime already has reference counter.=0A=
=0A=
> Usage of autosuspend reduces the number of power on/off. This=0A=
=0A=
> makes polling interface now usable to get data at low=0A=
=0A=
> frequency.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Missing static marking after reducing scope of one function.=0A=
=0A=
See inline. I've fixed that up and applied.=0A=
=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0=A0=A0 | 267 ++++++++++++=
------=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0=A0=A0=A0 |=A0=A0 5 +-=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=A0 33 ++-=0A=
=0A=
>=A0 3 files changed, 194 insertions(+), 111 deletions(-)=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> index 9076b6bb099c..750fbc2614f0 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> @@ -16,6 +16,8 @@=0A=
=0A=
>=A0 #include <linux/acpi.h>=0A=
=0A=
>=A0 #include <linux/platform_device.h>=0A=
=0A=
>=A0 #include <linux/regulator/consumer.h>=0A=
=0A=
> +#include <linux/pm.h>=0A=
=0A=
> +#include <linux/pm_runtime.h>=0A=
=0A=
>=A0 #include "inv_mpu_iio.h"=0A=
=0A=
>=A0 #include "inv_mpu_magn.h"=0A=
=0A=
>=A0 =0A=
=0A=
> @@ -400,26 +402,13 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_st=
ate *st, bool power_on)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 if (power_on) {=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->powerup_count) {=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_pwr_mgmt_1_write(st, false, -1, -1);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 return result;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_rang=
e(INV_MPU6050_REG_UP_TIME_MIN,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_REG_UP_TIME_MAX);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->powerup_count++;=0A=
=0A=
> -=A0=A0=A0=A0 } else {=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st->powerup_count =3D=3D 1) {=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_pwr_mgmt_1_write(st, true, -1, -1);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 return result;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->powerup_count--;=0A=
=0A=
> -=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 result =3D inv_mpu6050_pwr_mgmt_1_write(st, !power_on, -1, =
-1);=0A=
=0A=
> +=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map), "set power %d, count=3D=
%u\n",=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 power_on, st->powerup_count);=0A=
=0A=
> +=A0=A0=A0=A0 if (power_on)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(INV_MPU6050_REG_UP_TIM=
E_MIN,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 INV_MPU6050_REG_UP_TIME_MAX);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
>=A0 }=0A=
=0A=
> @@ -563,6 +552,7 @@ static int inv_mpu6050_read_channel_data(struct iio_d=
ev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev)=
;=0A=
=0A=
> +=A0=A0=A0=A0 struct device *pdev =3D regmap_get_device(st->map);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int freq_hz, period_us, min_sleep_us, max_s=
leep_us;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
=0A=
> @@ -571,92 +561,85 @@ static int inv_mpu6050_read_channel_data(struct iio=
_dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 freq_hz =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chi=
p_config.divider);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 period_us =3D 1000000 / freq_hz;=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);=0A=
=0A=
> -=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0 result =3D pm_runtime_get_sync(pdev);=0A=
=0A=
> +=A0=A0=A0=A0 if (result < 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_noidle(pdev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 switch (chan->type) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_ANGL_VEL:=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, true,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_GYRO);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need to wait 2 periods to have f=
irst valid sample */=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D 2 * period_us;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D 2 * (period_us + p=
eriod_us / 2);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_slee=
p_us);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.gyro_en) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_switch_engine(st, true,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_GYRO);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 goto error_power_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need to =
wait 2 periods to have first valid sample */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_u=
s =3D 2 * period_us;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_u=
s =3D 2 * (period_us + period_us / 2);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_rang=
e(min_sleep_us, max_sleep_us);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor_s=
how(st, st->reg->raw_gyro,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chan->chann=
el2, val);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, false,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_GYRO);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_ACCEL:=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, true,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_ACCL);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1 period for first sample a=
vailability */=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D period_us;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D period_us + period=
_us / 2;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_slee=
p_us);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.accl_en) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_switch_engine(st, true,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_ACCL);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 goto error_power_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1 p=
eriod for first sample availability */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_u=
s =3D period_us;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_u=
s =3D period_us + period_us / 2;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_rang=
e(min_sleep_us, max_sleep_us);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor_s=
how(st, st->reg->raw_accl,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chan->chann=
el2, val);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, false,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_ACCL);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_TEMP:=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, true,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_TEMP);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1 period for first sample a=
vailability */=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D period_us;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D period_us + period=
_us / 2;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_slee=
p_us);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.temp_en) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_switch_engine(st, true,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_TEMP);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 goto error_power_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1 p=
eriod for first sample availability */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_u=
s =3D period_us;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_u=
s =3D period_us + period_us / 2;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_rang=
e(min_sleep_us, max_sleep_us);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor_s=
how(st, st->reg->temperature,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IIO_MOD_X, =
val);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, false,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_TEMP);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_MAGN:=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, true,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_MAGN);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* frequency is limited for magneto=
meter */=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (freq_hz > INV_MPU_MAGN_FREQ_HZ_=
MAX) {=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 freq_hz =3D=
 INV_MPU_MAGN_FREQ_HZ_MAX;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_us =
=3D 1000000 / freq_hz;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.magn_en) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_switch_engine(st, true,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_MAGN);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 goto error_power_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* frequenc=
y is limited for magnetometer */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (freq_hz=
 > INV_MPU_MAGN_FREQ_HZ_MAX) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 freq_hz =3D INV_MPU_MAGN_FREQ_HZ_MAX;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 period_us =3D 1000000 / freq_hz;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need to =
wait 2 periods to have first valid sample */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_u=
s =3D 2 * period_us;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_u=
s =3D 2 * (period_us + period_us / 2);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_rang=
e(min_sleep_us, max_sleep_us);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need to wait 2 periods to have f=
irst valid sample */=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D 2 * period_us;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D 2 * (period_us + p=
eriod_us / 2);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_slee=
p_us);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu_magn_read(st=
, chan->channel2, val);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, false,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_MAGN);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 default:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> -=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_power_off;=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(pdev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 error_power_off:=0A=
=0A=
> -=A0=A0=A0=A0 inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> @@ -795,6 +778,7 @@ static int inv_mpu6050_write_raw(struct iio_dev *indi=
o_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 int val, int val2, long mask)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state=A0 *st =3D iio_priv(indio_d=
ev);=0A=
=0A=
> +=A0=A0=A0=A0 struct device *pdev =3D regmap_get_device(st->map);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /*=0A=
=0A=
> @@ -806,9 +790,11 @@ static int inv_mpu6050_write_raw(struct iio_dev *ind=
io_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);=0A=
=0A=
> -=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0 result =3D pm_runtime_get_sync(pdev);=0A=
=0A=
> +=A0=A0=A0=A0 if (result < 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_noidle(pdev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_write_raw_unlock;=
=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 switch (mask) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
=0A=
> @@ -846,7 +832,8 @@ static int inv_mpu6050_write_raw(struct iio_dev *indi=
o_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 result |=3D inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(pdev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
=0A=
>=A0 error_write_raw_unlock:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indio_dev);=0A=
=0A=
> @@ -903,6 +890,7 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struc=
t device_attribute *attr,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev)=
;=0A=
=0A=
> +=A0=A0=A0=A0 struct device *pdev =3D regmap_get_device(st->map);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (kstrtoint(buf, 10, &fifo_rate))=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> @@ -920,9 +908,11 @@ inv_mpu6050_fifo_rate_store(struct device *dev, stru=
ct device_attribute *attr,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D 0;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto fifo_rate_fail_unlock;=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);=0A=
=0A=
> -=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0 result =3D pm_runtime_get_sync(pdev);=0A=
=0A=
> +=A0=A0=A0=A0 if (result < 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_noidle(pdev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto fifo_rate_fail_unlock;=
=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->sample_rat=
e_div, d);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> @@ -938,8 +928,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struc=
t device_attribute *attr,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto fifo_rate_fail_power_of=
f;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(pdev);=0A=
=0A=
>=A0 fifo_rate_fail_power_off:=0A=
=0A=
> -=A0=A0=A0=A0 result |=3D inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
=0A=
>=A0 fifo_rate_fail_unlock:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> @@ -1385,6 +1376,14 @@ static void inv_mpu_core_disable_regulator_action(=
void *_data)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 inv_mpu_core_disable_regulator_vddio(st);=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> +static void inv_mpu_pm_disable(void *data)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D data;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_sync_suspend(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_disable(dev);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
>=A0 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *nam=
e,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int (*inv_mpu_bus_setup)(str=
uct iio_dev *), int chip_type)=0A=
=0A=
>=A0 {=0A=
=0A=
> @@ -1409,7 +1408,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const char *name,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 st =3D iio_priv(indio_dev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_init(&st->lock);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 st->chip_type =3D chip_type;=0A=
=0A=
> -=A0=A0=A0=A0 st->powerup_count =3D 0;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 st->irq =3D irq;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 st->map =3D regmap;=0A=
=0A=
>=A0 =0A=
=0A=
> @@ -1521,8 +1519,16 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 error_power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 /* chip init is done, turning off */=0A=
=0A=
> -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> +=A0=A0=A0=A0 /* chip init is done, turning on runtime power management *=
/=0A=
=0A=
> +=A0=A0=A0=A0 result =3D pm_runtime_set_active(dev);=0A=
=0A=
> +=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_power_off;=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_get_noresume(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_enable(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND_D=
ELAY_MS);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_use_autosuspend(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put(dev);=0A=
=0A=
> +=A0=A0=A0=A0 result =3D devm_add_action_or_reset(dev, inv_mpu_pm_disable=
, dev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
>=A0 =0A=
=0A=
> @@ -1590,11 +1596,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int=
 irq, const char *name,=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 EXPORT_SYMBOL_GPL(inv_mpu_core_probe);=0A=
=0A=
>=A0 =0A=
=0A=
> -#ifdef CONFIG_PM_SLEEP=0A=
=0A=
> -=0A=
=0A=
> -static int inv_mpu_resume(struct device *dev)=0A=
=0A=
> +static int __maybe_unused inv_mpu_resume(struct device *dev)=0A=
=0A=
>=A0 {=0A=
=0A=
> -=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(d=
ev));=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> @@ -1603,27 +1608,101 @@ static int inv_mpu_resume(struct device *dev)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);=0A=
=0A=
> +=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engine(st, true, st->suspende=
d_sensors);=0A=
=0A=
> +=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (iio_buffer_enabled(indio_dev))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_prepare_fifo=
(st, true);=0A=
=0A=
> +=0A=
=0A=
>=A0 out_unlock:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -static int inv_mpu_suspend(struct device *dev)=0A=
=0A=
> +static int __maybe_unused inv_mpu_suspend(struct device *dev)=0A=
=0A=
>=A0 {=0A=
=0A=
> -=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(d=
ev));=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (iio_buffer_enabled(indio_dev)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_prepare_fifo=
(st, false);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->suspended_sensors =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 if (st->chip_config.accl_en)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended_sensors |=3D INV_MPU6=
050_SENSOR_ACCL;=0A=
=0A=
> +=A0=A0=A0=A0 if (st->chip_config.gyro_en)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended_sensors |=3D INV_MPU6=
050_SENSOR_GYRO;=0A=
=0A=
> +=A0=A0=A0=A0 if (st->chip_config.temp_en)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended_sensors |=3D INV_MPU6=
050_SENSOR_TEMP;=0A=
=0A=
> +=A0=A0=A0=A0 if (st->chip_config.magn_en)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended_sensors |=3D INV_MPU6=
050_SENSOR_MAGN;=0A=
=0A=
> +=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engine(st, false, st->suspend=
ed_sensors);=0A=
=0A=
> +=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> +=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 inv_mpu_core_disable_regulator_vddio(st);=0A=
=0A=
> +out_unlock:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
>=A0 }=0A=
=0A=
> -#endif /* CONFIG_PM_SLEEP */=0A=
=0A=
>=A0 =0A=
=0A=
> -SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);=0A=
=0A=
> +static int __maybe_unused inv_mpu_runtime_suspend(struct device *dev)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(d=
ev));=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sensors;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 sensors =3D INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GY=
RO |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050=
_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_mpu6050_switch_engine(st, false, sensors);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 inv_mpu_core_disable_regulator_vddio(st);=0A=
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
> +static int __maybe_unused inv_mpu_runtime_resume(struct device *dev)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(d=
ev));=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_mpu_core_enable_regulator_vddio(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return inv_mpu6050_set_power_itg(st, true);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +const struct dev_pm_ops inv_mpu_pmops =3D {=0A=
=0A=
> +=A0=A0=A0=A0 SET_SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume)=0A=
=0A=
> +=A0=A0=A0=A0 SET_RUNTIME_PM_OPS(inv_mpu_runtime_suspend, inv_mpu_runtime=
_resume, NULL)=0A=
=0A=
> +};=0A=
=0A=
>=A0 EXPORT_SYMBOL_GPL(inv_mpu_pmops);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 MODULE_AUTHOR("Invensense Corporation");=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
> index e328c98e362c..cd38b3fccc7b 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
> @@ -164,6 +164,7 @@ struct inv_mpu6050_hw {=0A=
=0A=
>=A0=A0 *=A0 @magn_disabled:=A0=A0=A0=A0 magnetometer disabled for backward=
 compatibility reason.=0A=
=0A=
>=A0=A0 *=A0 @magn_raw_to_gauss:=A0=A0=A0=A0=A0 coefficient to convert mag =
raw value to Gauss.=0A=
=0A=
>=A0=A0 *=A0 @magn_orient:=A0=A0=A0=A0=A0=A0 magnetometer sensor chip orien=
tation if available.=0A=
=0A=
> + *=A0 @suspended_sensors:=A0=A0=A0=A0=A0 sensors mask of sensors turned =
off for suspend=0A=
=0A=
>=A0=A0 */=0A=
=0A=
>=A0 struct inv_mpu6050_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
=0A=
> @@ -174,7 +175,6 @@ struct inv_mpu6050_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 enum=A0=A0 inv_devices chip_type;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct i2c_mux_core *muxc;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct i2c_client *mux_client;=0A=
=0A=
> -=A0=A0=A0=A0 unsigned int powerup_count;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_platform_data plat_data;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix orientation;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct regmap *map;=0A=
=0A=
> @@ -189,6 +189,7 @@ struct inv_mpu6050_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 bool magn_disabled;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 s32 magn_raw_to_gauss[3];=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix magn_orient;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int suspended_sensors;=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /*register and associated bit definition*/=0A=
=0A=
> @@ -312,6 +313,7 @@ struct inv_mpu6050_state {=0A=
=0A=
>=A0 #define INV_MPU6050_ACCEL_UP_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20=
=0A=
=0A=
>=A0 #define INV_MPU6050_GYRO_UP_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3=
5=0A=
=0A=
>=A0 #define INV_MPU6050_GYRO_DOWN_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 150=
=0A=
=0A=
> +#define INV_MPU6050_SUSPEND_DELAY_MS=A0=A0=A0=A0=A0=A0=A0=A0 2000=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /* delay time in microseconds */=0A=
=0A=
>=A0 #define INV_MPU6050_REG_UP_TIME_MIN=A0=A0=A0=A0=A0=A0=A0=A0=A0 5000=0A=
=0A=
> @@ -439,7 +441,6 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state=
 *st, bool enable);=0A=
=0A=
>=A0 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 unsigned int mask);=0A=
=0A=
>=A0 int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 va=
l);=0A=
=0A=
> -int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_o=
n);=0A=
=0A=
Having done this, function should be marked static in _core.c=0A=
=0A=
=0A=
=0A=
I've done so.=0A=
=0A=
=0A=
=0A=
>=A0 int inv_mpu_acpi_create_mux_client(struct i2c_client *client);=0A=
=0A=
>=A0 void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);=0A=
=0A=
>=A0 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *nam=
e,=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_trigger.c=0A=
=0A=
> index f53f50d08b9e..f7b5a70be30f 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
=0A=
> @@ -3,6 +3,7 @@=0A=
=0A=
>=A0 * Copyright (C) 2012 Invensense, Inc.=0A=
=0A=
>=A0 */=0A=
=0A=
>=A0 =0A=
=0A=
> +#include <linux/pm_runtime.h>=0A=
=0A=
>=A0 #include "inv_mpu_iio.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)=
=0A=
=0A=
> @@ -156,41 +157,43 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_sta=
te *st, bool enable)=0A=
=0A=
>=A0 static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enab=
le)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev)=
;=0A=
=0A=
> +=A0=A0=A0=A0 struct device *pdev =3D regmap_get_device(st->map);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int scan;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 scan =3D inv_scan_query(indio_dev);=0A=
=0A=
> -=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (enable) {=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_it=
g(st, true);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scan =3D inv_scan_query(indio_dev);=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D pm_runtime_get_sync(pdev=
);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result < 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_=
put_noidle(pdev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retu=
rn result;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * In case autosuspend didn't tri=
gger, turn off first not=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * required sensors.=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, false, ~scan);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switc=
h_engine(st, true, scan);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 error_power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->skip_samples =3D inv_com=
pute_skip_samples(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_prepa=
re_fifo(st, true);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
sensors_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_prepa=
re_fifo(st, false);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
sensors_off;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, false, scan);=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_it=
g(st, false);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 error_power_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_mark_last_busy(pdev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
>=A0 =0A=
=0A=
> -error_sensors_off:=0A=
=0A=
> -=A0=A0=A0=A0 inv_mpu6050_switch_engine(st, false, scan);=0A=
=0A=
>=A0 error_power_off:=0A=
=0A=
> -=A0=A0=A0=A0 inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
poer=0A=
=0A=
