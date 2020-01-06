Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32501315D6
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2020 17:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAFQON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jan 2020 11:14:13 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:49592 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgAFQON (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jan 2020 11:14:13 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006G9uuB017123;
        Mon, 6 Jan 2020 08:13:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=hVR1gk9hbqQGc3PHflhvUL4bf1DwQq6qk4jORRCB+UU=;
 b=ai/IAjtbv+QG+m2xPPROT7AKKOk8yr+CZ41Ub3qBIeuv8fQdnVThqNaBPsL9vYh1Q6Pf
 DwNaZhnZjMkHOEbNF9zKrMto/UFeuF62cSeyiaFD2KvAe9noxSRz58c85bPGlF6zHnMW
 VGLqedNQ4UDcD8I2VccbkEET1cpKmCOF6lP60TDrzefa2aOtKrDDEZHJPxyy0JO2YjH5
 uzoB/RV0kPaW2x31Ma3F6kdDBhk8AsLbdkm8LspfpZSRdpCId+UDJ2uPeiM0VZj20qVT
 BBjeps4M2D/+7Q3ulP4ywHYXOfY+KwNqORvl1Q3tmiQPOGZF8nW6t+EMKjROFlUGWFWQ oQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00328301.pphosted.com with ESMTP id 2xaq2tgyqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 08:13:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfbwTIS550Y+6AB6aU0xFNbtQf8AJ+mifufN/zPwdbIfd7LMkjFdddHuL3bIh7W4vx47wbM4ELl8CLubIWfbsJ8chGAi/ptg6K2bcS+qLlc/BtwoZpFdmTMzPMz2c33SX5Dp7KY1enQp0uisYGVRb3wl4EYEXygdaeAVIzY6FvYf24LouBL8JOcmXiRUqbAb46fw727+WzsxX8c2/j8pcAXWhe6PAjtry3siiM9XXvAA1ZAW6RQEM02vBPuEBysC6oLP9BJvGR5GNXhWE9fGYMrzrXwvcnCD3HdpXm3Hc+b/DeMWx78JELjqBjGzV2oZqCInFBo48ZcrcNtlVMh61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVR1gk9hbqQGc3PHflhvUL4bf1DwQq6qk4jORRCB+UU=;
 b=gx9tsf467XOpgp08AzG+3CghsYY6RmkkXRwmp+QrnYVdjUIOT/XyjluQzTG+4sAFkN6e3K9Y6Cw5qRPCrktIvuRhv1FN4jb7R52/9ji3tyJ7UVdslJqrBAIejXHVJgAAsJ5NxB0leM6wgYBXUijA0Hc9i1jgtca7ShOihzBlXzePGl1AF/NJ4aA8k45GeLYB/aIt5UlIn4KaWIMi9Vgp03R7NPALk1KEsG/b4W8bVQ8v9jLPLwqh1fvbqsdsHtlLL756/2Py/gt4eMhRyHN0eF57DALFmE4NtgPOi3pNFSqJSoZoygM9pxeV8LJVoL08JoiAGRAtL1nOp+tOgbe0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVR1gk9hbqQGc3PHflhvUL4bf1DwQq6qk4jORRCB+UU=;
 b=SCecskDlWRKZ1yQIY11wyttYUZKkmuz/6G8dKgNeppIU07F5Wr0PgpNVSbpS5K5BRifMrfOM/SKw34vItS0mS//36zZLhnjRaMoYM0rbsPTwE9ekxtx9pSQbcCJlEcMjbwa02p2HuTsDSUJJqPGWPFqMnbEVSClBRIPMbZ3Yfmw=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2912.namprd12.prod.outlook.com (20.179.81.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Mon, 6 Jan 2020 16:13:39 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::d8f8:bea1:1dba:a5cf]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::d8f8:bea1:1dba:a5cf%7]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 16:13:39 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu/mpu6050: support dual-edge IRQ
Thread-Topic: [PATCH v2] iio: imu/mpu6050: support dual-edge IRQ
Thread-Index: AQHVxIL1X8uqoSBOtEqEaUxIjN5owafdzwkw
Date:   Mon, 6 Jan 2020 16:13:39 +0000
Message-ID: <MN2PR12MB337391664F21D198A17A5894C43C0@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <MN2PR12MB33737F067F25B2F7477C4FE5C43C0@MN2PR12MB3373.namprd12.prod.outlook.com>,<e5b39c16dc6dcb25324f6e8389cc0d0f895c1cbd.1578309319.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <e5b39c16dc6dcb25324f6e8389cc0d0f895c1cbd.1578309319.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64c08169-7467-4624-c709-08d792c36469
x-ms-traffictypediagnostic: MN2PR12MB2912:
x-microsoft-antispam-prvs: <MN2PR12MB29120DCF650451B14441982FC43C0@MN2PR12MB2912.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(33656002)(81156014)(81166006)(71200400001)(4326008)(8676002)(6506007)(53546011)(7696005)(26005)(186003)(478600001)(8936002)(52536014)(9686003)(66446008)(55016002)(86362001)(64756008)(5660300002)(91956017)(66556008)(110136005)(66476007)(2906002)(316002)(54906003)(66946007)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2912;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4K+w6AS1weSt2ck0qPPStxAS8WC2Ww5JyC98ZA9T43TIFGtfr6SC09qXxb1WqcBoBBlUvG/wfBqwTgVtj6NmVscPytS0h7relnPesNikfBq+nBp7ttMmTkIj7kEAVfZr+92vTTpY+ZQ/SHkfGH/EmtDv9EFAvxtWWIWB1+qwQiD/kvOXsAJMBOF3pYG17MFMs4FGyfa2AkKbCYTvUyV+R1p7t1WGoxnsp7bzZ8eYJXO5CNJOU3qQmGMdNYcmIl6w1PA/yHEIW/m4OwPtd96P6nEkw1E7uvGbm++5WF6e3S8FNMaNjNuDi/PPFZPI+CGXMcp9N/Z7e+LImRP79N2PN85lSLs3dglvb3VCCHSr3oHNkhr2rMHCvz+bCsL1mEXR5pBC7qIGgXMrSXrfSHcI89voaGEDRdSGo3xPjCGXfKftWx8dNWbJbrWGDBGxllWa
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c08169-7467-4624-c709-08d792c36469
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 16:13:39.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtqUT4/HT/JqMRRBo0RgKFB/TW1hx1dkxiqwhYNh3j6I1HkI+7bNykFO1hwLTX5kLtGO209GvBy9qixQLM3t8ibIG0cx/GHrvbcQ7H4JE0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
looks good for me.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>=0A=
=0A=
Sent: Monday, January 6, 2020 12:17=0A=
=0A=
To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; =
Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw=
.net>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vge=
r.kernel.org <linux-kernel@vger.kernel.org>=0A=
=0A=
Subject: [PATCH v2] iio: imu/mpu6050: support dual-edge IRQ=0A=
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
Make mpu6050 usable on platforms which provide only any-edge interrupts.=0A=
=0A=
This also covers shared interrupt case.=0A=
=0A=
=0A=
=0A=
Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>=0A=
=0A=
=0A=
=0A=
---=0A=
=0A=
v2:=0A=
=0A=
=A0=A0 just remove the dev_warn() message=0A=
=0A=
=0A=
=0A=
Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>=0A=
=0A=
---=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 5 +----=0A=
=0A=
=A02 files changed, 2 insertions(+), 5 deletions(-)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
=0A=
index 0686e41bb8a1..b3d138091f89 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
@@ -1241,7 +1241,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq=
, const char *name,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 irq_type =3D irqd_get_trigger_type(desc);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!irq_type)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 irq_type =3D IRQF_TRIGGER_=
RISING;=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 if (irq_type =3D=3D IRQF_TRIGGER_RISING)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (irq_type & IRQF_TRIGGER_RISING)=A0=A0=A0=A0 // risi=
ng or both-edge=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->irq_mask =3D INV_MPU60=
50_ACTIVE_HIGH;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 else if (irq_type =3D=3D IRQF_TRIGGER_FALLING)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->irq_mask =3D INV_MPU60=
50_ACTIVE_LOW;=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_ring.c=0A=
=0A=
index 10d16ec5104b..a4dc2c4a3ca5 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
=0A=
@@ -183,11 +183,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "f=
ailed to ack interrupt\n");=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto flush_fifo;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT)) {=
=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(regmap_get_device(st->=
map),=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "spurio=
us interrupt with status 0x%x\n", int_status);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!(st->chip_config.accl_fifo_enable |=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.gyro_fifo_=
enable |=0A=
=0A=
-- =0A=
=0A=
2.20.1=0A=
=0A=
=0A=
=0A=
