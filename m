Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5EE1B016C
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDTGRh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:17:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21732 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbgDTGRh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:17:37 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K68UAg011443;
        Mon, 20 Apr 2020 02:17:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vp0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:17:34 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K6HX2v019047;
        Mon, 20 Apr 2020 02:17:33 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vp09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:17:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO/88LnEbZobSRWgj4hEwzBArOkW4y6/FcZg6SE0SyVoSYm1hyuPWdsstwncqF+os9kZU6N3kNUQSp9skWxl7ElMEf3Q8M0spSLYuDzQ6Um3JTKJcixEqNsxCZoj7wGLxK+Wrr5R7TwSTURzy2/IRDo162ZWutoSqli7q9BHxgPXciUwl4E4Nu0iPbH+xZd8ImMrQskLwtsH6Otb5Ou414600wv1j3V4mGhpgmYNiMCfR7yoayH54br+Vok6RYCbcOp1eRlH0Cak3vXAcm0heWKjr2EtB2VKqxIF6/L4VG/2fyfu1hjS/vJ16AFbnAj5yxZ7Od1q1+YHigEdat0ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmp8P8c4uwhzVx6Yr1o0WFbt/6PNg4kmAlDCWI1/Jy8=;
 b=ktY3l3rIeD2C41HceDOIWItipladeTasBst79W4CY3Y9rXboP4C+/Q97ODdkyGrx2kRqlRaqea9WLjfBoM6gucy6VsTFFmEnGdg2UfwgdmW7RV5V+vVys2jzeiImd23oRtu1+RoNmTMgaWATPf1He1uF9SePBD7DeDiO+ESUUrHCPJPxQ/yps1JXxxL8okRUSGTmpmNhHr3pe5Uks6KUEv5Fob9q+VtwY2fSbAwFYZLXYfp88oN16pvfwWY9jYYovoEWRNe2KruKdgF5yPYmG8S5lmeUGmfFsHgYH94M//NjWGtHzorH1HMA0z94ClmI24H3HCTNgAwnqsIbBlwXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmp8P8c4uwhzVx6Yr1o0WFbt/6PNg4kmAlDCWI1/Jy8=;
 b=Ei9x5Z/eJ8rjZBITQxhw7islJl/acgIM+kkrDUU97XgRy4C5YZwcr5BOax9EHwrR/3uFYx1rtdpE5QhY83VBc3TD0zl1m8yBTKgCxgGLzCIl7UGaD2hERDwYmGf/Sd3B5qdgKfdVoBBduza0moKCr++buvwFvZiqhj9fQ+0q/Do=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4987.namprd03.prod.outlook.com (2603:10b6:5:1eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 06:17:32 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:17:32 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: Use an early return in iio_device_alloc to simplify
 code.
Thread-Topic: [PATCH] iio: Use an early return in iio_device_alloc to simplify
 code.
Thread-Index: AQHWFl1raH406mgAF0OJKYmouVYuqqiBiyMA
Date:   Mon, 20 Apr 2020 06:17:32 +0000
Message-ID: <0aac8f5bd4836b8ac0013bf19b2d8a0f9a8b5c47.camel@analog.com>
References: <20200419151337.43293-1-jic23@kernel.org>
In-Reply-To: <20200419151337.43293-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ba05622-b40a-4ae4-a396-08d7e4f28302
x-ms-traffictypediagnostic: DM6PR03MB4987:
x-microsoft-antispam-prvs: <DM6PR03MB498758C4CF816CCDB8FBB188F9D40@DM6PR03MB4987.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(136003)(376002)(39850400004)(346002)(366004)(76116006)(71200400001)(2906002)(8936002)(81156014)(8676002)(6486002)(4326008)(6512007)(91956017)(86362001)(6506007)(36756003)(2616005)(186003)(316002)(26005)(478600001)(110136005)(5660300002)(64756008)(66556008)(66446008)(66946007)(66476007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1U/aGiff0UYBjrpMuYpi0lNerVdrQVEqdiAjpJX5qTgzmY4wgEeRwvI1B8c8tD4t3OkhCCRbDEQOSDeBUygQ1xZvndpQPdYH1Sh4eLztchwm1cCn3GZMuoNYuuxpnUHW77323jHIecB1Ct5q8zWP2+uSN0oo+33jzTZfEymjqVRDdt7BVExoMCEoSpko1guo+BT0yMQBEOs2jx1a1Aw/NlBZ9G0nAkve+U1cxmIsLS24MY6bf27z3dBF8nXMrJUR6GzXVT20h6+FbQ3j0Gjly1ItQU7gJGhiFPLZCT5GiiXf6Kw6CjH1UearNk9kfeMpOtgm7J16/XS3VCemxjjrAma/PYsK4W9p8bsCbDEPUs7GzbHUPYqevFxkvWg0QvExpUuhK90URa3IdVXeLWzQH+maiRHQLsnktnlKC6YSZF3bV3kLvQ8+8IB7NP1YyHz9
x-ms-exchange-antispam-messagedata: heF5RSYaFSkd2BwXZjDBxeS3w6goJLtp6cnQ6UTyOOo3qdCEky23r2qZw8C4Rzyw0bncu7qTINvAvCye3p18q+47bQeuTvvibXAyHmz2Ymq441OqMUEFE9j2BdN3elVWU0xeAZyTyEdEquBbCAy1Jw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1CE32C36730B340BA74B43F379D6C45@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba05622-b40a-4ae4-a396-08d7e4f28302
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:17:32.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WpYU1nQzcXtD2WdPcV1G9F2QBaQ//0yGd+0f0quuUbAguZMF6nibwAXacZQbIG/fCOvIeGVchiRtanLPmcp6ve5nhldEGFoZ4cl9V+kWUlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4987
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_01:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDE2OjEzICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5D
YW1lcm9uQGh1YXdlaS5jb20+DQo+IA0KPiBOb3RpY2VkIHdoaWxzdCByZXZpZXdpbmcgQWxleGFu
ZHJ1J3MgcGF0Y2ggdG8gdGhlIHNhbWUgZnVuY3Rpb24uDQo+IElmIHdlIHNpbXBseSBmbGlwIHRo
ZSBsb2dpYyBhbmQgcmV0dXJuIE5VTEwgaW1tZWRpYXRlbHkgYWZ0ZXIgbWVtb3J5DQo+IGFsbG9j
YXRpb24gZmFpbHVyZSB3ZSByZWR1Y2UgdGhlIGluZGVudCBvZiB0aGUgZm9sbG93aW5nIGJsb2Nr
IGFuZA0KPiBlbmQgdXAgd2l0aCBtb3JlICdpZGlvbWF0aWMnIGtlcm5lbCBjb2RlLg0KPiANCg0K
SSBhbHNvIHdhcyB0ZW1wdGVkIHRvIGRvIGl0LCBidXQgd2FzIHRlbXB0ZWQgW2EgYml0IG1vcmVd
IGJ5IHRoZSBpbml0aWFsIGNoYW5nZQ0KdGhhdCBJIGdvb2ZlZC4NCg0KQSBmZXcgdGhvdWdodHMg
b24gdGhpcyBbY2FuIGJlIGlnbm9yZWRdLg0KQnV0LCBzaW5jZSBkb2luZyB0aGlzIGNoYW5nZSwg
c2hvdWxkICdkZXYnIGJlIHJlbmFtZWQgdG8gJ2luZGlvX2Rldic/DQpJdCBzaG91bGRuJ3QgYmUg
YSBsb3QgbW9yZSBjb2RlIHRoYW4gdGhlIGN1cnJlbnQgY2hhbmdlIFtJIGhvcGVdLg0KV2hlbiBs
b29raW5nIHRocm91Z2ggSUlPIGNvcmUsIEkgZ290IGEgbWlub3Ivc2xpZ2h0IGNvbmZ1c2lvbiBv
biB0aGlzIGFsbG9jIGNvZGUNCmFib3V0IHRoZSBuYW1lICdkZXYnIFt3aGljaCBpcyBvZiB0eXBl
ICdzdHJ1Y3QgaWlvX2RldicgdnMgJ3N0cnVjdCBkZXZpY2UnLCBhcw0KaXMgbW9yZSBjdXN0b21h
cnldLg0KDQpJZiAnZGV2JyB3YXMgY2hvc2VuIHRvIGZpdCB3aXRoaW4gYW55IDgwIGNvbC13aWR0
aCBsaW1pdCwgdGhhdCBsaW1pdCBzaG91bGQgYmUNCmxlc3MgbGlrZWx5IHRvIGhpdCBub3cuDQoN
CjEgbW9yZSBpbmxpbmUuDQoNCldlbGwsIGV2ZW4gd2l0aC93aXRob3V0IHRoZXNlIGNoYW5nZXMu
DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBh
bmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFu
LkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gQ2M6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1
LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlv
LWNvcmUuYyB8IDM4ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMgYi9kcml2ZXJzL2lpby9pbmR1
c3RyaWFsaW8tY29yZS5jDQo+IGluZGV4IGY0ZGFmMTlmMmEzYi4uOTZmNmRhY2IyMDZkIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jDQo+ICsrKyBiL2RyaXZl
cnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMNCj4gQEAgLTE1MDQsMjcgKzE1MDQsMjcgQEAgc3Ry
dWN0IGlpb19kZXYgKmlpb19kZXZpY2VfYWxsb2MoaW50IHNpemVvZl9wcml2KQ0KPiAgCWFsbG9j
X3NpemUgKz0gSUlPX0FMSUdOIC0gMTsNCj4gIA0KPiAgCWRldiA9IGt6YWxsb2MoYWxsb2Nfc2l6
ZSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFkZXYpDQo+ICsJCXJldHVybiBOVUxMOw0KPiAgDQo+
IC0JaWYgKGRldikgew0KPiAtCQlkZXYtPmRldi5ncm91cHMgPSBkZXYtPmdyb3VwczsNCj4gLQkJ
ZGV2LT5kZXYudHlwZSA9ICZpaW9fZGV2aWNlX3R5cGU7DQo+IC0JCWRldi0+ZGV2LmJ1cyA9ICZp
aW9fYnVzX3R5cGU7DQo+IC0JCWRldmljZV9pbml0aWFsaXplKCZkZXYtPmRldik7DQo+IC0JCWRl
dl9zZXRfZHJ2ZGF0YSgmZGV2LT5kZXYsICh2b2lkICopZGV2KTsNCj4gLQkJbXV0ZXhfaW5pdCgm
ZGV2LT5tbG9jayk7DQo+IC0JCW11dGV4X2luaXQoJmRldi0+aW5mb19leGlzdF9sb2NrKTsNCj4g
LQkJSU5JVF9MSVNUX0hFQUQoJmRldi0+Y2hhbm5lbF9hdHRyX2xpc3QpOw0KPiAtDQo+IC0JCWRl
di0+aWQgPSBpZGFfc2ltcGxlX2dldCgmaWlvX2lkYSwgMCwgMCwgR0ZQX0tFUk5FTCk7DQo+IC0J
CWlmIChkZXYtPmlkIDwgMCkgew0KPiAtCQkJLyogY2Fubm90IHVzZSBhIGRldl9lcnIgYXMgdGhl
IG5hbWUgaXNuJ3QgYXZhaWxhYmxlICovDQo+IC0JCQlwcl9lcnIoImZhaWxlZCB0byBnZXQgZGV2
aWNlIGlkXG4iKTsNCj4gLQkJCWtmcmVlKGRldik7DQo+IC0JCQlyZXR1cm4gTlVMTDsNCj4gLQkJ
fQ0KPiAtCQlkZXZfc2V0X25hbWUoJmRldi0+ZGV2LCAiaWlvOmRldmljZSVkIiwgZGV2LT5pZCk7
DQo+IC0JCUlOSVRfTElTVF9IRUFEKCZkZXYtPmJ1ZmZlcl9saXN0KTsNCj4gKwlkZXYtPmRldi5n
cm91cHMgPSBkZXYtPmdyb3VwczsNCj4gKwlkZXYtPmRldi50eXBlID0gJmlpb19kZXZpY2VfdHlw
ZTsNCj4gKwlkZXYtPmRldi5idXMgPSAmaWlvX2J1c190eXBlOw0KPiArCWRldmljZV9pbml0aWFs
aXplKCZkZXYtPmRldik7DQo+ICsJZGV2X3NldF9kcnZkYXRhKCZkZXYtPmRldiwgKHZvaWQgKilk
ZXYpOw0KPiArCW11dGV4X2luaXQoJmRldi0+bWxvY2spOw0KPiArCW11dGV4X2luaXQoJmRldi0+
aW5mb19leGlzdF9sb2NrKTsNCj4gKwlJTklUX0xJU1RfSEVBRCgmZGV2LT5jaGFubmVsX2F0dHJf
bGlzdCk7DQo+ICsNCj4gKwlkZXYtPmlkID0gaWRhX3NpbXBsZV9nZXQoJmlpb19pZGEsIDAsIDAs
IEdGUF9LRVJORUwpOw0KPiArCWlmIChkZXYtPmlkIDwgMCkgew0KPiArCQkvKiBjYW5ub3QgdXNl
IGEgZGV2X2VyciBhcyB0aGUgbmFtZSBpc24ndCBhdmFpbGFibGUgKi8NCj4gKwkJcHJfZXJyKCJm
YWlsZWQgdG8gZ2V0IGRldmljZSBpZFxuIik7DQo+ICsJCWtmcmVlKGRldik7DQo+ICsJCXJldHVy
biBOVUxMOw0KDQp3b3VsZCBpdCBiZSB0b28gbXVjaCBmb3IgdGhpcyBwYXRjaCB0byBtb3ZlIHRo
aXMgcmlnaHQgYWZ0ZXIgdGhlIGt6YWxsb2MoKT8NCm5vIHN0cm9uZyBvcGluaW9uIGZyb20gbXkg
c2lkZSB0byBkbyBpdCBvciBub3Q7DQpidXQgaXQgZG9lcyBzYXZlIHNvbWUgaW5pdCBjeWNsZXMs
IGFuZCBjb21wcmVzc2VzIHRoaXMgaW5pdCBibG9jayBhIGJpdDsNCg0KPiAgCX0NCj4gKwlkZXZf
c2V0X25hbWUoJmRldi0+ZGV2LCAiaWlvOmRldmljZSVkIiwgZGV2LT5pZCk7DQo+ICsJSU5JVF9M
SVNUX0hFQUQoJmRldi0+YnVmZmVyX2xpc3QpOw0KPiAgDQo+ICAJcmV0dXJuIGRldjsNCj4gIH0N
Cg==
