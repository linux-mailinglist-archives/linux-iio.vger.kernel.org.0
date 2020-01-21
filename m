Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D874314389D
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2020 09:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgAUIp3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jan 2020 03:45:29 -0500
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:18953
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727817AbgAUIp2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Jan 2020 03:45:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0d2+Wu74s6RD/B7TJGJQIXqeqsKMdjgRWChR3HOpTTVc/94Yp2NMTgegLT1J5tgke18S9Zma5BdLQT96+DBJ77hnJCV2aaQajEVufFhno0V2IrUC+thwnnCovmymRt7wGqX3F+59na6yzKDpplHiZUn9KncR0B6kYH8D4HsHBNq1vlb1r+XquN1VbH97lrblrws+vs5oOffj9ADTRYzPRHa5xKWNAjLeYFPVIgJJC7WNvwbk6OS0dhGhdoAMvGrpHousd59saUUNAnucjWsDxENMlnLft6x4uvoRnsMb+iLyXuKHlFnY4CMF62R2D6Y547rxkL9cNYtlfLB/uwQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un2CAUHZxU329KmtN/tkY7WCo/8+T3GXrT5DL5X1osU=;
 b=Ej0cBPlsFbfSjHtvBKnU/InanZcbyeLn+Mp/ObppgUgsA+p/mlFtYUpEN8H6wSvsjgMhXkCJlZyVRjUNzqsAWxBQDNx1u2smMZ2CCo3eMJqcQRoJ2xtYFPHSYUw9wjZRb7WPHjkP4V7dtw7jUd5j3NGFLgnJBaicJPjKYsxAZpxKfG9D9hbC6QL5u7jNc4+9XoEuJuI3lTejDxb80b8Fya7ipN28oAPCNlY8AIjpVeoD2y8AusY/WLMG4y+C5T8vsQiA1DpiBjJD1ZSdp6g5i66n5uyKTXrvN2RZN1MKnNe22ZjGxJkIroFAuIKFx9dhS2aAe0BuhsE59aMnXBZKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un2CAUHZxU329KmtN/tkY7WCo/8+T3GXrT5DL5X1osU=;
 b=hrvgPuCp9Nz3jkKX0hXyDk/FJNlnk+MwwD6sEkx7usMezQGwyTuLnuhh5mWbp/f5wbewMiQw35+cEoBVIu6wMihhhY62J6NBjq2mk+7FwT+5W+/co9VPHIODDrmgGH/cdktfdrCo9nxtQupabR2l0l74AdPaO5Eou08JEoeTIIM=
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com (10.170.210.140) by
 DB6PR06MB3096.eurprd06.prod.outlook.com (10.170.209.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 08:45:21 +0000
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::8d7e:fadb:f6c5:a504]) by DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::8d7e:fadb:f6c5:a504%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 08:45:21 +0000
Received: from [10.0.1.54] (62.97.226.122) by AM6P194CA0036.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 08:45:20 +0000
From:   Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Eugene Zalkonnikov <ez@norphonic.com>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Topic: [PATCH v3 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Index: AQHVsc26SON/FxISfkecdCGvyqtp7afIBc+AgC0EzYA=
Date:   Tue, 21 Jan 2020 08:45:21 +0000
Message-ID: <9d866c18-6643-f76f-df7e-6f29f01274da@norphonic.com>
References: <B0A4F7BA-0D41-4DA0-985E-F2603D66C48F@norphonic.com>
 <20191223171627.1179f88b@archlinux>
In-Reply-To: <20191223171627.1179f88b@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0036.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::49) To DB6PR06MB3048.eurprd06.prod.outlook.com
 (2603:10a6:6:5::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [62.97.226.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f6e452-eff7-4a19-e5a5-08d79e4e3fd0
x-ms-traffictypediagnostic: DB6PR06MB3096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR06MB3096916AFB25A93A8F05DA12CA0D0@DB6PR06MB3096.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39830400003)(366004)(136003)(199004)(189003)(66946007)(4326008)(71200400001)(5660300002)(31686004)(4744005)(81156014)(16576012)(316002)(956004)(110136005)(54906003)(2616005)(52116002)(26005)(81166006)(8936002)(2906002)(53546011)(8676002)(508600001)(6636002)(6486002)(31696002)(16526019)(186003)(36756003)(66556008)(66476007)(66446008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR06MB3096;H:DB6PR06MB3048.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DueO4lwyWntpI0c/vsvLX++8wE/5EXSSA7lC2qxpPtAVwVLBuuN4/fZthpUjbIDSbdf8em6P3I32tQtX6TyxgSeXhI9hR+rcIgGeVF5kaKhuii6SCQO3OEopvKXvU/4CJQV8SMZAkIy+TFMbbUFsPDjXQduQ6OmK88uF7yx6P/Ilihf5/3iqNOQT1SrG7KouhQVbkQtsMrJef2uL4t//K/nwaK8Ez3LjN8lC2LqIFChav6zXaeAN+eNEZP7XWlWJsgSBvjxOwKtK4VbatmdtlOu+1lbC/0S5IDKOufX+KPfWf28CBavNv5l3ZjNzdiMaNBjvmFg5AD+hCZN+fOblEGM0CZlxe3mHKAfWcK3i9qFLxPiJCfA9ESBF6whRFC049LSDv9QYq8pGjkLB6Mx7AinuNzTjfwO6Nfyi3OCGe7aPfMQpkT3xwUQa4+LisTo9
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5EABFF494F3AF40B0AEF50D4FBC07E2@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f6e452-eff7-4a19-e5a5-08d79e4e3fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 08:45:21.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srBtn9vhpcmnZO4FIAwPhSCRJ8UBk7ybz4kQ+ch9mEGGJM6ba16cLaji+SM7R5Fkd9HDSv5hDiYcZwkIpgXV+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR06MB3096
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCg0KT24gMjMuMTIuMjAxOSAxODoxNiwgSm9uYXRoYW4gQ2FtZXJvbiB3
cm90ZToNCj4NCj4gQXMgYmVsb3cuIFdoeSBjaGFuZ2UgdGhlIGV4aXN0aW5nIHJldHVybiB2YWx1
ZT8NCj4NCj4+ICsJCX0NCj4+ICsJCXJldHVybiByZXQ7DQo+PiArCX0NCj4+ICsJY2FzZSBJSU9f
Q0hBTl9JTkZPX1BFQUs6IHsNCj4+ICsJCWludCByZXQ7DQo+PiArDQo+PiArCQlyZXQgPSBpaW9f
ZGV2aWNlX2NsYWltX2RpcmVjdF9tb2RlKGluZGlvX2Rldik7DQo+PiArCQlpZiAocmV0KQ0KPj4g
KwkJCXJldHVybiByZXQ7DQo+PiArCQltdXRleF9sb2NrKCZkYXRhLT5sb2NrKTsNCj4+ICsJCXJl
dCA9IGhkYzIwMTBfZ2V0X21lYXN1cmVtZW50X2J5dGUoZGF0YSwgY2hhbik7DQo+PiArCQltdXRl
eF91bmxvY2soJmRhdGEtPmxvY2spOw0KPj4gKwkJaWlvX2RldmljZV9yZWxlYXNlX2RpcmVjdF9t
b2RlKGluZGlvX2Rldik7DQo+PiArCQlpZiAocmV0ID49IDApIHsNCj4+ICsJCSAgLyogU2NhbGlu
ZyB1cCB0aGUgdmFsdWUgc28gd2UgY2FuIHVzZSBzYW1lIG9mZnNldCBhcyBSQVcgKi8NCj4+ICsJ
CQkqdmFsID0gcmV0ICogMjU2Ow0KPj4gKwkJCXJldCA9IElJT19WQUxfSU5UOw0KPj4gKwkJfSBl
bHNlDQo+IFdoeSBvdmVyd3JpdGUgcmV0PyAgVGhhdCBtaWdodCBwcm92aWRlIGJldHRlciBpbmZv
cm1hdGlvbg0KPiBvbiB3aGF0IHdlbnQgd3JvbmcuDQoNCkFzIHdpdGggdGhlIG90aGVyIHN0eWxp
c3RpYyBub3RlcyBiZWZvcmUsIG5vIGdvb2QgcmVhc29uIG90aGVyIHRoYW4gaG93IGl0IHdhcyBo
YW5kbGVkIGluIG90aGVyIGRyaXZlcnMgaW4gdGhlIHRyZWUuIFNvIEkgYXNzdW1lZCBpdCB3YXMg
dGhlIHByYWN0aWNlLiBXaWxsIHRpZHkgdXAgbGF0ZXIgdGhpcyB3ZWVrIEkgaG9wZSBhbmQgc2Vu
ZCBhIG5ldyBwYXRjaHNldC4NCg0KLS0NCsKgIEV1Z2VuZQ0K
