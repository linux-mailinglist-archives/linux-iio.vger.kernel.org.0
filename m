Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391CD1467BD
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2020 13:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgAWMQY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jan 2020 07:16:24 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18548 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgAWMQY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jan 2020 07:16:24 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NCAXfC006081;
        Thu, 23 Jan 2020 07:16:04 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xkvnfnn80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 07:16:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnxxAUSlxQpLPtysdFcThDKdo5qk4Mp0MAmaS0GZlke1F09SnqgjfRT3wg9yw1KLp5KSFaRpDqcI1wkYDb9v9cGQ2bXIFJmlnzmLIvAdc47wqf4LoKHz6xLIcr63lF8irCIJZPono4c3yIsRmFnZKj7d+jpuRpP4gxJfZYJh64hjEyrBVMPJRkXyogfuW7sGvceYdHOuvIIkFjPnOKucewkjbGLivXdgcMEBUtduavREQve44WldIZm2YB0cwSg2o0UMWVoUSqZEalrzPXDP3GMt3P2E5mmQG+qJZeTjsEaQtOQnSr4KFhGISMxijbW0we1k3b+v3phcL+JWoK6XYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3K/vK92riidWeUCR96kAdqloUtnTdU4FLOt1dJlXzk=;
 b=Ic/e3A8iM7X9N175fLePLX9W1PjY6VrzgsxJk6c8UPmStG8DcMZVn5+ezBRFhRQzcb60jt4u6KT4NlrmGN5wUHsGt1kSHSUOmj0Q/NFI7Ab7S5Aajc5efgZ6gAXCWndcVvaJA1H8IP/EnkluobrFGO66aB4nWM1hx+YM0cTjfSmF3E3UDYSdEteHx1J3vAK/5gMJMJDoxpwSzi81bFoLcxVmB+UG64RbD1xWNLvk9S8PucLIPxgAAgDiTBPO8tXhNVK8LDLOMCNvxSS2S7IoZwheSyKETcxYqxxucogFfb6aCxj27urLpJF0VGvCRvtUSb8F8OhPp9hKZdgtaqpgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3K/vK92riidWeUCR96kAdqloUtnTdU4FLOt1dJlXzk=;
 b=6R+2t5ZSPJ6+0Kt4eaYx5Ar8BiTXJh0uEdIeR00JioXyXoV/ZgxmRZ91yq/BvoRXRNZzyGxqMZV1CoLUwpZtEXi1AFwRiUN7o3L5Q2i1iODbUGgPzoZbNlC/uiR5vQKzAQO4C5/v+9c3I8vfmytN7WVVv7FKJNvRShBKMTT/HF0=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5174.namprd03.prod.outlook.com (20.180.4.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 23 Jan 2020 12:16:03 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 12:16:03 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "zzzzPopa, zzzzStefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2] iio: ad5755: fix spelling mistake "to" -> "too" and
 grammar
Thread-Topic: [PATCH][V2] iio: ad5755: fix spelling mistake "to" -> "too" and
 grammar
Thread-Index: AQHV0c5ZypUSLkSV6060pzkn0y8YJ6f4KskA
Date:   Thu, 23 Jan 2020 12:16:03 +0000
Message-ID: <aae729269a5ab110fae379f88b72a8cbca6c8b13.camel@analog.com>
References: <20200123091954.10506-1-colin.king@canonical.com>
In-Reply-To: <20200123091954.10506-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4085ad4-785a-46eb-97b4-08d79ffe03ed
x-ms-traffictypediagnostic: CH2PR03MB5174:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB51744D781A41F1AC9F07B11AF90F0@CH2PR03MB5174.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(4744005)(5660300002)(81156014)(36756003)(8676002)(2906002)(81166006)(4326008)(6512007)(8936002)(54906003)(86362001)(2616005)(6506007)(186003)(316002)(26005)(110136005)(66476007)(478600001)(76116006)(66556008)(64756008)(6486002)(71200400001)(66946007)(66446008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5174;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iK1fX5QrPMhVLl7cR6DjlwAjM3rTEG+KbjXVV2D21Ad6wCr93UcHG5Rh5g9C7l1EW+hBF5IOhcR3yLbwDXrle1k0yZv1VIEe0JgZpMupIxGyiHCsAW48HpwseJ8wnPnu0D6e3aB8EnTsLAta+QM5XrI6QRMmG/W9bB8B+QYd8tsd/bysrLe6vaxkoRDEilz0IfVmq8kmd4Ug0+vZt57imK567ldwSC0R9Hxu0UhwR5J45VT8G1yu6k8E0xojRtP6YdRrtLi4eeZ5iJdAIc11nYJ7mw3+AdoyRGSKAssQWDFeWfbynDPHZJaSjywysm+9xgEkvIVISaf1iuxyJHr+xke6EqyhfDlkN3L5rLb6TbDif0qHx2/Bvn0Gjc3/++GWyRVZCZYrGEhTMzCa/fyrkHOb2mcD9+RtTK4DV4V8Gzghn1Cz3QvRPOi8KoffSljf39D5det+yYxvuk6XcEFPDKt8qPz954ivtURNLLxKkOE0XXR89sI2GLchHJr5LtVg
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DF19E837EB5674EA591FB0A5C9060EE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4085ad4-785a-46eb-97b4-08d79ffe03ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 12:16:03.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFZmEOfsHZxjUVvAIv3P8qfLpNR0b4rIwrvKoNYnDUK/Brbmtep99UZcBI5W5Y5ek5UEWnEtdNNJjTR0DaZpDelcQJqwvnjIyDDUjHEwoGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5174
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_08:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTIzIGF0IDA5OjE5ICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBG
cm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVGhl
cmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGFuZCBncmFtbWFyIG1pc3Rha2UgaW4gYSBkZXZfZXJy
DQo+IG1lc3NhZ2UuIEZpeCBpdC4NCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxl
YW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IENv
bGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IC0tLQ0KPiBWMjogZml4
IGdyYW1tYXIgdG9vLCB0aGFua3MgdG8gQWxleGFuZHJ1IEFyZGVsZWFuIGZvciBzcG90dGluZyB0
aGlzLg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2RhYy9hZDU3NTUuYyB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL2RhYy9hZDU3NTUuYyBiL2RyaXZlcnMvaWlvL2RhYy9hZDU3NTUuYw0K
PiBpbmRleCBiOTE3NWZiNGM4YWIuLjEzNTlhMWE5MmZkYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9paW8vZGFjL2FkNTc1NS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2RhYy9hZDU3NTUuYw0KPiBA
QCAtNjU1LDcgKzY1NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYWQ1NzU1X3BsYXRmb3JtX2RhdGEgKmFk
NTc1NV9wYXJzZV9kdChzdHJ1Y3QNCj4gZGV2aWNlICpkZXYpDQo+ICAJZm9yX2VhY2hfY2hpbGRf
b2Zfbm9kZShucCwgcHApIHsNCj4gIAkJaWYgKGRldm5yID49IEFENTc1NV9OVU1fQ0hBTk5FTFMp
IHsNCj4gIAkJCWRldl9lcnIoZGV2LA0KPiAtCQkJCSJUaGVyZSBpcyB0byBtYW55IGNoYW5uZWxz
IGRlZmluZWQgaW4gRFRcbiIpOw0KPiArCQkJCSJUaGVyZSBhcmUgdG9vIG1hbnkgY2hhbm5lbHMg
ZGVmaW5lZCBpbiBEVFxuIik7DQo+ICAJCQlnb3RvIGVycm9yX291dDsNCj4gIAkJfQ0KPiAgDQo=
