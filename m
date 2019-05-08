Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBBE1728F
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEHH2N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 03:28:13 -0400
Received: from mail-eopbgr00128.outbound.protection.outlook.com ([40.107.0.128]:25193
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbfEHH2N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 May 2019 03:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWKbaahYiA9lYMyegZeWHf8b2vQmLuiL+B95D4p8mLk=;
 b=cx+jDf1d2Tc/swdAuzjj69EfNTsgEVzvC64FIoFK9O8ellLAtuppmrmY4GrQC9ue0SZkLR0mvfME6+r3z++EXrv87BR+NLb8bklYwXVqHcJ894wNrZXAkORv6Y9sMiopCclSzr5MdYL/67tdrbFhVlmPjGNvatixrfIz0flGjH8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3933.eurprd05.prod.outlook.com (52.134.4.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Wed, 8 May 2019 07:28:05 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571%5]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 07:28:05 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH 1/5] iio: stmpe-adc: Add compatible name
Thread-Topic: [PATCH 1/5] iio: stmpe-adc: Add compatible name
Thread-Index: AQHVBOJChjWKjOCYJEK9rCCD5+wLmaZgzdmAgAAHiAA=
Date:   Wed, 8 May 2019 07:28:05 +0000
Message-ID: <0cf03cb66eebb1aa87a4460f96db5cadab47392c.camel@toradex.com>
References: <20190507143615.28477-1-dev@pschenker.ch>
         <20190508070107.GG7627@dell>
In-Reply-To: <20190508070107.GG7627@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddaba678-98d0-4676-a0d7-08d6d386b649
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR0502MB3933;
x-ms-traffictypediagnostic: VI1PR0502MB3933:
x-microsoft-antispam-prvs: <VI1PR0502MB3933A22E607CF338585F3446F4320@VI1PR0502MB3933.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(305945005)(6246003)(2351001)(7416002)(36756003)(14454004)(86362001)(6116002)(6506007)(6486002)(68736007)(4326008)(3846002)(6916009)(53936002)(229853002)(44832011)(2501003)(478600001)(25786009)(11346002)(446003)(6436002)(2906002)(14444005)(102836004)(5640700003)(186003)(118296001)(2616005)(7736002)(5660300002)(76176011)(99286004)(316002)(91956017)(486006)(73956011)(64756008)(66476007)(81156014)(76116006)(8676002)(66556008)(66446008)(66946007)(4744005)(54906003)(81166006)(6512007)(476003)(71200400001)(71190400001)(256004)(26005)(8936002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3933;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vP6X/d4d8ipD7XPGF7pXKL7U/j493agGxP5tq5U58tT/kegeV2D96FB8i+yqZP0j5ytWjuDDu4e+DSgJw3Rd5GuNzWNRIPgMoICAPMeThjEdV2vYIjWgoH+0PaZHqgm3hUgKOqHigHBwXDyDNb/oZLDi5pkRJjKAZKEl2Zg/XYPux/xHGdx5jes4Lg5eN5cAbevBDONQRVF7j8S6ylwWY6miJ91dydVOFVmN69+zR2b7xx8JRei5D7NjFIQlAAJvaTD53SFuNGj+Jn4XV98WUDVvJlTZ3BDv20HDy+w7FUrkoo6HAGSFtOqdbCDIlAPTyRzr8qWdzZxdXlrKINCvyMMD6F8z5xfSilFh7hdKUuQAMq/CVwcvbCi1ALIP7C+yfiAHqtLBh4P391yTt0msSuNKbSFyVVCfrXVQv+wlHi4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14D6D287240A1F4587BD207F33A3EE13@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaba678-98d0-4676-a0d7-08d6d386b649
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 07:28:05.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3933
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTA4IGF0IDA4OjAxICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFR1ZSwgMDcgTWF5IDIwMTksIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiANCj4gPiBGcm9t
OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gQWRkIHRoZSBjb21wYXRpYmxlIG5hbWUgdG8gdGhlIGRyaXZlciBzbyBpdCBnZXRzIGxv
YWRlZCB3aGVuIHRoZSBwcm9wZXINCj4gPiBub2RlIGluIERUIGlzIGRldGVjdGVkLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0
b3JhZGV4LmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiAgZHJpdmVycy9paW8vYWRjL3N0bXBlLWFk
Yy5jIHwgNyArKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IFdoeSBoYXZlIHlvdSBzZW50IHRoaXMgc2V0IHRvIG1lPw0KPiAN
Cg0KZ2V0X21haW50YWluZXIucGwgcmV0dXJuZWQgeW91IGFzIGEgY29tbWl0IHNpZ25lci4gWW91
IHNpZ25lZCB0aGUgaW5pdGlhbCBjb21taXQNCm9mIHRoaXMgZHJpdmVyIGFuZCBwdWxsZWQgaXQg
YmFjayB0aGVuIGJlY2F1c2UgaXQgaXMgcGFydCBvZiBhIG1mZC4NCg0KUGhpbGlwcGUNCg==
