Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E847310E7A8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 10:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLBJ2x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 04:28:53 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:49826 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfLBJ2w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 04:28:52 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB29SXMW007099;
        Mon, 2 Dec 2019 04:28:33 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2058.outbound.protection.outlook.com [104.47.33.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wknx8mf2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 04:28:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFptdh+mnwIxmIhJxkHg+llyKiUBcrE0/8ce6eXot5gy1r53zF7P7LwhuJeqyaDjPKD5rOM2TUBUu5HcyshaIhgm9mNGhx4vYnyX2rH23yXZqNQhmgvVH9suZE7ibmQVqzb4XbAMQZoyHUfuZU/e+GxyGLyy5TVdo/LJ0JOGbcHEXUprX4OrfmuZnQTCB3+zEGS4sWsVJHiBqiwyqmoFF5F3VEsKXbIZqpiQxzjPTQkq/q39zIrsJ0EmMvGeJPpNA3kXikRWp0iSU8ioreA7qnQ82MIGPYexiDhq7gbjtSWPTo3vvDl9HUfVxsWWpiItquQeW0QA60+Z0iWezJ+k1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWfjXkWtxx+ZeDY/5f64qWtRBeNiXPobFEzTeHpcnGE=;
 b=S83eMB4rFD8eV1XsvQDulOh0llN1zDazjBPoyCLqssbxKemBG+3xSHDlxHI3RsJh/0/V2eTORAKmWcjyU+l8kOaKGhjf26WjGUzA9g6aoR/M5pD6U18wiINxBK38tOmo0SKrpWizZBBe53wSThCvkVvQ01eviSNoiNZSxTJWM+sp317pwD9eum26nizcstsaobqgPvVdgV8hdHNcnYWb4hRSOQR7haZnsl7Z/mR5WwaiL87W8BOuxyDK2F4pfO7Ie7BaIOQmpPngclFgOFSxpiRYRpzaORYHGIlqvExot/QleD8Ey5orO/7+aYCg2zv7mUfxLMUHfWmuaBqCsCe7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWfjXkWtxx+ZeDY/5f64qWtRBeNiXPobFEzTeHpcnGE=;
 b=UyF1pD1nqgb54FVLpob+1qh5zcBn9jnNknu+X3xJaTlvt+HeB8P1QB8Si4bX9vG5sdu9GFgI/RtjEYQlykt4A2z6gC1s7E8d8R7+X35yw+n0348TvInSX94RNZJ9Fltjnwlr/56ZJzmFwDQg+h9EdhdxXNrqYOHqQ5J7dL8zwZc=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5160.namprd03.prod.outlook.com (20.180.5.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 09:28:32 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 09:28:32 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: adf4350: Convert to use GPIO descriptor
Thread-Topic: [PATCH] iio: adf4350: Convert to use GPIO descriptor
Thread-Index: AQHVqOv1cwNidedCWUeTjYwZZfnRfKemiXyAgAAHFwCAAAOnAA==
Date:   Mon, 2 Dec 2019 09:28:32 +0000
Message-ID: <75b6824b87bc75b968f4dc1a616c68e686068d88.camel@analog.com>
References: <20191202083830.71572-1-linus.walleij@linaro.org>
         <a1be250ce3e9a89e5a352390e16504ce8e017dbe.camel@analog.com>
         <CACRpkdYUz0yrJ_cB9rq1u+KUFUw_DOCwzAec340BgaHV_cdcuA@mail.gmail.com>
In-Reply-To: <CACRpkdYUz0yrJ_cB9rq1u+KUFUw_DOCwzAec340BgaHV_cdcuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0f16f2e-0de9-460d-fe1f-08d77709ff9c
x-ms-traffictypediagnostic: CH2PR03MB5160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5160A865AD5286B0E7CEC78CF9430@CH2PR03MB5160.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(51914003)(189003)(199004)(186003)(86362001)(229853002)(6436002)(6916009)(6246003)(71190400001)(71200400001)(478600001)(5660300002)(6512007)(6486002)(14454004)(76176011)(66946007)(4744005)(66476007)(66556008)(66446008)(64756008)(5640700003)(102836004)(36756003)(76116006)(6506007)(53546011)(25786009)(7736002)(2906002)(54906003)(8936002)(305945005)(81166006)(118296001)(316002)(2501003)(14444005)(2616005)(4326008)(446003)(11346002)(256004)(66066001)(8676002)(2351001)(3846002)(6116002)(26005)(99286004)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5160;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sorWtCUkgqJMbKCHLUTZj5jYOSPAPWGfZJ5Lyn7a2sMVlLLdL38y2s0j1ShrmBVvCqsuLYlMldWjPDh+NPkg5inE+w5EFtc2GJDGhlp5ySWWoaJf1bFiljtT3mGnomRXAayhVo6pI/E1G9BZq87LNqqDDlHD9hZ6+u47ggv/lQXQA4boE9D+oS3fbXFisehm4jjPU+J2J0zjOZPeYw0T5F7uirKPTsZobs4kBrVBbie1MIDZDpqbImZMD+NFhEyFpQPFHz79RTGFCszlHfE0DCnmg6N2eyLcbL4KpsoVhIFl2H37j+rgnKoZDskyiCQdSHrTxNdlDSEKSvm/MTmUk+hemUQLWoP2mCWgZT97H7q7hjjC9lkZ4jRqg4yLwLxQ2+bQVB1RUF1iyPMaazH3biXAavpLYtaeHeCz05OsxLtcYojHx31KIK0Q9nsQD962
Content-Type: text/plain; charset="utf-8"
Content-ID: <40A6626585CC65468A644F9DA74D8415@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f16f2e-0de9-460d-fe1f-08d77709ff9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 09:28:32.1909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1Fjjs6YDoodKHsij3Kv1DCweimO+SMrKcntthtjuFHTVZqc1ye74YFAtXTWOHpvOQZFeALyrmpAoJH+ydvVgS1kUNw8TcuMxupSUJ8Kz5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5160
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_01:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=940 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020086
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTAyIGF0IDEwOjE2ICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBNb24sIERlYyAyLCAyMDE5IGF0IDk6NTAgQU0gQXJkZWxlYW4sIEFsZXhhbmRydQ0KPiA8
YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiA+ICsgICAgIHN0
LT5sb2NrX2RldGVjdF9ncGlvZCA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKCZzcGktPmRldiwN
Cj4gPiA+IE5VTEwsDQo+ID4gDQo+ID4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBuYW1lIHRoZSBH
UElPIGhlcmU/DQo+ID4gTWF5YmUgbmFtZSBpdCAibG9jay1kZXRlY3QiPw0KPiA+IA0KPiA+IEkg
ZG8gcmVhbGl6ZSB0aGF0IHRoaXMgZ29lcyBpbnRvIHRoZSByZWFsbSBvZiBjaGFuZ2luZyBzb21l
IGRlZmF1bHQNCj4gPiBiZWhhdmlvci4NCj4gPiBBbmQgSSBhbSBub3Qgc3VyZSBob3cgYWNjZXB0
YWJsZSB0aGlzIGlzIFtnZW5lcmFsbHldLg0KPiANCj4gWW91IGNhbid0IG5hbWUgaXQgaW4gdGhl
IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKCkgY2FsbCBhcyB0aGlzDQo+IGluZGljYXRlcyB0aGUg
bmFtZSB0aGUgR1BJTyBsaW5lcyBoYXZlIGluIHRoZSBkZXZpY2UgdHJlZS4NCj4gDQo+IFdoYXQg
eW91IGNhbiBkbyBpcyBhZGQgYSBjYWxsIHRvDQo+IGdwaW9kX3NldF9jb25zdW1lcl9uYW1lKGdw
aW9kLCAibmFtZSIpOw0KPiB0byBleHBsaWNpdGx5IG5hbWUgdGhlIGxpbmUuDQo+IA0KPiBUaGlz
IHdpbGwgb25seSBhZmZlY3QgdGhlIG5hbWUgYXNzaWduZWQgdG8gdGhlIGxpbmUNCj4gaW4gZGVi
dWdmcyBhbmQgaW4gdGhlIHVzZXJzcGFjZSB0b29scyBsaWtlICJsc2dwaW8iLg0KPiANCg0KQWNr
Lg0KVGhhbmtzIGZvciB0aGUgaW5mby4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVh
biA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCg0KPiBZb3VycywNCj4gTGludXMg
V2FsbGVpag0K
