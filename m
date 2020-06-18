Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC641FF287
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jun 2020 15:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgFRNBo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jun 2020 09:01:44 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:37872 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgFRNBn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jun 2020 09:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592485303; x=1624021303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D0bexiqExjDBtzYS36YvG7cgtzZAYUqLMQBMUFMY0iY=;
  b=xDKG8iG+xR9/0geAm+6jhCk9O/4eXkbdg9PNIV1LgrJuIsDSlmax75Lm
   mZloy/Eet8GAlQNVnfC7T80ayy2d+AoHFoGs/suZFNu9pjl1+dAdM9Dq+
   LEW8Y6QjDQKaEkpL6DTDm6Kdil9kycIs5YeSk61yAqiv/jiBtLYL4zzPc
   vZxYlx5MD0Py+mCKfbdv34ObMdZBkN75Uiks3vNaNEgu3FN+o7uSL5Ys3
   vGhnXLoiTbTzVMO8PaUzA19cKT+qI8/mHP3AFAdLYLCLuCo/t2xgGL47j
   fr9TkvbYWBWp1Xc0qrG8X7bV5mD2ltd0ObMhinCLMhWYi8l+80Ioarebs
   w==;
IronPort-SDR: Zz9yOX4MgCkdjwVzelJKJk7hhVbncrHAc7g2gJcRTOyBL3dRsfyQ4vjfj1J/7ekYzI/+VMLfyY
 CT1a4vxslCaLrJUypr2Lcle9/e7SHfB2y1eOxmWCxkB1XaU9jGvpAgENvnpiAmQed+4PrY0HUh
 /zbgisEru2obLcuRx7qT7rPaLofkUP6+NromKsajVwxRpXRfAJ09cKm57It0IpYihghRnTFCt3
 BEc2096h5HKiu71r7dmhiGbM3eomPvN9tPwOalBG1JNp0Wo+M4wmgz8qf+8IUMjnkhajXYgSBv
 uT8=
X-IronPort-AV: E=Sophos;i="5.73,526,1583218800"; 
   d="scan'208";a="79973001"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 06:01:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 06:01:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 18 Jun 2020 06:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKlzhSbwsDJJFFncnsxsynLgJBcD2E/psbK/c7FP4gczjHUBkfyLPFsZ9xF6oEXvjXRPRAH8xPaArhCt253Pl7c3dUgxSczPBAAeuBHDuE39XLZ5HILBqRHrVB6OrGUO82Doq/JbDTgKB1wZUEuNDEm+2zVm9P68qaAr56PQ/HrZA3+3HKKIxffwX1rCNe2SEKwwBBC9qGrhQ0WC+BG5kVKC+UA6qBQBrbx/R2/OEyiFeaigMOw6Q+CxjqZlHsnXI2zdQrcMeJvJmaLVgUnQ+HuYUit+K1xlMKjTowbGkw16bCsH+DIoL7q4Ho2/NLfRZ3WOM2DuurFY662RuERvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0bexiqExjDBtzYS36YvG7cgtzZAYUqLMQBMUFMY0iY=;
 b=jVrnJKxQixzBcM2JclAkt9anBfVJ6/iAYhHXq/LCW5erm6RTcoYyqI7+FxAiFweDmfR94eoiVmJnyx389j63MGLFb5sM/LZa3HN+S/N5F9lvbwZXg/22l+PObMXuHFsvVsYn4r0vS78pIn7kNLxD2Ap4Beupk+Fn0GcQcfvWryXje/ejIReMNF7+osoXzpaSklpbE3SmiJsBTevtCUkUmhPzyVCu5vYfCS5vpcJgDm1KB4zjkCyPFhgGk5zF6xx35miJwW+QeXi1uaJ05R4fKaGk0p0oAOBtMJ8Zp3buzyHdeH7PMlaAzgKiGg2HCvMCh+3Mmvp+Y0qcynx+9VhsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0bexiqExjDBtzYS36YvG7cgtzZAYUqLMQBMUFMY0iY=;
 b=MIbghvb7NstHpBWD13BADTLwH2C1Iuc/+6YV+q2/lfh4DyEXilnC1Qy4ppa27lGqJd8R6QBh9GmXNYP8L70PAnneWyaBRu7J7o45K3i97S4/pus2PenpxcfeOXMrYY8I59pN1esZVLMWvmsM59niG80az/EGdt4xzAesCVb3Z2M=
Received: from BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17)
 by BYAPR11MB3319.namprd11.prod.outlook.com (2603:10b6:a03:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Thu, 18 Jun
 2020 13:01:37 +0000
Received: from BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::996a:3417:7ea7:2b8f]) by BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::996a:3417:7ea7:2b8f%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 13:01:37 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandru.Ardelean@analog.com>, <Jonathan.Cameron@Huawei.com>
CC:     <lars@metafoo.de>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <s.hauer@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <songqiang1304521@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <mcoquelin.stm32@gmail.com>, <lorenzo.bianconi83@gmail.com>,
        <shawnguo@kernel.org>, <linus.walleij@linaro.org>,
        <jic23@kernel.org>
Subject: Re: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Topic: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Index: AQHWMotBwkWaCEB0Gky7JFtHaSPpIajCXn4AgAKhXICAABHNAIAX4hqAgAAERoCAAYQUAA==
Date:   Thu, 18 Jun 2020 13:01:37 +0000
Message-ID: <e17fc5b3-fc6b-5980-7294-6d0a151138da@microchip.com>
References: <20200525113855.178821-1-alexandru.ardelean@analog.com>
 <20200525113855.178821-3-alexandru.ardelean@analog.com>
 <20200531164020.765822dc@archlinux>
 <a0253d719a4390f65668789e5fc182ec19355f17.camel@analog.com>
 <20200602095406.00005add@Huawei.com>
 <37ef45f4-9330-86ea-77c1-3138bb88601b@microchip.com>
 <0eeae8e8c2c1a3f21e15c1931bacb197a8245104.camel@analog.com>
In-Reply-To: <0eeae8e8c2c1a3f21e15c1931bacb197a8245104.camel@analog.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ad7d74c-c9ab-4509-e4dc-08d81387bc7b
x-ms-traffictypediagnostic: BYAPR11MB3319:
x-microsoft-antispam-prvs: <BYAPR11MB33198AC36EE2919D87388F45E89B0@BYAPR11MB3319.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 11pHK80xLkNKwrX5KvZ1XhCnOhugN09KMZ+MkQpYG/DtGy7NRoGWg4JLMGpf1h3sfvfMMxMgV+6Oxr4g2Tv518QjEPUyVOAhtZhvBw2Is/XDVD6oXpcjD55LujRQEX5jtyO/2vggfEgXRXZXXGHOQxB2KUVQ5eWWPx5ZYxlNJ0nTD3QBnOz7eKQ5w2Sqaw0cYbtqFZnF8MoubS8A0CReYfBxHJjtfKahC/FSRnHOMWxs4IrsChnoHwiSeUgs6ti1XlAE4OANn6TQ+sLXnlK8YrszF2PDR1KFLvDXsDjEa9bRB4teWDWwsRN1gTg4qCik+NoTiK3QkNhvxF9rDSgS9RbDYa6woSAzgAA5HhF1LJ1m1mvgVNPN4uvL4XDn0xgtf7j7oeyHnmngG+zPODiJM/CiKn54QdMNFxH17E3V9mAIe+Dn+NRdP/nR7vc/kCUog0yTb5Wtxe1MyXkaSDltyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(4326008)(6486002)(31686004)(66556008)(110136005)(478600001)(6512007)(64756008)(66946007)(186003)(2616005)(316002)(6506007)(66446008)(83380400001)(71200400001)(66476007)(26005)(966005)(53546011)(5660300002)(7416002)(86362001)(31696002)(76116006)(54906003)(91956017)(8676002)(8936002)(2906002)(36756003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pfdnT7m/lTXmSjHTYEhUsuntORRhfGEhrBj8vBx/NN5k55pdwkhk0fwFzlGmwd0UCd47QHjQhmDT2Ae7VzInYJfyJxQF6hOfdCjplky+r6EjIhLtBY9AEm3+Ls1LUMj/fNSXASjS8bTl7tQtACiqRbAnG730DygY3xfUV4EmFGgpsEIVQDUhzMKLQ0x8NWgj82HojW4vv9ZkOO08y31+qzt9WUy8xCuNc6VkpIGtHE3Cjd/YKDe81FqxJCWWBBVXZnw0faPTy4za6FLh6/u0vncoYCA0Qz/22u4pkGuuOTCPZG0X6+tNWmLNrnANSdbjyDJ3isL78LmWefUUnYXCCABnkpx+GT89MMd9EkWDcky9GPYG1tRc2YvNZ0+7Cs6o9q/DJkGGtDqE9vy+POxxnT2+0EngfSghHd1ork2KRlmdgsOmfi+ifAjtIegXQ7ZkLOivyRuh+9bpNtqd44ZV8fH8sc1zrrB2Dka6Li76XK4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0EDB4575451B74D81B9CB5687756C3B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad7d74c-c9ab-4509-e4dc-08d81387bc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 13:01:37.5644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyXc4vwIMAPOUQJ2mjNySZWG4vraRH8/Jyjzl3jsiFLHr9L8QEotTwXxNCRIJQrXXG7bX0MetsUB9IOLKoZRCuFfIkzOfcayej982wLVs0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3319
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMTcuMDYuMjAyMCAxNjo1MiwgQXJkZWxlYW4sIEFsZXhhbmRydSB3cm90ZToNCj4gT24gV2Vk
LCAyMDIwLTA2LTE3IGF0IDEzOjM3ICswMDAwLCBFdWdlbi5IcmlzdGV2QG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+PiBbRXh0ZXJuYWxdDQo+Pg0KPj4gT24gMDIuMDYuMjAyMCAxMTo1NCwgSm9uYXRo
YW4gQ2FtZXJvbiB3cm90ZToNCj4+PiBPbiBUdWUsIDIgSnVuIDIwMjAgMDc6NTA6MjMgKzAwMDAN
Cj4+PiAiQXJkZWxlYW4sIEFsZXhhbmRydSIgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29t
PiB3cm90ZToNCj4+Pg0KPj4+PiBPbiBTdW4sIDIwMjAtMDUtMzEgYXQgMTY6NDAgKzAxMDAsIEpv
bmF0aGFuIENhbWVyb24gd3JvdGU6DQo+Pj4+PiBPbiBNb24sIDI1IE1heSAyMDIwIDE0OjM4OjU1
ICswMzAwDQo+Pj4+PiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFs
b2cuY29tPiB3cm90ZToNCj4+Pj4+DQo+Pj4+Pj4gRnJvbTogTGFycy1QZXRlciBDbGF1c2VuIDxs
YXJzQG1ldGFmb28uZGU+DQo+Pj4+Pj4NCj4+Pj4+PiBUaGlzIHBhdGNoIHNob3VsZCBiZSBzcXVh
c2hlZCBpbnRvIHRoZSBmaXJzdCBvbmUsIGFzIHRoZSBmaXJzdCBvbmUgaXMNCj4+Pj4+PiBicmVh
a2luZyB0aGUgYnVpbGQgKGludGVudGlvbmFsbHkpIHRvIG1ha2UgdGhlIElJTyBjb3JlIGZpbGVz
IGVhc2llcg0KPj4+Pj4+IHRvDQo+Pj4+Pj4gcmV2aWV3Lg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVk
LW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9n
LmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+DQo+Pj4+PiBGcmllbmQgcG9rZS4gIFZlcnNpb24gbG9n
Pw0KPj4+Pg0KPj4+PiBWZXJzaW9uIGxvZyBpcyBpbiB0aGUgZmlyc3QgcGF0Y2guDQo+Pj4+IEkg
d2FzIHdvbmRlcmluZyBpZiBJIG9taXR0ZWQgaXQuDQo+Pj4+IFNlZW1zLCB0aGlzIHRpbWUgSSBk
aWRuJ3QuIEJ1dCBJIGFkbWl0LCBpdCBwcm9iYWJseSB3b3VsZCBoYXZlIGJlZW4gYmV0dGVyDQo+
Pj4+IGhlcmUuDQo+Pj4gQWggZmFpciBlbm91Z2guICBUaGF0IHdvcmtzIGZpbmUgaWYgdGhlcmUg
aXMgYSBjb3ZlciBsZXR0ZXIgYnV0IG5vdA0KPj4+IHNvIG11Y2gganVzdCBwdXR0aW5nIHRoaW5n
cyBpbiB0aGUgZmlyc3QgcGF0Y2ghDQo+Pj4+PiBPdGhlciB0aGFuIHRoZSB3aXN0ZnVsIGNvbW1l
bnQgYmVsb3cgKHdoaWNoIEknbSBub3QgZXhwZWN0aW5nIHlvdSB0bw0KPj4+Pj4gZG8gYW55dGhp
bmcgYWJvdXQgYnR3ISkgd2hvbGUgc2VyaWVzIGxvb2tzIGdvb2QgdG8gbWUuDQo+Pj4+Pg0KPj4+
Pj4gVGhlc2UgYXJlIG9idmlvdXNseSBubyBmdW5jdGlvbmFsIGNoYW5nZXMgKEkgdGhpbmspIHNv
IGl0J3Mgb25seSByZWFsbHkNCj4+Pj4+IHBhdGNoIDIgdGhhdA0KPj4+Pj4gY291bGQgZG8gd2l0
aCBtb3JlIGV5ZXMgYW5kIGFja3MuDQo+Pj4+Pg0KPj4+Pj4gRmFyIGFzIEkgY2FuIHRlbGwgdGhh
dCBjYXNlIGlzIGZpbmUgYXMgd2VsbCBiZWNhdXNlIG9mIHRoZSBwcm90ZWN0aW9ucw0KPj4+Pj4g
b24gYmVpbmcgaW4gdGhlIHJpZ2h0IG1vZGUsIGJ1dCBtb3JlIGV5ZXMgb24gdGhhdCB3b3VsZCBi
ZSBncmVhdC4NCj4+Pj4+DQo+Pj4+PiBTbyBhc3N1bWluZyB0aGF0J3MgZmluZSwgd2hhdCBjb21t
aXQgbWVzc2FnZSBkbyB5b3Ugd2FudCBtZSB0byB1c2UgZm9yDQo+Pj4+PiB0aGUgZnVzZWQgc2lu
Z2xlIHBhdGNoPw0KPj4+Pg0KPj4+PiBDb21taXQgbWVzc2FnZS13aXNlOiBJIHRoaW5rIHRoZSBt
ZXNzYWdlIGluIHRoZSBmaXJzdCBjb21taXQgd291bGQgYmUNCj4+Pj4gbW9zdGx5IHN1ZmZpY2ll
bnQuDQo+Pj4+IE5vIGlkZWEgd2hhdCBvdGhlciBkZXNjcmlwdGlvbiB3b3VsZCBiZSBuZWVkZWQu
DQo+Pj4+DQo+Pj4+IFNvLCBtYXliZSBzb21ldGhpbmcgbGlrZToNCj4+Pj4NCj4+Pj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPj4+PiBBbGwgZGV2aWNlcyB1c2luZyBhIHRyaWdnZXJlZCBidWZmZXIgbmVlZCB0
byBhdHRhY2ggYW5kIGRldGFjaCB0aGUgdHJpZ2dlcg0KPj4+PiB0byB0aGUgZGV2aWNlIGluIG9y
ZGVyIHRvIHByb3Blcmx5IHdvcmsuIEluc3RlYWQgb2YgZG9pbmcgdGhpcyBpbiBlYWNoIGFuZA0K
Pj4+PiBldmVyeSBkcml2ZXIgYnkgaGFuZCBtb3ZlIHRoaXMgaW50byB0aGUgY29yZS4NCj4+Pj4N
Cj4+Pj4gQXQgdGhpcyBwb2ludCBpbiB0aW1lLCBhbGwgZHJpdmVycyBzaG91bGQgaGF2ZSBiZWVu
IHJlc29sdmVkIHRvDQo+Pj4+IGF0dGFjaC9kZXRhY2ggdGhlIHBvbGwtZnVuY3Rpb24gaW4gdGhl
IHNhbWUgb3JkZXIuDQo+Pj4+DQo+Pj4+IFRoaXMgcGF0Y2ggcmVtb3ZlcyBhbGwgZXhwbGljaXQg
Y2FsbHMgb2YgaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZSgpDQo+Pj4+ICYgaWlvX3Ry
aWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZSgpIGluIGFsbCBkcml2ZXJzLCBzaW5jZSB0aGUgY29y
ZSBoYW5kbGVzDQo+Pj4+IG5vdyB0aGUgcG9sbGZ1bmMgYXR0YWNoL2RldGFjaC4NCj4+Pj4NCj4+
Pj4gVGhlIG1vcmUgcGVjdWxpYXIgY2hhbmdlIGlzIGZvciB0aGUgJ2F0OTEtc2FtYTVkMl9hZGMn
IGRyaXZlciwgc2luY2UgaXQncw0KPj4+PiBub3Qgb2J2aW91cyB0aGF0IHJlbW92aW5nIHRoZSBo
b29rcyBkb2Vzbid0IGJyZWFrIGFueXRoaW5nKioNCj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+Pg0K
Pj4+DQo+Pj4gTG9va3MgZ29vZC4NCj4+Pg0KPj4+PiAqKiBmb3IgdGhlIGNvbW1lbnQgYWJvdXQg
J2F0OTEtc2FtYTVkMl9hZGMnLCB3ZSByZWFsbHkgZG8gbmVlZCB0byBnZXQgc29tZQ0KPj4+PiB0
ZXN0aW5nOyBvdGhlcndpc2UgdGhpcyByaXNrcyBicmVha2luZyBpdC4NCj4+DQo+PiBIaSwNCj4+
DQo+PiBJIGNhbiB0ZXN0IGl0LCBkbyB3ZSBoYXZlIGFueSBwYXRjaHdvcmsgc28gSSBjYW4gZWFz
aWx5IGRvd25sb2FkIHRoZQ0KPj4gcGF0Y2hlcyA/DQo+PiBJIGhhdmUgaXNzdWVzIHdoZW4gYXBw
bHlpbmcgdGhlbS4NCj4gDQo+IElzIHRoaXMgZ29vZD8NCj4gDQo+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvMTE1Njg3NDMvDQo+IFNlcmllczoNCj4gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWlpby9saXN0Lz9zZXJpZXM9MjkzMTQxDQo+IA0K
PiBNYW55IHRoYW5rcw0KPiBBbGV4DQoNCk9uIGF0OTEtc2FtYTVkMi1hZGMgZHJpdmVyLCBzYW1h
NWQyLXhwbGFpbmVkIGJvYXJkLA0KVGVzdGVkLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlz
dGV2QG1pY3JvY2hpcC5jb20+DQoNCkkgYXBwbGllZCBhbGwgdGhyZWUgcGF0Y2hlcyBhbmQgdGVz
dGVkIHRvZ2V0aGVyIHdpdGggdGhlIG90aGVyIHBhdGNoIG9uIA0Kc2FtYTVkMi1hZGMgZHJpdmVy
Lg0KSXQgbG9va3MgdG8gYmUgd29ya2luZyBmaW5lLiBJZiBJIGRpc2NvdmVyIHNvbWV0aGluZyBs
YXRlciwgSSB3aWxsIGxldCANCnlvdSBrbm93Lg0KVGhhbmtzDQoNCj4gDQo+Pg0KPj4gVGhhbmtz
ICENCj4+DQo+Pj4gQWdyZWVkLg0KPj4+DQo+Pj4+DQo+Pj4+PiBUaGFua3MsDQo+Pj4+Pg0KPj4+
Pj4gSm9uYXRoYW4NCj4+Pj4+DQo+Pj4+Pj4gICAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fdHJp
Z2dlcl9vcHMgYXRsYXNfaW50ZXJydXB0X3RyaWdnZXJfb3BzID0gew0KPj4+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9kdW1teS9paW9fc2ltcGxlX2R1bW15X2J1ZmZlci5jDQo+Pj4+Pj4g
Yi9kcml2ZXJzL2lpby9kdW1teS9paW9fc2ltcGxlX2R1bW15X2J1ZmZlci5jDQo+Pj4+Pj4gaW5k
ZXggMTc2MDZlY2E0MmI0Li44ZTEzYzUzZDQzNjAgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvZHJpdmVy
cy9paW8vZHVtbXkvaWlvX3NpbXBsZV9kdW1teV9idWZmZXIuYw0KPj4+Pj4+ICsrKyBiL2RyaXZl
cnMvaWlvL2R1bW15L2lpb19zaW1wbGVfZHVtbXlfYnVmZmVyLmMNCj4+Pj4+PiBAQCAtOTksMjAg
Kzk5LDYgQEAgc3RhdGljIGlycXJldHVybl90IGlpb19zaW1wbGVfZHVtbXlfdHJpZ2dlcl9oKGlu
dA0KPj4+Pj4+IGlycSwgdm9pZCAqcCkNCj4+Pj4+PiAgICB9DQo+Pj4+Pj4NCj4+Pj4+PiAgICBz
dGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3BzDQo+Pj4+Pj4gaWlvX3NpbXBs
ZV9kdW1teV9idWZmZXJfc2V0dXBfb3BzID0gew0KPj4+Pj4+IC0gLyoNCj4+Pj4+PiAtICAqIGlp
b190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGU6DQo+Pj4+Pj4gLSAgKiBHZW5lcmljIGZ1bmN0
aW9uIHRoYXQgc2ltcGx5IGF0dGFjaGVzIHRoZSBwb2xsZnVuYyB0byB0aGUNCj4+Pj4+PiB0cmln
Z2VyLg0KPj4+Pj4+IC0gICogUmVwbGFjZSB0aGlzIHRvIG1lc3Mgd2l0aCBoYXJkd2FyZSBzdGF0
ZSBiZWZvcmUgd2UgYXR0YWNoIHRoZQ0KPj4+Pj4+IC0gICogdHJpZ2dlci4NCj4+Pj4+PiAtICAq
Lw0KPj4+Pj4+IC0gLnBvc3RlbmFibGUgPSAmaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJs
ZSwNCj4+Pj4+PiAtIC8qDQo+Pj4+Pj4gLSAgKiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNh
YmxlOg0KPj4+Pj4+IC0gICogR2VuZXJpYyBmdW5jdGlvbiB0aGF0IHNpbXBsZSBkZXRhY2hlcyB0
aGUgcG9sbGZ1bmMgZnJvbSB0aGUNCj4+Pj4+PiB0cmlnZ2VyLg0KPj4+Pj4+IC0gICogUmVwbGFj
ZSB0aGlzIHRvIHB1dCBoYXJkd2FyZSBzdGF0ZSBiYWNrIGFnYWluIGFmdGVyIHRoZSB0cmlnZ2Vy
DQo+Pj4+Pj4gaXMNCj4+Pj4+PiAtICAqIGRldGFjaGVkIGJ1dCBiZWZvcmUgdXNlcnNwYWNlIGtu
b3dzIHdlIGhhdmUgZGlzYWJsZWQgdGhlIHJpbmcuDQo+Pj4+Pj4gLSAgKi8NCj4+Pj4+PiAtIC5w
cmVkaXNhYmxlID0gJmlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUsDQo+Pj4+Pj4gICAg
fTsNCj4+Pj4+Pg0KPj4+Pj4gSG1tLiBHdWVzcyB3ZSBzaG91bGQgcHJvYmFibHkgJ2ludmVudCcg
YSByZWFzb24gdG8gaWxsdXN0cmF0ZSB0aGUgYnVmZXINCj4+Pj4+IG9wcyBpbiB0aGUgZHVtbXkg
ZXhhbXBsZS4gIEFueW9uZSBmZWVsaW5nIGNyZWF0aXZlPw0KPj4+PiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4+PiBsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdA0KPj4+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+
Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbF9fOyEhQTNOaThDUzB5MlkhdWxIOTJT
M29fSldMTVFmZzVWQnJGa253Y18tYTBLNUFIcEpCclRFQi1SdFlFcDdQblJKOWpBX0VhY096RlFt
Yk5JS08tUSQNCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KPiANCg0K
