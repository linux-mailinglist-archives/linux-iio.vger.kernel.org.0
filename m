Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC54115CF
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhITNbB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 09:31:01 -0400
Received: from mx0a-00549402.pphosted.com ([205.220.166.134]:31016 "EHLO
        mx0a-00549402.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235230AbhITNbA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 09:31:00 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 09:31:00 EDT
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 18KDLZV3011780;
        Mon, 20 Sep 2021 13:21:35 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2170.outbound.protection.outlook.com [104.47.11.170])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3b56fx8p9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 13:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkOnXJHdZuLstvetO6Y2af0J2DxMRdOqT5noXyUrdqvGH3g/ydByYHyOkwwyenJKidBKRxEpQt2DvtZH3MAffJRKlqzm7ayMRJ3o3lXTmIpKNycOxAmPDAeHh/xEx0Oi6HnGllz0TAsqOAKz6i88FvFskP8j4DgpT6BlfAFmAHF5S0h37m6Sq8fSyja9md9Nkp1gY6pYHuvdAyBS8IBJDEtIK0vDrjJy2tIwhym2xog5KZE3Lm+4mKJ7IYqVzfdW+anD1sUTGLCeA2e/Fs+RjwsLMmj27csetW5hEJ69A3VCZXjgXmUwygeWAQzhmhGsMoHyF5uXbyyen1RtUCsRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=41DQLg4neArn3ffgwmYWYjuzFg/YYdfrjlBCuC0WhvY=;
 b=LG7hU7KLBFAZ+Xf41CFyX7r9MXmKRkAjORBUvlrOh0MDhUk7ZyY7z4SR9M5Zr7dPY15MVEaUwr8YSDlFBFwi1MJE+liMXYCbCC5C7qvLtK0mJimedc1KNiVmnSLqMpD1vqBllzjeA1PiW0ZVhYcCyTmBn0mdsf65dQNGBG/sX9ifqIYBOG7UdjmbV2w82ueKbko2oML6r3gOK0t0wZKfUweghGmCLjJ5NFQ75FABlXm7UhhyEl0tkDCg2e+Mp2U7XxKx1Ll1YkCITUinBOBRIYxyjRm88O52ewwNoNTB0eM5vgzBMnBVJFuo+nQgwn0vnYCGHVd+0/K3ScKXYNO6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41DQLg4neArn3ffgwmYWYjuzFg/YYdfrjlBCuC0WhvY=;
 b=eZva9wo5VjPxiY1N10NrRA9CH9nx8et3Sboh/N5mR2IvFjTzE/boZSngfFD60ypclEZor46r4INV5/NC2HMBVJwMteCrszitp3AyiDul1RrKUAKkI5UrDu7f0bvqdSBveQYwMbojmvJBvWluytrEZ4ggrDHaBhSPKL2i7qSnTUMlRfQSLsHGSTxzxkwRiEOTAY4kApg/+9sTQAF4lCBgxP8i17wnb1teDshVGJRX4JnbwPuf+8PyzMMgLwuiKxI7fCLXb17RNGRr+pBzGTVkjPVG2zgWt9++OPqHGg5Vkg4lb1AAaRD2Z0i7YgufQs4X8MwI+s3EAbBRxViJrV6ocA==
Received: from FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:34::10)
 by FR0P281MB0445.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.10; Mon, 20 Sep
 2021 13:21:32 +0000
Received: from FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac14:2d90:3df8:3694]) by FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac14:2d90:3df8:3694%5]) with mapi id 15.20.4500.006; Mon, 20 Sep 2021
 13:21:32 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Baptiste Mansuy <bmansuy@invensense.com>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: mpu6050: add watermark support for
 icm20602/20690
Thread-Topic: [PATCH] iio: imu: mpu6050: add watermark support for
 icm20602/20690
Thread-Index: AQHXpy9vi7KCiV95b0+pOi8lfi8ucKujkUGAgAf/bwCAAWP/Bw==
Date:   Mon, 20 Sep 2021 13:21:31 +0000
Message-ID: <FR3P281MB053728C83C38C974D2F8CC1ACEA09@FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM>
References: <20210906123219.3084706-1-bmansuy@invensense.com>
        <20210911181024.0ce3e225@jic23-huawei>
        <BYAPR12MB29018030DC537A2937F83BFDDEDA9@BYAPR12MB2901.namprd12.prod.outlook.com>
 <20210919170056.5d30eab8@jic23-huawei>
In-Reply-To: <20210919170056.5d30eab8@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 51e9d8d3-f940-5e0c-ce75-41fbd1e97f85
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=tdk.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 256b1e0c-740d-4fa0-1ca0-08d97c399010
x-ms-traffictypediagnostic: FR0P281MB0445:
x-microsoft-antispam-prvs: <FR0P281MB04457CBB3AA3772AAED7DC38CEA09@FR0P281MB0445.DEUP281.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQIeX/ch0JUXBeyQ8DlPiG27P+i+6o8v89hICZ4HFb+1FAD5/lw8DWlVIRt0qUdSb/x0ae7g6zG2uhM/iraKQ9zmEAe7ZFxEsaolnKxPF+B5GOKrf6cONeZhOD9Uu9Xnikvux+F23Vo6a5VF3zrAxi14TwKJ9wL1/evNFdU0otzJNtJs2whVtA/A1HjXWFxd3SYZ3rGgyTz+gQtlzbQumJsXqiM8cZADV1S8I8K19ARqzomu2LRPizVQpWGV/MKIB6zIOTLNzAmktO1iKmpN0RwdvM0Rj70XHzb04k5jWoejRx0jEbhc0Amw/jOUeAg3lFaH4HUlQI1gYMOoyhDeh6OjkiTto3VNzieZPDluBMBnj+cxJtT6C9BD2aQW4GooJHj/v7FU17RQ8Ih4gqdlkCmpuEee2C9Qa1iqYWEIoeFmBhvBX/904h//CX7jVKTXVG15hmpZ/5uH9l8LwOKTzHXG06A47NjOYU6lnmlLufwFoviHX2eorPxytw/gJqeKkPk+Xircynt8pkxAZvKU903Al2m5DrmKRjQJUY/eJT3ptAZxoLzxiQne7secWjTkbpUrbX1LZXs0h23RUHym1/WQjRuShl8k7Liv6B8N0iGKUtD+kw81bb+Emt9w4ZWHprrELxSNwldbOAFtXvGbIZQ6CZ97ocQpoIv8Ox+aMdw1zS+67Vt2CK5Csj45j6i/s4z0zGOUc8tSXFs5wHOAKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(55016002)(66946007)(76116006)(66556008)(122000001)(38070700005)(66476007)(6506007)(30864003)(7696005)(54906003)(4326008)(110136005)(33656002)(53546011)(86362001)(71200400001)(38100700002)(186003)(316002)(66446008)(64756008)(9686003)(508600001)(26005)(2906002)(8676002)(52536014)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uSMi5gKMByYGDBL0yhuBqw3frtosFrQvtD3rACB3cGzvdg4wm0Zem6LhoD?=
 =?iso-8859-1?Q?SzjkKsNRxs7K9pEFWC65rrqQ+kQRl3bFI53lvAPsQH9eVThllkbwOja9VE?=
 =?iso-8859-1?Q?j1A7kY2OV35vyLP8UuK0pPl6l6dI84KVfHd2ovgXzl0NiQI0Frld43ftns?=
 =?iso-8859-1?Q?9ztmDxrqR2Jq4OPpEcG2COlde+5lmV2JY7DaUK3JN4AShcc0w8Kqj/ww2O?=
 =?iso-8859-1?Q?9d39vq48O1LP1cWftBvB6R2gcSTBkaDrOlg1ciNJvh47v1UMgMrLWRm3Ty?=
 =?iso-8859-1?Q?Yk0nvKbOWO+Wm67ZDwCDTt2XGYWXVZF8xfGfgLr7fHAwiPnNxeUBjyNRWx?=
 =?iso-8859-1?Q?UFm75CXrDaEh4YiwtAyXIM4G7svmOuJpmRHTWlRwIyBe4JnRbvfm4gpFfO?=
 =?iso-8859-1?Q?tmRSg9scBFYheNY8A3YDZBrnrMDeGv7HNkV56MUhXjRokis5BgOs0w5Ekj?=
 =?iso-8859-1?Q?6NHUzMDCCY6VI1MQYrjEc1A5G7hc74s51doX1rVTuVzCJCU+3CQRq8BaUj?=
 =?iso-8859-1?Q?gpZTx6IdawseKMystP5zpnOnfurCszIsPSzNnL3eD3Pkzm2UQ3AMeQuISQ?=
 =?iso-8859-1?Q?Myidv0a8GizJKnrH2UmPubiEem6EAHqrzaLTt7cUzqkrGc+sxnBD1ZRwlo?=
 =?iso-8859-1?Q?m6GfbvaOEDxxefQBCjY3R9cTMjLVYU4jXRIcHU9Br+SxHZl6710J6eMhmj?=
 =?iso-8859-1?Q?fhn9d3sZvipI7xG+6HlxgLHqBTWu3I/4qQPLdD6fWjbgKwrjYhn14dq6i5?=
 =?iso-8859-1?Q?qTveU25ihbZU7JtfXrhyLOkEW6P/KVVoq1IBAmvnVgiKDaraLPKZOptC5m?=
 =?iso-8859-1?Q?mEVlmF8wyIUTvCLW6rNpQkuwRaNgL64xn5NtSRC59ysqusHO1r9Za8Larr?=
 =?iso-8859-1?Q?PUk1hSyuxAnqrnHkfzErorCM0l+W8tJs8Dc2xdZXWgjJlSNdo5L/coijKi?=
 =?iso-8859-1?Q?xMyh2cr0XyHFSlKp99z+ynJHinJliDeUvBqSkodd5vLuOvZ1vtbcEH0gkq?=
 =?iso-8859-1?Q?k//RS2ufqMde8hFJK1MKGj2GQjzQlwlOtTJ27tcOaOhPr1kJhTdjSpe3Lw?=
 =?iso-8859-1?Q?SrwHtS1DwA6W8ts229XIki1e8jD1oVxQGYkkHJSF99j8PzYzXLIJ7PwV4m?=
 =?iso-8859-1?Q?HnGNmNgPPtRlG9oE+vpoa3t0x6EzSBjYx/ZpIn48APNIeqOHPrHCiBfgOY?=
 =?iso-8859-1?Q?DHe6/ojlkRydtqzuQxN157C3NuOFPWprPaNuDysTfbPCMn4FXbhLH3+CYT?=
 =?iso-8859-1?Q?/UifyxnZHmojS7RO+Wi5I05X4RB2zcSs1d/2iwaW9ldY8pqe3nb2B3DkpK?=
 =?iso-8859-1?Q?DxBXgRhwJKSfK4wmmi6S8/pEYzrcmZwCKpBMxuja1YBbYpI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 256b1e0c-740d-4fa0-1ca0-08d97c399010
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 13:21:32.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hl1Bd4ud1RqtfqgOQNhGBSsn425HpE4mWMQX1l0IuIOXdFB2clRk5tpgrcQ2Gf/yTpRMttIjUxNdgQ8jHiRJsuVJEzvlnGS0a0FdNqzW4/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB0445
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
concerning the FIFO maximum threshold, this is more complex than that. In o=
ur case we are using both hardware watermark from the chip FIFO and softwar=
e watermark from IIO kernel FIFO.=0A=
=0A=
We may want to use a big IIO kernel FIFO with a big corresponding watermark=
 value, without having the risk to loose data by overflowing the hardware F=
IFO. Thus the threshold in the hardware FIFO watermark used to keep some sp=
ace to handle system response latency.=0A=
=0A=
If we configure maximum value for the hardware FIFO, we may loose data even=
 if the watermark used is very far from IIO kernel FIFO size. Image we use =
a 4096 bytes IIO buffer with a watermark of 2048 (half the size), and our c=
hip only have 1024 bytes of FIFO. We want to use hardware FIFO as much as p=
ossible, but without the risk to loose data. Userspace user will not intend=
 to have holes in its data with such a value.=0A=
=0A=
With all that in mind, what do you think would be a good threshold to ensur=
e we cannot loose data with usual system latency?=0A=
=0A=
Thanks for your response,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, September 19, 2021 18:00=0A=
To: Baptiste Mansuy <bmansuy@invensense.com>=0A=
Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio=
@vger.kernel.org>=0A=
Subject: Re: [PATCH] iio: imu: mpu6050: add watermark support for icm20602/=
20690 =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Tue, 14 Sep 2021 13:52:53 +0000=0A=
Baptiste Mansuy <bmansuy@invensense.com> wrote:=0A=
=0A=
> Hi,=0A=
> =0A=
> Thank you for your comments, I wrote a reply bellow each of them.=0A=
> =0A=
> Baptiste=0A=
> =0A=
> =0A=
> From: Jonathan Cameron <jic23@kernel.org>=0A=
> Sent: Saturday, September 11, 2021 7:10 PM=0A=
> To: Baptiste Mansuy <bmansuy@invensense.com>=0A=
> Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>=0A=
> Subject: Re: [PATCH] iio: imu: mpu6050: add watermark support for icm2060=
2/20690 =0A=
> =0A=
> On Mon,=A0 6 Sep 2021 12:32:19 +0000=0A=
> Baptiste Mansuy <bmansuy@invensense.com> wrote:=0A=
> =0A=
> >> Add watermark support using FIFO interrupt for chips having this=0A=
> >> feature. This allows the use of the watermark interrupt with the=0A=
> >> posibility to change it's size. Change the timestamp computation=0A=
> >> to be used with the watermark.=0A=
> >> =0A=
> >> Add the set_watermark and flush callbacks according to the iio=0A=
> >> description.=0A=
> >> =0A=
> >>Signed-off-by: Baptiste Mansuy <bmansuy@invensense.com>=A0 =0A=
> >=0A=
> >Hi,=0A=
> >=0A=
> >A few comments inline.=0A=
> >=0A=
> >Jonathan=0A=
> >=A0 =0A=
> >> ---=0A=
> >>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0=A0=A0 | 104 +++++++++=
++++-=0A=
> >>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0=A0=A0=A0 |=A0 21 ++-=
=0A=
> >>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=A0=A0=A0 | 130 +++++++++=
++++-----=0A=
> >>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=A0 24 +++-=0A=
> >>=A0 4 files changed, 237 insertions(+), 42 deletions(-)=0A=
> >> =0A=
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_core.c=0A=
> >> index 597768c..9cdec62 100644=0A=
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> >> @@ -47,7 +47,9 @@ static const struct inv_mpu6050_reg_map reg_set_icm2=
0602 =3D {=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .raw_accl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D INV_MPU6050_REG_RAW_ACCEL,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .temperature=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 INV_MPU6050_REG_TEMPERATURE,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .int_enable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D INV_MPU6050_REG_INT_ENABLE,=0A=
> >> -=A0=A0=A0=A0 .int_status=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_=
MPU6050_REG_INT_STATUS,=0A=
> >> +=A0=A0=A0=A0 .int_status=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_=
ICM20602_REG_FIFO_WM_INT_STATUS,=0A=
> >> +=A0=A0=A0=A0 .wm_th_hb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
INV_ICM20602_FIFO_WM_TH_HB,=0A=
> >> +=A0=A0=A0=A0 .wm_th_lb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
INV_ICM20602_FIFO_WM_TH_LB,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .pwr_mgmt_1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D INV_MPU6050_REG_PWR_MGMT_1,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .pwr_mgmt_2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D INV_MPU6050_REG_PWR_MGMT_2,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .int_pin_cfg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 INV_MPU6050_REG_INT_PIN_CFG,=0A=
> >> @@ -56,6 +58,31 @@ static const struct inv_mpu6050_reg_map reg_set_icm=
20602 =3D {=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .i2c_if=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D INV_ICM20602_REG_I2C_IF,=0A=
> >>=A0 };=0A=
> >>=A0 =0A=
> >> +static const struct inv_mpu6050_reg_map reg_set_icm20690 =3D {=0A=
> >> +=A0=A0=A0=A0 .sample_rate_div=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU6050_RE=
G_SAMPLE_RATE_DIV,=0A=
> >> +=A0=A0=A0=A0 .lpf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D INV_MPU6050_REG_CONFIG,=0A=
> >> +=A0=A0=A0=A0 .accel_lpf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D IN=
V_MPU6500_REG_ACCEL_CONFIG_2,=0A=
> >> +=A0=A0=A0=A0 .user_ctrl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D IN=
V_MPU6050_REG_USER_CTRL,=0A=
> >> +=A0=A0=A0=A0 .fifo_en=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D INV_MPU6050_REG_FIFO_EN,=0A=
> >> +=A0=A0=A0=A0 .gyro_config=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6050_REG_GYRO_CONFIG,=0A=
> >> +=A0=A0=A0=A0 .accl_config=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6050_REG_ACCEL_CONFIG,=0A=
> >> +=A0=A0=A0=A0 .fifo_count_h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU6=
050_REG_FIFO_COUNT_H,=0A=
> >> +=A0=A0=A0=A0 .fifo_r_w=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
INV_MPU6050_REG_FIFO_R_W,=0A=
> >> +=A0=A0=A0=A0 .raw_gyro=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
INV_MPU6050_REG_RAW_GYRO,=0A=
> >> +=A0=A0=A0=A0 .raw_accl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
INV_MPU6050_REG_RAW_ACCEL,=0A=
> >> +=A0=A0=A0=A0 .temperature=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6050_REG_TEMPERATURE,=0A=
> >> +=A0=A0=A0=A0 .int_enable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_=
MPU6050_REG_INT_ENABLE,=0A=
> >> +=A0=A0=A0=A0 .int_status=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_=
ICM20602_REG_FIFO_WM_INT_STATUS,=0A=
> >> +=A0=A0=A0=A0 .wm_th_hb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
INV_ICM20690_FIFO_WM_TH_HB,=0A=
> >> +=A0=A0=A0=A0 .wm_th_lb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
INV_ICM20690_FIFO_WM_TH_LB,=0A=
> >> +=A0=A0=A0=A0 .pwr_mgmt_1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_=
MPU6050_REG_PWR_MGMT_1,=0A=
> >> +=A0=A0=A0=A0 .pwr_mgmt_2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_=
MPU6050_REG_PWR_MGMT_2,=0A=
> >> +=A0=A0=A0=A0 .int_pin_cfg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6050_REG_INT_PIN_CFG,=0A=
> >> +=A0=A0=A0=A0 .accl_offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6500_REG_ACCEL_OFFSET,=0A=
> >> +=A0=A0=A0=A0 .gyro_offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6050_REG_GYRO_OFFSET,=0A=
> >> +=A0=A0=A0=A0 .i2c_if=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D 0,=0A=
> >> +};=0A=
> >> +=0A=
> >>=A0 static const struct inv_mpu6050_reg_map reg_set_6500 =3D {=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .sample_rate_div=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU=
6050_REG_SAMPLE_RATE_DIV,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .lpf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D INV_MPU6050_REG_CONFIG,=0A=
> >> @@ -115,6 +142,8 @@ static const struct inv_mpu6050_chip_config chip_c=
onfig_6050 =3D {=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .magn_fifo_enable =3D false,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .accl_fs =3D INV_MPU6050_FS_02G,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .user_ctrl =3D 0,=0A=
> >> +=A0=A0=A0=A0 .wm_val =3D 1,=0A=
> >> +=A0=A0=A0=A0 .wm_size =3D 0,=A0 =0A=
> >=0A=
> >I don't think this is ever relevant to parts using this structure.=0A=
> >=A0 =0A=
> =0A=
> wm_val is used by every chip for the timestamp computation. It needs to b=
e set to 1.=0A=
I'd missed that.=A0 Thanks.=0A=
=0A=
> =0A=
> >>=A0 };=0A=
> >>=A0 =0A=
..=0A=
> >>=A0 =0A=
> >> +int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, un=
signed int val)=0A=
> >> +{=0A=
> >> +=A0=A0=A0=A0 unsigned int nb_byte, new_size_byte;=0A=
> >> +=A0=A0=A0=A0 int ret;=0A=
> >> +=0A=
> >> +=A0=A0=A0=A0 /* compute number of bytes inside FIFO */=0A=
> >> +=A0=A0=A0=A0 nb_byte =3D 0;=0A=
> >> +=A0=A0=A0=A0 if (st->chip_config.gyro_en)=0A=
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nb_byte +=3D INV_MPU6050_BYTES_P=
ER_3AXIS_SENSOR;=0A=
> >> +=A0=A0=A0=A0 if (st->chip_config.accl_en)=0A=
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nb_byte +=3D INV_MPU6050_BYTES_P=
ER_3AXIS_SENSOR;=0A=
> >> +=A0=A0=A0=A0 if (st->chip_config.magn_en)=0A=
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nb_byte +=3D INV_MPU9X50_BYTES_M=
AGN;=0A=
> >> +=A0=A0=A0=A0 if (st->chip_config.temp_en)=0A=
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nb_byte +=3D INV_MPU6050_BYTES_P=
ER_TEMP_SENSOR;=0A=
> >> +=0A=
> >> +=A0=A0=A0=A0 /* compute watermark size, use a threshold to keep some =
data space for read latency */=A0 =0A=
> >=0A=
> >Not following this comment.=A0 If the intent is you are setting the wate=
rmark in hardware lower=0A=
> >because you think more data will have come in before we actually read it=
, please don't.=0A=
> >The sampling frequency could be very low meaning there isn't enough data=
 available.=0A=
> >=0A=
> >We are dealing with a fifo here, it doesn't matter if a few more samples=
 are available when=0A=
> >we go to read than the level of the watermark.=A0 That's normal.=0A=
> >=A0 =0A=
> =0A=
> The issue here is when the fifo is full, if the processing of the interru=
pt takes too much time,=0A=
> we don't know if the first data were overwritten by new data.=A0 =0A=
> If it happens, we can't use the data. So we need to let some space in the=
 fifo.=0A=
=0A=
Then the watermark is set too high.=A0 So that's just a software / userspac=
e configuration issue=0A=
and is common to any similar fifo.=0A=
=0A=
> =0A=
> It usualy happens with high sample frequencies. If the current space is t=
oo much, we can=0A=
> choose a new space of 10 samples. With the highest frequency (500Hz), a f=
ree space of =0A=
> 10 samples gives 20ms for the processing of the interrupt.=0A=
=0A=
Understood on the problem, but leave dealing this to userspace control rath=
er than trying to=0A=
paper over in userspace.=A0 If you do what you have here, and a low sample =
rate is used=0A=
userspace software will expect to have at least the watermark worth of samp=
les.=A0 Whilst=0A=
it 'should' probably be hardened against underflow, it may well not be.=0A=
=0A=
Any userspace software that sets the watermark near the maximum possible wo=
uld=0A=
in my mind be either considered broken, or is being used in a case where lo=
osing=0A=
samples isn't a problem.=0A=
=0A=
> =0A=
> >> +=A0=A0=A0=A0 new_size_byte =3D val * nb_byte;=0A=
> >> +=A0=A0=A0=A0 if (new_size_byte > ((st->hw->fifo_size * 4) / 5)) {=0A=
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D ((st->hw->fifo_size * 4)=
 / 5) / nb_byte;=0A=
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 new_size_byte =3D val * nb_byte;=
=0A=
> >> +=A0=A0=A0=A0 }=0A=
> >> +=0A=
> >> +=A0=A0=A0=A0 ret =3D inv_mpu6050_set_hw_watermark(st, new_size_byte);=
=0A=
> >> +=A0=A0=A0=A0 if (ret)=0A=
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> >> +=0A=
> >> +=A0=A0=A0=A0 st->chip_config.wm_val =3D val;=0A=
> >> +=0A=
> >> +=A0=A0=A0=A0 return 0;=0A=
> >> +}=0A=
> >> +=0A=
=0A=
...=0A=
=0A=
> >> +=0A=
> >>=A0 static const struct iio_info mpu_info =3D {=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .read_raw =3D &inv_mpu6050_read_raw,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .write_raw =3D &inv_mpu6050_write_raw,=0A=
> >> @@ -1297,6 +1393,8 @@ static const struct iio_info mpu_info =3D {=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .attrs =3D &inv_attribute_group,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .validate_trigger =3D inv_mpu6050_validate_trigge=
r,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 .debugfs_reg_access =3D &inv_mpu6050_reg_access,=
=0A=
> >> +=A0=A0=A0=A0 .hwfifo_set_watermark =3D &inv_mpu6050_set_watermark,=0A=
> >> +=A0=A0=A0=A0 .hwfifo_flush_to_buffer =3D &inv_mpu6050_hw_flush_to_buf=
fer,=0A=
> >>=A0 };=0A=
> >>=A0 =0A=
> >>=A0 /*=0A=
> >> @@ -1618,7 +1716,7 @@ int inv_mpu_core_probe(struct regmap *regmap, in=
t irq, const char *name,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D devm_iio_trigg=
ered_buffer_setup(dev, indio_dev,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 iio_pollfunc_store_time,=0A=
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 inv_mpu6050_read_fifo,=0A=
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 inv_mpu6050_interrupt_handler,=0A=
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 NULL);=0A=
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result) {=0A=
> >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d=
ev_err(dev, "configure buffer fail %d\n", result);=0A=
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_iio.h=0A=
> >> index c6aa36e..d925885 100644=0A=
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> >> @@ -57,6 +57,8 @@ struct inv_mpu6050_reg_map {=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 u8 temperature;=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 u8 int_enable;=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 u8 int_status;=0A=
> >> +=A0=A0=A0=A0 u8 wm_th_hb;=0A=
> >> +=A0=A0=A0=A0 u8 wm_th_lb;=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 u8 pwr_mgmt_1;=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 u8 pwr_mgmt_2;=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 u8 int_pin_cfg;=0A=
> >> @@ -121,6 +123,8 @@ struct inv_mpu6050_chip_config {=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 unsigned int magn_fifo_enable:1;=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 u8 divider;=0A=
> >>=A0=A0=A0=A0=A0=A0=A0 u8 user_ctrl;=0A=
> >> +=A0=A0=A0=A0 unsigned int wm_val;=A0 =0A=
> >What are these two? Non obvious enough a comment would be good.=A0 =0A=
> =0A=
> I added the following lines in the Doxygen header :=0A=
> =0A=
>=A0 *=A0 @wm_val:=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark size in number of d=
ata=0A=
>=A0 *=A0 @wm_size:=A0=A0=A0=A0=A0=A0=A0=A0 watermark size in bytes=0A=
=0A=
Ah good.=A0 I hadn't noticed the structure had kernel-doc and this=0A=
would have caused problems when I ran a build tests.=0A=
=0A=
Please make sure to run build the documentation or run a build=0A=
test with W=3D1 so that we verify no other documentation is missing.=0A=
=0A=
> =0A=
> >> +=A0=A0=A0=A0 unsigned int wm_size;=0A=
> >>=A0 };=0A=
> >>=A0 =0A=
=0A=
...=0A=
=0A=
> >> -/*=0A=
> >> - * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIF=
O.=0A=
> >> - */=0A=
> >> -irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=A0 =0A=
> >=0A=
> >Given the count parameter has a 'special' value of 0, please add some do=
cumentation=0A=
> >for this function.=0A=
> >=A0 =0A=
> =0A=
> I added a Doxygen header for this function :=0A=
> =0A=
> /**=0A=
>=A0 * inv_mpu6050_flush_fifo() - Flush fifo=0A=
>=A0 *=0A=
>=A0 * @indio_dev:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Device driv=
er instance.=0A=
>=A0 * @timestamp_val:=A0=A0=A0 the interrupt timestamp=0A=
>=A0 * @count:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of data to flush=0A=
>=A0 *=0A=
>=A0 * This function flush the fifo using count as the number of data to fl=
ush.=0A=
=0A=
This function flushes the fifo using the count...=0A=
=0A=
>=A0 * As fifo_size may differ according to the chip unsigned=0A=
>=A0 * count =3D 0 is used to set the max size of the fifo for count.=0A=
>=A0 *=0A=
No point in the empty trailing line as it doesn't help readabilty so please=
 remove=0A=
that. Otherwise good docs.=0A=
>=A0 */=0A=
> =0A=
> >> +int inv_mpu6050_flush_fifo(struct iio_dev *indio_dev,=0A=
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s64 timestamp_val, unsigned int count)=0A=
> >>=A0 {=0A=
...=0A=
