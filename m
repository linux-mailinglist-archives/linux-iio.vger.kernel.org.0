Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B663B8EAC
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhGAIMw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 04:12:52 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:40222 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234905AbhGAIMw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 04:12:52 -0400
X-Greylist: delayed 1624 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2021 04:12:52 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1617QirB011894;
        Thu, 1 Jul 2021 00:43:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=zZ2pcAtWh09jSxu0WfmsTwd06Mrvcx5aSSt1C2f/GZA=;
 b=tAnokOC7On3JAjtMyZAgUymG3PUvQhxxSirBYvpZT6OxOCctUgoRTebJrXm9R2DCRABy
 fR4W9xdc9O+YpBDBFUASy9FDj77/3N7VJ0RxqQyzZcOyeS+IfbYJyaiajeGBCmNVn4jh
 oad1Fa7O9htBabzVOeCjYKQn9DI8eV+GvIZoqg0+MtAgm5X57Rn/jZCm7Ku2ENTFVy6f
 34JYuY2wdjLDH3NlrE/Cec6IVnn/43cce29982hT2g3KO/hodoq2d40xZYwVjaAKfzjp
 7l+tjL2q5+PIT2ytUdqPGWWYaJLpv9NjBtY2jLwDzYp9+wOYF3bgU95D6KXs85zRP5UG vQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by mx0a-00328301.pphosted.com with ESMTP id 39gxb98908-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 00:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq43oWv18qImVGYvaGDXvzDq9/rEndFgOKpRGZSV+57qU4jTfCltP+AyURHdPR60oRKGsU5PEPoLjxWIFg7W66ErNqjp6L35ZDZWxiEEeFP2bVlj9/4nYq7wIiyAsFElFsJ7JwQAE5/TnmOK2+2EOJP7gySK661UhDi0OJXolO0lXUqkAo2UFyVW7lpbDuBKSz3pbrTFsguTKb6yXCWBdg/XGIX2eeOUCbGFJsPA9QbWpDHlratCsX4Dext85KAMyjncUgI/VadaU6LJWOSqUIb+HaE3qq9p0DcMliCd0OZrDZ8IL+QFu41bKBlw3wQDVdnbC8hrB53Sab066GVYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ2pcAtWh09jSxu0WfmsTwd06Mrvcx5aSSt1C2f/GZA=;
 b=nJANrLwFlivk4TFuFWu4DzOns98ccF4NyNY2PlqzADKLbYWha4t60JVFrDs2ygpwP79IfMyTkRL2Ng9TQLlxTpRJngUMPaZDBxqClBe9PWA08FhSwnufq0yUXav2mVCG1SrbsK9hMBMjE5Z/FazDbwGvHvKa7frzyf8EpqBlM/6oo3Ch4C3UhrWMJk6eBstdE/nM21PtbexT74bp5ZtAO8KVtzJ/VgkhreQtNXUrxfPuhmaC9OeitK8uXHPa7liFTd7v/JQuKloljIggxDBpKKWsQXYAXRgvF11m/e8sH5l9ce81qD0D3faoAMq8HYNY+tgnAgu8bfBt4LrU3VFYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ2pcAtWh09jSxu0WfmsTwd06Mrvcx5aSSt1C2f/GZA=;
 b=MNTaInZzO2n6gad30eKOBpIeTdOxCzxD+VWWvCiiyY2KrAwwcoTDIkkB5OBy+sbYpa2xGuvo0SMyOpKj4NvqdO5d17FYKurIDtsXinb5vv7sRyl3Zfhz5eMlva6/0LA7B5lv9OwY56hMwhbvbSmT0/LQM3PZ+KUutPGhvGJMvrQ=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Thu, 1 Jul
 2021 07:43:15 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::e080:c98e:1dee:51ec]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::e080:c98e:1dee:51ec%6]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 07:43:15 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Baptiste Mansuy <bmansuy@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: --[[SPOOF or PHISHING]]--Re: --[[SPOOF or PHISHING]]--[PATCH] Add
 startup time for each chip using inv_mpu6050 driver
Thread-Topic: --[[SPOOF or PHISHING]]--Re: --[[SPOOF or PHISHING]]--[PATCH]
 Add startup time for each chip using inv_mpu6050 driver
Thread-Index: AQHXZn1EofjUMbukf0in+zSDH/q2naseLqJpgA+/K+U=
Date:   Thu, 1 Jul 2021 07:43:15 +0000
Message-ID: <BL0PR12MB501195F97958F932724F11ECC4009@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210621085731.9212-1-bmansuy@invensense.com>,<BL0PR12MB5011C3AAC67AF825FAA86857C40A9@BL0PR12MB5011.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB5011C3AAC67AF825FAA86857C40A9@BL0PR12MB5011.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 307bc913-79ff-4302-aa6b-08d93c63e2c5
x-ms-traffictypediagnostic: BL0PR12MB4931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB49310878295B0D626EB4E507C4009@BL0PR12MB4931.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWSSY+qxri49YSe3icoN9QuEthYrvidn2IrPgE28DZSgNVQ0X/M3faxPmZcsH2D6UPsPcSzHUhcQwTOJz6E7uUR9rK+vJKbyRD4KJItDjVnBFSC2ldkl7GAudGvmbrM7nIGVUiZ37QcGt62fisIJjZMjsgzAJ/6GBwBpe/6X6nX7pm1zqZBHknL4NxM665x4pCDx8ySeipn2TKW62wMc1xeEGjUJctvzv4SGZnlztx+5+HdlrtthK8uCuvAPgQTXc8IiX5tGbGrBZaOPQVrLjtr31mQuzZMN0CqMyoSCAzU25VG/SRzNGm62s9JVGIP/tfrVByQtKH7Wqjf113+tmpkKyKfvlmLROjidO6njrExkPWgvhkdT0TtMHF5b0xV9yUpWEQqz/GfViZFTyD6Kfof8wI0WzUry+yg73ZtCwsmrWXVnGKfJ5ibaCtPTX9SiDxAadg9/40G+sSCi7yk9V+MJrWlxlI32w2ehlRpYKYa0mnNU9x/weYVsSk2ydPSORs2kQxJcVjzrtBmnKNijzDoAuXGllEzgXJiHlLwLNPNU8Ihl9CkOSJpGn9s7jwg7H90ZBEawRDRPt+VvpWKjwiV5TOpQLaiRRwUs85zeYriObj4Q1BlwID2vrMnKqczOvijnSSbFDE3mbDsaHtT5wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39850400004)(376002)(396003)(52536014)(26005)(478600001)(64756008)(122000001)(66946007)(66476007)(66556008)(66446008)(6506007)(53546011)(55016002)(38100700002)(4326008)(76116006)(33656002)(91956017)(186003)(83380400001)(9686003)(86362001)(8676002)(8936002)(71200400001)(6916009)(7696005)(316002)(54906003)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4Ac/CBcC/Q51B0fKdeR71ArQn/uS9MgoWpxt5gKXEMPxE+knuAWEoOdQmj?=
 =?iso-8859-1?Q?hUPTuPM6FhpUAu8hJYERLlUlDk34BCK60mKdL+9/3fgNuEMW0Sk7r1G37j?=
 =?iso-8859-1?Q?a5pYl5J+LvFvLprw3sRRWyEVwt4vz0Elqu63HbS6UVervU/kTA0MHYpNwF?=
 =?iso-8859-1?Q?vAhSc9qLpIhtUaICVcK4D9XCfnMZbW1aPXKwhIi/MEvhNhO2YL7tSWF5kw?=
 =?iso-8859-1?Q?pSxpdxPZ+FxR8RX2qkhNOyIF60g5j3kIOzevbvtP1XyfmR0uZFUHIs4xeA?=
 =?iso-8859-1?Q?FEhy+8WUf1PbFGjWiIO/Ai8SVmdZoRYUgo9BtSxk81QZjPYHhVqEUsmtd/?=
 =?iso-8859-1?Q?zKMFbRKfuJckIz+eWzTXhsKoFNGEY3qaHba2RtDb1a5ktjrg/PPmC1MfN5?=
 =?iso-8859-1?Q?0UI2PtvOzdisbKw6lBgI3kqSDftMPYvHh01qxfI6JxdCgdAN2gGVNN/BqZ?=
 =?iso-8859-1?Q?4Vd/basymEVSAStipPIRsrn3PgsbIVdm5HfdhnFN5XaQO5Z4j03MK6qh0F?=
 =?iso-8859-1?Q?uVnQnanCEtBYFvgj74FQVL3pyvGxbev4juBpBlbECVIxM+gp2LW9B7lIPD?=
 =?iso-8859-1?Q?b5g2ZUUdZO0e3StYfxCDcAIh+pY2NQLDgHA5zjpLybxuizIrZneg/Vq50X?=
 =?iso-8859-1?Q?06l0yUpTOJU/O4hiAPbQ//848cYC6POIEAV6cetrRu71aR6EeCObexpG1G?=
 =?iso-8859-1?Q?fh7EU7m/NTSLTF2RdWoXaKLVLZAfHfc81IWARonoKaPLIRiFufKgNL46jM?=
 =?iso-8859-1?Q?4XACzTyQfL7CHo+Gl6uH1Pb83pCPLg2O993Iq6cL5IZ6DeVWkhDeROTVJk?=
 =?iso-8859-1?Q?QrwrJjYTBZaezOA6z37/0dj0Leh3FYtG8MntRgYZ8BisQiVfdoXAFlJgfk?=
 =?iso-8859-1?Q?fZplloqsl/0CuegHa7WZk1IrE+wTC7G/E9myKy74ASVmBaexy5Sm4XgQdQ?=
 =?iso-8859-1?Q?Hg3ML/5ByUsQwPrLHGqZSD4c5+4c/U/qguyOuDeO2NrQNfpNIFk0Dyqgsv?=
 =?iso-8859-1?Q?XnholLWcKeTuy2TDv7UdBweSnwzP282rQeeDCUmxZP5jwE3TxGbJvEo3Fv?=
 =?iso-8859-1?Q?Aqtc6XOvRgJEcBZbpVazgaRDEMxdoWg7LB03GkWg01920wyxuZrGA0bNvv?=
 =?iso-8859-1?Q?GlqsYugBBDdDL2tIGVNMLMT+m74md6zEReh0vYPc8VnJgRZrrC/L6nYMk/?=
 =?iso-8859-1?Q?LDiaQUbpl/W88c3UX+cFim09sBLjWh3nQCkFD5ibTMerHAwOp0Yb7y8Q6H?=
 =?iso-8859-1?Q?KkEfdGwNVzVvFDuYf429R41P23CVv3y/NXQ/Q8HhAHJYnrYADQHZCaF7zE?=
 =?iso-8859-1?Q?76R5QiZoX8bkhUnoI/9bAhL0u8X3fA1K7AeUVsBTbANteXM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307bc913-79ff-4302-aa6b-08d93c63e2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 07:43:15.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgI0DXPadS7Ts4HJw9vvkapJwjZLGDxc6fFSkNUS236IbmOx35MJigK2wMpocjHs6MGiDV6vcfGmfZSMNvD38NKiNnWJyvUYTD6j7ama8Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
X-Proofpoint-GUID: FiMRbBg1KBkN_10qb5tTLpjvHiKNVK4L
X-Proofpoint-ORIG-GUID: FiMRbBg1KBkN_10qb5tTLpjvHiKNVK4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-07-01_01,2021-06-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
any news about this patch?=0A=
=0A=
Thanks for your feedback,=0A=
JB=0A=
=0A=
=0A=
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Sent: Monday, June 21, 2021 11:16=0A=
To: Baptiste Mansuy <bmansuy@invensense.com>; linux-iio@vger.kernel.org <li=
nux-iio@vger.kernel.org>=0A=
Subject: --[[SPOOF or PHISHING]]--Re: --[[SPOOF or PHISHING]]--[PATCH] Add =
startup time for each chip using inv_mpu6050 driver =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
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
2.25.1=
