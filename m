Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2ADDEDAD2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 09:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKDIvD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 03:51:03 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:28386 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727138AbfKDIvD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 03:51:03 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA48lpeO032095;
        Mon, 4 Nov 2019 03:50:48 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2050.outbound.protection.outlook.com [104.47.40.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75h28a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 03:50:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPGFJjAsKp4/nxFFXpagPnrjVjCUKsE1VvXgamHHpbAXajHedX9ixXzZPG6maADzclUerxIWuTTPsnYrlLtSvyLN8Y3g/3cRWRUYKPVdNKjwHUJ2Hia2Kp94+nheZPwplLdPEHyAGPWsp3F9hnA6VNiwMZ92kHfvylWhy2eJxS+NLhOu+9BGAhLgLhUBNWlXCVPrUpHIIy7HCw/HfLV9zD9hddVeD3lgnyaPnTwtImm/NcS0KhFQydSO9Fdn7nwH5TWp1FisFY13mmiiCJR5dW8W/tJHxbEspdyOI9B1PZ43QpuHD/dXmNu5oCSRUjI5wG1jyb8BjX0mDAYgct41yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG/RCsVGfS7NFPBqV8kcG5FdSB+Bo0adt3GwdZO/Gew=;
 b=n+w8VjsEmqkGCbV919dFnNLKSxeNYvxCfMEiYKFBkWoCqe+2BXfiyTierSx4qbyvaOnO+vTmVZIO3QWGUQR6XuCOkZJizgdtCW5AgtPefxfofiJxurfYM0R1LjlPF9/lifELd82xJ3G48TRe1dfUlXdv7Gn6aTEyNCsNrctDpus1WV9iZdBxIEkrNExZQHLGs0oNUtvMZRAnm9slrBitoZgoYP0kK/c96PubGeEXoh3e6cYQmNaJNt7laYzOc5xwNy9GwnBNXB72Ago3+vg9irTI4XFGa6O4nPD8TPOGqTnqvj/C0CV5IttTfD6t29JnNYfU3K1fyuHgnaGGqL/Qmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG/RCsVGfS7NFPBqV8kcG5FdSB+Bo0adt3GwdZO/Gew=;
 b=afi/KD7IcJiiGf/k3SFtict2BIRpVQfxvlAI7mrDC3p1ZrsNzFH1hWYAr7dU8SRTLXuuXivYK7pXggUcBtYWgygIpVbm8R83GkqzDNwMr3+NQ4ugTBBkXVv3TIBYzd6u3AkIudi4cZ4KZkv2hwJyEbtZ+NMN4Jw1wlpmARANXhM=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5237.namprd03.prod.outlook.com (20.180.15.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 08:50:33 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 08:50:33 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 08/10] iio: imu: adis16480: assign bias value only if
 operation succeeded
Thread-Topic: [PATCH 08/10] iio: imu: adis16480: assign bias value only if
 operation succeeded
Thread-Index: AQHVkJe9TGQUKVQpW0iIlUn6yNxtq6d5RVKAgAFzhQA=
Date:   Mon, 4 Nov 2019 08:50:33 +0000
Message-ID: <20f60284065ae720b8d7c6f5188910264a42c419.camel@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
         <20191101093505.9408-9-alexandru.ardelean@analog.com>
         <20191103104131.4f4782e2@archlinux>
In-Reply-To: <20191103104131.4f4782e2@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c49283ef-db3c-4390-280e-08d761040dab
x-ms-traffictypediagnostic: CH2PR03MB5237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5237D48EE52DD4C2B3E97B81F97F0@CH2PR03MB5237.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(25786009)(2906002)(99286004)(66066001)(478600001)(6916009)(6116002)(3846002)(7736002)(6486002)(2501003)(6246003)(256004)(6512007)(229853002)(4326008)(118296001)(5660300002)(2351001)(86362001)(81166006)(71190400001)(71200400001)(446003)(11346002)(2616005)(476003)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(5640700003)(14454004)(8676002)(81156014)(305945005)(8936002)(186003)(6436002)(26005)(102836004)(76176011)(6506007)(316002)(54906003)(36756003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5237;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ao3M1mLimCHX5XUFvrUh+SP5hw7cyyYLq5lO624qe2CwzSbnXekChbmx+Isfkvs4n/YtyRzIKQZO+8cBEu7qbmQpqLgzxml63MJjyyqrW6++DpI/xslAId8YH2QpgFuhiF8TbhylVumya9i07+UOp+3DAWTqqzm+m0q/sX42Vi2Q3Cy8rWG7uWx28TQdkT5hDe0MJIf6myurUWTDNGdi+mw4bJrZvhhNhOiiNFSpWaLtFO7imZOPo/YpqMkQMef99KmR6pBV6BZFLsMTs0l1e35lMcbGogAaYpL6ZLz50pIuTv3rk7ER/c5cPrGHUCRc/ywBR16gExe0Ln21+PgYICmnnFXWQpp72Rhp7y+noohVQA9C2+tfLrIZdPWR76MrbHP206MeH3vU+OuSBKiWrASZUMnBP8ZmvUNIbmd5RiCv3WkuiMjqCuSyUBEkA12u
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC2E2AEC396FD4EBE75BFFDD35260A1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49283ef-db3c-4390-280e-08d761040dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 08:50:33.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XmcCFY2BFN28Pk5SW24CzWwDPBsGHHfj5hwOi6QwVFdMjgM4Oj5gX9RiXbJBOAgRzJ5h3rybzMsq+cjZjbebm4HNSKsoMzoBvwf0J7ggAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5237
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_06:2019-11-01,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTExLTAzIGF0IDEwOjQxICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDEgTm92IDIwMTkgMTE6MzU6MDMgKzAyMDANCj4gQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoaXMg
d2FzIGZvdW5kIG9ubHkgYWZ0ZXIgdGhlIHdob2xlIHRoaW5nIHdpdGggdGhlIGlubGluZSBmdW5j
dGlvbnMsDQo+ID4gYnV0DQo+ID4gdGhlIGNvbXBpbGVyIGFjdHVhbGx5IGZvdW5kIHNvbWV0aGlu
Zy4gVGhlIHZhbHVlIG9mIHRoZSBgYmlhc2AgKGluDQo+ID4gYWRpczE2NDgwX2dldF9jYWxpYmJp
YXMoKSkgc2hvdWxkIG9ubHkgYmUgc2V0IGlmIHRoZSByZWFkIG9wZXJhdGlvbiB3YXMNCj4gPiBz
dWNjZXNzZnVsLg0KPiA+IA0KPiA+IEZpeGVzOiAyZjNhYmU2Y2JiNmM5ICgiaWlvOmltdTogQWRk
IHN1cHBvcnQgZm9yIHRoZSBBRElTMTY0ODAgYW5kDQo+ID4gc2ltaWxhciBJTVVzIikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFs
b2cuY29tPg0KPiANCj4gSG1tLiBJdCdzIG5vdCByZWFsbHkgYSBmaXggYXMgc3VjaCB1bmxlc3Mg
dGhlcmUgaXMgYW4gaW4ga2VybmVsIGNvbnN1bWVyDQo+IHRoYXQgaXMgdXNpbmcgdGhpcyBhbmQg
bm90IGNoZWNraW5nIHRoZSByZXR1cm4gdmFsdWUuICAgSSB0aG91Z2h0IGFib3V0DQo+IGRyb3Bw
aW5nDQo+IHRoZSBmaXhlcyB0YWcsIGJ1dCBpdCBpcyBhdm9pZGluZyBjb25mdXNpbmcgdGhlIGNv
bXBpbGVyIHNvIEkgc3VwcG9zZSB3ZQ0KPiBtaWdodA0KPiBhcyB3ZWxsIGxlYXZlIGl0IG1hcmtl
ZCBhcyBhIGZpeC4gIEkgd2lsbCBhZGQgYSBub3RlIHRoYXQgdGhpcyBkb2Vzbid0DQo+IGNhdXNl
DQo+IGFueSBrbm93biByZWFsIHByb2JsZW1zIGFuZCBzbyBwcm9iYWJseSBpc24ndCBzdGFibGUg
bWF0ZXJpYWwuDQoNClRoYW5rcy4NCk5vIGlkZWEgaWYgaXQncyB3b3J0aCBoYXZpbmcgYSBGaXhl
cyB0YWcgb3Igbm90Lg0KSSB0aG91Z2h0IGFib3V0IGFkZGluZyBpdCwgc2luY2UgaXQgc2VlbWVk
IGxpa2UgYS1iaXQtb2YtYS1maXgsIGFuZCB3YXNuJ3QNCnN1cmUsIHNvIEkgYWRkZWQuIEkgZ3Vl
c3MgYWZ0ZXIgdXBzdHJlYW1pbmcgdGhpbmdzIGEgYml0LCBJIHN0YXJ0ZWQNCndvbmRlcmluZyBh
Ym91dCB0aGVzZSB0YWdzIGEgYml0IG1vcmUuDQoNCkFsZXgNCg0KPiANCj4gQXBwbGllZC4NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lp
by9pbXUvYWRpczE2NDgwLmMgfCA2ICsrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9pbXUvYWRpczE2NDgwLmMgYi9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDgwLmMNCj4gPiBp
bmRleCBiOWUyNjk1YmNmYWQuLmMwZTdlNzY4YmU0MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2lpby9pbXUvYWRpczE2NDgwLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDgw
LmMNCj4gPiBAQCAtNDUxLDEyICs0NTEsMTQgQEAgc3RhdGljIGludCBhZGlzMTY0ODBfZ2V0X2Nh
bGliYmlhcyhzdHJ1Y3QgaWlvX2Rldg0KPiA+ICppbmRpb19kZXYsDQo+ID4gIAljYXNlIElJT19N
QUdOOg0KPiA+ICAJY2FzZSBJSU9fUFJFU1NVUkU6DQo+ID4gIAkJcmV0ID0gYWRpc19yZWFkX3Jl
Z18xNigmc3QtPmFkaXMsIHJlZywgJnZhbDE2KTsNCj4gPiAtCQkqYmlhcyA9IHNpZ25fZXh0ZW5k
MzIodmFsMTYsIDE1KTsNCj4gPiArCQlpZiAocmV0ID09IDApDQo+ID4gKwkJCSpiaWFzID0gc2ln
bl9leHRlbmQzMih2YWwxNiwgMTUpOw0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJY2FzZSBJSU9fQU5H
TF9WRUw6DQo+ID4gIAljYXNlIElJT19BQ0NFTDoNCj4gPiAgCQlyZXQgPSBhZGlzX3JlYWRfcmVn
XzMyKCZzdC0+YWRpcywgcmVnLCAmdmFsMzIpOw0KPiA+IC0JCSpiaWFzID0gc2lnbl9leHRlbmQz
Mih2YWwzMiwgMzEpOw0KPiA+ICsJCWlmIChyZXQgPT0gMCkNCj4gPiArCQkJKmJpYXMgPSBzaWdu
X2V4dGVuZDMyKHZhbDMyLCAzMSk7DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAlkZWZhdWx0Og0KPiA+
ICAJCXJldCA9IC1FSU5WQUw7DQo=
