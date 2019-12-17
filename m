Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02F122A33
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 12:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLQLgN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 06:36:13 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24476 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfLQLgN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 06:36:13 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHBUVap007624;
        Tue, 17 Dec 2019 06:35:51 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvtfde8k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 06:35:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhSn4zM9LXHUUpGYHmd2yasTroADEL5bPJT10ryCRUeqVZi7/ltK9TTvbo08hXA8snebYGMH2wUw/UhDDY5x9de9/sFv+Mqe57LWtYcQxCW+HYvZnRziS/NUtoB+hPrIfjrouMM6eGDt51i2a/fOfAC7eYF4xRxnaPwqMyaamkUwoNNrqIGo/C3GrKU8fHhpcY6r7hzH5pBQc1bAf9jp7P8PPlKPurt8a9RIHKOqyjQTiy4WoIB+sI8WazdGKP+fry+vp1qy98ZsV4a3LGDbzAml5cyJsDGwh+JjrSlg84sH1T+UZbJ1JgsU3ITcxfe1MtWdMxuiRJnPGIEP2WBsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCpTQTX6wd/gUvzM7WhKDpGLZ6/LwVf4H0xf6fU1rqE=;
 b=SVRof5QYtxw0MjGOtbXv8lUE0/fAUbaWfkQVekpm4otcoV5KC1eEkW/Q3eAtalBi1uCv3ZvqQlLIFxUlzncTDK+8xfKla+Koe1cmtA85LCrlZjDH6J2fR5MRjx7fY+XzOve27mrJ7okVXrmGaySU3c6pTkENww4h5y/u0qM3Agmhgl1bSiiTFzy1xfmVOAAbem3bibagN52twzgPUottU+zfPEA80qNKLqsihQxrwEC5F15gZGFUlobJbEy4PL2QxhUkkapSZagy2mhtN7+x1Ypwq/8nqTZOwQrmUprIVP3JPhOPCQE4o14lB6k1mod7i622HIAgiTk+/KqREZRNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCpTQTX6wd/gUvzM7WhKDpGLZ6/LwVf4H0xf6fU1rqE=;
 b=czkH10Zsup6nro52LvPk73uYEA2vrpO3Tx3+oF19AwEYTeTMEbNDulRbM8dSsNJRxZnj5dXZZmCLngDQeqwOJeXaibhlZIWRg9ZUFTqFcbd+5jxrKP4czjsiYnTzI5LorXSjqQaC3owBxzpGwOC2UcS0RpMNoN8qr85SZnB2HfA=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5318.namprd03.prod.outlook.com (20.180.15.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 17 Dec 2019 11:35:49 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 11:35:49 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] iio: adc: ad7923: Add support for the
 ad7908/ad7918/ad7928
Thread-Topic: [PATCH v3 4/4] iio: adc: ad7923: Add support for the
 ad7908/ad7918/ad7928
Thread-Index: AQHVtMrrfgfBML9dRkaN+74C87HeL6e+MqsA
Date:   Tue, 17 Dec 2019 11:35:49 +0000
Message-ID: <9c85074a84d583527d7c59f1dad7e7f52dcbb300.camel@analog.com>
References: <20191217111158.30888-1-djunho@gmail.com>
         <20191217111158.30888-5-djunho@gmail.com>
In-Reply-To: <20191217111158.30888-5-djunho@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5f61aa0-83ac-48f8-2917-08d782e543e6
x-ms-traffictypediagnostic: CH2PR03MB5318:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB53189B2A5A888EB44E2040D3F9500@CH2PR03MB5318.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(71200400001)(2906002)(6512007)(66556008)(66476007)(5660300002)(86362001)(64756008)(2616005)(478600001)(110136005)(26005)(186003)(8676002)(81166006)(8936002)(4001150100001)(6486002)(76116006)(6506007)(36756003)(316002)(66946007)(66446008)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5318;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vTsakAm9u+q96Q/kEHprT25aes82kpZaCAFgge+zP/61JvFH1fT8sVAgGsITw8JEuX8gWHBqxyXQyVRzvlAYLiSSqE1Su1WwvWU+pwGWu+RpM7RCIwa1+1599wUgYORTxgbUrN4ccJrTYfVd7mHALGDYWOFvEq4D6NNq/+u/jzkpyf2BhGLilZO/lAdVZFyYd8r/P0ARYkv3oMrn/oQKbWmNnmjjoW7OUebtu1qjIYnPRWbQGSUttZldDq28g+lHlWcaKtrLrTa6/7PODKSt8ud0CF8RbD8ufMSGZMAfzdZ5453rPsYW3XNh1y/Pb/xvKsbP36gBfUu2gvgd+hCedMp03elsbGyXHNDU6qea1uFVo86COmm2Vdj5o8bhZxIJKEmK0DcgcVPhP+bChcDN3MxKO12mH6NXKbeWKMPrGuIJ1a0XYsNaYXsY4BCW6VQVhmugHHpdK64XxyxF/qTBbODYeu9Yj4KrghgIp5vciL1SjjjzkZd5Y7ubfCg4XyBq
Content-Type: text/plain; charset="utf-8"
Content-ID: <252B9D98DB586643AD38AF713DD957A8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f61aa0-83ac-48f8-2917-08d782e543e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 11:35:49.2751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTv4rxcop/S1HDQdUZsteNGpiTHzkHJsSSL1aN3W9XBLyE6XMvEekzncHLEGZtk6XyhnVfae3ZBZ47SIUWhr/YovlBeC5OVb3rcVZUTu/AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5318
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-16,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170099
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDA4OjExIC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IFRoZSBhZDc5MjggaXMgc29mdHdhcmUgY29tcGF0aWJsZSB3aXRoIHRoZSBhZDc5MjMuDQo+IFRo
ZSBhZDc5MDggYW5kIGFkNzkxOCBhcmUgdGhlIDggYW5kIDEwLWJpdCB2ZXJzaW9ucyBvZiB0aGUg
YWQ3OTI4Lg0KPiANCg0KT25lIG1pbm9yIG5pdC4NCkZpbmUgdG8gbGVhdmUgaXQgbGlrZSB0aGlz
Lg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5A
YW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSnVuaG8gPGRqdW5ob0BnbWFp
bC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jIHwgNTcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUwIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vYWRjL2FkNzkyMy5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IGluZGV4IDZkNTZm
YTBiOWUzMC4uMTA3NzAzNmQxZWQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWQ3
OTIzLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IEBAIC0xLDYgKzEsNiBA
QA0KPiAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiAgLyoNCj4g
LSAqIEFENzkwNC9BRDc5MTQvQUQ3OTIzL0FENzkyNCBTUEkgQURDIGRyaXZlcg0KPiArICogQUQ3
OTA0L0FENzkxNC9BRDc5MjMvQUQ3OTI0L0FENzkwOC9BRDc5MTgvQUQ3OTI4IFNQSSBBREMgZHJp
dmVyDQo+ICAgKg0KPiAgICogQ29weXJpZ2h0IDIwMTEgQW5hbG9nIERldmljZXMgSW5jIChmcm9t
IEFENzkyMyBEcml2ZXIpDQo+ICAgKiBDb3B5cmlnaHQgMjAxMiBDUyBTeXN0ZW1lcyBkJ0luZm9y
bWF0aW9uDQo+IEBAIC0yOSwxMSArMjksMTMgQEANCj4gICNkZWZpbmUgQUQ3OTIzX1BNX01PREVf
QVMJKDEpCQkvKiBhdXRvIHNodXRkb3duICovDQo+ICAjZGVmaW5lIEFENzkyM19QTV9NT0RFX0ZT
CSgyKQkJLyogZnVsbCBzaHV0ZG93biAqLw0KPiAgI2RlZmluZSBBRDc5MjNfUE1fTU9ERV9PUFMJ
KDMpCQkvKiBub3JtYWwgb3BlcmF0aW9uICovDQo+IC0jZGVmaW5lIEFENzkyM19TRVFVRU5DRV9P
RkYJKDApCQkvKiBubyBzZXF1ZW5jZSBmb25jdGlvbg0KPiAqLw0KPiAtI2RlZmluZSBBRDc5MjNf
U0VRVUVOQ0VfUFJPVEVDVAkoMikJCS8qIG5vIGludGVycnVwdA0KPiB3cml0ZSBjeWNsZSAqLw0K
PiAtI2RlZmluZSBBRDc5MjNfU0VRVUVOQ0VfT04JKDMpCQkvKiBjb250aW51b3VzIHNlcXVlbmNl
ICovDQo+ICANCj4gLSNkZWZpbmUgQUQ3OTIzX01BWF9DSEFOCQk0DQo+ICsjZGVmaW5lIEFENzky
M19TRVFVRU5DRV9PRkYJKDB4MDApCQkvKiBubyBzZXF1ZW5jZSBmdW5jdGlvbg0KPiAqLw0KPiAr
I2RlZmluZSBBRDc5MDhfU0VRVUVOQ0VfU0hBRE9XCSgweDAxKQkJLyogdXNlIHRoZSBzaGFkb3cN
Cj4gcmVnaXN0ZXINCj4gKwkJCQkJCSAqIGZvciBwcm9ncmFtbWluZw0KPiArCQkJCQkJICovDQo+
ICsjZGVmaW5lIEFENzkyM19TRVFVRU5DRV9QUk9URUNUCSgweDEwKQkJLyogbm8gaW50ZXJydXB0
IA0KDQpUaGVzZSByZWdpc3RlciBjaGFuZ2VzIHNlZW0gZXh0cmEuDQpUaGV5IGRvbid0IHNlZW0g
dG8gZG8gYW55dGhpbmcuDQpJIGRvbid0IG1pbmQgdGhlIGNoYW5nZSB0aG91Z2guDQoNCg0KPiB3
cml0ZSBjeWNsZSAqLw0KPiArI2RlZmluZSBBRDc5MjNfU0VRVUVOQ0VfT04JKDB4MTEpCQkvKiBj
b250aW51b3VzIHNlcXVlbmNlICovDQo+ICANCj4gICNkZWZpbmUgQUQ3OTIzX1BNX01PREVfV1JJ
VEUobW9kZSkJKChtb2RlKSA8PCA0KQkgLyogd3JpdGUgbW9kZSAqLw0KPiAgI2RlZmluZSBBRDc5
MjNfQ0hBTk5FTF9XUklURShjaGFubmVsKQkoKGNoYW5uZWwpIDw8IDYpIC8qIHdyaXRlDQo+IGNo
YW5uZWwgKi8NCj4gQEAgLTc0LDYgKzc2LDkgQEAgZW51bSBhZDc5MjNfaWQgew0KPiAgCUFENzkw
NCwNCj4gIAlBRDc5MTQsDQo+ICAJQUQ3OTI0LA0KPiArCUFENzkwOCwNCj4gKwlBRDc5MTgsDQo+
ICsJQUQ3OTI4DQo+ICB9Ow0KPiAgDQo+ICAjZGVmaW5lIEFENzkyM19WX0NIQU4oaW5kZXgsIGJp
dHMpCQkJCQlcDQo+IEBAIC0xMDIsOSArMTA3LDI1IEBAIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9z
cGVjIG5hbWUgIyMgX2NoYW5uZWxzW10gPSB7IFwNCj4gIAlJSU9fQ0hBTl9TT0ZUX1RJTUVTVEFN
UCg0KSwgXA0KPiAgfQ0KPiAgDQo+ICsjZGVmaW5lIERFQ0xBUkVfQUQ3OTA4X0NIQU5ORUxTKG5h
bWUsIGJpdHMpIFwNCj4gK2NvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjIG5hbWUgIyMgX2NoYW5u
ZWxzW10gPSB7IFwNCj4gKwlBRDc5MjNfVl9DSEFOKDAsIGJpdHMpLCBcDQo+ICsJQUQ3OTIzX1Zf
Q0hBTigxLCBiaXRzKSwgXA0KPiArCUFENzkyM19WX0NIQU4oMiwgYml0cyksIFwNCj4gKwlBRDc5
MjNfVl9DSEFOKDMsIGJpdHMpLCBcDQo+ICsJQUQ3OTIzX1ZfQ0hBTig0LCBiaXRzKSwgXA0KPiAr
CUFENzkyM19WX0NIQU4oNSwgYml0cyksIFwNCj4gKwlBRDc5MjNfVl9DSEFOKDYsIGJpdHMpLCBc
DQo+ICsJQUQ3OTIzX1ZfQ0hBTig3LCBiaXRzKSwgXA0KPiArCUlJT19DSEFOX1NPRlRfVElNRVNU
QU1QKDgpLCBcDQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBERUNMQVJFX0FENzkyM19DSEFOTkVMUyhh
ZDc5MDQsIDgpOw0KPiAgc3RhdGljIERFQ0xBUkVfQUQ3OTIzX0NIQU5ORUxTKGFkNzkxNCwgMTAp
Ow0KPiAgc3RhdGljIERFQ0xBUkVfQUQ3OTIzX0NIQU5ORUxTKGFkNzkyNCwgMTIpOw0KPiArc3Rh
dGljIERFQ0xBUkVfQUQ3OTA4X0NIQU5ORUxTKGFkNzkwOCwgOCk7DQo+ICtzdGF0aWMgREVDTEFS
RV9BRDc5MDhfQ0hBTk5FTFMoYWQ3OTE4LCAxMCk7DQo+ICtzdGF0aWMgREVDTEFSRV9BRDc5MDhf
Q0hBTk5FTFMoYWQ3OTI4LCAxMik7DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWQ3OTIz
X2NoaXBfaW5mbyBhZDc5MjNfY2hpcF9pbmZvW10gPSB7DQo+ICAJW0FENzkwNF0gPSB7DQo+IEBA
IC0xMTksNiArMTQwLDE4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWQ3OTIzX2NoaXBfaW5mbw0K
PiBhZDc5MjNfY2hpcF9pbmZvW10gPSB7DQo+ICAJCS5jaGFubmVscyA9IGFkNzkyNF9jaGFubmVs
cywNCj4gIAkJLm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUoYWQ3OTI0X2NoYW5uZWxzKSwNCj4g
IAl9LA0KPiArCVtBRDc5MDhdID0gew0KPiArCQkuY2hhbm5lbHMgPSBhZDc5MDhfY2hhbm5lbHMs
DQo+ICsJCS5udW1fY2hhbm5lbHMgPSBBUlJBWV9TSVpFKGFkNzkwOF9jaGFubmVscyksDQo+ICsJ
fSwNCj4gKwlbQUQ3OTE4XSA9IHsNCj4gKwkJLmNoYW5uZWxzID0gYWQ3OTE4X2NoYW5uZWxzLA0K
PiArCQkubnVtX2NoYW5uZWxzID0gQVJSQVlfU0laRShhZDc5MThfY2hhbm5lbHMpLA0KPiArCX0s
DQo+ICsJW0FENzkyOF0gPSB7DQo+ICsJCS5jaGFubmVscyA9IGFkNzkyOF9jaGFubmVscywNCj4g
KwkJLm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUoYWQ3OTI4X2NoYW5uZWxzKSwNCj4gKwl9LA0K
PiAgfTsNCj4gIA0KPiAgLyoqDQo+IEBAIC0xMzEsNyArMTY0LDExIEBAIHN0YXRpYyBpbnQgYWQ3
OTIzX3VwZGF0ZV9zY2FuX21vZGUoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwNCj4gIAlp
bnQgaSwgY21kLCBsZW47DQo+ICANCj4gIAlsZW4gPSAwOw0KPiAtCWZvcl9lYWNoX3NldF9iaXQo
aSwgYWN0aXZlX3NjYW5fbWFzaywgQUQ3OTIzX01BWF9DSEFOKSB7DQo+ICsJLyoNCj4gKwkgKiBG
b3IgdGhpcyBkcml2ZXIgdGhlIGxhc3QgY2hhbm5lbCBpcyBhbHdheXMgdGhlIHNvZnR3YXJlDQo+
IHRpbWVzdGFtcCBzbw0KPiArCSAqIHNraXAgdGhhdCBvbmUuDQo+ICsJICovDQo+ICsJZm9yX2Vh
Y2hfc2V0X2JpdChpLCBhY3RpdmVfc2Nhbl9tYXNrLCBpbmRpb19kZXYtPm51bV9jaGFubmVscyAt
IDEpDQo+IHsNCj4gIAkJY21kID0gQUQ3OTIzX1dSSVRFX0NSIHwgQUQ3OTIzX0NIQU5ORUxfV1JJ
VEUoaSkgfA0KPiAgCQkJQUQ3OTIzX1NFUVVFTkNFX1dSSVRFKEFENzkyM19TRVFVRU5DRV9PRkYp
IHwNCj4gIAkJCXN0LT5zZXR0aW5nczsNCj4gQEAgLTM0NCw2ICszODEsOSBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHNwaV9kZXZpY2VfaWQgYWQ3OTIzX2lkW10gPSB7DQo+ICAJeyJhZDc5MTQiLCBB
RDc5MTR9LA0KPiAgCXsiYWQ3OTIzIiwgQUQ3OTI0fSwNCj4gIAl7ImFkNzkyNCIsIEFENzkyNH0s
DQo+ICsJeyJhZDc5MDgiLCBBRDc5MDh9LA0KPiArCXsiYWQ3OTE4IiwgQUQ3OTE4fSwNCj4gKwl7
ImFkNzkyOCIsIEFENzkyOH0sDQo+ICAJe30NCj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxF
KHNwaSwgYWQ3OTIzX2lkKTsNCj4gQEAgLTM1Myw2ICszOTMsOSBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCBhZDc5MjNfb2ZfbWF0Y2hbXSA9DQo+IHsNCj4gIAl7IC5jb21wYXRp
YmxlID0gImFkaSxhZDc5MTQiLCB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNzkyMyIs
IH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJhZGksYWQ3OTI0IiwgfSwNCj4gKwl7IC5jb21wYXRp
YmxlID0gImFkaSxhZDc5MDgiLCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNzkxOCIs
IH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJhZGksYWQ3OTI4IiwgfSwNCj4gIAl7IH0sDQo+ICB9
Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYWQ3OTIzX29mX21hdGNoKTsNCj4gQEAgLTM3
MCw1ICs0MTMsNSBAQCBtb2R1bGVfc3BpX2RyaXZlcihhZDc5MjNfZHJpdmVyKTsNCj4gIA0KPiAg
TU9EVUxFX0FVVEhPUigiTWljaGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxv
Zy5jb20+Iik7DQo+ICBNT0RVTEVfQVVUSE9SKCJQYXRyaWNrIFZhc3NldXIgPHBhdHJpY2sudmFz
c2V1ckBjLXMuZnI+Iik7DQo+IC1NT0RVTEVfREVTQ1JJUFRJT04oIkFuYWxvZyBEZXZpY2VzIEFE
NzkwNC9BRDc5MTQvQUQ3OTIzL0FENzkyNCBBREMiKTsNCj4gK01PRFVMRV9ERVNDUklQVElPTigi
QW5hbG9nIERldmljZXMgQUQ3OTIzIGFuZCBzaW1pbGFyIEFEQyIpOw0KPiAgTU9EVUxFX0xJQ0VO
U0UoIkdQTCB2MiIpOw0K
