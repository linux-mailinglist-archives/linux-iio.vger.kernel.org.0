Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084D9CE350
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfJGNWM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 09:22:12 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3618 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727572AbfJGNWL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 09:22:11 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97DHk8l023079;
        Mon, 7 Oct 2019 09:21:52 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2055.outbound.protection.outlook.com [104.47.40.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ver39frah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 09:21:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5vJ8diGTHNqa3xyiddtTQTScg/Yg5p9fqYDIQJtQXIWblvN71YmjOuRGOyH/CXSDCyTiPY+Imr74Wjxy7cAkaKgRdskwHIjPFuRbli2KDjCGXxo5LRSuke/CPCim0a58DjafAviMTuKjMtxRahdfLUrAJcnYWyf5xTrt1SPKuoO+8ED38Gp1rlBVvM3puAkHnr0eM+9Md5Lv+ILSOU12id7FDn6j+wNdZ0K4nPpKHJfLJAnSTtxSEgThCbIYtolnACNoINyDndYLPjCxiw6b4OifOMCTMxX2xSzd+zAAHniB1aN8maGnF/gN2emA9ib0H1S7IPG5bKZptYEPEI3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhCtdndeYhcxjfnBFZCMwHJCAkIkA6Mnx9qKZH7QCA4=;
 b=gFmQFGM5PYoE9jXpUvl7TjpIc9/fEzEp+jvfPyValuetMeIHBK5vfww55CnyRgyDTpb8s1MN/kKO+FuGOER2vNDArm8mZ01UFKufYCEGEaFRPa9beL7aDC4EZH99sUt4C+VGRDOxaD3LyKBBx1D3s3NfPWdrTJzxIDWfb6G5MhUHRxAhQ2aW/tKwKzMx/0BPlMFLDBEYoZU3yvH8ZJNVvverJXW99/vkdbV67tV6Jg0dq4YPckq20kpp5YAEic9Yfz09jspM2iC48l9sd3Qm84YPuYdrVpH+RKgr3Yb5TKagiGHrQbAMpY+n54ClcQWVik82Pw91ogMTTeBDQ0yLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhCtdndeYhcxjfnBFZCMwHJCAkIkA6Mnx9qKZH7QCA4=;
 b=FExS/QUgSJrJkD8JIB9dql8qCdoTZCA6JqSns8wRI3Ipu0USNXueOorM4DPo7igqPSToJjZRK1iUjjq3ffWBoB7K7xithPMzUQAK5Ejtwc4IJ7vSTU3kfqmaHfvr192XMlwdM9ghUWC/B4j1T8ZIkaGm6Biem6Uw1nr4DdmmtKo=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5255.namprd03.prod.outlook.com (20.180.5.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 13:21:51 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 13:21:50 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Thread-Topic: [PATCH 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Thread-Index: AQHVfPeSWEuDjz9rbUuvJ/9gUHtP1adO+AOAgAAm8wCAAAuAgA==
Date:   Mon, 7 Oct 2019 13:21:50 +0000
Message-ID: <b03c8de71e6d568d54ddfd07758c07c03c0eb89d.camel@analog.com>
References: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
         <20191007101027.8383-2-manivannan.sadhasivam@linaro.org>
         <a60fb9ea8922c1eb532e0b7ef0a69abcc9306255.camel@analog.com>
         <4EC23AB5-B8BE-4E45-8E5B-FCCD5B1508BA@linaro.org>
In-Reply-To: <4EC23AB5-B8BE-4E45-8E5B-FCCD5B1508BA@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1ced93e-721c-4cb0-185d-08d74b29504b
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR03MB5255:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5255303A4AA7DE6A9C10C9BEF99B0@CH2PR03MB5255.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(366004)(199004)(189003)(51914003)(476003)(486006)(2616005)(118296001)(14454004)(446003)(11346002)(966005)(316002)(54906003)(305945005)(81156014)(81166006)(7736002)(8936002)(110136005)(2501003)(229853002)(8676002)(6512007)(6486002)(6436002)(66066001)(2201001)(36756003)(86362001)(6306002)(66946007)(102836004)(26005)(53546011)(478600001)(76116006)(186003)(6506007)(76176011)(256004)(25786009)(6246003)(99286004)(66556008)(66446008)(66476007)(4326008)(64756008)(71200400001)(5660300002)(71190400001)(6116002)(3846002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5255;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YcAo7YotoPZ+h5nuLADaIgveAYmBo6RMtbODj914bxSTTTIS9dbRhMUugX1ybtjejlKmXJRrEpUm3ahb0d+umLbI7FvfUio/EF3t2RAqiP/dDUnRcQo9zuCGdsMDmUXLG9Rgr3x+GizUDMvQLBtAx4M2Dr79PrX0QQcus6Nd8/FxP24rE/Yujni/ENEByi6T0MoZF38UHsx8/dYPRzGm0THLMopA3UV4nUeA9iIFIT1ngkhyaRo2Sxa61okTvyI26dUzMRCHuoqLAa0v55eGMpmogC+k4+ZcZF/CG50WcNaGLRxo/C36fCq5I8AcPMrvI7zzh+Q94YHS2E/9P3K5B/MMr+T6B6txT1ExbOyiDd3iV/0e8mXmjF5bSBnjEFB0FtGX/W6OXzvmzr91MDWAFp8QjbPgv5rglE4a6IHC175e332R/Os9TLl7Yqa2Z4JtbQSqUxtIRH0eeUzO0igWkA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3C73558214195469154C07F60F593A1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ced93e-721c-4cb0-185d-08d74b29504b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 13:21:50.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0fCPB00dQJgA2CW8AKmMeQMaQ4uuV3i2P227AxDXjRj7NgHUpbDQaWPP92y9qgG3XOE7LkDuME7NAUyvNnuqVmQ1Im8ixJwW+sQu0R6pU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5255
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070134
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTEwLTA3IGF0IDE4OjEwICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0g
d3JvdGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IEhpIEFyZGVsZWFuLCANCj4gDQo+IE9uIDcgT2N0
b2JlciAyMDE5IDM6NTE6MTYgUE0gSVNULCAiQXJkZWxlYW4sIEFsZXhhbmRydSIgPA0KPiBhbGV4
YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gT24gTW9uLCAyMDE5LTEwLTA3
IGF0IDE1OjQwICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0gd3JvdGU6DQo+ID4gPiBbRXh0
ZXJuYWxdDQo+ID4gPiANCj4gPiA+IEFkZCBkZXZpY2V0cmVlIGJpbmRpbmcgZm9yIEFuYWxvZyBE
ZXZpY2VzIEFEVVgxMDIwIFBob3RvbWV0cmljDQo+ID4gPiBzZW5zb3IuDQo+ID4gPiANCj4gPiAN
Cj4gPiBIZXksDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2hlcy4NCj4gPiANCj4gPiBU
aGlzIGR0LWJpbmRpbmcgZG9jcyBpcyBpbiB0ZXh0IGZvcm1hdC4NCj4gPiBkdC1iaW5kaW5nIGRv
Y3Mgbm93IG5lZWQgdG8gYmUgaW4gWUFNTCBmb3JtYXQuDQo+ID4gDQo+IA0KPiBTdXJlLiBJIGNh
biBjb252ZXJ0IHRvIFlBTUwgYmluZGluZy4gDQo+IA0KPiA+IEFsc28sIHBhdGNoZXMgZm9yIGR0
LWJpbmRpbmdzIGRvY3MgdXN1YWxseSBjb21lIGFmdGVyIHRoZSBkcml2ZXIgaXMNCj4gPiBhZGRl
ZC4NCj4gPiBTbywgdGhpcyBwYXRjaCBzaG91bGQgYmUgdGhlIHNlY29uZCBpbiB0aGUgc2VyaWVz
LCBub3QgdGhlIGZpcnN0Lg0KPiA+IA0KPiANCj4gSSBkb24ndCB0aGluayBzby4gVGhlIGNvbnZl
bnRpb24gaXMgdG8gcHV0IGR0LWJpbmRpbmdzIHBhdGNoIHVwZnJvbnQgZm9yDQo+IGFsbCBzdWJz
eXN0ZW1zLiBOb3Qgc3VyZSBpZiBJSU8gZGlmZmVycyBoZXJlLiANCg0KTm93IHRoYXQgeW91IG1l
bnRpb24sIEknbSBub3Qgc3VyZSBlaXRoZXIuDQpXZSB0eXBpY2FsbHkgc2VudCB0aGUgZHQtYmlu
ZGluZ3Mgb25lIGxhc3QsIHNvIEkgYXNzdW1lZCBpdCB3YXMgdGhlDQpkZWZhdWx0Lg0KDQo+IA0K
PiBUaGFua3MsIA0KPiBNYW5pDQo+ID4gQWxleA0KPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
TWFuaXZhbm5hbiBTYWRoYXNpdmFtDQo+ID4gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8u
b3JnPg0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2JpbmRpbmdzL2lpby9saWdodC9hZHV4MTAyMC50
eHQgICAgICAgICAgIHwgMjINCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
PiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vbGlnaHQvYWR1eDEwMjAu
dHh0DQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaWlvL2xpZ2h0L2FkdXgxMDIwLnR4dA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaWlvL2xpZ2h0L2FkdXgxMDIwLnR4dA0KPiA+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZTg5NmRkYTMwZTM2DQo+ID4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaWlvL2xpZ2h0L2FkdXgxMDIwLnR4dA0KPiA+ID4gQEAgLTAsMCArMSwyMiBAQA0KPiA+
ID4gK0FuYWxvZyBEZXZpY2VzIEFEVVgxMDIwIFBob3RvbWV0cmljIHNlbnNvcg0KPiA+ID4gKw0K
PiA+ID4gK0xpbmsgdG8gZGF0YXNoZWV0OiANCj4gPiA+IA0KPiA+IGh0dHBzOi8vd3d3LmFuYWxv
Zy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvQURVWDEw
MjAucGRmDQo+ID4gPiArDQo+ID4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiA+ICsNCj4g
PiA+ICsgLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgImFkaSxhZHV4MTAyMCINCj4gPiA+ICsgLSBy
ZWc6IHRoZSBJMkMgYWRkcmVzcyBvZiB0aGUgc2Vuc29yDQo+ID4gPiArDQo+ID4gPiArT3B0aW9u
YWwgcHJvcGVydGllczoNCj4gPiA+ICsNCj4gPiA+ICsgLSBpbnRlcnJ1cHRzOiBpbnRlcnJ1cHQg
bWFwcGluZyBmb3IgSVJRIGFzIGRvY3VtZW50ZWQgaW4NCj4gPiA+ICsgIA0KPiA+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pbnRlcnJ1cHRz
LnR4dA0KPiA+ID4gKw0KPiA+ID4gK0V4YW1wbGU6DQo+ID4gPiArDQo+ID4gPiArYWR1eDEwMjBA
NjQgew0KPiA+ID4gKwljb21wYXRpYmxlID0gImFkaSxhZHV4MTAyMCI7DQo+ID4gPiArCXJlZyA9
IDwweDY0PjsNCj4gPiA+ICsJaW50ZXJydXB0LXBhcmVudCA9IDwmbXNtZ3Bpbz47DQo+ID4gPiAr
CWludGVycnVwdHMgPSA8MjQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gPiArfTsNCg==
