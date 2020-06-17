Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662A51FCEA9
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jun 2020 15:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFQNh0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jun 2020 09:37:26 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:58576 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgFQNhX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jun 2020 09:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592401043; x=1623937043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4kXpZB9P0pBc+yiLVeSjIxvlobE5TiSDapH3MZnS004=;
  b=Vf8mqMwO4I3eRwJKFdbz9WIHwZKZz8vJ2jrWFeovRPzOBei+R0JiCsZC
   nvK1QEl69lbpnd9rIpcZKFJHgSj+ijG0JeYpurCRVVaUS7pryBzGukXQA
   0mdaq9AHyAhgin3/9WlxtOidNZBUsRS7kWbTmlzvkNfV176FN4qk37P+1
   puuLaQ4oPcp6m63+suyvtIgO7V3wN5E21fckxpAQxL3bKl2Rhfp17o048
   xXPDhaZqTwi+oV6g/lEzZPfUNHdPsmMmUyThLbGPHlt2Vdp/c50kXedW+
   tKZnTFcNodw7C/rLeCvHSRbXXSlobaqzhRv5hb4Qq1KzJQA/E6PUAzCcm
   Q==;
IronPort-SDR: fILc0E98FNgaklmPfaeOkcY184oGfxyq90TKXYKr7NpEsHdv7OiKLWCrkiHSHzmWEvAk1FBa3n
 uGPz0f8ncif2vg900EeBWJVgsh1ICd+9TOpHYbai2U6v+O4Dxe5GBZ5uQld4QiZ7Jr04N3ZrRd
 g9c+fAOMQDTtFBiWzLw0aZYWnLlkhkJUxx38kasik1gFGPW08eCP8hAkuzu1OKS6zyNveKKAIp
 iYBN82+7qicsA7d6V5D7z1wuDZB9b4W63gQ7wKbZbLk8KioCo1g05yrPyGiSQYu3ehUO410K7Y
 z9U=
X-IronPort-AV: E=Sophos;i="5.73,522,1583218800"; 
   d="scan'208";a="80465785"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2020 06:37:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 06:37:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 17 Jun 2020 06:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZg5aNbSiHMVqyj+lnIgZOsprEM6Ijouq7A2ylsuGj1/PjRpcSVI/xTNv7Vs73Y0y8aRTxy+riFuU7VP9HUiIzHT6GVl1FrmVOtHhdMoQrxcckneD7yNb8R/R1+ZPOfWobHy6s9tog91I2fNunWOxdJHKpdMJkomW+pEmz55XTfBCLSk68h+jn+DV44aiovEw/MsbDqSxZ0y/LbLfv0FdKre4YJclDS9inujlfd6FV2cf3pkeCFkcc+EVgM4sz6uFXZ4T4towCKtVSIyszx4tQ4kns+S6G3C6A1yBTVF+jEbB4/yfFen3LSnjZxtxepMsTuJTkX+Bg9gjwy1RGhm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kXpZB9P0pBc+yiLVeSjIxvlobE5TiSDapH3MZnS004=;
 b=BNpBLrYADI0+f5ML8RcSbxJ0Tmo61Pi/1/ag6R4EZKVjU+gOGkvnRGYr/MUvW1t5NdYbniDYSggG0BNYChBUsY1q2fBlVndyVw/QYqy1A3SBmLjzJtWNlIw0SILT3k4fbDqc2PaD7kjl5dtUZJBJ8qhJ9C3CosmMLWiFz508NUKP9Y3aUXmGhiUEXlMTTQwy5aMt9xfie0fRmv8XD7yh5c7x92Xid8HME5BBuR2/9VFPyiYJgrj+cEz+UfQRNTlfV/LDWH64Ic/V4Vcqi7C0p7Y2CI+xYEwU/bw0TCt9ev5m3uN433rZ+ZrViapOraBCtfd2OIuKeouHDj04ybPymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kXpZB9P0pBc+yiLVeSjIxvlobE5TiSDapH3MZnS004=;
 b=ElJIaWxrMDq/lLdYxQK/1VRqFhlbOAmYJu+vbf2Hh7313LaKs+IVFTMsvjZ7F9DfEjwO6fdQ5vAWb80Wz5A/wekOxqra1cZzxCMQk/EEhpeBDf2JcP6rb+d9abAzDzqCU8mBEHySYDcyKP/AZr19IajsrIxBibCrJ9RpGnqGR8k=
Received: from BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17)
 by BYAPR11MB3735.namprd11.prod.outlook.com (2603:10b6:a03:b4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 13:37:20 +0000
Received: from BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::996a:3417:7ea7:2b8f]) by BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::996a:3417:7ea7:2b8f%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 13:37:20 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Jonathan.Cameron@Huawei.com>, <alexandru.Ardelean@analog.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <s.hauer@pengutronix.de>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-kernel@vger.kernel.org>,
        <songqiang1304521@gmail.com>, <mcoquelin.stm32@gmail.com>,
        <lorenzo.bianconi83@gmail.com>, <shawnguo@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Topic: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Index: AQHWMotBwkWaCEB0Gky7JFtHaSPpIajCXn4AgAKhXICAABHNAIAX4hqA
Date:   Wed, 17 Jun 2020 13:37:20 +0000
Message-ID: <37ef45f4-9330-86ea-77c1-3138bb88601b@microchip.com>
References: <20200525113855.178821-1-alexandru.ardelean@analog.com>
 <20200525113855.178821-3-alexandru.ardelean@analog.com>
 <20200531164020.765822dc@archlinux>
 <a0253d719a4390f65668789e5fc182ec19355f17.camel@analog.com>
 <20200602095406.00005add@Huawei.com>
In-Reply-To: <20200602095406.00005add@Huawei.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef27a1b7-5097-4a13-22b7-08d812c38f1d
x-ms-traffictypediagnostic: BYAPR11MB3735:
x-microsoft-antispam-prvs: <BYAPR11MB373561FEDC78EF5B875C87ACE89A0@BYAPR11MB3735.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tsr+jiuG8/VpaQSmIBJ2Qa/y9libdgNUF4GnItW04o6UtMwQY1im5bMNjhfma3/AWWR9rbw6j18dZ2Jod5ORMSOngoJKyuj5LJ1avGB0PurWXBkG+Sp/m1nUl3YZNaibXzQ+3vdKImh7ow3lzQ1uQuKO4/4eqpIxvpSPQfJPfRco5Eo4Pe+Y1iy1c997bNDiMGHkY92xi8UNhBbV+9aUvRCNcTEzkCxIdhb20VJqW5BYWVle6hbdFoAZywjX3Xse1JTvhq1/t3/Qy9ksuFYa5/ASJU7o4E3FxJqm4zo4BtGXgvcrS2Y1Wyk2DURf0OwuFZkN4vxsWcjqkIx6xaMfJk/Ecd7Cj3F6zqqfki9s9XkaBr/1l3xO/+IXxKu/xZcstwHzan/gvZaBh3Yp6n9gv/wHAY3QL2uMqtEMgY+pECyi/vUQB39+cCRkJbAFTLuSqZfbJ6g3yxnLa7t6yytpgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(5660300002)(316002)(86362001)(31686004)(6512007)(110136005)(54906003)(31696002)(4326008)(186003)(71200400001)(26005)(76116006)(66446008)(91956017)(66946007)(8676002)(2616005)(966005)(478600001)(6486002)(6506007)(64756008)(36756003)(53546011)(66476007)(66556008)(83380400001)(8936002)(7416002)(2906002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Sjk2i0SLQ0CK9cJyAaulNF0mmbRePUV3JiIqCptjxEwO7da4J/Pv7Z9Qxbp6wZwTVi2pd2F1wlshqIW37wO5jIEy2JRyek0naQp3I/9xCasG6iIUWg1J/0RQXmksI9E0pEZzyb43M6gUtaex3bn+gQ+LimLx18RyM1/Dx9yAAa5XmskItfJt+OF/u8iZb5nja0PC51x6E7SpHKfWTiW+vkwhoCHV9HYIW6NXR9Cqwt9gv5yYhlmyAbDpMmpRHG37bLWiqxtkYiQzQ0bXeVBKb3ZGNK5uwAWAsit8kwwNj1+TsPqQH1ni2uLCw0U88OXkLgKzNBvL9sF0N9zroxqYjaZH/NO0qYKJYe1zf4lb21D0iEir3weWz/RMPtaiYc8w5GT4Gc1LbC39HX7iSK7/X+0627Tn73c1UvLQ2ER2CL6z80/stmPgd3nu34XQFzrS24n7u+iyoTB0n9X653vR93c16XiBvA6x7qUaX/lbJ7c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D88C4ED3D8692B41936B609D729F0945@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ef27a1b7-5097-4a13-22b7-08d812c38f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 13:37:20.1109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjqaIn2a+IUb/KYp16Lx6nMTqgOmCkuDa12SmdM023JKEjj6NM+mKPb41/byS74gsSbn6jpUydRgGvbjesIVKve8ZYMub3W+ljI039nYpHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3735
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMDIuMDYuMjAyMCAxMTo1NCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gVHVlLCAy
IEp1biAyMDIwIDA3OjUwOjIzICswMDAwDQo+ICJBcmRlbGVhbiwgQWxleGFuZHJ1IiA8YWxleGFu
ZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4+IE9uIFN1biwgMjAyMC0wNS0z
MSBhdCAxNjo0MCArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4+PiBPbiBNb24sIDI1
IE1heSAyMDIwIDE0OjM4OjU1ICswMzAwDQo+Pj4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5k
cnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+Pj4NCj4+Pj4gRnJvbTogTGFycy1QZXRl
ciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+Pj4+DQo+Pj4+IFRoaXMgcGF0Y2ggc2hvdWxk
IGJlIHNxdWFzaGVkIGludG8gdGhlIGZpcnN0IG9uZSwgYXMgdGhlIGZpcnN0IG9uZSBpcw0KPj4+
PiBicmVha2luZyB0aGUgYnVpbGQgKGludGVudGlvbmFsbHkpIHRvIG1ha2UgdGhlIElJTyBjb3Jl
IGZpbGVzIGVhc2llciB0bw0KPj4+PiByZXZpZXcuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPj4+
PiAtLS0NCj4+Pg0KPj4+IEZyaWVuZCBwb2tlLiAgVmVyc2lvbiBsb2c/DQo+Pg0KPj4gVmVyc2lv
biBsb2cgaXMgaW4gdGhlIGZpcnN0IHBhdGNoLg0KPj4gSSB3YXMgd29uZGVyaW5nIGlmIEkgb21p
dHRlZCBpdC4NCj4+IFNlZW1zLCB0aGlzIHRpbWUgSSBkaWRuJ3QuIEJ1dCBJIGFkbWl0LCBpdCBw
cm9iYWJseSB3b3VsZCBoYXZlIGJlZW4gYmV0dGVyDQo+PiBoZXJlLg0KPiBBaCBmYWlyIGVub3Vn
aC4gIFRoYXQgd29ya3MgZmluZSBpZiB0aGVyZSBpcyBhIGNvdmVyIGxldHRlciBidXQgbm90DQo+
IHNvIG11Y2gganVzdCBwdXR0aW5nIHRoaW5ncyBpbiB0aGUgZmlyc3QgcGF0Y2ghDQo+Pg0KPj4+
DQo+Pj4gT3RoZXIgdGhhbiB0aGUgd2lzdGZ1bCBjb21tZW50IGJlbG93ICh3aGljaCBJJ20gbm90
IGV4cGVjdGluZyB5b3UgdG8NCj4+PiBkbyBhbnl0aGluZyBhYm91dCBidHchKSB3aG9sZSBzZXJp
ZXMgbG9va3MgZ29vZCB0byBtZS4NCj4+Pg0KPj4+IFRoZXNlIGFyZSBvYnZpb3VzbHkgbm8gZnVu
Y3Rpb25hbCBjaGFuZ2VzIChJIHRoaW5rKSBzbyBpdCdzIG9ubHkgcmVhbGx5DQo+Pj4gcGF0Y2gg
MiB0aGF0DQo+Pj4gY291bGQgZG8gd2l0aCBtb3JlIGV5ZXMgYW5kIGFja3MuDQo+Pj4NCj4+PiBG
YXIgYXMgSSBjYW4gdGVsbCB0aGF0IGNhc2UgaXMgZmluZSBhcyB3ZWxsIGJlY2F1c2Ugb2YgdGhl
IHByb3RlY3Rpb25zDQo+Pj4gb24gYmVpbmcgaW4gdGhlIHJpZ2h0IG1vZGUsIGJ1dCBtb3JlIGV5
ZXMgb24gdGhhdCB3b3VsZCBiZSBncmVhdC4NCj4+Pg0KPj4+IFNvIGFzc3VtaW5nIHRoYXQncyBm
aW5lLCB3aGF0IGNvbW1pdCBtZXNzYWdlIGRvIHlvdSB3YW50IG1lIHRvIHVzZSBmb3INCj4+PiB0
aGUgZnVzZWQgc2luZ2xlIHBhdGNoPw0KPj4NCj4+IENvbW1pdCBtZXNzYWdlLXdpc2U6IEkgdGhp
bmsgdGhlIG1lc3NhZ2UgaW4gdGhlIGZpcnN0IGNvbW1pdCB3b3VsZCBiZQ0KPj4gbW9zdGx5IHN1
ZmZpY2llbnQuDQo+PiBObyBpZGVhIHdoYXQgb3RoZXIgZGVzY3JpcHRpb24gd291bGQgYmUgbmVl
ZGVkLg0KPj4NCj4+IFNvLCBtYXliZSBzb21ldGhpbmcgbGlrZToNCj4+DQo+PiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+PiBBbGwgZGV2aWNlcyB1c2luZyBhIHRyaWdnZXJlZCBidWZmZXIgbmVlZCB0byBhdHRh
Y2ggYW5kIGRldGFjaCB0aGUgdHJpZ2dlcg0KPj4gdG8gdGhlIGRldmljZSBpbiBvcmRlciB0byBw
cm9wZXJseSB3b3JrLiBJbnN0ZWFkIG9mIGRvaW5nIHRoaXMgaW4gZWFjaCBhbmQNCj4+IGV2ZXJ5
IGRyaXZlciBieSBoYW5kIG1vdmUgdGhpcyBpbnRvIHRoZSBjb3JlLg0KPj4NCj4+IEF0IHRoaXMg
cG9pbnQgaW4gdGltZSwgYWxsIGRyaXZlcnMgc2hvdWxkIGhhdmUgYmVlbiByZXNvbHZlZCB0bw0K
Pj4gYXR0YWNoL2RldGFjaCB0aGUgcG9sbC1mdW5jdGlvbiBpbiB0aGUgc2FtZSBvcmRlci4NCj4+
DQo+PiBUaGlzIHBhdGNoIHJlbW92ZXMgYWxsIGV4cGxpY2l0IGNhbGxzIG9mIGlpb190cmlnZ2Vy
ZWRfYnVmZmVyX3Bvc3RlbmFibGUoKQ0KPj4gJiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNh
YmxlKCkgaW4gYWxsIGRyaXZlcnMsIHNpbmNlIHRoZSBjb3JlIGhhbmRsZXMNCj4+IG5vdyB0aGUg
cG9sbGZ1bmMgYXR0YWNoL2RldGFjaC4NCj4+DQo+PiBUaGUgbW9yZSBwZWN1bGlhciBjaGFuZ2Ug
aXMgZm9yIHRoZSAnYXQ5MS1zYW1hNWQyX2FkYycgZHJpdmVyLCBzaW5jZSBpdCdzDQo+PiBub3Qg
b2J2aW91cyB0aGF0IHJlbW92aW5nIHRoZSBob29rcyBkb2Vzbid0IGJyZWFrIGFueXRoaW5nKioN
Cj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+DQo+IA0KPiBMb29rcyBnb29kLg0KPiANCj4+ICoqIGZvciB0
aGUgY29tbWVudCBhYm91dCAnYXQ5MS1zYW1hNWQyX2FkYycsIHdlIHJlYWxseSBkbyBuZWVkIHRv
IGdldCBzb21lDQo+PiB0ZXN0aW5nOyBvdGhlcndpc2UgdGhpcyByaXNrcyBicmVha2luZyBpdC4N
Cj4gDQoNCkhpLA0KDQpJIGNhbiB0ZXN0IGl0LCBkbyB3ZSBoYXZlIGFueSBwYXRjaHdvcmsgc28g
SSBjYW4gZWFzaWx5IGRvd25sb2FkIHRoZSANCnBhdGNoZXMgPw0KSSBoYXZlIGlzc3VlcyB3aGVu
IGFwcGx5aW5nIHRoZW0uDQoNClRoYW5rcyAhDQoNCj4gQWdyZWVkLg0KPiANCj4+DQo+Pg0KPj4+
DQo+Pj4gVGhhbmtzLA0KPj4+DQo+Pj4gSm9uYXRoYW4NCj4+Pg0KPj4+PiAgIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgaWlvX3RyaWdnZXJfb3BzIGF0bGFzX2ludGVycnVwdF90cmlnZ2VyX29wcyA9IHsN
Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2R1bW15L2lpb19zaW1wbGVfZHVtbXlfYnVm
ZmVyLmMNCj4+Pj4gYi9kcml2ZXJzL2lpby9kdW1teS9paW9fc2ltcGxlX2R1bW15X2J1ZmZlci5j
DQo+Pj4+IGluZGV4IDE3NjA2ZWNhNDJiNC4uOGUxM2M1M2Q0MzYwIDEwMDY0NA0KPj4+PiAtLS0g
YS9kcml2ZXJzL2lpby9kdW1teS9paW9fc2ltcGxlX2R1bW15X2J1ZmZlci5jDQo+Pj4+ICsrKyBi
L2RyaXZlcnMvaWlvL2R1bW15L2lpb19zaW1wbGVfZHVtbXlfYnVmZmVyLmMNCj4+Pj4gQEAgLTk5
LDIwICs5OSw2IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBpaW9fc2ltcGxlX2R1bW15X3RyaWdnZXJf
aChpbnQNCj4+Pj4gaXJxLCB2b2lkICpwKQ0KPj4+PiAgIH0NCj4+Pj4NCj4+Pj4gICBzdGF0aWMg
Y29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3BzDQo+Pj4+IGlpb19zaW1wbGVfZHVtbXlf
YnVmZmVyX3NldHVwX29wcyA9IHsNCj4+Pj4gLSAvKg0KPj4+PiAtICAqIGlpb190cmlnZ2VyZWRf
YnVmZmVyX3Bvc3RlbmFibGU6DQo+Pj4+IC0gICogR2VuZXJpYyBmdW5jdGlvbiB0aGF0IHNpbXBs
eSBhdHRhY2hlcyB0aGUgcG9sbGZ1bmMgdG8gdGhlDQo+Pj4+IHRyaWdnZXIuDQo+Pj4+IC0gICog
UmVwbGFjZSB0aGlzIHRvIG1lc3Mgd2l0aCBoYXJkd2FyZSBzdGF0ZSBiZWZvcmUgd2UgYXR0YWNo
IHRoZQ0KPj4+PiAtICAqIHRyaWdnZXIuDQo+Pj4+IC0gICovDQo+Pj4+IC0gLnBvc3RlbmFibGUg
PSAmaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZSwNCj4+Pj4gLSAvKg0KPj4+PiAtICAq
IGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGU6DQo+Pj4+IC0gICogR2VuZXJpYyBmdW5j
dGlvbiB0aGF0IHNpbXBsZSBkZXRhY2hlcyB0aGUgcG9sbGZ1bmMgZnJvbSB0aGUNCj4+Pj4gdHJp
Z2dlci4NCj4+Pj4gLSAgKiBSZXBsYWNlIHRoaXMgdG8gcHV0IGhhcmR3YXJlIHN0YXRlIGJhY2sg
YWdhaW4gYWZ0ZXIgdGhlIHRyaWdnZXINCj4+Pj4gaXMNCj4+Pj4gLSAgKiBkZXRhY2hlZCBidXQg
YmVmb3JlIHVzZXJzcGFjZSBrbm93cyB3ZSBoYXZlIGRpc2FibGVkIHRoZSByaW5nLg0KPj4+PiAt
ICAqLw0KPj4+PiAtIC5wcmVkaXNhYmxlID0gJmlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2Fi
bGUsDQo+Pj4+ICAgfTsNCj4+Pj4NCj4+PiBIbW0uIEd1ZXNzIHdlIHNob3VsZCBwcm9iYWJseSAn
aW52ZW50JyBhIHJlYXNvbiB0byBpbGx1c3RyYXRlIHRoZSBidWZlcg0KPj4+IG9wcyBpbiB0aGUg
ZHVtbXkgZXhhbXBsZS4gIEFueW9uZSBmZWVsaW5nIGNyZWF0aXZlPw0KPj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0DQo+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbA0KPiANCj4gDQoNCg==
