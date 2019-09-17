Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF54B4724
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 08:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391283AbfIQGF0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 02:05:26 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:49958 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390980AbfIQGF0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 02:05:26 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8H63vjT012011;
        Tue, 17 Sep 2019 02:05:17 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v0sy95h02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 02:05:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQvhRgt1/iscwPjy4sVo3QjkantTDXoGk/j7jPEmuN6OgcbPCz2m3dLe7OoUWg95G+v1TmXC6DI1haWnVlwJbAE7r3VzxU62nf6cC46uK0r5PJf3qmVeyMXxQXwN5T3JUL7dq+bnBzSfQzis+/7cjrLh9zzOMZp9LBtcbyT2crrPgoesdSQsxT97+1mPJruKSatobrLtgzreURGtHrfF/Jy0hi7sujp/QtWLOZ+qoY+s6PqMVOoZKQgON/3o7SVKmkHArYeZAt6NRyPvhek4JggOC0GXOquW2vfcWUk3pMmmNO6fs5fitCnJPVyhHHxMMbaW4zYJKgh6sEQM0ya6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+6Kej0PWywlbLk7/futs8QlscG0Jq/zavuIB5fyv7Y=;
 b=jJlDd/b3K5OaBIvCDKAyYsN7Ko2Mp0a8mNchORP1Tm8VxVGNQJSb+aGZmrYz4ZgNYgfnq18WkfKWz/SFOJf7qWpUR0/YT8CyyX7VLEiSNapikRJ53S9XLVFn5N8A0stmJyes+EgoXKof+yRtXOas4CBQqRWt7W0m7lCUnN+zbEQemM8qp2Q+SHkaMPW/0YrvI7dPGucnN3JQX/mXRSWvFzi4RvvVlOCzO/04j+r74an2dgSdcwsStwMqPpiCzBNdDq0GTrmIqihlIWPMg6BGaz0aBGn3TTEx7oEmiVRAkRwhKVg9+MSDIX1BAIrv8dLtWzh5xUaaZZWWzDpN39JSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+6Kej0PWywlbLk7/futs8QlscG0Jq/zavuIB5fyv7Y=;
 b=ktt6MribjegogA/KP3UPkJkGo/2tjjV99GyeCCdoTxB9DE57Q4nNmiFMSu4QDqD+6WDSFZCvDPe7OBiMu1PSitvIk5fBaGZyTMz0aRVA38yfr71WIPsIay9lOVLzm8K6dc0awtA7oxy4uBi20IndD8x4XVMCnrDJm/q7VbydXIs=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5271.namprd03.prod.outlook.com (20.180.13.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Tue, 17 Sep 2019 06:05:16 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Tue, 17 Sep 2019
 06:05:16 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Thread-Topic: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Thread-Index: AQHVag+8uWmQQq3ExEyRd/qnwNwICqcuP2sAgAADYYCAAALHAIAABOiAgAAKv4CAAUSvAA==
Date:   Tue, 17 Sep 2019 06:05:15 +0000
Message-ID: <2ebd680eb38bd3bc46414a5e18e399279946bd9b.camel@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
         <20190913114550.956-4-alexandru.ardelean@analog.com>
         <20190916122505.GC4352@sirena.co.uk>
         <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
         <20190916124707.GD4352@sirena.co.uk>
         <458cbb212fbd04c157c9861501f51c03ea958302.camel@analog.com>
         <20190916134309.GH4352@sirena.co.uk>
In-Reply-To: <20190916134309.GH4352@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9bdd46e-9884-4ad4-68e3-08d73b3502b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5271;
x-ms-traffictypediagnostic: CH2PR03MB5271:
x-microsoft-antispam-prvs: <CH2PR03MB5271501AC8E77D431352B9A0F98F0@CH2PR03MB5271.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(346002)(396003)(199004)(189003)(478600001)(2501003)(256004)(36756003)(81166006)(5660300002)(6436002)(8676002)(7416002)(99286004)(118296001)(229853002)(26005)(6916009)(6486002)(102836004)(6506007)(81156014)(6246003)(6512007)(5640700003)(64756008)(66946007)(66476007)(446003)(2616005)(6116002)(476003)(3846002)(66066001)(486006)(45080400002)(86362001)(1730700003)(186003)(8936002)(76176011)(76116006)(2906002)(4326008)(66446008)(2351001)(14454004)(66556008)(7736002)(305945005)(71200400001)(71190400001)(316002)(25786009)(11346002)(54906003)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5271;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kZsGlFYYmK0WXjafWp4O0BtMkHbvEAGcueY8IC9IqUoM1X8EZiPcizWsPhD+hz3GHa9wxFdwMzHQYlQ4dxnMi+KA1Ah8y7ntFaJ1EFpbLJspZAYh3KMhcH32UyV6AofgCuFrFjqIEYp17Ql4B/tOSAf53eDCgbcYMnX/av5g54SMNswEh5BkOyA1+My00gzdUx6JJSqoC6E5Atof1nb1o+WzEHfVamXBlR7oeVVOc8tpnk2i4XiLiiEcWTRgBAo2v+gnilMi0ZDa4Dgp8K8jA6bvr7h3dUGAUBLN1iRzIkloBKxafvMvxmIAOYag9Cm3Glgn/O2kVx8SUKsAkRlutWt+DrvcHdA6DrmNhWN1emzB3CxCzdg6vQMjvGF6jHYNtrqnGREom5V3QEKORJkEuTBFnEHJCzf9UJZ1w8eAFSE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <418F646267A0C44DA315D6E3661E68FC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bdd46e-9884-4ad4-68e3-08d73b3502b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 06:05:15.8524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xrIj0E0aOd+aqAXisvroVX5E8RXhW1tEliF+YUDg06IR6FvJVAwzJxl/3PwfrHUOo6h4JuiEzP+RSbueEkgX8i6NIOSg4kcocNBg1afswg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5271
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_03:2019-09-11,2019-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909170068
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDE0OjQzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIFNlcCAxNiwgMjAxOSBhdCAwMTowNDo0MlBNICswMDAw
LCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxOS0wOS0xNiBhdCAx
Mzo0NyArMDEwMCwgTWFyayBCcm93biB3cm90ZToNCj4gPiA+IFRoYXQgdjMgc2VlbXMgdG8gYmUg
YSBzbWFsbCBzdWJzZXQgb2YgdGhpcyBzZXJpZXM/DQo+ID4gQWNrLg0KPiA+IFYzIGlzIHRoZSBm
aXJzdCA0IHBhdGNoZXMgZnJvbSB0aGlzIHNlcmllcy4NCj4gPiBXZWxsLCBwYXRjaGVzIDMgJiA0
IGFyZSBzcXVhc2hlZC4NCj4gPiBJIGFtIDEwMCUgY29udmluY2VkIHRoYXQgdGhlIGVudGlyZSBz
ZXJpZXMgaXMgYSBnb29kIGlkZWEuDQoNClNvbWV0aGluZyBoYXBwZW5lZCBoZXJlIHRvIHRoZSAi
bm90IiB3b3JkLg0KUHJvYmFibHkgZ290IGxvc3QgaW4gYW4gYWx0ZXJuYXRlIGRpbWVuc2lvbiAg
wq9cXyjjg4QpXy/CryAuDQoNCldhcyBzdXBwb3NlZCB0byBiZToNCiJJIGFtIG5vdCAxMDAlIGNv
bnZpbmNlZCB0aGF0IHRoZSBlbnRpcmUgc2VyaWVzIGlzIGEgZ29vZCBpZGVhLiINCg0KDQo+ID4g
SW4gdGhlIHNlbnNlIHRoYXQgYSBgc3RydWN0IHNwaV9kZWxheWAgbWF5IGJlIGEgZ29vZCBpZGVh
LCBidXQgYXQgdGhlDQo+ID4gc2FtZSB0aW1lLCBpdCBtYXkgYmUgdW4tbmVlZGVkLg0KPiA+IEFs
bCBJIHdhbnRlZCB0byBkbywgd2FzIHRvIGFkZCBhbm90aGVyIGRlbGF5IHNvbWV3aGVyZSwgYW5k
IGdvdCBsb3N0IGluDQo+ID4gdGhlIHJld29yayBvZiBjdXJyZW50IGRlbGF5cy4NCj4gPiBJIHRo
b3VnaHQgYWJvdXQgcHJvcG9zaW5nIGp1c3QgdGhlIGZpcnN0IDQgcGF0Y2hlcyBbb24gdGhlaXIg
b3duXSwgYnV0DQo+ID4gSSB0aG91Z2h0IHRoYXQgc2hvd2luZyB0aGUgY3VycmVudCBzZXJpZXMg
YXMtaXMNCj4gPiBub3csIG1heSBiZSBhIGdvb2QgaWRlYSBhcyB3ZWxsIFt0byBnYXRoZXIgc29t
ZSBmZWVkYmFja10uDQo+IA0KPiBJIHRoaW5rIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gcmV2aWV3
IGFzIGEgd2hvbGUgc2VyaWVzIHJhdGhlciB0aGFuIG9ubHkNCj4gYSBwYXJ0IG9mIHRoZSBjb252
ZXJzaW9uLCBpdCBkb2Vzbid0IHJlYWxseSBoZWxwIHRvIG9ubHkgZG8gcGFydCBvZiBpdC4NCj4g
DQo+IFBsZWFzZSBmaXggeW91ciBtYWlsIGNsaWVudCB0byB3b3JkIHdyYXAgd2l0aGluIHBhcmFn
cmFwaHMgYXQgc29tZXRoaW5nDQo+IHN1YnN0YW50aWFsbHkgbGVzcyB0aGFuIDgwIGNvbHVtbnMu
ICBEb2luZyB0aGlzIG1ha2VzIHlvdXIgbWVzc2FnZXMgbXVjaA0KPiBlYXNpZXIgdG8gcmVhZCBh
bmQgcmVwbHkgdG8uDQoNCkFjay4NClByb2JsZW0gaXM6IEkgaGF2ZSB0byByZS1zZXR1cCBteSBl
bWFpbCBjbGllbnQgZXZlcnkgbm93LW4tdGhlbiBzaW5jZSB0aGUNCndvcmstZW1haWwgc2VydmVy
IGhhcyBzb21lIGlzc3VlcyB3aXRoIExpbnV4IGVtYWlsIGNsaWVudHMuDQpBbmQgSSBzb21ldGlt
ZXMgZm9yZ2V0IHRvIGNvbmZpZ3VyZSB0aGlzLg0KWyBFeGNoYW5nZSBkb2VzIG5vdCBhbHdheXMg
Z2V0IGFsb25nIHdlbGwgd2l0aCBub24tT3V0bG9vayBjbGllbnRzIF0NCg==
