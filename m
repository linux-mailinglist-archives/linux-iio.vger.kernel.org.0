Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACE51B97A3
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 08:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgD0GoA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 02:44:00 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:53390 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgD0GoA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 02:44:00 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03R6b7tW015790;
        Mon, 27 Apr 2020 02:43:44 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2058.outbound.protection.outlook.com [104.47.46.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 30nf4rjnh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 02:43:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUWzulKiclzIana3mUny9nDcnbij01mFSLPh6xfUIBHKFfJ5mopolU9pOkS7vvum27cZRiSDJOQ2nsChUy/4PqrjdXREo8MYh28yb1rtGlp+M6LATtPDRas/rMquLek0JNYTRlsNaoWg/UIXOandqdcAHBPn5Rx97QIbFuaQGgrikeDPowz7jY0SSSG9TBkLpSeqo8xDiCErCUOQXRLUmSZERYz4hWvdUXXIfXyN5cZB5+JBb34JQK73yQsAOoy/3cwKNOgf5yhJIRAaGcDgQ26d/Texds+3YeQinzqIYsW5U6SgbLvmxY0rrHk61x1sDYb5oGsYhtRv20nS2Z8u/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQFUftCAPSsLHpzwSHs2aFp0N7++MZ1AJCRzV42/XIo=;
 b=Kpc7l5tVVw1ZWdS90ip7QRWImzlEaCA+tL+KjS36uL8QMp8lhVy/96nesWsIZdcQT6Wj6joQC2wdc2mK0hwpO48qt0dXvHPgi8tKSospqogpCsrfqgLl4isQanSHrVIscquCuqj3p8DtzKxKsvBcnn888e3pyCa89NoXZvTKCbYgbysKllpl6ozl75udWxI3u6CqF7Fd+7Eor+LpN7YVy9jBNrzMV+KmKpfsYkEtW745ptR1fzeu8eduj4CG07wqZLVrhezHtDIxBHKUvqkYS+fTwoLzoYCSC1+VNMw6qK424sa+QhyfWCGakasPoNZfKHlwU5S/sVTmStywjxMaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQFUftCAPSsLHpzwSHs2aFp0N7++MZ1AJCRzV42/XIo=;
 b=iemIFJvxodOOyQTu4ezkJdGnmoxPDVq5EyQPKulUGgTwab52mu10ewIVO7bizqMunXVGq3kUB545PWqYMlvCD2A+lkDz8090oi4LDdw+Vl0cmJmG9rFqQOGqINhflfUnVN+M9Q6Y4GuJRKI8fzRI7EYiDfzvRojwEDbk5SFf6es=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3947.namprd03.prod.outlook.com (2603:10b6:5:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 06:43:41 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 06:43:41 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v5 5/6] iio: core: add simple centralized mechanism for
 ioctl() handlers
Thread-Topic: [PATCH v5 5/6] iio: core: add simple centralized mechanism for
 ioctl() handlers
Thread-Index: AQHWG52eqbf2uFgPVkWtC16dM7DzaqiLLqGAgAADKoCAAVVYAA==
Date:   Mon, 27 Apr 2020 06:43:41 +0000
Message-ID: <db28898f5a2a92a24cc549fe5a2064ad83efa2bc.camel@analog.com>
References: <20200426073817.33307-1-alexandru.ardelean@analog.com>
         <20200426073817.33307-6-alexandru.ardelean@analog.com>
         <20200426111037.076b984d@archlinux> <20200426112157.51b16616@archlinux>
In-Reply-To: <20200426112157.51b16616@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d8cd95a-d5d1-4c3f-d653-08d7ea7652d5
x-ms-traffictypediagnostic: DM6PR03MB3947:
x-microsoft-antispam-prvs: <DM6PR03MB39472A97F95753196341D106F9AF0@DM6PR03MB3947.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(6512007)(186003)(5660300002)(86362001)(6506007)(26005)(6486002)(2906002)(36756003)(6916009)(498600001)(2616005)(54906003)(8676002)(81156014)(8936002)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(91956017)(71200400001)(4326008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8ec0giYfU9duvbbwB4lxXxC9pB5D7AmwSXq64YohylQ77A77uNA7Jp/lQpgdoVc2U1qhKjZGGPRx/AgabvZ5MzMUyuG0ZDryjoc95JlF0U60ZqvWOkE/JJoR51ID43iZIrQpu2GKecSt8Y3u8gPjfMDJ/C5Oh8TGuhl/N860wcD6NAmf3IQj49UYUOUHa+INrn3r35TGUDqJs9Lm9aeMsae65vveDK+Cz9IWyALovAmpxaD6Qjg/JMZT8GLVXN80idHQt/HhZmCRFYuXckOWusLiU/pFh5D920FgF9v5SOJNC1fAQPm/mH1OxY0UcD2bzM2XVizIj9Vs4DDa6hLznH/g4PZWuxzU5hFEhNPLovREgpd9mMjBWTJsRCnVEgWJhukUgbd1KZ2mnDXaDbdKeBSlvb41v9RqNZ6xgHrXCsCfDv2w/2zTow20m0Yfhha
x-ms-exchange-antispam-messagedata: GnQzUgX+MBx9NVHbLXBS8N5la9JQhx8Z0eOw0lZf99nrMyonQUtvfuMlXol7zexLzBfqP82WB40is3CyD58kn5TqV6ULHGsn5/HoTdqbrFwMmT+cd28kSl50rU9xC1Q6CHDUsSRsjj9hk7UDghGjvsSxFnj6jBf6W1lpISGTCKSmvGO6CThyi8KVJzri2qEIAtN7EMX1MHma7nggoLfoiSLno0qtQHJOijZ6POAnLgVZOx7nbqmm6kUGBOjCRSgWHK7Kx8Hfpnkurp8i5sBEnPvzPLj8QPeqZoBjWlH2clj5IY7oe6TKS5OXP8lo78xBaDV34GIF1Axj4HizM+L0tbIkvpvqh3klSwwUKPysbmkiuylfRCEWg0X2mXDoQSwRsL6oLXUP3nRUbac47U0X0xS9MZMtRuCHfhrmmarlgQ5ODQtztvCq2gQebBphF51TcVokvLPKsCtENoaANxptZqEdwqVQXKTmLFdnQVU6ZMqAEbBHKLhG8zZ/tililqY1DtsFdWSmtBBZBgRxoV0je/V/vLuNvZXSj5pXDTp1TkGm41r8ajT52vJB8oXpvXc8yu1kRJsVIUjJTHQtmMTZocK4+Q0TrBJzOEzApoxV8mPlRgBBxO/ApqRfqsYygCUHTF+VHAwPDoWx/DQED+gLU2kpgkaDMEDg2PVFWWmmBk14Rly+vJNUE2Ko/GTuxvXsymLllijViRDufnX94KImi/djg4qKpnZubgNpcWHbPEA24pMtOYuotLKwdYD47cc3zI8sqyAqlZZUpEnzbRoI8C8E41jZoC7mXoAP00b7sAs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0F6E00805C09944BF40643A0B2A72D4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8cd95a-d5d1-4c3f-d653-08d7ea7652d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 06:43:41.2021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxRcLBQlmXNMHoWNaQj65yU/VLwEwTiLCJWxqGk/ZfM0lB2NXDz8/YX7rXn5UMN7yrMlcGCUGQANFw8Yvb5Cr6Y8xFtPlISpvS4EBb2pEfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3947
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_02:2020-04-24,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270058
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTI2IGF0IDExOjIxICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTdW4sIDI2IEFwciAyMDIwIDExOjEwOjM3ICswMTAw
DQo+IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gPiBP
biBTdW4sIDI2IEFwciAyMDIwIDEwOjM4OjE2ICswMzAwDQo+ID4gQWxleGFuZHJ1IEFyZGVsZWFu
IDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBUaGUg
YWltIG9mIHRoaXMgaXMgdG8gcmVkdWNlIHRoZSBvcmdhbml6YXRpb24gdmlvbGF0aW9uIG9mIGlv
Y3RsKCkgY2FsbHMNCj4gPiA+IGluDQo+ID4gPiBJSU8gY29yZS4gQ3VycmVudGx5LCBzaW5jZSB0
aGUgY2hhcmRldiBpcyBzcGxpdCBhY3Jvc3MgZmlsZXMsIGV2ZW50DQo+ID4gPiBpb2N0bCgpDQo+
ID4gPiBjYWxscyBuZWVkIHRvIGJlIGNhbGxlZCBpbiBidWZmZXIgaW9jdGwoKSBjYWxscy4NCj4g
PiA+IA0KPiA+ID4gVGhlICdpbmR1c3RyaWFsaW8tY29yZS5jJyBmaWxlIHdpbGwgcHJvdmlkZSBh
ICdpaW9fZGV2aWNlX2lvY3RsKCknIHdoaWNoDQo+ID4gPiB3aWxsIGl0ZXJhdGUgb3ZlciBhIGxp
c3Qgb2YgaW9jdGxzIHJlZ2lzdGVyZWQgd2l0aCB0aGUgSUlPIGRldmljZS4gVGhlc2UNCj4gPiA+
IGNhbiBiZSBldmVudCBpb2N0bCgpIG9yIGJ1ZmZlciBpb2N0bCgpIGNhbGxzLCBvciBzb21ldGhp
bmcgZWxzZS4NCj4gPiA+IFRoaXMgaXMgbmVlZGVkLCBzaW5jZSB0aGVyZSBpcyBjdXJyZW50bHkg
b25lIGNoYXJkZXYgcGVyIElJTyBkZXZpY2UgYW5kDQo+ID4gPiB0aGF0IGlzIHVzZWQgZm9yIGJv
dGggZXZlbnQgaGFuZGxpbmcgYW5kIHJlYWRpbmcgZnJvbSB0aGUgYnVmZmVyLg0KPiA+ID4gDQo+
ID4gPiBFYWNoIGlvY3RsKCkgd2lsbCBoYXZlIHRvIHJldHVybiBhIElJT19JT0NUTF9VTkhBTkRM
RUQgY29kZSAod2hpY2ggaXMNCj4gPiA+IHBvc2l0aXZlIDEpLCBpZiB0aGUgaW9jdGwoKSBkaWQg
bm90IGhhbmRsZSB0aGUgY2FsbCBpbiBhbnkuIFRoaXMNCj4gPiA+IGVsaW1pbmF0ZXMNCj4gPiA+
IGFueSBwb3RlbnRpYWwgYW1iaWd1aXRpZXM7IGlmIHdlIHdlcmUgdG8gaGF2ZSB1c2VkIGVycm9y
IGNvZGVzIGl0IHdvdWxkDQo+ID4gPiBoYXZlIGJlZW4gdW5jZXJ0YWluIHdoZXRoZXIgdGhleSB3
ZXJlIGFjdHVhbCBlcnJvcnMsIG9yIHdoZXRoZXINCj4gPiA+IHRoZSByZWdpc3RlcmVkIGlvY3Rs
KCkgZG9lc24ndCBzZXJ2aWNlIHRoZSBjb21tYW5kLg0KPiA+ID4gDQo+ID4gPiBJZiBhbnkgaW9j
dGwoKSByZXR1cm5zIDAsIGl0IHdhcyBjb25zaWRlcmVkIHRoYXQgaXQgd2FzIHNlcnZpY2VkDQo+
ID4gPiBzdWNjZXNzZnVsbHkgYW5kIHRoZSBsb29wIHdpbGwgZXhpdC4NCj4gPiA+IA0KPiA+ID4g
T25lIGFzc3VtcHRpb24gZm9yIGFsbCByZWdpc3RlcmVkIGlvY3RsKCkgaGFuZGxlcnMgaXMgdGhh
dCB0aGV5IGFyZQ0KPiA+ID4gc3RhdGljYWxseSBhbGxvY2F0ZWQsIHNvIHRoZSBpaW9fZGV2aWNl
X3VucmVnaXN0ZXIoKSB3aGljaCBqdXN0IHJlbW92ZSBhbGwNCj4gPiA+IG9mIHRoZW0gZnJvbSB0
aGUgZGV2aWNlJ3MgaW9jdGwoKSBoYW5kbGVyIGxpc3QuDQo+ID4gPiANCj4gPiA+IEFsc28sIHNv
bWV0aGluZyB0aGF0IGlzIGEgYml0IGhhcmQgdG8gZG8gW2F0IHRoaXMgcG9pbnRdIGFuZCBtYXkg
bm90IGJlDQo+ID4gPiB3b3J0aCB0aGUgZWZmb3J0IG9mIGRvaW5nLCBpcyB0byBjaGVjayB3aGV0
aGVyIHJlZ2lzdGVyZWQgaW9jdGwoKQ0KPiA+ID4gY2FsbHMvY29tbWFuZHMgb3ZlcmxhcC4gVGhp
cyBzaG91bGQgYmUgdW5saWtlbHkgdG8gaGFwcGVuLCBhbmQgc2hvdWxkIGdldA0KPiA+ID4gY2F1
Z2h0IGF0IHJldmlldyB0aW1lLiBUaG91Z2gsIG5ldyBpb2N0bCgpIGNhbGxzIHdvdWxkIGxpa2Vs
eSBub3QgYmUgYWRkZWQNCj4gPiA+IHRvbyBvZnRlbi4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4g
IA0KPiA+IA0KPiA+IEEgcXVlc3Rpb24gb24gbG9ja2luZyBpbmxpbmUuIE90aGVyd2lzZSB0aGlz
IGxvb2tzIGZhaXJseSBjbGVhbiBhbmQgc2ltcGxlDQo+ID4gdG8gbWUuDQo+ID4gDQo+ID4gSm9u
YXRoYW4NCj4gPiANCj4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvaWlvL2lpb19jb3Jl
LmggICAgICAgICAgfCAxNCArKysrKysrKysrKysrKw0KPiA+ID4gIGRyaXZlcnMvaWlvL2luZHVz
dHJpYWxpby1jb3JlLmMgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiA+ICBpbmNsdWRlL2xpbnV4L2lpby9paW8uaCAgICAgICAgIHwgIDIgKysNCj4gPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2lpb19jb3JlLmggYi9kcml2ZXJzL2lpby9paW9fY29yZS5oDQo+ID4gPiBp
bmRleCBhNTI3YTY2YmU5ZTUuLjM0YzNlMTkyMjlkOCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZl
cnMvaWlvL2lpb19jb3JlLmgNCj4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2lpb19jb3JlLmgNCj4g
PiA+IEBAIC0xNyw2ICsxNywyMCBAQCBzdHJ1Y3QgaWlvX2RldjsNCj4gPiA+ICANCj4gPiA+ICBl
eHRlcm4gc3RydWN0IGRldmljZV90eXBlIGlpb19kZXZpY2VfdHlwZTsNCj4gPiA+ICANCj4gPiA+
ICsjZGVmaW5lIElJT19JT0NUTF9VTkhBTkRMRUQJMQ0KPiA+ID4gK3N0cnVjdCBpaW9faW9jdGxf
aGFuZGxlciB7DQo+ID4gPiArCXN0cnVjdCBsaXN0X2hlYWQgZW50cnk7DQo+ID4gPiArCWxvbmcg
KCppb2N0bCkoc3RydWN0IGlpb19kZXYgKmluZGlvX2Rldiwgc3RydWN0IGZpbGUgKmZpbHAsDQo+
ID4gPiArCQkgICAgICB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZyk7DQo+ID4g
PiArfTsNCj4gPiA+ICsNCj4gPiA+ICtsb25nIGlpb19kZXZpY2VfaW9jdGwoc3RydWN0IGlpb19k
ZXYgKmluZGlvX2Rldiwgc3RydWN0IGZpbGUgKmZpbHAsDQo+ID4gPiArCQkgICAgICB1bnNpZ25l
ZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZyk7DQo+ID4gPiArDQo+ID4gPiArdm9pZCBpaW9f
ZGV2aWNlX2lvY3RsX2hhbmRsZXJfcmVnaXN0ZXIoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwN
Cj4gPiA+ICsJCQkJICAgICAgIHN0cnVjdCBpaW9faW9jdGxfaGFuZGxlciAqaCk7DQo+ID4gPiAr
dm9pZCBpaW9fZGV2aWNlX2lvY3RsX2hhbmRsZXJfdW5yZWdpc3RlcihzdHJ1Y3QgaWlvX2lvY3Rs
X2hhbmRsZXIgKmgpOw0KPiA+ID4gKw0KPiA+ID4gIGludCBfX2lpb19hZGRfY2hhbl9kZXZhdHRy
KGNvbnN0IGNoYXIgKnBvc3RmaXgsDQo+ID4gPiAgCQkJICAgc3RydWN0IGlpb19jaGFuX3NwZWMg
Y29uc3QgKmNoYW4sDQo+ID4gPiAgCQkJICAgc3NpemVfdCAoKmZ1bmMpKHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5j
IGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLQ0KPiA+ID4gY29yZS5jDQo+ID4gPiBpbmRleCBh
ZWM1ODVjYzg0NTMuLjc5ZThmYThmZjcwYiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaWlv
L2luZHVzdHJpYWxpby1jb3JlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxp
by1jb3JlLmMNCj4gPiA+IEBAIC0xNTMxLDYgKzE1MzEsNyBAQCBzdHJ1Y3QgaWlvX2RldiAqaWlv
X2RldmljZV9hbGxvYyhpbnQgc2l6ZW9mX3ByaXYpDQo+ID4gPiAgCX0NCj4gPiA+ICAJZGV2X3Nl
dF9uYW1lKCZkZXYtPmRldiwgImlpbzpkZXZpY2UlZCIsIGRldi0+aWQpOw0KPiA+ID4gIAlJTklU
X0xJU1RfSEVBRCgmZGV2LT5idWZmZXJfbGlzdCk7DQo+ID4gPiArCUlOSVRfTElTVF9IRUFEKCZk
ZXYtPmlvY3RsX2hhbmRsZXJzKTsNCj4gPiA+ICANCj4gPiA+ICAJcmV0dXJuIGRldjsNCj4gPiA+
ICB9DQo+ID4gPiBAQCAtMTU4NCw2ICsxNTg1LDMzIEBAIHN0cnVjdCBpaW9fZGV2ICpkZXZtX2lp
b19kZXZpY2VfYWxsb2Moc3RydWN0IGRldmljZQ0KPiA+ID4gKmRldiwgaW50IHNpemVvZl9wcml2
KQ0KPiA+ID4gIH0NCj4gPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChkZXZtX2lpb19kZXZpY2VfYWxs
b2MpOw0KPiA+ID4gIA0KPiA+ID4gK3ZvaWQgaWlvX2RldmljZV9pb2N0bF9oYW5kbGVyX3JlZ2lz
dGVyKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gPiArCQkJCSAgICAgICBzdHJ1Y3Qg
aWlvX2lvY3RsX2hhbmRsZXIgKmgpDQo+ID4gPiArew0KPiA+ID4gKwkvKiB0aGlzIGFzc3VtZXMg
dGhhdCBhbGwgaW9jdGwoKSBoYW5kbGVycyBhcmUgc3RhdGljYWxseSBhbGxvY2F0ZWQgKi8NCj4g
PiA+ICsJbGlzdF9hZGRfdGFpbCgmaC0+ZW50cnksICZpbmRpb19kZXYtPmlvY3RsX2hhbmRsZXJz
KTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArbG9uZyBpaW9fZGV2aWNlX2lvY3RsKHN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXYsIHN0cnVjdCBmaWxlICpmaWxwLA0KPiA+ID4gKwkJICAgICAg
dW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpDQo+ID4gPiArew0KPiA+ID4gKwlz
dHJ1Y3QgaWlvX2lvY3RsX2hhbmRsZXIgKmg7DQo+ID4gPiArCWludCByZXQ7DQo+ID4gPiArDQo+
ID4gPiArCWlmICghaW5kaW9fZGV2LT5pbmZvKQ0KPiA+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+
ID4gPiArDQo+ID4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnkoaCwgJmluZGlvX2Rldi0+aW9jdGxf
aGFuZGxlcnMsIGVudHJ5KSB7DQo+ID4gPiArCQlyZXQgPSBoLT5pb2N0bChpbmRpb19kZXYsIGZp
bHAsIGNtZCwgYXJnKTsNCj4gPiA+ICsJCWlmIChyZXQgPT0gMCkNCj4gPiA+ICsJCQlyZXR1cm4g
MDsNCj4gPiA+ICsJCWlmIChyZXQgIT0gSUlPX0lPQ1RMX1VOSEFORExFRCkNCj4gPiA+ICsJCQly
ZXR1cm4gcmV0Ow0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAtRUlOVkFMOw0K
PiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICBzdGF0aWMgaW50IGlpb19jaGVja191bmlxdWVfc2Nh
bl9pbmRleChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ID4gIHsNCj4gPiA+ICAJaW50
IGksIGo7DQo+ID4gPiBAQCAtMTY5NSw2ICsxNzIzLDggQEAgRVhQT1JUX1NZTUJPTChfX2lpb19k
ZXZpY2VfcmVnaXN0ZXIpOw0KPiA+ID4gICAqKi8NCj4gPiA+ICB2b2lkIGlpb19kZXZpY2VfdW5y
ZWdpc3RlcihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ID4gIHsNCj4gPiA+ICsJc3Ry
dWN0IGlpb19pb2N0bF9oYW5kbGVyICpoLCAqdDsNCj4gPiA+ICsNCj4gPiA+ICAJaWYgKGluZGlv
X2Rldi0+Y2hyZGV2KQ0KPiA+ID4gIAkJY2Rldl9kZXZpY2VfZGVsKGluZGlvX2Rldi0+Y2hyZGV2
LCAmaW5kaW9fZGV2LT5kZXYpOw0KPiA+ID4gIAllbHNlDQo+ID4gPiBAQCAtMTcwOCw2ICsxNzM4
LDkgQEAgdm9pZCBpaW9fZGV2aWNlX3VucmVnaXN0ZXIoc3RydWN0IGlpb19kZXYNCj4gPiA+ICpp
bmRpb19kZXYpDQo+ID4gPiAgDQo+ID4gPiAgCWlpb19kaXNhYmxlX2FsbF9idWZmZXJzKGluZGlv
X2Rldik7DQo+ID4gPiAgDQo+ID4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShoLCB0LCAm
aW5kaW9fZGV2LT5pb2N0bF9oYW5kbGVycywgZW50cnkpDQo+ID4gPiArCQlsaXN0X2RlbCgmaC0+
ZW50cnkpOw0KPiA+ID4gKyAgDQo+ID4gDQo+ID4gSXMgdGhlcmUgYW55IGNoYW5jZSBhbnl0aGlu
ZyBpcyB3YWxraW5nIHRoYXQgbGlzdCB3aGlsc3Qgd2UgYXJlIGRlbGV0aW5nIGl0Pw0KPiA+IEkg
dGhpbmsgdGhpcyBuZWVkcyB0byBoYXBwZW4gdW5kZXIgYSBsb2NrIGFzIGRvZXMgdGhlIHdhbGsu
DQo+IA0KPiBXZSBtYXkgd2FudCB0byB1c2UgdGhlIHJjdSBtZXRob2RzIHRvIG1ha2UgdGhlIHdh
bGsgYW5kIGRlbGV0ZSBzYWZlIHdoaWxzdA0KPiBhdm9pZGluZyBoZWF2eSB3ZWlnaHQgbG9ja2lu
ZyBvbiB0aGUgcmVhZCBwYXRoDQo+IA0KPiBsaW51eC9yY3VsaXN0LmgNCj4gDQo+IEkndmUgbm90
IHRob3VnaHQgYWJvdXQgdGhpcyBpbiBtdWNoIGRlcHRoIHRob3VnaCBzbyB0YWtlIHRoYXQgYWR2
aWNlIGFzDQo+IGEgdmFndWUgc3VnZ2VzdGlvbiBhbmQgbm90aGluZyBtb3JlIQ0KDQpJJ20gYSBi
aXQgdGVtcHRlZCB0byBkbyB0aGUgc2ltcGxlIG11dGV4IGFwcHJvYWNoLCBidXQgSSdsbCB0YWtl
IGEgbG9vayBhdCB0aGUNCnJjdWxpc3QuaCB0aGluZ2kuDQoNClRoZSBwb2ludCBpcyBnb29kIGFi
b3V0IHRoZSBsaXN0IGJlaW5nIHdhbGtlZCB3aGlsZSBiZWluZyBkZWxldGVkLg0KDQo+IA0KPiAN
Cj4gPiA+ICAJaW5kaW9fZGV2LT5pbmZvID0gTlVMTDsNCj4gPiA+ICANCj4gPiA+ICAJaWlvX2Rl
dmljZV93YWtldXBfZXZlbnRzZXQoaW5kaW9fZGV2KTsNCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2lpby9paW8uaCBiL2luY2x1ZGUvbGludXgvaWlvL2lpby5oDQo+ID4gPiBpbmRl
eCA1Mjk5MmJlNDRlOWUuLmI2Y2E4ZDg1NjI5ZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUv
bGludXgvaWlvL2lpby5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lpby9paW8uaA0KPiA+
ID4gQEAgLTQ4OCw2ICs0ODgsNyBAQCBzdHJ1Y3QgaWlvX2J1ZmZlcl9zZXR1cF9vcHMgew0KPiA+
ID4gICAqIEBjdXJyZW50bW9kZToJW0RSSVZFUl0gY3VycmVudCBvcGVyYXRpbmcgbW9kZQ0KPiA+
ID4gICAqIEBkZXY6CQlbRFJJVkVSXSBkZXZpY2Ugc3RydWN0dXJlLCBzaG91bGQgYmUgYXNzaWdu
ZWQgYSBwYXJlbnQNCj4gPiA+ICAgKgkJCWFuZCBvd25lcg0KPiA+ID4gKyAqIEBpb2N0bF9oYW5k
bGVyczoJW0lOVEVSTl0gbGlzdCBvZiByZWdpc3RlcmVkIGlvY3RsIGhhbmRsZXJzDQo+ID4gPiAg
ICogQGV2ZW50X2ludGVyZmFjZToJW0lOVEVSTl0gZXZlbnQgY2hyZGV2cyBhc3NvY2lhdGVkIHdp
dGggaW50ZXJydXB0DQo+ID4gPiBsaW5lcw0KPiA+ID4gICAqIEBidWZmZXI6CQlbRFJJVkVSXSBh
bnkgYnVmZmVyIHByZXNlbnQNCj4gPiA+ICAgKiBAYnVmZmVyX2xpc3Q6CVtJTlRFUk5dIGxpc3Qg
b2YgYWxsIGJ1ZmZlcnMgY3VycmVudGx5IGF0dGFjaGVkDQo+ID4gPiBAQCAtNTI5LDYgKzUzMCw3
IEBAIHN0cnVjdCBpaW9fZGV2IHsNCj4gPiA+ICAJaW50CQkJCW1vZGVzOw0KPiA+ID4gIAlpbnQJ
CQkJY3VycmVudG1vZGU7DQo+ID4gPiAgCXN0cnVjdCBkZXZpY2UJCQlkZXY7DQo+ID4gPiArCXN0
cnVjdCBsaXN0X2hlYWQJCWlvY3RsX2hhbmRsZXJzOw0KPiA+ID4gIA0KPiA+ID4gIAlzdHJ1Y3Qg
aWlvX2V2ZW50X2ludGVyZmFjZQkqZXZlbnRfaW50ZXJmYWNlOw0KPiA+ID4gICAgDQo=
