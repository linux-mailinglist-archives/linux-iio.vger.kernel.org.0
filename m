Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B064EC077
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfKAJZx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:25:53 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:49032 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbfKAJZx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:25:53 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19NtiL025028;
        Fri, 1 Nov 2019 05:25:38 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2055.outbound.protection.outlook.com [104.47.33.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwh5s472-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSUI9EEVV4xm9ePs4ttV2wVR5kjH7B9IdOkM1cUPgHWaqQMHK9edcx+pOYAXEHSCeaRm2f6vCoZ9PJmHhRggFFtCN775sChMdd4pZK2kdFJw2MOpconQWBa15KJPxxff5wyT/zbdJTkkkI892S/5NZ4KIGsUVBMzHimUr//z8g5FgouMdLxYklmzxRoWpPFLhB4tM4987Um35t/HGubx7xypWGOJbSoMhaYc5g0gSELb88J1Ju2OpQQmnCIjVaoTEkU6FZcxNzv3c5GwlTtQEEKeqRNHGN99V8f2scZBBUdRotoWXEM9oCEPfUvzptTNiP/XtU7MwnIf190TFTswKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2sC8sdgUPJleJjuEYYGJxp+xXzdWPf/2DuWX93Oumw=;
 b=WCw2iGSyQNPhjqEZXivWh1c33BmVTZ9b0ZSLA8sfqOeaEUSXf8OzFNa8aC2xNcEwnh6wi/82AVqdsn3aiynLD7JgZWMN6hKV7t0JspkntRAia1NwysOZSkUDjIYdj/N+YZhyisnXDEvVSlQpm+hQODdyk1ZCImT5ZJfX3tw2GrioFRYt46qXDhe2QZDZuCSxCTuyb3CT8F8QGa+mMdffQOlMI2ljqwA7Ejvs/o/Lp13c6kgE+/4DKkuxyUG080KRc/DfFHmahh2boas4fafXBY/Gb3O0QCHXd6gymdY1h178MJAtSW+Ywr9EykxcyaH5l+hVqRN6ep6YzKNXVYGv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2sC8sdgUPJleJjuEYYGJxp+xXzdWPf/2DuWX93Oumw=;
 b=a7s6e+0KfTTAMfFPAi4luy+g9OjqbVXsJ4hhnNVOHOb++HxuIRpz8afjfHx34GhPjw0zirZyI6gymJ3RQguwOCEA4VM1eZlQPkeaYcnfR8yeUGrMiXewyQdwnCfqXS/x9BJt0Or1wfcO8KDH8prxHxYCzlE2+hMPV6ghd5O2qrA=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5160.namprd03.prod.outlook.com (20.180.5.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 1 Nov 2019 09:25:37 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 09:25:36 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: imu: adis: assign value only if return code zero in
 read funcs
Thread-Topic: [PATCH] iio: imu: adis: assign value only if return code zero in
 read funcs
Thread-Index: AQHVjxjo18dq+ZNI30ao2kTepFzpBqd2Dm+A
Date:   Fri, 1 Nov 2019 09:25:36 +0000
Message-ID: <30dad15e9b9090983451dcbef54b23589599e3b9.camel@analog.com>
References: <20191030115511.28975-1-alexandru.ardelean@analog.com>
In-Reply-To: <20191030115511.28975-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 590f40bc-f0c0-4d3a-c63b-08d75ead744c
x-ms-traffictypediagnostic: CH2PR03MB5160:
x-microsoft-antispam-prvs: <CH2PR03MB5160C30683E1AACBA4AB4E89F9620@CH2PR03MB5160.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(118296001)(2906002)(6512007)(6506007)(6486002)(71190400001)(4326008)(446003)(476003)(11346002)(6116002)(3846002)(66446008)(6246003)(5660300002)(76116006)(110136005)(486006)(256004)(229853002)(4001150100001)(186003)(66946007)(71200400001)(36756003)(64756008)(66556008)(66476007)(54906003)(6436002)(25786009)(7736002)(99286004)(102836004)(81166006)(14454004)(81156014)(305945005)(8676002)(26005)(66066001)(76176011)(478600001)(2616005)(316002)(2501003)(86362001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5160;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6nFF6nHBMMCGEbVG23OaBEbyYdVUPkGE3OMeRe31jve6wtQTBrxA+fXzpTFil/RZyzh54Ky7YGtv4E+UK50iLhMBmER7JPewFE1jmzYXAiOR4vMdc6I2BpNWw325uxVr9O6MwzsZ4w+Ic33KjVvu++Fhy1tSlvTszsBpEYJ3Na6AI/KpECEZd1GmtOUNAT5C9POT0DFEA9DXMmqRiDTT2T8UMzktJaKpW11EFMKksZBfZfOAuDjZPW51pLfnFxhLnlnZ56tuv3WDIvQSAdioi7WQ+7tT8FpOQI6ZvhZgbi8ReRZXAKfu9rao1wtWlqWl0/6lb48qX5bxjzQ/EIEH5G9QkDYFQpo6otlGfh4pBZUNJa13pJL2ZSqpXjDDZnARB5bgROTOyDA9om/bywk+FTwaUnoO/6BNgUR1IoD0cjbiQzs5ji6Yc0MOdp8293l
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B942588AA430F14EB54F419D387FC801@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590f40bc-f0c0-4d3a-c63b-08d75ead744c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 09:25:36.8053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkClEMxo75cWPb4eljpViGZPwfy/xxJZgjORy8Osk2wO7RyCczs9Sp/2F1FDKxszZc79CjrhyC7hxw9ER+kIOt+KtNbz++xdcHUnWrEtHpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5160
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010094
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTMwIGF0IDEzOjU1ICswMjAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoZSBpbmxpbmUgcmVhZCBmdW5jdGlvbnMgaW4gdGhlIEFESVMgbGlicmFyeSBkb24n
dCBjaGVjayB0aGUgcmV0dXJuDQo+IHZhbHVlDQo+IG9mIHRoZSBgYWRpc19yZWFkX3JlZygpYCBm
dW5jdGlvbiBhbmQgYXNzaWduIHRoZSB2YWx1ZSBvZiBgdG1wYA0KPiByZWdhcmRsZXNzLg0KPiAN
Cj4gRml4IHRoaXMgYnkgY2hlY2tpbmcgaWYgcmV0dXJuIHZhbHVlIGlzIHplcm8gYW5kIG9ubHkg
dGhlbiBhc3NpZ25pbmcgdGhlDQo+IHZhbHVlIG9mIGB0bXBgLg0KPiANCg0KQEpvbmF0aGFuOg0K
UGxlYXNlIGRpc3JlZ2FyZCB0aGlzLg0KSSB3aWxsIHJlLXNwaW4gdGhpcyBhcyBhIHNlcmllcy4N
Ckl0IHR1cm5lZCBvdXQgdGhhdCB0aGUgd2hvbGUgdGhpbmcvY2hhbmdlc2V0IGlzIG11Y2ggYmln
Z2VyIHRoYW4gSQ0KaW5pdGlhbGx5IGFudGljaXBhdGVkLg0KDQpJIHRoaW5rIEkgZm91bmQgdGhl
IHJlYXNvbiB3aHkgd2UgKGF0IEFESSkgd2VyZW4ndCBjYXRjaGluZyB0aGUgQURJUw0Kd2Fybmlu
Z3MvZXJyb3JzLCBiZWZvcmUgdXBzdHJlYW1pbmcuDQpJdCB0dXJucyBvdXQsIHRoYXQgd2Ugd2Vy
ZSBvbmx5IHRlc3Rpbmcgd2l0aCBBUk0gJiBBUk02NCBjb21waWxlcnMsIHdoaWxlDQp0aGUgY29t
cGlsZXJzIHRoYXQgd2VyZSBoaXR0aW5nIHVzIHdpdGggd2FybmluZ3MgYXJlIHg4Nl82NC4gSSBk
byByZW1lbWJlcg0KW2Zyb20gcGFzdCBleHBlcmllbmNlc10gdGhhdCBkaWZmZXJlbnQgR0NDIGNv
bXBpbGVycyByZXBvcnQgZGlmZmVyZW50DQpbb2Z0ZW4gdmFsaWRdIHR5cGVzIG9mIGVycm9ycy4g
QnV0LCBpZiBJIGRvbid0IG5lZWQgdG8gd29yayB3aXRoIHRvbyBtYW55DQpBUkNIcywgSSBkbyBm
b3JnZXQgYWJvdXQgdGhpcyBhc3BlY3QuDQoNCkluIGFueSBjYXNlLCBJJ3ZlIHVwZGF0ZWQgb3Vy
IENJIHRvIGFsc28gaW5jbHVkZSBhIGJ1aWxkLXJ1biB3aXRoIHg4Nl82NA0KZm9yIGFsbCBBREkg
ZHJpdmVycy4NCkFuZCB3ZSBtYXkgYWxzbyBleHRlbmQgdGhpcyB0byBjb3ZlciB0aGUgZW50aXJl
IGtlcm5lbCBbbGF0ZXJdLg0KDQpUaGFua3MNCkFsZXgNCg0KDQo+IEZpeGVzOiA1N2ExMjI4YTA2
YjdhICgiaWlvOmltdTphZGlzOiBBZGQgc3VwcG9ydCBmb3IgMzJiaXQgcmVnaXN0ZXJzIikNCj4g
U2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5h
bG9nLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2lpby9pbXUvYWRpcy5oIHwgNiArKysr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9paW8vaW11L2FkaXMuaCBiL2luY2x1ZGUv
bGludXgvaWlvL2ltdS9hZGlzLmgNCj4gaW5kZXggNGM1MzgxNWJiNzI5Li45MmFhZTE0NTkzYmYg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmgNCj4gKysrIGIvaW5j
bHVkZS9saW51eC9paW8vaW11L2FkaXMuaA0KPiBAQCAtMTI5LDcgKzEyOSw4IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGFkaXNfcmVhZF9yZWdfMTYoc3RydWN0IGFkaXMgKmFkaXMsDQo+IHVuc2lnbmVk
IGludCByZWcsDQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCXJldCA9IGFkaXNfcmVhZF9yZWcoYWRp
cywgcmVnLCAmdG1wLCAyKTsNCj4gLQkqdmFsID0gdG1wOw0KPiArCWlmIChyZXQgPT0gMCkNCj4g
KwkJKnZhbCA9IHRtcDsNCj4gIA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IEBAIC0xNDcsNyAr
MTQ4LDggQEAgc3RhdGljIGlubGluZSBpbnQgYWRpc19yZWFkX3JlZ18zMihzdHJ1Y3QgYWRpcyAq
YWRpcywNCj4gdW5zaWduZWQgaW50IHJlZywNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+ICAJcmV0ID0g
YWRpc19yZWFkX3JlZyhhZGlzLCByZWcsICZ0bXAsIDQpOw0KPiAtCSp2YWwgPSB0bXA7DQo+ICsJ
aWYgKHJldCA9PSAwKQ0KPiArCQkqdmFsID0gdG1wOw0KPiAgDQo+ICAJcmV0dXJuIHJldDsNCj4g
IH0NCg==
