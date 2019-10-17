Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9701DAD96
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2019 14:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390587AbfJQM5C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Oct 2019 08:57:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35336 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729124AbfJQM5C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2019 08:57:02 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9HCqhFW030235;
        Thu, 17 Oct 2019 08:56:35 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2051.outbound.protection.outlook.com [104.47.41.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vkbr7fjhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 08:56:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRB/UO9KDMezPxdcbPKhZvE7XtEdQI8vFK82/0/A3Fvjb+nJyCY+VA2wxoYJ+1W1b7JE7b92cGRdhb1JJ9cZ3VJOlb3ttXHrEnyRkdTG0/d/D7mCWdp3SD6ZX7yIKZY+XoPKe1NKjlSbnhk4qGXPzfRmRZgLz19tKN2SweVx2m626PVzP7ndhfdRBFQHM5dSx5A/wGMI1OPBtfos4ulL9pncryWExBF+YxTQHGkdL+DTRQH4/Vxs7fatEysmTSKAeZX0kempzpqiCi+yFK/99Ee5n5jSyUE8pDInfObBYfKHAvIE5H1V4uQ+Ri1jJvxuM/Ch5OXPrCLzghiVije0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jEzNIWS78iD394zsIU+kwMdQAdMn854iUNm6kzD5pU=;
 b=BFWAYyAEx3lW1197CqePLORHD2K9TDFj+2S6RE0RemYw5hymwzoYagFak60/ARyl8fbC4m0lHiyYrGWoeCBmq+58xrgb4nuQpHGIrGO0oYsLvQGqWKGYwNdvWe9zZQ8W9/B5yv7qjs6XVuz6pDnQN/d+nkemthFT+47pz35jS/SeAexdPiXQpRmzzNfo/ucH49bZUtEcJHzAr3/hYAM9CopJaRwRzXW69tbTQgvWMlG0hHGvmUVGRar90ztrAGXg4PJbgHpiODpKitlXjaTWyIIef+nEDuiwtCeo8+9D6+HGQRxJMY0o39ku/Lf+v3froF0/ua2tTkUq3w/WUNYGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jEzNIWS78iD394zsIU+kwMdQAdMn854iUNm6kzD5pU=;
 b=Vmq2AbblDr+JqIl9kB2lcK2iY55nBkEC0BcpJ1eSLZVuumEqjLk1tp2T2L88DBnbPbT/sVIDRmF+l6n3C0PmFzDsdCZxh3XatKqsOGylLCs6/wLkMGGfNZijVuGorTzX5neP6piFg3XcdUvTth7/dJM56X82RxBKZx51oEhewlQ=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5160.namprd03.prod.outlook.com (20.180.5.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Thu, 17 Oct 2019 12:56:33 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 12:56:33 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hslester96@gmail.com" <hslester96@gmail.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad9834: add a check for devm_clk_get
Thread-Topic: [PATCH] staging: iio: ad9834: add a check for devm_clk_get
Thread-Index: AQHVhC2u3ScEUTGZY0uRy+gHxSSwk6dezFaA
Date:   Thu, 17 Oct 2019 12:56:33 +0000
Message-ID: <3acc69aceb04667ba34200f54c59b3d160ab2f5d.camel@analog.com>
References: <20191016142540.26450-1-hslester96@gmail.com>
In-Reply-To: <20191016142540.26450-1-hslester96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d75a178-172d-40c6-7fdf-08d75301700e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR03MB5160:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5160EBB5F48DCFB05DB9487EF96D0@CH2PR03MB5160.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(316002)(25786009)(2616005)(6436002)(6506007)(4326008)(66946007)(6512007)(2501003)(8936002)(81166006)(66066001)(6916009)(54906003)(7736002)(476003)(81156014)(305945005)(486006)(8676002)(14454004)(5660300002)(446003)(11346002)(71200400001)(229853002)(26005)(2906002)(1361003)(186003)(4744005)(6486002)(76116006)(66446008)(14444005)(4001150100001)(478600001)(36756003)(66476007)(66556008)(102836004)(86362001)(71190400001)(76176011)(5640700003)(64756008)(3846002)(6116002)(99286004)(118296001)(6246003)(1411001)(2351001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5160;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iPqS4ortSntpe6dtG4EKDAp4RXlemLCcwMVL6zo5xBIcDv5aFHgxJnsQyljQWSOSU+Wsup3lX+5fff12MZkW4K7xET66FqDSCxYCW2hjreBsy89dOOh67SjmaMrfV0dgOug/isCRsEJydZ+sa1MQZ8xJMjQHdV0iMxGwAJzOwHi5+FA+fW3zwCHllj++BWgrO18Tz+8vUWgrsnHGn6xJks8o7bUdsS/qSFh1SIFooH/Cy0nDgPwuxyOuSoa4kbvHLZh7MSr5aKr7VbD+wbPf+0y467SzNsjIFxesMldVBUIjeek2LVuWtko62VEfyC8hMw1y+tPb5M1sWtICibZHylIvDxz+AN0etCbLO16pTAtAtOrvKyQJ/QtYURjWHk6oofFBgg5ZfX1GGJHjviVsDGo3/Q7L49W0t3IRkb8eE70=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C0EAE7EA9B8014BB309E0A55CBE3A78@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d75a178-172d-40c6-7fdf-08d75301700e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 12:56:33.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EY3geQ+sXPcwlM9NaOpb//p9FgoqzujCmaENeD3LuS8h0xPQa2arqmfIsfbE5brTM+8ABQId08cwXZDKJPfZnZiZRHBdcktypzYV6YEL0xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5160
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_04:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910170119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTE2IGF0IDIyOjI1ICswODAwLCBDaHVob25nIFl1YW4gd3JvdGU6DQo+
IGFkOTgzNF9wcm9iZSBtaXNzZXMgYSBjaGVjayBmb3IgZGV2bV9jbGtfZ2V0IGFuZCBtYXkgY2F1
c2UgcHJvYmxlbXMuDQo+IEFkZCBhIGNoZWNrIGxpa2Ugd2hhdCBhZDk4MzIgZG9lcyB0byBmaXgg
aXQuDQo+IA0KDQpUaGlzIGNvdWxkIGFsc28gdXNlIGEgRml4ZXMgdGFnLCBidXQgbm90IGEgYmln
IGRlYWwuDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRl
bGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IENodWhvbmcgWXVhbiA8aHNsZXN0
ZXI5NkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zdGFnaW5nL2lpby9mcmVxdWVuY3kv
YWQ5ODM0LmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2ZyZXF1ZW5jeS9hZDk4MzQuYw0K
PiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vZnJlcXVlbmN5L2FkOTgzNC5jDQo+IGluZGV4IDAzOGQ2
NzMyYzNmZC4uMjMwMjY5NzhhNWE1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlv
L2ZyZXF1ZW5jeS9hZDk4MzQuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2ZyZXF1ZW5j
eS9hZDk4MzQuYw0KPiBAQCAtNDE3LDYgKzQxNywxMCBAQCBzdGF0aWMgaW50IGFkOTgzNF9wcm9i
ZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgCXN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsN
Cj4gIAltdXRleF9pbml0KCZzdC0+bG9jayk7DQo+ICAJc3QtPm1jbGsgPSBkZXZtX2Nsa19nZXQo
JnNwaS0+ZGV2LCBOVUxMKTsNCj4gKwlpZiAoSVNfRVJSKHN0LT5tY2xrKSkgew0KPiArCQlyZXQg
PSBQVFJfRVJSKHN0LT5tY2xrKTsNCj4gKwkJZ290byBlcnJvcl9kaXNhYmxlX3JlZzsNCj4gKwl9
DQo+ICANCj4gIAlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoc3QtPm1jbGspOw0KPiAgCWlmIChy
ZXQpIHsNCg==
