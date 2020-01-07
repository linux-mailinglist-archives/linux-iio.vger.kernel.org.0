Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC11132190
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2020 09:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAGIlm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jan 2020 03:41:42 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:33010 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgAGIlm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jan 2020 03:41:42 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0078f5lc027833;
        Tue, 7 Jan 2020 03:41:39 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xawstwy4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 03:41:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuO/4mI9OYovzq1Ivbz8g1eZyvpYacce3efnLGcGMTErq8HeJEMMTn8dAjsASjCZCF9XL/h2l928ytZPCCnNE7kRlxOA/Gte23zkHYIUQDuzuHAzLSSkMpmYIgUrD60WYlBqWr0u33sg2uHzIJfje4TMbaBmqKUFWubrwiAWYESZ8UOh4x7LdQlLX+/BBLPjlr8oC4HwSB4UEVa2TLdvUxEGnL5kWpcbd90G05eNwqctpXEV0pbsHDDRhyENIV0IlEgw03bFfuDCjd+pWoF0ShtsmkCS8uHoZQ5AHYbTIAwhqHKiztMw5eLzPM8iI6p6/juM7jOzHSGyHa5YK/JK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/3pmQ+xxqZu+VqauNxUNsBjwv4pVVkMTS4ePtpPxe4=;
 b=DICZbBgob1/PjhuZxucA+nupNGEUc6v8OxzNFoMCjRnw+ILBBpwDVE7O3fnOKLDgIKI32mMtF/buUvD2sUxFgQCnC6hEzv9gwvIz+wvrbHWjWrycnVL85QBr1I7iwDa0Dii0X5iCcPfJK8lTdvtQHAnN5oDTtGWN7BervJjp7bXQsMwNKUOUhOSfDAFKDwFFigoTHruhPTKyGna98FiXju8ok+kYIPCDOOnJF2ISh7kmaMGsVZMM9X425TtkrpRhwZR+RLCqRhhpp0krk+HNS27wwq0GH5cJmln3ZsQP+vq83YpDck0V5ylqM3bGjUOZU887k8TdsUTofPrJXQ0yMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/3pmQ+xxqZu+VqauNxUNsBjwv4pVVkMTS4ePtpPxe4=;
 b=UziVuNfMtQZn0sEeuH02deaQYBwlOayK10wxQRUCyVNE1mo2t/PRgpVQl0jUUOIxLnwwDKzz/+0HmbyqBuA+Vo1hxY8lDwPJbsxpyQMUPYKLSd2FGR75SRzgDCWq7qvqU2OYWEuRFRy5/8R+WaMW8Xmrgz9H6m+al0zq5NNlhro=
Received: from CY4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:903:33::30)
 by BN6PR03MB2514.namprd03.prod.outlook.com (2603:10b6:404:15::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10; Tue, 7 Jan
 2020 08:41:28 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by CY4PR03CA0020.outlook.office365.com
 (2603:10b6:903:33::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend
 Transport; Tue, 7 Jan 2020 08:41:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Tue, 7 Jan 2020 08:41:28 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 0078fRd4011637
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Jan 2020 00:41:27 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 7 Jan 2020 00:41:26 -0800
Received: from SCSQMBX11.ad.analog.com ([fe80::9868:b016:ef0b:4ad2]) by
 SCSQMBX11.ad.analog.com ([fe80::9868:b016:ef0b:4ad2%8]) with mapi id
 15.01.1779.002; Tue, 7 Jan 2020 00:41:26 -0800
From:   "Tachici, Alexandru" <Alexandru.Tachici@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: Add custom irq flags
Thread-Topic: [PATCH] iio: ad_sigma_delta: Add custom irq flags
Thread-Index: AQHVxIAm+CQgPGEoQUeeJ/PyeZo22affaZMA
Date:   Tue, 7 Jan 2020 08:41:25 +0000
Message-ID: <6b67da6c8223a1d4ce031ef4d1485f2d25c7f04d.camel@analog.com>
References: <20200106105747.8244-1-alexandru.tachici@analog.com>
In-Reply-To: <20200106105747.8244-1-alexandru.tachici@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.175]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD9D9CE797E15240B3FD2732E8170ABF@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(199004)(189003)(26005)(5660300002)(36756003)(70586007)(7696005)(70206006)(186003)(4326008)(426003)(86362001)(246002)(8676002)(110136005)(2616005)(336012)(8936002)(2906002)(7636002)(356004)(498600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2514;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5a39257-56d1-4c6b-0fec-08d7934d6366
X-MS-TrafficTypeDiagnostic: BN6PR03MB2514:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2514649926DEE2BC10A589B9903F0@BN6PR03MB2514.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 027578BB13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUb37+XQgP3P8wqOrp5GSCqCzEAcRpaJv+6BqpwOjnh/FFPQnEbRNuOyYOmOUhFcKH9MPyRSYJaxlz3mFCiwJzk6a+syvfcL64MFLo+nmWKGK353FB85hWV+WB+oLoNyYPD2LiR+wXMxYLklZ64SkGztR1iNrmGp4BqKd/gDheXAEvPWNZ7AyDGIKO2RKrm7OE19A3BrUUQvB5NoPM6eJ16Ji6H/IbgQtXO2mSoyIyN/gmk8xKjBaUFQLYujyXow2/hQr9I+CHRtkUcdtU6+5rjLT1Lr3e3CA3KJ7eUPO6gibGXLeqq3fs7m6e0Xqrjmgmeh+afjLA14u5yjXp1GtLjcmGHx/k1a2/rSfSxE9KooC8r7GddHMnbkKeOft7cEFAqpIFpxE1ZIswVEFyHeAlYSyoqsjE1L2qIbF8GhzY5K4O9b4+Gj37jvmNPWdJfw
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 08:41:28.4541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a39257-56d1-4c6b-0fec-08d7934d6366
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2514
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_02:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070069
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTA2IGF0IDEyOjU3ICswMjAwLCBBbGV4YW5kcnUgVGFjaGljaSB3cm90
ZToNCj4gVGhlIGRhdGEtc2hlZXQgb2YgQUQ3MTI0LCBmcm9tIHRoZSBTaWdtYS1EZWx0YSBBREMg
ZmFtaWx5LA0KPiByZWNvbW1lbmRzIHRoYXQgdGhlIGZhbGxpbmcgZWRnZSBvZiB0aGUgRE9VVCBs
aW5lIHNob3VsZCBiZSB1c2VkIGZvcg0KPiBhbiBpbnRlcnJ1cHQuDQo+IA0KPiBUaGUgYWRfc2ln
bWFfZGVsdGEgaW1wbGVtZW50YXRpb24gaGFyZGNvZGVzIHRoZSBpcnEgdHJpZ2dlciB0eXBlDQo+
IHRvIGxvdywgYXNzdW1pbmcgdGhhdCBhbGwgU2lnbWEtRGVsdGEgQURDcyBoYXZlIHRoZSBzYW1l
IGludGVycnVwdC0NCj4gdHlwZS4NCj4gVGhpcyBjYXVzZXMgdW53YW50ZWQgYmVoYXZpb3VyLiBJ
ZiBET1VUIGxpbmUgaXMgYWxyZWFkeSBsb3csIHRoZQ0KPiBpbnRlcnJ1cHQgd2lsbCBmaXJlIG9u
Y2UsIHdoZW4gZW5hYmxlZCBhbmQgdGhlIGlycSBoYW5kbGVyIHdpbGwgc2VuZA0KPiBhDQo+IHJl
YWQgcmVxdWVzdCB0byB0aGUgZGV2aWNlLiBBdCB0aGlzIHRpbWUgdGhlIGRldmljZSBoYXMgbm90
IHlldA0KPiBmaW5pc2hlZA0KPiB0aGUgcHJldmlvdXMgY29udmVyc2lvbiBhbmQgd2lsbCBnaXZl
IGEgYmFkIHJlYWRpbmcuDQo+IA0KPiBUaGlzIHBhdGNoIGFsbG93cyBkcml2ZXJzIHVzaW5nIHRo
ZSBhZF9zaWdtYV9kZWx0YSBsYXllciB0byBzZXQgdGhlDQo+IGlycSB0cmlnZ2VyIHR5cGUgdG8g
dGhlIG9uZSBzcGVjaWZpZWQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgZGF0YS0NCj4gc2hlZXQuDQo+
IA0KDQpQbGVhc2UgZGlzcmVnYXJkIHRoaXMgd2lsbCBzZW5kIGEgcHJvcHBlciBWMi4NCg0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgVGFjaGljaSA8YWxleGFuZHJ1LnRhY2hpY2lAYW5hbG9n
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYyAgICAgICB8
IDkgKysrKysrKystDQo+ICBpbmNsdWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuaCB8
IDIgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jDQo+
IGIvZHJpdmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMNCj4gaW5kZXggZDEwYmQwYzk3MjMz
Li4wMDA3ZGY4ZDUwZmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9k
ZWx0YS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jDQo+IEBAIC00
NTQsNyArNDU0LDcgQEAgc3RhdGljIGludCBhZF9zZF9wcm9iZV90cmlnZ2VyKHN0cnVjdCBpaW9f
ZGV2DQo+ICppbmRpb19kZXYpDQo+ICANCj4gIAlyZXQgPSByZXF1ZXN0X2lycShzaWdtYV9kZWx0
YS0+c3BpLT5pcnEsDQo+ICAJCQkgIGFkX3NkX2RhdGFfcmR5X3RyaWdfcG9sbCwNCj4gLQkJCSAg
SVJRRl9UUklHR0VSX0xPVywNCj4gKwkJCSAgc2lnbWFfZGVsdGEtPmlycV9mbGFncywNCj4gIAkJ
CSAgaW5kaW9fZGV2LT5uYW1lLA0KPiAgCQkJICBzaWdtYV9kZWx0YSk7DQo+ICAJaWYgKHJldCkN
Cj4gQEAgLTU0MCw4ICs1NDAsMTUgQEANCj4gRVhQT1JUX1NZTUJPTF9HUEwoYWRfc2RfY2xlYW51
cF9idWZmZXJfYW5kX3RyaWdnZXIpOw0KPiAgaW50IGFkX3NkX2luaXQoc3RydWN0IGFkX3NpZ21h
X2RlbHRhICpzaWdtYV9kZWx0YSwgc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwNCj4gIAlz
dHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCBjb25zdCBzdHJ1Y3QgYWRfc2lnbWFfZGVsdGFfaW5mbyAq
aW5mbykNCj4gIHsNCj4gKwl1bnNpZ25lZCBsb25nIHNldF90cmlnZ2VyX2ZsYWdzOw0KPiArDQo+
ICAJc2lnbWFfZGVsdGEtPnNwaSA9IHNwaTsNCj4gIAlzaWdtYV9kZWx0YS0+aW5mbyA9IGluZm87
DQo+ICsNCj4gKwlzZXRfdHJpZ2dlcl9mbGFncyA9IHNpZ21hX2RlbHRhLT5pcnFfZmxhZ3MgJiBJ
UlFGX1RSSUdHRVJfTUFTSzsNCj4gKwlpZiAoc2V0X3RyaWdnZXJfZmxhZ3MgPT0gSVJRRl9UUklH
R0VSX05PTkUpDQo+ICsJCXNpZ21hX2RlbHRhLT5pcnFfZmxhZ3MgfD0gSVJRRl9UUklHR0VSX0xP
VzsNCj4gKw0KPiAgCWlpb19kZXZpY2Vfc2V0X2RydmRhdGEoaW5kaW9fZGV2LCBzaWdtYV9kZWx0
YSk7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaWlv
L2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+IGIvaW5jbHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21h
X2RlbHRhLmgNCj4gaW5kZXggNWJhNDMwY2M5YTg3Li45NGE5MTczMWM4ZTggMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvbGludXgvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+ICsrKyBiL2luY2x1
ZGUvbGludXgvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+IEBAIC01Myw2ICs1Myw3IEBAIHN0
cnVjdCBhZF9zaWdtYV9kZWx0YV9pbmZvIHsNCj4gICAqIHN0cnVjdCBhZF9zaWdtYV9kZWx0YSAt
IFNpZ21hIERlbHRhIGRldmljZSBzdHJ1Y3QNCj4gICAqIEBzcGk6IFRoZSBzcGkgZGV2aWNlIGFz
c29jaWF0ZWQgd2l0aCB0aGUgU2lnbWEgRGVsdGEgZGV2aWNlLg0KPiAgICogQHRyaWc6IFRoZSBJ
SU8gdHJpZ2dlciBhc3NvY2lhdGVkIHdpdGggdGhlIFNpZ21hIERlbHRhIGRldmljZS4NCj4gKyAq
IEBpcnFfZmxhZ3M6IGZsYWdzIGZvciB0aGUgaW50ZXJydXB0IHVzZWQgYnkgdGhlIHRyaWdnZXJl
ZCBidWZmZXINCj4gICAqDQo+ICAgKiBNb3N0IG9mIHRoZSBmaWVsZHMgYXJlIHByaXZhdGUgdG8g
dGhlIHNpZ21hIGRlbHRhIGxpYnJhcnkgY29kZQ0KPiBhbmQgc2hvdWxkIG5vdA0KPiAgICogYmUg
YWNjZXNzZWQgYnkgaW5kaXZpZHVhbCBkcml2ZXJzLg0KPiBAQCAtNjAsNiArNjEsNyBAQCBzdHJ1
Y3QgYWRfc2lnbWFfZGVsdGFfaW5mbyB7DQo+ICBzdHJ1Y3QgYWRfc2lnbWFfZGVsdGEgew0KPiAg
CXN0cnVjdCBzcGlfZGV2aWNlCSpzcGk7DQo+ICAJc3RydWN0IGlpb190cmlnZ2VyCSp0cmlnOw0K
PiArCXVuc2lnbmVkIGxvbmcJCWlycV9mbGFnczsNCj4gIA0KPiAgLyogcHJpdmF0ZTogKi8NCj4g
IAlzdHJ1Y3QgY29tcGxldGlvbgljb21wbGV0aW9uOw0K
