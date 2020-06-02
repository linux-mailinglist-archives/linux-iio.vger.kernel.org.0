Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA42A1EBE2C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFBOcb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 10:32:31 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:59528 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgFBOcb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 10:32:31 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 052EUsjp031068;
        Tue, 2 Jun 2020 10:32:26 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0b-00128a01.pphosted.com with ESMTP id 31bh8b0trf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 10:32:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKSq4zZBq9cL76fF3zxLZQEzzigT9bveEhVWOCri/gpG6MqUzmZ/M6eo/BvH583JylF+2w3lC0Td5vpLHtV0dWjYJtL13eXVMmbAqFkQ64KsPLp9VnLVs2ZWSl59gHU/sOnXTvbNdFgFHYVqclpXFJza9hBtVk3GGnIZI4f3b+KP1GsvDDUNVlCLhHRHKR/REIGdeo98MuLXq0UTElyd93wd+fTAPDdPAkRZBb8+4IqAvsFldbka4Vd51vXFZ2KJjl1SGwR5rS++v0XYRO6DDWXJnV2NkpZDZSesmsvZ6BEZDaoeGRo6UTLYfn9jpPr+JY/nGT7iS8OEWS0SbbQ7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d6DRjUoF+2GVwt6ljmUjHvw63lyjBNVjcCjjLwIBgg=;
 b=D5ONplfL/DyJHMmUL1VZqTdUfgXXEiRkbpbwog9FRJLsPM04OjPjDMpP7xZN6HlkkEuz4fWJObrIKq7CpegO+mi/aUd6l+q+TLvKKVqEvfzNiT9eViOq6DHT2qPucPDot6Wt1uPG5iHhwDv0lCq8g0+lYpEXTI2jtAQdPxeQh7wONvb4uAXHu6ti/fZuYD4L9H8zqpIxt5eoBSbHMzdRe44C84cOZJMU0DcKZ9nAjVG0lXBE+vCaj4r7udAw+qcj7/Twzzpc75AjSfIC+MklKz/Uu7d0JO91o3QDjJTyEU+vW9OXX0lkGZaozEGghGAknVaGz75Z8e6J9C0RNeKxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d6DRjUoF+2GVwt6ljmUjHvw63lyjBNVjcCjjLwIBgg=;
 b=CJroEjOjzc61qH2jhLU/hK9L9W2Wej/RDyRELqa5UOv8jmnEX5akGu1aAtr6aPOJAxFnWeMF80yDE8BdyO/dsZNA+2uB9210vA4vVQdgrah7mDMyhVACaW1tbAIxbD7r+8/OHIKa52ynB54pqHoeDxolLI04MmpC91x4SibBAxA=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3433.namprd03.prod.outlook.com (2603:10b6:5:ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 14:32:24 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3066.018; Tue, 2 Jun 2020
 14:32:24 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "johan@kernel.org" <johan@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/5] iio: light: lm3533-als: remove explicit parent
 assignment
Thread-Topic: [PATCH 4/5] iio: light: lm3533-als: remove explicit parent
 assignment
Thread-Index: AQHWMBQTKJFuUy7W6E2X8purierYqqi+5C4AgAAOtACAACvOgIADN/4AgAMeagA=
Date:   Tue, 2 Jun 2020 14:32:23 +0000
Message-ID: <2e99bd6d95d001f337ca7c5cdd17e67cea19e62a.camel@analog.com>
References: <20200522082208.383631-1-alexandru.ardelean@analog.com>
         <20200522082208.383631-4-alexandru.ardelean@analog.com>
         <20200529101608.GC19480@localhost>
         <05500c815f4881a6aa86c809c5ac53e8af3f3e91.camel@analog.com>
         <20200529134533.GD19480@localhost> <20200531155444.73b9fd78@archlinux>
In-Reply-To: <20200531155444.73b9fd78@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2f67956-c11d-4e9d-9a69-08d80701c428
x-ms-traffictypediagnostic: DM6PR03MB3433:
x-microsoft-antispam-prvs: <DM6PR03MB34332E52803A4FB00F38E018F98B0@DM6PR03MB3433.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvF0Jm0Y74NEfi8NPA1VWjA8gHLYx2r237gKspHG14oIP8NNaIpx0hETzNH8zC2VPJxdNwF25c3O6JjSZpOevL5HucI7jPKRuLWUbJrFqUzwsa4Elf1oV8h76WR/NHdsp5BrTnwqPMuPObA0ezO1ViD2TGQcmMVAVtgtl5cxZuZzCXfrkSIWcKZa+J8/fkMDjtm5Ai/g5uQ7wPZdGBi/QVX2kuijirulYgkjEDu7KSgKYeB0rZgU0alSlwhH0K542jioCqkQ1RrKbQEE2EMQrERyLihFPfMV7sJ8Iy2TlZpR1nZXXgcOIFa+0xsQ1Cdi95tow2bS+iTnYzDTEgmCnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(376002)(346002)(366004)(39860400002)(110136005)(54906003)(26005)(5660300002)(316002)(86362001)(2616005)(8936002)(71200400001)(6506007)(8676002)(4326008)(66946007)(478600001)(6486002)(66556008)(64756008)(36756003)(2906002)(6512007)(186003)(66446008)(66476007)(76116006)(83380400001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NOFNWXyfSXbkJ9lD2zQjUFZ3T7Hejt7CQUQ6DCgynRbNnXY/rlA1WlrpyPptFf1sAFfUEQUUIKZjGinbH6ykd1ctoJT4yosdXwQ/cLxyfoLIklN9pOea13NC8zTAP7nEuubGOm6bjDYq0z3oNlZiGqw7bIecusg3qkF83Ii3MVlbNpPPijAWRDVeejAql059lRP0YmplaaSlw82KuGP4tJKTuMmoWF3TQaoXxD2f0xro2lg4dHGSqoQf1vmkavL+9zMjNsPYQ9Aa5kRUQob+mvY9fl6GKyAx+40bRS+avjCEdP5ONcD889wKr/x0Hoqa57vYD0TFD4NEKSO/gOBhd2yR8+tkGJiul9/RBCE6Uop+F8TF7atYay1WCoAldFBT0O21XVHIcSvFmArRZDOiZINeKFz/hU0lYtilNJkdufoNOKvOF//oZrY5yJa4LYaAOUYwfEsNeMZCpX/IbfSJn8wOYFXivYbtdLO18SZ2Y6wLkWxfXzaREldxYIGmbGPg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3C0A837DB59EB4E81EAE6BFAA622665@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f67956-c11d-4e9d-9a69-08d80701c428
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 14:32:23.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eWr3n3LbcaK7VMt+imGQh2j8EnY2KrYaenUrb4MJK8Woo+Y3eChA9g4k0zyjoyKS0M4ncf1xcTYk3hiqwtwTTYiRGV1pI0p8gpE4YCqX8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3433
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_13:2020-06-02,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 cotscore=-2147483648
 adultscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020104
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTMxIGF0IDE1OjU0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDI5IE1heSAyMDIwIDE1OjQ1OjMzICswMjAw
DQo+IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiA+IFsgVHJp
bW1pbmcgQ0MgdG8gc29tZXRoaW5nIG1vcmUgcmVhc29uYWJsZS4uLiBdDQo+ID4gDQo+ID4gT24g
RnJpLCBNYXkgMjksIDIwMjAgYXQgMTE6MDg6MzhBTSArMDAwMCwgQXJkZWxlYW4sIEFsZXhhbmRy
dSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgMjAyMC0wNS0yOSBhdCAxMjoxNiArMDIwMCwgSm9oYW4g
SG92b2xkIHdyb3RlOiAgDQo+ID4gPiA+IE9uIEZyaSwgTWF5IDIyLCAyMDIwIGF0IDExOjIyOjA3
QU0gKzAzMDAsIEFsZXhhbmRydSBBcmRlbGVhbg0KPiA+ID4gPiB3cm90ZTogIA0KPiA+ID4gPiA+
IFRoaXMgYXNzaWdubWVudCBpcyB0aGUgbW9yZSBwZWN1bGlhciBvZiB0aGUgYnVuY2ggYXMgaXQg
YXNzaWducw0KPiA+ID4gPiA+IHRoZSBwYXJlbnQNCj4gPiA+ID4gPiBvZiB0aGUgcGxhdGZvcm0t
ZGV2aWNlJ3MgZGV2aWNlIChpLmUuIHBkZXYtPmRldi5wYXJlbnQpIGFzIHRoZQ0KPiA+ID4gPiA+
IElJTyBkZXZpY2Uncw0KPiA+ID4gPiA+IHBhcmVudC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJ
dCdzIHVuY2xlYXIgd2hldGhlciB0aGlzIGlzIGludGVudGlvbmFsIG9yIG5vdC4NCj4gPiA+ID4g
PiBIZW5jZSBpdCBpcyBpbiBpdCdzIG93biBwYXRjaC4gIA0KPiA+ID4gPiANCj4gPiA+ID4gWWVh
aCwgd2UgaGF2ZSBhIGZldyBtZmQgZHJpdmVycyB3aG9zZSBjaGlsZCBkcml2ZXJzIHJlZ2lzdGVy
cyB0aGVpcg0KPiA+ID4gPiBjbGFzcyBkZXZpY2VzIGRpcmVjdGx5IHVuZGVyIHRoZSBwYXJlbnQg
bWZkIGRldmljZSByYXRoZXIgdGhhbiB0aGUNCj4gPiA+ID4gY29ycmVzcG9uZGluZyBjaGlsZCBw
bGF0Zm9ybSBkZXZpY2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaW5jZSBpdCdzIGRvbmUgY29uc2lz
dGVudGx5IEkgdGhpbmsgeW91IG5lZWQgdG8gdXBkYXRlIHRoZW0gYWxsIGlmDQo+ID4gPiA+IHlv
dQ0KPiA+ID4gPiByZWFsbHkgd2FudCB0byBjaGFuZ2UgdGhpcy4gDQo+ID4gPiA+IA0KPiA+ID4g
PiBBbmQgaXQgbWF5IG5vdCBiZSB3b3J0aCBpdCBzaW5jZSBhdCBsZWFzdCBpbiB0aGVvcnkgc29t
ZW9uZSBjb3VsZA0KPiA+ID4gPiBub3cgYmUNCj4gPiA+ID4gcmVseWluZyBvbiB0aGlzIHRvcG9s
b2d5LiAgDQo+ID4gPiANCj4gPiA+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KPiA+ID4gSSBn
dWVzcywgaXQgY291bGQgbWFrZSBzZW5zZSB0byBkbyBoZXJlOg0KPiA+ID4gICAgICAgZGV2bV9p
aW9fZGV2aWNlX2FsbG9jKHBkZXYtPmRldi5wYXJlbnQsIC4uLikNCj4gPiA+IA0KPiA+ID4gQ3Vy
cmVudGx5IGl0J3M6DQo+ID4gPiAgICAgICBkZXZtX2lpb19kZXZpY2VfYWxsb2MoJnBkZXYtPmRl
diwgLi4uKQ0KPiA+ID4gDQo+ID4gPiBUaGF0IHdvdWxkIG1ha2UgaXQgc2xpZ2h0bHkgbW9yZSBj
b25zaXN0ZW50LiAgaS5lLiB0aGUgbGlmZS10aW1lIG9mDQo+ID4gPiB0aGUgb2JqZWN0IHdvdWxk
IGJlIGF0dGFjaGVkIHRvIHRoZSBwYXJlbnQgb2YgdGhlIHBsYXRmb3JtIGRldmljZSwNCj4gPiA+
IHZlcnN1cyB0aGUgcGxhdGZvcm0tZGV2aWNlLiAgDQo+ID4gDQo+ID4gTm90IHJlYWxseS4gSWYg
eW91IHVuYmluZCB0aGUgaWlvIGRyaXZlciwgdGhlIGlpbyBkZXZpY2UgZ2V0cw0KPiA+IGRlcmVn
aXN0ZXJlZCAoYXMgaXQgc2hvdWxkIGJlKSBhbmQgdGhlcmUncyBubyBuZWVkIHRvIGtlZXAgaXQg
YXJvdW5kDQo+ID4gYW55DQo+ID4gbW9yZS4NCj4gPiANCj4gPiBZb3UnZCBlc3NlbnRpYWxseSBq
dXN0IGxlYWsgcmVzb3VyY2VzIGV2ZXJ5IHRpbWUgeW91IHJlYmluZCB0aGUgZHJpdmVyDQo+ID4g
KGUuZy4gZHVyaW5nIGRldmVsb3BtZW50KS4NCj4gPiANCj4gPiBBbmQgaW4gZmFjdCwgeW91IGNv
dWxkIGFsc28gaW50cm9kdWNlIGEgdXNlLWFmdGVyLWZyZWUgZGVwZW5kaW5nIG9uIGlmDQo+ID4g
dGhlIHBhcmVudCBtZmQgZHJpdmVyIHVzZSBkZXZyZXMgdG8gZGVyZWdpc3RlciBpdHMgY2hpbGRy
ZW4uDQo+ID4gDQo+ID4gPiBDdXJyZW50bHksIGFzIGl0IGlzLCB0aGUgYWxsb2NhdGlvbiBbb2Yg
dGhlIElJTyBkZXZpY2VdIGlzIHRpZWQgdGhlDQo+ID4gPiBwbGF0Zm9ybS1kZXZpY2UsIGFuZCB0
aGUgSUlPIHJlZ2lzdHJhdGlvbiB0byB0aGUgcGFyZW50IChvZiB0aGUNCj4gPiA+IHBsYXRmb3Jt
LWRldmljZSkuICANCj4gPiANCj4gPiBOb3QgcXVpdGU7IHRoZSBpaW8gZGV2aWNlIHN0aWxsIGdl
dHMgZGVyZWdpc3RlcmVkIHdoZW4gdGhlIHBsYXRmb3JtDQo+ID4gZGV2aWNlIGlzIHVuYm91bmQu
DQo+ID4gDQo+ID4gPiBJJ20gbm90IHN1cGVyLWZhbWlsaWFyIHdpdGggdGhlIGludGVybmFscyBo
ZXJlLCBidXQgZG9lcyB0aGlzIHNvdW5kIGENCj4gPiA+IGJpdCB3cm9uZz8gIA0KPiA+IA0KPiA+
IEl0J3Mgbm90IGEgY29tbW9uIHBhdHRlcm4gYnV0IG5vdCBuZWNlc3NhcmlseSB3cm9uZyBwZXIg
c2UuDQo+ID4gDQo+ID4gPiBJcyB0aGVyZSBhIGNoYW5jZSB3aGVyZSB0aGUgSUlPIGRldmljZSBj
b3VsZCBiZSBkZS1hbGxvY2F0ZWQsIHdoaWxlDQo+ID4gPiByZWdpc3RlcmVkPyAgDQo+ID4gDQo+
ID4gTm8sIHRoZSBkZXZpY2UtbWFuYWdlZCBpaW8gZGV2aWNlIG9iamVjdCBpcyBmcmVlZCB3aGVu
IHRoZSBwbGF0Zm9ybQ0KPiA+IGRldmljZSBpcyB1bmJvdW5kIGFuZCBzcGVjaWZpY2FsbHkgYWZ0
ZXIgdGhlIGlpbyBkZXZpY2UgaGFzIGJlZW4NCj4gPiBkZXJlZ2lzdGVyZWQuDQo+IA0KPiBJIGhh
ZCBhIGZlZWxpbmcgd2UgbWlnaHQgaGF2ZSBhIGZldyBjYXNlcyBsaWtlIHRoaXMgaGlkaW5nIGlu
IElJTy4NCj4gDQo+IEZvciB0aGVzZSBJJ2QganVzdCBsZWF2ZSB0aGUgcGFyZW50IGJlaW5nIG1h
bnVhbGx5IHNldC4NCj4gSXQgZG9lc24ndCBkbyBhbnkgaGFybSBhbmQgdGhlIGZhY2lsaXR5IGV4
aXN0aW5nIGlzIHVzZWZ1bCBmb3IgbWVzc2luZw0KPiBhcm91bmQgd2l0aCB0b3BvbG9neS4NCj4g
DQo+IFdlIG1heSBob3dldmVyIHdhbnQgdG8gd3JhcCBpdCB1cCBpbiBhIHV0aWxpdHkgZnVuY3Rp
b24gb24gdGhlDQo+IGJhc2lzIHRoYXQgd2UgbWF5IHdhbnQgdG8gY2hhbmdlIHRoZSB2aXNpYmls
aXR5IGFuZCBsb2NhdGlvbg0KPiBvZiB0aGUgSUlPIGRldmljZSBkb3duIHRoZSBsaW5lLg0KPiAN
Cj4gaWlvX2RldmljZV9zZXRfcGFyZW50KCkgcGVyaGFwcyB3aXRoIGRvY3MgdG8gc3BlY2lmeSB0
aGF0IGl0IG11c3QNCj4gYmUgY2FsbGVkIGJldHdlZW4gYWxsb2NhdGlvbiBhbmQgcmVnaXN0cmF0
aW9uICsgaXMgbWVhbnQgdG8gYWxsb3cNCj4gY2FzZXMgd2hlcmUgd2Ugd2FudCBhIGRpZmZlcmVu
dCBwYXJlbnQgdGhhbiB0aGUgZGV2aWNlIHVzZWQgZm9yDQo+IG1hbmFnZWQgYWxsb2NhdGlvbnMg
ZXRjLg0KPiANCg0KV29ya3MgZm9yIG1lLg0KSWYgbm8gb2JqZWN0aW9ucywgSSdsbCBpbmNsdWRl
IGluIHRoZSBuZXh0IHJlLXNwaW4uDQoNCg0KPiBKb25hdGhhbg0KPiANCj4gDQo+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5h
bG9nLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9paW8vbGlnaHQvbG0z
NTMzLWFscy5jIHwgMSAtDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0p
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2xpZ2h0L2xt
MzUzMy1hbHMuYw0KPiA+ID4gPiA+IGIvZHJpdmVycy9paW8vbGlnaHQvbG0zNTMzLWFscy5jDQo+
ID4gPiA+ID4gaW5kZXggYmMxOTZjMjEyODgxLi4wZjM4MGVjOGQzMGMgMTAwNjQ0DQo+ID4gPiA+
ID4gLS0tIGEvZHJpdmVycy9paW8vbGlnaHQvbG0zNTMzLWFscy5jDQo+ID4gPiA+ID4gKysrIGIv
ZHJpdmVycy9paW8vbGlnaHQvbG0zNTMzLWFscy5jDQo+ID4gPiA+ID4gQEAgLTg1Miw3ICs4NTIs
NiBAQCBzdGF0aWMgaW50IGxtMzUzM19hbHNfcHJvYmUoc3RydWN0DQo+ID4gPiA+ID4gcGxhdGZv
cm1fZGV2aWNlDQo+ID4gPiA+ID4gKnBkZXYpDQo+ID4gPiA+ID4gIAlpbmRpb19kZXYtPmNoYW5u
ZWxzID0gbG0zNTMzX2Fsc19jaGFubmVsczsNCj4gPiA+ID4gPiAgCWluZGlvX2Rldi0+bnVtX2No
YW5uZWxzID0gQVJSQVlfU0laRShsbTM1MzNfYWxzX2NoYW5uZWxzKTsNCj4gPiA+ID4gPiAgCWlu
ZGlvX2Rldi0+bmFtZSA9IGRldl9uYW1lKCZwZGV2LT5kZXYpOw0KPiA+ID4gPiA+IC0JaW5kaW9f
ZGV2LT5kZXYucGFyZW50ID0gcGRldi0+ZGV2LnBhcmVudDsNCj4gPiA+ID4gPiAgCWluZGlvX2Rl
di0+bW9kZXMgPSBJTkRJT19ESVJFQ1RfTU9ERTsNCj4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gIAlh
bHMgPSBpaW9fcHJpdihpbmRpb19kZXYpOyAgDQo+ID4gDQo+ID4gSm9oYW4NCg==
