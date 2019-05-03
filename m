Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC11319B
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfECP6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 11:58:44 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com ([40.107.2.139]:59205
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfECP6n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 May 2019 11:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh4TWYCzlC9xrPM3UNENXZxpnGU5mMj6FMHQ1Y4TBk0=;
 b=Uhm4PoxnO1NrfEwqpXK4NpMeSuPFObQfQfUksbq25tDwjf2jZtDa3FQsZwHELXjlvo5rhrJ31FBz7ZTOjEVdYj+qIDy2+vUAmFJNo2XEeOXoE3nJecYMXtHvqdRptPAEmfHzev/FJw7BMPV7Hak6ePlQa+e8nA7gDm7kRqZ265w=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3997.eurprd05.prod.outlook.com (52.134.18.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Fri, 3 May 2019 15:58:38 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571%5]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 15:58:38 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
Subject: Re: [PATCH 2/3] iio: stmpe-adc: Make wait_completion non
 interruptible
Thread-Topic: [PATCH 2/3] iio: stmpe-adc: Make wait_completion non
 interruptible
Thread-Index: AQHVAbgvhKEqeNeMGUGopQqxfyxbHKZZeJoAgAAWGIA=
Date:   Fri, 3 May 2019 15:58:38 +0000
Message-ID: <1aa6533aa8b1bf4a01c1c5f8d6a208337be6b57e.camel@toradex.com>
References: <20190503135725.9959-1-dev@pschenker.ch>
         <20190503135725.9959-2-dev@pschenker.ch>
         <0aab3e91bb9644acb430a8beba927b5a@AcuMS.aculab.com>
In-Reply-To: <0aab3e91bb9644acb430a8beba927b5a@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eff7935f-2724-47bd-6700-08d6cfe034ef
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR0502MB3997;
x-ms-traffictypediagnostic: VI1PR0502MB3997:
x-microsoft-antispam-prvs: <VI1PR0502MB3997C1CABA11DD642F92660EF4350@VI1PR0502MB3997.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39840400004)(376002)(396003)(189003)(199004)(118296001)(186003)(2616005)(476003)(2906002)(102836004)(6116002)(11346002)(66556008)(4744005)(4326008)(2201001)(76116006)(66946007)(68736007)(6506007)(64756008)(305945005)(66446008)(8676002)(86362001)(6512007)(73956011)(91956017)(486006)(44832011)(7736002)(7416002)(66476007)(26005)(446003)(71200400001)(71190400001)(8936002)(6246003)(66066001)(53936002)(81166006)(6436002)(81156014)(2501003)(76176011)(25786009)(6486002)(256004)(478600001)(36756003)(316002)(229853002)(99286004)(5660300002)(3846002)(110136005)(54906003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3997;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: myoox2xZjx8TtCFEYinRg24d5HwpcC9H2dir7ZMbDkf5CouobEi6Lkpt+fZFzqmo+Vq7FqRqClsAClDejNUVorIb1akDCTqjGHCTgdJC8CQeM37Q79IQqF9T1AymM6NLcKts+B7rwXyK/ey16QKsqRgEQe74v4eHHflZDgiHm/uLblxjZSfuAJ4lUDxPYfiQBi3NwJf1BNOqK10mGRo2xc7ivc86qom0N+qdj7Xpv4NcxI/gpl11NEivhx4uwN4hLN4LFLf1mj26egxcY1I4JLxukluh+gXL2bEIU1pDa/KdNoPOrX2rZuwLnzx5BvWthX2wD9uo/NEFzzZ30a8hK5R7BxuMlP1MNGjY/GaiJhkm3RUXny4zrK2QD9k7ZdSSRiQw593HlQgO8So1slHGMwiUmojvyOFRdpRZTuHa4t8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30EE247C42402344A09AFA35C0A279BA@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff7935f-2724-47bd-6700-08d6cfe034ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 15:58:38.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3997
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDE5LTA1LTAzIGF0IDE0OjM5ICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+
IEZyb206IFBoaWxpcHBlIFNjaGVua2VyDQo+ID4gU2VudDogMDMgTWF5IDIwMTkgMTQ6NTcNCj4g
PiBJbiBzb21lIGNhc2VzLCB0aGUgd2FpdF9jb21wbGV0aW9uIGdvdCBpbnRlcnJ1cHRlZC4gVGhp
cyBjYXVzZWQgdGhlDQo+ID4gZXJyb3ItaGFuZGxpbmcgdG8gbXV0ZXhfdW5sb2NrIHRoZSBmdW5j
dGlvbi4gVGhlIGJlZm9yZSB0dXJuZWQgb24NCj4gPiBpbnRlcnJ1cHQgdGhlbiBnb3QgY2FsbGVk
IGFueXdheS4gSW4gdGhlIElTUiB0aGVuIGNvbXBsZXRpb24oKQ0KPiA+IHdhcyBjYWxsZWQgY2F1
c2luZyBwcm9ibGVtcy4NCj4gPiANCj4gPiBNYWtpbmcgdGhpcyB3YWl0X2NvbXBsZXRpb24gbm9u
IGludGVycnVwdGlibGUgc29sdmVzIHRoZSBwcm9ibGVtLg0KPiANCj4gV29uJ3QgdGhlIHNhbWUg
dGhpbmcgaGFwcGVuIGlmIHRoZSBpbnRlcnJ1cHQgb2NjdXJzIGp1c3QgYWZ0ZXINCj4gdGhlIHRp
bWVvdXQ/DQo+IA0KPiAJRGF2aWQNCj4gIA0KPiANCj4gLQ0KPiBSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwNCj4gVUsNCj4gUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCj4gDQoNCllvdSdy
ZSBvZiBjb3Vyc2UgcmlnaHQuLi4gVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4gSSB3aWxs
IHNlbmQgYSB2MiB3aXRoIGENCmJldHRlciBzb2x1dGlvbiB0aGVuLg0KDQpQaGlsaXBwZQ0K
