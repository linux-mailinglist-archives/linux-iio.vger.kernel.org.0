Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C207E130FAF
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2020 10:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgAFJme (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jan 2020 04:42:34 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:44268 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgAFJme (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jan 2020 04:42:34 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0069fR8O020951;
        Mon, 6 Jan 2020 01:42:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=UCNkm5Hqq6ur+sONMumRnli3SO+IU0O4ZCIHT7SpkZM=;
 b=G4nHddx33BpSWChqu5Kye5oinH7AtsJ6bCd+84JeOjMEK+u0iY6qaT/QY+XqTz5irPKx
 v7HO7jNKNDj8mT7x+Ef5YVIiWsyVp5cK9h1Hjlt2jm6AyuDCYwTzBNxUzX0yYM0NpuKn
 Kw3x9rdkT0vNDiAARTs5kDh4vYucAYRgg44baxbRZ+NeR8GXm1FQest9wwec1OVphNsW
 NMTf6ghiqvR9XDWH4Zll3ltMFCPaS+5K7/EXCdbs/WpHGiCV0pBSKvn9r9tX19dfp9aV
 BjZtAxQGSxbCxeSR/OHvlp92/K4CmZKBeiRWAp3MUbluFydndlcgZ/JOFrdN8tMaXjst 0A== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0a-00328301.pphosted.com with ESMTP id 2xaq2tgtvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 01:42:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J95mykiyGAdnFfVv92pPN3yeOE1DcR94WQ2V6fhoJ5Gdt8dytcYH6H5O9iI3SBDJA8TR4r0FPLNneGGJpvhWtjWb52mNjxEpe9xRgwf4u2sQnGeaVsILdPjGGsgM7DT+7IzEKHVVooxWf8tfqQzEYfQn/N1Kk5VYYR3fxwkkq0CK9mEmgbgGb3THTpZVVa8h+ETP5SjGUT5d/M3BkKy/Dlvig/vmIxI4XJMUAFgTF2k0bT1MdLJVOnVESfrRjcrH7HW554ZgvgTpesvhGmoNE0/EPD/xZU5gxJfs4yMB0dU+Z8mu52hzv8Q2mX0hADR0f6ZHBt0K9zQH/dqGf4nLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCNkm5Hqq6ur+sONMumRnli3SO+IU0O4ZCIHT7SpkZM=;
 b=AxP20EnAcBDbDYUSkhC0+nfoswwZSRLd0bocr6XDmA1Ea/RDDUL4+2WUg5lmRBFMI0nULSh3FyTkNpE0lawOHnk49hK5sTuxMGPtKZlEXHZqjbdhOeZ07oK/1+woeLYV5VmUiJBhaBSBsvmzQGxmCcHIqZ47UQQEize3jrUlnAeCepp6i5AjOxZLZHyq/sGEYsvJ7Z2FnUP7PYCsRbSO75+/IFULOcOhqG3BmhvJHxoJmZ9L2lj2JlfDNaX0LpUmrOKb1oIQJ9fXl6gERh370HMyTLAKGJOYzKKsVMW0ZYaepxtN2U+dNbO2QF9JKiuesDFmRKtC9a8X+XXxRzM+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCNkm5Hqq6ur+sONMumRnli3SO+IU0O4ZCIHT7SpkZM=;
 b=fc96r5+NJ/Pgvv3hy6soLm7uPPz5iknqNhxqaji9VqhHkFixtj972hLKS4wCdA+rk3AXrDvTwurX07HLfdc4bHWSCcU75TzfCmugi35hCff73SW/ibA7jGZfM83cocJXzM8shnno0GhFYcK2jIsiYepRpkjX22Vnr9AxO46M0mg=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4192.namprd12.prod.outlook.com (52.135.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Mon, 6 Jan 2020 09:42:00 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::d8f8:bea1:1dba:a5cf]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::d8f8:bea1:1dba:a5cf%7]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 09:42:00 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu/mpu6050: support dual-edge IRQ
Thread-Topic: [PATCH] iio: imu/mpu6050: support dual-edge IRQ
Thread-Index: AQHVwx5GRqw8i2TNS0SP7XRwRJJyD6fdY4sb
Date:   Mon, 6 Jan 2020 09:42:00 +0000
Message-ID: <MN2PR12MB33737F067F25B2F7477C4FE5C43C0@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <e03daea84ce5fe5e79311a07fee4636c2a884a8e.1578156240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <e03daea84ce5fe5e79311a07fee4636c2a884a8e.1578156240.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0bf2780-3fb3-4a50-9253-08d7928cadcd
x-ms-traffictypediagnostic: MN2PR12MB4192:
x-microsoft-antispam-prvs: <MN2PR12MB4192170EB920F53165A5989BC43C0@MN2PR12MB4192.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39850400004)(396003)(346002)(199004)(189003)(8936002)(2906002)(5660300002)(86362001)(316002)(7696005)(66574012)(81156014)(52536014)(55016002)(9686003)(81166006)(66946007)(53546011)(6506007)(33656002)(478600001)(66476007)(66446008)(66556008)(64756008)(8676002)(186003)(54906003)(110136005)(71200400001)(26005)(4326008)(91956017)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4192;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4daB8ZejlqcHdWG7i9qcSKJpTGZvAm8XdZAwimdEek1YJxWt/ziFWy70EXIl/L9BCx+KShLBhxrgAEtUAl3Sld2xliDWpvYtna0zXvfEAYY1cIG/HbV0tdob4Ha4gtu8w7HMZGCDXY7wx+8ZV+23cbyM8d531eh9ldjS7fUg0jht+AkGCrNpMC818Ua6iTcnq/sSNq7BACEPO4qFo4tmf5bSzPgRBCUnp0WDZ2ywVGBJ1LOAEMlrKt50fTS+idRfo9csR2pb/okMsWU2Av8VxpJrfPIEE3UCzGU06UQinHKoDxxiw21yKFlYj6oQqdW89FHpn4UlrbQU4QtTewtWxzT2GDaPMnRKFnZ2n+0heIEoWqQtdJNANT7opSXepaMY3mnPeKM8Ytz1kZ38IemXefodownLENS1nyeyPkeSxpiCWZkVdHD05BvAlMaxcSp/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bf2780-3fb3-4a50-9253-08d7928cadcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 09:42:00.1933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2iz+n1iZciwCDLpip0uPe67wxxugp3ebptwmCRIKoVqWsyESg0xHyfCbQ+ehnQSNmmo73430En69aAEkppMNiT7HQS0pVxi1oIb5QSAU/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_02:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060088
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Michal,=0A=
=0A=
interesting, thanks a lot.=0A=
=0A=
It would be far better to simply delete the warning log for spurious interr=
upt. I was thinking that it would only be triggered by a real bug somewhere=
. I wasn't thinking about systems with any-edge trigger like yours.=0A=
=0A=
So just delete the warn message and no need to add the irq_ignore_spurious =
logic and variable.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>=0A=
=0A=
Sent: Saturday, January 4, 2020 17:44=0A=
=0A=
To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; =
Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw=
.net>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vge=
r.kernel.org <linux-kernel@vger.kernel.org>=0A=
=0A=
Subject: [PATCH] iio: imu/mpu6050: support dual-edge IRQ=0A=
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
=0A=
=0A=
Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>=0A=
=0A=
---=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 ++-=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 | 1 +=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 6 ++++--=0A=
=0A=
=A03 files changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
=0A=
index 0686e41bb8a1..36b6a3922d15 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
@@ -1239,9 +1239,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int ir=
q, const char *name,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 irq_type =3D irqd_get_trigger_type(desc);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 st->irq_ignore_spurious =3D irq_type =3D=3D (IRQF_TRIGG=
ER_RISING|IRQF_TRIGGER_FALLING);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!irq_type)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 irq_type =3D IRQF_TRIGGER_=
RISING;=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 if (irq_type =3D=3D IRQF_TRIGGER_RISING)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (irq_type =3D=3D IRQF_TRIGGER_RISING || st->irq_igno=
re_spurious)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->irq_mask =3D INV_MPU60=
50_ACTIVE_HIGH;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 else if (irq_type =3D=3D IRQF_TRIGGER_FALLING)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->irq_mask =3D INV_MPU60=
50_ACTIVE_LOW;=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
=0A=
index b096e010d4ee..94ee7b18b198 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
@@ -158,6 +158,7 @@ struct inv_mpu6050_state {=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct regmap *map;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int irq;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 u8 irq_mask;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 u8 irq_ignore_spurious;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned skip_samples;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s64 chip_period;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s64 it_timestamp;=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_ring.c=0A=
=0A=
index 10d16ec5104b..52f02de3d9b0 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
=0A=
@@ -184,8 +184,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto flush_fifo;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_IN=
T)) {=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(regmap_get_device(st->=
map),=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "spurio=
us interrupt with status 0x%x\n", int_status);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->irq_ignore_spurious)=
=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_war=
n(regmap_get_device(st->map),=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 "spurious interrupt with status 0x%x\n",=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 int_status);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=A0=0A=
=0A=
-- =0A=
=0A=
2.20.1=0A=
=0A=
=0A=
=0A=
