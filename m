Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C20F7069
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 10:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfKKJWc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 04:22:32 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:21980 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726768AbfKKJWc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 04:22:32 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAB9Hpfe008437;
        Mon, 11 Nov 2019 04:22:26 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w6v7aa6kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 04:22:26 -0500
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAB9KDet010771;
        Mon, 11 Nov 2019 04:22:25 -0500
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2058.outbound.protection.outlook.com [104.47.32.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w6v7aa6kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 04:22:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N45apVxYjAWNIZmgIltxhLei5n+p+9UMOYJSBPZ4GbcCryHgu0GvTeOx3zXE/+R6gWbi3H+5dYkd0gd5nZ2sdEleHOnSSHYIY4CWsbawu4IT9lGxJg538tvFT3X7zTsTavXTJlbqZ0kJnV4jpW2YrDXc5UJVKGuG7J0UncI5ceXtTgyxH1cx3I+hwplviWKrlx+BKHJ9RC0vsyFqVt7L7PfOgAqQWc2ZmN2fGl/g61GX0GpTcKhffRcAeskcmd9rV8+o0vEJxJZb6PBWkXFCpamInO1W7dICpdzLwXEitm2zcs6HHf4g39YbxSntesOjE5Pg7bQfXqRLtaA8nXq3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTiulq/B7rjkrhugcpEIQMw9tGu116TUbIFOYulj1KA=;
 b=WJMb6A1KDGM4eFtKDMeareZpGVBbcl4JnT9oGM2NaFBdyOksLduIpneGMuDeFWRp9c9l/vo2s8AME2Bgvjxl+SXZbPF4MOV2pux/IXA3JDLiqoQcvcVaYpeEsTLBR4BQIaKLCjXe9vQTGa7mMdnvz2Rd0gDPF2WI5DRj25bnWkRJRME/NrSfVeOzcOvbLfp9NnnZIvNjHQkP2Dx1ziC4U04emEgMxzFC8ImlF3wr6K3x18Kv5XuCFSLS1s9QydeQhTZmXjkIxmPXzsYprUtvwBAgZyYWbCSvCEuuzAVuADMOOwx+oknThiB7+OjOUxgFi1HMV7AFtCZRIAKVlZrs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTiulq/B7rjkrhugcpEIQMw9tGu116TUbIFOYulj1KA=;
 b=V4YS7hATMmdfM+M+RPvFHs/+aOLI28w0PJSLPIQkD/ELfe8iyKZCVumTaMzcrWmrLZMikwaTxVHUIIHEvdjDIZUAvibN62ElYhevdgd4+dlelKBpxXAF2RZnWHWy7ph2WOWwRiJY57uG7sxhBxh0gaBUXg95N+iIUFb+Q/liyV8=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5190.namprd03.prod.outlook.com (20.180.12.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Mon, 11 Nov 2019 09:22:24 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 09:22:23 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "martenli@axis.com" <martenli@axis.com>
Subject: Re: [PATCH] iio:adc:ti-adc084s021: Endian casting tidy ups.
Thread-Topic: [PATCH] iio:adc:ti-adc084s021: Endian casting tidy ups.
Thread-Index: AQHVgauIp82dYghfEUO4ZtRv/khJ2qd7QAGAgAeqYYCAAvWOAA==
Date:   Mon, 11 Nov 2019 09:22:23 +0000
Message-ID: <eef1b6f23fc09bccebebf3b9028b98f1e94bdd3b.camel@analog.com>
References: <20191013094722.1429243-1-jic23@kernel.org>
         <a07e927d00802115b17a5b01a3b0db245e776d7e.camel@analog.com>
         <20191109121149.4ffec6bb@archlinux>
In-Reply-To: <20191109121149.4ffec6bb@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80ff512e-6c15-4ae3-71ca-08d76688a965
x-ms-traffictypediagnostic: CH2PR03MB5190:
x-microsoft-antispam-prvs: <CH2PR03MB5190FBC8F8FF2A446D6A99E9F9740@CH2PR03MB5190.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(3846002)(4326008)(6116002)(66066001)(6486002)(66946007)(66556008)(66476007)(64756008)(66446008)(5660300002)(6246003)(66574012)(76116006)(478600001)(4001150100001)(7736002)(86362001)(316002)(305945005)(25786009)(99286004)(6916009)(102836004)(2906002)(229853002)(486006)(6506007)(76176011)(71200400001)(14454004)(6436002)(2501003)(6512007)(256004)(14444005)(26005)(186003)(5640700003)(118296001)(8676002)(54906003)(2616005)(81156014)(81166006)(446003)(36756003)(8936002)(476003)(2351001)(71190400001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5190;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rq/lBlgKb35+HqLDAqddSGB2IfHXMG4vdZEmV2GEoqkvGJlJS5HPAGGnzrFsbksSKbDnnehq8ui1szu3XrpLa6tDD0pxptyYLbSDt7pgOETAj2tArRhyaszfb8mETRALvhD9eVYQeAypsDIQi2AaLWDSica4vPpkUrcWfbbnE/iqRjtuQ2Qx4cetS80EtwZa0/aNYGQks3URCfwI5itKmRYyIzj6MTDMiPi3CE4z4QBW/CJF3JzCx9sqUgsvrVsYZcta4BC2E05KW3KOeBe+9K/c+mAstVKL9rXv7Sp56/kAzx+HQJ3C4w8QeVm+Dge6B7g5TUX/wiXMRZ8Fzlk+6X+hJHILgCW3x6YJQWPbgoCGA0uGHEcHO4mthugTsnzHAiduUob+qnBk+PtfnhjoOj7pWghc5A1o4fUGuzjE3ELjSstETiEAitQc+hoNZqxN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D9BA5A564FB5C4283BEF73552D12139@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ff512e-6c15-4ae3-71ca-08d76688a965
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 09:22:23.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Tp1Z94Etbxdkz7Lc2vmuKZTnjxGLw762rh14zWRgAijCmYM77nhr2V8f2HF80olyYoYjBZ/09r67XiNXW/6IEqw63btFgSRVmAAUpHLr00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5190
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-11_02:2019-11-08,2019-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911110092
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTExLTA5IGF0IDEyOjExICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDQgTm92IDIwMTkgMTU6MDg6MTIgKzAwMDAN
Cj4gIkFyZGVsZWFuLCBBbGV4YW5kcnUiIDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4g
d3JvdGU6DQo+IA0KPiA+IE9uIFN1biwgMjAxOS0xMC0xMyBhdCAxMDo0NyArMDEwMCwgamljMjNA
a2VybmVsLm9yZyB3cm90ZToNCj4gPiA+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFu
LkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gPiA+IA0KPiA+ID4gSGlnaGxpZ2h0ZWQgYnkgc3BhcnNl
Og0KPiA+ID4gQ0hFQ0sgICBkcml2ZXJzL2lpby9hZGMvdGktYWRjMDg0czAyMS5jDQo+ID4gPiBk
cml2ZXJzL2lpby9hZGMvdGktYWRjMDg0czAyMS5jOjc5OjI2OiB3YXJuaW5nOiBpbmNvcnJlY3Qg
dHlwZSBpbg0KPiA+ID4gYXNzaWdubWVudCAoZGlmZmVyZW50IGJhc2UgdHlwZXMpDQo+ID4gPiBk
cml2ZXJzL2lpby9hZGMvdGktYWRjMDg0czAyMS5jOjc5OjI2OiAgICBleHBlY3RlZCB1bnNpZ25l
ZCBzaG9ydA0KPiA+ID4gW3Vuc2lnbmVkXSBbc2hvcnRdIFt1c2VydHlwZV0gPG5vaWRlbnQ+DQo+
ID4gPiBkcml2ZXJzL2lpby9hZGMvdGktYWRjMDg0czAyMS5jOjc5OjI2OiAgICBnb3QgcmVzdHJp
Y3RlZCBfX2JlMTYNCj4gPiA+IDxub2lkZW50Pg0KPiA+ID4gZHJpdmVycy9paW8vYWRjL3RpLWFk
YzA4NHMwMjEuYzoxMTA6MjQ6IHdhcm5pbmc6IGNhc3QgdG8gcmVzdHJpY3RlZA0KPiA+ID4gX19i
ZTE2DQo+ID4gPiBkcml2ZXJzL2lpby9hZGMvdGktYWRjMDg0czAyMS5jOjExMDoyNDogd2Fybmlu
ZzogY2FzdCB0byByZXN0cmljdGVkDQo+ID4gPiBfX2JlMTYNCj4gPiA+IGRyaXZlcnMvaWlvL2Fk
Yy90aS1hZGMwODRzMDIxLmM6MTEwOjI0OiB3YXJuaW5nOiBjYXN0IHRvIHJlc3RyaWN0ZWQNCj4g
PiA+IF9fYmUxNg0KPiA+ID4gZHJpdmVycy9paW8vYWRjL3RpLWFkYzA4NHMwMjEuYzoxMTA6MjQ6
IHdhcm5pbmc6IGNhc3QgdG8gcmVzdHJpY3RlZA0KPiA+ID4gX19iZTE2DQo+ID4gPiAgIA0KPiBU
aGFua3MgZm9yIGxvb2tpbmcgYXQgdGhpcy4gSSdkIG1pc3NlZCBlbnRpcmVseSB0aGF0IGEgdm9p
ZCAqDQo+IHdhcyBoaWRpbmcgc29tZSBtb3JlIG5hc3RpbmVzcyENCj4gDQo+ID4gVGhpcyBvbmUg
bG9va3MgYSBiaXQgdHJpY2t5Lg0KPiA+IEFuZCBsb29rcyBsaWtlIGl0IGNvdWxkIHVzZSBhIGJp
dCBtb3JlIGNsZWFudXAgdGhhbiB0aGlzLg0KPiA+IE90aGVyd2lzZSBzcGFyc2UgbWF5IGNvbWUg
YWxvbmcgYW5kIGNvbXBsYWluIGFib3V0IG1vcmUgc3R1ZmYuDQo+ID4gDQo+ID4gT25lIHRoaW5n
IHRoYXQgd291bGQgYmUgZ29vZCwgd291bGQgYmUgdG8gY2hhbmdlOg0KPiA+IA0KPiA+IGludCBh
ZGMwODRzMDIxX2FkY19jb252ZXJzaW9uKHN0cnVjdCBhZGMwODRzMDIxICphZGMsIHZvaWQgKmRh
dGEpDQo+ID4gDQo+ID4gdG8NCj4gPiANCj4gPiBpbnQgYWRjMDg0czAyMV9hZGNfY29udmVyc2lv
bihzdHJ1Y3QgYWRjMDg0czAyMSAqYWRjLCBfX2JlMTYgKmRhdGEsIGludA0KPiA+IGJ1Zl9zaXpl
KSAgIFsxXQ0KPiA+IA0KPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJv
biA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiA+ID4gQ2M6IE3DpXJ0ZW4gTGluZGFo
bCA8bWFydGVubGlAYXhpcy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2lpby9hZGMv
dGktYWRjMDg0czAyMS5jIHwgNyArKysrLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2FkYy90aS1hZGMwODRzMDIxLmMgYi9kcml2ZXJzL2lpby9hZGMvdGktDQo+ID4g
PiBhZGMwODRzMDIxLmMNCj4gPiA+IGluZGV4IGJkZWRmNDU2ZWUwNS4uNDI5NjZmMmViM2Q4IDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL3RpLWFkYzA4NHMwMjEuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9paW8vYWRjL3RpLWFkYzA4NHMwMjEuYw0KPiA+ID4gQEAgLTY4LDcgKzY4
LDcgQEAgc3RhdGljIGludCBhZGMwODRzMDIxX2FkY19jb252ZXJzaW9uKHN0cnVjdA0KPiA+ID4g
YWRjMDg0czAyMQ0KPiA+ID4gKmFkYywgdm9pZCAqZGF0YSkNCj4gPiA+ICB7DQo+ID4gPiAgCWlu
dCBuX3dvcmRzID0gKGFkYy0+c3BpX3RyYW5zLmxlbiA+PiAxKSAtIDE7IC8qIERpc2NhcmQgZmly
c3Qgd29yZA0KPiA+ID4gKi8NCj4gPiA+ICAJaW50IHJldCwgaSA9IDA7DQo+ID4gPiAtCXUxNiAq
cCA9IGRhdGE7DQo+ID4gPiArCV9fYmUxNiAqcCA9IGRhdGE7DQo+ID4gPiAgDQo+ID4gPiAgCS8q
IERvIHRoZSB0cmFuc2ZlciAqLw0KPiA+ID4gIAlyZXQgPSBzcGlfc3luYyhhZGMtPnNwaSwgJmFk
Yy0+bWVzc2FnZSk7DQo+ID4gPiBAQCAtODcsNiArODcsNyBAQCBzdGF0aWMgaW50IGFkYzA4NHMw
MjFfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYNCj4gPiA+ICppbmRpb19kZXYsDQo+ID4gPiAgew0K
PiA+ID4gIAlzdHJ1Y3QgYWRjMDg0czAyMSAqYWRjID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4g
PiA+ICAJaW50IHJldDsNCj4gPiA+ICsJX19iZTE2IHZhbHVlOw0KPiA+ID4gIA0KPiA+ID4gIAlz
d2l0Y2ggKG1hc2spIHsNCj4gPiA+ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX1JBVzoNCj4gPiA+IEBA
IC0xMDEsMTMgKzEwMiwxMyBAQCBzdGF0aWMgaW50IGFkYzA4NHMwMjFfcmVhZF9yYXcoc3RydWN0
IGlpb19kZXYNCj4gPiA+ICppbmRpb19kZXYsDQo+ID4gPiAgCQl9DQo+ID4gPiAgDQo+ID4gPiAg
CQlhZGMtPnR4X2J1ZlswXSA9IGNoYW5uZWwtPmNoYW5uZWwgPDwgMzsNCj4gPiA+IC0JCXJldCA9
IGFkYzA4NHMwMjFfYWRjX2NvbnZlcnNpb24oYWRjLCB2YWwpOw0KPiA+ID4gKwkJcmV0ID0gYWRj
MDg0czAyMV9hZGNfY29udmVyc2lvbihhZGMsICZ2YWx1ZSk7ICANCj4gPiANCj4gPiBGb2xsb3dp
bmcgWzFdLCB0aGlzIGNvdWxkIGJlIGNhbGxlZA0KPiA+IHdpdGggICJhZGMwODRzMDIxX2FkY19j
b252ZXJzaW9uKGFkYywNCj4gPiAmdmFsdWUsIDEpIiB0byBtYWtlIHN1cmUgaXQncyBub3QgZG9p
bmcgYW55IHN0YWNrIGNvcnJ1cHRpb24uIEkgY2FuJ3QNCj4gPiB0ZWxsDQo+ID4gaWYgdGhpcyBp
cyBkb2luZyBhbnkgb3Igbm90OyB0aGUgY29kZSBpcyBhIGJpdCBmdXp6eSB0byBtZS4NCj4gDQo+
IEknbSBmYWlybHkgc3VyZSBjdXJyZW50IGNvZGUgaXMgc2FmZSBhcyBJSU9fQ0hBTl9JTkZPX1JB
VyByZWFkcyBvY2N1cg0KPiB3aXRoIHByb3RlY3Rpb24gYWdhaW5zdCBidWZmZXJlZCBtb2RlIGFu
ZCB3aGVuIG5vdCBpbiBidWZmZXJlZCBtb2RlIHRoZQ0KPiBtYWdpYyBsZW5ndGggaXMgNCB3aGlj
aCBpcyBkaXZpZGVkIGJ5IDIgYW5kIGhhcyAxIHN1YnRyYWN0ZWQgZ2l2aW5nIGENCj4gc2FmZSB2
YWx1ZSBvZiAxLiAgVGhpcyBkYW5jZSBpcyBlbnN1cmUgdGhlcmUgaXMgb25seSBvbmUgcGxhY2Ug
d2hlcmUNCj4gdGhlIGxlbmd0aCBpcyByZWNvcmRlZCBhbmQgYXZvaWQgcmVjb21wdXRpbmcgaXQg
aW4NCj4gKl9idWZmZXJfdHJpZ2dlcl9oYW5kbGVyLg0KPiBXZSBjb3VsZCBzdGFzaCBpdCBpbiB0
aGUgcHJpdmF0ZSBkYXRhIHRob3VnaCBmb3IgZWFzaWVyIHRvIHJlYWQgY29kZS4NCg0KTm8gaWRl
YSB3aGF0J3MgYmVzdCBoZXJlLg0KSSBhbSBtb3N0bHkgaW50ZXJlc3RlZCBpbiBnZXR0aW5nIHRo
ZSBzcGFyc2UgY2hlY2tzIHVwLW4tcnVubmluZywgc28gdGhhdA0Kd2UgZG9uJ3QgaGF2ZSBhbm90
aGVyIGRhbmNlIHdpdGggR3JlZyBbYXMgdGhlIG9uZXMgd2l0aCB0aGUgQURJUyBwYXRjaGVzXS4N
Cg0KPiANCj4gQWdyZWVkIHRoYXQgdGhlIHR5cGUgY2hhbmdlIHRvIF9fYmUxNiAqIGRlZmluaXRl
bHkgbWFrZXMgc2Vuc2UgdGhvdWdoLg0KPiBXaWxsIHJlc3BpbiB3aXRoIHRoYXQuDQo+IA0KPiA+
IFRoZSBuZWF0IHBhcnQgaXMgdGhhdCBtZW1jcHkoKSBjb3VsZCBiZSB1c2VkIHRvIHRoZW4gYWNj
ZXNzIHRoZSBkYXRhIG9uDQo+ID4gcnhfYnVmLg0KPiANCj4gV2UgY291bGQgZG8gdGhhdCwgYnV0
IGFzIGl0J3Mgbm90IHBhcnQgb2YgdGhlIGZpeCByZWFsbHkgSSdkIHJhdGhlciBsZWF2ZQ0KPiB0
aGF0IGZvciBhbm90aGVyIGRheS4gIE5vdCBzdXJlIGFueXRoaW5nIHN0b3BzIHVzIGRvaW5nIHRo
aXMgd2hpbHN0IGRvaW5nDQo+IHRoaXMgdGlkeSB1cCBldmVuIHdpdGhvdXQgcGFzc2luZyBpbiB0
aGUgc2l6ZS4NCg0KTGV0J3MgbGVhdmUgdGhpbmdzIGhlcmUgYXMtaXMgZm9yIG5vdy4NCnNwYXJz
ZSBjaGVja3MgW29yIGFueSBuZXcgY2hlY2tzIHdlJ3JlIGFkZGluZ10gZmVlbCBtb3JlIGltcG9y
dGFudCByaWdodA0Kbm93Lg0KDQpUaGFua3MNCkFsZXgNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Sm9uYXRoYW4NCj4gDQo+ID4gDQo+ID4gPiAgCQlpaW9fZGV2aWNlX3JlbGVhc2VfZGlyZWN0X21v
ZGUoaW5kaW9fZGV2KTsNCj4gPiA+ICAJCXJlZ3VsYXRvcl9kaXNhYmxlKGFkYy0+cmVnKTsNCj4g
PiA+ICAJCWlmIChyZXQgPCAwKQ0KPiA+ID4gIAkJCXJldHVybiByZXQ7DQo+ID4gPiAgDQo+ID4g
PiAtCQkqdmFsID0gYmUxNl90b19jcHUoKnZhbCk7DQo+ID4gPiArCQkqdmFsID0gYmUxNl90b19j
cHUodmFsdWUpOw0KPiA+ID4gIAkJKnZhbCA9ICgqdmFsID4+IGNoYW5uZWwtPnNjYW5fdHlwZS5z
aGlmdCkgJiAweGZmOw0KPiA+ID4gIA0KPiA+ID4gIAkJcmV0dXJuIElJT19WQUxfSU5UOyAgDQo=
