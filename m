Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A521A72EB
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 07:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405443AbgDNFU2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 01:20:28 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:40946 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405440AbgDNFU0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 01:20:26 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E5K0vq022422;
        Tue, 14 Apr 2020 01:20:11 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7naqxsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 01:20:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiLjuz7DWo5CTd3Ua63skBLujAeXHdtAd2WRqn0ArRS5+p8B4Cg/n1yhFfbUXYCu2GlsNEpXoiQnToFaBXQwkRDcQsvfquZ9NCtbUQHqmV8A6D38+tNYJEU/np0ei9s3lwp7eMgdS25C6LLpZUHF8tMosVCYiV471Zwt1k7jU0GflW6+ErFJOSS5nEM6do3kgPOjwEexVhiwon+bhTYZ1JsKUIqroRv4/iqKv8WBd9VWwE5HsAVN/d5me0+Hn6aM5fc2TWdlR1qLvElk9JETssVvxixv9APml7wahhlCHnbSClNi2SbsfiRFC+XPDjy4lBI3SxlToNlfi3UFlXuQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttL+ssNo925jR4Ahge/SnhI+Pu+SpW+w1xr0LP6O0yg=;
 b=isQiusqMBQwQnOC6rh63tZYmQj+/Dqcx4FMPbSS1zgr7TnCfUA1PHRyvb0K6GsuuleXpJPIvC0lUKZ94hihYYiERVhNJm++2ZkcnUQzW5RJukeLeGdtZk7uVCYKGj6is4o5ofr2nltp+STjo11nBys6+f/hul0hne+QP5mzGIchminyZmHEju8hMgWKAMaQ1afm1oUCtTEfWLtyWLfOJ+5+zqSTCHb0S1MidtTGJMXs/CiNgW38mKqn+b2m5+y5t8xHFkvUv1aTGg+CyuJbJzXgoh1esAOCxARZcHO4NDpZAga/KYbDBawjcOe+Ryvn6aLngdrq/XumH6rXq/RW5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttL+ssNo925jR4Ahge/SnhI+Pu+SpW+w1xr0LP6O0yg=;
 b=Vv+UbO/TU4vfyX06PSRHkBqosmaKYyVIKVK8Gm2d9BAy1Q9XMB4zVMhoUOVbIiUJqXH41f+lKEci42PcXXica7ncRInTtpqmVsBEoNibQIVXiMH11D3vmrq4TSILcX9rMeLNbypNUM8pEpCfV8+MIhjsuDqLGkM3wUtOS21Iv8o=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4283.namprd03.prod.outlook.com (2603:10b6:5:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Tue, 14 Apr
 2020 05:20:10 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Tue, 14 Apr 2020
 05:20:10 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v3 1/5] iio: core: register buffer fileops only if buffer
 present
Thread-Topic: [PATCH v3 1/5] iio: core: register buffer fileops only if buffer
 present
Thread-Index: AQHWD0KnO2OJL38DS0W/y8nQFzbZ0Kh3NyMAgADkKAA=
Date:   Tue, 14 Apr 2020 05:20:09 +0000
Message-ID: <17b4c332f285cf3cbc6ad6f7ce2960740c055a35.camel@analog.com>
References: <20200410141729.82834-1-alexandru.ardelean@analog.com>
         <20200410141729.82834-2-alexandru.ardelean@analog.com>
         <20200413164726.5e5e2efd@archlinux>
In-Reply-To: <20200413164726.5e5e2efd@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 281ff68f-d3e8-4c5b-32a1-08d7e0338089
x-ms-traffictypediagnostic: DM6PR03MB4283:
x-microsoft-antispam-prvs: <DM6PR03MB428318BA351E29477F225E48F9DA0@DM6PR03MB4283.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(376002)(39860400002)(136003)(366004)(346002)(8676002)(81156014)(66446008)(64756008)(66556008)(66946007)(66476007)(6486002)(2906002)(76116006)(91956017)(86362001)(6916009)(186003)(8936002)(6512007)(5660300002)(2616005)(36756003)(26005)(478600001)(6506007)(54906003)(4326008)(71200400001)(316002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sM5ds/ul4gqbYYAuQI7VqrstAaUNDBQp4W3E7AZQ2yixJKDNHyVgE/+fqkQmmzOs7Q8VOKmKIkqsmAa3Q/Rc1FSY+HjnD7LztVw5vIXobCntlcz53GXj4GbmmGWrhvTrSjA/PoN/w78faaQ2Kf6g3WIDcs00XjoABQ0O0vMVTKR8C+aNUb79+cAJZC5TIbP/yquiUymGOeNgtW9SEy4nfWbM21PKpd1Nl1p3qbLc+7KO9Lc9Vw5UMJ1d3JCNj9UOTg7/R3q/qNzgeeNaviF/RQQESUL/KTaVxaEzM5TquJZ1dbXewMXzybSIwBo0qWkX7/ne36Ub+YOBoVCokLXvxNPif3aJZvYT7WEn7KuJkNSVZ2mcAH4wI7zTSyb5+IwdJgxVJsyTT8oVifBY3aKnvmDckW34ArfnzlhBfcIaZJKD+Ygu6BGJlaBlNzL09H2
x-ms-exchange-antispam-messagedata: NZ2MiUfZR0JLbdcTZIwVEEpfJQVtplpOMGdVBC2Y7fLCWfY9sKWMRf4K1yrPb59bjiLVDmH+QuI86VsYGTkgiwYUZDgj9/wVJLPAc7hbvX3kB+5YBxewJO03onHQDSyPpIhDU82ud+iMC7q2TGzbyw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <90BA2CA66B83A8448D2C488D3C08155F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281ff68f-d3e8-4c5b-32a1-08d7e0338089
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 05:20:09.9354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDYunJPHK1DTR9qjnWfqwJkPbsxD/aRv2LAK+45OblAFt+kg36UpOYg7bsygiy4ih96Dg5rIegDnq1W89MP7dRn6Lz6VV1Qg1XUu9WMlrOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4283
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_01:2020-04-13,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140043
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTEzIGF0IDE2OjQ3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDEwIEFwciAyMDIwIDE3OjE3OjI1ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGUgaW50ZW50IGlzIHRvIGxvY2FsaXplIGFsbCBidWZmZXIgb3BzIGlu
dG8gdGhlIGluZHVzdHJpYWxpby1idWZmZXIuYw0KPiA+IGZpbGUsIHRvIGJlIGFibGUgdG8gYWRk
IHN1cHBvcnQgZm9yIG11bHRpcGxlIGJ1ZmZlcnMgcGVyIElJTyBkZXZpY2UuDQo+ID4gDQo+ID4g
V2Ugc3RpbGwgbmVlZCB0byBhbGxvY2F0ZSBhIGNoYXJkZXYgaW4gX19paW9fZGV2aWNlX3JlZ2lz
dGVyKCkgdG8gYmUgYWJsZQ0KPiA+IHRvIHBhc3MgZXZlbnQgaW9jdGwgY29tbWFuZHMuIFNvLCBp
ZiB0aGUgSUlPIGRldmljZSBoYXMgbm8gYnVmZmVyLCB3ZQ0KPiA+IGNyZWF0ZSB0aGUgbGVnYWN5
IGNoYXJkZXYgZm9yIHRoZSBldmVudCBpb2N0bCgpIGNvbW1hbmQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNv
bT4NCj4gDQo+IFdoaWxzdCB3ZSBhcmUgaGVyZSwgY2FuIHdlIGF2b2lkIGFsbG9jYXRpbmcgdGhl
IGNoYXJkZXYgYXQgYWxsIGlmDQo+IHdlIGhhdmUgbmVpdGhlciBidWZmZXIgc3VwcG9ydCwgbm9y
IGV2ZW50cz8gIFNvIGRvbid0IGFkZCB0aGUgY2hyZGV2IHRvIHRoZQ0KPiBkZXZpY2UuDQoNClRo
YXQgc2hvdWxkIGhhcHBlbiBhZnRlciBwYXRjaCA1LzUuDQpJZiB0aGVyZSBhcmVuJ3QgYW55IGJ1
ZmZlcnMsIGFuZCAnaW5kaW9fZGV2LT5ldmVudF9pbnRlcmZhY2UnIGlzIE5VTEwsIG5vDQpjaGFy
ZGV2IHNob3VsZCBleGlzdC4NCg0KTWF5YmUgSSBjYW4gcmVkdWNlIHRoaXMsIGdpdmVuIHRoZSBm
YWN0IHRoYXQgdGhpcyBnb2VzIGF3YXkgaW50byBmaWxlcyBsYXRlci4NCkkgZGlkIHRoaW5ncyBp
biB2ZXJ5LXNtYWxsIGluY3JlbWVudGFsIHN0ZXBzIHRoYXQgSSBsYXRlciBzcXVhc2hlZC4NCg0K
VGhpcyBwYXRjaCBraW5kIG9mIGhpZ2hsaWdodHMgYW4gaW50ZXJtZWRpYXRlIHN0ZXAgdG93YXJk
cyB0aGUgZmluYWwgcmV3b3JrDQpbbW92aW5nIGNoYXJkZXZzIGludG8gZmlsZXNdDQoNCj4gDQo+
IFRoYXQgY292ZXJzIHF1aXRlIGEgd2lkZSByYW5nZSBvZiBzbG93IGRldmljZXMgYW5kIGlzIGEg
bmljZSBpbmNpZGVudGFsDQo+IGltcHJvdmVtZW50ICh0byBiZSBob25lc3QgSSdkIGZvcmdvdHRl
biB3ZSBhY3R1YWxseSBjcmVhdGVkIGEgY2hhcmRldg0KPiBpbiB0aG9zZSBjaXJjdW1zdGFuY2Ug
OigNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9pbmR1c3Ry
aWFsaW8tY29yZS5jIHwgMTQgKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby0N
Cj4gPiBjb3JlLmMNCj4gPiBpbmRleCAxNTdkOTVhMjRmYWEuLmM4YzA3NDYwMjcwOSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jDQo+ID4gKysrIGIvZHJp
dmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiA+IEBAIC0xNzA3LDYgKzE3MDcsMTUgQEAg
c3RhdGljIGludCBpaW9fY2hlY2tfdW5pcXVlX3NjYW5faW5kZXgoc3RydWN0IGlpb19kZXYNCj4g
PiAqaW5kaW9fZGV2KQ0KPiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVy
X3NldHVwX29wcyBub29wX3Jpbmdfc2V0dXBfb3BzOw0KPiA+ICANCj4gPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgaWlvX2V2ZW50X2ZpbGVvcHMgPSB7DQo+ID4gKwkucmVs
ZWFzZSA9IGlpb19jaHJkZXZfcmVsZWFzZSwNCj4gPiArCS5vcGVuID0gaWlvX2NocmRldl9vcGVu
LA0KPiA+ICsJLm93bmVyID0gVEhJU19NT0RVTEUsDQo+ID4gKwkubGxzZWVrID0gbm9vcF9sbHNl
ZWssDQo+ID4gKwkudW5sb2NrZWRfaW9jdGwgPSBpaW9faW9jdGwsDQo+ID4gKwkuY29tcGF0X2lv
Y3RsID0gY29tcGF0X3B0cl9pb2N0bCwNCj4gPiArfTsNCj4gPiArDQo+ID4gIGludCBfX2lpb19k
ZXZpY2VfcmVnaXN0ZXIoc3RydWN0IGlpb19kZXYgKmluZGlvX2Rldiwgc3RydWN0IG1vZHVsZQ0K
PiA+ICp0aGlzX21vZCkNCj4gPiAgew0KPiA+ICAJaW50IHJldDsNCj4gPiBAQCAtMTc1Nyw3ICsx
NzY2LDEwIEBAIGludCBfX2lpb19kZXZpY2VfcmVnaXN0ZXIoc3RydWN0IGlpb19kZXYgKmluZGlv
X2RldiwNCj4gPiBzdHJ1Y3QgbW9kdWxlICp0aGlzX21vZCkNCj4gPiAgCQlpbmRpb19kZXYtPnNl
dHVwX29wcyA9PSBOVUxMKQ0KPiA+ICAJCWluZGlvX2Rldi0+c2V0dXBfb3BzID0gJm5vb3Bfcmlu
Z19zZXR1cF9vcHM7DQo+ID4gIA0KPiA+IC0JY2Rldl9pbml0KCZpbmRpb19kZXYtPmNocmRldiwg
Jmlpb19idWZmZXJfZmlsZW9wcyk7DQo+ID4gKwlpZiAoaW5kaW9fZGV2LT5idWZmZXIpDQo+ID4g
KwkJY2Rldl9pbml0KCZpbmRpb19kZXYtPmNocmRldiwgJmlpb19idWZmZXJfZmlsZW9wcyk7DQo+
ID4gKwllbHNlDQo+ID4gKwkJY2Rldl9pbml0KCZpbmRpb19kZXYtPmNocmRldiwgJmlpb19ldmVu
dF9maWxlb3BzKTsNCj4gPiAgDQo+ID4gIAlpbmRpb19kZXYtPmNocmRldi5vd25lciA9IHRoaXNf
bW9kOw0KPiA+ICANCg==
