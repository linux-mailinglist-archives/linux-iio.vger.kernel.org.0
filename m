Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F6818F713
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 15:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCWOji (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 10:39:38 -0400
Received: from mail-db8eur05on2096.outbound.protection.outlook.com ([40.107.20.96]:62329
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbgCWOji (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 10:39:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPxrwTjEmjiBiDY8LZpEK4w/WSfY1wkOyfeUKteW39624tdEdXx8z9aQZri5vlex6TuQFk9OdyixwUCFcSl1aP0x2pq/N17OH9D/6Bjdti1GI9OgOvpXyM+d5kDeLFxTYTa8E0i8NpFtpwqlwIix7RiT6cX+aLAJ8TUuWfQeBkEMoMhDHoDxJap8DtYXQVZZg5eG3sE0J4ATDgZ48igKUzY0kt10/aIP5HVH8cZEE4lr2meo/ba2WvkxjgMoZdsX5v9WAauesG0xK5s9yaGKDE5Ys/ChCFV7e4PhvC1J4KT5R/8xbf3wA4imRsYgq67wn1ElZ3LvtxLv9qBEkJWhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKaw+4s7oO/7VK0GnXfWUNMG3BTlWobqcvB9P4MPNrk=;
 b=NPCxjnhSZ6TzYIH1QN0N3jxPZb553VDbWqjC+NTZ39Y4gcqWzvS/SqqpiVdbXevxDvFAmjFca3vXivYtOU3KrqnctVAg3vzOCsu2CwiTOnls60R1EIUJ66Nv/nB9vz87A05kU1YKfbNgjJn5LVPi+jtn4TpRS/N5lUKfX8BLIH7yjM0DX3jfBckSGHgQEQky2Fwxk2uA22EjubvUz4OEpku60KtzT0qAI5S9mkDS0PSqccMBHrbt5LCDwPf6W92f0FelbLp4wvWX6dQ9jlmf1NZSoB6qpjavR7mVjZKWFdHu6wkgviZx9sypIwYZoU6mZYdjW9wAgtM9RwOwEzHp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKaw+4s7oO/7VK0GnXfWUNMG3BTlWobqcvB9P4MPNrk=;
 b=UZ0qdTw60u41bZRmV1Jm+d1GH28l2XwkGaWll+4vzyoVOjAsEIzbxCbtD/L1I/4gJqlPRmg7fj8YAsCmTLivXn52NUaTZoytoQ9qFIr0k8ezE4hvvnL+eQUiPpz1ZPC0Fg7+MXZnuHBQPFK1R7fVimIJLZu9Xaa7osBZDwL0SAw=
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com (10.170.210.140) by
 DB6PR06MB4005.eurprd06.prod.outlook.com (10.168.21.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 14:39:34 +0000
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::c9cc:78ea:1bdd:5094]) by DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::c9cc:78ea:1bdd:5094%5]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 14:39:34 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Topic: [PATCH v6 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Index: AQHV/Jd7aicLLyk+Yk+vDytuCt/ZmahU0YwAgAF3AYA=
Date:   Mon, 23 Mar 2020 14:39:34 +0000
Message-ID: <F8BF24B6-5686-437E-8EE4-1A2151C848CF@norphonic.com>
References: <84EE5291-D8C4-40D3-A75C-92362BF9DF8B@norphonic.com>
 <20200322161722.0feb8da8@archlinux>
In-Reply-To: <20200322161722.0feb8da8@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [62.97.226.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f270351-f55a-4a28-7eab-08d7cf38016b
x-ms-traffictypediagnostic: DB6PR06MB4005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR06MB4005FA0C46BD1179C69F2A5DCAF00@DB6PR06MB4005.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(346002)(396003)(376002)(199004)(2906002)(4744005)(4326008)(33656002)(86362001)(6916009)(316002)(71200400001)(186003)(26005)(2616005)(508600001)(54906003)(64756008)(66946007)(66556008)(66446008)(76116006)(91956017)(66476007)(36756003)(5660300002)(6506007)(81156014)(81166006)(8676002)(53546011)(8936002)(6486002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR06MB4005;H:DB6PR06MB3048.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AzQ1jTm1CX12GeQdTqkjuuZ5QJGNc61CkRNoX+FSKB3bcVr1+us+KwlfGKGGYNBbdxuXNcVFZhtaVh7g7wJKOCflh7c25iOnNmMi4ShOaa7mcoJBYJu0QvGO7T3AwazTdpjTNhfev8IdXt/a6RiFvnf09nwMAu7vBdq5Wi6gLT0MUatsNNMiQcBIOJN/HYGs4g/zXXcUOFL+Hfbp7TeS2/DXPcGCdly+FWSijBc794ZX1b4xRSC0mWYfJyhGIN8cikJvHbrmZPfQZiW8K8PCGHa3WQhg16UY0VYNtmWrGaZeV++gtHsYjni+9TWCcfBJYaTEypqdqhAlJMDM+fE3uaD94ouIJU8tXgR13MJ/yaKLed0ZsaIvxgMp3r9IO5ekrXutuEMsJ+EmZVB4mLCPaveLfXmpT16D3ameGGKOdZA4hNSNajLmPOnAxX3RwL85
x-ms-exchange-antispam-messagedata: OLm19PX8/tNB7p5RX8Z226agAGtrUszAzPGZ2e164e6R7g/xculp7KJHWvz1dMnkYEEMr0D1I/GqiTlohduy/wbHX8CK15QMc/8LzabQtAs8gY/uVCpVvOnWa0TKzf8Lfi/1YieVZAbzPula+GgkXA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E710DA5E8F5D9D41B38096733AB87748@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f270351-f55a-4a28-7eab-08d7cf38016b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 14:39:34.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmm7WHKplT+k7W4VfgZmThMlPUFtcPjhpOzHccAYj6Lyjdh9aSfW1ifb9PkdOzYZDybLqIXzFYcxTWfqGqSAdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR06MB4005
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCj4gT24gMjIgTWFyIDIwMjAsIGF0IDE3OjE3LCBKb25hdGhhbiBDYW1l
cm9uIDxqaWMyM0BrZXJuZWwub3JnPiB3cm90ZToNCj4+ICtzdGF0aWMgaW50IGhkYzIwMTBfd3Jp
dGVfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+PiArCQkJICAgICBzdHJ1Y3QgaWlv
X2NoYW5fc3BlYyBjb25zdCAqY2hhbiwNCj4+ICsJCQkgICAgIGludCB2YWwsIGludCB2YWwyLCBs
b25nIG1hc2spDQo+PiArew0KPj4gKwlzdHJ1Y3QgaGRjMjAxMF9kYXRhICpkYXRhID0gaWlvX3By
aXYoaW5kaW9fZGV2KTsNCj4+ICsJaW50IG5ldywgcmV0ID0gLUVJTlZBTDsNCj4gDQo+IFVubGVz
cyBJJ20gaGFsZiBhc2xlZXAgKHdoaWNoIGlzIHBvc3NpYmxlIDopIHJldCBpcyBhbHdheXMNCj4g
d3JpdHRlbiBiZWxvdyBiZWZvcmUgYmVpbmcgdXNlZC4gIEhlbmNlIHRoaXMgaW5pdCBpc24ndCBu
ZWVkZWQuDQo+IA0KSSBzdXNwZWN0IGl04oCZcyBhIHZlc3RpZ2UgZnJvbSBiZWZvcmUgYWxsIHN0
eWxpc3RpYyByZXdyaXRlcyBpbiByZWNlbnQgcGF0Y2hlcy4gDQpTYW1lIGZvciB0aGUgc2hhcmVk
IHJldHVybnMuIFdpbGwgY2hhbmdlIHRoYXQuDQoNCj4+ICsNCj4+ICsJaW5kaW9fZGV2LT5kZXYu
cGFyZW50ID0gJmNsaWVudC0+ZGV2Ow0KPj4gKwlpbmRpb19kZXYtPm5hbWUgPSBkZXZfbmFtZSgm
Y2xpZW50LT5kZXYpOw0KPiANCj4gVGhhdCBzaG91bGQgYmUgdGhlIHBhcnQgbnVtYmVyLiAgSUlS
QyB0aGF0J3Mgbm90IHdoYXQgeW91J2xsIGdldA0KPiBmcm9tIGRldl9uYW1lIGNhbGxlZCBvbiB0
aGUgaTJjIGRldmljZS4gIE5vdGUgd2UgbGV0IGEgZmV3IG9mDQo+IHRoZXNlIGluIGluIHRoZSBw
YXN0IGFuZCBhcmUgbm93IHN0dWNrIHdpdGggdGhlbS4uLiANCj4gDQpNeSBhY2Nlc3MgdG8gYWN0
dWFsIGh3IGlzIGxpbWl0ZWQgbm93LCBzbyB0byByZWR1Y2UgdGhlIGl0ZXJhdGlvbnMgaGVyZTog
d2hhdA0KaXMgZ29pbmcgdG8gYmUgYSBzdWl0YWJsZSBkZXZpY2UgbmFtZT8gV291bGQg4oCcaGRj
MjB4MOKAnSBkbz8g4oCcaGRjMjAxMOKAnT8NCg0KDQpSZWdhcmRzLA0KICBFdWdlbmUu
