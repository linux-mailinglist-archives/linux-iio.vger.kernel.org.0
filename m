Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F21B11A54E
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 08:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfLKHq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 02:46:29 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:52906 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbfLKHq2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 02:46:28 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB7jPii001014;
        Wed, 11 Dec 2019 02:46:06 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wraevv3ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 02:46:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEvuDc8KWZO7aOrfTPzMHLPJ4kBsllriAZqUD5THHu1r5o88uA8SbZefK2na+ggu2Ti0picFCHSw/rNgv2QTWiFMIrtt+7AiqFizQz2Wnxzg7wD7+dYDmXN1wOQlF7Sddxt8azB9hPFHH8OHhfOOSXDbWRzE1nvKJ9zDrMtnjHA1C71bd1dHia69918kkYNnfRHKzNLxhDKKOxrMOjtBv17VA1Vqt/Oe+82Dk08bxsGp28/eQ32dBfWMgzcltTrhBsy95i3HSssTeGJdXycgedFzSSDvwKnA730XOUmZyNZ24lUGovx0sY0EjRE9ZlUia3mYjWbfu3zfsnmoCkGs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bID5EXQGKK8qe5ElelF8EerA7VRX/xe3B0j+j1xOmBU=;
 b=CIQlqyni3Q/OP+B8kyU56vUESpVm/9SbRyD+74oMhLbu6HkzAfiqB1ilizbf83hyiwwbOUr9sLu9LaUYlWsImwGnQwFEbckgqRw0XHW4pHYP2ViUwuyilN/FMP+9mhlc1R5V5bHqpu3VlWzAE+EvJQVj7noh7pFtgEghPbinj6p16Qd32ZfAq8yVoXKzFp718l7WGF4B/dcctSb5AdTIUJ+CIuHYqOHDcT7ukBWzZTwXJrpwc7MDmXr5fQ3lCKWbIMJzBMmx+Gd6F7DokREvoCse8g8comT/Qn9PoVisAkcEC5EcaSLDV8VVT40PID4UdProJnUHB3uox3U/pdAzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bID5EXQGKK8qe5ElelF8EerA7VRX/xe3B0j+j1xOmBU=;
 b=apJPWKgDfFGm8A6mv0NYiXMUWtimBooBl4KNuxBZVpQZ/k7h6DurRDuqUW2SKSd20Zf8FsQPqVt35QzPs+3Gxp1kPayzyCrkzGFfpQ8mWCiEpbQU9Xx0q7mPOzUb2O2X4iPpIxyALRYibwKsJAn/Nkvv86zmMS3+1JdZ5DxXid0=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5208.namprd03.prod.outlook.com (20.180.4.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 11 Dec 2019 07:46:04 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 07:46:04 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7923: Add support for the
 ad7908/ad7918/ad7928
Thread-Topic: [PATCH v2 4/4] iio: adc: ad7923: Add support for the
 ad7908/ad7918/ad7928
Thread-Index: AQHVr2vKPavhydgmhEm1//0Nw9gpUqe0j6KA
Date:   Wed, 11 Dec 2019 07:46:04 +0000
Message-ID: <e3e9d03c9679144612f5949eb32565e9b8f119d7.camel@analog.com>
References: <20191210150811.3429-1-djunho@gmail.com>
         <20191210150811.3429-5-djunho@gmail.com>
In-Reply-To: <20191210150811.3429-5-djunho@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64a4528e-b849-461f-a796-08d77e0e2cfb
x-ms-traffictypediagnostic: CH2PR03MB5208:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5208D8CC70A74F0E6891C927F95A0@CH2PR03MB5208.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(316002)(66946007)(2906002)(6512007)(8936002)(2616005)(71200400001)(5660300002)(36756003)(81156014)(81166006)(66476007)(66556008)(6506007)(8676002)(76116006)(64756008)(66446008)(6486002)(4001150100001)(110136005)(26005)(478600001)(86362001)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5208;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xOMV/l8dVIUxMuD7QdTLxxAjr0EUNVKSSEY5ERbc47+dDMwke4QhSdyQX+Reid/F2crEKyLOLC0UDGwA0xRoJLCW13k/ngj9lxIHv/sQ1oI5s9R/gI6TZelq4HTdZfzK6tvDHYLyLmGdqUMFc2bg4r142CE6AkJu/3CtPWy6+9+QZqu4f5LjoGJfTpGKnwcx+IrPgel6HV9/vK1QTDEtTL4XgGZG9paZr4EdVe0bC0emddxvRmNUM0ykqOwwAx8uvaupKv6bGf28A6/ac6XTSmtpv+ZvUpuDqr2w3k3pI5/dZIWXmFZAasHLxoohI9H+gPO5Yl2BEAvREkwMCYqSXpb78/E9m1sJJV8IZTcxaiXN+Hveo9Kyr07XtVf1TuB8/Bzuolwoz2Hi76h4UkeC2Mzd5CyDLqLTA8RYlwprSstwe+eexCnMvNwpFyIN6Dz/mSCfr7XKOJnEJmrF5W58QAGPZruvCGPUVe3WZ+7c/DRu1C3omHX5ngkOsXg4MHX3
Content-Type: text/plain; charset="utf-8"
Content-ID: <609CBABDFA95C943BCAAD91451A3E08F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a4528e-b849-461f-a796-08d77e0e2cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 07:46:04.4680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oery7/hmkKO76jAja1Ltfk1Cq0s+OsfsfD3/aX/w0F3pChE66tTErJcw0/IhSg/FdqdNQMo33h1j5VEa+1oT3qFEUtqMr6eP588UqOCedsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5208
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_01:2019-12-10,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110066
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTEwIGF0IDEyOjA4IC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoZSBhZDc5MjggaXMgc29mdHdhcmUgY29tcGF0aWJsZSB3aXRo
IHRoZSBhZDc5MjMuDQo+IFRoZSBhZDc5MDggYW5kIGFkNzkxOCBhcmUgdGhlIDggYW5kIDEwLWJp
dCB2ZXJzaW9ucyBvZiB0aGUgYWQ3OTI4Lg0KPiANCg0KVGhlIHBhdGNoIGxvb2tzIGdvb2QuDQpD
b21tZW50cyBtb3N0bHkgYWJvdXQgbmFtaW1nLg0KT25lIGFib3V0IGNoYW5uZWwgbnVtYmVycy4N
Cg0KDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBKdW5obyA8ZGp1bmhvQGdtYWlsLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvYWQ3OTIzLmMgfCA2MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2Fk
NzkyMy5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IGluZGV4IDZkNTZmYTBiOWUzMC4u
YWU4MDdmY2FhZDc2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWQ3OTIzLmMNCj4g
KysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IEBAIC0xLDYgKzEsNiBAQA0KPiAgLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiAgLyoNCj4gLSAqIEFENzkw
NC9BRDc5MTQvQUQ3OTIzL0FENzkyNCBTUEkgQURDIGRyaXZlcg0KPiArICogQUQ3OTA0L0FENzkx
NC9BRDc5MjMvQUQ3OTI0L0FENzkwOC9BRDc5MTgvQUQ3OTI4IFNQSSBBREMgZHJpdmVyDQo+ICAg
Kg0KPiAgICogQ29weXJpZ2h0IDIwMTEgQW5hbG9nIERldmljZXMgSW5jIChmcm9tIEFENzkyMyBE
cml2ZXIpDQo+ICAgKiBDb3B5cmlnaHQgMjAxMiBDUyBTeXN0ZW1lcyBkJ0luZm9ybWF0aW9uDQo+
IEBAIC0yOSwxMSArMjksMTQgQEANCj4gICNkZWZpbmUgQUQ3OTIzX1BNX01PREVfQVMJKDEpCQkv
KiBhdXRvIHNodXRkb3duICovDQo+ICAjZGVmaW5lIEFENzkyM19QTV9NT0RFX0ZTCSgyKQkJLyog
ZnVsbCBzaHV0ZG93biAqLw0KPiAgI2RlZmluZSBBRDc5MjNfUE1fTU9ERV9PUFMJKDMpCQkvKiBu
b3JtYWwgb3BlcmF0aW9uICovDQo+IC0jZGVmaW5lIEFENzkyM19TRVFVRU5DRV9PRkYJKDApCQkv
KiBubyBzZXF1ZW5jZSBmb25jdGlvbg0KPiAqLw0KPiAtI2RlZmluZSBBRDc5MjNfU0VRVUVOQ0Vf
UFJPVEVDVAkoMikJCS8qIG5vIGludGVycnVwdA0KPiB3cml0ZSBjeWNsZSAqLw0KPiAtI2RlZmlu
ZSBBRDc5MjNfU0VRVUVOQ0VfT04JKDMpCQkvKiBjb250aW51b3VzIHNlcXVlbmNlICovDQo+ICAN
Cj4gLSNkZWZpbmUgQUQ3OTIzX01BWF9DSEFOCQk0DQo+ICsjZGVmaW5lIEFENzkyM19TRVFVRU5D
RV9PRkYJKDB4MDApCQkvKiBubyBzZXF1ZW5jZSBmdW5jdGlvbg0KPiAqLw0KPiArI2RlZmluZSBB
RDc5MjNfU0VRVUVOQ0VfU0hBRE9XCSgweDAxKQkJLyogdXNlIHRoZSBzaGFkb3cNCj4gcmVnaXN0
ZXINCj4gKwkJCQkJCSAqIGZvciBwcm9ncmFtbWluZw0KPiArCQkJCQkJICogKG9ubHkgQUQ3OTA4
Lzc5MTgvNzkyOCkNCg0KDQpbMV0gU2luY2UgdGhpcyByZWcgaXMgb25seSBhdmFpbGFibGUgb24g
dGhlc2UgMyBjaGlwcywgeW91IGNvdWxkIHJlbmFtZQ0KdGhpcyB0byBBRDc5MDhfU0VRVUVOQ0Vf
U0hBRE9XICBhbmQgdXNlIGl0IGZvciB0aGVzZSAzIGNoaXBzIG9ubHkuDQpUaGF0IHdheSwgeW91
IGRvbid0IG5lZWQgdG8gbWVudGlvbiB2aWEgY29tbWVudCAiKG9ubHkgQUQ3OTA4Lzc5MTgvNzky
OCkiDQoNCg0KPiArCQkJCQkJICovDQo+ICsjZGVmaW5lIEFENzkyM19TRVFVRU5DRV9QUk9URUNU
CSgweDEwKQkJLyogbm8gaW50ZXJydXB0DQo+IHdyaXRlIGN5Y2xlICovDQo+ICsjZGVmaW5lIEFE
NzkyM19TRVFVRU5DRV9PTgkoMHgxMSkJCS8qIGNvbnRpbnVvdXMgc2VxdWVuY2UgKi8NCj4gIA0K
PiAgI2RlZmluZSBBRDc5MjNfUE1fTU9ERV9XUklURShtb2RlKQkoKG1vZGUpIDw8IDQpCSAvKiB3
cml0ZSBtb2RlICovDQo+ICAjZGVmaW5lIEFENzkyM19DSEFOTkVMX1dSSVRFKGNoYW5uZWwpCSgo
Y2hhbm5lbCkgPDwgNikgLyogd3JpdGUNCj4gY2hhbm5lbCAqLw0KPiBAQCAtNzQsNiArNzcsOSBA
QCBlbnVtIGFkNzkyM19pZCB7DQo+ICAJQUQ3OTA0LA0KPiAgCUFENzkxNCwNCj4gIAlBRDc5MjQs
DQo+ICsJQUQ3OTA4LA0KPiArCUFENzkxOCwNCj4gKwlBRDc5MjgNCj4gIH07DQo+ICANCj4gICNk
ZWZpbmUgQUQ3OTIzX1ZfQ0hBTihpbmRleCwgYml0cykJCQkJCVwNCj4gQEAgLTkzLDcgKzk5LDcg
QEAgZW51bSBhZDc5MjNfaWQgew0KPiAgCQl9LAkJCQkJCQlcDQo+ICAJfQ0KPiAgDQo+IC0jZGVm
aW5lIERFQ0xBUkVfQUQ3OTIzX0NIQU5ORUxTKG5hbWUsIGJpdHMpIFwNCj4gKyNkZWZpbmUgREVD
TEFSRV9BRDc5MjNfNENIQU5ORUxTKG5hbWUsIGJpdHMpIFwNCj4gIGNvbnN0IHN0cnVjdCBpaW9f
Y2hhbl9zcGVjIG5hbWUgIyMgX2NoYW5uZWxzW10gPSB7IFwNCj4gIAlBRDc5MjNfVl9DSEFOKDAs
IGJpdHMpLCBcDQo+ICAJQUQ3OTIzX1ZfQ0hBTigxLCBiaXRzKSwgXA0KPiBAQCAtMTAyLDkgKzEw
OCwyNSBAQCBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBuYW1lICMjIF9jaGFubmVsc1tdID0g
eyBcDQo+ICAJSUlPX0NIQU5fU09GVF9USU1FU1RBTVAoNCksIFwNCj4gIH0NCj4gIA0KPiAtc3Rh
dGljIERFQ0xBUkVfQUQ3OTIzX0NIQU5ORUxTKGFkNzkwNCwgOCk7DQo+IC1zdGF0aWMgREVDTEFS
RV9BRDc5MjNfQ0hBTk5FTFMoYWQ3OTE0LCAxMCk7DQo+IC1zdGF0aWMgREVDTEFSRV9BRDc5MjNf
Q0hBTk5FTFMoYWQ3OTI0LCAxMik7DQo+ICsjZGVmaW5lIERFQ0xBUkVfQUQ3OTIzXzhDSEFOTkVM
UyhuYW1lLCBiaXRzKSBcDQoNClNhbWUgY29tbWVudHMgYXMgWzFdLCB5b3UgY291bGQgbGVhdmUg
REVDTEFSRV9BRDc5MjNfQ0hBTk5FTFMgYW5kIGRlY2xhcmUNCkRFQ0xBUkVfQUQ3OTA4X0NIQU5O
RUxTIHdoaWNoIGhhcyA4IGNoYW5uZWxzIGFuZCB1c2UgZm9yIHRoZSAzIG5ldyBjaGlwcy4NCg0K
PiArY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgbmFtZSAjIyBfY2hhbm5lbHNbXSA9IHsgXA0K
PiArCUFENzkyM19WX0NIQU4oMCwgYml0cyksIFwNCj4gKwlBRDc5MjNfVl9DSEFOKDEsIGJpdHMp
LCBcDQo+ICsJQUQ3OTIzX1ZfQ0hBTigyLCBiaXRzKSwgXA0KPiArCUFENzkyM19WX0NIQU4oMywg
Yml0cyksIFwNCj4gKwlBRDc5MjNfVl9DSEFOKDQsIGJpdHMpLCBcDQo+ICsJQUQ3OTIzX1ZfQ0hB
Tig1LCBiaXRzKSwgXA0KPiArCUFENzkyM19WX0NIQU4oNiwgYml0cyksIFwNCj4gKwlBRDc5MjNf
Vl9DSEFOKDcsIGJpdHMpLCBcDQo+ICsJSUlPX0NIQU5fU09GVF9USU1FU1RBTVAoOCksIFwNCj4g
K30NCj4gKw0KPiArc3RhdGljIERFQ0xBUkVfQUQ3OTIzXzRDSEFOTkVMUyhhZDc5MDQsIDgpOw0K
PiArc3RhdGljIERFQ0xBUkVfQUQ3OTIzXzRDSEFOTkVMUyhhZDc5MTQsIDEwKTsNCj4gK3N0YXRp
YyBERUNMQVJFX0FENzkyM180Q0hBTk5FTFMoYWQ3OTI0LCAxMik7DQo+ICtzdGF0aWMgREVDTEFS
RV9BRDc5MjNfOENIQU5ORUxTKGFkNzkwOCwgOCk7DQo+ICtzdGF0aWMgREVDTEFSRV9BRDc5MjNf
OENIQU5ORUxTKGFkNzkxOCwgMTApOw0KPiArc3RhdGljIERFQ0xBUkVfQUQ3OTIzXzhDSEFOTkVM
UyhhZDc5MjgsIDEyKTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZDc5MjNfY2hpcF9p
bmZvIGFkNzkyM19jaGlwX2luZm9bXSA9IHsNCj4gIAlbQUQ3OTA0XSA9IHsNCj4gQEAgLTExOSw2
ICsxNDEsMTggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZDc5MjNfY2hpcF9pbmZvDQo+IGFkNzky
M19jaGlwX2luZm9bXSA9IHsNCj4gIAkJLmNoYW5uZWxzID0gYWQ3OTI0X2NoYW5uZWxzLA0KPiAg
CQkubnVtX2NoYW5uZWxzID0gQVJSQVlfU0laRShhZDc5MjRfY2hhbm5lbHMpLA0KPiAgCX0sDQo+
ICsJW0FENzkwOF0gPSB7DQo+ICsJCS5jaGFubmVscyA9IGFkNzkwOF9jaGFubmVscywNCj4gKwkJ
Lm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUoYWQ3OTA4X2NoYW5uZWxzKSwNCj4gKwl9LA0KPiAr
CVtBRDc5MThdID0gew0KPiArCQkuY2hhbm5lbHMgPSBhZDc5MThfY2hhbm5lbHMsDQo+ICsJCS5u
dW1fY2hhbm5lbHMgPSBBUlJBWV9TSVpFKGFkNzkxOF9jaGFubmVscyksDQo+ICsJfSwNCj4gKwlb
QUQ3OTI4XSA9IHsNCj4gKwkJLmNoYW5uZWxzID0gYWQ3OTI4X2NoYW5uZWxzLA0KPiArCQkubnVt
X2NoYW5uZWxzID0gQVJSQVlfU0laRShhZDc5MjhfY2hhbm5lbHMpLA0KPiArCX0sDQo+ICB9Ow0K
PiAgDQo+ICAvKioNCj4gQEAgLTEzMSw3ICsxNjUsNyBAQCBzdGF0aWMgaW50IGFkNzkyM191cGRh
dGVfc2Nhbl9tb2RlKHN0cnVjdCBpaW9fZGV2DQo+ICppbmRpb19kZXYsDQo+ICAJaW50IGksIGNt
ZCwgbGVuOw0KPiAgDQo+ICAJbGVuID0gMDsNCj4gLQlmb3JfZWFjaF9zZXRfYml0KGksIGFjdGl2
ZV9zY2FuX21hc2ssIEFENzkyM19NQVhfQ0hBTikgew0KPiArCWZvcl9lYWNoX3NldF9iaXQoaSwg
YWN0aXZlX3NjYW5fbWFzaywgaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgLSAxKSANCg0KSSBnb3Qg
dGhlIGlkZWEgYWJvdXQgJ2luZGlvX2Rldi0+bnVtX2NoYW5uZWwgLSAxJy4NClRoaXMgbWFrZXMg
dGhlIGFzc3VtcHRpb24gdGhhdCB0aGUgbnVtYmVyIG9mIElJTyBjaGFubmVscyBpcyBhbHdheXMg
SFctDQpjaGFubmVscyArIDEgdGltZXN0YW1wIGNoYW5uZWwgW3doaWNoIGZvciBub3cgaXMgdHJ1
ZV0uDQpJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBvay4NCg0KSSB0aGluayBKb25hdGhhbiB3b3Vs
ZCBiZSBhIGJpdCBiZXR0ZXIgaGVyZSB0byBjb21tZW50Lg0KDQo+IHsNCj4gIAkJY21kID0gQUQ3
OTIzX1dSSVRFX0NSIHwgQUQ3OTIzX0NIQU5ORUxfV1JJVEUoaSkgfA0KPiAgCQkJQUQ3OTIzX1NF
UVVFTkNFX1dSSVRFKEFENzkyM19TRVFVRU5DRV9PRkYpIHwNCj4gIAkJCXN0LT5zZXR0aW5nczsN
Cj4gQEAgLTM0NCw2ICszNzgsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9kZXZpY2VfaWQg
YWQ3OTIzX2lkW10gPSB7DQo+ICAJeyJhZDc5MTQiLCBBRDc5MTR9LA0KPiAgCXsiYWQ3OTIzIiwg
QUQ3OTI0fSwNCj4gIAl7ImFkNzkyNCIsIEFENzkyNH0sDQo+ICsJeyJhZDc5MDgiLCBBRDc5MDh9
LA0KPiArCXsiYWQ3OTE4IiwgQUQ3OTE4fSwNCj4gKwl7ImFkNzkyOCIsIEFENzkyOH0sDQo+ICAJ
e30NCj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxFKHNwaSwgYWQ3OTIzX2lkKTsNCj4gQEAg
LTM1Myw2ICszOTAsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhZDc5MjNf
b2ZfbWF0Y2hbXSA9DQo+IHsNCj4gIAl7IC5jb21wYXRpYmxlID0gImFkaSxhZDc5MTQiLCB9LA0K
PiAgCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNzkyMyIsIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9
ICJhZGksYWQ3OTI0IiwgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gImFkaSxhZDc5MDgiLCB9LA0K
PiArCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNzkxOCIsIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9
ICJhZGksYWQ3OTI4IiwgfSwNCj4gIAl7IH0sDQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJM
RShvZiwgYWQ3OTIzX29mX21hdGNoKTsNCj4gQEAgLTM3MCw1ICs0MTAsNSBAQCBtb2R1bGVfc3Bp
X2RyaXZlcihhZDc5MjNfZHJpdmVyKTsNCj4gIA0KPiAgTU9EVUxFX0FVVEhPUigiTWljaGFlbCBI
ZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+Iik7DQo+ICBNT0RVTEVfQVVU
SE9SKCJQYXRyaWNrIFZhc3NldXIgPHBhdHJpY2sudmFzc2V1ckBjLXMuZnI+Iik7DQo+IC1NT0RV
TEVfREVTQ1JJUFRJT04oIkFuYWxvZyBEZXZpY2VzIEFENzkwNC9BRDc5MTQvQUQ3OTIzL0FENzky
NCBBREMiKTsNCj4gK01PRFVMRV9ERVNDUklQVElPTigiQW5hbG9nIERldmljZXMNCj4gQUQ3OTA0
L0FENzkxNC9BRDc5MjMvQUQ3OTI0L0FENzkwOC9BRDc5MTgvQUQ3OTI4IEFEQyIpOw0KDQpUaGlz
IGRlc2NyaXB0aW9uIGlzIGJlY29taW5nIGxvbmcuDQpNYXliZSBzaW1wbGlmeSB0byANCk1PRFVM
RV9ERVNDUklQVElPTigiQW5hbG9nIERldmljZXMgQUQ3OTIzIGFuZCBzaW1pbGFyIEFEQyIpOw0K
DQo+ICBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo=
