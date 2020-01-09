Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DE51357C8
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgAILTs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 06:19:48 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:56008 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgAILTs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jan 2020 06:19:48 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: FYPRjnk6AvWJhUpp4jTtlyDGiIxA9rW2ZUdftnhRN0nIk6eEQm4w7lDatR/lTD6OFPN17SzjAo
 vXOnDNFfs8mehi1xrPiDkVQ9p245N/1+IQVMK+F8dSp4QAdNxDuwbzCeEArlH6I46wy6HsNctg
 TME8ZGbiSmEAlAP9W2vfO3Ebf1InybTltvVYyKlWBIC0KZ37EiDNJ+igv097AxwVuJmajJO/Iu
 XGl008MtAPVtQEb3in2nELQlYFA+uubVlg6PckStOX8cL5V2FbF86aHQZ0ytGCzLpfvbTQ/Gwn
 3qw=
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="64163359"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jan 2020 04:19:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Jan 2020 04:19:47 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 9 Jan 2020 04:19:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGEi8TQzBCK+tG8OJmbG4hmlEtduC7pahYbBI0qierpk9m+wY0peQ+Y/VhsDbtKdTbM39M5eJzUuIqaYKO+hFluOo4WHDdiVsis+YkrKfCempfhAZO72krtElBMfNIxMo0WqcMZABDAD4uiW2ADTZdmTIAjr5oO+W7KKrQYIN0jY415iT1i+akAnCeY384QhwswOP9R0IBsBwhmBJI1M2fzwvF9T9tKPgBVzU5LUJ1y1+R1ioZDon5TM1T3K+i92K+NwqU010/DFHRLtP5Xw+5IsbCPF09PNQsuYvgKR81HcgUjSPRZgF31YZuhvT1mjMKCYO9zufjVjm/DLY5WH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8/F4CbHyggNHtGCIVhx/HKA000KCrpYJbizrCDlCiE=;
 b=YVD/oOz8QH8Vil5+RmfriOQa43df1+k0nU7YhzRkRxW9IG3KIet2rRZ2+qxrAOqJ3InpUwAh+fvVxh3PGM8QFBav24DDPpx9/fRNDHBWN6+3F4HUtqWY8ByW8WEt9QhFwV0XVokYanzobdUFGe/4G0TVjYl6mmx77FgeDdGQ6tKaJEH8dgfTJwSZIz1a91LjYS6h3BCv+YhpD15K0mvpYbKek8f3TsAP+z2UbVkrjDM17m1GIXLEnBC/WSjOEThuI3QlcSATxhdt1sKgwxG0w39hEnk9pFSVxVoDeos5Q1nUXKuG0nRUajhyhnZfFntEtAWhOEp6lFmNiReDSFZ7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8/F4CbHyggNHtGCIVhx/HKA000KCrpYJbizrCDlCiE=;
 b=kkWpGlBzHWJ75BOKbmU3ec895UY1uL4jWOfnabQDZOg5ZcQoOKTOjaeSwtQaa0V5AyGB0eiB/SHZ0aSri4If9AmH6lfj08ksROIhx2j6yzwmwNzl+uqGjkKB1JAbY5ldrXgTtfEhLU1mFc023DOzv/cZAdH3yM7vvBFevr/tizI=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1530.namprd11.prod.outlook.com (10.172.38.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 9 Jan 2020 11:19:45 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79%6]) with mapi id 15.20.2623.011; Thu, 9 Jan 2020
 11:19:45 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 04/10] rtc: at91rm9200: use of_platform_populate as return
 value
Thread-Topic: [PATCH 04/10] rtc: at91rm9200: use of_platform_populate as
 return value
Thread-Index: AQHVtb+OEQqavda3i02bVS64GBIv7afAGSQAgAACToCAAAHPgIABEL4AgAATLoCABlg0AIAauF2A
Date:   Thu, 9 Jan 2020 11:19:45 +0000
Message-ID: <7e67d601-e17e-f82c-edeb-824fc3dd89db@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
 <1576686157-11939-5-git-send-email-eugen.hristev@microchip.com>
 <20191218164348.GN695889@piout.net>
 <04264cb0-61a9-aba3-82ad-e7d12fd8441e@microchip.com>
 <20191218165831.GO695889@piout.net>
 <91cc67e1-7e14-f7b9-da77-b16d9e158f20@microchip.com>
 <20191219102321.GR695889@piout.net> <20191223111636.4698123b@archlinux>
In-Reply-To: <20191223111636.4698123b@archlinux>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 372891a8-b400-4cf8-458a-08d794f5d4c9
x-ms-traffictypediagnostic: DM5PR11MB1530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1530548676A4041243581A03E8390@DM5PR11MB1530.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(36756003)(110136005)(31686004)(86362001)(478600001)(4326008)(54906003)(31696002)(53546011)(66446008)(66556008)(66476007)(316002)(66946007)(8936002)(64756008)(81166006)(8676002)(81156014)(26005)(2616005)(6512007)(6506007)(91956017)(76116006)(6486002)(107886003)(2906002)(186003)(71200400001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1530;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yVwtaxaLPkgF3RhEYl33UStsg9hbrOCPP7hPnilW1KprV/9hxDkmSwYTVNOPi6qZq8XTMc/eK0b5sjaqa6H+xu+UD+2VddZs3QOT/6wKxgSjpZ87PBI3dK7FibsZ9O5bLl8Q8/4IOhjtmMJO20/0/ZUdAc56Fpplq7IZ5FvUZxtEZujQqd1PXAZOvWCVCRtVdyD1kzJ6+QUc97yu3EyUkP2PPfxT6NpKWJlo3slEja3nrkvtdLx1F2luH78pbXi5kAAXYNXuOVBs8VR3ITpumh92wYUqWC5FkXk7usg/5kwSuXg7FtSZOV9F5eJyOzuDKs1S25rPiDs3QKVqaEFgeCydzziqagvLD7ZfJ9V3bFgCFpKf4Swd+3GSwXTfbNj0/4yTo2qddl4UMZFzQM26dqTvopG/lmJSjdobnl9twMg5HRgj/0QKz5jNvlyA+Vgo
Content-Type: text/plain; charset="utf-8"
Content-ID: <19ED096E953C30488046F741624ED967@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 372891a8-b400-4cf8-458a-08d794f5d4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 11:19:45.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjfVtK9iegYTaouMgqRWwB1FLMqxpjuSY+iC1NkQq7EhlfTf0KFzqlVEWHCa7oqOFwPCT8Y4LGLQYXPqHn3ZHwyzdM/PqabZL8bZMal2H+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1530
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCk9uIDIzLjEyLjIwMTkgMTM6MTYsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQoNCj4gT24g
VGh1LCAxOSBEZWMgMjAxOSAxMToyMzoyMSArMDEwMA0KPiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxl
eGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+IHdyb3RlOg0KPiANCj4+IE9uIDE5LzEyLzIwMTkg
MDk6MTU6MDIrMDAwMCwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+DQo+
Pj4NCj4+PiBPbiAxOC4xMi4yMDE5IDE4OjU4LCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90ZToNCj4+
Pj4gT24gMTgvMTIvMjAxOSAxNjo1MjoyMSswMDAwLCBFdWdlbi5IcmlzdGV2QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE9uIDE4LjEyLjIwMTkgMTg6NDMsIEFsZXhh
bmRyZSBCZWxsb25pIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+PiBIaSwNCj4+Pj4+Pg0KPj4+Pj4+IE9u
IDE4LzEyLzIwMTkgMTY6MjQ6MDArMDAwMCwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4+Pj4+PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hp
cC5jb20+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoaXMgYWxsb3dzIHRoZSBSVEMgbm9kZSB0byBoYXZl
IGNoaWxkIG5vZGVzIGluIERULg0KPj4+Pj4+PiBUaGlzIGFsbG93cyBzdWJub2RlcyB0byBiZSBw
cm9iZWQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1
Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+ICAgICBkcml2
ZXJzL3J0Yy9ydGMtYXQ5MXJtOTIwMC5jIHwgMiArLQ0KPj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pj4+DQo+Pj4+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3J0Yy9ydGMtYXQ5MXJtOTIwMC5jIGIvZHJpdmVycy9ydGMvcnRjLWF0
OTFybTkyMDAuYw0KPj4+Pj4+PiBpbmRleCAzYjgzM2UwLi5mMWI1YjNkIDEwMDY0NA0KPj4+Pj4+
PiAtLS0gYS9kcml2ZXJzL3J0Yy9ydGMtYXQ5MXJtOTIwMC5jDQo+Pj4+Pj4+ICsrKyBiL2RyaXZl
cnMvcnRjL3J0Yy1hdDkxcm05MjAwLmMNCj4+Pj4+Pj4gQEAgLTQyMSw3ICs0MjEsNyBAQCBzdGF0
aWMgaW50IF9faW5pdCBhdDkxX3J0Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPj4+Pj4+PiAgICAgICAgICBhdDkxX3J0Y193cml0ZV9pZXIoQVQ5MV9SVENfU0VDRVYpOw0K
Pj4+Pj4+Pg0KPj4+Pj4+PiAgICAgICAgICBkZXZfaW5mbygmcGRldi0+ZGV2LCAiQVQ5MSBSZWFs
IFRpbWUgQ2xvY2sgZHJpdmVyLlxuIik7DQo+Pj4+Pj4+IC0gICAgIHJldHVybiAwOw0KPj4+Pj4+
PiArICAgICByZXR1cm4gb2ZfcGxhdGZvcm1fcG9wdWxhdGUocGRldi0+ZGV2Lm9mX25vZGUsIE5V
TEwsIE5VTEwsICZwZGV2LT5kZXYpOw0KPj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gWW91IGNhbiBh
dm9pZCB0aGUgRFQgYmluZGluZyBjaGFuZ2UgYW5kIERUIHBhcnNpbmcgYnkgdXNpbmcNCj4+Pj4+
PiBwbGF0Zm9ybV9hZGRfZGV2aWNlIGhlcmUuIEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYW55IHBv
aW50IGRlc2NyaWJpbmcNCj4+Pj4+PiB0aGUgdHJpZ2dlciBhcyBhIGNoaWxkIG5vZGUgKGEgd2F0
Y2hkb2cgZnVuY3Rpb25hbGl0eSB3b3VsZG4ndCBiZQ0KPj4+Pj4+IGRlc2NyaWJlZCBmb3IgZXhh
bXBsZSkuDQoNCkhpIEFsZXhhbmRyZSwNCg0KSSBzdGFydGVkIHRvIHdvcmsgb24gdGhpcywgSSBh
bSB0cnlpbmcgdG8gYWRkIGFuZCBwcm9iZSB0aGUgDQpydGNfYWRjX3RyaWdnZXIgd2l0aCBwbGF0
Zm9ybV9kZXZpY2VfYWRkLg0KDQpIb3dldmVyLCBzb21lIGlzc3VlcyBhcmlzZTogdGhpcyBtZWFu
cyB0aGF0IHRoZSBydGNfYWRjX3RyaWdnZXIgd2lsbCBub3QgDQpiZSBPRi1jb21wYXRpYmxlLCBz
bywgaG93IGNhbiBJIGlkZW50aWZ5IHRoZSBkcml2ZXIgdG8gcHJvYmUgPw0KU2Vjb25kLCBieSBh
ZGRpbmcgYSBuZXcgcGxhdGZvcm0gZGV2aWNlIGZyb20gdGhlIFJUQyBkcml2ZXIsIHdvdWxkIG1l
YW4gDQp0aGF0IEkgd291bGQgaGF2ZSB0byBzdXBwbHkgaXQncyBwcm9iZS9yZW1vdmUgZnVuY3Rp
b25zLCB3aGljaCBJIGNhbm5vdCANCmhhdmUgaGVyZS4gVGhvc2UgYXJlIGluIHRoZSBydGNfYWRj
X3RyaWdnZXIgaWlvIGRyaXZlci4NCg0KSW4gZmFjdCwgdGhlIHF1ZXN0aW9uIGlzLCB3aGljaCBp
cyB0aGUgbWVjaGFuaXNtIHlvdSBzdWdnZXN0ZWQsIHRvIGJlIA0KYWJsZSB0byBwcm9iZSB0aGUg
cnRjX2FkY190cmlnZ2VyLCBmcm9tIGluc2lkZSB0aGUgcnRjIGRyaXZlciwgd2l0aG91dCANCnVz
aW5nIGEgY2hpbGQgbm9kZSBpbiBEVCwgYXMgeW91IHJlcXVlc3RlZCA/DQpUaGUgcnRjX2FkY190
cmlnZ2VyIG5lZWRzIGEgTUVNIHJlc291cmNlLCBhbmQgYSBwYXJlbnQsIGFuZCBpdCBtdXN0IA0K
cmVzaWRlIGluc2lkZSB0aGUgSUlPIHN1YnN5c3RlbS4NCg0KVGhhbmtzLA0KRXVnZW4NCg0KDQo+
Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBIaSwNCj4+Pj4+DQo+Pj4+PiBJdCdzIG5lZWRlZCBiZWNhdXNl
IHRoZSBBREMgbmVlZHMgYSBsaW5rIHRvIHRoZSB0cmlnZ2VyIGRldmljZS4gVGhpcyBpcw0KPj4+
Pj4gYSBoYXJkd2FyZSBsaW5rIGluc2lkZSB0aGUgU29DLCBzbyBJIHRob3VnaHQgdGhlIGJlc3Qg
d2F5IGlzIHRvIGRlc2NyaWJlDQo+Pj4+PiB0aGlzIGhhcmR3YXJlIGlzIGluIHRoZSBEZXZpY2Ug
VHJlZS4NCj4+Pj4+IE90aGVyd2lzZSB0aGUgQURDIG5vZGUgaXMgdW5hd2FyZSBvZiB0aGUgUlRD
IHRyaWdnZXJpbmcgcG9zc2liaWxpdHkuDQo+Pj4+PiBJZiB3ZSBqdXN0IGFzc2lnbiB0aGUgUlRD
IHRyaWdnZXIgZGV2aWNlIHRvIHRoZSBBREMgdGhyb3VnaCB0aGUgc3lzZnMsDQo+Pj4+PiB0aGUg
QURDIGNhbm5vdCBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZSBSVEMgdHJpZ2dlciBhbmQgb3RoZXIg
dmFyaW91cw0KPj4+Pj4gdHJpZ2dlcnMgd2hpY2ggY2FuIGJlIGF0dGFjaGVkLg0KPj4+Pj4NCj4+
Pj4NCj4+Pj4gSSdtIG5vdCBzdXJlIHRoaXMgbGlua3MgaXMgcmVxdWlyZWQgYnV0IEkgd2lsbCBs
ZXQgSm9uYXRoYW4gcmV2aWV3LiBFdmVuDQo+Pj4+IGlmIGl0IGlzIG5lZWRlZCwgeW91IGNhbiBz
dGlsbCB1c2UgdGhlIHJ0YyBub2RlIHRvIGRlc2NyaWJlIHRoYXQgbGluay4NCj4+Pg0KPj4+IEFj
dHVhbGx5LCB0aGUgUlRDIG5vZGUgY291bGQgcG90ZW50aWFsbHkgaGF2ZSB0d28gZGlmZmVyZW50
IEFEQw0KPj4+IHRyaWdnZXJzLiBUaGVyZSBpcyBhbm90aGVyIE9VVDEgZmllbGQgdGhhdCBjYW4g
ZG8gYSBzZWNvbmQgdHJpZ2dlciBmb3INCj4+PiB0aGUgQURDIG9ubHkgZm9yIHRoZSBsYXN0IGNo
YW5uZWwuIEZ1dHVyZSBkZXZlbG9wbWVudCBtaWdodCBhZGQgdGhpcw0KPj4+IHRyaWdnZXIsIHNv
LCB3aXRoIHRoYXQgaW4gbWluZCwgSSB0aGluayBpdCdzIGJlc3QgdG8gbGluayB0aGUgZXhhY3QN
Cj4+PiB0cmlnZ2VyIGFuZCBub3QgdGhlIFJUQyBub2RlLg0KPj4NCj4+IE5vdGhpbmcgcHJldmVu
dHMgeW91IGZyb20gdXNpbmcgYW4gaW5kZXggd2l0aCB0aGUgcGhhbmRsZSAoYW5kIEkgd291bGQN
Cj4+IGFkZCBhIHR5cGUgaW4gdGhhdCBjYXNlIHRoZW4pLiBIYXZpbmcgc3Vibm9kZXMgaW4gdGhl
IERUIGlzIG5vdCByZWFsbHkgYQ0KPj4gZ29vZCBpZGVhLiBUaGUgSVAgaXMgdGhlIFJUQywgaXQg
anVzdCBoYXBwZW5zIHRvIGhhdmUgc29tZSBvdXRwdXRzLg0KPj4gU2VlIHdoYXQgaGFzIGJlZW4g
ZG9uZSBmb3IgdGhlIFBNQy4NCj4+DQo+Pg0KPiANCj4gSWYgaXQgY2FuIGJlIGRvbmUgZWl0aGVy
IHdheSwgbGV0J3MgYXZvaWQgYWRkaW5nIHRvIHRoZSBydGMgZHQgYmluZGluZy4NCj4gDQo+IEpv
bmF0aGFuDQo+IA0KPiA=
