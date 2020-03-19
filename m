Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A2118ADC7
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 08:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgCSH6j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 03:58:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41700 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgCSH6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 03:58:39 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02J7sYma004612;
        Thu, 19 Mar 2020 03:58:24 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yu9jawhur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 03:58:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7PsLqatcaDOXczflUZKDKF+hFo8OUJYAOGg/F77hYaOG9AlIM2D7//tQuQ3iuIHxtXSEftgyYxTJs+mzrnAdioxF36HF4unAm9As+FsEch7GIvDdzrCkJPZOH3QT7vCRd/UM2cEaJ7GPJox7z5BO3ojBzv1cixjIw39+2Hi3O1MbvN8S0RcUVaOc0P1ps9jvmUUPH5qsOANcCPIT44vtJA63t9PBtx4liGgq4xW7UvuSXVdNbkkOMXONEGLtcfP0zzPx3/mCBxl4ak6rFyN+sEAkwtT9GzM6YoZBNRJEFybva7MkMOn3Om5uqaEJ4C0vC7UJq1OTnueRMBuQ9yPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIk1sullkjZEXeaRr0ds+8ztGg6Hh3jbDoCxpQpH2NU=;
 b=ISfcugNP7/D8+w1N6c84kPtAnaq7VNGeXtfG4oU3uxjplRm7plGQJknl0kJCuh8evpSoENFxnyL5DC3OUmUK7vBlGy0DBiO0kn1KCZFFflxrCJ/yxXPRTiwJFWZxTgCBvNHJPNC088Bk46aesV77L614m6B41gH/bNUHIrFfJGhn8mp9mojAmu4j+xFByyjHD8jo5GkVHlA68ZlxCiCkFVrKvqsTV6iAH6LcV95xliGqH67GsU+1CdgHB+ZH20rzq+l4F7P10+maxTWx9pPUTyEMoaug7bipZFUO7VBOeV454V7GTQyy7mI8VRNtrGL8+POUwTq4L+8/bYYFkd+fag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIk1sullkjZEXeaRr0ds+8ztGg6Hh3jbDoCxpQpH2NU=;
 b=BrVfrXjBDSuXKvDL4PXsT4Bv1PGJLf61oallOS+Um23WytVj3tAedIHW8K5ehhcUzr2AKKU+q/SW5UVI7q8ndyHhUvEXZX/BCuR0pMUO6ACIxkbX6vmatkzfL8uh/2YopTA98PfgIzZPwaYOvoS1BUGYqNxc9l4m4a1dbhFbdbU=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3708.namprd03.prod.outlook.com (2603:10b6:5:b3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Thu, 19 Mar
 2020 07:58:23 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Thu, 19 Mar 2020
 07:58:23 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
Subject: Re: [PATCH 5/5] iio: adc: ad7793: use read_avail iio hook for scale
 available
Thread-Topic: [PATCH 5/5] iio: adc: ad7793: use read_avail iio hook for scale
 available
Thread-Index: AQHV/SppVVVrWL45DUGrOveHnZbXKqhOdEoAgAEaowA=
Date:   Thu, 19 Mar 2020 07:58:22 +0000
Message-ID: <e4a2757a8eaa148b15111830e4cf783319d0d68b.camel@analog.com>
References: <20200318134042.30133-1-alexandru.ardelean@analog.com>
         <20200318134042.30133-6-alexandru.ardelean@analog.com>
         <ffe8008d-5506-0e88-7ab2-6b221e36afba@metafoo.de>
In-Reply-To: <ffe8008d-5506-0e88-7ab2-6b221e36afba@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8f04e2d-3c7d-4480-42b2-08d7cbdb4c2e
x-ms-traffictypediagnostic: DM6PR03MB3708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB3708FFF9353F50BF4568FAE3F9F40@DM6PR03MB3708.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(66556008)(6506007)(6512007)(91956017)(76116006)(478600001)(2906002)(107886003)(36756003)(66476007)(71200400001)(4326008)(5660300002)(316002)(186003)(2616005)(8936002)(26005)(6486002)(66446008)(64756008)(8676002)(53546011)(81156014)(81166006)(110136005)(66946007)(54906003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3708;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BPzNY4PlFLXufGcY93S1rQeTpygeE3r9zUws7FOnWlwnW+q7uM+fkNYhhxU05WqP64VX7vKzoI3pL6fep/YxSsntyQ8/wSuATDYys0/U1Lx0+/+wCv512NzHXga+LB4GD0KIEo1VjEk1K985rqr/3utElbJaV20LO+m+ZaxuLV94YzwBfwK7fQuAp0AW8D+Crc7zG9fptAX+pQCxzlYafFX+uyDcs1NqhPTKvmazO7zYh76B4DSdR9WhRQ7f3Um8/ODs9DxFioflR+Bg4Nxj2b90GG5qwXiN+SmFAD9Vy82dPCpEYcFU+Y6u0hyTT6okxlPwoFJjQq9Qk4hsXKvK1MFkngLL/pxFceqQmC8lMF2phikrPwQsCGKHoCQ/OYKcMyNWQqwbX+6uq3pesoyhj6596y44B59PHG+db6E3kaJYz2iOyBG5XgxxY4LXZHDo
x-ms-exchange-antispam-messagedata: vDxBPZPzZTqIa3iopnSgNDPj/RnDs1urG4URmklXO4p8pMQpepFr1ge0hdm5p3QDjObD1CiY0rho6wQgFADcp+cXA5y5qg8qSF7QX1Gs8B/2MZJGUauZuLaTv0e8B6XXj4myU8anHTEUEH3WTcMZ5g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <11730AA20BF13849A771C9BC32B0544B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f04e2d-3c7d-4480-42b2-08d7cbdb4c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 07:58:22.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzugVRvO6r6LCoiClRs4xZV6y80u47jHaBpj0r5JR5t1eV3YNaJ6IZW3bzpVCyYddhB8ZkqorzPvxZv9IGe+YKtfABa6p1gVtbr4B+t5q0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3708
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_01:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190036
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTE4IGF0IDE2OjEwICswMTAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IE9uIDMvMTgvMjAgMjo0MCBQTSwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiA+
IFRoaXMgY2hhbmdlIHVzZXMgdGhlIHJlYWRfYXZhaWwgYW5kICcuaW5mb19tYXNrX3NoYXJlZF9i
eV90eXBlX2F2YWlsYWJsZScNCj4gPiBtb2RpZmllciB0byBzZXQgdGhlIGF2YWlsYWJsZSBzY2Fs
ZS4NCj4gPiBFc3NlbnRpYWxseSwgbm90aGluZyBjaGFuZ2VzIHRvIHRoZSBkcml2ZXIncyBBQkku
DQo+ID4gDQo+ID4gVGhlIG1haW4gaWRlYSBmb3IgdGhpcyBwYXRjaCBpcyB0byByZW1vdmUgdGhl
IEFENzc5MyBkcml2ZXIgZnJvbQ0KPiA+IGNoZWNrcGF0Y2gncyByYWRhci4gVGhlcmUgaGF2ZSBi
ZWVuIGFib3V0IH4zIGF0dGVtcHRzIHRvIGZpeC9icmVhayB0aGUNCj4gPiAnaW5fdm9sdGFnZS12
b2x0YWdlX3NjYWxlX2F2YWlsYWJsZScgYXR0cmlidXRlLCBiZWNhdXNlIGNoZWNrcGF0Y2ggYXNz
dW1lZA0KPiA+IGl0IHRvIGJlIGFuIGFyaXRobWV0aWMgb3BlcmF0aW9uIGFuZCBwZW9wbGUgd2Vy
ZSB0cnlpbmcgdG8gY2hhbmdlIHRoYXQuDQo+IA0KPiBZZWFoLCBwcm9iYWJseSBhIGdvb2QgaWRl
YSENCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUu
YXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaWlvL2FkYy9hZDc3
OTMuYyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzc5My5jIGIvZHJpdmVycy9paW8v
YWRjL2FkNzc5My5jDQo+ID4gaW5kZXggNTU5MmFlNTczZTZiLi5mYWQ5OGYxODAxZGIgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzc5My5jDQo+ID4gKysrIGIvZHJpdmVycy9p
aW8vYWRjL2FkNzc5My5jDQo+ID4gQEAgLTM1NCwyOSArMzU0LDI4IEBAIHN0YXRpYyBJSU9fQ09O
U1RfQVRUUl9TQU1QX0ZSRVFfQVZBSUwoDQo+ID4gICBzdGF0aWMgSUlPX0NPTlNUX0FUVFJfTkFN
RUQoc2FtcGxpbmdfZnJlcXVlbmN5X2F2YWlsYWJsZV9hZDc3OTcsDQo+ID4gICAJc2FtcGxpbmdf
ZnJlcXVlbmN5X2F2YWlsYWJsZSwgIjEyMyA2MiA1MCAzMyAxNyAxNiAxMiAxMCA4IDYgNCIpOw0K
PiA+ICAgDQo+ID4gLXN0YXRpYyBzc2l6ZV90IGFkNzc5M19zaG93X3NjYWxlX2F2YWlsYWJsZShz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gLQkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRy
LCBjaGFyICpidWYpDQo+ID4gK3N0YXRpYyBpbnQgYWQ3NzkzX3JlYWRfYXZhaWwoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldiwNCj4gPiArCQkJICAgICBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25z
dCAqY2hhbiwNCj4gPiArCQkJICAgICBjb25zdCBpbnQgKip2YWxzLCBpbnQgKnR5cGUsIGludCAq
bGVuZ3RoLA0KPiA+ICsJCQkgICAgIGxvbmcgbWFzaykNCj4gPiAgIHsNCj4gPiAtCXN0cnVjdCBp
aW9fZGV2ICppbmRpb19kZXYgPSBkZXZfdG9faWlvX2RldihkZXYpOw0KPiA+ICAgCXN0cnVjdCBh
ZDc3OTNfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiAtCWludCBpLCBsZW4g
PSAwOw0KPiA+ICAgDQo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzdC0+c2NhbGVf
YXZhaWwpOyBpKyspDQo+ID4gLQkJbGVuICs9IHNwcmludGYoYnVmICsgbGVuLCAiJWQuJTA5dSAi
LCBzdC0+c2NhbGVfYXZhaWxbaV1bMF0sDQo+ID4gLQkJCSAgICAgICBzdC0+c2NhbGVfYXZhaWxb
aV1bMV0pOw0KPiA+ICsJc3dpdGNoIChtYXNrKSB7DQo+ID4gKwljYXNlIElJT19DSEFOX0lORk9f
U0NBTEU6DQo+ID4gKwkJKnZhbHMgPSAoaW50ICopc3QtPnNjYWxlX2F2YWlsOw0KPiANCj4gQ2Fu
IHlvdSBjaGFuZ2UgdGhlIHR5cGUgb2Ygc2NhbGVfYXZhaWwgdG8gaW50IHNvIHdlIGRvbid0IG5l
ZWQgdGhlIGNhc3Q/DQo+IA0KDQpTbywgSSBkb24ndCB3YW50IHRvIGNvbWUtdXAgYXMgbG9va2lu
ZyBsYXp5Lg0KW0kgbWVhbiwgSSBhbSBsYXp5LCBidXQgSSBkb24ndCB3YW50IHRvIGxvb2sgbGF6
eS5dDQoNCkkgdG9vayBhIGxvb2sgYXQgd2hhdCBpdCBtZWFucyB0byBjaGFuZ2UgdGhpcyB0byBh
IHNpbXBsZSBhcnJheS4NClRoZSByZXdvcmsgZmVlbHMgdG8gbWUgbGlrZSBhIGJpdCBtb3JlIG5v
aXNlIHRoYW4gaXMgcHJvYmFibHkgd29ydGggaXQuDQpJIG1lYW4sIGlmIHRoZSBwdXJwb3NlIG9m
IHRoZSByZXdvcmsgaXMgdG8ganVzdCBnZXQgcmlkIG9mIHRoaXMgY2FzdCwgdGhlbiBpdA0KZmVl
bHMgbm9pc3kgW3RvIG1lXS4NCg0KVGhhdCBiZWluZyBzYWlkLCBpZiB5b3UgaW5zaXN0LCBJIGNh
biB0YWtlIGEgbG9vayBhbmQgZG8gYSBwYXRjaCBbYmVmb3JlIHRoaXMNCm9uZV0gdG8gY29udmVy
dCBpdCB0byBhIHNpbXBsZSBhcnJheS4NCg0KDQo+ID4gKwkJKnR5cGUgPSBJSU9fVkFMX0lOVF9Q
TFVTX05BTk87DQo+ID4gKwkJLyogVmFsdWVzIGFyZSBzdG9yZWQgaW4gYSAyRCBtYXRyaXggICov
DQo+ID4gKwkJKmxlbmd0aCA9IEFSUkFZX1NJWkUoc3QtPnNjYWxlX2F2YWlsKSAqIDI7DQo+ID4g
ICANCj4gPiAtCWxlbiArPSBzcHJpbnRmKGJ1ZiArIGxlbiwgIlxuIik7DQo+ID4gKwkJcmV0dXJu
IElJT19BVkFJTF9MSVNUOw0KPiA+ICsJfQ0KPiA+ICAgDQo+ID4gLQlyZXR1cm4gbGVuOw0KPiA+
ICsJcmV0dXJuIC1FSU5WQUw7DQo+ID4gICB9DQo=
