Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B260EEE36A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfKDPRQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:17:16 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38760 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfKDPRQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:17:16 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4F9wwJ008896;
        Mon, 4 Nov 2019 10:17:13 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e1n9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:17:13 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FHBXp001489;
        Mon, 4 Nov 2019 10:17:11 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e1n9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:17:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1pkV6u8P98Ih75Gs8RX56gdhLHX32xdyW+pVSPNhy9GKxD57IXUYk+XB9S8Aw7U1bJIAzNZyQOWeerpevLyKH7Z+HFI3n4bGf9inntGF2WZLfEo/+j0rR0mpyYvEXkXbeJb7tOERsYJnWOtakPvrBBVbZsfX7T9qu0thCzfOhm/Khv8NIBSZxzswt1wi8dGJv23P0eLO2JFgqp+Qrf7vif2S5ZYsfgUdY9pbH/yXn5S5dIagPpXwdjit3h0+TkEcBk4M+IcQE8seIkyVY9HWp99GNPmo7Yw3p/hmjGKNPrVW9Nms6YiHW0dQak4ilNjKDhZiaeB08RYx/FXfYujOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4nQWxa2QmiJ31EGd5BmZbeM2t2OJLizUA2XZFYc9g4=;
 b=hNLYTMS1XJSq8epRNUWMcp2leGaV4ojYqphAkdYW5kslQWw9ES62wFNCSZ7bTxtD8c5Wl5pL7PsDND7KBHeFh/Bn0jsS5GFoYjVZ0aLVb5p9OtGWsBaECmdcV48INbdrt2AjzNY7j/cZRvW6PGWTXkaKNGucLQ04jlUzZ4woFah8LTSESO4UzH4KIw57Lo3Kg02y18Q3e8Hdlnzy5JnOJLAJYifEgubucvSjPE5IyGaxL2sv2tDOnbYgOa77DK07dhXPOE3rcXk86gYjF2yXbYu2GdtELpM6J0qdgjTPnMR5G/Mme1gpi+uyTWBWQgW1db9DXWeUDTRnl3G+zG7OSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4nQWxa2QmiJ31EGd5BmZbeM2t2OJLizUA2XZFYc9g4=;
 b=Aouxrav5/7WH5yqgSlISJVEAUyBOJpziQIXdBwtOBtC8C6On06XiQhXhCrs0r/YL8xXIM/PFQSOIE4hcemiuVcs+KKRBWJPFYQwgxyuET/K3H2Ern1+gZm2q/lJcv7r51Mc0oCcQP1RUOyX8hIYo8aSLfCRyG0iRLXnzn5z6XGc=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5224.namprd03.prod.outlook.com (20.180.13.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:17:08 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:17:08 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: npcm: use devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: adc: npcm: use devm_platform_ioremap_resource
Thread-Index: AQHVgd1oBGEbYVKmREai7rYEz7GcSKd7QhyA
Date:   Mon, 4 Nov 2019 15:17:08 +0000
Message-ID: <82747a09236357a7b1a285404dcc9ae17baac963.camel@analog.com>
References: <20191013154427.1853794-1-jic23@kernel.org>
In-Reply-To: <20191013154427.1853794-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa5f16f1-af35-485e-6f7f-08d7613a0ef6
x-ms-traffictypediagnostic: CH2PR03MB5224:
x-microsoft-antispam-prvs: <CH2PR03MB5224EF4460DAAD400328BD61F97F0@CH2PR03MB5224.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(6116002)(3846002)(76116006)(66476007)(66556008)(66446008)(66946007)(256004)(2906002)(64756008)(99286004)(26005)(6506007)(102836004)(305945005)(2616005)(54906003)(2501003)(14444005)(316002)(76176011)(446003)(11346002)(118296001)(110136005)(36756003)(71200400001)(71190400001)(86362001)(478600001)(14454004)(6512007)(186003)(229853002)(6486002)(7736002)(486006)(476003)(4326008)(5660300002)(25786009)(8676002)(8936002)(81156014)(81166006)(6436002)(66066001)(6246003)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5224;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVLNhBZdcJWlpgN9G1RNzQQoDD8zAlNPJIjBLUNfgoo0VHAlzICkWTxBHBMZfEllQ9dfj0Ovs+k31kbYzeDCadSuL5fW6iF/0BNc8ApuhRRdjCc/gh/ksHZoeTtQA1cDLUZLt//sRuXQrTegqJyJOaRs9ogEb+JulM70Zoqdm4OU5IPMvB8ylQLJt21Rra9MS19Jvg0xZU3EpZNFbwdLCMVCuNPKhFyscN2W0nhXG+VoZq5VQfyzSXa63deX7m5YkY46gMo9EneNEECKYb90xiihaHjGLafw88oEUTpDbC8gJ0s+b17gGU//RywwTIyImzWB5PDpFgdU9Go0f2MVN2ibgbh5wLy/W/QTDT++NmG3qiVrvbTx1h1dinch1X8F2jibSmp1HvfYlPqbtzuOS+zl4XFZRLDnmedEicqqGGZT/52dnOW6lVxDyH0RDTHa
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E58C4644C37F44ABA9C5E52FC22E321@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5f16f1-af35-485e-6f7f-08d7613a0ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:17:08.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCTcY3e7MCTYPooUo8F2cu5EH92ursDFkMT+WDmu7cmRSz/ktJmvKrR4boYa8UrOFtPs0hsfrS+ZEG0gja5GORtHYf/LkzJFd+jEYns969w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5224
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911040151
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDE2OjQ0ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBSZWR1Y2VzIGxvY2FsIGJvaWxlcnBsYXRlIGNvZGUuDQo+IFN1Z2dlc3RlZCBieSBj
b2NjaW5lbGxlIHZpYSBjb2NjaWNoZWNrLg0KPiANCj4gQ0hFQ0sgICBkcml2ZXJzL2lpby9hZGMv
bnBjbV9hZGMuYw0KPiBkcml2ZXJzL2lpby9hZGMvbnBjbV9hZGMuYzoyMDA6MS0xMTogV0FSTklO
RzogVXNlDQo+IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSBmb3IgaW5mbyAtPiByZWdz
DQo+IA0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxl
YW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25h
dGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IENjOiBUb21lciBNYWltb24gPHRtYWltb243N0Bn
bWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL25wY21fYWRjLmMgfCA0ICstLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbnBjbV9hZGMuYyBiL2RyaXZlcnMvaWlvL2Fk
Yy9ucGNtX2FkYy5jDQo+IGluZGV4IDkxMGYzNTg1ZmE1NC4uYTYxNzBhMzdlYmU4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbnBjbV9hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9h
ZGMvbnBjbV9hZGMuYw0KPiBAQCAtMTgzLDcgKzE4Myw2IEBAIHN0YXRpYyBpbnQgbnBjbV9hZGNf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAlpbnQgaXJxOw0KPiAg
CXUzMiBkaXY7DQo+ICAJdTMyIHJlZ19jb247DQo+IC0Jc3RydWN0IHJlc291cmNlICpyZXM7DQo+
ICAJc3RydWN0IG5wY21fYWRjICppbmZvOw0KPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7
DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gQEAgLTE5Niw4ICsxOTUs
NyBAQCBzdGF0aWMgaW50IG5wY21fYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4g
KnBkZXYpDQo+ICANCj4gIAlpbmZvLT5kZXYgPSAmcGRldi0+ZGV2Ow0KPiAgDQo+IC0JcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLQlpbmZv
LT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ICsJaW5m
by0+cmVncyA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gIAlp
ZiAoSVNfRVJSKGluZm8tPnJlZ3MpKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihpbmZvLT5yZWdzKTsN
Cj4gIA0K
