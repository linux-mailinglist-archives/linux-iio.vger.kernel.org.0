Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C953AE644
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jun 2021 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFUJma (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Jun 2021 05:42:30 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:40576 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbhFUJm3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jun 2021 05:42:29 -0400
X-Greylist: delayed 1421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 05:42:29 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 15L7VWkR020900
        for <linux-iio@vger.kernel.org>; Mon, 21 Jun 2021 02:16:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=eOiaBRTDGMlSHrJS4HvOiEp/Qc/6smAk0bjssdLgsEo=;
 b=D9ZRo0q4fPsP+/hOQBu/cAVH5aeilPHXRoA2Fs+EZoRnxAUUHQX/mkMInNUYanIkigOr
 ivgc2sViqqTMciDfIfqRLMXUze1GG5O4XeWk0qO1+eSzjNWrlqibfElYobLdag7knPfa
 OMv4Z0lBE6Dzu4WGoR9lzuBHU2p9gKjKxKJ7WBJ1OIPlMD648sC4EIeFmR4DkrWGon75
 +vsEYwZEglfSjYXqqnxGGIhGQPnCLjE2WQeFeLJPx7aOcOw3WyVnzxvxO5KJx2z0lpGh
 iPaK1Ns2/SxU+NvLtQF8sFo7t5+qMEK6j569Esyll1oBpTBudC692ILTX9dAkSJZjHhk Gg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-00328301.pphosted.com with ESMTP id 39a8ky0amk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 21 Jun 2021 02:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+A2fG1BN5AKO1MPGosYjgHT7eNJHDPsHUnjKNfRpeKlT8mSUPcfwugIEfZYqMtMOeIJa5aTSHRVDT56/VlF+FAJ9xcPgaddCtyulCMvJppE8WSu0XaU3rXTp4ktEeqFa3s1XWGH7b+YFgqeirRwtJvPi2TVb2T2KUegL4sIMe6WSod8DhgIdBiFV5XNrR2TJW6TqCa6ow1kUFtjyQPwVmXP0obWYsqLWNBEqTzyIJqcN+SDi0em/lUhjYbTCjF+yzDnuzZwYPFMA3caDy4jprFgBTvyPlA9kaMVXoSNkqJ4Y9zGJ3UvRbRtTeOJvkefe8pcIHSacvTLhXE7IcxHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOiaBRTDGMlSHrJS4HvOiEp/Qc/6smAk0bjssdLgsEo=;
 b=KOKxVry61Cw/O8gjGCmAovMJP2wzxCp/uZ5Xu5ibtFtpeq7AMilKZWiV4NLtsDHLJIh/YCDmxqtZjY4aVhd5zqKaa5QdIQhNpvEY0Fq3a77qC1U3MVGxPn1Mj19shzNq6cvmFbDf1FsjhU8tldxvdC5GAhVs0bq/xzHtd1AhPVJyDObgPX1xaV53lkzcrWeIQwqSanlWLGOzyBp+EedG7CyzyQ+b1FM3mQGC62LICQidwSoRkzi0cUvnt63GPzqRKEp3seMilzSMzvigg7weKc0TKCmjOR2yATzKEmrzjM0C2jIhA4sGUFrqCruUYEY2iprk+4IgnYqUQm4eOL8UJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOiaBRTDGMlSHrJS4HvOiEp/Qc/6smAk0bjssdLgsEo=;
 b=GbLTpQjEHejtMlD9osdAinEt7bbYk4Bxm75Mw1ehwqsERU3RH/mGD+tIivBKoxraw71mXULdo7aErVc5wzrrZnpo1ifdQ5cQfO0OVJ0YyMBUlOROEbkRgdyYuXasZnxColCSHHvWMptDel6hWxCNgrXcUgqQ1sBIIrbIKpJuQ+I=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Mon, 21 Jun
 2021 09:16:30 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::5953:549d:1a81:8afc]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::5953:549d:1a81:8afc%2]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 09:16:30 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Baptiste Mansuy <bmansuy@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: --[[SPOOF or PHISHING]]--[PATCH] Add startup time for each chip
 using inv_mpu6050 driver
Thread-Topic: --[[SPOOF or PHISHING]]--[PATCH] Add startup time for each chip
 using inv_mpu6050 driver
Thread-Index: AQHXZn1EofjUMbukf0in+zSDH/q2naseLqJp
Date:   Mon, 21 Jun 2021 09:16:30 +0000
Message-ID: <BL0PR12MB5011C3AAC67AF825FAA86857C40A9@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210621085731.9212-1-bmansuy@invensense.com>
In-Reply-To: <20210621085731.9212-1-bmansuy@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: invensense.com; dkim=none (message not signed)
 header.d=none;invensense.com; dmarc=none action=none
 header.from=invensense.com;
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13f05a0d-903e-4677-45ce-08d9349541c3
x-ms-traffictypediagnostic: MN2PR12MB4079:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40792ED7DF3150236625A868C40A9@MN2PR12MB4079.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /r9EIYOIyUunUfF4lLTQ7IeaXzBLuZKrbIwcYRpQDdKSG6erO3Hy+hs6+aCEjp3eG1uI8L5V3Uh7Jn6aGHp5JvT+LYXY/YugrcBCfLa0u5/LONStvheYGLUnvWVy/c7iUK+weAPI8Cuw15e/OBTb065vYyV+YseYmYSPbcYFwV3uF67dZNQHFoOIVMwjkTVQHKg4S4QmXNRrr2/fV1wuEykMvIQOo7HJUvngpgdHET7sl2B8vC781f0ebNjObpJgtRziSdSkTzzQlrH9sKHpaBwR6Vt+acQr2gY9TuVqBmC5VddL0PZDyl4mlCKVEDj+N8/23pDJLLGghv4KNLTHDDzyGkCrdxokUcu1Dai2RUZ3VSmAN5Oos6I/OXKb81p3EfaIuOo1IK3lXKdthdmU6ClNaChZq/+XCmNxXK6OBhJn1UjYQh2d9aat9sbcuywjvVYTv07QX5dp10lBT+5pQUWa8po4Lnm7ImT5VxuZbbNKNfv4JFZGkf5YVe8FcfTbQm4Ii40GR109WNb1DogmHs2x6fFCmyOv0Cb5WuhbEpm0/m+UftGtpamexcwD1B997bky+JxPEnlJSrtwkqmXvjm7rM+2CnR1i7P5DdLAeGo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39850400004)(83380400001)(86362001)(478600001)(71200400001)(110136005)(2906002)(8936002)(186003)(316002)(8676002)(26005)(55016002)(9686003)(52536014)(66476007)(66556008)(66446008)(76116006)(91956017)(66946007)(53546011)(7696005)(6506007)(64756008)(33656002)(5660300002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T/Vi3AjpJJG1MMFFRd7q9+37xaEImcjic8CsNw5USOWV+nWohDQRN9txoX?=
 =?iso-8859-1?Q?0xc9Mte8RQhTqiTw9xw2uZgPdMFoR4rrVW+adiRaTcSX2EOeXpc7TFhsv1?=
 =?iso-8859-1?Q?CURusNXWUf/6dbZRwmW6d9hLL4O8rrKZh5fwNUhM6ot3BjYOdSj0Yqoa6H?=
 =?iso-8859-1?Q?3t0mx34/X685A/VE1juSAjacNLP/MJfU8e0idRHVTEiejwGzCk/pI3s32i?=
 =?iso-8859-1?Q?etWYsbAAwBYDOECfdumundOIStlYblHpENwVI3QFAp8D4oi4FjQe4LAGab?=
 =?iso-8859-1?Q?D8Ty3was7RSo6dPHXHBV+L7vtNQiev05SRkc8sreIJgPAagHTvvVgdtEL6?=
 =?iso-8859-1?Q?CgEZ2tCe3bZx0C94tDyxs6T2oGiog7UodxSLkwMsZumMNdhZQyMM4EQT96?=
 =?iso-8859-1?Q?bVlfoGi21C04BY6CLukO/TegbsowMAmitsAgwdGuryO7l7VrekaNh1asVx?=
 =?iso-8859-1?Q?QaF1ydJXakXoEo/xOqSHJvt047f4LBlwtKM4aJggg9CVdnSHaapkxwz2i0?=
 =?iso-8859-1?Q?ih9xqwIJK9aR6jthjGO50UGD8FMzlJDVB++UMwOnlOd7dgbHmKp/zlDsK9?=
 =?iso-8859-1?Q?h+W7IJlScQe6urf28WqttVYYODoM+FOvPV3x54nUx1MC2f+YQkiHfPK8sY?=
 =?iso-8859-1?Q?3sBBcw9azKly0O4wfIX0J47xbHDCzntxDcHNFO6nYXJQJRTprBTNzLJBQ2?=
 =?iso-8859-1?Q?OLbzFc39FKvyRGrcNjFQ5TsFSnITUwu3nyNyeCXS2QUr7ZZdJPzAyjjgcs?=
 =?iso-8859-1?Q?idKNEm/mb4cwmcrk/fx14YNlihStp80fXhcYYvY2zTtPMWY1Lcv13FETtq?=
 =?iso-8859-1?Q?vpN1bnMOCuNVnkpSboTAmp1MOCZhGHvXdXRMOfNWJxEiGPgV1tpkWauSCz?=
 =?iso-8859-1?Q?ZCn0mklc3LtM5ff2zsejra2dMQeR8/s0KKxZB2fo4uTc1GurmMYuCVv3QC?=
 =?iso-8859-1?Q?BeZZppTxRMkShn0XM0kfJdPf25s423PV8pm/mSX+jH6e8gSlpkAp5HliS5?=
 =?iso-8859-1?Q?aOUcb82lVC5GLbBi6vpwk+wcVXl5mYW2ZBbk8d7Keib9W2QcyxnRDiXBGV?=
 =?iso-8859-1?Q?tvqBzT2YOhWmgzVWN5qEHA4da8RBEqT487BPzi81QFZfxwA0doeB68nk9s?=
 =?iso-8859-1?Q?cSuVHhOEfc2lvdxTJ4WwtTq14pB4zzlhmO5iTnaW0oLEvJcnuNxbm3oT80?=
 =?iso-8859-1?Q?ItMX42s+zdFtMjKPJDOOuHvan68IyzfUqvXcvzc4dUYOHw24HUrLYrvWDp?=
 =?iso-8859-1?Q?2dhogK48qDgBYdCm7dHkWEfLJVu5xKODjAkie4PEUUj95WMJus1O14EgDp?=
 =?iso-8859-1?Q?ZCU7WtOCGQX5BdH92N2FMKOqQJC524z1/I5Zevky5HnqQAI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f05a0d-903e-4677-45ce-08d9349541c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 09:16:30.6678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwwJlKAsXLHvY1niagatemEBnPZurIEB+TwjS5kMjG89EiDYBK/XmXFDFQJBXyT1vB8Icv404VB8VF/nRLOaX9gic9R+PYOUkTNIcqdndEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
X-Proofpoint-ORIG-GUID: 7ZJKhhUTYJtR_3_fgOYKIVNo5gqT0p3C
X-Proofpoint-GUID: 7ZJKhhUTYJtR_3_fgOYKIVNo5gqT0p3C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.136,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-06-21_03,2021-06-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
looks good for me, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: Baptiste Mansuy <bmansuy@invensense.com>=0A=
Sent: Monday, June 21, 2021 10:57=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc: Baptiste Mansuy <bmansuy@invensense.com>=0A=
Subject: --[[SPOOF or PHISHING]]--[PATCH] Add startup time for each chip us=
ing inv_mpu6050 driver =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
Add startup time for each chip familly. This allows a better behaviour of =
=0A=
the gyro and the accel. The gyro has now the time to stabilise itself =0A=
thus making initial data discarding for gyro irrelevant.=0A=
=0A=
Signed-off-by: Baptiste Mansuy <bmansuy@invensense.com>=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0=A0=A0 | 22 +++++++++++++++=
----=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0=A0=A0=A0 | 18 +++++++++++++=
--=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 15 ++-----------=0A=
=A03 files changed, 36 insertions(+), 19 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 6244a07048df..50be32b60f19 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -143,6 +143,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
050,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 1024,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6050_TEM=
P_OFFSET, INV_MPU6050_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6050_=
GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_MPU6500_WH=
OAMI_VALUE,=0A=
@@ -151,6 +152,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 512,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6500_TEM=
P_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_MPU6515_WH=
OAMI_VALUE,=0A=
@@ -159,6 +161,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 512,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6500_TEM=
P_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_MPU6880_WH=
OAMI_VALUE,=0A=
@@ -167,6 +170,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 4096,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6500_TEM=
P_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_MPU6000_WH=
OAMI_VALUE,=0A=
@@ -175,6 +179,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
050,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 1024,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6050_TEM=
P_OFFSET, INV_MPU6050_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6050_=
GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_MPU9150_WH=
OAMI_VALUE,=0A=
@@ -183,6 +188,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
050,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 1024,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6050_TEM=
P_OFFSET, INV_MPU6050_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6050_=
GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_MPU9250_WH=
OAMI_VALUE,=0A=
@@ -191,6 +197,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 512,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6500_TEM=
P_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_MPU9255_WH=
OAMI_VALUE,=0A=
@@ -199,6 +206,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 512,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6500_TEM=
P_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20608_W=
HOAMI_VALUE,=0A=
@@ -207,6 +215,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 512,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TE=
MP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20609_W=
HOAMI_VALUE,=0A=
@@ -215,6 +224,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 4 * 1024,=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TE=
MP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20689_W=
HOAMI_VALUE,=0A=
@@ -223,6 +233,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 4 * 1024,=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TE=
MP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20602_W=
HOAMI_VALUE,=0A=
@@ -231,6 +242,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 1008,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TE=
MP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_ICM20602=
_GYRO_STARTUP_TIME, INV_ICM20602_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20690_W=
HOAMI_VALUE,=0A=
@@ -239,6 +251,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 1024,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TE=
MP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_ICM20690=
_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_IAM20680_W=
HOAMI_VALUE,=0A=
@@ -247,6 +260,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6=
500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 512,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TE=
MP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0};=0A=
=A0=0A=
@@ -379,12 +393,12 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_stat=
e *st, bool en,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D 0;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (en) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
 (mask & INV_MPU6050_SENSOR_ACCL) {=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if (sleep < INV_MPU6050_ACCEL_UP_TIME)=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D INV_MPU6050_ACCEL_UP_T=
IME;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if (sleep < st->hw->startup_time.accel)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D st->hw->startup_time.a=
ccel;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
 (mask & INV_MPU6050_SENSOR_GYRO) {=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if (sleep < INV_MPU6050_GYRO_UP_TIME)=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D INV_MPU6050_GYRO_UP_TI=
ME;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if (sleep < st->hw->startup_time.gyro)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D st->hw->startup_time.g=
yro;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
 (mask & INV_MPU6050_SENSOR_GYRO) {=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index 58188dc0dd13..c6aa36ee966a 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -149,6 +149,10 @@ struct inv_mpu6050_hw {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int offset;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int scale;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 } temp;=0A=
+=A0=A0=A0=A0=A0=A0 struct {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int accel;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int gyro;=0A=
+=A0=A0=A0=A0=A0=A0 } startup_time;=0A=
=A0};=0A=
=A0=0A=
=A0/*=0A=
@@ -320,11 +324,21 @@ struct inv_mpu6050_state {=0A=
=A0/* delay time in milliseconds */=0A=
=A0#define INV_MPU6050_POWER_UP_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 100=
=0A=
=A0#define INV_MPU6050_TEMP_UP_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 100=
=0A=
-#define INV_MPU6050_ACCEL_UP_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20=0A=
-#define INV_MPU6050_GYRO_UP_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 35=0A=
+#define INV_MPU6050_ACCEL_STARTUP_TIME=A0=A0=A0=A0=A0=A0 20=0A=
+#define INV_MPU6050_GYRO_STARTUP_TIME=A0=A0=A0=A0=A0=A0=A0 60=0A=
=A0#define INV_MPU6050_GYRO_DOWN_TIME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 150=0A=
=A0#define INV_MPU6050_SUSPEND_DELAY_MS=A0=A0=A0=A0=A0=A0=A0=A0 2000=0A=
=A0=0A=
+#define INV_MPU6500_GYRO_STARTUP_TIME=A0=A0=A0=A0=A0=A0=A0 70=0A=
+#define INV_MPU6500_ACCEL_STARTUP_TIME=A0=A0=A0=A0=A0=A0 30=0A=
+=0A=
+#define INV_ICM20602_GYRO_STARTUP_TIME=A0=A0=A0=A0=A0=A0 100=0A=
+#define INV_ICM20602_ACCEL_STARTUP_TIME=A0=A0=A0=A0=A0 20=0A=
+=0A=
+#define INV_ICM20690_GYRO_STARTUP_TIME=A0=A0=A0=A0=A0=A0 80=0A=
+#define INV_ICM20690_ACCEL_STARTUP_TIME=A0=A0=A0=A0=A0 10=0A=
+=0A=
+=0A=
=A0/* delay time in microseconds */=0A=
=A0#define INV_MPU6050_REG_UP_TIME_MIN=A0=A0=A0=A0=A0=A0=A0=A0=A0 5000=0A=
=A0#define INV_MPU6050_REG_UP_TIME_MAX=A0=A0=A0=A0=A0=A0=A0=A0=A0 10000=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_trigger.c=0A=
index e21ba778595a..28416a09c462 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
@@ -91,22 +91,11 @@ static unsigned int inv_scan_query(struct iio_dev *indi=
o_dev)=0A=
=A0=0A=
=A0static unsigned int inv_compute_skip_samples(const struct inv_mpu6050_st=
ate *st)=0A=
=A0{=0A=
-=A0=A0=A0=A0=A0=A0 unsigned int gyro_skip =3D 0;=0A=
-=A0=A0=A0=A0=A0=A0 unsigned int magn_skip =3D 0;=0A=
-=A0=A0=A0=A0=A0=A0 unsigned int skip_samples;=0A=
-=0A=
-=A0=A0=A0=A0=A0=A0 /* gyro first sample is out of specs, skip it */=0A=
-=A0=A0=A0=A0=A0=A0 if (st->chip_config.gyro_fifo_enable)=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gyro_skip =3D 1;=0A=
+=A0=A0=A0=A0=A0=A0 unsigned int skip_samples =3D 0;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /* mag first sample is always not ready, skip it *=
/=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.magn_fifo_enable)=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 magn_skip =3D 1;=0A=
-=0A=
-=A0=A0=A0=A0=A0=A0 /* compute first samples to skip */=0A=
-=A0=A0=A0=A0=A0=A0 skip_samples =3D gyro_skip;=0A=
-=A0=A0=A0=A0=A0=A0 if (magn_skip > skip_samples)=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 skip_samples =3D magn_skip;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 skip_samples =3D 1;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return skip_samples;=0A=
=A0}=0A=
-- =0A=
2.25.1=0A=
