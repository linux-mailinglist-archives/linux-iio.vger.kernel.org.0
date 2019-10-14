Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9123CD5CA1
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfJNHuk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 03:50:40 -0400
Received: from mail-eopbgr20129.outbound.protection.outlook.com ([40.107.2.129]:63179
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729234AbfJNHuk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Oct 2019 03:50:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpXKPfH4r10DgBWZW0SelJOH4jMA+FbDwBO+BtFMqZhwGWzZC1hMng8U00np3ffukyeQKPsj4AsYgiHRFdCsuiCe6HqSTEz8CkPFykPN26C5dkeRLKO5BdcOroWzxGJs3q9jW4jGyMTM1/N/bQ26W1KbpE7FL3AD31UYtQk/RYqjt5Vz9v1FyBo6D/GcbXP1DMClCbMWWJjhEE88wcTv0jIvK0cdfLs2ofVd1c/d9ToMmJ56EP/vIMH8dhRagnsQyeFbiPci0vMuOsIrqB5iHA85iNbIQdMuchl4xnr3RPXSsEhfp/X4CVbc7HT0T+M5l0gT2oQEDTahVnuEvXrk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WBVmYjsOu9FLRwgo4QIHPks1HVa2JcnFv2o3JigGZ4=;
 b=OARPhpJIeRiu99feHcoDPkJSrBSCVBweJIF6DPK/7jFRX1qN6eo1tQn3I2RywHO8mcfhZGO7Laih4Is4BRFFSGvsV2ZdsF3hnVxRow2uHCOc/hBNhM8ejfWhrpsSAhXK2lmFtCkgL6GNOqEHrtI/5fGJPWjn7hM0dXxzHDfCmPAfMBFTkxAESmKSVvcdXd+gLdwNs358DOaD2K+au2y4BGl06QTCzHbRHrGQglHOv4tfe0Zi28AWDTN4mhD344gpBkHhMj5JdLuGStpBn2nq6003CZyFAzl4mRJ45DLsF6t82nrQGb8d8hQotm8wx2Hl93e4Xm0U5tVSE4e2O0NyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WBVmYjsOu9FLRwgo4QIHPks1HVa2JcnFv2o3JigGZ4=;
 b=oB5DTAra4EcQFTOKvdKq2JvthGPKUR73HICxPgOecvyyh2rlmYcadTZ69H8Fj7FR+kUXvU4gQ+RLcSx6nmBhZvSMTUdhLrZNW4HfuyJWTu9ITQ2xf5Ly9zWhjqpj5WFbUGrbk/okq39B4FPmhnDAFXjzuTXBtCxGMq0cOHVl9jc=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB3968.eurprd05.prod.outlook.com (52.134.17.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 14 Oct 2019 07:50:33 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 07:50:33 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio:adc:stmpe-adc: Cleanup endian type of local variable
Thread-Topic: [PATCH] iio:adc:stmpe-adc: Cleanup endian type of local variable
Thread-Index: AQHVgacZS+BiyquXjUitaUpMn4+RkKdZxM0A
Date:   Mon, 14 Oct 2019 07:50:33 +0000
Message-ID: <28f616a36507f0473aa37857fe58f3763bee4f5e.camel@toradex.com>
References: <20191013091541.1382009-1-jic23@kernel.org>
In-Reply-To: <20191013091541.1382009-1-jic23@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e59fcf42-bef6-4403-104f-08d7507b312e
x-ms-traffictypediagnostic: VI1PR0502MB3968:
x-microsoft-antispam-prvs: <VI1PR0502MB3968CE24FD15D193150361F6F4900@VI1PR0502MB3968.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:212;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39840400004)(376002)(346002)(366004)(396003)(199004)(189003)(6436002)(3846002)(305945005)(81166006)(118296001)(86362001)(4326008)(7736002)(8936002)(76176011)(110136005)(81156014)(6116002)(99286004)(6512007)(6246003)(6486002)(229853002)(8676002)(316002)(76116006)(6506007)(66946007)(66476007)(446003)(11346002)(66446008)(64756008)(66556008)(14454004)(102836004)(186003)(26005)(36756003)(71200400001)(4001150100001)(486006)(476003)(2616005)(91956017)(2906002)(5660300002)(256004)(25786009)(14444005)(71190400001)(44832011)(2501003)(66066001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3968;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPg92MiwVP5qCRM/v5zH6y6CzYKc1P2FD+KklEX6sDCq1pkAFgLljFgXbQ2D03DUIiMdTWJWkgykAl+HTNtorVOfhBnvKmfkaPf+xOX6f/vqPs5JvHPTeY2eXnhvB0Rsg2zEaC3nn0SSi8VJ0r6e/yEDb3DLX6u+Tx15XSBrlPLGs+wZYx226JMg4eAnRKdPGoU9Iv5P6FpvjZdnkdtPmGDRJHCiiZJeERvTDcKlL/4ZpeUyRUPAyiIcbuNG2OWfAishv5PIsZr2OYz50iEmXXkwbZq0QPujnYtgDBbxRalio49IMLFz4qpgbWW+YnfrWhZbTnyesb/UAqA5mpTY2pBdd+xY2wi/zp59S0bmIOGApUteau+B9GopXm4BA4X3SnYjKd96KuB7ooOHKO4eZGm9CBFbX2o856Gt4cIqC4s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0EAAE2680D50A42BE9BEF145C1E551C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59fcf42-bef6-4403-104f-08d7507b312e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 07:50:33.1487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faM+nyxHg4hTyATGMXPHFcAvwY9uaTcTrSXyY7tfNliLINC9iQuUFwOm6SmS1fmxAslWhZ0jsefG4ElofZsJhUjp3MptrBkyzzLOG/ibOW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3968
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDEwOjE1ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBOb3RoaW5nIHN0b3BzIGRhdGEgYmVpbmcgb2YgdHlwZSBfX2JlMTYsIHdoaWNoIGZp
eGVzIHRoZSB3YXJuaW5nOg0KPiANCj4gQ0hFQ0sgICBkcml2ZXJzL2lpby9hZGMvc3RtcGUtYWRj
LmMNCj4gZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jOjIwMjoyOTogd2FybmluZzogY2FzdCB0
byByZXN0cmljdGVkIF9fYmUxNg0KPiBkcml2ZXJzL2lpby9hZGMvc3RtcGUtYWRjLmM6MjAyOjI5
OiB3YXJuaW5nOiBjYXN0IHRvIHJlc3RyaWN0ZWQgX19iZTE2DQo+IGRyaXZlcnMvaWlvL2FkYy9z
dG1wZS1hZGMuYzoyMDI6Mjk6IHdhcm5pbmc6IGNhc3QgdG8gcmVzdHJpY3RlZCBfX2JlMTYNCj4g
ZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jOjIwMjoyOTogd2FybmluZzogY2FzdCB0byByZXN0
cmljdGVkIF9fYmUxNg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9u
YXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiBDYzogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQpUaGFua3MgZm9yIGZpeGluZyB0aGF0Lg0KDQpS
ZXZpZXdlZC1ieTogPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQo+IC0tLQ0KPiAg
ZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vYWRjL3N0bXBlLWFkYy5jIGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jDQo+IGluZGV4
IGJkNzI3MjdmYzQxNy4uMGY4ODA0OGVhNDhmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9h
ZGMvc3RtcGUtYWRjLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jDQo+IEBA
IC0xNzUsNyArMTc1LDcgQEAgc3RhdGljIGludCBzdG1wZV9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2Rl
dg0KPiAqaW5kaW9fZGV2LA0KPiAgc3RhdGljIGlycXJldHVybl90IHN0bXBlX2FkY19pc3IoaW50
IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiAgew0KPiAgCXN0cnVjdCBzdG1wZV9hZGMgKmluZm8gPSAo
c3RydWN0IHN0bXBlX2FkYyAqKWRldl9pZDsNCj4gLQl1MTYgZGF0YTsNCj4gKwlfX2JlMTYgZGF0
YTsNCj4gIA0KPiAgCWlmIChpbmZvLT5jaGFubmVsIDw9IFNUTVBFX0FEQ19MQVNUX05SKSB7DQo+
ICAJCWludCBpbnRfc3RhOw0K
