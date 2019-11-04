Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E682FEE358
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfKDPP5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:15:57 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56970 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfKDPP5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:15:57 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4FA86q010753;
        Mon, 4 Nov 2019 10:15:53 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rhk6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:15:53 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FArEE011076;
        Mon, 4 Nov 2019 10:15:52 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rhk6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:15:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPAR9ADKAJrued+3OhTOU9Epbkb4jCu9fYjZ45lZBdNgi8dlA5OCLorZE4G3wK0KPUJgwDDjBgmCAxo4dBCgGQ98snO5r6uyqLZ8DBezBuHrHAeccrYzRJj/lWdA2Ax0rWDsXt7RKULmq2J/KmNTcv9oM7Xr3WJAJgVJX7IrjkiChKOQ4zuBPHYbC+LMqy3bZGOEZ8Q4YU1VFH7UCnsGyo7CjWORoBcCUPdtseZzi5Zt5TFaOfSDWwt5Br7dkp0EEsco2ixcweMQxn6B7bRwFf9ETaZRznUpqmrJ14TexFWtWJrsSZd6N2bQF/WGLCkChlFMmbS8bLKNCQzZ/lBOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1+OVsS6bAuouOLmdn+mwRjrm+/EX6nnl4LBg/XYbYk=;
 b=fgJQA8XgzF+gleJYnaGhibNRrcvgRn/L0/pOmFLbbTgrIUy3Au98cr3QbMfmv2K8ORyG++Je1s9KFsW7JHsjhAkR630mS4ROJGMqaykkODcCmWcTLRZ6xp1QXUgAbdN0mJ7TJXCRCFT+6usF0Qy3c8rXxAYocyzEUJNJGqWJUuuQD0Dmy4oprFegKNk/FZ7eyk4GZq+B1wWWXXom7q61Vr+A+cB1XbBb8tH97+jB50ACL3mI56rPGUVVh8yPnzxSRwhLeF/Fy4upQ5e6kXbZcTIu0p+cWCH0KyOc0clm/pUUnsdBne7deBYedQiwhPgdL/IbuXHqa5GVHLxQUs6vgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1+OVsS6bAuouOLmdn+mwRjrm+/EX6nnl4LBg/XYbYk=;
 b=05habrGRJ1dAsOqW/B+PgYH3hxllb1gkLoYAcNl4v4qd+3uFUXolO54efPIkvVKoFtBbhXNmWzMABSaHH2rym3oxbfqIAdx5LAGiKvG4qdx50KD03pJxjAIvv5rUVOrYTq0s7iokQyxgbfvIRSgz6ypiRyDDGUXCetHD96rZwrk=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5224.namprd03.prod.outlook.com (20.180.13.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:15:51 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:15:50 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "naidu.tellapati@imgtec.com" <naidu.tellapati@imgtec.com>
Subject: Re: [PATCH] iio: adc: cc10001: use devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: adc: cc10001: use devm_platform_ioremap_resource
Thread-Index: AQHVgcGXc6dorkgFVUuI78Y8DKXNO6d7QfgA
Date:   Mon, 4 Nov 2019 15:15:50 +0000
Message-ID: <882478ce1c7e6f6b857231b19b9e15c05f7c943c.camel@analog.com>
References: <20191013122512.1793656-1-jic23@kernel.org>
In-Reply-To: <20191013122512.1793656-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edd9d6c2-2b68-4dec-b6a1-08d76139e0df
x-ms-traffictypediagnostic: CH2PR03MB5224:
x-microsoft-antispam-prvs: <CH2PR03MB52244BDC69A1115F52A192B7F97F0@CH2PR03MB5224.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:556;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(6116002)(3846002)(76116006)(66476007)(66556008)(66446008)(66946007)(256004)(2906002)(64756008)(99286004)(26005)(6506007)(102836004)(305945005)(2616005)(54906003)(2501003)(14444005)(316002)(76176011)(446003)(11346002)(118296001)(110136005)(36756003)(71200400001)(71190400001)(86362001)(478600001)(14454004)(6512007)(186003)(229853002)(6486002)(7736002)(486006)(476003)(4326008)(5660300002)(25786009)(8676002)(8936002)(81156014)(81166006)(6436002)(66066001)(6246003)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5224;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6e8uSBb0YiM0anclYyhtih48dzDdTbl7wmIonW/rA+Yd7nu1zUSa2QW8qNobJt4FxbYp9GB78nudf0KbspDqyrywML9GEwR55DSbrJXVuHCcCxgc2UNnrhH4mlBpG4NQHJOxUH/qAJbUHmzRf6pjoCzpdcp3ZzxiyBVTTrLIFHe1LIAFR7r0cQIGe8wmx0TTXsFcyC192e1Db6Q59GTTwkaG/tKhqQm4/RNqydQul/w+oSGg8hFEruH9EORrHXsR0b08n3rfNZ4vvFl7ruW1ItowAUx4qslenuYFM6Bd2Sgq85P8UAdnEsoUYs24sLsd6YtM3PcpGi+9SlyBA4c+i8QMwgpEjrIPkv5ElSjABT5TA0kRuXSc648D0dwJipWX4LKi7fJq8Z36ojEHOwB7s9HAUri6xqeMwSuzsk9iUW6Vua+4OhhBSXfpsWFJ8Ml
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CB47020E0F47645ABC643B9DBD832B6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd9d6c2-2b68-4dec-b6a1-08d76139e0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:15:50.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJTsHfV6yJc9PAHHarHJ8CtNq0p3DICmGGlV85lUXgfRAqZzmNEXnfYLjmpi6MgiCcm4QkTpEUJ5NwX85TSJAUhKZ2JKt4Jg2u0XyGhbRGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5224
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040151
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDEzOjI1ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBSZWR1Y2VzIGxvY2FsIGJvaWxlcnBsYXRlLg0KPiBGb3VuZCBieSBjb2NjaW5lbGxl
Og0KPiANCj4gZHJpdmVycy9paW8vYWRjL2NjMTAwMDFfYWRjLmM6MzQ0OjEtMTg6IFdBUk5JTkc6
IFVzZQ0KPiBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UgZm9yIGFkY19kZXYgLT4gcmVn
X2Jhc2UNCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5h
cmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24g
PEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gQ2M6IE5haWR1IFRlbGxhcGF0aSA8bmFp
ZHUudGVsbGFwYXRpQGltZ3RlYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2NjMTAw
MDFfYWRjLmMgfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvY2MxMDAwMV9h
ZGMuYw0KPiBiL2RyaXZlcnMvaWlvL2FkYy9jYzEwMDAxX2FkYy5jDQo+IGluZGV4IGY5M2YxZDkz
YjgwZC4uZmU5MjU3NjI0ZjE2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvY2MxMDAw
MV9hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvY2MxMDAwMV9hZGMuYw0KPiBAQCAtMzEw
LDcgKzMxMCw2IEBAIHN0YXRpYyBpbnQgY2MxMDAwMV9hZGNfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZQ0KPiAqcGRldikNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBwZGV2LT5k
ZXYub2Zfbm9kZTsNCj4gIAlzdHJ1Y3QgY2MxMDAwMV9hZGNfZGV2aWNlICphZGNfZGV2Ow0KPiAg
CXVuc2lnbmVkIGxvbmcgYWRjX2Nsa19yYXRlOw0KPiAtCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0K
PiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7DQo+ICAJdW5zaWduZWQgbG9uZyBjaGFubmVs
X21hcDsNCj4gIAlpbnQgcmV0Ow0KPiBAQCAtMzQwLDggKzMzOSw3IEBAIHN0YXRpYyBpbnQgY2Mx
MDAwMV9hZGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAlpbmRp
b19kZXYtPmluZm8gPSAmY2MxMDAwMV9hZGNfaW5mbzsNCj4gIAlpbmRpb19kZXYtPm1vZGVzID0g
SU5ESU9fRElSRUNUX01PREU7DQo+ICANCj4gLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAtCWFkY19kZXYtPnJlZ19iYXNlID0gZGV2bV9p
b3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ICsJYWRjX2Rldi0+cmVnX2Jhc2Ug
PSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ICAJaWYgKElTX0VS
UihhZGNfZGV2LT5yZWdfYmFzZSkpIHsNCj4gIAkJcmV0ID0gUFRSX0VSUihhZGNfZGV2LT5yZWdf
YmFzZSk7DQo+ICAJCWdvdG8gZXJyX2Rpc2FibGVfcmVnOw0K
