Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABFD162AE9
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 17:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRQor (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 11:44:47 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:33478 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgBRQor (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 11:44:47 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IGgaQC009993;
        Tue, 18 Feb 2020 08:44:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=cbOZ0PHyCrUhhPOY0TynrH2jBn3sgDPxF3PEKCiAFQ8=;
 b=uFsJBlPbp44tyRpH3tq1Y+LKBp9YJSGS/1l5ZpsRXDgTZcjBhNDvOlzL1lGtrQF7IgY/
 oMr1aSlqV6mnynGQ5GLM4pkqd8Agx8DuTyDGGkF01UOnkyqxn6HU3EtRufUqORdSHlm4
 8lwxpd75647yuJm1rqF9lEQIvBr0K5dAG+NCO2uwbs9VcEq/PyM/W9kxKwqml6xJkYm+
 lo/0rfTbGXnMmfGWN3gqwFCJwPeCTNiLYFqLjymqrQSh0Vz44YWjigYC2USq/B4/84aY
 KWdvi9x35bWec7O5YmEDqCU3O5iK3OJTDP81ctc/+4GXCkrapNoWRVu2DLqte/81lW9k pQ== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0b-00328301.pphosted.com with ESMTP id 2y6dfss929-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 08:44:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk6g2hzRWCfONcy0r04voqYfVJXx6/Aw3aGfyX8bb5yqM7L6+6wwNHqS8KKXsCJVEjYK4EuB5F9dX2UHd7Wi+BmagcD5Jm5VjObTjbxB+1ArbYz9YXtMdkuEUyoGWIzJBJ59ls6UBPbcaJvIA857toUHvVZxSCIIJKYiiZFvS98HtFhFXA7XREtXkofAJgJRLQ8tYnZyrWkypZhpIqMtAQJ0w+T7ynhIYMlVimm9l/iJR6MJO4PmDRkGrDmNHMSyre4n8I+HmtiKp/LYVnz7NMjEKv0S58XluLpp1ocajrYXrQmrZ4ocCGyRPhqZ/HK7sePbChAMFeffpUDZY/Duyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbOZ0PHyCrUhhPOY0TynrH2jBn3sgDPxF3PEKCiAFQ8=;
 b=KDTPaSgEaVkx8hRGR9bAAzttBmMusP1aIsotPlHpu1r8YrMdZOYgwsyN0+ldoniCWDNlb0aX4EPZSZDWyIsIPkA4CP35VycldvPTpCbzm0l/ZK7Itq1GTjkmOmtxeme8APVCpHwJiegosckfmrwBJqVGFiJ4rW95rMPHLz+8imKC/7o+SPSlUUYnka9pQ8UHPAKNYnH/W3cliFMEl4wKU7vx/nR12C8PRQyNZcS5sIL29/IaD1+RVhWgTSjMwLQWMhKJ78cBpTYH75ef0591Ek2enin6hVKN9lkWpkpANeiYwtpaQSgmVncU2pYIFbMEMNqVHCtEx3Ed/I3ZnSVuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbOZ0PHyCrUhhPOY0TynrH2jBn3sgDPxF3PEKCiAFQ8=;
 b=AWF5Mz5eMYBD+Kk4QX/kv9SPkIeoNFhJUmGlr3ANmOLn5bkS8v2Ub+8xNb4T/Cn3S+A8zs2rhO0zMuhOj4O2TM7e/5Wh6VhqEkITxXd/4yk/ayA8zgX1qW70h98APLCOn3k5m9p6RplQQuqppSpE+QqPU8q0ZH0wkwH2JOzqrTA=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3845.namprd12.prod.outlook.com (52.132.245.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Tue, 18 Feb 2020 16:44:37 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 16:44:36 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 12/13] iio: imu: inv_mpu6050: use runtime pm with
 autosuspend
Thread-Topic: [PATCH 12/13] iio: imu: inv_mpu6050: use runtime pm with
 autosuspend
Thread-Index: AQHV4cutUs8wTPGS+UORE+RafSJekagcliKAgASQUSI=
Date:   Tue, 18 Feb 2020 16:44:36 +0000
Message-ID: <CH2PR12MB418154CF0143B4DAC52E2C0DC4110@CH2PR12MB4181.namprd12.prod.outlook.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
        <20200212174048.1034-13-jmaneyrol@invensense.com>,<20200215182221.01f53e88@archlinux>
In-Reply-To: <20200215182221.01f53e88@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9b7673d-c9d7-4f84-6011-08d7b491d6fe
x-ms-traffictypediagnostic: CH2PR12MB3845:
x-microsoft-antispam-prvs: <CH2PR12MB384560644B008CE242EEFA3EC4110@CH2PR12MB3845.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(478600001)(30864003)(8676002)(81156014)(2906002)(71200400001)(33656002)(6506007)(8936002)(81166006)(4326008)(55016002)(53546011)(26005)(9686003)(5660300002)(7696005)(186003)(52536014)(86362001)(66946007)(6916009)(91956017)(76116006)(66476007)(66446008)(316002)(64756008)(66556008)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3845;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zzndLtoLFHgtoSMyEQ9bQp03L32AJBdnq1b21thh6fR+fofGatZ4V4se9rYbHRyRMRCZ8sXFnUh3q30U2XGMTSH7gtLIvGHEMCiEdEJXBGDoqb4TMnDTHBeRI1ErtVU5XJPgoyKlRe5TtnQCgYYs6jM6t4XlyUsJoMT7k6+8/MwbW1iNxnYzBo7AGrqfuppAtoUpZPha6lsujSr2Nh12Biui9UKP7R6GdYjmCf6ofWIJUn9Z9xN4o0lwjlwiQC6oeW7zCL3JWCcaqgod0zC8KGKt5VTvZVRW2jh7YblSUDrPhYFPuB/AJe10TGrkh+p45KBrXNIChCMd3A+f+0WjDD+uYSCxD3RglJoJJBz49NjbcShpdrZ516AegX7V8v5BAl0D7ern884ADMIO6hWI0iuwN45p4imAr73VqyFjtzblQqKNFE5zsAd58UMgE3AN
x-ms-exchange-antispam-messagedata: +Qe3JV4bdaE7QZVat6CzXRYdwU3FMYH41G4Bs/5ZF3/rrwtL6A8Mb0MGaVm7m0h4lOPu2PBr/hhAEJ+tpHo5ACcMeMDWMqBKxV1nQB8a/fOrmYTSsUFNIGFlfdQ4uVRwck6xxMhQG29ovuB+gIoaGQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b7673d-c9d7-4f84-6011-08d7b491d6fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 16:44:36.5048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmdd6P+TXCDbAxZUUFG1fOrLfG3OAUeJRGd7x83Ox9b345eSWbQ3WFtpH4+ByCyFt44mw6PaNaLuWxa4uXT8Hkwd1Anjar9L9vBace92sm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_04:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
responses are inline.=0A=
=0A=
Hope text formatting is better.=0A=
JB=0A=
=0A=
> From: Jonathan Cameron <jic23@kernel.org>=0A=
> Sent: Saturday, February 15, 2020 19:22=0A=
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
> Subject: Re: [PATCH 12/13] iio: imu: inv_mpu6050: use runtime pm with aut=
osuspend=0A=
> =A0=0A=
> =0A=
> On Wed, 12 Feb 2020 18:40:47 +0100=0A=
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
> =0A=
> > Use runtime power management for handling chip power and=0A=
> > sensor engines on/off. Simplifies things a lot since pm=0A=
> > runtime already has reference counter.=0A=
> > Usage of autosuspend reduces the number of power on/off. This=0A=
> > makes polling interface now usable to get data at low=0A=
> > frequency.=0A=
> > =0A=
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
> =0A=
> Looks good.=A0 A couple of questions / suggestions inline.=0A=
> =0A=
> > ---=0A=
> >=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0=A0=A0 | 265 ++++++++++=
++------=0A=
> >=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0=A0=A0=A0 |=A0=A0 5 +-=
=0A=
> >=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=A0 29 +-=0A=
> >=A0 3 files changed, 191 insertions(+), 108 deletions(-)=0A=
> > =0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c=0A=
> > index f33fd04671cc..f698d2aa61f4 100644=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> > @@ -16,6 +16,8 @@=0A=
> >=A0 #include <linux/acpi.h>=0A=
> >=A0 #include <linux/platform_device.h>=0A=
> >=A0 #include <linux/regulator/consumer.h>=0A=
> > +#include <linux/pm.h>=0A=
> > +#include <linux/pm_runtime.h>=0A=
> >=A0 #include "inv_mpu_iio.h"=0A=
> >=A0 #include "inv_mpu_magn.h"=0A=
> >=A0 =0A=
> > @@ -400,26 +402,13 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_=
state *st, bool power_on)=0A=
> >=A0 {=0A=
> >=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
> >=A0 =0A=
> > -=A0=A0=A0=A0 if (power_on) {=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->powerup_count) {=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =
=3D inv_mpu6050_pwr_mgmt_1_write(st, false, -1, -1);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (resul=
t)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 return result;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_ra=
nge(INV_MPU6050_REG_UP_TIME_MIN,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_REG_UP_TIME_MAX);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->powerup_count++;=0A=
> > -=A0=A0=A0=A0 } else {=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st->powerup_count =3D=3D 1) {=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =
=3D inv_mpu6050_pwr_mgmt_1_write(st, true, -1, -1);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (resul=
t)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 return result;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->powerup_count--;=0A=
> > -=A0=A0=A0=A0 }=0A=
> > +=A0=A0=A0=A0 result =3D inv_mpu6050_pwr_mgmt_1_write(st, !power_on, -1=
, -1);=0A=
> > +=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
> >=A0 =0A=
> > -=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map), "set power %d, count=
=3D%u\n",=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 power_on, st->powerup_count);=0A=
> > +=A0=A0=A0=A0 if (power_on)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(INV_MPU6050_REG_UP_T=
IME_MIN,=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 INV_MPU6050_REG_UP_TIME_MAX);=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> >=A0 }=0A=
> > @@ -563,6 +552,7 @@ static int inv_mpu6050_read_channel_data(struct iio=
_dev *indio_dev,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val)=0A=
> >=A0 {=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_de=
v);=0A=
> > +=A0=A0=A0=A0 struct device *pdev =3D regmap_get_device(st->map);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 unsigned int freq_hz, period_us, min_sleep_us, max=
_sleep_us;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> > @@ -571,92 +561,85 @@ static int inv_mpu6050_read_channel_data(struct i=
io_dev *indio_dev,=0A=
> >=A0=A0=A0=A0=A0=A0=A0 freq_hz =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->c=
hip_config.divider);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 period_us =3D 1000000 / freq_hz;=0A=
> >=A0 =0A=
> > -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);=0A=
> > -=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0 result =3D pm_runtime_get_sync(pdev);=0A=
> > +=A0=A0=A0=A0 if (result < 0) {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_noidle(pdev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
> > +=A0=A0=A0=A0 }=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 switch (chan->type) {=0A=
> >=A0=A0=A0=A0=A0=A0=A0 case IIO_ANGL_VEL:=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, true,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_GYRO);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need to wait 2 periods to have=
 first valid sample */=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D 2 * period_us;=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D 2 * (period_us +=
 period_us / 2);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_sl=
eep_us);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.gyro_en) {=
=0A=
> =0A=
> Are these changes due to runtime pm?=A0 Or do they make sense in general?=
=0A=
> =0A=
Yes, these changes are required for using efficiently the autosuspend featu=
re=0A=
of runtime pm. We want to sample the data without turning the sensor on/off=
=0A=
each time. So if the sensor engine is already turned on, just read the sens=
or=0A=
data register. Without autosuspend it doesn't make sense, since the sensor =
are=0A=
turned off as soon as the data is read.=0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =
=3D inv_mpu6050_switch_engine(st, true,=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_GYRO);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (resul=
t)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 goto error_power_off;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need t=
o wait 2 periods to have first valid sample */=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep=
_us =3D 2 * period_us;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep=
_us =3D 2 * (period_us + period_us / 2);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_ra=
nge(min_sleep_us, max_sleep_us);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor=
_show(st, st->reg->raw_gyro,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chan->chann=
el2, val);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, false,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_GYRO);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 case IIO_ACCEL:=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, true,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_ACCL);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1 period for first sample=
 availability */=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D period_us;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D period_us + peri=
od_us / 2;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_sl=
eep_us);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.accl_en) {=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =
=3D inv_mpu6050_switch_engine(st, true,=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_ACCL);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (resul=
t)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 goto error_power_off;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1=
 period for first sample availability */=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep=
_us =3D period_us;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep=
_us =3D period_us + period_us / 2;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_ra=
nge(min_sleep_us, max_sleep_us);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor=
_show(st, st->reg->raw_accl,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chan->chann=
el2, val);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, false,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_ACCL);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 case IIO_TEMP:=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, true,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_TEMP);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1 period for first sample=
 availability */=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D period_us;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D period_us + peri=
od_us / 2;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_sl=
eep_us);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.temp_en) {=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =
=3D inv_mpu6050_switch_engine(st, true,=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_TEMP);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (resul=
t)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 goto error_power_off;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1=
 period for first sample availability */=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep=
_us =3D period_us;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep=
_us =3D period_us + period_us / 2;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_ra=
nge(min_sleep_us, max_sleep_us);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor=
_show(st, st->reg->temperature,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IIO_MOD_X, =
val);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, false,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_TEMP);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 case IIO_MAGN:=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, true,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_MAGN);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* frequency is limited for magne=
tometer */=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (freq_hz > INV_MPU_MAGN_FREQ_H=
Z_MAX) {=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 freq_hz =
=3D INV_MPU_MAGN_FREQ_HZ_MAX;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_us=
 =3D 1000000 / freq_hz;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.magn_en) {=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =
=3D inv_mpu6050_switch_engine(st, true,=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_MAGN);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (resul=
t)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 goto error_power_off;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* freque=
ncy is limited for magnetometer */=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (freq_=
hz > INV_MPU_MAGN_FREQ_HZ_MAX) {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 freq_hz =3D INV_MPU_MAGN_FREQ_HZ_MAX;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 period_us =3D 1000000 / freq_hz;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need t=
o wait 2 periods to have first valid sample */=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep=
_us =3D 2 * period_us;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep=
_us =3D 2 * (period_us + period_us / 2);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_ra=
nge(min_sleep_us, max_sleep_us);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need to wait 2 periods to have=
 first valid sample */=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D 2 * period_us;=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D 2 * (period_us +=
 period_us / 2);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_sl=
eep_us);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu_magn_read(=
st, chan->channel2, val);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, false,=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_MAGN);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 default:=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0 =0A=
> > -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, false);=0A=
> > -=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_power_off;=0A=
> > +=A0=A0=A0=A0 pm_runtime_mark_last_busy(pdev);=0A=
> > +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> >=A0 =0A=
> >=A0 error_power_off:=0A=
> > -=A0=A0=A0=A0 inv_mpu6050_set_power_itg(st, false);=0A=
> > +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
> >=A0 }=0A=
> >=A0 =0A=
> > @@ -795,6 +778,7 @@ static int inv_mpu6050_write_raw(struct iio_dev *in=
dio_dev,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 int val, int val2, long mask)=0A=
> >=A0 {=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state=A0 *st =3D iio_priv(indio=
_dev);=0A=
> > +=A0=A0=A0=A0 struct device *pdev =3D regmap_get_device(st->map);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 /*=0A=
> > @@ -806,9 +790,11 @@ static int inv_mpu6050_write_raw(struct iio_dev *i=
ndio_dev,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> > -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);=0A=
> > -=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0 result =3D pm_runtime_get_sync(pdev);=0A=
> > +=A0=A0=A0=A0 if (result < 0) {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_noidle(pdev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_write_raw_unloc=
k;=0A=
> > +=A0=A0=A0=A0 }=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 switch (mask) {=0A=
> >=A0=A0=A0=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
> > @@ -846,7 +832,8 @@ static int inv_mpu6050_write_raw(struct iio_dev *in=
dio_dev,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0 =0A=
> > -=A0=A0=A0=A0 result |=3D inv_mpu6050_set_power_itg(st, false);=0A=
> > +=A0=A0=A0=A0 pm_runtime_mark_last_busy(pdev);=0A=
> > +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
> >=A0 error_write_raw_unlock:=0A=
> >=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indio_dev);=0A=
> > @@ -903,6 +890,7 @@ inv_mpu6050_fifo_rate_store(struct device *dev, str=
uct device_attribute *attr,=0A=
> >=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_de=
v);=0A=
> > +=A0=A0=A0=A0 struct device *pdev =3D regmap_get_device(st->map);=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (kstrtoint(buf, 10, &fifo_rate))=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> > @@ -920,9 +908,11 @@ inv_mpu6050_fifo_rate_store(struct device *dev, st=
ruct device_attribute *attr,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D 0;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto fifo_rate_fail_unlock=
;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);=0A=
> > -=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0 result =3D pm_runtime_get_sync(pdev);=0A=
> > +=A0=A0=A0=A0 if (result < 0) {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_noidle(pdev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto fifo_rate_fail_unlock=
;=0A=
> > +=A0=A0=A0=A0 }=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->sample_r=
ate_div, d);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > @@ -938,8 +928,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, str=
uct device_attribute *attr,=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto fifo_rate_fail_power_=
off;=0A=
> >=A0 =0A=
> > +=A0=A0=A0=A0 pm_runtime_mark_last_busy(pdev);=0A=
> >=A0 fifo_rate_fail_power_off:=0A=
> > -=A0=A0=A0=A0 result |=3D inv_mpu6050_set_power_itg(st, false);=0A=
> > +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
> >=A0 fifo_rate_fail_unlock:=0A=
> >=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > @@ -1385,6 +1376,14 @@ static void inv_mpu_core_disable_regulator_actio=
n(void *_data)=0A=
> >=A0=A0=A0=A0=A0=A0=A0 inv_mpu_core_disable_regulator_vddio(st);=0A=
> >=A0 }=0A=
> >=A0 =0A=
> > +static void inv_mpu_pm_disable(void *data)=0A=
> > +{=0A=
> > +=A0=A0=A0=A0 struct device *dev =3D data;=0A=
> > +=0A=
> > +=A0=A0=A0=A0 pm_runtime_put_sync_suspend(dev);=0A=
> > +=A0=A0=A0=A0 pm_runtime_disable(dev);=0A=
> > +}=0A=
> > +=0A=
> >=A0 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *n=
ame,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int (*inv_mpu_bus_setup)(s=
truct iio_dev *), int chip_type)=0A=
> >=A0 {=0A=
> > @@ -1409,7 +1408,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int=
 irq, const char *name,=0A=
> >=A0=A0=A0=A0=A0=A0=A0 st =3D iio_priv(indio_dev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 mutex_init(&st->lock);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 st->chip_type =3D chip_type;=0A=
> > -=A0=A0=A0=A0 st->powerup_count =3D 0;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 st->irq =3D irq;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 st->map =3D regmap;=0A=
> >=A0 =0A=
> > @@ -1521,8 +1519,16 @@ int inv_mpu_core_probe(struct regmap *regmap, in=
t irq, const char *name,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 go=
to error_power_off;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0 =0A=
> > -=A0=A0=A0=A0 /* chip init is done, turning off */=0A=
> > -=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, false);=0A=
> > +=A0=A0=A0=A0 /* chip init is done, turning on runtime power management=
 */=0A=
> > +=A0=A0=A0=A0 result =3D pm_runtime_set_active(dev);=0A=
> > +=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_power_off;=0A=
> > +=A0=A0=A0=A0 pm_runtime_get_noresume(dev);=0A=
> > +=A0=A0=A0=A0 pm_runtime_enable(dev);=0A=
> > +=A0=A0=A0=A0 pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND=
_DELAY_MS);=0A=
> > +=A0=A0=A0=A0 pm_runtime_use_autosuspend(dev);=0A=
> > +=A0=A0=A0=A0 pm_runtime_put(dev);=0A=
> > +=A0=A0=A0=A0 result =3D devm_add_action_or_reset(dev, inv_mpu_pm_disab=
le, dev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
> >=A0 =0A=
> > @@ -1594,36 +1600,113 @@ EXPORT_SYMBOL_GPL(inv_mpu_core_probe);=0A=
> >=A0 =0A=
> >=A0 static int inv_mpu_resume(struct device *dev)=0A=
> >=A0 {=0A=
> > -=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata=
(dev));=0A=
> > +=A0=A0=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);=0A=
> > +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> > +=0A=
> >=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu_core_enable_regulator_vddio(st)=
;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);=0A=
> > +=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> > +=0A=
> > +=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engine(st, true, st->suspen=
ded_sensors);=0A=
> > +=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> > +=0A=
> > +=A0=A0=A0=A0 if (iio_buffer_enabled(indio_dev))=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_prepare_fi=
fo(st, true);=0A=
> > +=0A=
> >=A0 out_unlock:=0A=
> >=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> > -=0A=
> =0A=
> Not keen on random white space tweaks in a complex patch like this.=0A=
> =0A=
Oups, will be deleted in v2.=0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
> >=A0 }=0A=
> >=A0 =0A=
> >=A0 static int inv_mpu_suspend(struct device *dev)=0A=
> >=A0 {=0A=
> > -=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata=
(dev));=0A=
> > +=A0=A0=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);=0A=
> > +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> > +=0A=
> > +=A0=A0=A0=A0 if (iio_buffer_enabled(indio_dev)) {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_prepare_fi=
fo(st, false);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> > +=A0=A0=A0=A0 }=0A=
> > +=0A=
> > +=A0=A0=A0=A0 st->suspended_sensors =3D 0;=0A=
> > +=A0=A0=A0=A0 if (st->chip_config.accl_en)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended_sensors |=3D INV_MP=
U6050_SENSOR_ACCL;=0A=
> > +=A0=A0=A0=A0 if (st->chip_config.gyro_en)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended_sensors |=3D INV_MP=
U6050_SENSOR_GYRO;=0A=
> > +=A0=A0=A0=A0 if (st->chip_config.temp_en)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended_sensors |=3D INV_MP=
U6050_SENSOR_TEMP;=0A=
> > +=A0=A0=A0=A0 if (st->chip_config.magn_en)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended_sensors |=3D INV_MP=
U6050_SENSOR_MAGN;=0A=
> > +=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engine(st, false, st->suspe=
nded_sensors);=0A=
> > +=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> > +=0A=
> >=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, false);=
=0A=
> > +=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> > +=0A=
> >=A0=A0=A0=A0=A0=A0=A0 inv_mpu_core_disable_regulator_vddio(st);=0A=
> > -=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> >=A0 =0A=
> > +out_unlock:=0A=
> > +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
> >=A0 }=0A=
> >=A0 #endif /* CONFIG_PM_SLEEP */=0A=
> >=A0 =0A=
> > -SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);=0A=
> > +#ifdef CONFIG_PM=0A=
> =0A=
> Preferred to avoid the ifdef fun and mark the functions __maybe_unused=0A=
> instead.=A0 Avoids weird build issues that tend to happen around the=0A=
> CONFIG_PM options.=A0 Same for the CONFIG_PM_SLEEP cases above.=0A=
> Note this preference has changed over the years since this driver=0A=
> was introduced so entirely reasonable that we might want to update=0A=
> this now.=0A=
> =0A=
No problem. Will be fixed in v2.=0A=
=0A=
> > +static int inv_mpu_runtime_suspend(struct device *dev)=0A=
> > +{=0A=
> > +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata=
(dev));=0A=
> > +=A0=A0=A0=A0 unsigned int sensors;=0A=
> > +=A0=A0=A0=A0 int ret;=0A=
> > +=0A=
> > +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> > +=0A=
> > +=A0=A0=A0=A0 sensors =3D INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_=
GYRO |=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU60=
50_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN;=0A=
> > +=A0=A0=A0=A0 ret =3D inv_mpu6050_switch_engine(st, false, sensors);=0A=
> > +=A0=A0=A0=A0 if (ret)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> > +=0A=
> > +=A0=A0=A0=A0 ret =3D inv_mpu6050_set_power_itg(st, false);=0A=
> > +=A0=A0=A0=A0 if (ret)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> > +=0A=
> > +=A0=A0=A0=A0 inv_mpu_core_disable_regulator_vddio(st);=0A=
> > +=0A=
> > +out_unlock:=0A=
> > +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> > +=A0=A0=A0=A0 return ret;=0A=
> > +}=0A=
> > +=0A=
> > +static int inv_mpu_runtime_resume(struct device *dev)=0A=
> > +{=0A=
> > +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata=
(dev));=0A=
> > +=A0=A0=A0=A0 int ret;=0A=
> > +=0A=
> > +=A0=A0=A0=A0 ret =3D inv_mpu_core_enable_regulator_vddio(st);=0A=
> > +=A0=A0=A0=A0 if (ret)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> > +=0A=
> > +=A0=A0=A0=A0 return inv_mpu6050_set_power_itg(st, true);=0A=
> > +}=0A=
> > +#endif=0A=
> > +=0A=
> > +const struct dev_pm_ops inv_mpu_pmops =3D {=0A=
> > +=A0=A0=A0=A0 SET_SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume)=
=0A=
> > +=A0=A0=A0=A0 SET_RUNTIME_PM_OPS(inv_mpu_runtime_suspend, inv_mpu_runti=
me_resume, NULL)=0A=
> > +};=0A=
> >=A0 EXPORT_SYMBOL_GPL(inv_mpu_pmops);=0A=
> >=A0 =0A=
> >=A0 MODULE_AUTHOR("Invensense Corporation");=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h=0A=
> > index e328c98e362c..cd38b3fccc7b 100644=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> > @@ -164,6 +164,7 @@ struct inv_mpu6050_hw {=0A=
> >=A0=A0 *=A0 @magn_disabled:=A0=A0=A0=A0 magnetometer disabled for backwa=
rd compatibility reason.=0A=
> >=A0=A0 *=A0 @magn_raw_to_gauss:=A0=A0=A0=A0=A0 coefficient to convert ma=
g raw value to Gauss.=0A=
> >=A0=A0 *=A0 @magn_orient:=A0=A0=A0=A0=A0=A0 magnetometer sensor chip ori=
entation if available.=0A=
> > + *=A0 @suspended_sensors:=A0=A0=A0=A0=A0 sensors mask of sensors turne=
d off for suspend=0A=
> >=A0=A0 */=0A=
> >=A0 struct inv_mpu6050_state {=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
> > @@ -174,7 +175,6 @@ struct inv_mpu6050_state {=0A=
> >=A0=A0=A0=A0=A0=A0=A0 enum=A0=A0 inv_devices chip_type;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct i2c_mux_core *muxc;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct i2c_client *mux_client;=0A=
> > -=A0=A0=A0=A0 unsigned int powerup_count;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_platform_data plat_data;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix orientation;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct regmap *map;=0A=
> > @@ -189,6 +189,7 @@ struct inv_mpu6050_state {=0A=
> >=A0=A0=A0=A0=A0=A0=A0 bool magn_disabled;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 s32 magn_raw_to_gauss[3];=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix magn_orient;=0A=
> > +=A0=A0=A0=A0 unsigned int suspended_sensors;=0A=
> >=A0 };=0A=
> >=A0 =0A=
> >=A0 /*register and associated bit definition*/=0A=
> > @@ -312,6 +313,7 @@ struct inv_mpu6050_state {=0A=
> >=A0 #define INV_MPU6050_ACCEL_UP_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=
0=0A=
> >=A0 #define INV_MPU6050_GYRO_UP_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 35=0A=
> >=A0 #define INV_MPU6050_GYRO_DOWN_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 150=
=0A=
> > +#define INV_MPU6050_SUSPEND_DELAY_MS=A0=A0=A0=A0=A0=A0=A0=A0 2000=0A=
> >=A0 =0A=
> >=A0 /* delay time in microseconds */=0A=
> >=A0 #define INV_MPU6050_REG_UP_TIME_MIN=A0=A0=A0=A0=A0=A0=A0=A0=A0 5000=
=0A=
> > @@ -439,7 +441,6 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_sta=
te *st, bool enable);=0A=
> >=A0 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 unsigned int mask);=0A=
> >=A0 int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 =
val);=0A=
> > -int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power=
_on);=0A=
> >=A0 int inv_mpu_acpi_create_mux_client(struct i2c_client *client);=0A=
> >=A0 void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);=0A=
> >=A0 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *n=
ame,=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> > index f53f50d08b9e..9eab39042443 100644=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> > @@ -3,6 +3,7 @@=0A=
> >=A0 * Copyright (C) 2012 Invensense, Inc.=0A=
> >=A0 */=0A=
> >=A0 =0A=
> > +#include <linux/pm_runtime.h>=0A=
> >=A0 #include "inv_mpu_iio.h"=0A=
> >=A0 =0A=
> >=A0 static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev=
)=0A=
> > @@ -156,41 +157,39 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_s=
tate *st, bool enable)=0A=
> >=A0 static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool en=
able)=0A=
> >=A0 {=0A=
> >=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_de=
v);=0A=
> > +=A0=A0=A0=A0 struct device *pdev =3D regmap_get_device(st->map);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 unsigned int scan;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
> >=A0 =0A=
> > -=A0=A0=A0=A0 scan =3D inv_scan_query(indio_dev);=0A=
> > -=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (enable) {=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_=
itg(st, true);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scan =3D inv_scan_query(indio_dev=
);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D pm_runtime_get_sync(pd=
ev);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result < 0) {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtim=
e_put_noidle(pdev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn result;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, false, ~scan);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> =0A=
> I'd like a comment on this block.=A0 I guess this off / on sequence is=0A=
> now necessary as we were previously relying on the power having been=0A=
> turned off?=0A=
> =0A=
Good guess. We need now to turn off sensor that we don't need in case=0A=
autosuspend didn't trigger. Will add a comment in v2.=0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_swi=
tch_engine(st, true, scan);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 go=
to error_power_off;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->skip_samples =3D inv_c=
ompute_skip_samples(st);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_pre=
pare_fifo(st, true);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_sensors_off;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_pre=
pare_fifo(st, false);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_sensors_off;=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_eng=
ine(st, false, scan);=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto erro=
r_power_off;=0A=
> > -=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_=
itg(st, false);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 go=
to error_power_off;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_mark_last_busy(pdev);=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0 =0A=
> >=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> >=A0 =0A=
> > -error_sensors_off:=0A=
> > -=A0=A0=A0=A0 inv_mpu6050_switch_engine(st, false, scan);=0A=
> >=A0 error_power_off:=0A=
> > -=A0=A0=A0=A0 inv_mpu6050_set_power_itg(st, false);=0A=
> > +=A0=A0=A0=A0 pm_runtime_put_autosuspend(pdev);=0A=
> >=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
> >=A0 }=0A=
> >=A0 =0A=
