Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF8E98F8
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2019 10:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfJ3JNi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Oct 2019 05:13:38 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:7502 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfJ3JNi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Oct 2019 05:13:38 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9U97gTL028439;
        Wed, 30 Oct 2019 05:13:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwgw96v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 05:13:35 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id x9U9Bweb031798;
        Wed, 30 Oct 2019 05:13:35 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwgw96v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 05:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViHGVHNrxThacTeQ607r850mjchgwnHGdhxggXu1uml3fq4ulmJgrxH0PXoZTZU4CX7v33KDkFYJG+cUs94KfL4HbNpxGwAmzqZRMFH1hJoWH+RxxGCzfdmm3VAmhyYccSuprnk7BW8WOcWFjtQmCJwYYNszjzwbj3dKJZDZZfkdAEtLPYSgJw3RLqkHFSjx+TUzJO7gTgER/f7lXi8biMlYUlb3Iji+BsAON11TaCIBhF6Ae2COmhdD4VNMksFrEfx2CSbs6xT5VaR8/DCVIyJ7VHbvxUnheSs8R1sNexatEG8BzJFXTUCb2mYgWiIRVnhn+hCZi2xXxDVQlug9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCiFTRvd7YEy0zVsuH2Myr5fPjTF4rt5WO+cO6OF2Ak=;
 b=fcJXQJhFe8QME1eYv8DUjN9jbKYvjNiXs4iRaLdN/FiwM+7yCc//Vm6cCwtcteQOWeHYa8MrSN9E8XCcO/UNQlefZfuGFJJVPo8XwlQ6Aoh4o3xVMURqWkW6lGErv06Cm5Mgofk/hMfKdcN+2izJS0U+i2O2YiLB7qJksoK3O0znTXjOypBcuj8cmosG5Zy0lfSYsWpJGHJuqql3ewTQaJEbOIcOIwxZwdWs/bDJTicL74eR2JBGpgeI/lS6y2qFGHkOJXsTBSeRzYhDEg6rmGnQmlkRxwWFwcDlv0ll24lTCD8Cx12RZp+sXfAxdmgMfVDcK3jZWePYdxRX778Pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCiFTRvd7YEy0zVsuH2Myr5fPjTF4rt5WO+cO6OF2Ak=;
 b=wmVtkyKbhdo8VB/nfPYKIAVT7orXLkmv4Xqd266mv/Hm0m2XdFzxamseloPM3E2ecZjvRSyxYxcEUzf/MfsnnRCTzepfgDeWl0NwWDYbkdtD+ZaAQSpRu2LfynmWwIIiITitHXlnd2o4AfqYOL3EqfCCod3AmTk8YiYLHILjQp4=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5157.namprd03.prod.outlook.com (20.180.15.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 09:13:33 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 09:13:33 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Thread-Topic: [PATCH 1/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Thread-Index: AQHVjvtrBj5Qf5upT0iyFDGx/fmGzady5qIA
Date:   Wed, 30 Oct 2019 09:13:33 +0000
Message-ID: <fb8722ad2c1ef51944dc814a7b24433f4348721e.camel@analog.com>
References: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>
         <1572423581-59762-2-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1572423581-59762-2-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 800642f6-c8d1-4060-d372-08d75d197067
x-ms-traffictypediagnostic: CH2PR03MB5157:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB51574C2B0E933EEDECB2DA0FF9600@CH2PR03MB5157.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(229853002)(4326008)(118296001)(6246003)(8676002)(66476007)(66066001)(76176011)(54906003)(6506007)(66946007)(6512007)(4001150100001)(102836004)(36756003)(26005)(110136005)(186003)(99286004)(66446008)(6116002)(5660300002)(8936002)(7736002)(76116006)(81156014)(6486002)(305945005)(3846002)(66556008)(64756008)(86362001)(81166006)(6436002)(486006)(2906002)(256004)(71190400001)(11346002)(476003)(25786009)(446003)(71200400001)(2616005)(316002)(14454004)(478600001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5157;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lbcxVcs+FJvi4gy0+gU2ml5c0oFo0KJ62yufZFMrmXb9fQMsixjLvw/xL/KCqYE9T1YEIzIZAnp8hD8KcVMkhZW1b4cJQvZ7GPlWE1huXPNp+YiLB2t+9BTnOnuJ9asKWYBQ8AGm0z6BJHcSc6rci62s/KtFFP/+OSY3UfmDxNWPvCmP9ml5R2CSWRgnd+p0vrHsdQZwF/pnb1ZxsdGek5Y6Ij1voc/7nBvQywECkRei6mv4bY5/ksMHYupLK9+m5ZL811dqr3YQaQzBKk5Pfd2GA1gZ8a9lvtsaMessecrpX4wC/QEd+vI2QeaBX8aoyPsM0qZMXPVvQeExknNxlUOrWyNIA2s0NDwpjo2pvjxFHTH5t+Qiz4X3pUtgl2SFAEUcJmBJJEN5Qslfu2sWLOySJhWplWFvMcOwP9N70vpUU8jzNG6Uko1VHx0RR+5B
Content-Type: text/plain; charset="utf-8"
Content-ID: <712253D854665B4AA4C96780B13CC775@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800642f6-c8d1-4060-d372-08d75d197067
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 09:13:33.6656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzGBwJKOM2rBwayeu59E4i3HZXn3MyKGvvpL1mTmh1sCa9wXcamS+HGDfbXThrIdgL6zpg80tsczh+6YJuYuC2Q4QtR/KDT/q27CIdFoK+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5157
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_04:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910300092
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTMwIGF0IDE2OjE5ICswODAwLCB6aG9uZyBqaWFuZyB3cm90ZToNCj4g
W0V4dGVybmFsXQ0KPiANCj4gSXQgaXMgbW9yZSBjbGVhciB0byB1c2UgREVGSU5FX0RFQlVHRlNf
QVRUUklCVVRFIHRvIGRlZmluZSBkZWJ1Z2ZzIGZpbGUNCj4gb3BlcmF0aW9uIHJhdGhlciB0aGFu
IERFRklORV9TSU1QTEVfQVRUUklCVVRFLg0KDQpOb3Qgc3VyZSBpZiAibW9yZSBjbGVhciIgaXMg
dGhlIHdvcmQuDQpCdXQgaXQgaXMgbW9yZSBjb3JyZWN0IHRvIHVzZSBERUZJTkVfREVCVUdGU19B
VFRSSUJVVEUoKSwgc2luY2UgdGhleSBhcmUNCmRlYnVnZnMgYXR0cnMuDQoNCkluIGFueSBjYXNl
LCB0aGlzIGlzIG5vIGJpZyBkZWFsLg0KU286DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJk
ZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiB6aG9uZyBqaWFuZyA8emhvbmdqaWFuZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvaWlvL2ltdS9hZGlzMTY0NjAuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aWlvL2ltdS9hZGlzMTY0NjAuYyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NjAuYw0KPiBpbmRl
eCA2YWVkOWU4Li4yZTdhNTgyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2
NDYwLmMNCj4gKysrIGIvZHJpdmVycy9paW8vaW11L2FkaXMxNjQ2MC5jDQo+IEBAIC04Nyw3ICs4
Nyw3IEBAIHN0YXRpYyBpbnQgYWRpczE2NDYwX3Nob3dfc2VyaWFsX251bWJlcih2b2lkICphcmcs
IHU2NA0KPiAqdmFsKQ0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IC1ERUZJTkVfU0lNUExF
X0FUVFJJQlVURShhZGlzMTY0NjBfc2VyaWFsX251bWJlcl9mb3BzLA0KPiArREVGSU5FX0RFQlVH
RlNfQVRUUklCVVRFKGFkaXMxNjQ2MF9zZXJpYWxfbnVtYmVyX2ZvcHMsDQo+ICAJYWRpczE2NDYw
X3Nob3dfc2VyaWFsX251bWJlciwgTlVMTCwgIjB4JS40bGx4XG4iKTsNCj4gIA0KPiAgc3RhdGlj
IGludCBhZGlzMTY0NjBfc2hvd19wcm9kdWN0X2lkKHZvaWQgKmFyZywgdTY0ICp2YWwpDQo+IEBA
IC0xMDUsNyArMTA1LDcgQEAgc3RhdGljIGludCBhZGlzMTY0NjBfc2hvd19wcm9kdWN0X2lkKHZv
aWQgKmFyZywgdTY0DQo+ICp2YWwpDQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gLURFRklO
RV9TSU1QTEVfQVRUUklCVVRFKGFkaXMxNjQ2MF9wcm9kdWN0X2lkX2ZvcHMsDQo+ICtERUZJTkVf
REVCVUdGU19BVFRSSUJVVEUoYWRpczE2NDYwX3Byb2R1Y3RfaWRfZm9wcywNCj4gIAlhZGlzMTY0
NjBfc2hvd19wcm9kdWN0X2lkLCBOVUxMLCAiJWxsdVxuIik7DQo+ICANCj4gIHN0YXRpYyBpbnQg
YWRpczE2NDYwX3Nob3dfZmxhc2hfY291bnQodm9pZCAqYXJnLCB1NjQgKnZhbCkNCj4gQEAgLTEy
Myw3ICsxMjMsNyBAQCBzdGF0aWMgaW50IGFkaXMxNjQ2MF9zaG93X2ZsYXNoX2NvdW50KHZvaWQg
KmFyZywgdTY0DQo+ICp2YWwpDQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gLURFRklORV9T
SU1QTEVfQVRUUklCVVRFKGFkaXMxNjQ2MF9mbGFzaF9jb3VudF9mb3BzLA0KPiArREVGSU5FX0RF
QlVHRlNfQVRUUklCVVRFKGFkaXMxNjQ2MF9mbGFzaF9jb3VudF9mb3BzLA0KPiAgCWFkaXMxNjQ2
MF9zaG93X2ZsYXNoX2NvdW50LCBOVUxMLCAiJWxsZFxuIik7DQo+ICANCj4gIHN0YXRpYyBpbnQg
YWRpczE2NDYwX2RlYnVnZnNfaW5pdChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0K
