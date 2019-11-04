Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E8EE363
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfKDPQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:16:49 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:23438 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfKDPQs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:16:48 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4F9wXo003990;
        Mon, 4 Nov 2019 10:16:46 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9yhr5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:16:45 -0500
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FGjPT006224;
        Mon, 4 Nov 2019 10:16:45 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9yhr5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:16:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bupEV84EOC+n08cBs8iIQExO+7QdJ8jfTjpy0kxEGs0DLXCUajUfU+R0JkoqL35yUwim8KiuINi7SoUfc7CThOVsWnYG8hMC3IS8QnJLhUvTFOtnENPkJqdMbhI+QEkHbnpPspys1d1LAn895T8m5ZIJOeEzFjQz0BALIWTQ4Slyw0zkIBIgQrociCepmUDxJLGVbIAlTvKtlnwQQtTkTHr7EfkB26I1x6zgF7y6Xxj95RPQ0nZDb0MtDVuJYeGKjgPNrq6aQCny5NaDSUH5CWxK0kauAK14RE04/JYPitaOmO6AI5dDKT7pe4KMTKyZ5rwPhxNz6HwlDVM1kJb16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1IVvX3xl3wok7sOdXiAx9FgAHITx9Kcj7+88LVPS7w=;
 b=C9EB3b6dFT5UF8+24HGG7in7CepgGKQLG1BZcgF+wJiBTsEo2mp0YMi5n0fDfm1+7g7ctT/NsZGRhGiJ4uFfnKQ/iiK7RIwEoH+RFiKD4gTGll75cm0o8uR94ywX0xuYPavrl3jqG5I7ysyDykaLhbdnh5nh3mwW+tJWR26NP40ndD4FKQaIKkcnTPL8OZhIte9iQxWn+jl7qdTV4CkMuLJCDd+sTPHJy8nOartQXhAvM0+4aN7v72sVHUJ9eqnMV8mHatSFlyBWHd9guCRDrTsJhyP0bu0L5kzB7QsXmQXmkTo5LbaHQF6oekQ+0AzZozDikX/7/TCRFbOwnDU9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1IVvX3xl3wok7sOdXiAx9FgAHITx9Kcj7+88LVPS7w=;
 b=NaUBfEnV3Uah9Bwp+TO1oEKmlmrb7RveIHbwwRrZvGw5n1YWfYtBGKSqy8xLbCUg9bF8dtTFPjndTXM+yKiymI8jJiF2rLzxZFt1DZYo4Uv4fCcLeMRUySfHB/qZecbxO/Ohv7fMjsvceHEfjIWpMkkstKJAHTiLAitbzgnrjE4=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5368.namprd03.prod.outlook.com (20.180.15.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:16:44 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:16:44 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "manabian@gmail.com" <manabian@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: dac: lpc18xx: Use devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: dac: lpc18xx: Use devm_platform_ioremap_resource
Thread-Index: AQHVgenxeZLCH+g6y02cLq62DA7XlKd7QeaA
Date:   Mon, 4 Nov 2019 15:16:44 +0000
Message-ID: <a26444c26603137a293dae3c84147f8e727ce198.camel@analog.com>
References: <20191013171414.2154379-1-jic23@kernel.org>
In-Reply-To: <20191013171414.2154379-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de5e8f27-0f72-4d8b-7848-08d7613a0099
x-ms-traffictypediagnostic: CH2PR03MB5368:
x-microsoft-antispam-prvs: <CH2PR03MB5368C1118D9C0BB5E8AF5579F97F0@CH2PR03MB5368.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(7736002)(186003)(6486002)(229853002)(486006)(4326008)(476003)(86362001)(6512007)(478600001)(14454004)(81156014)(81166006)(8936002)(6246003)(66066001)(4001150100001)(6436002)(25786009)(5660300002)(8676002)(99286004)(102836004)(6506007)(26005)(305945005)(14444005)(316002)(54906003)(2616005)(2501003)(66556008)(66476007)(76116006)(6116002)(3846002)(64756008)(2906002)(66946007)(66446008)(256004)(71190400001)(71200400001)(446003)(11346002)(76176011)(36756003)(118296001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5368;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DwrNfOSs3rdGwfidkpqn+0ZOIiWNMiFKNIceuNta2ZPsYd++dxUsN5oQfjXFNtQ3H4W0XxyJAMjK0Uz5Gk3Mw2ywtGmIoHywN1fHoEhu+Q6AqV9RJphhjF4fAFHEdy0W2CswarcCj7DT0oLs52uT418efgldmZqQ93/fzocyu/BfIhiYgSAeH/T+dCOU5iVeQQUR4Dj8mzJVj9cR3KdJ7CK67/NylRIfj2ElrTBOfY85n0ni55zpWQeVgye3+bJxzXgiS1IHkusOn+gu9ojDyTQU9qlmGUQ6DWJNYg3jXqXE7ANwSMmCPGc9bDdQafUs0kJgmNWjxncJmVyYD5JS8KhdYBNGKBs+LHrX5qnDX+8Nl8alb38MeZIWTJe9YEnKMKmx0JleVOSKa24kzFEZieFNSQYuUcZLb6HqQb43qt7pzP4NHqVMhBAGVSQhqXj+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <056B25F42B73644A8DFCB1FA57C3B5CE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5e8f27-0f72-4d8b-7848-08d7613a0099
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:16:44.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRiLzzWrZYb1k4+UQD8Pvr7O8FL6NwskqoMvtOuYqbSD6E3kbnOf0jqz8L6zjQH37FKYAPa+ZbWy9+EIC7eiLVewjqB6Vx2WUc8HqI3Di8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5368
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040151
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDE4OjE0ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBSZWR1Y2UgYm9pbGVycGxhdGUuDQo+IFN1Z2dlc3RlZCBieSBjb2NjaW5lbGxlDQo+
ICAgQ0hFQ0sgICBkcml2ZXJzL2lpby9kYWMvbHBjMTh4eF9kYWMuYw0KPiBkcml2ZXJzL2lpby9k
YWMvbHBjMTh4eF9kYWMuYzoxMjE6MS0xMDogV0FSTklORzogVXNlDQo+IGRldm1fcGxhdGZvcm1f
aW9yZW1hcF9yZXNvdXJjZSBmb3IgZGFjIC0+IGJhc2UNCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25l
ZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4N
Cj4gQ0M6IEpvYWNoaW0gRWFzdHdvb2QgPG1hbmFiaWFuQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2lpby9kYWMvbHBjMTh4eF9kYWMuYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWlvL2RhYy9scGMxOHh4X2RhYy5jDQo+IGIvZHJpdmVycy9paW8vZGFjL2xwYzE4eHhfZGFj
LmMNCj4gaW5kZXggODgzZTg0ZTk2NjA5Li4wYWIzNTdiZDM2MzMgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvaWlvL2RhYy9scGMxOHh4X2RhYy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2RhYy9scGMx
OHh4X2RhYy5jDQo+IEBAIC0xMDYsNyArMTA2LDYgQEAgc3RhdGljIGludCBscGMxOHh4X2RhY19w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBp
aW9fZGV2ICppbmRpb19kZXY7DQo+ICAJc3RydWN0IGxwYzE4eHhfZGFjICpkYWM7DQo+IC0Jc3Ry
dWN0IHJlc291cmNlICpyZXM7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCWluZGlvX2RldiA9IGRl
dm1faWlvX2RldmljZV9hbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKmRhYykpOw0KPiBAQCAtMTE3
LDggKzExNiw3IEBAIHN0YXRpYyBpbnQgbHBjMTh4eF9kYWNfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZQ0KPiAqcGRldikNCj4gIAlkYWMgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiAgCW11
dGV4X2luaXQoJmRhYy0+bG9jayk7DQo+ICANCj4gLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAtCWRhYy0+YmFzZSA9IGRldm1faW9yZW1h
cF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0KPiArCWRhYy0+YmFzZSA9IGRldm1fcGxhdGZv
cm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gIAlpZiAoSVNfRVJSKGRhYy0+YmFzZSkp
DQo+ICAJCXJldHVybiBQVFJfRVJSKGRhYy0+YmFzZSk7DQo+ICANCg==
