Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55AD144CB0
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2020 08:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAVH6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jan 2020 02:58:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61760 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbgAVH6e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jan 2020 02:58:34 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00M7t4ta004907;
        Wed, 22 Jan 2020 02:58:19 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbj3s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:58:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWImrdh9Trawu8RdxNIBtDQREuyJYgzCQSKhCkkRq0AJsNfCVmooT1iKAHCc6k05TAver99Jigt/Ra+hbLXgLPsVdKePGDyuW459/zAVe0Ms0Z1ittUBKwVFu1Wjdw5n0qBf2eRdquzhjbUpMROVaoOxXSKvo3O2pvjImi4UpqeUXlwxc5b6EkhHk7z47fJT1FVxwAH6t0n1Qlg4uEEv6VRGaG6PJVCUw+OJPnTYEO48zvSUYsqWOQEpY6Xc8NIZ11B6P7BqY8+2Kr40noYKwX1GbUiyAdu6DkOpY/snjbReid55/PA+vESuyp7Ce3s7y3Gn3z8RNG89XANbSKI3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPG/TtYOlT/B3MMsFf695fIL2MixERsh8nW8d2F9HbY=;
 b=Gsse6iv1TBrUggl40Za9apFkiRnEbjtCL1wQOnJBx7+Cwj+oH6Q3kiDpPFl5Up5+Rsvb15SIloDVtag2I+JdC7Kjn+NrtrCMPo2zfrgOPqjR648C3ZAe7kblW8tOIijDXHsUm1uhAuGe0j/8/iyFZTAnVDIh0TKUM/3EUW3kAWttv69NHvhdMocZn0ns9rpahzB5EC+VK9MiWSJSU+BYR2uJ7TTetAbEDIZHijrPODZB486OSiOlEPSYI+dofOrUHhGNujrkfGVTC+CR3qypTurvZ4IsT3dIDujO3jvEsf0jJje7dItztUv6DZvejkO0738VwV/rMrfBcIW9miKfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPG/TtYOlT/B3MMsFf695fIL2MixERsh8nW8d2F9HbY=;
 b=PBQPGECY/EWSR3K8gcUQMwwChz0ODExz/PdakHnHy/8OuUVOlOh5Zstegva9aDlTl39PPQSa//52rp87q4D0+gqgtLg9rImIfLFcR8/dNO/SMHBwNGqAtCsQfRdNpwY1Lfkmdzbt0A2FO/HKzqDrVhW5g158WyXbeDNblrnKnWM=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5191.namprd03.prod.outlook.com (20.180.13.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 07:58:17 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 07:58:17 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "ekigwana@gmail.com" <ekigwana@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 2/3] dt-bindings: iio: frequency: Add docs for ADF4360 PLL
Thread-Topic: [PATCH 2/3] dt-bindings: iio: frequency: Add docs for ADF4360
 PLL
Thread-Index: AQHV0E2gMOixGgHtiEGkhcohOANxWqf1alQAgADpHAA=
Date:   Wed, 22 Jan 2020 07:58:17 +0000
Message-ID: <f5a39017a50141574c1ab87724bb406043190fe4.camel@analog.com>
References: <20200121112556.9867-1-alexandru.ardelean@analog.com>
         <20200121112556.9867-2-alexandru.ardelean@analog.com>
         <20200121180614.GA9314@bogus>
In-Reply-To: <20200121180614.GA9314@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ac37018-b1cd-40f5-1127-08d79f10d770
x-ms-traffictypediagnostic: CH2PR03MB5191:
x-microsoft-antispam-prvs: <CH2PR03MB5191A4B5EEDDD9EF84FC08A9F90C0@CH2PR03MB5191.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(8936002)(6486002)(5660300002)(6506007)(8676002)(186003)(81156014)(81166006)(6512007)(316002)(26005)(66556008)(76116006)(2616005)(66946007)(6916009)(66476007)(36756003)(66446008)(64756008)(71200400001)(2906002)(478600001)(4326008)(86362001)(966005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5191;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AuSAm7xbj/SENllSEyL7Rn9ViXrK1nywMLgdBfTXCW5Kv5wJaV0fXlESzKCAZclmYbRSKe/Wg4IxQgqkM6Pu2XIjA4HFT7icT1ZVnl9vB5llUgIK7nIXgvtQg0ulk690BE5M+xZcfzcy9kbq/pDICgbpXEQu4PyyD61PS7CMNUTnIaAj+uxmKQGXpBcJgNoh1wInslvY8i0Jn8UnEjyngpMdqMW6I5PMpNIkAj+RJfi1wQxOrTQxl6Z+pdW1YcLF63uxbA9K68IXUnhkBXwpt/d+ux4QAC8WB6qV0/+GJ1BN8Jmv6leS6KPTyRV53J5ov2I/FWvJPCasZOZNnjRBBms8490R6KZ2LRSIrMKfc2h6bztuaRJjFOBGYX6I5BxEaleVgtfy4Q4FUG2LF3mArRDG72XQgDPydSP92ZcJpOOmIjiwn6p4ckJNj5410JWNEmZNo/OE4vDNDv/WipbauSf2xHKWXroCoj2wNpLPfsU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C0977E2BC61E0499020E86F04F1B6E3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac37018-b1cd-40f5-1127-08d79f10d770
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 07:58:17.7350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTq5mSVjAHPTQDgydS1PlHliXEFIJcq24jlxeIoE+v5alEcwoepRmZnYukuGGTXvw/ECYJCap92tnXG9pYNyq1epKoIZ2a/klxIPDSvVJyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5191
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001220071
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTIxIGF0IDEyOjA2IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCAyMSBKYW4gMjAyMCAxMzoyNTo1NSArMDIwMCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdy
b3RlOg0KPiA+IEZyb206IEVkd2FyZCBLaWd3YW5hIDxla2lnd2FuYUBnbWFpbC5jb20+DQo+ID4g
DQo+ID4gVGhpcyBjaGFuZ2UgYWRkcyB0aGUgZGV2aWNlLXRyZWUgYmluZGluZ3MgZG9jdW1lbnRh
dGlvbiBmb3IgdGhlIEFERjQzNjANCj4gPiBmYW1pbHkgb2YgUExMcy4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBFZHdhcmQgS2lnd2FuYSA8ZWtpZ3dhbmFAZ21haWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5j
b20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9paW8vZnJlcXVlbmN5L2FkaSxhZGY0MzYw
LnlhbWwgICB8IDE1OCArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE1
OCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZnJlcXVlbmN5L2FkaSxhZGY0MzYwLnlhbWwNCj4g
PiANCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmluZyAnbWFrZSBkdF9iaW5kaW5nX2No
ZWNrJyBvbiB5b3VyIHBhdGNoOg0KPiANCg0KdXJncy4uLg0KYXBvbG9naWVzIGZvciBmb3JnZXR0
aW5nIHRvIHJ1biB0aGlzOw0KYW5kIG1hbnkgdGhhbmtzIHRvIHlvdXIgYm90Ow0Kd2lsbCBmaXg7
DQoNCmkgdGhpbmsgaSBoYXZlIHRvbyBtdWNoIGRpc3RyaWJ1dGlvbiBmb3IgbXkgYXR0ZW50aW9u
LCBhbmQgaSBmb3JnZXQgc3R1ZmY7DQp3ZWxsLCBpJ2xsIHN0aWxsIGhhdmUgdG8gc2VlIGFib3V0
IG1vcmUgaW1wcm92ZW1lbnRzIGZvciBvdXIgY2kNCg0KPiB3YXJuaW5nOiBubyBzY2hlbWEgZm91
bmQgaW4gZmlsZToNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9mcmVx
dWVuY3kvYWRpLGFkZjQzNjAueWFtbA0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtDQo+
IHJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ZyZXF1ZW5jeS9h
ZGksYWRmNDM2MC55YW1sOg0KPiBpZ25vcmluZywgZXJyb3IgcGFyc2luZyBmaWxlDQo+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZnJlcXVlbmN5L2FkaSxhZGY0MzYwLnlh
bWw6ICB3aGlsZQ0KPiBzY2FubmluZyBhIHNpbXBsZSBrZXkNCj4gICBpbiAiPHVuaWNvZGUgc3Ry
aW5nPiIsIGxpbmUgOTgsIGNvbHVtbiA1DQo+IGNvdWxkIG5vdCBmaW5kIGV4cGVjdGVkICc6Jw0K
PiAgIGluICI8dW5pY29kZSBzdHJpbmc+IiwgbGluZSA5OSwgY29sdW1uIDUNCj4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL01ha2VmaWxlOjEyOiByZWNpcGUgZm9yIHRhcmdldA0K
PiAnRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9mcmVxdWVuY3kvYWRpLGFk
ZjQzNjAuZXhhbXBsZS5kdHMnDQo+IGZhaWxlZA0KPiBtYWtlWzFdOiAqKioNCj4gW0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZnJlcXVlbmN5L2FkaSxhZGY0MzYwLmV4YW1w
bGUuZHRzXQ0KPiBFcnJvciAxDQo+IE1ha2VmaWxlOjEyNjM6IHJlY2lwZSBmb3IgdGFyZ2V0ICdk
dF9iaW5kaW5nX2NoZWNrJyBmYWlsZWQNCj4gbWFrZTogKioqIFtkdF9iaW5kaW5nX2NoZWNrXSBF
cnJvciAyDQo+IA0KPiBTZWUgaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMjI2
NDAxDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0K
