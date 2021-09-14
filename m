Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6740B08E
	for <lists+linux-iio@lfdr.de>; Tue, 14 Sep 2021 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhINOZz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Sep 2021 10:25:55 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:18798 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233695AbhINOZy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Sep 2021 10:25:54 -0400
X-Greylist: delayed 1888 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Sep 2021 10:25:54 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EBFQRP011002;
        Tue, 14 Sep 2021 06:52:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=GujvVK+TSzZe2O7CKQhS+rilDOJTB9EIudWXVcvQ/Y0=;
 b=gnWdGPh7eS3mqnVEdY+mgyVG8s9Blfyytm0OMDuxzuUK33e+G7dh8oF13MJV9/4ymmUy
 jSp3CDuvR/eve35VofOdVsE00tIB4ugV2y/cSRi/riWwxrS/LrteFY8Mp/24rs5Ui+CM
 t9uUsh4qNV4RZTlk7EdF9SFcRsrY4xlExUfWdkDmGkrA66GsANu4Zl/P8xFwM1yczQ4t
 m6EHcoGC2LsQlNgil6BDRVJvnFXXIb2FDkfu3mylvvra1QLNBalofMZDRvDR1ABZbRRE
 Lco1M+SwTssYW2EC609A1T4ETNilEppg3VCmYl5b5OnoYCkA1cUGXdAFZ4eahXIuDAJ5 TA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by mx0a-00328301.pphosted.com with ESMTP id 3b25wts206-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 06:52:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArBXDDEcwimH5nj9+Nok7ASVBleFPfSJyQzA7+xeg2L0o51dakJaYk+0mUybomNJouJQviAeTv261VpR9xrAu8D/Ic4/MH1bVCeULaXamwqrIfDqevgcPh8TS07wSXrJxWlyMRwOYjXdvvF2X0EapnLI3CDfY0ZJpRSSzofU9mfKBRPnZXi8+PJHargfBOP/S1Y1grZtXrpM0smFWwewWz9u2C8WDds3Rl6AV3XqIXCXs728XQzj2LaPHpmo2jr8YuTD4ylBbTi/JAkubBJmPp+QUPg6PSJXcCTVl3TKqHWB7NYwQfEJTFEOtUGQqR47GKhdXZ92iX5MwAheQYK6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GujvVK+TSzZe2O7CKQhS+rilDOJTB9EIudWXVcvQ/Y0=;
 b=mgnFwo+wERqdNQqkAuJyp1KufjwAhd9Q8r7BbDzsf33VVBlYaehpzstdjXtJdefILXZmc0iLgEiKDAf5/LUdLLSHIGaFBADJFnxu7EGnPoovODP/SoWpj1ZP1e3zK4dPoTh/qARRFt8FC9fGRUltgeBxaWsm5mQG5CB3gIB/NTIVgjQJPLKFZ3N5RMeOleTWJZWDgIDMRT5a4D+WMPUIF7Wk3hWe5H6KoZXCL08Pfn3289gT8f/gWHRcx60X2Gbkp3DY/ifIIDXbZQ1yOzYSqu2Q2+07yR4k5X7JE/k3S76Oy+MCXsZQeS4LXuWcL79N8PJTelRqI1VYJ4A1Md2HAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GujvVK+TSzZe2O7CKQhS+rilDOJTB9EIudWXVcvQ/Y0=;
 b=TgXJ77r/W4COxFBKETjItnzTPBrUt3p4RXkndfU1VrLPAHNWqWEza5H+Jr4B3S27Wkpqmw5v5VGTBSagHFmQnLyN5nDDkJlutJbEZPID2hHyzj6czGrXhyU+x9WZY4vNLx7VQBjYNw8BVftpkDlFsOofEHPM0FO9SgsI3WDD1VE=
Received: from BYAPR12MB2901.namprd12.prod.outlook.com (2603:10b6:a03:138::32)
 by BY5PR12MB3745.namprd12.prod.outlook.com (2603:10b6:a03:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 13:52:53 +0000
Received: from BYAPR12MB2901.namprd12.prod.outlook.com
 ([fe80::8880:75b:9bf:6d6b]) by BYAPR12MB2901.namprd12.prod.outlook.com
 ([fe80::8880:75b:9bf:6d6b%5]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 13:52:53 +0000
From:   Baptiste Mansuy <bmansuy@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: mpu6050: add watermark support for
 icm20602/20690
Thread-Topic: [PATCH] iio: imu: mpu6050: add watermark support for
 icm20602/20690
Thread-Index: AQHXoxtw2D/hhgS26ESgEAgcj9WDkqufGZoAgARzXGk=
Date:   Tue, 14 Sep 2021 13:52:53 +0000
Message-ID: <BYAPR12MB29018030DC537A2937F83BFDDEDA9@BYAPR12MB2901.namprd12.prod.outlook.com>
References: <20210906123219.3084706-1-bmansuy@invensense.com>
 <20210911181024.0ce3e225@jic23-huawei>
In-Reply-To: <20210911181024.0ce3e225@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 2b5b8dc5-e8f9-c245-7607-fa6e63da5ed2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d062a66a-5c8d-473b-cc26-08d97786f2e6
x-ms-traffictypediagnostic: BY5PR12MB3745:
x-microsoft-antispam-prvs: <BY5PR12MB37453973BD81463DAF46E6AADEDA9@BY5PR12MB3745.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUV2/Fy13Xo+01cldcXaIe1l+yXI/e8pWtknXJSwwLNs6zUjXRgmN5LDRI6pq5T/4ZhXA7aGnzlERXr09OfTCOxnoLtX7rMgFqzH99JPRTWPvmSIssD6Z2WgzK0r2NWGG0Mfji2yD2MEhWdeGuPKcVwOQ/BBD/fjNs2fKAbkHDE0YK8rfy/VZa3OWPjskOTHXczVKQgp9HICtiT1hb/gDO29rw1ejXrKcERVkaZ9mlfbCX/ODxS+7DSXdQR/tfribJOEN85Ff9Y2f1zO6d/CUThgzKnxODCWZj9WDS3s9D7ymZNjLeeFGYRlAjMnFprV6Qco7muu6nH/DBoPAU4TCYBvB3XXrUP+zT6FO9oLBeKIo0ayOGkczpot3AXwpx0Le14pBtnPrQeuUIhfAxTbFPhJyCoZnCH46E0qXHFHCHFJw7b4Mdeh4VSref5TfhvIvOVKflpetAzt+nSXhj/JRn6dLE7g+OtCv/y/TlEvYMWPO/SGnejVivlA86IHUP4q7Mjfdf4LM0dfPb7ZjQkuLFzDNXjw5TARHnU85ErPDDNTbhMrkg0ZJzjOTJePeQ41ZZfgu7hlLkvY8Ftkr6xOWJaedL2PG+pxrLxL2VW29kPWSanL8m5GK/XfWxfv3C+crmk5dSCBGoGHEFGLnpixinNPmLD9oe6iXoXxDuvqxcYzabIBEgXkbKI3Q1Swq6f8NWnwk1eIAV3Xb8Qx/ZwNag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(136003)(39860400002)(186003)(83380400001)(76116006)(2906002)(38070700005)(52536014)(91956017)(55016002)(33656002)(54906003)(66946007)(316002)(64756008)(71200400001)(6506007)(53546011)(66556008)(38100700002)(5660300002)(30864003)(122000001)(66476007)(478600001)(66446008)(9686003)(8676002)(6916009)(86362001)(7696005)(8936002)(4326008)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fhoragAAiX5E4ScuhPiZWSWUT4I0DTefA4J/Y/sav/1QZXFSggiryP+NwM?=
 =?iso-8859-1?Q?VBS+AYKanvrTGxAqOMnmHEY979XZmcByjvPahOnGnYMrbCgECwCV59aWdD?=
 =?iso-8859-1?Q?sApQDxYv5R+m+MlpIA8jV7+R/zrw53RP6eIhJ5+y2SMDFf1F9scG4RnrDw?=
 =?iso-8859-1?Q?7c263QoUp+imZNbmZIpgIYDMDwAaLYNaXAb4RK+PEt9XbDjhVnC/8afI3r?=
 =?iso-8859-1?Q?taZwWcjG0GnMzPbJRWNvjwFHziUWkBlq76OAhUPK81tTmhQoaZlivVZPAB?=
 =?iso-8859-1?Q?ZelyZZo2Acxj9Rkdv8B8HKVtwUfRPWRximqsVZcsk3r8PfcePZCkOXUVFX?=
 =?iso-8859-1?Q?JGG2hmUneBANlgGSnhEAzST3DYdWi2USW8s8PpirrmNddCc3F7xnMO9W2B?=
 =?iso-8859-1?Q?4IGdUCoYPUpbO+h+c7pUsOUi6MZ+g7Uz2YQBO13G46H3qopbhkIW5sDQl1?=
 =?iso-8859-1?Q?b07gcuPKbIVj4fdIRU5h8mNj7wNdepZAcFyyRGzdJSFDtRB3x0Jvg2FKEA?=
 =?iso-8859-1?Q?minIXSV6DUdt7yJo2L74ON2fkK+QfTInciJ2+ThQdsMJ/vQ8RW6lPANGGC?=
 =?iso-8859-1?Q?PvLJXoEinES1f3msAiWsbQqCcOPuP6TuQnyOP6eQAJk/AabIT9qWML6oGj?=
 =?iso-8859-1?Q?m95O/7T2b0guck6INnIRiaLNMZDSpeT+V6VBBQ4jhn7Ev4rpaC3QGdswef?=
 =?iso-8859-1?Q?gLatdg0MQDtHd7f7Y8aaNEaUkzcOIqErNH/WJk1fZ6Dv9CiFPNhqggBd0Q?=
 =?iso-8859-1?Q?0JJVFtoUQB/TOiCGoZZ98pKfrJF14eK/HTsH3tGdsRqBjrX+3z1UgKpXc5?=
 =?iso-8859-1?Q?Ov8ju7wBiwRf0dsP/vZQureTQedJau2RilQCObQF8yHpO5yAB1zWgujKT0?=
 =?iso-8859-1?Q?a9NsBqnZKfa5DBDQ5e+aJ+dHauHiP6OtpS8r6/Vth0Y7BFuMDhfvubPTNH?=
 =?iso-8859-1?Q?RTQfIvj/dk/lh1oMXvah+1wgfvDwnYfnybR55qETj5CC3in5NzG8gv7ftZ?=
 =?iso-8859-1?Q?zwzr8GpCcohc/jjvN23P2FyEmHiqUTzBLkC9FKynUdmwYTfvqRa7blqe6a?=
 =?iso-8859-1?Q?tggM2sLVMJN7ano3l2u4U3RP+IDdQBrTqczsFV3nus/DqW38qJTQeP8i9S?=
 =?iso-8859-1?Q?hm5mYo3Qj4RS8V+VURrYGKmFdhd3bd9ONyD5j6tP/gaaUjZoEKsNuHQZ/h?=
 =?iso-8859-1?Q?DESv4NlKt3yJbl5Rtn4almEE7HcQur9UCAaJ70qpr41dFbfsdIDZA4LcSw?=
 =?iso-8859-1?Q?IUylSPlehm0aP2ltENjb6VSrCFiQ3M5hGYXMkn55rDxwIVdMttggQPQgYN?=
 =?iso-8859-1?Q?aYdeP1bF56tso8Q80fuHvV8RXDPdLScCAmnz5vv85m9yKuIZoRKizr+Ekv?=
 =?iso-8859-1?Q?3fyc7DawAtyh47Wl+KOS+pRxsDYwtoJqmFmWtttDtyUIjPuaU6p6rhKWGZ?=
 =?iso-8859-1?Q?Bqn7YATODvqXedon?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d062a66a-5c8d-473b-cc26-08d97786f2e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 13:52:53.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6WGf52BLM95OIpMZ7PEj215FM7iNZ/kkewl+BPVMTZ72pmQdVyrIHJ3dqBr84JQ/yI5U40vlENe+40F4+0e3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3745
X-Proofpoint-GUID: O4fTDNfpav888Tc467AHQsGqlbe7w4sw
X-Proofpoint-ORIG-GUID: O4fTDNfpav888Tc467AHQsGqlbe7w4sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_03,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,=0A=
=0A=
Thank you for your comments, I wrote a reply bellow each of them.=0A=
=0A=
Baptiste=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Saturday, September 11, 2021 7:10 PM=0A=
To: Baptiste Mansuy <bmansuy@invensense.com>=0A=
Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio=
@vger.kernel.org>=0A=
Subject: Re: [PATCH] iio: imu: mpu6050: add watermark support for icm20602/=
20690 =0A=
=0A=
On Mon,=A0 6 Sep 2021 12:32:19 +0000=0A=
Baptiste Mansuy <bmansuy@invensense.com> wrote:=0A=
=0A=
>> Add watermark support using FIFO interrupt for chips having this=0A=
>> feature. This allows the use of the watermark interrupt with the=0A=
>> posibility to change it's size. Change the timestamp computation=0A=
>> to be used with the watermark.=0A=
>> =0A=
>> Add the set_watermark and flush callbacks according to the iio=0A=
>> description.=0A=
>> =0A=
>>Signed-off-by: Baptiste Mansuy <bmansuy@invensense.com>=0A=
>=0A=
>Hi,=0A=
>=0A=
>A few comments inline.=0A=
>=0A=
>Jonathan=0A=
>=0A=
>> ---=0A=
>>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0=A0=A0 | 104 +++++++++++=
++-=0A=
>>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0=A0=A0=A0 |=A0 21 ++-=0A=
>>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=A0=A0=A0 | 130 +++++++++++=
++-----=0A=
>>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=A0 24 +++-=0A=
>>=A0 4 files changed, 237 insertions(+), 42 deletions(-)=0A=
>> =0A=
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_core.c=0A=
>> index 597768c..9cdec62 100644=0A=
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>> @@ -47,7 +47,9 @@ static const struct inv_mpu6050_reg_map reg_set_icm206=
02 =3D {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .raw_accl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =3D INV_MPU6050_REG_RAW_ACCEL,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .temperature=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D I=
NV_MPU6050_REG_TEMPERATURE,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .int_enable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 INV_MPU6050_REG_INT_ENABLE,=0A=
>> -=A0=A0=A0=A0 .int_status=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6050_REG_INT_STATUS,=0A=
>> +=A0=A0=A0=A0 .int_status=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_IC=
M20602_REG_FIFO_WM_INT_STATUS,=0A=
>> +=A0=A0=A0=A0 .wm_th_hb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D IN=
V_ICM20602_FIFO_WM_TH_HB,=0A=
>> +=A0=A0=A0=A0 .wm_th_lb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D IN=
V_ICM20602_FIFO_WM_TH_LB,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .pwr_mgmt_1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 INV_MPU6050_REG_PWR_MGMT_1,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .pwr_mgmt_2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 INV_MPU6050_REG_PWR_MGMT_2,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .int_pin_cfg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D I=
NV_MPU6050_REG_INT_PIN_CFG,=0A=
>> @@ -56,6 +58,31 @@ static const struct inv_mpu6050_reg_map reg_set_icm20=
602 =3D {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .i2c_if=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D INV_ICM20602_REG_I2C_IF,=0A=
>>=A0 };=0A=
>>=A0 =0A=
>> +static const struct inv_mpu6050_reg_map reg_set_icm20690 =3D {=0A=
>> +=A0=A0=A0=A0 .sample_rate_div=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU6050_REG_=
SAMPLE_RATE_DIV,=0A=
>> +=A0=A0=A0=A0 .lpf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D INV_MPU6050_REG_CONFIG,=0A=
>> +=A0=A0=A0=A0 .accel_lpf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_=
MPU6500_REG_ACCEL_CONFIG_2,=0A=
>> +=A0=A0=A0=A0 .user_ctrl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_=
MPU6050_REG_USER_CTRL,=0A=
>> +=A0=A0=A0=A0 .fifo_en=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
INV_MPU6050_REG_FIFO_EN,=0A=
>> +=A0=A0=A0=A0 .gyro_config=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU6=
050_REG_GYRO_CONFIG,=0A=
>> +=A0=A0=A0=A0 .accl_config=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU6=
050_REG_ACCEL_CONFIG,=0A=
>> +=A0=A0=A0=A0 .fifo_count_h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU605=
0_REG_FIFO_COUNT_H,=0A=
>> +=A0=A0=A0=A0 .fifo_r_w=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D IN=
V_MPU6050_REG_FIFO_R_W,=0A=
>> +=A0=A0=A0=A0 .raw_gyro=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D IN=
V_MPU6050_REG_RAW_GYRO,=0A=
>> +=A0=A0=A0=A0 .raw_accl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D IN=
V_MPU6050_REG_RAW_ACCEL,=0A=
>> +=A0=A0=A0=A0 .temperature=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU6=
050_REG_TEMPERATURE,=0A=
>> +=A0=A0=A0=A0 .int_enable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6050_REG_INT_ENABLE,=0A=
>> +=A0=A0=A0=A0 .int_status=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_IC=
M20602_REG_FIFO_WM_INT_STATUS,=0A=
>> +=A0=A0=A0=A0 .wm_th_hb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D IN=
V_ICM20690_FIFO_WM_TH_HB,=0A=
>> +=A0=A0=A0=A0 .wm_th_lb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D IN=
V_ICM20690_FIFO_WM_TH_LB,=0A=
>> +=A0=A0=A0=A0 .pwr_mgmt_1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6050_REG_PWR_MGMT_1,=0A=
>> +=A0=A0=A0=A0 .pwr_mgmt_2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MP=
U6050_REG_PWR_MGMT_2,=0A=
>> +=A0=A0=A0=A0 .int_pin_cfg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU6=
050_REG_INT_PIN_CFG,=0A=
>> +=A0=A0=A0=A0 .accl_offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU6=
500_REG_ACCEL_OFFSET,=0A=
>> +=A0=A0=A0=A0 .gyro_offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU6=
050_REG_GYRO_OFFSET,=0A=
>> +=A0=A0=A0=A0 .i2c_if=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D 0,=0A=
>> +};=0A=
>> +=0A=
>>=A0 static const struct inv_mpu6050_reg_map reg_set_6500 =3D {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .sample_rate_div=A0=A0=A0=A0=A0=A0=A0 =3D INV_MPU60=
50_REG_SAMPLE_RATE_DIV,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .lpf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D INV_MPU6050_REG_CONFIG,=0A=
>> @@ -115,6 +142,8 @@ static const struct inv_mpu6050_chip_config chip_con=
fig_6050 =3D {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .magn_fifo_enable =3D false,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .accl_fs =3D INV_MPU6050_FS_02G,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .user_ctrl =3D 0,=0A=
>> +=A0=A0=A0=A0 .wm_val =3D 1,=0A=
>> +=A0=A0=A0=A0 .wm_size =3D 0,=0A=
>=0A=
>I don't think this is ever relevant to parts using this structure.=0A=
>=0A=
=0A=
wm_val is used by every chip for the timestamp computation. It needs to be =
set to 1.=0A=
=0A=
>>=A0 };=0A=
>>=A0 =0A=
>>=A0 static const struct inv_mpu6050_chip_config chip_config_6500 =3D {=0A=
>> @@ -132,6 +161,8 @@ static const struct inv_mpu6050_chip_config chip_con=
fig_6500 =3D {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .magn_fifo_enable =3D false,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .accl_fs =3D INV_MPU6050_FS_02G,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .user_ctrl =3D 0,=0A=
>> +=A0=A0=A0=A0 .wm_val =3D 1,=0A=
>> +=A0=A0=A0=A0 .wm_size =3D 0,=0A=
>=0A=
>>=A0 };=0A=
>>=A0 =0A=
>>=A0 /* Indexed by enum inv_devices */=0A=
>> @@ -247,7 +278,7 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0 {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20690_WH=
OAMI_VALUE,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "ICM20690",=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .reg =3D &reg_set_6500,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .reg =3D &reg_set_icm20690,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_65=
00,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 1024,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TEM=
P_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>> @@ -264,6 +295,38 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0 },=0A=
>>=A0 };=0A=
>>=A0 =0A=
>> +int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsi=
gned int val)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 unsigned int nb_byte, new_size_byte;=0A=
>> +=A0=A0=A0=A0 int ret;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 /* compute number of bytes inside FIFO */=0A=
>> +=A0=A0=A0=A0 nb_byte =3D 0;=0A=
>> +=A0=A0=A0=A0 if (st->chip_config.gyro_en)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nb_byte +=3D INV_MPU6050_BYTES_PER=
_3AXIS_SENSOR;=0A=
>> +=A0=A0=A0=A0 if (st->chip_config.accl_en)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nb_byte +=3D INV_MPU6050_BYTES_PER=
_3AXIS_SENSOR;=0A=
>> +=A0=A0=A0=A0 if (st->chip_config.magn_en)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nb_byte +=3D INV_MPU9X50_BYTES_MAG=
N;=0A=
>> +=A0=A0=A0=A0 if (st->chip_config.temp_en)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nb_byte +=3D INV_MPU6050_BYTES_PER=
_TEMP_SENSOR;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 /* compute watermark size, use a threshold to keep some da=
ta space for read latency */=0A=
>=0A=
>Not following this comment.=A0 If the intent is you are setting the waterm=
ark in hardware lower=0A=
>because you think more data will have come in before we actually read it, =
please don't.=0A=
>The sampling frequency could be very low meaning there isn't enough data a=
vailable.=0A=
>=0A=
>We are dealing with a fifo here, it doesn't matter if a few more samples a=
re available when=0A=
>we go to read than the level of the watermark.=A0 That's normal.=0A=
>=0A=
=0A=
The issue here is when the fifo is full, if the processing of the interrupt=
 takes too much time,=0A=
we don't know if the first data were overwritten by new data.  =0A=
If it happens, we can't use the data. So we need to let some space in the f=
ifo.=0A=
=0A=
It usualy happens with high sample frequencies. If the current space is too=
 much, we can=0A=
choose a new space of 10 samples. With the highest frequency (500Hz), a fre=
e space of =0A=
10 samples gives 20ms for the processing of the interrupt.=0A=
=0A=
>> +=A0=A0=A0=A0 new_size_byte =3D val * nb_byte;=0A=
>> +=A0=A0=A0=A0 if (new_size_byte > ((st->hw->fifo_size * 4) / 5)) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D ((st->hw->fifo_size * 4) /=
 5) / nb_byte;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 new_size_byte =3D val * nb_byte;=
=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 ret =3D inv_mpu6050_set_hw_watermark(st, new_size_byte);=
=0A=
>> +=A0=A0=A0=A0 if (ret)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 st->chip_config.wm_val =3D val;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 return 0;=0A=
>> +}=0A=
>> +=0A=
>>=A0 static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st,=
 bool sleep,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int clock, int temp_dis)=0A=
>>=A0 {=0A=
>> @@ -1290,6 +1353,39 @@ static int inv_mpu6050_reg_access(struct iio_dev =
*indio_dev,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>>=A0 }=0A=
>>=A0 =0A=
>> +static int inv_mpu6050_set_watermark(struct iio_dev *indio_dev, unsigne=
d int val)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
>> +=A0=A0=A0=A0 int ret;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 switch (st->chip_type) {=0A=
>> +=A0=A0=A0=A0 case INV_ICM20602:=0A=
>> +=A0=A0=A0=A0 case INV_ICM20690:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_compute_hw_wat=
ermark(st, val);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=A0=A0=A0=A0 default:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static int inv_mpu6050_hw_flush_to_buffer(struct iio_dev *indio_dev,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int count)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
>> +=A0=A0=A0=A0 int ret;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
>> +=A0=A0=A0=A0 ret =3D inv_mpu6050_flush_fifo(indio_dev, 0, count);=0A=
>> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
>> +=0A=
>> +=A0=A0=A0=A0 return ret;=0A=
>> +}=0A=
>> +=0A=
>>=A0 static const struct iio_info mpu_info =3D {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .read_raw =3D &inv_mpu6050_read_raw,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .write_raw =3D &inv_mpu6050_write_raw,=0A=
>> @@ -1297,6 +1393,8 @@ static const struct iio_info mpu_info =3D {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .attrs =3D &inv_attribute_group,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .validate_trigger =3D inv_mpu6050_validate_trigger,=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0 .debugfs_reg_access =3D &inv_mpu6050_reg_access,=0A=
>> +=A0=A0=A0=A0 .hwfifo_set_watermark =3D &inv_mpu6050_set_watermark,=0A=
>> +=A0=A0=A0=A0 .hwfifo_flush_to_buffer =3D &inv_mpu6050_hw_flush_to_buffe=
r,=0A=
>>=A0 };=0A=
>>=A0 =0A=
>>=A0 /*=0A=
>> @@ -1618,7 +1716,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D devm_iio_trigger=
ed_buffer_setup(dev, indio_dev,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 iio_pollfunc_store_time,=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 inv_mpu6050_read_fifo,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 inv_mpu6050_interrupt_handler,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 NULL);=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev=
_err(dev, "configure buffer fail %d\n", result);=0A=
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_iio.h=0A=
>> index c6aa36e..d925885 100644=0A=
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
>> @@ -57,6 +57,8 @@ struct inv_mpu6050_reg_map {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 u8 temperature;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 u8 int_enable;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 u8 int_status;=0A=
>> +=A0=A0=A0=A0 u8 wm_th_hb;=0A=
>> +=A0=A0=A0=A0 u8 wm_th_lb;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 u8 pwr_mgmt_1;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 u8 pwr_mgmt_2;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 u8 int_pin_cfg;=0A=
>> @@ -121,6 +123,8 @@ struct inv_mpu6050_chip_config {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 unsigned int magn_fifo_enable:1;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 u8 divider;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 u8 user_ctrl;=0A=
>> +=A0=A0=A0=A0 unsigned int wm_val;=0A=
>What are these two? Non obvious enough a comment would be good.=0A=
=0A=
I added the following lines in the Doxygen header :=0A=
=0A=
 *  @wm_val:		watermark size in number of data=0A=
 *  @wm_size:		watermark size in bytes=0A=
=0A=
>> +=A0=A0=A0=A0 unsigned int wm_size;=0A=
>>=A0 };=0A=
>>=A0 =0A=
>>=A0 /*=0A=
>> @@ -264,8 +268,19 @@ struct inv_mpu6050_state {=0A=
>>=A0 #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT=A0=A0 0x10=0A=
>>=A0 #define INV_MPU6050_BIT_RAW_DATA_RDY_INT=A0=A0=A0 0x01=0A=
>>=A0 =0A=
>> +#define INV_ICM20602_REG_FIFO_WM_INT_STATUS 0x39=0A=
>> +#define INV_ICM20602_BIT_FIFO_WM_INT=A0=A0=A0=A0=A0=A0=A0 0x40=0A=
>> +=0A=
>>=A0 #define INV_MPU6050_REG_EXT_SENS_DATA=A0=A0=A0=A0=A0=A0 0x49=0A=
>>=A0 =0A=
>> +#define INV_ICM20602_FIFO_WM_TH_HB=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x60=0A=
>> +#define INV_ICM20602_BITS_FIFO_WM_TH_HB=A0=A0=A0=A0 0x03=0A=
>> +#define INV_ICM20602_FIFO_WM_TH_LB=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x61=0A=
>> +=0A=
>> +#define INV_ICM20690_FIFO_WM_TH_HB=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x5E=0A=
>> +#define INV_ICM20690_BITS_FIFO_WM_TH_HB=A0=A0=A0=A0 0x03=0A=
>> +#define INV_ICM20690_FIFO_WM_TH_LB=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x61=0A=
>> +=0A=
>>=A0 /* I2C slaves data output from 0 to 3 */=0A=
>>=A0 #define INV_MPU6050_REG_I2C_SLV_DO(_x)=A0=A0=A0=A0=A0 (0x63 + (_x))=
=0A=
>>=A0 =0A=
>> @@ -338,7 +353,6 @@ struct inv_mpu6050_state {=0A=
>>=A0 #define INV_ICM20690_GYRO_STARTUP_TIME=A0=A0=A0=A0=A0=A0 80=0A=
>>=A0 #define INV_ICM20690_ACCEL_STARTUP_TIME=A0=A0=A0=A0=A0 10=0A=
>>=A0 =0A=
>> -=0A=
>>=A0 /* delay time in microseconds */=0A=
>>=A0 #define INV_MPU6050_REG_UP_TIME_MIN=A0=A0=A0=A0=A0=A0=A0=A0=A0 5000=
=0A=
>>=A0 #define INV_MPU6050_REG_UP_TIME_MAX=A0=A0=A0=A0=A0=A0=A0=A0=A0 10000=
=0A=
>> @@ -457,7 +471,7 @@ enum inv_mpu6050_clock_sel_e {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 NUM_CLK=0A=
>>=A0 };=0A=
>>=A0 =0A=
>> -irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);=0A=
>> +irqreturn_t inv_mpu6050_interrupt_handler(int irq, void *p);=0A=
>>=A0 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type=
);=0A=
>>=A0 int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enabl=
e);=0A=
>>=A0 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,=
=0A=
>> @@ -468,5 +482,8 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_clien=
t *client);=0A=
>>=A0 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *na=
me,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int (*inv_mpu_bus_setup)(st=
ruct iio_dev *), int chip_type);=0A=
>>=A0 extern const struct dev_pm_ops inv_mpu_pmops;=0A=
>> +int inv_mpu6050_set_hw_watermark(struct inv_mpu6050_state *st, unsigned=
 int wm_size_byte);=0A=
>> +int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsi=
gned int wm_size_byte);=0A=
>> +int inv_mpu6050_flush_fifo(struct iio_dev *indio_dev, s64 timestamp_val=
, unsigned int count);=0A=
>>=A0 =0A=
>>=A0 #endif=0A=
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_ring.c=0A=
>> index 45c3752..d6e6246 100644=0A=
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
>> @@ -40,15 +40,16 @@ static void inv_mpu6050_update_period(struct inv_mpu=
6050_state *st,=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (st->it_timestamp =3D=3D 0) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* not initialized, forced =
to use it_timestamp */=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 use_it_timestamp =3D true;=
=0A=
>> -=A0=A0=A0=A0 } else if (nb =3D=3D 1) {=0A=
>> +=A0=A0=A0=A0 } else if (nb =3D=3D st->chip_config.wm_val) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Validate the use of it=
 timestamp by checking if interrupt=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * has been delayed.=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * nb > 1 means interrupt was de=
layed for more than 1 sample,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * nb > wm_val means interrupt w=
as delayed for more than 1 sample,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * so it's obviously not =
good.=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * If watermark does not exist f=
or the chip, wm_val =3D 1.=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Compute the chip perio=
d between 2 interrupts for validating.=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D div_s64(timestamp - st->=
it_timestamp, divider);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D div_s64(timestamp - st->=
it_timestamp, divider) / st->chip_config.wm_val;=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (delta > period_min && d=
elta < period_max) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* =
update chip period and use it timestamp */=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st-=
>chip_period =3D (st->chip_period + delta) / 2;=0A=
>> @@ -89,6 +90,25 @@ static s64 inv_mpu6050_get_timestamp(struct inv_mpu60=
50_state *st)=0A=
>>=A0=A0=A0=A0=A0=A0=A0 return ts;=0A=
>>=A0 }=0A=
>>=A0 =0A=
>> +int inv_mpu6050_set_hw_watermark(struct inv_mpu6050_state *st, unsigned=
 int size)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 int ret;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 if (size =3D=3D st->chip_config.wm_size)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, st->reg->wm_th_hb, (size >> =
8) & 0xFF);=0A=
>> +=A0=A0=A0=A0 if (ret)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, st->reg->wm_th_lb, size & 0x=
FF);=0A=
>> +=A0=A0=A0=A0 if (ret)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 st->chip_config.wm_size =3D size;=0A=
>> +=A0=A0=A0=A0 return 0;=0A=
>> +}=0A=
>> +=0A=
>>=A0 static int inv_reset_fifo(struct iio_dev *indio_dev)=0A=
>>=A0 {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
>> @@ -104,43 +124,33 @@ static int inv_reset_fifo(struct iio_dev *indio_de=
v)=0A=
>>=A0 =0A=
>>=A0 reset_fifo_fail:=0A=
>>=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st->map), "reset fifo fai=
led %d\n", result);=0A=
>> -=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->int_enable,=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 INV_MPU6050_BIT_DATA_RDY_EN);=0A=
>> -=0A=
>> +=A0=A0=A0=A0 switch (st->chip_type) {=0A=
>> +=A0=A0=A0=A0 case INV_ICM20602:=0A=
>> +=A0=A0=A0=A0 case INV_ICM20690:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_hw_wate=
rmark(st, st->chip_config.wm_size);=0A=
>return inv_mpu...=0A=
=0A=
I added your solution.=0A=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=A0=A0=A0=A0 default:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_write(st->map, s=
t->reg->int_enable,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_MPU6050_BIT_DATA_RDY_EN);=0A=
>return regmap_write(...=0A=
=0A=
I added your solution.=0A=
=0A=
>> +=A0=A0=A0=A0 }=0A=
>>=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
>>=A0 }=0A=
>>=A0 =0A=
>> -/*=0A=
>> - * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.=
=0A=
>> - */=0A=
>> -irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
>=0A=
>Given the count parameter has a 'special' value of 0, please add some docu=
mentation=0A=
>for this function.=0A=
>=0A=
=0A=
I added a Doxygen header for this function :=0A=
=0A=
/**=0A=
 * inv_mpu6050_flush_fifo() - Flush fifo=0A=
 *=0A=
 * @indio_dev:		Device driver instance.=0A=
 * @timestamp_val:	the interrupt timestamp=0A=
 * @count:		Number of data to flush=0A=
 *=0A=
 * This function flush the fifo using count as the number of data to flush.=
=0A=
 * As fifo_size may differ according to the chip unsigned=0A=
 * count =3D 0 is used to set the max size of the fifo for count.=0A=
 *=0A=
 */=0A=
=0A=
>> +int inv_mpu6050_flush_fifo(struct iio_dev *indio_dev,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s64 timestamp_val, unsigned int count)=0A=
>>=A0 {=0A=
>> -=A0=A0=A0=A0 struct iio_poll_func *pf =3D p;=0A=
>> -=A0=A0=A0=A0 struct iio_dev *indio_dev =3D pf->indio_dev;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev=
);=0A=
>> -=A0=A0=A0=A0 size_t bytes_per_datum;=0A=
>> -=A0=A0=A0=A0 int result;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 u16 fifo_count;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 s64 timestamp;=0A=
>> -=A0=A0=A0=A0 int int_status;=0A=
>> +=A0=A0=A0=A0 int result;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 size_t i, nb;=0A=
>> -=0A=
>> -=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
>> -=0A=
>> -=A0=A0=A0=A0 /* ack interrupt and check status */=0A=
>> -=A0=A0=A0=A0 result =3D regmap_read(st->map, st->reg->int_status, &int_=
status);=0A=
>> -=A0=A0=A0=A0 if (result) {=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st->map)=
,=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "failed to=
 ack interrupt\n");=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto flush_fifo;=0A=
>> -=A0=A0=A0=A0 }=0A=
>> -=A0=A0=A0=A0 if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
>> +=A0=A0=A0=A0 size_t bytes_per_datum;=0A=
>>=A0 =0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (!(st->chip_config.accl_fifo_enable |=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.gyro_fifo_e=
nable |=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.magn_fifo_e=
nable))=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
>> +=0A=
>>=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum =3D 0;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.accl_fifo_enable)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_MP=
U6050_BYTES_PER_3AXIS_SENSOR;=0A=
>> @@ -161,7 +171,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_bulk_read(st->map, st->reg->fifo_=
count_h,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->data, INV_MPU6050_FIFO_COUNT_BYTE);=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 fifo_count =3D be16_to_cpup((__be16 *)&st->data[0])=
;=0A=
>>=A0 =0A=
>>=A0=A0=A0=A0=A0=A0=A0 /*=0A=
>> @@ -171,18 +181,31 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p=
)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
>>=A0=A0=A0=A0=A0=A0=A0 nb =3D 3 * bytes_per_datum;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (fifo_count >=3D st->hw->fifo_size - nb) {=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(regmap_get_device(st->map=
), "fifo overflow reset\n");=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto flush_fifo;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(regmap_get_device(st->map=
), "fifo overflow\n");=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_reset_fifo(indio_dev);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>>=A0 =0A=
>>=A0=A0=A0=A0=A0=A0=A0 /* compute and process all complete datum */=0A=
>>=A0=A0=A0=A0=A0=A0=A0 nb =3D fifo_count / bytes_per_datum;=0A=
>> -=A0=A0=A0=A0 inv_mpu6050_update_period(st, pf->timestamp, nb);=0A=
>> +=A0=A0=A0=A0 /*=0A=
>> +=A0=A0=A0=A0=A0 * As fifo_size may differ according to the chip unsigne=
d=0A=
>> +=A0=A0=A0=A0=A0 * count =3D 0 is used to choose the max value for count=
=0A=
>> +=A0=A0=A0=A0=A0 */=0A=
>=0A=
>Add this to the function documentation as it's not obvious.=0A=
>=0A=
=0A=
It is now in the header comment=0A=
=0A=
>> +=A0=A0=A0=A0 if (count =3D=3D 0)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 count =3D st->hw->fifo_size / byte=
s_per_datum;=0A=
>> +=A0=A0=A0=A0 if (timestamp_val !=3D 0)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu6050_update_period(st, time=
stamp_val, nb);=0A=
>> +=A0=A0=A0=A0 if (nb > count)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nb =3D count;=0A=
>=0A=
>nb =3D min(nb, count);=0A=
>=0A=
=0A=
I applied you solution.=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < nb; ++i) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_noinc_rea=
d(st->map, st->reg->fifo_r_w,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->data, bytes_per_=
datum);=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto flush=
_fifo;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_reset_=
fifo(indio_dev);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return res=
ult;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>> +=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* skip first samples if ne=
eded */=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st->skip_samples) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st-=
>skip_samples--;=0A=
>> @@ -192,6 +215,45 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_ti=
mestamp(indio_dev, st->data, timestamp);=0A=
>>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>>=A0 =0A=
>> +=A0=A0=A0=A0 return i;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * inv_mpu6050_interrupt_handler() - Transfer data from hardware FIFO t=
o KFIFO.=0A=
>> + */=0A=
>> +irqreturn_t inv_mpu6050_interrupt_handler(int irq, void *p)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 struct iio_poll_func *pf =3D p;=0A=
>> +=A0=A0=A0=A0 struct iio_dev *indio_dev =3D pf->indio_dev;=0A=
>> +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
>> +=A0=A0=A0=A0 int result;=0A=
>> +=A0=A0=A0=A0 int int_status;=0A=
>> +=A0=A0=A0=A0 int int_status_bit;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
>> +=0A=
>> +=A0=A0=A0=A0 /* ack interrupt and check status */=0A=
>> +=A0=A0=A0=A0 result =3D regmap_read(st->map, st->reg->int_status, &int_=
status);=0A=
>> +=A0=A0=A0=A0 if (result) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st->map)=
,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "failed to=
 ack interrupt\n");=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto flush_fifo;=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0 switch (st->chip_type) {=0A=
>> +=A0=A0=A0=A0 case INV_ICM20602:=0A=
>> +=A0=A0=A0=A0 case INV_ICM20690:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int_status_bit =3D INV_ICM20602_BI=
T_FIFO_WM_INT;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=A0=A0=A0=A0 default:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int_status_bit =3D INV_MPU6050_BIT=
_RAW_DATA_RDY_INT;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=A0=A0=A0=A0 if (!(int_status & int_status_bit))=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 inv_mpu6050_flush_fifo(indio_dev, pf->timestamp, 0);=0A=
>> +=0A=
>>=A0 end_session:=0A=
>>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
>>=A0=A0=A0=A0=A0=A0=A0 iio_trigger_notify_done(indio_dev->trig);=0A=
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio=
/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
>> index 8825468..c685ed4 100644=0A=
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
>> @@ -131,10 +131,28 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_st=
ate *st, bool enable)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret=
urn ret;=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable interrupt */=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, st->=
reg->int_enable,=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_BIT_DATA_RDY_EN);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 switch (st->chip_type) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20602:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20690:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* waterma=
rk interrupt is enabled by setting the watermark value */=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D in=
v_mpu6050_compute_hw_watermark(st, st->chip_config.wm_val);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D re=
gmap_write(st->map, st->reg->int_enable,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_BIT_DATA_RDY_EN);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>>=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, st->=
reg->int_enable, 0);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 switch (st->chip_type) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20602:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20690:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* waterma=
rk interrupt is disabled by setting the watermark value to 0 */=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D in=
v_mpu6050_set_hw_watermark(st, 0);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D re=
gmap_write(st->map, st->reg->int_enable, 0);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret=
urn ret;=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->ma=
p, st->reg->fifo_en, 0);=0A=
