Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134FDCE1CF
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 14:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfJGMeB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 08:34:01 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41064 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbfJGMeA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 08:34:00 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97CSORU010425;
        Mon, 7 Oct 2019 08:33:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ven19qm5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 08:33:31 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id x97CUjDr012630;
        Mon, 7 Oct 2019 08:33:31 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ven19qm56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 08:33:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uar5+QEyarrEwEqcL/FtVaeh+xw2omlZ1i32m9jpd5M1CUqxQvMatwznjIXV7utnM+SEcLPIoIgWhxte+le8ykxIhnsdnaf6xgxufJXPOuofKhuHNZe10NV9KXA/2oalmRzVfCUGHGcrj1HsJX5BgC04hHDr2w8D6ufcPUgz6JsNJMfsfLdY1oSyjZ3S2bGlk4kCOL4bg5lez4D2pGB+jdOpdU06OQU5lWY12XrUR+fjEgG8k7nb6tyUQXlbKQUIUlvpim4nEczEhvp6l/03tF2BnDmLZtSxEln9oRJ6vQFqExvKRJ5tiNw1FoXLmejiNf95U7ZUi+8EWdtVbtUijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLwFcIlBk57lhfG5oKiCZ1Sz7ofcp+5MtwovjWqZCDQ=;
 b=BPMLHMs5fnlFapnBi2QYWvMgFhbNyRVk8FC4p5tIkXN7vhBuIqCHMEmlQD5u5RDBaB2uCrtaJenVNr7hvx2MuOpISZbBJivPXOcxgd6/M3zD6Z+DLkQBIeH+PbB66DFQ6MrK9rVFyLFwHqINmAcvGIrqYAavadTqOp1RUmcs/PYGigulZki3+8PDpSfxMZexSZt5obOTC6zkaZbCY8LIrvb+DL4rQ02CBzT1ffv9sBS2zAwUBL2EW5TS3MOTFntK/6c251xQzoTMDKROu3/oIQMPnaocbu5PeYGKp/1gF8ruoOSlfOVUMmU2Zekk+802/HOCVWxUuJ/G/Pu0l4CpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLwFcIlBk57lhfG5oKiCZ1Sz7ofcp+5MtwovjWqZCDQ=;
 b=9PQx3QFlSryPuYLcU2zf4/FOyB9CYsOrgEKlrNcK1aTnrQZJQRiipoTmujD84QPxdGHmpNlbXzOdnNnbHJrzCo+q/uXbN+yMCKbIM+ilqTAHX0QtSaO1E4PAz5a0qxGQ02Gj8nn6GAV1SNyryIIsuKXKWo1m1ld9giSVp5EQrKM=
Received: from MN2PR03MB5117.namprd03.prod.outlook.com (52.132.171.137) by
 MN2PR03MB4605.namprd03.prod.outlook.com (20.179.82.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 12:33:28 +0000
Received: from MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::8c20:8f3b:b536:dca5]) by MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::8c20:8f3b:b536:dca5%7]) with mapi id 15.20.2327.025; Mon, 7 Oct 2019
 12:33:28 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH v3 1/2] iio: temperature: Add support for LTC2983
Thread-Topic: [PATCH v3 1/2] iio: temperature: Add support for LTC2983
Thread-Index: AQHVertqUpI7UfsRN06rgGD7cfaxBadNbqcAgAF6B4CAAC1igIAAC3CA
Date:   Mon, 7 Oct 2019 12:33:28 +0000
Message-ID: <427efb1f1cbd90e5853926cf95c97067d3397356.camel@analog.com>
References: <20191004135519.191657-1-nuno.sa@analog.com>
         <20191006113732.1ffd597c@archlinux>
         <fcddb48f722392578431ecccce4862288bbec6ba.camel@analog.com>
         <20191007125259.00002eba@huawei.com>
In-Reply-To: <20191007125259.00002eba@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19f26f8a-b713-4df5-3b55-08d74b228e9c
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR03MB4605:
x-microsoft-antispam-prvs: <MN2PR03MB4605336665A06696B7C989A1999B0@MN2PR03MB4605.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(40764003)(99286004)(81156014)(81166006)(76176011)(8676002)(11346002)(478600001)(66446008)(5640700003)(6306002)(6512007)(25786009)(6506007)(102836004)(66556008)(26005)(476003)(66476007)(8936002)(66066001)(486006)(66946007)(64756008)(91956017)(186003)(446003)(76116006)(14454004)(86362001)(2616005)(36756003)(5660300002)(2501003)(6916009)(256004)(14444005)(71200400001)(118296001)(229853002)(7736002)(6116002)(71190400001)(6486002)(54906003)(2906002)(6436002)(305945005)(316002)(2351001)(3846002)(6246003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4605;H:MN2PR03MB5117.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a4gu7NBw74MlWotqbpv7KwW04nndMkaOXOMhRRvbT1H57V34EmlXO6XLdmJoPOKZCwgqR2Yb5hmcWWf90ZTLUomIl/3ToSlh43gck3qQ+SNaqCkGeHXd6CTwOQVNevRQkZSVJ4o7ekGNq0l6IFnKSEiO4FfkBy6kRjq9b9BnH+QG1AXUSXLcLBiuguDpNLupGU3Dq7kzYOXg+buMFp+zL/YCdAb0vRYkUddvfWB12F2BQUcPtRxjERnfO2l7kVpI3Zz2qVrzcrU6YKM+Hd71EUDYMxN7abvPdl0+ftdg3o6qBKNMFmajHNhl0TICISL6vu1zBsjt0+1sK+ZN9OEX/wqnLrWXYlHIfkRCwXQiLTjIdfY5FTsPt+0TwRls7F/sQ62TliQHr82PONsQIzcT9kIMgbWIkhVBPZmkpIKrQP4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E4965C9D6E72940864693D98FE33ECB@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f26f8a-b713-4df5-3b55-08d74b228e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 12:33:28.9112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rH9D9vGoUgyMs38jEiZe9THe6BrcW2AItw4sTifZbdLcx8UBkke8t9IlJWbPeIqQeids2MoMwBo9psAiLsCAGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4605
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070125
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTEwLTA3IGF0IDEyOjUyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiANCj4gT24gTW9uLCA3IE9jdCAyMDE5IDA5OjEwOjA2ICswMDAwDQo+ICJTYSwgTnVubyIg
PE51bm8uU2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIFN1biwgMjAxOS0xMC0wNiBh
dCAxMTozNyArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gPiA+IFtFeHRlcm5hbF0N
Cj4gPiA+IA0KPiA+ID4gT24gRnJpLCA0IE9jdCAyMDE5IDE1OjU1OjE4ICswMjAwDQo+ID4gPiBO
dW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiA+ICAgDQo+ID4gPiA+IFRo
ZSBMVEMyOTgzIGlzIGEgTXVsdGktU2Vuc29yIEhpZ2ggQWNjdXJhY3kgRGlnaXRhbCBUZW1wZXJh
dHVyZQ0KPiA+ID4gPiBNZWFzdXJlbWVudCBTeXN0ZW0uIEl0IG1lYXN1cmVzIGEgd2lkZSB2YXJp
ZXR5IG9mIHRlbXBlcmF0dXJlDQo+ID4gPiA+IHNlbnNvcnMgYW5kDQo+ID4gPiA+IGRpZ2l0YWxs
eSBvdXRwdXRzIHRoZSByZXN1bHQsIGluIMKwQyBvciDCsEYsIHdpdGggMC4xwrBDIGFjY3VyYWN5
DQo+ID4gPiA+IGFuZA0KPiA+ID4gPiAwLjAwMcKwQyByZXNvbHV0aW9uLiBJdCBjYW4gbWVhc3Vy
ZSB0aGUgdGVtcGVyYXR1cmUgb2YgYWxsDQo+ID4gPiA+IHN0YW5kYXJkDQo+ID4gPiA+IHRoZXJt
b2NvdXBsZXMgKHR5cGUgQixFLEosSyxOLFMsUixUKSwgc3RhbmRhcmQgMi0sMy0sNC13aXJlDQo+
ID4gPiA+IFJURHMsDQo+ID4gPiA+IHRoZXJtaXN0b3JzIGFuZCBkaW9kZXMuDQo+ID4gPiA+IA0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPiAgDQo+
ID4gPiANCj4gPiA+IFR3byB0aGluZ3MgaW5saW5lIHRoYXQgSSdkIG1pc3NlZCBiZWZvcmUuIE90
aGVyd2lzZSBsb29rcyBnb29kLg0KPiA+ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiANCj4gPiA+
IEpvbmF0aGFuDQo+ID4gPiAgIA0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gQ2hhbmdlcyBpbiB2MjoN
Cj4gPiA+ID4gICogQWRkZWQgc29tZSBuZWVkZWQgYmxhbmsgbGluZXMgKGZvciByZWFkYWJpbGl0
eSk7DQo+ID4gPiA+ICAqIEFsbG9jYXRlIGlpb19jaGFuIGluIHRoZSBzZXR1cCgpIGZ1bmN0aW9u
Ow0KPiA+ID4gPiAgKiBSZW5hbWUgcmVzZXQgdG8gc2xlZXA7DQo+ID4gPiA+ICAqIFJlbW92ZSB1
bm5lZWRlZCBkZXZfZGJnIGNhbGxzOw0KPiA+ID4gPiAgKiBSZW1vdmUgdW5uZWVkZWQgbGluZSB3
cmFwcGluZzsNCj4gPiA+ID4gICogUmVtb3ZlIHVubmVlZGVkIGNvbW1lbnRzOw0KPiA+ID4gPiAg
KiBSZW1vdmUgZXh0ZW5kX25hbWVzLiBVc2UgdGhlIHN0YW5kYXJkIEFCSTsNCj4gPiA+ID4gICog
QWRhcHQgdGhlIHNjYWxlcyB0byByZXBvcnQgaW4gbWlsbGl2b2x0IGFuZCBtaWxsaSBkZWdyZWVz
Ow0KPiA+ID4gPiAgKiBBZGFwdCB0aGUgb2ZfcHJvcGVydHkgcmVhZGluZ3MgdG8gdGhlIHJlbmFt
aW5nIG9mIHRoZQ0KPiA+ID4gPiBwcm9wZXJ0aWVzOw0KPiA+ID4gPiAgKiBGb3IgY3VzdG9tIHRo
ZXJtaXN0b3JzLCBleGNpdGF0aW9uLWN1cnJlbnQgY2Fubm90IGJlIHNldCB0bw0KPiA+ID4gPiBB
dXRvDQo+ID4gPiA+IHJhbmdlLg0KPiA+ID4gPiANCj4gPiA+ID4gQ2hhbmdlcyBpbiB2MzoNCj4g
PiA+ID4gICogVXNlIG5vcm1hbCBgZGV2bV9yZXF1ZXN0X2lycWA7DQo+ID4gPiA+ICAqIEhhbmRs
ZSBhbmQgZGVjb2RlIHRoZSBuZXcgZGV2aWNldHJlZSBwcm9wZXJ0aWVzIGZvciBzZW5zb3INCj4g
PiA+ID4gY29uZmlndXJhdGlvbi4NCj4gPiA+ID4gDQo+ID4gPiA+ICBNQUlOVEFJTkVSUyAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICA3ICsNCj4gPiA+ID4gIGRyaXZlcnMvaWlvL3RlbXBlcmF0
dXJlL0tjb25maWcgICB8ICAgMTAgKw0KPiA+ID4gPiAgZHJpdmVycy9paW8vdGVtcGVyYXR1cmUv
TWFrZWZpbGUgIHwgICAgMSArDQo+ID4gPiA+ICBkcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9sdGMy
OTgzLmMgfCAxNTU0DQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
PiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE1NzIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL2x0YzI5ODMuYw0KPiA+ID4gPiAN
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gPiA+ID4g
aW5kZXggZjBjMDM3NDBiOWZiLi4xNGEyNTZlNzg1Y2EgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL01B
SU5UQUlORVJTDQo+ID4gPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gPiA+IEBAIC05NDkxLDYg
Kzk0OTEsMTMgQEAgUzoJTWFpbnRhaW5lZA0KPiA+ID4gPiAgRjoJRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby9kYWMvbHRjMTY2MC50eHQNCj4gPiA+ID4gIEY6CWRyaXZlcnMv
aWlvL2RhYy9sdGMxNjYwLmMNCj4gPiA+ID4gIA0KPiA+ID4gPiArTFRDMjk4MyBJSU8gVEVNUEVS
QVRVUkUgRFJJVkVSDQo+ID4gPiA+ICtNOglOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0K
PiA+ID4gPiArVzoJaHR0cDovL2V6LmFuYWxvZy5jb20vY29tbXVuaXR5L2xpbnV4LWRldmljZS1k
cml2ZXJzDQo+ID4gPiA+ICtMOglsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+ID4gPiA+ICtT
OglTdXBwb3J0ZWQNCj4gPiA+ID4gK0Y6CWRyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL2x0YzI5ODMu
Yw0KPiA+ID4gPiArDQo+ID4gPiA+ICBMVEM0MjYxIEhBUkRXQVJFIE1PTklUT1IgRFJJVkVSDQo+
ID4gPiA+ICBNOglHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+ID4gPiA+ICBM
OglsaW51eC1od21vbkB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWlvL3RlbXBlcmF0dXJlL0tjb25maWcNCj4gPiA+ID4gYi9kcml2ZXJzL2lpby90ZW1wZXJh
dHVyZS9LY29uZmlnDQo+ID4gPiA+IGluZGV4IDczN2ZhYTA5MDFmZS4uMDRiNWE2N2I1OTNjIDEw
MDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9LY29uZmlnDQo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL0tjb25maWcNCj4gPiA+ID4gQEAgLTQs
NiArNCwxNiBAQA0KPiA+ID4gPiAgIw0KPiA+ID4gPiAgbWVudSAiVGVtcGVyYXR1cmUgc2Vuc29y
cyINCj4gPiA+ID4gIA0KPiA+ID4gPiArY29uZmlnIExUQzI5ODMNCj4gPiA+ID4gKwl0cmlzdGF0
ZSAiQW5hbG9nIERldmljZXMgTXVsdGktU2Vuc29yIERpZ2l0YWwNCj4gPiA+ID4gVGVtcGVyYXR1
cmUNCj4gPiA+ID4gTWVhc3VyZW1lbnQgU3lzdGVtIg0KPiA+ID4gPiArCWRlcGVuZHMgb24gU1BJ
ICANCj4gPiA+IA0KPiA+ID4gU2VsZWN0IFJFR01BUF9TUEkgbmVlZGVkIEkgdGhpbmsuICANCj4g
PiANCj4gPiBhY2suDQo+ID4gDQo+ID4gPiA+ICsJaGVscA0KPiA+ID4gPiArCSAgU2F5IHllcyBo
ZXJlIHRvIGJ1aWxkIHN1cHBvcnQgZm9yIHRoZSBMVEMyOTgzIE11bHRpLQ0KPiA+ID4gPiBTZW5z
b3INCj4gPiA+ID4gKwkgIGhpZ2ggYWNjdXJhY3kgZGlnaXRhbCB0ZW1wZXJhdHVyZSBtZWFzdXJl
bWVudCBzeXN0ZW0uDQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkgIFRvIGNvbXBpbGUgdGhpcyBkcml2
ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6DQo+ID4gPiA+IHRoZSBtb2R1bGUNCj4gPiA+
ID4gKwkgIHdpbGwgYmUgY2FsbGVkIGx0YzI5ODMuDQo+ID4gPiA+ICsNCj4gPiA+ID4gIGNvbmZp
ZyBNQVhJTV9USEVSTU9DT1VQTEUNCj4gPiA+ID4gIAl0cmlzdGF0ZSAiTWF4aW0gdGhlcm1vY291
cGxlIHNlbnNvcnMiDQo+ID4gPiA+ICAJZGVwZW5kcyBvbiBTUEkNCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL01ha2VmaWxlDQo+ID4gPiA+IGIvZHJpdmVycy9p
aW8vdGVtcGVyYXR1cmUvTWFrZWZpbGUNCj4gPiA+ID4gaW5kZXggYmFjYTQ3NzZjYTBkLi5kNmI4
NTBiMGNmNjMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL01h
a2VmaWxlDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL01ha2VmaWxlDQo+
ID4gPiA+IEBAIC0zLDYgKzMsNyBAQA0KPiA+ID4gPiAgIyBNYWtlZmlsZSBmb3IgaW5kdXN0cmlh
bCBJL08gdGVtcGVyYXR1cmUgZHJpdmVycw0KPiA+ID4gPiAgIw0KPiA+ID4gPiAgDQo+ID4gPiA+
ICtvYmotJChDT05GSUdfTFRDMjk4MykgKz0gbHRjMjk4My5vDQo+ID4gPiA+ICBvYmotJChDT05G
SUdfSElEX1NFTlNPUl9URU1QKSArPSBoaWQtc2Vuc29yLXRlbXBlcmF0dXJlLm8NCj4gPiA+ID4g
IG9iai0kKENPTkZJR19NQVhJTV9USEVSTU9DT1VQTEUpICs9IG1heGltX3RoZXJtb2NvdXBsZS5v
DQo+ID4gPiA+ICBvYmotJChDT05GSUdfTUFYMzE4NTYpICs9IG1heDMxODU2Lm8NCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL2x0YzI5ODMuYw0KPiA+ID4gPiBi
L2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL2x0YzI5ODMuYw0KPiA+ID4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmY4OTljMWQ3NWY4YQ0KPiA+ID4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL2x0
YzI5ODMuYw0KPiA+ID4gPiBAQCAtMCwwICsxLDE1NTQgQEAgIA0KPiA+ID4gLi4uDQo+ID4gPiAg
IA0KPiA+ID4gPiArc3RhdGljIGludCBsdGMyOTgzX2NoYW5fcmVhZChzdHJ1Y3QgbHRjMjk4M19k
YXRhICpzdCwNCj4gPiA+ID4gKwkJCWNvbnN0IHN0cnVjdCBsdGMyOTgzX3NlbnNvciAqc2Vuc29y
LA0KPiA+ID4gPiBpbnQgKnZhbCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwl1MzIgc3RhcnRfY29u
dmVyc2lvbiA9IDA7DQo+ID4gPiA+ICsJaW50IHJldDsNCj4gPiA+ID4gKwl1bnNpZ25lZCBsb25n
IHRpbWU7DQo+ID4gPiA+ICsJX19iZTMyIHRlbXA7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkvKg0K
PiA+ID4gPiArCSAqIERvIG5vdCBhbGxvdyBjaGFubmVsIHJlYWRpbmdzIGlmIGRldmljZSBpcyBp
biBzbGVlcA0KPiA+ID4gPiBzdGF0ZS4NCj4gPiA+ID4gKwkgKiBBIHJlYWQvd3JpdGUgb24gdGhl
IHNwaSBidXMgd291bGQgYnJpbmcgdGhlIGRldmljZQ0KPiA+ID4gPiBwcmVtYXR1cmVseQ0KPiA+
ID4gPiArCSAqIG91dCBvZiBzbGVlcC4NCj4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gKwlpZiAoc3Qt
PnNsZWVwKQ0KPiA+ID4gPiArCQlyZXR1cm4gLUVQRVJNOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJ
c3RhcnRfY29udmVyc2lvbiA9IExUQzI5ODNfU1RBVFVTX1NUQVJUKHRydWUpOw0KPiA+ID4gPiAr
CXN0YXJ0X2NvbnZlcnNpb24gfD0gTFRDMjk4M19TVEFUVVNfQ0hBTl9TRUwoc2Vuc29yLQ0KPiA+
ID4gPiA+Y2hhbik7DQo+ID4gPiA+ICsJZGV2X2RiZygmc3QtPnNwaS0+ZGV2LCAiU3RhcnQgY29u
dmVyc2lvbiBvbiBjaGFuOiVkLA0KPiA+ID4gPiBzdGF0dXM6JTAyWFxuIiwNCj4gPiA+ID4gKwkJ
c2Vuc29yLT5jaGFuLCBzdGFydF9jb252ZXJzaW9uKTsNCj4gPiA+ID4gKwkvKiBzdGFydCBjb252
ZXJzaW9uICovDQo+ID4gPiA+ICsJcmV0ID0gcmVnbWFwX3dyaXRlKHN0LT5yZWdtYXAsIExUQzI5
ODNfU1RBVFVTX1JFRywNCj4gPiA+ID4gc3RhcnRfY29udmVyc2lvbik7DQo+ID4gPiA+ICsJaWYg
KHJldCkNCj4gPiA+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJlaW5p
dF9jb21wbGV0aW9uKCZzdC0+Y29tcGxldGlvbik7DQo+ID4gPiA+ICsJLyoNCj4gPiA+ID4gKwkg
KiB3YWl0IGZvciBjb252ZXJzaW9uIHRvIGNvbXBsZXRlLg0KPiA+ID4gPiArCSAqIDMwMCBtcyBz
aG91bGQgYmUgbW9yZSB0aGFuIGVub3VnaCB0byBjb21wbGV0ZSB0aGUNCj4gPiA+ID4gY29udmVy
c2lvbi4NCj4gPiA+ID4gKwkgKiBEZXBlbmRpbmcgb24gdGhlIHNlbnNvciBjb25maWd1cmF0aW9u
LCB0aGVyZSBhcmUgMi8zDQo+ID4gPiA+IGNvbnZlcnNpb25zDQo+ID4gPiA+ICsJICogY3ljbGVz
IG9mIDgybXMuDQo+ID4gPiA+ICsJICovDQo+ID4gPiA+ICsJdGltZSA9IHdhaXRfZm9yX2NvbXBs
ZXRpb25fdGltZW91dCgmc3QtPmNvbXBsZXRpb24sDQo+ID4gPiA+ICsJCQkJCSAgIG1zZWNzX3Rv
X2ppZmZpZXMoMzAwDQo+ID4gPiA+ICkpOw0KPiA+ID4gPiArCWlmICghdGltZSkgew0KPiA+ID4g
PiArCQlkZXZfd2Fybigmc3QtPnNwaS0+ZGV2LCAiQ29udmVyc2lvbiB0aW1lZA0KPiA+ID4gPiBv
dXRcbiIpOw0KPiA+ID4gPiArCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gPiA+ID4gKwl9DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKwkvKiByZWFkIHRoZSBjb252ZXJ0ZWQgZGF0YSAqLw0KPiA+ID4gPiAr
CXJldCA9IHJlZ21hcF9idWxrX3JlYWQoc3QtPnJlZ21hcCwNCj4gPiA+ID4gTFRDMjk4M19DSEFO
X1JFU19BRERSKHNlbnNvci0+Y2hhbiksDQo+ID4gPiA+ICsJCQkgICAgICAgJnRlbXAsIHNpemVv
Zih0ZW1wKSk7ICANCj4gPiA+IA0KPiA+ID4gSSdkIG1pc3NlZCB0aGlzIGJlZm9yZS4gIHJlZ21h
cF9idWxrX3JlYWQgY2FuIGRpcmVjdGx5IHVzZSB0aGUNCj4gPiA+IHN1cHBsaWVkIGJ1ZmZlcg0K
PiA+ID4gZm9yIGRtYS4gIEhlbmNlIGl0IG5lZWRzIHRvIGJlIGRtYSBzYWZlLiAgVGhhdCBtZWFu
cyB5b3UgaGF2ZSB0bw0KPiA+ID4gaGF2ZQ0KPiA+ID4gaXQNCj4gPiA+IGluIGl0J3Mgb3duIGNh
Y2hlbGluZS4gIFRoZXJlIGlzIG5vIHdheSBvZiBlbmZvcmNpbmcgdGhhdCBvbiB0aGUNCj4gPiA+
IHN0YWNrIHNvDQo+ID4gPiBlaXRoZXIgYWxsb2NhdGUgaXQgbG9jYWxseSBmcm9tIHRoZSBoZWFw
LCBvciBwdXQgaXQgYXQgdGhlIGVuZCBvZg0KPiA+ID4gdGhlDQo+ID4gPiBkYXRhIHN0cnVjdHVy
ZSBhbmQgbWFyayBpdCBfX2NhY2hlbGluZV9hbGlnbmVkICh3ZSBtYWtlIHN1cmUNCj4gPiA+IHRo
b3NlDQo+ID4gPiBzdHJ1Y3R1cmVzDQo+ID4gPiBhcmUgYWxzbyBjYWNoZWxpbmUgYWxpZ25lZCBh
bmQgb24gdGhlIGhlYXAgc3BlY2lmaWNhbGx5IHRvIGFsbG93DQo+ID4gPiB1cw0KPiA+ID4gdG8g
ZG8gdGhhdA0KPiA+ID4gdHJpY2spLiAgDQo+ID4gDQo+ID4gSnVzdCBmb3IgbXkgdW5kZXJzdGFu
ZGluZy4gSSBkbyBzZWUgdGhlIHRoZSBuZWVkIG9mIHVzaW5nDQo+ID4gX19jYWNoZWxpbmVfYWxp
Z25lZCBvbiB0aGUgc3RydWN0IHBhcmFtZXRlciB3ZSB3YW50IHRvIGFsaWduLiBJIHdhcw0KPiA+
IG5vdw0KPiA+IHRyeWluZyB0byB1bmRlcnN0YW5kIHlvdXIgY29tbWVudCBvbiBwYXJlbnRoZXNp
cy4gV2h5IGRvIHdlIG5lZWQNCj4gPiB0aGF0DQo+ID4gdHJpY2s/IFdvdWxkbid0IGJlIHN1ZmZp
Y2llbnQgdG8gaGF2ZSB0aGUgc3RydWN0IGVsZW1lbnQgbWFya2VkDQo+ID4gd2l0aA0KPiA+IF9f
Y2FjaGVsaW5lX2FsaWduZWQ/DQo+ID4gDQo+IA0KPiBBaC4gIFRoYXQgaXMgZG93biB0byB3aGF0
IF9fY2FjaGVsaW5lX2FsaWduZWQgYWN0dWFsbHkgZG9lcyBhbmQNCj4gaG93IHdlIGNyZWF0ZSB0
aGUgcmVnaW9uIGFjY2Vzc2VkIGJ5IGlpb19wcml2KCkNCj4gDQo+IElmIHdlIGhhdmUgYSBzdGFu
ZCBhbG9uZSBzdHJ1Y3R1cmUgYWxsb2NhdGVkIHdpdGgga21hbGxvYyB3aXRoIGFuDQo+IGVsZW1l
bnQgbWFya2VkIF9fY2FjaGVsaW5lX2FsaWduZWQgaXQgd2lsbCBpbmRlZWQgaGF2ZSB0aGUgY29y
cmVjdA0KPiBhbGlnbm1lbnQuDQo+IA0KPiBpaW9fcHJpdiBpcyBkb25lIGJ5IGluY3JlYXNpbmcg
dGhlIHNpemUgb2YgdGhlIG1lbW9yeSBhbGxvY2F0aW9uDQo+IGRvbmUgaW4gaWlvX2RldmljZV9h
bGxvYywgdGhlIGlpb19wcml2KCkgcG9pbnRlciB0aGVuIGdpdmVzIHVzDQo+IHRoZSBhZGRyZXNz
IG9mIGEgcmVnaW9uIGJleW9uZCB0aGUgZW5kIG9mIHRoZSBpaW9fZGV2IHN0cnVjdHVyZS4NCg0K
R290IGl0Lg0KDQo+IFRoYXQgcmVnaW9uIGhhcyB0byBhbHNvIGJlIGNhY2hlbGluZSBhbGlnbmVk
IHNvIHRoYXQgd2hlbiB3ZSBmaW5kDQo+IHRoZSBsb2NhdGlvbiBvZiB0aGUgX19jYWNoZWxpbmVf
YWxpZ25lZCBlbGVtZW50IG9mIHRoZSBzdHJ1Y3R1cmUNCj4gd2UgYXJlIHB1dHRpbmcgdGhlcmUg
KGJhc2ljYWxseSBhbiBvZmZzZXQgZnJvbSBpaW9fcHJpdikgaXQgd2lsbA0KPiBhbHNvIGhhdmUg
dGhlIHJpZ2h0IGFsaWdubWVudC4NCg0KVW5kZXJzdG9vZC4gVGhlbiwgdGhlIG9ubHkgdGhpbmcg
SSdtIHN0aWxsIHdvbmRlcmluZyBpcyB0aGF0IHdlIG5lZWQgdG8NCmhhdmUgdGhlIGd1YXJhbnRl
ZSB0aGF0IGttYWxsb2MgYWxzbyByZXR1cm5zIGEgcG9pbnRlciB3aGljaCBpcyBhdA0KbGVhc3Qg
X19jYWNoZWxpbmVfYWxpZ25lZCBmb3Igb3VyIGlpb19kZXYgc3RydWN0IHNvIHRoYXQsIG91ciBw
cml2YXRlDQpzdHJ1Y3QgaGFzIHRoZSBjb3JyZWN0IGFsaWdubWVudCAoYW5kIHRodXMgdGhlIGVs
ZW1lbnQpLiBJcyB0aGlzDQpjb3JyZWN0Pw0KDQo+IFRoZSBjb21waWxlciBoYXMgbm8gd2F5IG9m
IGtub3dpbmcgd2UgYXJlIGRvaW5nIHRoaXMgc3R1ZmYgc28gaXQNCj4ganVzdCBhZGRzIHBhZGRp
bmcgdG8gdGhlIHByaXZhdGUgc3RydWN0dXJlIG9uIHRoZSBhc3N1bXB0aW9uDQo+IHRoZSBzdHJ1
Y3R1cmUgaXRzZWxmIGlzIGFsaWduZWQuDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gDQpUaGFua3Mg
Zm9yIHlvdXIgaGVscCBhbmQgZXhwbGFuYXRpb24hDQpOdW5vIFPDoQ0K
