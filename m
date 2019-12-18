Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC14124E5F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLRQw2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:52:28 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36365 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLRQw2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:52:28 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: B3hJCgvXUuiOmBQJrZj+OXsB6UjUQJJulMiWAQ9kwRMs77edPNRfiJVy6LpoQKHnXT+0Cmy1xj
 uMzvexOaIL4rmWlrDa2BW8FuG4bZmhb4QV7rE/ZMFsKPZLNUl52g5Y+fqoPlecwWoPIdjkE64E
 sD6QVX7LnlJqjc/SBXUvApTcN25IZSP0opzebUQsjke0rQzNyUsSUKDBWpkiuJBaXV+TBIvg8O
 mfC8he5gLBOU4UP1emyGMiO43DQTo+qXMVEdpJABuPYfBgIzIU2R2kx8PZcpVa+n/RGgm0gqZ3
 Foc=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="59432211"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:52:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:52:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 09:52:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9mBOSR1ONboEKsvP8ln/CghaNIC/4l+Wz44ELNbRQlGRuGfBWBc8bEmJFScemhOAKPR0PneRlyU8c1dhJh39bmmFVw87d8FXiZ40vcB06FWjN5pJQipDj/5B2q8K6K1ZaMrP2jcHXSFCQK4XKLJb5HZeb/5uBq6kJav9XILXPys//jD/QkAbZFDw+k1roCDu5fNnN0g1v8Ln2E4B5TjWe+XL0qyDIQCV7OrXiT5MuAXMyEyh6DoJq24sjSOVOTxJb9mKPK+XPdzkQKqJelzSvnuQHCmeNcoUbxER9aUy79XxSIK973+JXqkGhbP+KfNqP+9TTWz/b1FE0b2TPNd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJR29hcIIYXyopRtRiHRTLOXdfLQWFtEqrG+/1MU+6I=;
 b=drAK7sj6mi3j5yu41J+Z3b+ZSY/wS0lAe3gwQ5zvt4IYTX1MiLg6AmHGK0q2hRN0076QuvuWoGFM7Qgd5WBtqyysBOZgKHiTM6nF8qM3npAm7XnQxQt/aRdoxUtrZZOaUMz2i8+loOplrF5wgRSA9VYwAKShp/5mSAiHazp1YA62ypOBX0TL5uBQbU1/dEREKbomt0mdRjwcetzwv34ptsJ1Oshl/ZutNJc9VE8SppB3DgskOWhFgXnMIRxWzqTMVZTlb+Q3tZOsjNoqytF8W6E2l8VMz/grP+c1lBqNwLqpPCpErH7TgwPMVkAzHjQMQzgUyE0r2M6bI6G9095XQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJR29hcIIYXyopRtRiHRTLOXdfLQWFtEqrG+/1MU+6I=;
 b=qAiTZ+McjCtEfYXtl8OY2tozQf5V6WoK8RmEAOLbO2TKSgJBlmNFEK4pKjaF7R7WQGYLTbrKVFEWSQ4BRAAMqcAvCyfFXrWErXjHrar7nKVjkqfkQUWCcGTxCtTe/cvFTVqHp+QGBlwB0m2iwwoA1xxm4Wx5ZkaGPn1EELxPOWM=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1643.namprd11.prod.outlook.com (10.172.37.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 16:52:22 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:52:21 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 04/10] rtc: at91rm9200: use of_platform_populate as return
 value
Thread-Topic: [PATCH 04/10] rtc: at91rm9200: use of_platform_populate as
 return value
Thread-Index: AQHVtb+OEQqavda3i02bVS64GBIv7afAGSQAgAACToA=
Date:   Wed, 18 Dec 2019 16:52:21 +0000
Message-ID: <04264cb0-61a9-aba3-82ad-e7d12fd8441e@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
 <1576686157-11939-5-git-send-email-eugen.hristev@microchip.com>
 <20191218164348.GN695889@piout.net>
In-Reply-To: <20191218164348.GN695889@piout.net>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 888525af-e4a0-41ec-6dbd-08d783daa6b4
x-ms-traffictypediagnostic: DM5PR11MB1643:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1643148E953C7401B75BB3A9E8530@DM5PR11MB1643.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(199004)(189003)(2616005)(54906003)(478600001)(2906002)(966005)(86362001)(31686004)(81156014)(8676002)(6486002)(6916009)(36756003)(107886003)(316002)(186003)(5660300002)(26005)(53546011)(8936002)(6512007)(66476007)(66556008)(64756008)(66446008)(4326008)(66946007)(71200400001)(6506007)(31696002)(81166006)(76116006)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1643;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bO40mwsv36liD/cUs1SJYB3J0JuoRwzcU2frq1edAgoqdMBLfA++roy/oyRs+dqv5XwNGE89YoO66dLc6pUprB2TZL+jWCCAaqR/apoE6nGv3DHZ6NB25EbcqVMbdMaVtaKsU23/68epjIiQUdOSPKm9YpZo27RPguzMShG+Y+vTj73DMrUGjJZd4509b3TfxdQJgROvIRkMvAowd2XKedeTAgHFU8xFwcPOtHwQ7tHG16LPFmrQfw95RJTV7/yB54KUsobY53jx9tbze+1sN4wjFDG+W3iIOzVBnLilseHw9SJ5meH0syTT8wYNB1sgg68uMgUU2DzbKSQMJ1yBFUgwKZ0bbvr1cK808EdP64kV+T6x+zNTp7eEhdXNWxPfQojSClIKfX6CfPIkWmggNM7jBmP8IkB3PAd09VQtZFVs8a8VRy+3wtxXlDCqKUzrmUi4//NNrMPhITMvYzAC0brgyeiL6cQ899Z+sX24oNI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D8225504AE3BB4791663D834708AA64@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 888525af-e4a0-41ec-6dbd-08d783daa6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:52:21.7666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ku1Qd/oNWsLDWEDVojwilQpchgHuOPj2Lzgpsyay9QmiwEL/oXZrSRdwU6I1BekKGsht0H7HjwaF/EYkZ7gB4RTmUIOQiAMJitH5C/fhfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1643
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCk9uIDE4LjEyLjIwMTkgMTg6NDMsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KDQo+IEhp
LA0KPiANCj4gT24gMTgvMTIvMjAxOSAxNjoyNDowMCswMDAwLCBFdWdlbi5IcmlzdGV2QG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1p
Y3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhpcyBhbGxvd3MgdGhlIFJUQyBub2RlIHRvIGhhdmUgY2hp
bGQgbm9kZXMgaW4gRFQuDQo+PiBUaGlzIGFsbG93cyBzdWJub2RlcyB0byBiZSBwcm9iZWQuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2No
aXAuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvcnRjL3J0Yy1hdDkxcm05MjAwLmMgfCAyICst
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9ydGMtYXQ5MXJtOTIwMC5jIGIvZHJpdmVycy9y
dGMvcnRjLWF0OTFybTkyMDAuYw0KPj4gaW5kZXggM2I4MzNlMC4uZjFiNWIzZCAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvcnRjL3J0Yy1hdDkxcm05MjAwLmMNCj4+ICsrKyBiL2RyaXZlcnMvcnRj
L3J0Yy1hdDkxcm05MjAwLmMNCj4+IEBAIC00MjEsNyArNDIxLDcgQEAgc3RhdGljIGludCBfX2lu
aXQgYXQ5MV9ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgICAg
ICBhdDkxX3J0Y193cml0ZV9pZXIoQVQ5MV9SVENfU0VDRVYpOw0KPj4NCj4+ICAgICAgICBkZXZf
aW5mbygmcGRldi0+ZGV2LCAiQVQ5MSBSZWFsIFRpbWUgQ2xvY2sgZHJpdmVyLlxuIik7DQo+PiAt
ICAgICByZXR1cm4gMDsNCj4+ICsgICAgIHJldHVybiBvZl9wbGF0Zm9ybV9wb3B1bGF0ZShwZGV2
LT5kZXYub2Zfbm9kZSwgTlVMTCwgTlVMTCwgJnBkZXYtPmRldik7DQo+Pg0KPiANCj4gWW91IGNh
biBhdm9pZCB0aGUgRFQgYmluZGluZyBjaGFuZ2UgYW5kIERUIHBhcnNpbmcgYnkgdXNpbmcNCj4g
cGxhdGZvcm1fYWRkX2RldmljZSBoZXJlLiBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGFueSBwb2lu
dCBkZXNjcmliaW5nDQo+IHRoZSB0cmlnZ2VyIGFzIGEgY2hpbGQgbm9kZSAoYSB3YXRjaGRvZyBm
dW5jdGlvbmFsaXR5IHdvdWxkbid0IGJlDQo+IGRlc2NyaWJlZCBmb3IgZXhhbXBsZSkuDQo+IA0K
DQpIaSwNCg0KSXQncyBuZWVkZWQgYmVjYXVzZSB0aGUgQURDIG5lZWRzIGEgbGluayB0byB0aGUg
dHJpZ2dlciBkZXZpY2UuIFRoaXMgaXMgDQphIGhhcmR3YXJlIGxpbmsgaW5zaWRlIHRoZSBTb0Ms
IHNvIEkgdGhvdWdodCB0aGUgYmVzdCB3YXkgaXMgdG8gZGVzY3JpYmUgDQp0aGlzIGhhcmR3YXJl
IGlzIGluIHRoZSBEZXZpY2UgVHJlZS4NCk90aGVyd2lzZSB0aGUgQURDIG5vZGUgaXMgdW5hd2Fy
ZSBvZiB0aGUgUlRDIHRyaWdnZXJpbmcgcG9zc2liaWxpdHkuDQpJZiB3ZSBqdXN0IGFzc2lnbiB0
aGUgUlRDIHRyaWdnZXIgZGV2aWNlIHRvIHRoZSBBREMgdGhyb3VnaCB0aGUgc3lzZnMsIA0KdGhl
IEFEQyBjYW5ub3QgZGlzdGluZ3Vpc2ggYmV0d2VlbiB0aGUgUlRDIHRyaWdnZXIgYW5kIG90aGVy
IHZhcmlvdXMgDQp0cmlnZ2VycyB3aGljaCBjYW4gYmUgYXR0YWNoZWQuDQoNCj4gLS0NCj4gQWxl
eGFuZHJlIEJlbGxvbmksIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdp
bmVlcmluZw0KPiBodHRwczovL2Jvb3RsaW4uY29tDQo+IA==
