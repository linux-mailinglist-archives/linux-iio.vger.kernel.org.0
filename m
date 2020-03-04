Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911B1178C02
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 08:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgCDHzP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 02:55:15 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2748 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725271AbgCDHzO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 02:55:14 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0247o61H027240;
        Wed, 4 Mar 2020 02:55:12 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52a7yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 02:55:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpIbdWK5Ja5cAAv9y6swTIpi1Ex/F1L93Tfwgz58bvy5mr3IXjrfXv05zxVXg4f2Qt8lcci8KtbyS3XbUSNCto134oOocl5IArB1rsAzJvCsM2Uzr4YDoLTByjg9lb37Ms82JnB89Ze0UpVDkAQtRjhL64cbOVfWajYiz9JGQfIE86Qv1RbNYKfTG4EJvchWHk1bW467Qc/KkKRA8POVS1WnzuQjZNUDoLexv1RmPqxPq+7ugOX+XaiFUbkgKosb2wpC008nmXB6vc89lGOmMYt7M8SdBRwjDcyH8JRWhDsOC8G/ZM6W9yw2awFlFrdFkVHsoJFYXIsA7Jsjwge83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzuS+31t5/CwffCq1Co0tq2C+Qx6TQa1uI/ABILbo14=;
 b=PQe+oB3qFunnhFnhCaDheKusiRXnQ13eBFqvMNWpF8pCfcTKZsx3NdPbibt31B6FR45EpjP1xiFzSuEDm6yLFV6vvgleQgRZ7H5KEnlX2e3VaKUd/K1H+z7XeoCaZeveq7JbterHCseUuT9rZRcID0uxNjpw303k5FedJRALJbkjpvm9scoy+N4jTF7Tg2wGXLb+HWB9QTU9/iZ9qMduF7kTUs79I3tzlvP2Ref0koQiCLPuQJzt6VPx/F7WaceLW9z3Ilu5tgJ2ErddIRjF0Mz17QlBxy5CJVS2ukBm9nGey5mtHLCED104nuBoVsuXvBUM6vcuQa8073Ao+tx7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzuS+31t5/CwffCq1Co0tq2C+Qx6TQa1uI/ABILbo14=;
 b=7sdKZMKAevtuM7+Dpb81BYJCsFg7GwAWKG2TE6P3rhD7gqARt3YkpXu96cAhzR/NGsFVmpocU2tPXI47Dg0B41ljVV3lLJD2bIcILx6Gf7ez07MlCMhi5sH41ISv1Bqx4uM4muTlzbl6nRH0yWd4fSTuxf0H4pHwiSNUEQ+KFu8=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5285.namprd03.prod.outlook.com (2603:10b6:610:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 07:55:11 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 07:55:11 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
Thread-Topic: [PATCH v3 6/8] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
Thread-Index: AQHV7Udb5D6lYi83SEWbjatESgaKOKg3HfGAgAD80YA=
Date:   Wed, 4 Mar 2020 07:55:11 +0000
Message-ID: <e8075f2fc949b541ccc369bc0cc5d3726ea0a3bf.camel@analog.com>
References: <20200227082719.6343-1-alexandru.ardelean@analog.com>
         <20200227082719.6343-7-alexandru.ardelean@analog.com>
         <20200303165323.GA32472@bogus>
In-Reply-To: <20200303165323.GA32472@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5611d698-d6d8-4969-f087-08d7c0115d7c
x-ms-traffictypediagnostic: CH2PR03MB5285:
x-microsoft-antispam-prvs: <CH2PR03MB5285750BDAA761AB11766B05F9E50@CH2PR03MB5285.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(189003)(91956017)(6512007)(6506007)(66476007)(64756008)(66446008)(2616005)(76116006)(66556008)(71200400001)(26005)(66946007)(186003)(8676002)(54906003)(36756003)(6916009)(81156014)(4326008)(86362001)(5660300002)(478600001)(316002)(6486002)(81166006)(966005)(2906002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5285;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lrGq8VMz8UH6cDSXm7d7s9wK43WBEZiK54Uhty7GVOHUAeB7S8b6hhVD9rXiiAM2axfd/3afOb3G3URZ5gybZhPcPlQWIbkymQlOP+iylQjESEf3lRxu3C42j9/Su2/MhK+Z+dw4FOV5cLw3w5MMrTU2LshQRrD/YYDznWUu3daXffwZrNBZrN4h7durAv3JdBo2uTHA9ya9Bp/DN8XWgqK0FZNdBWTZyUAbN2vmy6jc92QTxpDJ5Rc2YYzTu/nC4J5JtR2Ili/xxT0we8ssJtwlvkBBeDpTP+2A2qUaZxTcAmpCFmFw+L8xOERvkYfniU46lPOCMVmcdKt6GAWBqTYMUfIbU713hWuQ7Z6SEc+XvjJmRoWOFVJ97Cb2K+LWvHulc5pyv/u8FU54vbABLkuTle0Vm0s3LifYKAZZylv/QMvBWERJHIJD42InOdK2/fd66zhkukLBMz+uRR+nzgAhrW+PLdROS4fAJdE5OGOzYvgQ5a33B1mBYhWF+2lIMI37BXuOvihRgzcpR98ejQ==
x-ms-exchange-antispam-messagedata: x5O0V2kX4Q7VVBUi5ae7tmqX375FfPUSTbWn6W31qbXYTn/MYGwYnseqDX2aketERY0yOKVyzjriAt11wYamCeXPA+XWqAxExc7FNHDYMm2vxYUX9LAWcixXMnHMm8EO/ZrU3Lj1c0Ud7kO9puDbTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3D58B2C9D609043B829F5D385F51B60@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5611d698-d6d8-4969-f087-08d7c0115d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 07:55:11.1063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4FIccm9Ge/K1g7JJljRXO9tG0Q8uwpF5dtB/nJtwQAhWwEUW2dXAcKWM9VhcCWnYT8WA7BqhWQTEmwktmoBMXW24vWeu/cGnyroB6DkZ8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5285
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040061
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDEwOjUzIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBGZWIgMjcsIDIwMjAgYXQgMTA6Mjc6MTdBTSArMDIwMCwgQWxleGFuZHJ1IEFyZGVs
ZWFuIHdyb3RlOg0KPiA+IFRoaXMgY2hhbmdlIGFkZHMgdGhlIGJpbmRpbmdzIGRvY3VtZW50YXRp
b24gZm9yIHRoZSBBWEkgQURDIGRyaXZlci4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9hZGktYXhpLWFkYy55YW1sICAgICAgICAgfCA2OSAr
KysrKysrKysrKysrKysrKysrDQo+IA0KPiBGb2xsb3cgdGhlIGNvbXBhdGlibGUgc3RyaW5nOiBh
ZGksYXhpLWFkYy55YW1sIA0KDQphY2sNCg0KPiANCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY5IGlu
c2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaS1heGktDQo+ID4gYWRjLnlhbWwNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRp
LWF4aS1hZGMueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by9hZGMvYWRpLWF4aS1hZGMueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5kNDVkNDFmNGYwOGUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLWF4aS1hZGMu
eWFtbA0KPiA+IEBAIC0wLDAgKzEsNjkgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICst
LS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vYWRjL2FkaS1h
eGktYWRjLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNj
aGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IEFuYWxvZyBEZXZpY2VzIEFYSSBB
REMgSVAgY29yZQ0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBNaWNoYWVsIEhl
bm5lcmljaCA8bWljaGFlbC5oZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gPiArICAtIEFsZXhhbmRy
dSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gKw0KPiA+ICtk
ZXNjcmlwdGlvbjogfA0KPiA+ICsgIEFuYWxvZyBEZXZpY2VzIEdlbmVyaWMgQVhJIEFEQyBJUCBj
b3JlIGZvciBpbnRlcmZhY2luZyBhbiBBREMgZGV2aWNlDQo+ID4gKyAgd2l0aCBhIGhpZ2ggc3Bl
ZWQgc2VyaWFsIChKRVNEMjA0Qi9DKSBvciBzb3VyY2Ugc3luY2hyb25vdXMgcGFyYWxsZWwNCj4g
PiArICBpbnRlcmZhY2UgKExWRFMvQ01PUykuDQo+ID4gKyAgVXN1YWxseSwgc29tZSBvdGhlciBp
bnRlcmZhY2UgdHlwZSAoaS5lIFNQSSkgaXMgdXNlZCBhcyBhIGNvbnRyb2wNCj4gPiArICBpbnRl
cmZhY2UgZm9yIHRoZSBhY3R1YWwgQURDLCB3aGlsZSB0aGlzIElQIGNvcmUgd2lsbCBpbnRlcmZh
Y2UNCj4gPiArICB0byB0aGUgZGF0YS1saW5lcyBvZiB0aGUgQURDIGFuZCBoYW5kbGUgdGhlIHN0
cmVhbWluZyBvZiBkYXRhIGludG8NCj4gPiArICBtZW1vcnkgdmlhIERNQS4NCj4gPiArDQo+ID4g
KyAgaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2VzL2ZwZ2EvZG9jcy9heGlfYWRjX2lw
DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBl
bnVtOg0KPiA+ICsgICAgICAtIGFkaSxheGktYWRjLTEwLjAuYQ0KPiA+ICsNCj4gPiArICByZWc6
DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBkbWFzOg0KPiA+ICsgICAgbWlu
SXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+IA0KPiBKdXN0IG1heEl0ZW1zIGlzIGVu
b3VnaC4NCg0KYWNrDQoNCj4gDQo+ID4gKw0KPiA+ICsgIGRtYS1uYW1lczoNCj4gPiArICAgIG1h
eEl0ZW1zOiAxDQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogcngNCj4gPiAr
DQo+ID4gKyAgYWRpLWF4aS1hZGMtY2xpZW50Og0KPiANCj4gYWRpLGF4aS1hZGMtY2xpZW50DQo+
IA0KPiBUaG91Z2ggSSB0aGluayAnYWRpLGFkYy1kZXYnIHdvdWxkIGJlIGJldHRlciBuYW1lLg0K
DQp3b3JrcyBmb3IgbWUNCm9uZSBxdWVzdGlvbiB0aG91Z2g7IHRoaXMgc3RpbGwgZ2l2ZXM6DQoN
CiAgQ0hLRFQgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGks
YXhpLWFkYy55YW1sDQovaG9tZS9zYW5kdS93b3JrL2xpbnV4L3Vwc3RyZWFtL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxheA0KaS1hZGMueWFtbDogcHJvcGVy
dGllczphZGksYWRjLWRldjogeydkZXNjcmlwdGlvbic6ICdBIHJlZmVyZW5jZSB0byBhIHRoZSBh
Y3R1YWwNCkFEQyB0byB3aGljaCB0aGlzIEZQR0EgQURDIGludGVyZmFjZXMgdG8uJywgJ21heEl0
ZW1zJzogMX0gaXMgbm90IHZhbGlkIHVuZGVyDQphbnkgb2YgdGhlIGdpdmVuIHNjaGVtYXMgKFBv
c3NpYmxlIGNhdXNlcyBvZiB0aGUgZmFpbHVyZSk6DQoJL2hvbWUvc2FuZHUvd29yay9saW51eC91
cHN0cmVhbS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkDQpjL2FkaSxh
eGktYWRjLnlhbWw6IHByb3BlcnRpZXM6YWRpLGFkYy1kZXY6ICdub3QnIGlzIGEgcmVxdWlyZWQg
cHJvcGVydHkNCg0KDQpBbnkgdGhvdWdodHM/DQoNCg0KPiANCj4gPiArICAgIGRlc2NyaXB0aW9u
Og0KPiA+ICsgICAgICBBIHJlZmVyZW5jZSB0byBhIHRoZSBhY3R1YWwgQURDIHRvIHdoaWNoIHRo
aXMgRlBHQSBBREMgaW50ZXJmYWNlcyB0by4NCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0K
PiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIGRtYXMNCj4gPiAr
ICAtIHJlZw0KPiA+ICsgIC0gYWRpLWF4aS1hZGMtY2xpZW50DQo+ID4gKw0KPiA+ICthZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0K
PiA+ICsgICAgZnBnYV9heGkgew0KPiANCj4gWW91IGNhbiBkcm9wIHRoaXMgbm9kZS4NCg0KYWNr
DQoNCj4gDQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAg
I3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKw0KPiA+ICsgICAgICAgIGF4aS1hZGNANDRhMDAwMDAg
ew0KPiA+ICsgICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYXhpLWFkYy0xMC4wLmEiOw0KPiA+
ICsgICAgICAgICAgcmVnID0gPDB4NDRhMDAwMDAgMHgxMDAwMD47DQo+ID4gKyAgICAgICAgICBk
bWFzID0gPCZyeF9kbWEgMD47DQo+ID4gKyAgICAgICAgICBkbWEtbmFtZXMgPSAicngiOw0KPiA+
ICsNCj4gPiArICAgICAgICAgIGFkaS1heGktYWRjLWNsaWVudCA9IDwmc3BpX2FkYz47DQo+ID4g
KyAgICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gKy4uLg0KPiA+IC0tIA0KPiA+IDIuMjAuMQ0K
PiA+IA0K
