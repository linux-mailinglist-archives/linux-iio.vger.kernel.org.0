Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 815CAEE36D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfKDPRc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:17:32 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61824 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfKDPRc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:17:32 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4FAARV010795;
        Mon, 4 Nov 2019 10:17:30 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rhk8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:17:30 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FGdNv027454;
        Mon, 4 Nov 2019 10:17:29 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2051.outbound.protection.outlook.com [104.47.40.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rhk8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:17:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcn3fuDo+EebqvBWLz3KI5jLtLQxmT6g68W6ev1GABwi/Bdyzt8/ZLSjnTeED6SlR66dWy5n7qdauF0RaKm1EIb+EVTI/0ScPPBLPmoh377ANdGp9WuvDA0yfzrBxNAKosqj2c4yhQQG4tWdTggRApci5KMjorLmdomPzHXNiJiDOXPWxPVpWN42anmYbMNNP2B4WHG5JIUdTwK7MHGpy0XYzTrh345TsAGzEc/ZXetijyKubGPcU/D9qh2PiBrKb/hYWyEgoEZj87+T0q/J+xuHs/6M1ve0bnJaPtbaTqcgDvAM8MjtKEOtAwnto5f1uuYOJ9fSilGwfgYRAWa8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKDK/Pp/qdkOUhSKabrP0FhfKVTsbz604eRx8UrvKS0=;
 b=CK8Lj2nmBa+T6Y2BhFMjQR/K6TAY32vcLxIIMItp6OC0rHpKYZ65nN9RBaMiPUaFQ/ICsWzrM3/BDmUNx5rYR4L6vpJxRDyomE6o4zOFXU4sFgZYvhyl8ml5qB5nZlYPDmsODSRB9yh1SgaZ3sHuYcsK/LKyopn4OyTz/ySUrPY3edDsi1pd5ujY+4VCAJApbQpg2N++m5S0ISWppaSlV35ainzYUKEHl3I75LMKaJzq9E7OBa9cu0Ls0ydMkLSAJBaLFY8P664uL7HuKWHUMI0E2vsOzS/ZSiH9fiqe25o5OvlazsAolzIRLdjQk22yr7BfeI7QWZhSQXnpED+EOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKDK/Pp/qdkOUhSKabrP0FhfKVTsbz604eRx8UrvKS0=;
 b=kiNsvDQhMLb3Wd1nSOLcIi1MBaD1yDaWEug0S5tSG4GYofTHaUsX7CjC1v88b+Dl/6OBCI41wRKv4vEFUMUWxXkr3Hh69usJ+oOdLgxWzC+B+hxYYH051arY9UZoqoe5cG02iIlRDmlfo0qMCBpNjGKJRRFwB9gNXps1V4K6jz0=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5224.namprd03.prod.outlook.com (20.180.13.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:17:28 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:17:28 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: rcar-gyroadc: use
 devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: adc: rcar-gyroadc: use
 devm_platform_ioremap_resource
Thread-Index: AQHVgd37cYgxCCRnNkC9MSoM6ECh2qd7QjOA
Date:   Mon, 4 Nov 2019 15:17:28 +0000
Message-ID: <853e5567973d6225307d6b557ecdcca61c86e0b7.camel@analog.com>
References: <20191013154832.1858884-1-jic23@kernel.org>
In-Reply-To: <20191013154832.1858884-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 362890ce-196e-44be-0764-08d7613a1b05
x-ms-traffictypediagnostic: CH2PR03MB5224:
x-microsoft-antispam-prvs: <CH2PR03MB52243AC89F67B6D66815744CF97F0@CH2PR03MB5224.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(6116002)(3846002)(76116006)(66476007)(66556008)(66446008)(66946007)(256004)(2906002)(64756008)(99286004)(26005)(6506007)(102836004)(305945005)(2616005)(54906003)(2501003)(14444005)(316002)(76176011)(446003)(11346002)(118296001)(110136005)(36756003)(71200400001)(71190400001)(86362001)(478600001)(14454004)(6512007)(186003)(229853002)(6486002)(7736002)(486006)(476003)(4326008)(5660300002)(25786009)(8676002)(8936002)(81156014)(81166006)(6436002)(66066001)(6246003)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5224;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mO1GJO3UaAWghLiQapmYyTPLvJYDxOM4njM8WS9TLpjcDGH6rZlvolVoA87uUECCPf/ONEAKdcJQLvbUuhZo0A0xSQ6NTVYGIfwjGPoK4wUvzxlDDobikbPH8J5vJCzjy7ZIgF5MIBZxyQmEoM/msN/Wm5CAlcRbaRz/aKObxo6wnQYdz6bFnQGmqSDkDWMztY8M4yIyn3DFBWL81Z3ytusY3PhG0xf9y9EFWME60W3RG1PQSkOZB+QX2eM6cPtIbfWRf6xAiYHLd4GT6Cs0mnOhauxD1EEzGNKza1gWeJ1tzXOBkhLHJ8F6YJL5S0NR8ek2hrSt5UtCN7Fdcei7J5H0FS0hsQlkqrFHlntyDEASu+ZA8YmrjKQR613n0nicR6iWTIR8PtUWcOMAe557AxBeFBa0xryyPPb2Wyi2bFNc2Hw5F+7XrwhZZNTxKvWN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4DA81539EC92F4F9210A5DAC9A6F23B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362890ce-196e-44be-0764-08d7613a1b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:17:28.4809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPrf7TsQ9Oh3ykCge0fsqZlA4eafjxgRKw1P2hZRSwSGyxdJrwqtGhTl7OAJH4gvhHds0EDz+W6ih9TB+KOOzL/VXYr6NJhTtokQWaWZUis=
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

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDE2OjQ4ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBBdm9pZHMgc29tZSBsb2NhbCBib2lsZXJwbGF0ZS4NCj4gU3VnZ2VzdGVkIGJ5IGNv
Y2NpbmVsbGUuDQo+IA0KPiBDSEVDSyAgIGRyaXZlcnMvaWlvL2FkYy9yY2FyLWd5cm9hZGMuYw0K
PiBkcml2ZXJzL2lpby9hZGMvcmNhci1neXJvYWRjLmM6NDk1OjEtMTE6IFdBUk5JTkc6IFVzZQ0K
PiBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UgZm9yIHByaXYgLT4gcmVncw0KPiANCg0K
UmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxv
Zy5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2Ft
ZXJvbkBodWF3ZWkuY29tPg0KPiBDYzogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNA
Z21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9yY2FyLWd5cm9hZGMuYyB8IDQg
Ky0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9yY2FyLWd5cm9hZGMuYyBiL2RyaXZl
cnMvaWlvL2FkYy9yY2FyLQ0KPiBneXJvYWRjLmMNCj4gaW5kZXggYzM3ZjIwMTI5NGIyLi42M2Nl
NzQzZWU3YWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9yY2FyLWd5cm9hZGMuYw0K
PiArKysgYi9kcml2ZXJzL2lpby9hZGMvcmNhci1neXJvYWRjLmMNCj4gQEAgLTQ4MSw3ICs0ODEs
NiBAQCBzdGF0aWMgaW50IHJjYXJfZ3lyb2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ICpwZGV2KQ0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAJc3Ry
dWN0IHJjYXJfZ3lyb2FkYyAqcHJpdjsNCj4gIAlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2Ow0K
PiAtCXN0cnVjdCByZXNvdXJjZSAqbWVtOw0KPiAgCWludCByZXQ7DQo+ICANCj4gIAlpbmRpb19k
ZXYgPSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoZGV2LCBzaXplb2YoKnByaXYpKTsNCj4gQEAgLTQ5
MSw4ICs0OTAsNyBAQCBzdGF0aWMgaW50IHJjYXJfZ3lyb2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCXByaXYgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiAg
CXByaXYtPmRldiA9IGRldjsNCj4gIA0KPiAtCW1lbSA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+IC0JcHJpdi0+cmVncyA9IGRldm1faW9yZW1hcF9y
ZXNvdXJjZShkZXYsIG1lbSk7DQo+ICsJcHJpdi0+cmVncyA9IGRldm1fcGxhdGZvcm1faW9yZW1h
cF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gIAlpZiAoSVNfRVJSKHByaXYtPnJlZ3MpKQ0KPiAgCQly
ZXR1cm4gUFRSX0VSUihwcml2LT5yZWdzKTsNCj4gIA0K
