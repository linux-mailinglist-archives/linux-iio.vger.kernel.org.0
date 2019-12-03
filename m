Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5163910FA7F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2019 10:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfLCJLg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Dec 2019 04:11:36 -0500
Received: from mail-eopbgr80092.outbound.protection.outlook.com ([40.107.8.92]:31810
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCJLf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Dec 2019 04:11:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxhIExvibkSM12RFewmIHaZLi4pSeOJl1dZeZftpp4LcGhDoFktGOFcU3zOAcsIyRYoUNCGXGM7fayq2ANydm0IH7o/IgsZtNkRmJNfESJPm+wwVakkqASm5DdwE5ychyxM9j37vr408Yfh395H5FbERpGC3SGsxTDLdPRrXWfLoKtabydPCIXt6wNVfhdBtS7LE78EW+r6p3QLdPYUU2wl1yw0kTG/gnRgV9jw8n/COqICRJRwVT94BxoQ+B4gifu6u2mckdcgnDCqYneKpWXVvw51qhF1bs8010m/UXadI0DkUhGzG3UXEVvxLpvHJ7KwMGwqmEG4V5IF8R/2ANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSdQTEeqKekCf/kXaT+Zip9ncXFPJvVqoD6aUMOUQBQ=;
 b=fl195M/HrDZLJj4Lbp0qJeUAiSS2oUfnfBUQADxNwwA2uQrp5ZH6Nf6fwTlLwwMrn5+/yJwbZFXd7r7bHPWHuwDPxHLlnRuQC+CIh4SMyiv5fwfrKzEn3Yj1jVOjGHAx7aTCvMnLHZyhwgjlEnBB5KDu89qzp2+ztp91MYbx5fvoGSw9pJfqgwO2POksVDmP1BRWZOEYvwErwcl1/e2mU9T2Nh7aAH9zOmw+lRpRGLfy5KEB3BDPEWvAmIK2tWDl14n+UnMR6ZfwuvMWhVM01oTxEZHvMyUZk0dUOr2WrJ+vKEnHQILTsAaqGrWgpXHKJLlBR6+SE539JMCTd6wAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSdQTEeqKekCf/kXaT+Zip9ncXFPJvVqoD6aUMOUQBQ=;
 b=TtL2hZkuJ1wNIH73APZEQF6YpUFkmW3JZfc1AG4u5/yxKgrAjxjdrfulo8LYHciVFyCYrsHezkQqkMuFjoYepmHL6I0mM3dLcnvj4ZRkovNwrjTt7Oc+MTV3ca1kRY/+izrdqe2b+b+74CYkNx8U/GISKY/ccmx1xnt/7txCjUs=
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com (20.177.202.94) by
 VI1PR06MB3951.eurprd06.prod.outlook.com (20.176.5.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 09:10:49 +0000
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::a56e:b59e:d95f:c568]) by VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::a56e:b59e:d95f:c568%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 09:10:49 +0000
From:   Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Eugene Zalkonnikov <ez@norphonic.com>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Topic: [PATCH v2 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Index: AQHVqbMiF7qR+SRdokmvz+tzmAQIm6eoH7KA
Date:   Tue, 3 Dec 2019 09:10:49 +0000
Message-ID: <221cc09d-340c-b5b5-7af6-0608588598a1@norphonic.com>
References: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
 <20191201123606.1db0d5b1@archlinux>
In-Reply-To: <20191201123606.1db0d5b1@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::22)
 To VI1PR06MB5790.eurprd06.prod.outlook.com (2603:10a6:803:99::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [62.97.226.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffc913e9-7147-47a0-5072-08d777d0b08e
x-ms-traffictypediagnostic: VI1PR06MB3951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR06MB3951C686EDC6419ACCEA4761CA420@VI1PR06MB3951.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(199004)(189003)(66946007)(25786009)(66556008)(2616005)(66446008)(64756008)(5660300002)(14454004)(71190400001)(71200400001)(36756003)(508600001)(66476007)(4326008)(6512007)(26005)(256004)(186003)(14444005)(6506007)(386003)(11346002)(7736002)(446003)(53546011)(305945005)(6246003)(102836004)(6636002)(2906002)(99286004)(54906003)(6436002)(52116002)(6486002)(229853002)(76176011)(110136005)(3846002)(6116002)(31686004)(8936002)(81156014)(8676002)(31696002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR06MB3951;H:VI1PR06MB5790.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blBRyw3mbLjVmbfBMRUAY/6VYuasCWrda3jIJtIZMi7gepsimMpnDX4OTwC+pOfGcLNyHZo0HdGqGqIj7fUysNKV9FDBbRFjXvxdwGXxP+lHmXBPyX1rup0f5CJ4BrjQRTIL1Y4KfYe0BGFlkQKkhdknRWd1JCib4t30NneOKsW0VgSwLKv7rwrRDtDk0Kika7CiDrKFQtmu0MqjBSKNkXxhrgFxOaUavLptaSfSfdPM/6OoQOOkobiE1hsfQ/oND4x5LLes2CuwKJVC4O2ZCtBbpksuEzu3cRP6UTvp6B6qRLYTIiQW4Km83rKtzQ2wt0zxPtL1SYLHRJBOx9C9t2TU9IvfDvRDk7czvfl4vIE33ATHHdzvwH/ymoSf1M2zA3v6NPrmaB2m8o1ixdrTWdJGBzCP5i3yqJPNb/uPFExzCvnV6CQqtaZIzvUTILG2
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1B0620CA4F6AF4DA83B752DDA134433@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc913e9-7147-47a0-5072-08d777d0b08e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 09:10:49.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6xIK+Am6qzY1IPh2Fxw3c4sbIrjIaCaZiGOzDyHPoBg69WOA/ltVJ3JWYedh3zros5b2qE6WQqMOhuWPOlnCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB3951
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQpPbiAwMS4xMi4yMDE5IDEzOjM2LCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPg0KPj4gSGVh
dGVyIG91dCBoYXMgYmVlbiBjb252ZXJ0ZWQgdG8gSUlPX0NIQU5fSU5GT19FTkFCTEUsIGhvcGUg
aXQgaXMgaWRpb21hdGljIHVzZS4NCj4gSG1tLiBUaGlzIGlzIG9uZSBvZiB0aG9zZSBjYXNlcyB3
aGVyZSB3ZSBhcmUgcHJvYmFibHkgYmV0dGVyIG9mZiBtYXRjaGluZw0KPiBleGlzdGluZyBkcml2
ZXJzIGV2ZW4gaWYgdGhleSBhcmUgYSBiaXQgaWxsb2dpY2FsLg0KPg0KPiBUaGUgZW5hYmxlIGVs
ZW1lbnQgaXMgbWFpbmx5IHVzZWQgZm9yIGNvdW50aW5nIHR5cGUgc2Vuc29ycyAoc3RhcnQgY291
bnRpbmcNCj4gc3RlcHMgZXRjKSB3aGVyZSB0aGVyZSBpcyBhIGNsZWFyIGRpZmZlcmVuY2UgYmV0
d2VlbiBpdCBiZWluZyBvbiBhbmQgdGFraW5nDQo+IGEgbWVhc3VyZW1lbnQuDQpPSywgd2lsbCBy
ZXZlcnQgdGhhdCB0byBwcmlvci4NCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3Bl
YyBoZGMyMDEwX2NoYW5uZWxzW10gPSB7DQo+PiArCXsNCj4+ICsJCS50eXBlID0gSUlPX1RFTVAs
DQo+PiArCQkuYWRkcmVzcyA9IEhEQzIwMTBfUkVHX1RFTVBfTE9XLA0KPj4gKwkJLmluZm9fbWFz
a19zaGFyZWRfYnlfdHlwZSA9IEJJVChJSU9fQ0hBTl9JTkZPX09GRlNFVCkgfA0KPj4gKwkJCUJJ
VChJSU9fQ0hBTl9JTkZPX1NDQUxFKSwNCj4+ICsJCS5pbmZvX21hc2tfc2VwYXJhdGUgPSBCSVQo
SUlPX0NIQU5fSU5GT19SQVcpLA0KPj4gKwl9LA0KPj4gKwl7DQo+PiArCQkudHlwZSA9IElJT19U
RU1QLA0KPj4gKwkJLmFkZHJlc3MgPSBIREMyMDEwX1JFR19URU1QX01BWCwNCj4+ICsJCS5pbmZv
X21hc2tfc2VwYXJhdGUgPSBCSVQoSUlPX0NIQU5fSU5GT19QRUFLKSwNCj4gTm90IHN1cmUgSSBs
aWtlIHRoaXMgYXBwcm9hY2ggb2YgYSBzZXBhcmF0ZSBjaGFubmVsLiAgVGhlIGludGVudCBvZg0K
PiBteSBwcmV2aW91cyByZXZpZXcgYXMgdG8gc3VnZ2VzdCB3ZSB1c2VkIGEgc2luZ2xlIGNoYW5u
ZWwuIEhlcmUNCj4gd2UgYXJlIHJlYWxseSBqdXN0IGFkZGluZyBvbmUgdG8gZ2V0IGFuIGFkZHJl
c3MuICBXaGlsc3QgaXQgd29ya3MNCj4gdG9kYXksIHRoaXMgc29ydCBvZiB1bnVzdWFsIHN0cnVj
dHVyZSBjYW4gbWFrZSBpdCBoYXJkZXIgdG8gcmVmYWN0b3INCj4gY29yZSBlbGVtZW50cyBvZiB0
aGUgY29kZSBpbiB0aGUgZnV0dXJlLg0KPg0KPiBJJ2QgcmF0aGVyIHNlZSBhIGJpdCBvZiBpbmRp
cmVjdGlvbiB3aGVyZSBhZGRyZXNzIGFjdHVhbGx5IGdpdmVzDQo+IGFuIGVudW0gdmFsdWUgZnJv
bSB3aGljaCB0aGUgZGF0YSBhbmQgX01BWCByZWdpc3RlcnMgY2FuIGJlDQo+IGVzdGFibGlzaGVk
IHZpYSBhIGxvb2t1cCBpbiBhbiBhc3NvY2lhdGVkIGFycmF5Lg0KDQpJIHNlZSB3aGF0IHlvdSBt
ZWFuIG5vdy4gV2FzIHRha2luZyB0aGUgbmFtZSBvZiAuYWRkcmVzcyBmaWVsZCBsaXRlcmFsbHks
IGJ1dCBpZiBhbnl0aGluZyBnb2VzIHRoZXJlLCBzdXJlLg0KDQpXaGlsZSB3ZSBhcmUgYXQgaXQs
IHRoZXJlIGFyZSBmb3VyIHIvdyB0aHJlc2hvbGQgcmVnaXN0ZXJzIG9uIHRoZSBkZXZpY2UgZm9y
IHJoL3RlbXAuIFNob3VsZCBvbmUgaW1wbGVtZW50IHRoZW0gaW4gdGhlIGZ1dHVyZSwgYXJlIHRo
ZXkgZ29pbmcgdG8gYmUgYWxzbyBtaXhlZCBpbnRvIHRoZXNlIHNvbWVob3cgb3IgY2FuIHRoZXkg
YmUgb3duIGV2ZW50IGNoYW5uZWxzPw0KDQoNCi0tDQoNCsKgIEV1Z2VuZQ0KDQo=
