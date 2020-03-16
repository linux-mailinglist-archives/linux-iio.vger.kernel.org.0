Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21DA18677B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgCPJJL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 05:09:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51346 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730152AbgCPJJL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 05:09:11 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02G97pa8001758;
        Mon, 16 Mar 2020 05:09:10 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yrv64ndb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 05:09:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqyfRaO00Ct1oIzPTb9oDemlpdZqPM8hg5S155wzyJyk8oiWxZnp2YFFCy4IB2NpSdELs9Hfpand81jaxob5RKQY0gbBik8pnxy2xapO6X+HsY+anZdLDq/yoz/iFNGfX1RXHpTDwCaTE00sS5CKbmfuuEPIHeEmaMzrYtF6s+furO1YwJ1WGcEAYFQCadPk5O8nfe4kox1QHlh+9jWbSAee4Mm0i0D+fRTHCVCTm8AsqG3r1KScnu+6TxdDD1KQGxroPSTEr04cE8SNqBWmrUDTeFcYqUwc4VdNjUTlOvjIEfKHb3AOYlt/g+qQvm0J4ZLEyQZfyUl9tk7J4C03LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY2YoJayt4W2b/SkIDkP3OpXrJJelyeCTUkUHy9U3I8=;
 b=RcQFHK2QovxVJyhrTTjXRaWhBX2zRo8l1xWCEueyFfsmJEXbrT4GnOwBVYe6oHE7Rxe6sTxMeq8E+32PVx1KhbfsCVkWvq8qhu3dJ6XJqoqTFwtDPtc4uOJ5pYRSa98Eb2P4SG6T5tOH3n5uwlTYhxLNZdX6k3gI8x4wXxcrnQHdKjImBBGoVWEImQJ0sasrQeOxzUFYoc5DIhcZexBJGOb859euw7cbGtq01G0Rma2B2dkmi9m9o9d/T6ncu+9EjCvVuuIHPzXwaA122O4aeYzRIYbYcN59QdwXwlgyEgJvrtjPK9lGDSPEikWijnX7B1exIir2BXDQwrn0l3hD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY2YoJayt4W2b/SkIDkP3OpXrJJelyeCTUkUHy9U3I8=;
 b=6PaBP3Rx33kxdz+YzvHD73ytJIb9VQbM5FvMUMBZ8BEBY3vrGTbG/WUWMqr/UXJ4+BgiRi/FML9+Ycm3cMrX3OrQc/tsGdvGb1lVQSpbrkb4yXDzBj7t6FlpXV0BBPMzwqTgeWiTER0Ht2o+jO8RRnw5gcXO15x3EKb7vHSY+tU=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4780.namprd03.prod.outlook.com (2603:10b6:5:184::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Mon, 16 Mar
 2020 09:09:08 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 09:09:08 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH 1/8] iio: core: drop devm_iio_device_unregister() API call
Thread-Topic: [PATCH 1/8] iio: core: drop devm_iio_device_unregister() API
 call
Thread-Index: AQHV7XS+rdYEasFkQk2ytz3YniAWqqhLCi6A
Date:   Mon, 16 Mar 2020 09:09:08 +0000
Message-ID: <9a18cedd0e537927aad27001dfc5e8845d302e46.camel@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200227135227.12433-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d038c77-a3a7-4b5d-20dc-08d7c989af3a
x-ms-traffictypediagnostic: DM6PR03MB4780:
x-microsoft-antispam-prvs: <DM6PR03MB47807F430F2D507C0BF40B06F9F90@DM6PR03MB4780.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39850400004)(199004)(2906002)(478600001)(110136005)(86362001)(81166006)(6486002)(8676002)(5660300002)(26005)(316002)(186003)(81156014)(8936002)(71200400001)(4326008)(6506007)(91956017)(66556008)(66446008)(36756003)(6512007)(2616005)(66476007)(66946007)(76116006)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4780;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+1iLR3XK9iGiUYOdLKEIx6hi16rgNw6nv8X/ETSWQFyMagJhV+bHFDtxh/PR3Ex/cukqZWWFy4R6i0YJSkqC3fOAuunzfGjd6Wr4sXzy9JoKMafTvXkWrl/pN/mM2VcDDlNN27jKEqfCekW0TgWR4ZCiLINcWiB7nAZX7yc4aVJB8XN4iELp0imhXkMxnzErSvEsG1wemUduy3RX4Bk0fIfFafM6HwETUbTEkBjE64jrjlMVYMHX9X9o2NrZvon4ZdVhSy3LZ0Scs5oFfbRBDfYs/CakG7lKnrBgCiFR2yCF5/5xHzfrZ+/kZGvU8Qak0r1fJURrcmyzXlFfBYwA8tmZAfBIMcLs1bWbFLecJec1myve3C4INKHC5G4oRQoblneTfMVuPtd8OuI8hzAHGMnbmtANUo1YZIQWV1V9xdaJ6fHxIDHD5aYblRK9Fb4
x-ms-exchange-antispam-messagedata: H42gQjkNqBgRQI+bp2LbqQpGSGuQhl+3xI9LKYjj5f5X7ycXNnqLT0P6O0ZPBrvIAziRQBLc5dSjwCV5dSocRLmKSgQLIOgsafgdZqvJV6f47/GFXfGhtk1IUdDvithgHWDl3fqmWF678xiJ2txn2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0B2077D7AE1BB4F9353EA46C76B3303@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d038c77-a3a7-4b5d-20dc-08d7c989af3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 09:09:08.3049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAymBjIl49X9SzdikvF279gXlqyv3904hnAJwxWy8fH5YkEAgbB/OIgAIwScOefczJyEsIqKwWVhoctQZkyuud9VKBifYzaxqwg1mmUXjys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4780
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-16_02:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160047
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTI3IGF0IDE1OjUyICswMjAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IEl0J3MgdW51c2VkIHNvIGZhciwgc28gaXQgY2FuJ3QgYmUgcmVtb3ZlZC4gQWxzbyBt
YWtlcyBzZW5zZSB0byByZW1vdmUgaXQNCj4gdG8gZGlzY291cmFnZSB3ZWlyZCB1c2VzIG9mIHRo
aXMgY2FsbCBkdXJpbmcgcmV2aWV3Lg0KDQpBbnkgdGhvdWdodHMgb24gdGhpcz8NCkkgc3VzcGVj
dCB0aGF0IHRoaXMgbWF5IGJlIG9uZSBvZiB0aG9zZSAiSSdkIGxpa2UgdG8gc2l0IG9uIHRoaXMg
Zm9yIGEgd2hpbGUiDQpwYXRjaHNldHM/DQpXaGljaCBpcyBmaW5lLg0KQnV0IEknbSBhbHNvIHdv
bmRlcmluZyBpZiB0aGlzIGdvdCBvbWl0dGVkLg0KDQpUaGFua3MNCkFsZXgNCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9n
LmNvbT4NCj4gLS0tDQo+ICAuLi4vZHJpdmVyLWFwaS9kcml2ZXItbW9kZWwvZGV2cmVzLnJzdCAg
ICAgICAgICB8ICAxIC0NCj4gIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMgICAgICAg
ICAgICAgICAgIHwgMTcgLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvaWlvL2lp
by5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAyMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZl
ci1hcGkvZHJpdmVyLW1vZGVsL2RldnJlcy5yc3QNCj4gYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1h
cGkvZHJpdmVyLW1vZGVsL2RldnJlcy5yc3QNCj4gaW5kZXggNDZjMTM3ODA5OTRjLi4wNTgwYzY0
ZWJkZmQgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9kcml2ZXItbW9k
ZWwvZGV2cmVzLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvZHJpdmVyLW1v
ZGVsL2RldnJlcy5yc3QNCj4gQEAgLTI4Niw3ICsyODYsNiBAQCBJSU8NCj4gICAgZGV2bV9paW9f
ZGV2aWNlX2FsbG9jKCkNCj4gICAgZGV2bV9paW9fZGV2aWNlX2ZyZWUoKQ0KPiAgICBkZXZtX2lp
b19kZXZpY2VfcmVnaXN0ZXIoKQ0KPiAtICBkZXZtX2lpb19kZXZpY2VfdW5yZWdpc3RlcigpDQo+
ICAgIGRldm1faWlvX2tmaWZvX2FsbG9jYXRlKCkNCj4gICAgZGV2bV9paW9fa2ZpZm9fZnJlZSgp
DQo+ICAgIGRldm1faWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXAoKQ0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxp
by1jb3JlLmMNCj4gaW5kZXggMGIxNDY2NmRmZjA5Li5lNDAxMWY4NDMxZjkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9paW8v
aW5kdXN0cmlhbGlvLWNvcmUuYw0KPiBAQCAtMTgyMywyMyArMTgyMyw2IEBAIGludCBfX2Rldm1f
aWlvX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYsDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChfX2Rldm1faWlvX2Rldmlj
ZV9yZWdpc3Rlcik7DQo+ICANCj4gLS8qKg0KPiAtICogZGV2bV9paW9fZGV2aWNlX3VucmVnaXN0
ZXIgLSBSZXNvdXJjZS1tYW5hZ2VkIGlpb19kZXZpY2VfdW5yZWdpc3RlcigpDQo+IC0gKiBAZGV2
OglEZXZpY2UgdGhpcyBpaW9fZGV2IGJlbG9uZ3MgdG8NCj4gLSAqIEBpbmRpb19kZXY6CXRoZSBp
aW9fZGV2IGFzc29jaWF0ZWQgd2l0aCB0aGUgZGV2aWNlDQo+IC0gKg0KPiAtICogVW5yZWdpc3Rl
ciBpaW9fZGV2IHJlZ2lzdGVyZWQgd2l0aCBkZXZtX2lpb19kZXZpY2VfcmVnaXN0ZXIoKS4NCj4g
LSAqLw0KPiAtdm9pZCBkZXZtX2lpb19kZXZpY2VfdW5yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBpaW9fZGV2DQo+ICppbmRpb19kZXYpDQo+IC17DQo+IC0JaW50IHJjOw0KPiAt
DQo+IC0JcmMgPSBkZXZyZXNfcmVsZWFzZShkZXYsIGRldm1faWlvX2RldmljZV91bnJlZywNCj4g
LQkJCSAgICBkZXZtX2lpb19kZXZpY2VfbWF0Y2gsIGluZGlvX2Rldik7DQo+IC0JV0FSTl9PTihy
Yyk7DQo+IC19DQo+IC1FWFBPUlRfU1lNQk9MX0dQTChkZXZtX2lpb19kZXZpY2VfdW5yZWdpc3Rl
cik7DQo+IC0NCj4gIC8qKg0KPiAgICogaWlvX2RldmljZV9jbGFpbV9kaXJlY3RfbW9kZSAtIEtl
ZXAgZGV2aWNlIGluIGRpcmVjdCBtb2RlDQo+ICAgKiBAaW5kaW9fZGV2Ogl0aGUgaWlvX2RldiBh
c3NvY2lhdGVkIHdpdGggdGhlIGRldmljZQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9p
aW8vaWlvLmggYi9pbmNsdWRlL2xpbnV4L2lpby9paW8uaA0KPiBpbmRleCA4NjJjZTAwMTllYmEu
LjBlYjllOGQ3ZWM2OCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9paW8vaWlvLmgNCj4g
KysrIGIvaW5jbHVkZS9saW51eC9paW8vaWlvLmgNCj4gQEAgLTU5MSw5ICs1OTEsNiBAQCB2b2lk
IGlpb19kZXZpY2VfdW5yZWdpc3RlcihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KTsNCj4gICAq
IGNhbGxzIGlpb19kZXZpY2VfcmVnaXN0ZXIoKSBpbnRlcm5hbGx5LiBSZWZlciB0byB0aGF0IGZ1
bmN0aW9uIGZvciBtb3JlDQo+ICAgKiBpbmZvcm1hdGlvbi4NCj4gICAqDQo+IC0gKiBJZiBhbiBp
aW9fZGV2IHJlZ2lzdGVyZWQgd2l0aCB0aGlzIGZ1bmN0aW9uIG5lZWRzIHRvIGJlIHVucmVnaXN0
ZXJlZA0KPiAtICogc2VwYXJhdGVseSwgZGV2bV9paW9fZGV2aWNlX3VucmVnaXN0ZXIoKSBtdXN0
IGJlIHVzZWQuDQo+IC0gKg0KPiAgICogUkVUVVJOUzoNCj4gICAqIDAgb24gc3VjY2VzcywgbmVn
YXRpdmUgZXJyb3IgbnVtYmVyIG9uIGZhaWx1cmUuDQo+ICAgKi8NCj4gQEAgLTYwMSw3ICs1OTgs
NiBAQCB2b2lkIGlpb19kZXZpY2VfdW5yZWdpc3RlcihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2
KTsNCj4gIAlfX2Rldm1faWlvX2RldmljZV9yZWdpc3RlcigoZGV2KSwgKGluZGlvX2RldiksIFRI
SVNfTU9EVUxFKTsNCj4gIGludCBfX2Rldm1faWlvX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ICAJCQkgICAgICAgc3RydWN0
IG1vZHVsZSAqdGhpc19tb2QpOw0KPiAtdm9pZCBkZXZtX2lpb19kZXZpY2VfdW5yZWdpc3Rlcihz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBpaW9fZGV2DQo+ICppbmRpb19kZXYpOw0KPiAgaW50
IGlpb19wdXNoX2V2ZW50KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIHU2NCBldl9jb2RlLCBz
NjQgdGltZXN0YW1wKTsNCj4gIGludCBpaW9fZGV2aWNlX2NsYWltX2RpcmVjdF9tb2RlKHN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXYpOw0KPiAgdm9pZCBpaW9fZGV2aWNlX3JlbGVhc2VfZGlyZWN0
X21vZGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2Rldik7DQo=
