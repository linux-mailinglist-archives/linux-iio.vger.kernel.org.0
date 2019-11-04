Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C04EE343
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKDPNK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:13:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19900 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfKDPNK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:13:10 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4FA86Q010753;
        Mon, 4 Nov 2019 10:13:06 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rhk1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:13:06 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FD5sl012846;
        Mon, 4 Nov 2019 10:13:05 -0500
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2051.outbound.protection.outlook.com [104.47.48.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rhk1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:13:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfK+A5boRxrpi7CbrOJ8XhXuKElB+HEsFOQbeqb/m6frhS498t4K7qUMM5oE0IAMajPrQgrd3RVnl2YSHlaqtztbDMaTzYLNC/6bKwODJ9TMMfz42CHtzp4moOjtM220nBS/FE5ejiCNLb65ukWN9ImA1yiwwMD6RVXT3tDe61ZRy0toye/VBSdRPQ4dnXEc+tAJw0iLDa9fMg7v0+YzRjNsB1KHRvdjECWtEquPYnx4zl/PHo++zGiqittRsU2B6FJSngGbpcUF6cYbx5TvdLiILQi3x5nDHZOVnClecWOFn6Qc48ejRNNv7R4tAiI2GmFPyycrcqQqTAVijfM5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dSRExnZw5jhtGHqzB31kle/fgbtU0rrlrwXp+J2I7o=;
 b=dHUpmta69J1ULQX/WLiY2fUVFNfZMWkxqZ1VYc7Nsu4gMrH2M8cipvrKfe+DOFdP9WFMZQDEWebgkMFIPqGhSpyORf68yhfWRqkKHJA9MHLvcqnDgiR0YZrd4IyrhAP+GPX7A8Jp256iu2v/R+ialsE7o2qvT86Fyi+XKcuKIDhONj7emPL8L5rpISwNld/cPaYhXO3sD8KHoHGbuBNLdp57oR2ZyrHRO+cZta8v3N80j2HUdnBX+K1bqm/6OPw/KNfuaQiI5Nave/HdCwJAWxQbQlVL62qzC5f7aAyPd7yOHd+36AmZiM4htyiuZEzCK0ka600cWhlz654F8S5dxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dSRExnZw5jhtGHqzB31kle/fgbtU0rrlrwXp+J2I7o=;
 b=MckJlPRyFbgQ2Qjw7D+LsJuuaUa3mrNTkyvNx0Gm+tARL6Qy7yOP65eWOHPm3Rdn6546WZoDmRfSDU03IvRBjiGngfEE6CVAOogf1BLQn31E3liNjlx/w43XH12LOXILkPu/XnbrtZnB0NzF4kVm7ueTqjBud9Cq/+M8qxmF3w8=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5224.namprd03.prod.outlook.com (20.180.13.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:12:58 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:12:58 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "raltherr@google.com" <raltherr@google.com>
Subject: Re: [PATCH] iio: adc: aspeed: use devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: adc: aspeed: use devm_platform_ioremap_resource
Thread-Index: AQHVgbrZ3BQYmVeZb0S9GE6AiPDKL6d7QTeA
Date:   Mon, 4 Nov 2019 15:12:58 +0000
Message-ID: <1be83f4fa8c1c87d41f17c9180651bc0ced625e7.camel@analog.com>
References: <20191013113705.1721011-1-jic23@kernel.org>
In-Reply-To: <20191013113705.1721011-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a229d228-5cd7-4c27-d4c0-08d761397a23
x-ms-traffictypediagnostic: CH2PR03MB5224:
x-microsoft-antispam-prvs: <CH2PR03MB52245E626E953C77A2DD97A0F97F0@CH2PR03MB5224.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(6116002)(3846002)(76116006)(66476007)(66556008)(66446008)(66946007)(256004)(2906002)(64756008)(99286004)(26005)(6506007)(102836004)(305945005)(2616005)(54906003)(2501003)(14444005)(316002)(76176011)(446003)(11346002)(118296001)(110136005)(36756003)(71200400001)(71190400001)(86362001)(478600001)(14454004)(6512007)(186003)(229853002)(6486002)(7736002)(486006)(476003)(4326008)(5660300002)(25786009)(8676002)(8936002)(81156014)(81166006)(6436002)(66066001)(6246003)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5224;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3XXIeLyPX/MqB+IMEdI3IkAE7xYgrUi011HtQ30ujpDDNDanpFcYSx/AJN6BsECPwKMHDeHJxMwgFy2TsgzU4XkyVBRdI9F7JDrRoBa4pucM3zB05jfNoY/TGgVUT80oWHI+vYXH36V6hOiDHS9As/QpHd1HYq2FmGbMDjDZ5/TV1VkoZO93th9CcfM4xoBq7UbJHomeFPLzSaLJ7x1D0z50Z5LoVx08R0+h2lpcSLvbi86FDvqnPUjanpBxZofYFDIA2Ms3M9GwQy17gRRm+YL8gkarzBmkzsCdiy+hr4XLLVO7jKavbOhy+CD86OG59+JDooI4PUzDIjTZw/VVK57e4HIneIcUqsoyPlDQxdF7evahogm9hINFsf9b8eDNtQxjlSgMTCSFuE0SSH/TXXLZwLJt8de7IChYP7qaBYZP3hB7NUyRN4hv3M8ji/O
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6A4782CF5F1CE419E87931C8DD4136B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a229d228-5cd7-4c27-d4c0-08d761397a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:12:58.4571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IX6hx/YpdVx+A8mIZkyM8qX0suZId5CNC5KKxswUDVYyBOpym1PjkjKbzoQ0bfpSTs6Qrr2a9kfj8Zxy7qeq9Rp75gH0BS4OOs8d7zux+8U=
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

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDEyOjM3ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBSZWR1Y2VzIGJvaWxlcnBsYXRlLg0KPiANCj4gSWRlbnRpZmllZCBieTogQ29jY2lu
ZWxsZSAvIGNvY2NpY2hlY2sNCj4gDQo+IENIRUNLICAgZHJpdmVycy9paW8vYWRjL2FzcGVlZF9h
ZGMuYw0KPiBkcml2ZXJzL2lpby9hZGMvYXNwZWVkX2FkYy5jOjE4OToxLTExOiBXQVJOSU5HOiBV
c2UNCj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlIGZvciBkYXRhIC0+IGJhc2UNCj4g
DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBh
bmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFu
LkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gQ2M6IFJpY2sgQWx0aGVyciA8cmFsdGhlcnJAZ29vZ2xl
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvYXNwZWVkX2FkYy5jIHwgNCArLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FzcGVlZF9hZGMuYyBiL2RyaXZlcnMvaWlvL2Fk
Yy9hc3BlZWRfYWRjLmMNCj4gaW5kZXggZDNmYzM5ZGY1MzVkLi4xZTUzNzUyMzVjZmUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hc3BlZWRfYWRjLmMNCj4gKysrIGIvZHJpdmVycy9p
aW8vYWRjL2FzcGVlZF9hZGMuYw0KPiBAQCAtMTczLDcgKzE3Myw2IEBAIHN0YXRpYyBpbnQgYXNw
ZWVkX2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCXN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXY7DQo+ICAJc3RydWN0IGFzcGVlZF9hZGNfZGF0YSAqZGF0YTsN
Cj4gIAljb25zdCBzdHJ1Y3QgYXNwZWVkX2FkY19tb2RlbF9kYXRhICptb2RlbF9kYXRhOw0KPiAt
CXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAgCWNvbnN0IGNoYXIgKmNsa19wYXJlbnRfbmFtZTsN
Cj4gIAlpbnQgcmV0Ow0KPiAgCXUzMiBhZGNfZW5naW5lX2NvbnRyb2xfcmVnX3ZhbDsNCj4gQEAg
LTE4NSw4ICsxODQsNyBAQCBzdGF0aWMgaW50IGFzcGVlZF9hZGNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAlkYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4g
IAlkYXRhLT5kZXYgPSAmcGRldi0+ZGV2Ow0KPiAgDQo+IC0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLQlkYXRhLT5iYXNlID0gZGV2bV9p
b3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ICsJZGF0YS0+YmFzZSA9IGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gIAlpZiAoSVNfRVJSKGRhdGEt
PmJhc2UpKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihkYXRhLT5iYXNlKTsNCj4gIA0K
