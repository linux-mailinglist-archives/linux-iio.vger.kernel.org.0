Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E291421CE94
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 07:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgGMFIC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 01:08:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9042 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgGMFIC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2020 01:08:02 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06D57lgW027425;
        Mon, 13 Jul 2020 01:07:47 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 327ab4kskp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 01:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at4k78oWH5I+1fwquGBFrQLtmamXk9H0mpSmJLNGovG7Fi3kNAwJvtZavc2TpNhiPC9R/M9VGi1tj1j0gbdu65qJYgWVn5IyeXHEU8fsXw/3aKI0CS7eDZ87gEotmzmMMqDjnB+TQpTnADYTe0IddzpV2amxsGTl4ObUfXsIuLr/b4V5OinGCylm4JyCPC5IlbGtA7xqViTjKMvL8i4IC9VhNO4a9jbLUnHWoY8l36iVsJZyFI1hazrnn5Ep636BnNqLfJOBQgHktnVE4GiRS/cFSq1atV6xDyuAHtcI9e3axU4t28xuPJQBcg5uEemtfUfhU8/2JB/NyYB1aMuNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyLNJg9mAwZJC6w7guyLBYmYEA4XzhEyWKalD4RgREc=;
 b=YxfdmXAwFsyPkpysspUFUS9DL9HSF2F2JqlxqBTkgBkklirKN6ohjyvJT2c6RhPaEsamdr7CMRNhquSGXDJke6K8ihGV83ooLR+cgosaXv+P2i6GpifsfMraKf39gpJ8yBXPCTr4rLFIGwYzTzq7QKG5NzH2aFcR5cDIKA/eZJja6DyR1mq0ptz+wr1/ND6HOF7IGq0eq9nQM6vdDM6odGIbtVtmp9TYqxNrNqJpZhDJ2/rZgSl+haMxoXdKWnWzFWvyibEm/Vuj5La7V1Xm845qDZJvUS3emk7yZy/rxD5yitpTU9u9Ygh0uICzixn6hzLPsYyD706vPkPm9Qpstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyLNJg9mAwZJC6w7guyLBYmYEA4XzhEyWKalD4RgREc=;
 b=R7Lw2FbTWxEN3Df4zAR1dLixw6RhK3xH1wKFgwnDfuedQy/FaDz+I5JzHELzgqvi9krttNng74qEF22PFbhXESgjqoVNnN4LW7sM3mpaBdfm6QEld6q4MhfsnD68E0IH5OOM0Iv5QaqVM8Iobs4cDRm6YFOMNUD3W/q4fAD59Js=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3931.namprd03.prod.outlook.com (2603:10b6:5:4b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 05:07:45 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c1c3:9cbb:449c:ac0a]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c1c3:9cbb:449c:ac0a%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 05:07:45 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "contact@artur-rojek.eu" <contact@artur-rojek.eu>
CC:     "ezequiel@vanguardiasur.com.ar" <ezequiel@vanguardiasur.com.ar>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "paul@crapouillou.net" <paul@crapouillou.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v8 2/6] IIO: Ingenic JZ47xx: Error check clk_enable calls.
Thread-Topic: [PATCH v8 2/6] IIO: Ingenic JZ47xx: Error check clk_enable
 calls.
Thread-Index: AQHWVgTo84dbJEvIi0y+LdDlMC9+5qkD3I8AgAEee4A=
Date:   Mon, 13 Jul 2020 05:07:44 +0000
Message-ID: <526dc4337ce1b5fcac94923c2b5533852a7b2739.camel@analog.com>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
         <20200709152200.10039-3-contact@artur-rojek.eu>
         <20200712130222.76bf32ed@archlinux>
In-Reply-To: <20200712130222.76bf32ed@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d22a6b1b-383e-47dc-3251-08d826eaada3
x-ms-traffictypediagnostic: DM6PR03MB3931:
x-microsoft-antispam-prvs: <DM6PR03MB3931839145D79DE894D9241AF9600@DM6PR03MB3931.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uML8PN1y5+5kVmckiQ5HFgyQsCpLcD/uRfc7tCTBBKOs3LqCvM1dzqVxaF/fAAdZdem1d8pYxgFP+mSOPPWmBCQqy/YrmSU34DFb/HxSKicESwZbPSADIbLGRa3bXq0ZAKEGhXnc83f4Uq2BgRA3gBJ9IuPUds1UwryGNmpeEgrS2ixuzg2ZBSgCGvvebcEwDrCJGMLm9Lme5cSAIJAeUwvWIrbnlZZaIa2ivGrkKiamPsKCSwmqxJCSJaz1aT3klaD8T54D8a6j0ESS/Qg0I4Q9cNY8Y8sNe3BxhNDdQPMgntJ+zuIX6uU7CvW2TwVs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(396003)(376002)(39860400002)(136003)(36756003)(5660300002)(6486002)(8936002)(2906002)(6506007)(2616005)(316002)(71200400001)(86362001)(110136005)(8676002)(186003)(26005)(6512007)(478600001)(66446008)(64756008)(66556008)(66476007)(66946007)(54906003)(76116006)(91956017)(4326008)(83380400001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yU8dm6/OLqSQhKBRue2NAjkRR2ucjX6utQWHS63h7ssb0bZyOQD2mIvSy2pYNb2epZKnPWvLN8Zzmzm0/1HoMn2Z1aP+qgxPFy2XCykmb92Pw8tr1Qei1OdESVtuI4ddj6fDX+XFGAMHby0iWuaSLctHUoB6t2vnOlDbuz8rr0ovzKl1lqU5a4lgznjp10z+8OWK2Q7YF8S/+0FbVOjvst7Mnidl7JfkYQXWrAnM4/nqAcI0XczCEY3cuPq71Iis3DixZluPyLEHyDo68RH0aRY6cyGxYYtuvLLUJGQnC6HWc8xDHf3HtroLXgtbXweRRwsWJT2dCSRJ9QRZHAjg+TFiOSTGA2PCXJw8t9NR6m+bXz5LCs7SesSdD9jfYtfIE9oklhJD1ebg6hka4SvE9w45JdfYTjCOjWY6ucbjNqYdYKjALhMfsGkKasCFsM31DpcJikBX8JcxsHTlT6pP3nbXZjPbGUTGlkQAoD9X5qg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7AB8802FB92EF469C7220C509209C13@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22a6b1b-383e-47dc-3251-08d826eaada3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 05:07:44.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0lQAqj7fAlrIp/lup9RT/8Rpj7EPTxPsZq64kRWbdhi9O4CY0UyITfpGwaGyZVU/SHjx179OF0aNHvX9CzW9icvOSQr3vUF9UgP4To+y/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3931
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_03:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130037
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA3LTEyIGF0IDEzOjAyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUaHUsICA5IEp1bCAyMDIwIDE3OjIxOjU2ICswMjAwDQo+IEFydHVyIFJvamVrIDxj
b250YWN0QGFydHVyLXJvamVrLmV1PiB3cm90ZToNCj4gDQo+ID4gSW50cm9kdWNlIGVycm9yIGNo
ZWNrcyBmb3IgdGhlIGNsa19lbmFibGUgY2FsbHMgdXNlZCBpbiB0aGlzIGRyaXZlci4NCj4gPiBB
cyBwYXJ0IG9mIHRoZSBjaGFuZ2VzLCBtb3ZlIGNsa19lbmFibGUvY2xrX2Rpc2FibGUgY2FsbHMg
b3V0IG9mDQo+ID4gaW5nZW5pY19hZGNfc2V0X2NvbmZpZyBhbmQgaW50byByZXNwZWN0aXZlIGxv
Z2ljIG9mIGl0cyBjYWxsZXJzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFydHVyIFJvamVr
IDxjb250YWN0QGFydHVyLXJvamVrLmV1Pg0KPiA+IFRlc3RlZC1ieTogUGF1bCBDZXJjdWVpbCA8
cGF1bEBjcmFwb3VpbGxvdS5uZXQ+DQo+IEFwcGxpZWQuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBK
b25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiANCj4gPiAgQ2hhbmdlczoNCj4gPiANCj4gPiAgdjY6
IG5ldyBwYXRjaA0KPiA+IA0KPiA+ICB2Nzogbm8gY2hhbmdlDQo+ID4gDQo+ID4gIHY4OiBtb3Zl
IGBjbGtfZGlzYWJsZWAgb3V0c2lkZSB0aGUgbG9jaw0KPiA+IA0KPiA+ICBkcml2ZXJzL2lpby9h
ZGMvaW5nZW5pYy1hZGMuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9pbmdlbmljLWFkYy5jIGIvZHJpdmVycy9paW8v
YWRjL2luZ2VuaWMtDQo+ID4gYWRjLmMNCj4gPiBpbmRleCAzOWMwYTYwOWZjOTQuLmMxOTQ2YTlm
MWNjYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvaW5nZW5pYy1hZGMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9pbmdlbmljLWFkYy5jDQo+ID4gQEAgLTczLDcgKzczLDYg
QEAgc3RhdGljIHZvaWQgaW5nZW5pY19hZGNfc2V0X2NvbmZpZyhzdHJ1Y3QgaW5nZW5pY19hZGMN
Cj4gPiAqYWRjLA0KPiA+ICB7DQo+ID4gIAl1aW50MzJfdCBjZmc7DQo+ID4gIA0KPiA+IC0JY2xr
X2VuYWJsZShhZGMtPmNsayk7DQo+ID4gIAltdXRleF9sb2NrKCZhZGMtPmxvY2spOw0KPiA+ICAN
Cj4gPiAgCWNmZyA9IHJlYWRsKGFkYy0+YmFzZSArIEpaX0FEQ19SRUdfQ0ZHKSAmIH5tYXNrOw0K
PiA+IEBAIC04MSw3ICs4MCw2IEBAIHN0YXRpYyB2b2lkIGluZ2VuaWNfYWRjX3NldF9jb25maWco
c3RydWN0IGluZ2VuaWNfYWRjDQo+ID4gKmFkYywNCj4gPiAgCXdyaXRlbChjZmcsIGFkYy0+YmFz
ZSArIEpaX0FEQ19SRUdfQ0ZHKTsNCj4gPiAgDQo+ID4gIAltdXRleF91bmxvY2soJmFkYy0+bG9j
ayk7DQo+ID4gLQljbGtfZGlzYWJsZShhZGMtPmNsayk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0
YXRpYyB2b2lkIGluZ2VuaWNfYWRjX2VuYWJsZShzdHJ1Y3QgaW5nZW5pY19hZGMgKmFkYywNCj4g
PiBAQCAtMTI0LDYgKzEyMiw4IEBAIHN0YXRpYyBpbnQgaW5nZW5pY19hZGNfd3JpdGVfcmF3KHN0
cnVjdCBpaW9fZGV2DQo+ID4gKmlpb19kZXYsDQo+ID4gIAkJCQkgbG9uZyBtKQ0KPiA+ICB7DQo+
ID4gIAlzdHJ1Y3QgaW5nZW5pY19hZGMgKmFkYyA9IGlpb19wcml2KGlpb19kZXYpOw0KPiA+ICsJ
c3RydWN0IGRldmljZSAqZGV2ID0gaWlvX2Rldi0+ZGV2LnBhcmVudDsNCj4gPiArCWludCByZXQ7
DQo+ID4gIA0KPiA+ICAJc3dpdGNoIChtKSB7DQo+ID4gIAljYXNlIElJT19DSEFOX0lORk9fU0NB
TEU6DQo+ID4gQEAgLTEzMSw2ICsxMzEsMTQgQEAgc3RhdGljIGludCBpbmdlbmljX2FkY193cml0
ZV9yYXcoc3RydWN0IGlpb19kZXYNCj4gPiAqaWlvX2RldiwNCj4gPiAgCQljYXNlIElOR0VOSUNf
QURDX0JBVFRFUlk6DQo+ID4gIAkJCWlmICghYWRjLT5zb2NfZGF0YS0+YmF0dGVyeV92cmVmX21v
ZGUpDQo+ID4gIAkJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwkJCXJldCA9IGNsa19l
bmFibGUoYWRjLT5jbGspOw0KPiA+ICsJCQlpZiAocmV0KSB7DQo+ID4gKwkJCQlkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBlbmFibGUgY2xvY2s6DQo+ID4gJWRcbiIsDQo+ID4gKwkJCQkJcmV0KTsN
Cj4gPiArCQkJCXJldHVybiByZXQ7DQo+ID4gKwkJCX0NCj4gPiArDQo+ID4gIAkJCWlmICh2YWwg
PiBKWl9BRENfQkFUVEVSWV9MT1dfVlJFRikgew0KPiA+ICAJCQkJaW5nZW5pY19hZGNfc2V0X2Nv
bmZpZyhhZGMsDQo+ID4gIAkJCQkJCSAgICAgICBKWl9BRENfUkVHX0NGR19CQVRfTQ0KPiA+IEQs
DQo+ID4gQEAgLTE0Miw2ICsxNTAsOSBAQCBzdGF0aWMgaW50IGluZ2VuaWNfYWRjX3dyaXRlX3Jh
dyhzdHJ1Y3QgaWlvX2Rldg0KPiA+ICppaW9fZGV2LA0KPiA+ICAJCQkJCQkgICAgICAgSlpfQURD
X1JFR19DRkdfQkFUX00NCj4gPiBEKTsNCj4gPiAgCQkJCWFkYy0+bG93X3ZyZWZfbW9kZSA9IHRy
dWU7DQo+ID4gIAkJCX0NCj4gPiArDQo+ID4gKwkJCWNsa19kaXNhYmxlKGFkYy0+Y2xrKTsNCj4g
PiArDQo+ID4gIAkJCXJldHVybiAwOw0KPiA+ICAJCWRlZmF1bHQ6DQo+ID4gIAkJCXJldHVybiAt
RUlOVkFMOw0KPiA+IEBAIC0zMTcsNiArMzI4LDEzIEBAIHN0YXRpYyBpbnQgaW5nZW5pY19hZGNf
cmVhZF9jaGFuX2luZm9fcmF3KHN0cnVjdA0KPiA+IGluZ2VuaWNfYWRjICphZGMsDQo+ID4gIAkJ
CQkJICBpbnQgKnZhbCkNCj4gPiAgew0KPiA+ICAJaW50IGJpdCwgcmV0LCBlbmdpbmUgPSAoY2hh
bi0+Y2hhbm5lbCA9PSBJTkdFTklDX0FEQ19CQVRURVJZKTsNCj4gPiArCXN0cnVjdCBkZXZpY2Ug
KmRldiA9IGlpb19wcml2X3RvX2RldihhZGMpLT5kZXYucGFyZW50Ow0KDQpUaGlzIHVzZXMgaWlv
X3ByaXZfdG9fZGV2KCksIHdoaWNoIHNob3VsZCBiZSByZW1vdmVkIFtpZiBpdCBoYXNuJ3QgYmVl
bg0KYWxyZWFkeV0uDQpBbHNvLCB3aXRoIHRoZSBpaW9fZGV2X29wYXF1ZSBzdHJ1Y3QvdHlwZSwg
dXNpbmcgdGhlIGlpb19wcml2X3RvX2RldigpDQpoZWxwZXIgc2hvdWxkbid0IHdvcmssIG9yIHNo
b3VsZCBnaXZlIHVuZGVmaW5lZCBiZWhhdmlvciwgYXMgdGhlIG9mZnNldCB0bw0KdGhlIHByaXZh
dGUgZGF0YSBzaG91bGQgYmUgbWF0Y2hlZCBhZ2FpbnN0IGlpb19kZXZfb3BhcXVlIChhbmQgbm90
DQppaW9fZGV2KS4NCg0KTG9va2luZyBhdCB0aGlzIGNvZGUsIGl0IGxvb2tzIGxpa2UgaW5nZW5p
Y19hZGNfcmVhZF9jaGFuX2luZm9fcmF3KCkgY2FuDQp0YWtlIGFuICdpbmRpb19kZXYnIHJlZmVy
ZW5jZSBhbmQgb2J0YWluIHRoZSBwcml2YXRlIGluZm9ybWF0aW9uIHZpYQ0KaWlvX3ByaXYoKQ0K
DQpNYXliZSBbZm9yIHNvbWVdIHRoZXJlJ3MgYSBxdWVzdGlvbiBhcyB0byB3aHkgaWlvX3ByaXZf
dG9fZGV2KCkgaXMgYmVpbmcNCnJlbW92ZWQuDQpUaGUgYW5zd2VyIGlzOiBiZWNhdXNlIHRoZSBp
aW9fZGV2X29wYXF1ZSBzdHJ1Y3QvdHlwZSB3YXMgaW50cm9kdWNlZCB0bw0KaGlkZSBzb21lIGlp
b19kZXYgW0lOVEVSTl0gZmllbGRzOyB0aGUgbWFpbiByZWFzb24gZm9yIGhpZGluZyB0aGVtIFth
c2lkZQ0KZnJvbSBnb29kIGNvZGluZyBwcmFjdGljZSwgYW5kIGJlY2F1c2UgdGhleSBiZWxvbmcg
dG8gdGhlIElJTyBmcmFtZXdvcmtdIGlzDQp0byBub3QgaGF2ZSB0byByZXZpZXcgbmV3IGRyaXZl
cnMgYmVpbmcgY29waWVkL2FkYXB0ZWQgZnJvbSBvbGQgZHJpdmVycy4NCg0KTmF0dXJhbGx5LCB0
aGUgaWlvX3ByaXZfdG9fZGV2KCkgY291bGQgaGF2ZSBiZWVuIGtlcHQgYXJvdW5kIFtpbiBhIHJl
d29ya2VkDQpmb3JtXSwgYnV0IGl0IGRpZG4ndCBtYWtlIG11Y2ggc2Vuc2UsIHNpbmNlIG1vc3Qg
dXNlcnMgb2YgaWlvX3ByaXZfdG9fZGV2KCkNCmNvdWxkIGFjY2VzcyBhIHJlZmVyZW5jZSB0byBp
bmRpb19kZXYgd2l0aG91dCBtdWNoL2FueSBoYXNzbGUuDQoNCj4gPiArDQo+ID4gKwlyZXQgPSBj
bGtfZW5hYmxlKGFkYy0+Y2xrKTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBlbmFibGUgY2xvY2s6ICVkXG4iLCByZXQpOw0KPiA+ICsJCXJldHVybiBy
ZXQ7DQo+ID4gKwl9DQo+ID4gIA0KPiA+ICAJLyogV2UgY2Fubm90IHNhbXBsZSBBVVgvQVVYMiBp
biBwYXJhbGxlbC4gKi8NCj4gPiAgCW11dGV4X2xvY2soJmFkYy0+YXV4X2xvY2spOw0KPiA+IEBA
IC0zMjUsNyArMzQzLDYgQEAgc3RhdGljIGludCBpbmdlbmljX2FkY19yZWFkX2NoYW5faW5mb19y
YXcoc3RydWN0DQo+ID4gaW5nZW5pY19hZGMgKmFkYywNCj4gPiAgCQlpbmdlbmljX2FkY19zZXRf
Y29uZmlnKGFkYywgSlpfQURDX1JFR19DRkdfQVVYX01ELCBiaXQpOw0KPiA+ICAJfQ0KPiA+ICAN
Cj4gPiAtCWNsa19lbmFibGUoYWRjLT5jbGspOw0KPiA+ICAJcmV0ID0gaW5nZW5pY19hZGNfY2Fw
dHVyZShhZGMsIGVuZ2luZSk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCWdvdG8gb3V0Ow0KPiA+
IEBAIC0zNDIsOCArMzU5LDggQEAgc3RhdGljIGludCBpbmdlbmljX2FkY19yZWFkX2NoYW5faW5m
b19yYXcoc3RydWN0DQo+ID4gaW5nZW5pY19hZGMgKmFkYywNCj4gPiAgDQo+ID4gIAlyZXQgPSBJ
SU9fVkFMX0lOVDsNCj4gPiAgb3V0Og0KPiA+IC0JY2xrX2Rpc2FibGUoYWRjLT5jbGspOw0KPiA+
ICAJbXV0ZXhfdW5sb2NrKCZhZGMtPmF1eF9sb2NrKTsNCj4gPiArCWNsa19kaXNhYmxlKGFkYy0+
Y2xrKTsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo=
