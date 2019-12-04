Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 356481129E1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 12:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfLDLMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 06:12:43 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49168 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727268AbfLDLMn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 06:12:43 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4B8XqT029388;
        Wed, 4 Dec 2019 06:12:20 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkp76jy4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 06:12:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG6T1R6v2whqfUUPwWtUEBAFGdWF1haecr5XT2473fGmBWvnWbQ0X4+jkjIRNS3/g5s0zOpfaKBFa1tBu/yS29bQRgoF/svwzqMMMa8tZc6VOUz2vVx3v8BT/QzR+ujb2tMqfdA5DZd9Am0FGpBze5kl5p9kt/w1dZGfyafsmVDpmkOiSwb+08NRcKoiv6qA1Bx1AFukXvIG/xoC9TgxMCzHZtxdqcVQFLly3uWQEfoYXMiJmYCo6f+YpBE2sYAA95Vb7guVjB92fTXLxmd4D+jLxIn1JfITfOeTt57DdXhOj+JFFoskepzMfGwdrSA3SbjpWUbrvtgj0uNvXHnkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK+HfhWhB1N1XJ6+y7y9VorYWKhF94bv244+S0a8TxA=;
 b=DVNBeK9hrxLe7H9WIMrLbKtxNWkWYg3sSn4rh1F5OKjxHmAbMb4B3y0/mNOCUw8p/hh+kd+2fL9nu1jpJKyy4u6NFY8TPoDonmPl1wbCpyD6CAoW2Ae1BAx08cK0bSL8CEpvyBuVyqMl4/rxUIEkoGQyYYBVDLHdLAj81gYHlM40Ek9+y96akQvXFdb+s+gX6I7rzIPTLK6SsyV9S+IEPKXFADd8oF2ekuJZPDY/4MEcZtA+uFIuFNm5xu+qTrFYFVdV8wX0f38cXU5DpOfWWbdRa4aEXPjKJPp4lFuIiQagcfznIn0Fq3WAxrFyqn+kaTfIObMSgeffGY8stv9EQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK+HfhWhB1N1XJ6+y7y9VorYWKhF94bv244+S0a8TxA=;
 b=XAYoqknJzCtcu4PyVOSyXD3FlrVAvYqXSgPWLVN6NBkVFYDBofQ4MidWr6XGgTvlY8ncipI6Y4gFCfW2EYg4Waa0m6EjJ/ZIn9LLZDu4KmXX/z67/+PAca6uU8J5x7MGmeIsovgMcPWy0eRmRit8CeTXMg94GJrJG651MJdQNQg=
Received: from MN2PR03MB5200.namprd03.prod.outlook.com (10.186.146.8) by
 MN2PR03MB5262.namprd03.prod.outlook.com (10.186.146.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 11:12:18 +0000
Received: from MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::e4ed:1890:e3f0:2c2d]) by MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::e4ed:1890:e3f0:2c2d%7]) with mapi id 15.20.2516.013; Wed, 4 Dec 2019
 11:12:18 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars.moellendorf@plating.de" <lars.moellendorf@plating.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 1/3] iio: buffer: align the size of scan bytes to size of
 the largest element
Thread-Topic: [PATCH 1/3] iio: buffer: align the size of scan bytes to size of
 the largest element
Thread-Index: AQHVqRDBywD5xcdbbUiiYjAfYzvg0qem2WEAgALdwACAAB55AA==
Date:   Wed, 4 Dec 2019 11:12:18 +0000
Message-ID: <00c2ff8c95bafc9e1f098d627b7e19457e14dacf.camel@analog.com>
References: <810ab64f-31bf-c4af-a655-7bddf364dae4@metafoo.de>
         <20191202130113.24005-1-lars.moellendorf@plating.de>
         <531d08db4d758cb8ab9f7e1955c7b918ff2b0c69.camel@analog.com>
         <a6b4d1aa-cb7b-690e-f0b0-2171f993f679@plating.de>
In-Reply-To: <a6b4d1aa-cb7b-690e-f0b0-2171f993f679@plating.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 590737d0-ee24-4589-23d8-08d778aad3c2
x-ms-traffictypediagnostic: MN2PR03MB5262:
x-microsoft-antispam-prvs: <MN2PR03MB5262E091AA6594EC3D256B75F95D0@MN2PR03MB5262.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(376002)(136003)(52024003)(189003)(199004)(316002)(2201001)(66556008)(8936002)(76116006)(11346002)(2501003)(86362001)(6246003)(3846002)(110136005)(81166006)(8676002)(305945005)(36756003)(66574012)(14444005)(53546011)(7736002)(6506007)(102836004)(6486002)(81156014)(118296001)(64756008)(66476007)(91956017)(14454004)(66946007)(26005)(6116002)(66446008)(76176011)(25786009)(5660300002)(71190400001)(2616005)(229853002)(71200400001)(2906002)(99286004)(6512007)(186003)(478600001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5262;H:MN2PR03MB5200.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5xnseLSqmOwMFlMcLtGL/qrXkFBU+bV0pQBoCEXYj2w4Fer5d7fYsSk1fKN65PV8r6NakMU4gl3B6/N7PzY99OtZvFjpbj8QPciKGA6KUDXIg0HnO6sd9NIB5WQVAfOY/+uAJ8C3MoYAn6gbtaL8D4x/dd0xw/lLYuMgpiRXFk2m7QJxEMO0HRz/PV5YdfLRFKTKdbmnpF3j6+tw2D1VQaC5K5lgyhHE+WC/N4c/w4r09jnWCDoNoYpgCiBoL7bzy2e44O45VeEhpJKm/M3aK+z4sxPgH75zQpvNjb+8amSTnuIqVhy3TmLdgQwiowaRu/hmQZwTqsMYIe98mL4Yq6STXcMG6WBo1jlcPL3LDFdeAGDHXqG1LehMNpakh4OgCbRPfoo6doI7RCDlO7p38ryfd48nCwWxNYdCLjbVjb3ba1qKvuUw3AJxgbwtu7VPekcJrWpaM4W6ci5mMJMAFgu1BM7DcHl+lkJiTl2IfHSBZ4DhPYcAZn4y9daos2X3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B9E4DC2B50E2141A317C02401E7F31D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590737d0-ee24-4589-23d8-08d778aad3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 11:12:18.7578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JN93pW5BNBJmDV9VoI37Ei+lKkqqKZ7gtMw+ZF8WGfGu4yxsHPB97/nF9uJLeFeWON0H8oGAKPkndxYeJkKID5233ECH+c4m7yZtnnzUXPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5262
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912040089
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTA0IGF0IDEwOjI0ICswMTAwLCBMYXJzIE3DtmxsZW5kb3JmIHdyb3Rl
Og0KPiBPbiAwMi4xMi4xOSAxNDozNywgQXJkZWxlYW4sIEFsZXhhbmRydSB3cm90ZToNCj4gPiBP
biBNb24sIDIwMTktMTItMDIgYXQgMTQ6MDEgKzAxMDAsIExhcnMgTcO2bGxlbmRvcmYgd3JvdGU6
DQo+ID4gDQo+ID4gSGV5IExhcnMsDQo+ID4gDQo+ID4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2gu
DQo+ID4gDQo+ID4gQ291bGQgeW91IGFkZCBhIGRlc2NyaXB0aW9uIG9mIHRoZSBwcm9ibGVtIGlu
IHRoZSBjb21taXQgZGVzY3JpcHRpb24/DQo+ID4gWW91IGRpZCBhIHJlYWxseSBncmVhdCBqb2Ig
b24gZGVzY3JpYmluZyBpdCB2aWEgZW1haWwgZWFybGllciwgYW5kIGl0DQo+ID4gd291bGQNCj4g
PiBiZSBncmVhdCB0byBoYXZlIGl0IGluIHRoZSBnaXQgaGlzdG9yeSBhcyB3ZWxsLg0KPiANCj4g
SXMgdGhlIGRlc2NyaXB0aW9uIGluIG15IGxhdGVzdCBwYXRjaCBvaz8NCg0KTG9va3MgZ29vZCB0
byBtZS4NCg0KSSB3b24ndCBhZGQgYW55IGZvcm1hbCB0YWdzIChSZXZpZXdlZC1ieSksIHNpbmNl
IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUNCmZ1bGwtc2NvcGUgb2YgdGhlIGlzc3VlLg0KSSB3YXMg
anVzdCByZXBseWluZyB0byB0aGUgbGFjayBvZiBkZXNjcmlwdGlvbiB0aGUgY29tbWl0Lg0KDQo+
IA0KPiANCj4gPiBBbHNvLCB0aGlzIHBhdGNoIGlzIG1hcmtlZCAxLzMgOyBjdXJpb3M6IGFyZSB0
aGVyZSAyIG1vcmUgcGF0Y2hlcyBpbiBhDQo+ID4gc2V0Pw0KPiA+IFNvbWV0aW1lcywgc29tZSBw
YXRjaGVzIGdldCBsb3N0IHZpYSBlbWFpbCBjbGllbnRzL3NlcnZlcnMuDQo+IA0KPiBObywgdGhl
cmUgaXMgb25seSBvbmUgcGF0Y2guIEkganVzdCBkaWQgbm90IHVzZSBgZ2l0IGZvcm1hdC1wYXRj
aGANCj4gY29ycmVjdGx5IGluIG15IGZpcnN0IGF0dGVtcHQuDQo+IA0KPiA+IE1heWJlIEpvbmF0
aGFuIFtvciBzb21lb25lIGVsc2VdIGhhcyBzb21lIG1vcmUgcG9pbnRzIHRvIHRoaXMuDQo+IA0K
PiBBbnl0aGluZyBlbHNlIEkgY2FuIGRvIHRvIGltcHJvdmUgdGhlIHBhdGNoPyBJdCBpcyB0aGUg
Zmlyc3QgdGltZSBJIGFtDQo+IHRyeWluZyB0byBzdWJtaXQgYSBwYXRjaCB0byB0aGUga2VybmVs
LiBXb3VsZCBiZSBuaWNlIHRvIGtub3cgaWYgaXQgaXMNCj4gYWNjZXB0ZWQgYW5kIGlmIG5vdCwg
d2h5LiBTbyBJIGNhbiBsZWFybiBmcm9tIG15IG1pc3Rha2VzLg0KPiANCg0KU28sIEpvbmF0aGFu
IG1heSBjb21lIGJhY2sgdG8gdGhpcyBhbmQgcmVwbHkuDQpJIGhhdmUgbm90aGluZyBtb3JlIHRv
IGFkZC4NCg0KVHlwaWNhbGx5IGhlIGRvZXMgdGhhdCBkdXJpbmcgd2Vla2VuZHM7IGJ1dCBzb21l
dGltZXMgaGUgcmVwbGllcyBkdXJpbmcgdGhlDQp3ZWVrLg0KSWYgeW91IGRvbid0IGdldCBhIHJl
cGx5IGZyb20gaGltIGluIDEtMiB3ZWVrcywgbWF5YmUgc2VuZCBhIHBpbmctZW1haWwuDQpCdXQs
IGlmIGhlIGdldHMgYXJvdW5kIGl0IHRoaXMgd2Vla1tlbmRdLCB0aGVuIGF0IGxlYXN0IHlvdXIg
cGF0Y2ggaGFzIHRoZQ0KZGVzY3JpcHRpb24gcGFydCBub3cgOikNCg0KDQo+ID4gVGhhbmtzDQo+
ID4gQWxleA0KPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTGFycyBNw7ZsbGVuZG9yZiA8bGFy
cy5tb2VsbGVuZG9yZkBwbGF0aW5nLmRlPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9paW8v
aW5kdXN0cmlhbGlvLWJ1ZmZlci5jIHwgNiArKysrKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMNCj4gPiA+IGIvZHJpdmVycy9paW8v
aW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ID4gPiBpbmRleCA1ZDA1YzM4YzRiYTkuLjJmMDM3Y2Q1
OWQ1MyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIu
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ID4gPiBA
QCAtNTQ2LDcgKzU0Niw3IEBAIHN0YXRpYyBpbnQgaWlvX2NvbXB1dGVfc2Nhbl9ieXRlcyhzdHJ1
Y3QgaWlvX2Rldg0KPiA+ID4gKmluZGlvX2RldiwNCj4gPiA+ICAJCQkJY29uc3QgdW5zaWduZWQg
bG9uZyAqbWFzaywgYm9vbCB0aW1lc3RhbXApDQo+ID4gPiAgew0KPiA+ID4gIAl1bnNpZ25lZCBi
eXRlcyA9IDA7DQo+ID4gPiAtCWludCBsZW5ndGgsIGk7DQo+ID4gPiArCWludCBsZW5ndGgsIGks
IGxhcmdlc3QgPSAwOw0KPiA+ID4gDQo+ID4gPiAgCS8qIEhvdyBtdWNoIHNwYWNlIHdpbGwgdGhl
IGRlbXV4ZWQgZWxlbWVudCB0YWtlPyAqLw0KPiA+ID4gIAlmb3JfZWFjaF9zZXRfYml0KGksIG1h
c2ssDQo+ID4gPiBAQCAtNTU0LDEzICs1NTQsMTcgQEAgc3RhdGljIGludCBpaW9fY29tcHV0ZV9z
Y2FuX2J5dGVzKHN0cnVjdA0KPiA+ID4gaWlvX2Rldg0KPiA+ID4gKmluZGlvX2RldiwNCj4gPiA+
ICAJCWxlbmd0aCA9IGlpb19zdG9yYWdlX2J5dGVzX2Zvcl9zaShpbmRpb19kZXYsIGkpOw0KPiA+
ID4gIAkJYnl0ZXMgPSBBTElHTihieXRlcywgbGVuZ3RoKTsNCj4gPiA+ICAJCWJ5dGVzICs9IGxl
bmd0aDsNCj4gPiA+ICsJCWxhcmdlc3QgPSBtYXgobGFyZ2VzdCwgbGVuZ3RoKTsNCj4gPiA+ICAJ
fQ0KPiA+ID4gDQo+ID4gPiAgCWlmICh0aW1lc3RhbXApIHsNCj4gPiA+ICAJCWxlbmd0aCA9IGlp
b19zdG9yYWdlX2J5dGVzX2Zvcl90aW1lc3RhbXAoaW5kaW9fZGV2KTsNCj4gPiA+ICAJCWJ5dGVz
ID0gQUxJR04oYnl0ZXMsIGxlbmd0aCk7DQo+ID4gPiAgCQlieXRlcyArPSBsZW5ndGg7DQo+ID4g
PiArCQlsYXJnZXN0ID0gbWF4KGxhcmdlc3QsIGxlbmd0aCk7DQo+ID4gPiAgCX0NCj4gPiA+ICsN
Cj4gPiA+ICsJYnl0ZXMgPSBBTElHTihieXRlcywgbGFyZ2VzdCk7DQo+ID4gPiAgCXJldHVybiBi
eXRlczsNCj4gPiA+ICB9DQo+ID4gPiANCj4gPiA+IC0tDQo+ID4gPiAyLjIzLjANCj4gPiA+IA0K
