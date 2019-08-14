Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B998CC22
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2019 08:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfHNG46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Aug 2019 02:56:58 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42906 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbfHNG46 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Aug 2019 02:56:58 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7E6rXaS009034;
        Wed, 14 Aug 2019 02:56:23 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uc0whhsdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 02:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKKE4kej61LSyR//Qc39ZXnqZpTdsan1K0GT9CkgAl1M9twDBk3DWrGP2qS+SXoKtixc9zJbAkoPzowg9Ly35+Zz8tnAyJU3FhxgBPrjXKA6HaO50vfyzCoprDXXv/4DCXCRt38Jnd9uC5PTqYNvNFItQ+iY+O+FgX6CUSVq01+855DkQ55wMtOiVAOnOij3q+HPzQcnqunVLMud+bqOv/3VYYm++4o1b5znLzfnFZ7bk0nDa6Wq1g4LVxEpfPI2RMYJfOgu1zJVaEp0Ic/w4kmTcH6p18JKn9k+QjbrwFS2yvodVyD/R8ZZ7OZ5WtCghDfjoFugd/sZGC/kPy+8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIwUMvLo1s8tG+DoBqsBKC+2kV7Og0PzsQJI2lwahdM=;
 b=mgy9ihmxNInv0Fm3StL+KEFytpXGp9vp7PIeblxKt+OOROOXrgyNINe6PCbkbvtgk/c/Xz4+8LqS67561ggDC6NBMcdPPosuwQOZoNP08bHii7GAsgoRGah20b6Lt4OwjuoEiuDFwpVUZH2JaoDQjeuDx1EGL3Guhru6lg7L2Ezozqezlv12vkqxZmHYPtM3ZX0kqXU0vy661ucRmoDGB5odHdmFMvdzUd8FbMFaFiltzr0id+jmbJie2DXJHHxaA60W/Qo1j6E/KEk9MS7P8uesCmhLCAUFg33xSw32iMW6MTo1IAT8xfUnrDzSj9/fWgznzFPrdsEHdP9Y+V65pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIwUMvLo1s8tG+DoBqsBKC+2kV7Og0PzsQJI2lwahdM=;
 b=FkZyoaSRBkJCVyigXKE62H9tJFZx/nxcPaeU2w4+QfH/5iAj340yVehk9Cb991cXSOHB6eVjpXzTw2vucyvFzWwSAzeDsIDDcs2nuGs94TKxkegHRoTovlA8tcJNT2/kRozr7w1PXty1ibdU8cT31Tnf9hYmOQ7eNyPaepWabYk=
Received: from CH2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:59::39)
 by BLUPR0301MB2084.namprd03.prod.outlook.com (2a01:111:e400:c474::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Wed, 14 Aug
 2019 06:56:21 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CH2PR03CA0029.outlook.office365.com
 (2603:10b6:610:59::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15 via Frontend
 Transport; Wed, 14 Aug 2019 06:56:20 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Wed, 14 Aug 2019 06:56:20 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7E6uJGN012658
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 13 Aug 2019 23:56:19 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Wed, 14 Aug 2019 02:56:19 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] staging: iio: accel: adis16240: Improve readability
 on write_raw function
Thread-Topic: [PATCH v2] staging: iio: accel: adis16240: Improve readability
 on write_raw function
Thread-Index: AQHVUg27ho7Fo7+PkkmXku6NXNI65qb6eawA
Date:   Wed, 14 Aug 2019 06:56:18 +0000
Message-ID: <28dda97db73c56fbaf746aa52eb63faaf02b15d7.camel@analog.com>
References: <20190813193101.26867-1-rodrigorsdc@gmail.com>
In-Reply-To: <20190813193101.26867-1-rodrigorsdc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.113]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF30E5D4A3E6D54980D844CFF442E35F@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(189003)(199004)(4326008)(426003)(229853002)(14454004)(6246003)(8676002)(2501003)(50466002)(356004)(11346002)(7636002)(54906003)(86362001)(436003)(7416002)(305945005)(336012)(7736002)(5660300002)(2486003)(23676004)(110136005)(47776003)(446003)(2906002)(6116002)(3846002)(316002)(36756003)(486006)(476003)(126002)(246002)(70586007)(118296001)(186003)(7696005)(106002)(2616005)(70206006)(2201001)(26005)(102836004)(76176011)(8936002)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB2084;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 633cf9ca-a6e1-4923-2e3e-08d72084835b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BLUPR0301MB2084;
X-MS-TrafficTypeDiagnostic: BLUPR0301MB2084:
X-Microsoft-Antispam-PRVS: <BLUPR0301MB20848D18702677BA012470C1F9AD0@BLUPR0301MB2084.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 01294F875B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: SWult33XP65Ll2GPRKmLEsZ9i8iJIIvn1lUfGlzqDQWiIQvgtB+r5K/M9g4xmOaf1AEkmWK5n+/pZk0E0NCoJH9SbG3rqD1q4FsC2YZVmVGjdHP0/wy8hn163D5i7Z3J5iQtx5HGDY3p3LMi0uJe8HX1MKayu1JsZvDFMllc7IAQXIqLMl12AIgbuL8rka4CqSgLVNzN4vPbGJayPaMwBcmObAFLQ2CKyeWuPbxM43zCzmYgy4djpMVo2UfitqlOna0KOzg/Z5x7i0i2HQI2TMK6mkOdGdYcYC8WGj9YKjyRyGdWGC3QXTNN8v9wQvgXuwj2jMb3aa46DDk0eq3aBCilnLP9BKH6wefTedgU8/N9J2WTMskMGibJ1btrm8J9GmEHzL3Slx2JLYDH7UCEKFEY70+7cR41HaipTz0hUhc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 06:56:20.2953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633cf9ca-a6e1-4923-2e3e-08d72084835b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB2084
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTEzIGF0IDE2OjMxIC0wMzAwLCBSb2RyaWdvIFJpYmVpcm8gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IFJlcGxhY2Ugc2hpZnQgYW5kIG1pbnVzIG9wZXJhdGlvbiBi
eSBHRU5NQVNLIG1hY3JvIGFuZCByZW1vdmUgdGhlIGxvY2FsDQo+IHZhcmlhYmxlcyB1c2VkIHRv
IHN0b3JlIGludGVybWVkaWF0ZSBkYXRhLg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBB
cmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4gU2lnbmVkLW9mZi1i
eTogUm9kcmlnbyBSaWJlaXJvIENhcnZhbGhvIDxyb2RyaWdvcnNkY0BnbWFpbC5jb20+DQo+IC0t
LQ0KPiB2MjoNCj4gICAgLSBMZWF2ZSBzd2l0Y2ggc3RhdGVtZW50IGluc3RlYWQgb2YgcmVwbGFj
ZSBieSBpZiBzdGF0ZW1lbnQNCj4gIGRyaXZlcnMvc3RhZ2luZy9paW8vYWNjZWwvYWRpczE2MjQw
LmMgfCA1ICstLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hY2NlbC9hZGlz
MTYyNDAuYyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWNjZWwvYWRpczE2MjQwLmMNCj4gaW5kZXgg
NjJmNGIzYjFiNDU3Li44MjA5OWRiNGJmMGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2lu
Zy9paW8vYWNjZWwvYWRpczE2MjQwLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hY2Nl
bC9hZGlzMTYyNDAuYw0KPiBAQCAtMzA5LDE1ICszMDksMTIgQEAgc3RhdGljIGludCBhZGlzMTYy
NDBfd3JpdGVfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ICAJCQkgICAgICAgbG9u
ZyBtYXNrKQ0KPiAgew0KPiAgCXN0cnVjdCBhZGlzICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7
DQo+IC0JaW50IGJpdHMgPSAxMDsNCj4gLQlzMTYgdmFsMTY7DQo+ICAJdTggYWRkcjsNCj4gIA0K
PiAgCXN3aXRjaCAobWFzaykgew0KPiAgCWNhc2UgSUlPX0NIQU5fSU5GT19DQUxJQkJJQVM6DQo+
IC0JCXZhbDE2ID0gdmFsICYgKCgxIDw8IGJpdHMpIC0gMSk7DQo+ICAJCWFkZHIgPSBhZGlzMTYy
NDBfYWRkcmVzc2VzW2NoYW4tPnNjYW5faW5kZXhdWzBdOw0KPiAtCQlyZXR1cm4gYWRpc193cml0
ZV9yZWdfMTYoc3QsIGFkZHIsIHZhbDE2KTsNCj4gKwkJcmV0dXJuIGFkaXNfd3JpdGVfcmVnXzE2
KHN0LCBhZGRyLCB2YWwgJiBHRU5NQVNLKDksIDApKTsNCj4gIAl9DQo+ICAJcmV0dXJuIC1FSU5W
QUw7DQo+ICB9DQo=
