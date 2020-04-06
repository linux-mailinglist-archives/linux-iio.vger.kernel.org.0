Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CDD19F0D2
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgDFHdv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 03:33:51 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:53008 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgDFHdv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 03:33:51 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0367ScAL002564;
        Mon, 6 Apr 2020 00:33:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=4n3qPraFfCDpMJrmkBdBXQrOFLGiQ1Xm5RD5s5j0vBg=;
 b=W4RtP9kKcOh7I2UWuNnn3W7shpvqlDgoMpcADjSigmJniY0GgMS0Arq1ks13zTOVcdNP
 JHVucUtAbqfB4Oxyqja0B2laGxbHuW1ziAlXvDt/4IAOmTa5ywTScfJ8h1lIpOwvZ1md
 nG8OIpnJC18Gj83Y/voGsOIxyxcZEZbE4SlRLaFRX4Lwn17yGledM6QGSxhIXyoPBjLR
 1wAyF9b4LFax1lpz/E2GjHai+xqdbt8UHDpe+tYeWc8JUjgRt09aV3rrEIZwlvxBYyAq
 tX6mSc5JH68bsSvkIrl3JssSYLnVSPrzvq7Ecu/S9CxyWY0MkAFbo1n1wG0eP2VpjBuM Ww== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00328301.pphosted.com with ESMTP id 306xk1gecc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 00:33:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfd+jZz68LncmQA6B1fRkEjNI8zDpzg0VtyuCwlIGXbvK2mCMY6VMXnFKxP/T3zVG6BopXKG0UziNrL/gWsVk4RKHSudMkaRRDtOD/XqNc9tGoIHnH3pWf7/zNGbZGhyhTQuAu8GZR1YBf1DykfBRzeCQR5ffw83NdhHFdjWFZlm7cxi9k+F/UC12J8dopgWjsyHmT7GR7afQ6xnS+VGYKEEvDdw99rPZBbFmw0PmdOZjsiIIEpt0KpDKUcLHjTGOs3x5ivhoSgp/Njx2hrxty/1cuHfkMqqZw+y0b4klb+ICLB/j3PH2DNRZBjRiVlMV4nAil9HMVxiUl2rVXhUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n3qPraFfCDpMJrmkBdBXQrOFLGiQ1Xm5RD5s5j0vBg=;
 b=Ph79f1AwvtboBJMCXx3iSp1vbgxpDz8dnmE/U0CUD0dqFUsLAugTOVCK8nis9dInADXunFaeHadORQwFWbHPPSV/gJQC7DYiS6E+UuN/0PrkwW64/6OA/eyHAfZzvdn1fuXljdUEAcDv+2gkUZs69pco1sQ6SeMGAIv/BJo0bW69IlGzhSqGbswkUDLhRjgS0qLIOvldCrPDNkCLDoHvJCSnO8fXGzWoLMnvoO0NohZJXkOVG+J6Bu4a6bSwVTBusChiXtoSgMPM/J0Vubf9pmjMgMlhIa+ZIato7DvMyC9zECIo1le2MLg5xa2dX/lsT5prmZej09fCy1y9T7NUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n3qPraFfCDpMJrmkBdBXQrOFLGiQ1Xm5RD5s5j0vBg=;
 b=jDVdovtpL69Ki/VZp84pmeTn4kmsp0mLnalPw7dbDMFzly8vjushQkija+pMg3rK5sL/rLrsWu919J/sCPMoeoq8YK5skeWjk0meVe9XcWQVBa7HKAIvW01BzwpM6klXtdgQ3j2etKZauQtyjaSij/7+1Uillw4dD5OoRgwmHj4=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3311.namprd12.prod.outlook.com (2603:10b6:208:100::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 07:33:44 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2878.017; Mon, 6 Apr 2020
 07:33:44 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime
 power
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime
 power
Thread-Index: AQHWB2HEfG9pP8WIw0etsswWO1hkTqhqieKAgAEx0HQ=
Date:   Mon, 6 Apr 2020 07:33:44 +0000
Message-ID: <MN2PR12MB44224D20FCD73D198639A5DAC4C20@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200331133850.23757-1-jmaneyrol@invensense.com>,<20200405141549.0f773f5f@archlinux>
In-Reply-To: <20200405141549.0f773f5f@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a7856b1-c7cf-406f-6dd4-08d7d9fcd615
x-ms-traffictypediagnostic: MN2PR12MB3311:
x-microsoft-antispam-prvs: <MN2PR12MB3311A2FC754BF4E2E7E8C6C6C4C20@MN2PR12MB3311.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39850400004)(71200400001)(5660300002)(9686003)(55016002)(86362001)(81166006)(15650500001)(52536014)(76116006)(81156014)(478600001)(91956017)(316002)(66446008)(64756008)(66556008)(66476007)(66946007)(8676002)(8936002)(26005)(53546011)(7696005)(2906002)(186003)(33656002)(6506007)(6916009)(4326008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JsN9vMmNQFRz7JlXV/gxYTo3KS6yFq6hHTjQ7m6zjk52BVxaf+Ui5gXsKUJ4mODnHx79nHH0xS/MIp4rET3YL23YcNeTCmOYEtlrQ8AMfEP7SKkGcjT2OenTon5KSVAfFsVTf034ivHGM4Eee4MJKxN4zly32izyLvC8EhWYvHJBu/3HkTmOqQfqzoV7KylOcpeAyoDDul7xL++9oMoP7IWoCMydgEhUBhBZbOHr18NcFBZBk0sKnyAEvs3Y+lyAEE6l0ZN3fF8ixYKrmv4WH0kiXY4vp56qPwg5VUkJD+PpBwo3+c9HhSdA7ymM3O+fC5h5yoWePK2evEG3fmGSiOsZbS4l6iU+xjYR9Tl2EWW5gSgtZ8EnA9KkJMYU5UnspByRdN3oo0bVjJizIFKbbtNHhTSx+YWiMHTxleAYhvCissjiQnKaF5k3F62UFeSc
x-ms-exchange-antispam-messagedata: 2lR6vKqXXZrKSXXpGsp5x0vZXBPv4tjKIZ5DK6PV8qLLuV+y4IuWDvO8qffu72kZTbAfdXFTeHchd9AduvQXgRLQlfyyE0lBpAlpFcsZ9VJUtPmj2MgRwKJ/icuo6ENQby/E8tHNqldS2Sozpc4bRA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7856b1-c7cf-406f-6dd4-08d7d9fcd615
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 07:33:44.0529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1xPCAv+jmh9XaWWJOfAhe4A2SDPKYHDjEIQXwuIdxh9IOJ2PbzVnKf2uqlARR1U5/T7HYehRbbgvQCazn07Pb02J0M8mUE3cY0dp8w1riU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_03:2020-04-03,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060063
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
there were 2 issues with suspend/resume when the device was already suspend=
ed by runtime pm.=0A=
=0A=
When entering suspend, there was an error in logs because we were disabling=
 vddio regulator although it was already disabled.=0A=
And when resuming, the chip was pull back to full power but the pm_runtime =
state was not updated. So it was believing it was still suspended.=0A=
=0A=
Do you need a new patch with full description?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Sent: Sunday, April 5, 2020 15:15=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime=
 power=0A=
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
On Tue, 31 Mar 2020 15:38:50 +0200=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Suspend/resume were not working correctly with pm runtime.=0A=
=0A=
=0A=
=0A=
Need more info than that!=0A=
=0A=
Anyhow, when you say "not working correctly" what is happening that=0A=
=0A=
is wrong?=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
> Now suspend check if the chip is already suspended, and=0A=
=0A=
> resume put runtime pm in the correct state.=0A=
=0A=
> =0A=
=0A=
> Fixes: 4599cac84614 ("iio: imu: inv_mpu6050: use runtime pm with autosusp=
end")=0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 11 ++++++++++-=0A=
=0A=
>=A0 1 file changed, 10 insertions(+), 1 deletion(-)=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> index e4b0d368c2f9..a58bab03f0b0 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> @@ -1636,6 +1636,10 @@ static int __maybe_unused inv_mpu_resume(struct de=
vice *dev)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_disable(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_set_active(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_enable(dev);=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
Looking at the docs, we should do this if we were previously suspended and =
no longer=0A=
=0A=
are.=A0 Not sure we should do it we weren't previously in runtime suspend?=
=0A=
=0A=
=0A=
=0A=
I guess it is idempotent anyway so if we were previously enabled we just se=
t it again.=0A=
=0A=
So probably fine.=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engine(st, true, st->s=
uspended_sensors);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> @@ -1657,13 +1661,18 @@ static int __maybe_unused inv_mpu_suspend(struct =
device *dev)=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 st->suspended_sensors =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 if (pm_runtime_suspended(dev)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (iio_buffer_enabled(indio_dev)) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_prepa=
re_fifo(st, false);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 out_unlock;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 st->suspended_sensors =3D 0;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.accl_en)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->suspended_sensors |=3D I=
NV_MPU6050_SENSOR_ACCL;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.gyro_en)=0A=
=0A=
=0A=
=0A=
