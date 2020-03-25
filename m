Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED7B193105
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 20:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgCYTV1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 15:21:27 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:24000 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727279AbgCYTV1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 15:21:27 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PJ7po0030129;
        Wed, 25 Mar 2020 12:21:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=yYTBmhoInJAw4ycyiMtQBVJvC0KOB2iQC0wR42Tw64Y=;
 b=GkmAriyR1Sbgw+jTajlrc5e5C8tw9ju5m2oeT3jNPeNDtEWjwIqAexAZRErd9kqv+5zK
 2CNDzCji8mGUR1KphwHZwNe+akJ+9IoeVeRoajNLH0JD5tGJ+juLu6vNwKrN6+Agp7f+
 PnXccGr1ua2hCUhVbDWN0wlWFZ0UgOkG3kDhlscmcRMm6dbBRTIYhjnZRxmnma0K7l48
 qDigMOINRMu3IYvKXwAM/jwAMc+p+J4/PNSUAzcUB+E0lu2BMaMpC+glIecCaRRi96so
 zZMYPzknUDMgGIovlcT4zRibxv0TlxnPPuRQ0pWKUlvFVGcq9JtbsXjeyAGUB9idYJnA cQ== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by mx0b-00328301.pphosted.com with ESMTP id 300bux01c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 12:21:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ1ujRW1Pj5y1E8s5JWpjJmDx4CITNgHrM5y1YgJoWdJV7kqq+k2d2Vw5/sR/4C+Frt3Gt5zZ1pQT/hftCQ2lZvhSdk5nYqNVZmEHHB/biJjREfP/tlERwT+APfdZGhP0qWpQDKTyIx7H0KSlFvALR4JJg3DkKItLFJz7E+e6pUKNBcN81Zb8+MUE6SOfNVKyXaRf63NF/gBmSY0D7fkbQiZfGdb8pitKTRE5VhTtYFQXWdZu7g4+EKrB8U9Z3sBwwtAaU9rwE78r8+OP2oZb9nIvGIjWkxaE7buLWtKJFXlDMLWZqGhiCFg+T+uhPe4rD6DZStYsw0QSdw5FWUTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYTBmhoInJAw4ycyiMtQBVJvC0KOB2iQC0wR42Tw64Y=;
 b=ODW1LAasrPVRWjlA5Xg+7R1/QMPGUlvY3AXEs8nOGbjNe2KfBF1my4jfqRnI708DBF/uP3cdFo5x0ADa0JIaAGV5dnMJ6y54HvFb9pE8o2oHxb7L7xv2h52mQ4/cMEmQetkORQpkGhJI1kK+7jVf7kmp+0+DCeLfVZADYCyWoRhVO99ELDrhYLNmAmCU+5klnUhboQZ8GUfZZuTTL6nIXI79xYaPRTDiHIOiL+b86CaiXHlTmDnz4NgF+4qCmyJq/UNWxQzI+gpeYFZw0g6sO2BDGsu0UEEEzoOXP2upRtTLSqJ0IEKOxihsa/s/7Ync539dwbi6ShC6B43AspS69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYTBmhoInJAw4ycyiMtQBVJvC0KOB2iQC0wR42Tw64Y=;
 b=lhS3R8gnuoG0NCQa9gABnqQ/iczjb65TPd1HOO1mm+7x2WF+Mb0JeNEmNE4YVLGwzK87jCtTsk+9eKoAwjie4o/xXWnSr2x5v9T6dwfvnzB8SxxAYetfUXqDUo032f4MLlhhcx4m9GKsRI2LGtpzHJxYsLsD74WGFTRYZ2RuA6s=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 25 Mar
 2020 19:21:21 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 19:21:21 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 12/13] iio: imu: inv_mpu6050: use runtime pm with
 autosuspend
Thread-Topic: [PATCH v2 12/13] iio: imu: inv_mpu6050: use runtime pm with
 autosuspend
Thread-Index: AQHV5zKiPKrK9DXwykeLcHDQk3kYfKhYduSAgAFvH6o=
Date:   Wed, 25 Mar 2020 19:21:21 +0000
Message-ID: <MN2PR12MB44226E64423AA0338D061636C4CE0@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
 <20200219143958.3548-13-jmaneyrol@invensense.com>,<e7c7dc02-bf91-9300-19c5-ce8fe16f549f@gmail.com>
In-Reply-To: <e7c7dc02-bf91-9300-19c5-ce8fe16f549f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a01:e0a:393:a700:4db5:27d5:7e25:3ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b32de559-4b32-4cf4-820b-08d7d0f1b369
x-ms-traffictypediagnostic: MN2PR12MB4207:
x-microsoft-antispam-prvs: <MN2PR12MB420721BC67CA9B991E12EE94C4CE0@MN2PR12MB4207.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39850400004)(346002)(136003)(396003)(8676002)(110136005)(52536014)(76116006)(5660300002)(91956017)(71200400001)(186003)(8936002)(478600001)(6506007)(2906002)(316002)(33656002)(81156014)(9686003)(86362001)(7696005)(66946007)(66476007)(66446008)(55016002)(64756008)(66556008)(81166006)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4207;H:MN2PR12MB4422.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NsTmHXeMf4HVScNRvO49aztVr55IGFj+hh/TMiJ2IQHmHL2RMV94hgsWvoNSQl5MulOXHDWY4Xiyx53h2G03TvblKw/UDMW3AiJRhZvNrpea5Xxd4pNsFKhU9LetKvX6BWWHim3IrZ/QFfv9pF6s3vdvkTK+l7ZvgoLafTACELDrlJcPS+ofWGYZJTuyBpMxC0XPVFXQq1+i33SgECdFmKklxckFNcCyvnQGoDRgYDUdd/xqIZhWt7I9r0r7Uy91pgSr1vlHRiO9N6BHx2scFCBIo3XQXwM1k4GeCd/GtNiKyy7YjqG8R0YxJuKzkGLckli1t2Fgz/glqi9EaBpImVKxm5oHkmV94YVfTBEj4QhhsuZRgDPpn8+rlrA6t2FaYZIjMQEF14H0akDZyh3DWOsDZ3Axoyjqe84eQT40h6EdHwfTUsPmaVKmq31tV/hO
x-ms-exchange-antispam-messagedata: GQ2vuOCvNEr5wSxKL1c9R4/vdwRxU2kCvsxW0DbJtcLtCMTYS0B9wmsWodJDMz/KrH5o6UftyEp9af+WOarikVdw2UwezaDGfmQy4BtGzZz4OdO98BHSQyluH8BY068ikFlPWBrdahWAoBjh37gRru707Z/MaWKxVAcpNVGXSB5qwbBrWIS6O973IyAullZmvJSKaO3fg17Hhw+GKO0TxQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32de559-4b32-4cf4-820b-08d7d0f1b369
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 19:21:21.0313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocUsW5O01rwiBNi4fhGNMw4Gah7PJ9nNvne/mK5WZOVYFeOU1RoYHp29G3fpoAO8Zxg0+QrtgSDnj7OYS89fcYJvYIvKpmjNwXVitzDYu/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_10:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250155
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Dmitry,=0A=
=0A=
that's right, thanks for finding it.=0A=
=0A=
Hopefully this will not prevent system suspend since we are not checking on=
 the return value.=0A=
=0A=
System suspend/resume callbacks need to be reworked to work correctly with =
pm_runtime.=0A=
I will send a fix patch when it is ready.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
=0A=
From: Dmitry Osipenko <digetx@gmail.com>=0A=
=0A=
Sent: Tuesday, March 24, 2020 22:24=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; jic23@kernel.org <ji=
c23@kernel.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH v2 12/13] iio: imu: inv_mpu6050: use runtime pm with au=
tosuspend=0A=
=0A=
=9A=0A=
=0A=
=0A=
=9ACAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
19.02.2020 17:39, Jean-Baptiste Maneyrol =D0=C9=DB=C5=D4:=0A=
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
> ---=0A=
=0A=
>=9A drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=9A=9A=9A | 267 ++++++++++++=
------=0A=
=0A=
>=9A drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=9A=9A=9A=9A |=9A=9A 5 +-=0A=
=0A=
>=9A drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=9A 33 ++-=0A=
=0A=
>=9A 3 files changed, 194 insertions(+), 111 deletions(-)=0A=
=0A=
=0A=
=0A=
Hello,=0A=
=0A=
=0A=
=0A=
This patch introduces a system suspend-resume regressing, I'm seeing the=0A=
=0A=
following on entering into suspend:=0A=
=0A=
=0A=
=0A=
=9Avdd_gen1v8: Underflow of regulator enable count=0A=
=0A=
=9Ainv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -22=0A=
=0A=
=0A=
=0A=
Apparently RPM disables the regulator and then it's erroneously disabled=0A=
=0A=
second time on suspend. Please fix it, thanks in advance.=0A=
=0A=
