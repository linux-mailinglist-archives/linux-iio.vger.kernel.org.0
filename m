Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7DB8B3C
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 08:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfITGrG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 02:47:06 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:12158 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730573AbfITGrF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 02:47:05 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8K6ggrI025997;
        Fri, 20 Sep 2019 02:46:39 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2053.outbound.protection.outlook.com [104.47.50.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v3vb5v78d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 02:46:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7ltP3SOyhFYVpBPxUI/HdYdTj2FJ3qzYVTQJ5+vKz+jg5AsfRfTcyl6cfLBCnhTE4u6kEWwtMnYCkaiMKAgJNej8R47zhDVnwwR6lyRYYuAYZMCgOT++qCEWRwXGuC/DpHPmPfigSG+ii9QAk6OvxhplmUNg0Zb0UUd7Rzt/yZvXnDqdl1mWDYm/4Hm9Vga1ROs0m5u0HypIHxG2oPwa8IM//E6CIW+MfNDh4Q8PUXzX5/GgcKn/OfogYfE7ObUpbS7xzqzYc0rPFz5YGTzWodPdO9f8AR2PHC6NORDbQULk66Wvgzu/SE2+FfiYUD8Dbmu5wo323PPT+n84kRbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T93xBT4Q/lfZZOaqlADSfBvRAWeEoU/P7nr4oLWTShc=;
 b=GhyD+vxUjGe0YHI4qNo6JhampiSfZypWXPzIthk/AHPN+7e90u7+tugCf2A2qPDb9M6+zkNAlPBf3izSpUyKHOLgp/HSQ6FjJEhPnRPI529d6XNsPT5qjUbPsrv1Qq32Icvtusja1paBl3obO2Bkqk/JM2SjyGb4eVWVeAJOBs6c59D0NgmFsiEivx+ffmG41pidY0sJWoc9Pik9SysLGmbEFXsNI2CTCOYEIISR5WpNLUCfha+4mt3hlIbya25PRqiaRgyqhwkDmBnvPL1LuDE+AoXHLD9jBXnBblnF4f5n93v2fD1SIUEFpxUZdisp78l+A6A9IqLWG4srNnsCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T93xBT4Q/lfZZOaqlADSfBvRAWeEoU/P7nr4oLWTShc=;
 b=ztuwM8hEx+K317iwgfE8bw0Fikgd3sjrDbicPtzx5/xbBUcBWPb7wq+Ccm7NGEzvNHpEyOS6kgZgnngT5j0HpSQNNcIMtQ5RPel6PwqZmB1V8EHY9vo51Jx6nD1hZ8vd4rXkZwtW7N+QJubFOxovBQUdyavrwlOfEbLE1DsgdXw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5352.namprd03.prod.outlook.com (20.180.15.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 06:46:37 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 06:46:37 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "navid.emamdoost@gmail.com" <navid.emamdoost@gmail.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: imu: adis16400: release allocated memory on
 failure
Thread-Topic: [PATCH v2] iio: imu: adis16400: release allocated memory on
 failure
Thread-Index: AQHVbwH5BsBQwO6N20Wr9QA5NPYEMKc0Uo6A
Date:   Fri, 20 Sep 2019 06:46:37 +0000
Message-ID: <d4c21c74d88e542771818720e6270e4d6141b686.camel@analog.com>
References: <84e2832b52cc88665ff071942c1545b83eeb5602.camel@analog.com>
         <20190919155003.2207-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190919155003.2207-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ccc4d13-633e-4300-892e-08d73d964907
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5352;
x-ms-traffictypediagnostic: CH2PR03MB5352:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB53528B872B92458DA5CCD312F9880@CH2PR03MB5352.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(186003)(6512007)(5640700003)(476003)(6486002)(486006)(229853002)(71190400001)(71200400001)(6436002)(66446008)(6506007)(66066001)(66476007)(26005)(76116006)(36756003)(478600001)(66556008)(102836004)(64756008)(2616005)(66946007)(25786009)(14444005)(11346002)(99286004)(2351001)(256004)(446003)(7416002)(76176011)(81156014)(6916009)(5660300002)(86362001)(14454004)(316002)(4326008)(4744005)(8676002)(81166006)(1361003)(2501003)(6116002)(3846002)(118296001)(54906003)(8936002)(305945005)(7736002)(2906002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5352;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XdzOa4cWFYpVA+ZK7+JywdTWjqsycAQWPe/J9XM+OC7Iyg0AAOcrb7T1l8pObU0MOV0h/e817F22+B2uFrNJZct1w37MIpRAq4Jg/FPnKkU+s0ecjTM6aqyvefDdBOs51HDXEdtbR2MOrQ/1q6fAfhC4j/fZGUCZ3zmzbqSfTuWzarPgvWa+BaAE03yaGqEtQkhSFkm3MonGdv7172Dq1Lw47S+mSBTs1JHn/bzdoo7Bl9Ds3krKVtulRBQJ68zLYXCjcGkauL7VhTDhdwG2eR5quS1h7CkLA4ZulwfrCFLhU+0Thx9vnFg4rrQcKhYA22fmMzSehtjGoY48UEEppVmqXnGaeYnGl9cP9uYQKfMnZLBuH+3goyRN8FnaVWFcQcRDn4gyW6JTzpzKB9RlWPA5Fu5RWep/rq5fEjyCnBc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB260D7680E6DC42B68CCFEF92648A0A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccc4d13-633e-4300-892e-08d73d964907
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 06:46:37.4542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/X0ZGwjrBjYTr3EBEGhrWsQ2/enUa1giFfvFqk1rtO+WB5NGRGbzY1sI6+/oPDnPLULmDuOy9G2Uwtx7zB873Y8rztqcM6ePDQt8u7ABp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5352
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-20_01:2019-09-19,2019-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=928 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909200072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDEwOjUwIC0wNTAwLCBOYXZpZCBFbWFtZG9vc3Qgd3JvdGU6
DQo+IEluIGFkaXNfdXBkYXRlX3NjYW5fbW9kZSwgaWYgYWxsb2NhdGlvbiBmb3IgYWRpcy0+YnVm
ZmVyIGZhaWxzLA0KPiBwcmV2aW91c2x5IGFsbG9jYXRlZCBhZGlzLT54ZmVyIG5lZWRzIHRvIGJl
IHJlbGVhc2VkLg0KPiANCj4gdjI6IGFkZGVkIGFkaXMtPnhmZXIgPSBOVUxMIHRvIGF2b2lkIGFu
eSBwb3RlbnRpYWwgZG91YmxlIGZyZWUuDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxl
YW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IE5h
dmlkIEVtYW1kb29zdCA8bmF2aWQuZW1hbWRvb3N0QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9pbXUvYWRpc19idWZmZXIuYw0KPiBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5j
DQo+IGluZGV4IDlhYzgzNTZkOWE5NS4uZjQ0NmZmNDk3ODA5IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0KPiArKysgYi9kcml2ZXJzL2lpby9pbXUvYWRpc19i
dWZmZXIuYw0KPiBAQCAtNzgsOCArNzgsMTEgQEAgaW50IGFkaXNfdXBkYXRlX3NjYW5fbW9kZShz
dHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gIA0KPiAg
CWFkaXMtPmJ1ZmZlciA9IGtjYWxsb2MoaW5kaW9fZGV2LT5zY2FuX2J5dGVzLCAyLCBHRlBfS0VS
TkVMKTsNCj4gLQlpZiAoIWFkaXMtPmJ1ZmZlcikNCj4gKwlpZiAoIWFkaXMtPmJ1ZmZlcikgew0K
PiArCQlrZnJlZShhZGlzLT54ZmVyKTsNCj4gKwkJYWRpcy0+eGZlciA9IE5VTEw7DQo+ICAJCXJl
dHVybiAtRU5PTUVNOw0KPiArCX0NCj4gIA0KPiAgCXJ4ID0gYWRpcy0+YnVmZmVyOw0KPiAgCXR4
ID0gcnggKyBzY2FuX2NvdW50Ow0K
