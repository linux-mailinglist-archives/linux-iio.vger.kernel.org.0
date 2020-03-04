Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D901796B3
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 18:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCDR3o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 12:29:44 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:31588 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbgCDR3o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 12:29:44 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024HKsG9022980;
        Wed, 4 Mar 2020 12:29:26 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yfnfcdgws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 12:29:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+QZ3qX4dHpFHG1f+eBbNzxSqNbb/kQxBHxKLOncw52A3CKBEO20G8LrU0uhka+G5JDtLPXg680IVobtuKCXHIOxDH3RukZXXJqQs3ep+Oe6vODDi76++IgCXwb8K3hY6C12UIg6O9gS26ooxMdBnR0PuQIItFReWCEFZG0tUv2qAwlWh6WBqCsQrP1rEm8BFYrtsZW+9Yym0czfPNdHWD1U4ZjPy+c71dLJ6l28Wpf4MtO3OvyUfBePxGB9MhrIKZ16lrOPvCkEhXnAAGSgyS29iJYQWSOGmBaRR7OGcg3QPZW65bGoZO+Itd2uIoQR6PeDVrnKSrlLvjpBbmIDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyrpTZt4elWNSb6sbZFn4/Ol9QW9yPACx03cMKER8Dw=;
 b=fpnsqVTkffejhJSdZrEKenUAtyuFQvSmqYTsOQvkY55yZMf3ylPa374x6We9a2WdFTvAuC+VwfZWIBm8XiEky9v5PwUOB3F+ZKSEQy+bwn/aPAFZzDMJ0pjgi+hYGHfZMS7kUHd8QAnhr0o4kayH9hIPxMKMHyIYRq8d8pw3GzvxbA3GUy6e0Mbzc7A40TtHdKjci5BXvshHsMZl2UV3b5X6J+MNX4AMAqC9M1IF3t6wWJtmio09rwyOnRTFEQSdZlyhgPT6MwlJWeJZNV5L9Z136RcfLBBT/F8jGmmwYd2xsv4lvEj3v/4bd8o4Sgx4wSnA2yKYRdPmNi2OwVAdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyrpTZt4elWNSb6sbZFn4/Ol9QW9yPACx03cMKER8Dw=;
 b=00iwV49kWvf5acdidxgJMOz6pIjt35Ge1MtplecaSaYtbqs8pUbzKaZvpxtn43mna9RoHEJaeGhqY79RR8atyH8oSlS/iROMPfloJh5gHgsLY6w53SIhdQVtIg/eN2fmM78ta2fXfr+IZLod6UFR1Ns1aqqZunu0CXkY0LkpXwI=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2787.namprd03.prod.outlook.com (2603:10b6:404:5b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Wed, 4 Mar
 2020 17:29:25 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 17:29:24 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/5] iio: imu: adis: Add irq mask variable
Thread-Topic: [PATCH 2/5] iio: imu: adis: Add irq mask variable
Thread-Index: AQHV69jnLEQrb+cfS0m9FTQhYRb5xqg3YFCAgAFdJ4A=
Date:   Wed, 4 Mar 2020 17:29:24 +0000
Message-ID: <0eb6b0373b13457ee6db321369c1d6217b6a6142.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
         <20200225124152.270914-3-nuno.sa@analog.com>
         <20200303204041.36a1bc6a@archlinux>
In-Reply-To: <20200303204041.36a1bc6a@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 309ce78e-ac4e-4383-8577-08d7c061958e
x-ms-traffictypediagnostic: BN6PR03MB2787:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB278721AD27E320E98891B81299E50@BN6PR03MB2787.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(316002)(86362001)(71200400001)(6916009)(54906003)(2906002)(36756003)(6512007)(6486002)(26005)(66556008)(66446008)(64756008)(66946007)(76116006)(66476007)(2616005)(478600001)(8936002)(6506007)(8676002)(186003)(81166006)(81156014)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2787;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otoIbK7A4E36s1ijYW+S7NBeyCBuOWcaSK+UPg/Pk+uqffaHUnEDVxxFLGGl9SZLK8IEYOacAXNOFSqT1jSqIuqk3q675vCS5YgXjVjrunJTBv+SV0XlO/g0M1OMtAvV25JCLoA5SiXLtHwF9W7B94m4DUqOOuaoKSVu/JUwdvS73Hy217WDfDt+OkFj4qxK46xIc6K6aTG8j91BYd4rvPe6sknRZJaDcFJYOIPMs0jfvnUVMHOEnlx6ycP1M5QKOKU0c8F6y0VAkOtCMzXMOpIw/Qlf9vXbEpZCecLr5/W4dcIHSHWtBNY7DHCsML4ZWVFE5yr7Xdvxm3FbY7lPZatHYyAJbv1MnA+bYxg17rmS8wkjtcUbt3y/40tutBbrCoH+X/e7/9DIBNp2JmxGeziuTDDtPmg4XYB81EmMxL1gzyyVKQMbxBZQAlQNXULZ
x-ms-exchange-antispam-messagedata: AhxVzFo6RdMBOFppttPOHuL1VkK25gD5q/0I1eDDHNg/eyJNR7Kn7nG8ok80bZjuBepOtF5lSIyrL8Us+Q4BUrq6PxolLYqnLkaQ6yQa3VGtAf5z8M5Ut2xaXNWMvbhItTdeUODig6SVk46rWughbQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2693DDB312C3C4288F2594A4E3EC198@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309ce78e-ac4e-4383-8577-08d7c061958e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 17:29:24.8601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+ovyhkWKCEYpNMCd8EXpbQD2XqWyO2IMQlhQbCAk7aUa/uuBU3cu7AU2mVxX+t10xvblwWouLn6RqlTqqaP8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003040122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDIwOjQwICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDI1IEZlYiAyMDIwIDEzOjQxOjQ5ICswMTAwDQo+IE51bm8gU8OhIDxudW5v
LnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGVyZSBhcmUgc29tZSBBRElTIGRldmlj
ZXMgdGhhdCBjYW4gY29uZmlndXJlIHRoZSBkYXRhIHJlYWR5IHBpbg0KPiA+IHBvbGFyaXR5LiBI
ZW5jZSwgd2UgY2Fubm90IGhhcmRjb2RlIG91ciBJUlEgbWFzayBhcw0KPiA+IElSUUZfVFJJR0dF
Ul9SSVNJTkcNCj4gPiBzaW5jZSB3ZSBtaWdodCB3YW50IHRvIGhhdmUgaXQgYXMgSVJRRl9UUklH
R0VSX0ZBTExJTkcuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FA
YW5hbG9nLmNvbT4NCj4gDQo+IE1pc3NpbmcgZG9jcyBmb3IgdGhlIGFkZGl0aW9uIHRvIHN0cnVj
dCBhZGlzLg0KPiANCj4gT3RoZXJ3aXNlLCBsb29rcyBnb29kIHRvIG1lLg0KDQpHb3QgaXQuDQoN
Ci0gTnVubyBTw6ENCj4gdGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvaWlvL2ltdS9hZGlzX3RyaWdnZXIuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ID4gIGluY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmggICB8ICAxICsNCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvYWRpc190cmlnZ2VyLmMNCj4gPiBiL2Ry
aXZlcnMvaWlvL2ltdS9hZGlzX3RyaWdnZXIuYw0KPiA+IGluZGV4IGEwN2RjYzM2NWMxOC4uYWU1
YTRmNjY3NTJmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzX3RyaWdnZXIu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzX3RyaWdnZXIuYw0KPiA+IEBAIC0zNCw2
ICszNCwyMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYWRpc190cmlnZ2VyX3NldHVwKHN0cnVjdA0K
PiA+IGFkaXMgKmFkaXMpDQo+ID4gIAlpaW9fdHJpZ2dlcl9zZXRfZHJ2ZGF0YShhZGlzLT50cmln
LCBhZGlzKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIGlubGluZSBpbnQgX19hZGlzX3Zh
bGlkYXRlX2lycV9tYXNrKHN0cnVjdCBhZGlzICphZGlzKQ0KPiA+ICt7DQo+ID4gKwlpZiAoIWFk
aXMtPmlycV9tYXNrKSB7DQo+ID4gKwkJYWRpcy0+aXJxX21hc2sgPSBJUlFGX1RSSUdHRVJfUklT
SU5HOw0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsJfSBlbHNlIGlmIChhZGlzLT5pcnFfbWFzayAh
PSBJUlFGX1RSSUdHRVJfUklTSU5HICYmDQo+ID4gKwkJICAgYWRpcy0+aXJxX21hc2sgIT0gSVJR
Rl9UUklHR0VSX0ZBTExJTkcpIHsNCj4gPiArCQlkZXZfZXJyKCZhZGlzLT5zcGktPmRldiwgIklu
dmFsaWQgSVJRIG1hc2s6JTA4bHhcbiIsDQo+ID4gKwkJCWFkaXMtPmlycV9tYXNrKTsNCj4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAr
fQ0KPiA+ICAvKioNCj4gPiAgICogYWRpc19wcm9iZV90cmlnZ2VyKCkgLSBTZXRzIHVwIHRyaWdn
ZXIgZm9yIGEgYWRpcyBkZXZpY2UNCj4gPiAgICogQGFkaXM6IFRoZSBhZGlzIGRldmljZQ0KPiA+
IEBAIC01NCw5ICs2OCwxMyBAQCBpbnQgYWRpc19wcm9iZV90cmlnZ2VyKHN0cnVjdCBhZGlzICph
ZGlzLCBzdHJ1Y3QNCj4gPiBpaW9fZGV2ICppbmRpb19kZXYpDQo+ID4gIA0KPiA+ICAJYWRpc190
cmlnZ2VyX3NldHVwKGFkaXMpOw0KPiA+ICANCj4gPiArCXJldCA9IF9fYWRpc192YWxpZGF0ZV9p
cnFfbWFzayhhZGlzKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiAr
DQo+ID4gIAlyZXQgPSByZXF1ZXN0X2lycShhZGlzLT5zcGktPmlycSwNCj4gPiAgCQkJICAmaWlv
X3RyaWdnZXJfZ2VuZXJpY19kYXRhX3JkeV9wb2xsLA0KPiA+IC0JCQkgIElSUUZfVFJJR0dFUl9S
SVNJTkcsDQo+ID4gKwkJCSAgYWRpcy0+aXJxX21hc2ssDQo+ID4gIAkJCSAgaW5kaW9fZGV2LT5u
YW1lLA0KPiA+ICAJCQkgIGFkaXMtPnRyaWcpOw0KPiA+ICAJaWYgKHJldCkNCj4gPiBAQCAtOTUs
OSArMTEzLDEzIEBAIGludCBkZXZtX2FkaXNfcHJvYmVfdHJpZ2dlcihzdHJ1Y3QgYWRpcyAqYWRp
cywNCj4gPiBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICANCj4gPiAgCWFkaXNfdHJp
Z2dlcl9zZXR1cChhZGlzKTsNCj4gPiAgDQo+ID4gKwlyZXQgPSBfX2FkaXNfdmFsaWRhdGVfaXJx
X21hc2soYWRpcyk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0K
PiA+ICAJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgmYWRpcy0+c3BpLT5kZXYsIGFkaXMtPnNwaS0+
aXJxLA0KPiA+ICAJCQkgICAgICAgJmlpb190cmlnZ2VyX2dlbmVyaWNfZGF0YV9yZHlfcG9sbCwN
Cj4gPiAtCQkJICAgICAgIElSUUZfVFJJR0dFUl9SSVNJTkcsDQo+ID4gKwkJCSAgICAgICBhZGlz
LT5pcnFfbWFzaywNCj4gPiAgCQkJICAgICAgIGluZGlvX2Rldi0+bmFtZSwNCj4gPiAgCQkJICAg
ICAgIGFkaXMtPnRyaWcpOw0KPiA+ICAJaWYgKHJldCkNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9paW8vaW11L2FkaXMuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9paW8vaW11L2FkaXMu
aA0KPiA+IGluZGV4IDc0MTUxMmIyOGFhYS4uYjRjMzVkMTM3ZTJhIDEwMDY0NA0KPiA+IC0tLSBh
L2luY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lp
by9pbXUvYWRpcy5oDQo+ID4gQEAgLTg0LDYgKzg0LDcgQEAgc3RydWN0IGFkaXMgew0KPiA+ICAJ
c3RydWN0IHNwaV9tZXNzYWdlCW1zZzsNCj4gPiAgCXN0cnVjdCBzcGlfdHJhbnNmZXIJKnhmZXI7
DQo+ID4gIAl1bnNpZ25lZCBpbnQJCWN1cnJlbnRfcGFnZTsNCj4gPiArCXVuc2lnbmVkIGxvbmcJ
CWlycV9tYXNrOw0KPiANCj4gVGhpcyBzdHJ1Y3R1cmUgaGFzIGtlcm5lbC1kb2MuIFBsZWFzZSBh
ZGQgdGhpcyBuZXcgZWxlbWVudC4NCj4gDQo+ID4gIAl2b2lkCQkJKmJ1ZmZlcjsNCj4gPiAgDQo+
ID4gIAl1aW50OF90CQkJdHhbMTBdIF9fX19jYWNoZWxpbmVfYWxpZ25lZDsNCg0K
