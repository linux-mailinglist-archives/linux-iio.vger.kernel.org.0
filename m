Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047EAEE349
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDPOn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:14:43 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:51548 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfKDPOn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:14:43 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4F9xwa003999;
        Mon, 4 Nov 2019 10:14:37 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9yhr20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:14:37 -0500
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FDQ0W006915;
        Mon, 4 Nov 2019 10:14:36 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9yhr1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:14:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyUKnnp+FDqY4qmqK/uogmqBj5cgrvmsxUdfdgEUvkCSR97TUGx6bfaq6NTAFH2xR9B6wPm8Wvvc9830z/RvDsw+lyxUH7VirImK7Lk6kEflwaOehr7Vif/0lTsRS7jysUtugRzxNy+diLfAzZXfdmL+JJHYqhAUQnmUjS/1bF+zDP2ZxtUb2B/Iw+jVg6nyqLX4JYHPsgIAjGNQsTFxeoR+5Y7lfox5oC+9aKooQS4wk7oSWqed8bbIPa6JJjwi4nhXvSP4v6bCw2WKnSPMfLomk5pMAFAV1w/YO6oPxUpzkHU8sC6VmkdyeQKMDGiVaIYMuwcQgjvpdHosk5qPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iicWn14U3hz7VP1b7wd0EEvO2BPDoQbQseiPWP3i8Eg=;
 b=P1/0dhxJBRfecXh7gL1Un6ofXBiz42prJwTIYI4LN/KEHPYP8+MBTOuv8ihnGdbx6Hh7jyCoRIfyFtl8o71itctpLGO7NaRcSDtLWspevMXihpnG94H4pZEbeNbBvYN736teq8Re72iYFsxVB7dWOOVFUp3l+6AtH+c6UnOntY9qgJULFEjnzW6Wl9P08J+vf618X3pq8qe50HQJwqRcVor8UMYdKHY6SfvSfbJvyOpXuI8b6b1mQdSYaEbdEpYgGzCQsnYxGFcDwHPl8p+36tv2WwwbIUYEIIqNaeNRP1QB7eEffi1bCmpCQd1zPMZl2Dc3s064UBh22FaZJUh8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iicWn14U3hz7VP1b7wd0EEvO2BPDoQbQseiPWP3i8Eg=;
 b=f2qBVIVEnou9MT9LjVkwqEoiwu9TfT6X3uCqxjDxN8dhOKjHuUe8fk36jZwtQCq3M3Vf4/F0L0YxpZTyvZeL9Cd0qIqVUZ5F5WfmLbhS1E78fHs8Bl7yCvdPNfTnsyo39bZcljY6RxVr6c4/15+uyVyisVVN56Imi89a7mutgTw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5224.namprd03.prod.outlook.com (20.180.13.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:14:33 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:14:33 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "zhiyong.tao@mediatek.com" <zhiyong.tao@mediatek.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: mt6577_auxdac: use
 devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: adc: mt6577_auxdac: use
 devm_platform_ioremap_resource
Thread-Index: AQHVgcA9dUEZj/+tQU2C1Eel9QMpOKd7QZ4A
Date:   Mon, 4 Nov 2019 15:14:32 +0000
Message-ID: <15c54a7c16eda55700e5e073db5650eece76d9f1.camel@analog.com>
References: <20191013121538.1782436-1-jic23@kernel.org>
In-Reply-To: <20191013121538.1782436-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3dd2b8d-ff00-4c71-ff7e-08d76139b26f
x-ms-traffictypediagnostic: CH2PR03MB5224:
x-microsoft-antispam-prvs: <CH2PR03MB52242EF615082704CCB379D5F97F0@CH2PR03MB5224.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(6116002)(3846002)(76116006)(66476007)(66556008)(66446008)(66946007)(256004)(2906002)(64756008)(99286004)(26005)(6506007)(102836004)(305945005)(2616005)(54906003)(2501003)(14444005)(316002)(76176011)(446003)(11346002)(118296001)(110136005)(36756003)(71200400001)(71190400001)(86362001)(478600001)(14454004)(6512007)(186003)(229853002)(6486002)(7736002)(486006)(476003)(4326008)(5660300002)(25786009)(8676002)(8936002)(81156014)(81166006)(6436002)(66066001)(6246003)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5224;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7z53I3g/s2/FjIjtBsm6LGsKf18RL1Q2LAGHjI41rndx5cmaYI/lBLmtjF5Pfi2kXIY1ROCVgH8XSNZCYbSXYUal7uDJQNSK/0nh2ygu+H98MX9DJb9oJxruzdRK9QpAwkywbHWPtimju1CJCfBAnvqMkCgoY0vWfAoWOAbGmzYMu9uhhBCyyQqs8RTdVhy8Hpl+PMfp+tXuHdCMzH19SEZ70mQNbbPkkc5wgADtCMA2BkuNnlbrJyNusFzKJyKJrBpH2YRG4b7OMmMJbElSH1n05TClrCWnKRcHKnbfp5AvCH4n8WbE3wiO28EquWqYrE3AqLTWf8I5N8qI10atZnStjG4KmyUi1KmYthC3wKSm8az8gY1srStNIztdpxjxHKCvon+BjmYjU6d3WkpKjn1R8DsDkdlEX+XclLpoc30xSeOK8KjlAppwPpykNwx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7B2C23A5ADBFE47BCB7A301AF591403@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dd2b8d-ff00-4c71-ff7e-08d76139b26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:14:32.9276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bRiLZru1cQXLkGm489NCBq21gVfawUZ68djb2qgyRmhTXTZPGmN0QGrpuL/Rz0QvehZmuPugPFw4n4A3G2qLhrShYszZjVpohkARE1opks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5224
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

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDEzOjE1ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBSZWR1Y2VzIGJvaWxlcnBsYXRlLiAgSWRlbnRpZmllZCBieSBjb2NjaW5lbGxlDQo+
IA0KPiBDSEVDSyAgIGRyaXZlcnMvaWlvL2FkYy9tdDY1NzdfYXV4YWRjLmMNCj4gZHJpdmVycy9p
aW8vYWRjL210NjU3N19hdXhhZGMuYzoyNTc6MS0xODogV0FSTklORzogVXNlDQo+IGRldm1fcGxh
dGZvcm1faW9yZW1hcF9yZXNvdXJjZSBmb3IgYWRjX2RldiAtPiByZWdfYmFzZQ0KPiANCg0KUmV2
aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5j
b20+DQoNCg0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1l
cm9uQGh1YXdlaS5jb20+DQo+IENjOiBaaGl5b25nIFRhbyA8emhpeW9uZy50YW9AbWVkaWF0ZWsu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9tdDY1NzdfYXV4YWRjLmMgfCA0ICstLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbXQ2NTc3X2F1eGFkYy5jDQo+IGIvZHJpdmVy
cy9paW8vYWRjL210NjU3N19hdXhhZGMuYw0KPiBpbmRleCA3YmJiNjRjYTNiMzIuLmE0Nzc2ZDky
NGYzYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL210NjU3N19hdXhhZGMuYw0KPiAr
KysgYi9kcml2ZXJzL2lpby9hZGMvbXQ2NTc3X2F1eGFkYy5jDQo+IEBAIC0yMzcsNyArMjM3LDYg
QEAgc3RhdGljIGludCBtdDY1NzdfYXV4YWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UN
Cj4gKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG10NjU3N19hdXhhZGNfZGV2aWNlICphZGNfZGV2
Ow0KPiAgCXVuc2lnbmVkIGxvbmcgYWRjX2Nsa19yYXRlOw0KPiAtCXN0cnVjdCByZXNvdXJjZSAq
cmVzOw0KPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7DQo+ICAJaW50IHJldDsNCj4gIA0K
PiBAQCAtMjUzLDggKzI1Miw3IEBAIHN0YXRpYyBpbnQgbXQ2NTc3X2F1eGFkY19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCWluZGlvX2Rldi0+Y2hhbm5lbHMgPSBt
dDY1NzdfYXV4YWRjX2lpb19jaGFubmVsczsNCj4gIAlpbmRpb19kZXYtPm51bV9jaGFubmVscyA9
IEFSUkFZX1NJWkUobXQ2NTc3X2F1eGFkY19paW9fY2hhbm5lbHMpOw0KPiAgDQo+IC0JcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLQlhZGNf
ZGV2LT5yZWdfYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0K
PiArCWFkY19kZXYtPnJlZ19iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBk
ZXYsIDApOw0KPiAgCWlmIChJU19FUlIoYWRjX2Rldi0+cmVnX2Jhc2UpKSB7DQo+ICAJCWRldl9l
cnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBnZXQgYXV4YWRjIGJhc2UgYWRkcmVzc1xuIik7DQo+
ICAJCXJldHVybiBQVFJfRVJSKGFkY19kZXYtPnJlZ19iYXNlKTsNCg==
