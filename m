Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2B125D68
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 10:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLSJPN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 04:15:13 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:13614 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSJPM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 04:15:12 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: F/FQchJLdDY1R2vAdyYFxU6MCdwmtS3eQTq4wFFNSZyCmvop9landZkK6hfmY5FG0LCAgo8EbM
 o059HnC4Yq8jgBfpAYhxlXv2H6Kfy4KW1NLA+DbCcuTB/Y5x7Byp4yyQHslqFQ4bXqsEgB9FDv
 UxtoeguWGSlO2yuu3KygAwUDU/kyvEat2qxwwNoTFGnVbtYF5PO7w/E2NOW1Y2lAoXY0KKd2wQ
 sQxgN3/k+wcY/u4VvnkvD+GZ5Fp00SZvJ5h5idWAkvXdzOHBBNFnk9vTc0hc1H3U91Dz8TsjoM
 gDQ=
X-IronPort-AV: E=Sophos;i="5.69,331,1571727600"; 
   d="scan'208";a="59010997"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Dec 2019 02:15:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Dec 2019 02:15:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Dec 2019 02:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScqlVI2JfuXSEWH9r+kpDum4sqr5XzrkYza24C+6N+gltvLciCOFMXnI0QIcEdhACYu4xgvoBztHD9HS9zDKaMa7lyqXV35BY6k3iOxGjYKiGZwR9oeP/gfZC6SVhgowpONOGs3a2M6Q5IOR4cas3GjLAtqbnb6gFuuM3vgf42+uLQaMYn8ctLbyAIXUib1SJrskvZlu+LxTPg3JtURX18D4CCOzJ/Wg4YJMsOVMKxjvcEfvqbhLxwTUzAg8wcmAgjiE3y3UrCcLUwbjpv0wU3S/1WzGFR2JL1LhMp39OiRIXm8XSjN74rQT+sS0DU0MQuivOwaOedxWfBqneezGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTmaT4Dbw9ErdnHi+2Fo1iCrO78QIOIPp/13Yms+YSI=;
 b=nP1/qV/ppzyjBnsU13VRBvs1AP2duOUqTs0BlFFe7YtBWkVar/aTtlWXEiNRyyYAZ6vjq7kaU2+DRAJjjZDd1g8H2XhxVFHgryVz0j5KKVkaYqX3oBprja9cl1nX4rm7hWXbPexhEMM653XkeUdpTRA7RZmPe9x6WWwjwRQ8QgMGySe1gMu2AH/4Kc1pbKUsarTRn+L/Eg4sdg9CcUIesdho1qwA3jBc79c4AUgeiAnwHO6HvnN4PFXRlXzFbQ8oMpWfuAvc5v4hDG4FBafl4UHjcL4WsC+YF8OrefTiHnacZkhYxayWxUniHjhADL0A0zGbF1EaG9mhj6I+6Z2gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTmaT4Dbw9ErdnHi+2Fo1iCrO78QIOIPp/13Yms+YSI=;
 b=WzStBP9cILMTUYo7/wAe2tRJNZDGsDBTD6IICIXZnsh1Cw+o+gy1gMmm4g+UlRorVZenZ6oyMzc3D/ZTgeTh/hKu/PNNboqL1fWk22YInc2PVbqC+mfJfuzLGPbKdR2MSOu4BgJcSJ9bzpy1omDEvUuCFKRonQAN1wzu6PrdCpk=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1803.namprd11.prod.outlook.com (10.175.89.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 09:15:02 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Thu, 19 Dec
 2019 09:15:02 +0000
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
Thread-Index: AQHVtb+OEQqavda3i02bVS64GBIv7afAGSQAgAACToCAAAHPgIABEL4A
Date:   Thu, 19 Dec 2019 09:15:02 +0000
Message-ID: <91cc67e1-7e14-f7b9-da77-b16d9e158f20@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
 <1576686157-11939-5-git-send-email-eugen.hristev@microchip.com>
 <20191218164348.GN695889@piout.net>
 <04264cb0-61a9-aba3-82ad-e7d12fd8441e@microchip.com>
 <20191218165831.GO695889@piout.net>
In-Reply-To: <20191218165831.GO695889@piout.net>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ce2a8df-4e50-44da-04f8-08d78463ede4
x-ms-traffictypediagnostic: DM5PR11MB1803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB180300021EF177867108C72AE8520@DM5PR11MB1803.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(316002)(2616005)(66556008)(53546011)(966005)(71200400001)(107886003)(66476007)(8936002)(26005)(2906002)(8676002)(6506007)(66446008)(64756008)(6486002)(81166006)(66946007)(76116006)(81156014)(5660300002)(31696002)(478600001)(54906003)(6916009)(31686004)(6512007)(186003)(4326008)(86362001)(91956017)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1803;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YKs5mU4tt4gZBK9x5T1ypnLc7iuJ+FmsoSwwZ0p6c44S6LoYIOrHqV4Mmyk7hYfCrnTPypdRgKzBso6URWVQ7fPhnOvIiWzx3QOAlO5UdsAIVwrUBDW3lTH8ldQFO50m4Sp8VltXLgD3EOq67oPOByJPcnx+MpUjfCqvCZf/6+7QKyte0eLB3uEJvuqx+XCDGNW35nubdyHNF9nL35qRk8UyewTm03I4qmmf9nbx1KGzpgpuBJH3wgjruGh5a9bnGLngiOAc0L8J04QYFQXWNGUSh6GjbYoXb0A135GYAiAuVQgNE5iU8qJSj94Q+nb2l89Etld0w72mhByG8n52jLvPAOmB5NRWyTXER3wD+Pp9swSVWIVVo3TVC3aMttfUYHZxlMPn4Mdg4eN1aSvMeGZWdoYDNDmCyTkioXMtnIl3EEpGRfrcCnlxKlzuIxHr6G8i1jq/FaVypLORrbdIJDMUnHnQNT7+8PMxVgWvxg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D714D64720BC224783739E60B0E26B02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce2a8df-4e50-44da-04f8-08d78463ede4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 09:15:02.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEziUnSqvcl+pBAEOtLUTmp9fYPc2I3FICVf7Vh3nt73cYBkCr3D08jeSILKDI4MYwluIxQs45kVEX+hGJIdN+a+Mtd2vBYtQrB4lAq7huw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1803
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCk9uIDE4LjEyLjIwMTkgMTg6NTgsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBPbiAx
OC8xMi8yMDE5IDE2OjUyOjIxKzAwMDAsIEV1Z2VuLkhyaXN0ZXZAbWljcm9jaGlwLmNvbSB3cm90
ZToNCj4+DQo+Pg0KPj4gT24gMTguMTIuMjAxOSAxODo0MywgQWxleGFuZHJlIEJlbGxvbmkgd3Jv
dGU6DQo+Pg0KPj4+IEhpLA0KPj4+DQo+Pj4gT24gMTgvMTIvMjAxOSAxNjoyNDowMCswMDAwLCBF
dWdlbi5IcmlzdGV2QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IEZyb206IEV1Z2VuIEhyaXN0
ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+Pj4NCj4+Pj4gVGhpcyBhbGxvd3Mg
dGhlIFJUQyBub2RlIHRvIGhhdmUgY2hpbGQgbm9kZXMgaW4gRFQuDQo+Pj4+IFRoaXMgYWxsb3dz
IHN1Ym5vZGVzIHRvIGJlIHByb2JlZC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW4g
SHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAg
ZHJpdmVycy9ydGMvcnRjLWF0OTFybTkyMDAuYyB8IDIgKy0NCj4+Pj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3J0Yy9ydGMtYXQ5MXJtOTIwMC5jIGIvZHJpdmVycy9ydGMvcnRjLWF0OTFybTky
MDAuYw0KPj4+PiBpbmRleCAzYjgzM2UwLi5mMWI1YjNkIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2
ZXJzL3J0Yy9ydGMtYXQ5MXJtOTIwMC5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvcnRjL3J0Yy1hdDkx
cm05MjAwLmMNCj4+Pj4gQEAgLTQyMSw3ICs0MjEsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBhdDkx
X3J0Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+PiAgICAgICAgIGF0
OTFfcnRjX3dyaXRlX2llcihBVDkxX1JUQ19TRUNFVik7DQo+Pj4+DQo+Pj4+ICAgICAgICAgZGV2
X2luZm8oJnBkZXYtPmRldiwgIkFUOTEgUmVhbCBUaW1lIENsb2NrIGRyaXZlci5cbiIpOw0KPj4+
PiAtICAgICByZXR1cm4gMDsNCj4+Pj4gKyAgICAgcmV0dXJuIG9mX3BsYXRmb3JtX3BvcHVsYXRl
KHBkZXYtPmRldi5vZl9ub2RlLCBOVUxMLCBOVUxMLCAmcGRldi0+ZGV2KTsNCj4+Pj4NCj4+Pg0K
Pj4+IFlvdSBjYW4gYXZvaWQgdGhlIERUIGJpbmRpbmcgY2hhbmdlIGFuZCBEVCBwYXJzaW5nIGJ5
IHVzaW5nDQo+Pj4gcGxhdGZvcm1fYWRkX2RldmljZSBoZXJlLiBJIGRvbid0IHRoaW5rIHRoZXJl
IGlzIGFueSBwb2ludCBkZXNjcmliaW5nDQo+Pj4gdGhlIHRyaWdnZXIgYXMgYSBjaGlsZCBub2Rl
IChhIHdhdGNoZG9nIGZ1bmN0aW9uYWxpdHkgd291bGRuJ3QgYmUNCj4+PiBkZXNjcmliZWQgZm9y
IGV4YW1wbGUpLg0KPj4+DQo+Pg0KPj4gSGksDQo+Pg0KPj4gSXQncyBuZWVkZWQgYmVjYXVzZSB0
aGUgQURDIG5lZWRzIGEgbGluayB0byB0aGUgdHJpZ2dlciBkZXZpY2UuIFRoaXMgaXMNCj4+IGEg
aGFyZHdhcmUgbGluayBpbnNpZGUgdGhlIFNvQywgc28gSSB0aG91Z2h0IHRoZSBiZXN0IHdheSBp
cyB0byBkZXNjcmliZQ0KPj4gdGhpcyBoYXJkd2FyZSBpcyBpbiB0aGUgRGV2aWNlIFRyZWUuDQo+
PiBPdGhlcndpc2UgdGhlIEFEQyBub2RlIGlzIHVuYXdhcmUgb2YgdGhlIFJUQyB0cmlnZ2VyaW5n
IHBvc3NpYmlsaXR5Lg0KPj4gSWYgd2UganVzdCBhc3NpZ24gdGhlIFJUQyB0cmlnZ2VyIGRldmlj
ZSB0byB0aGUgQURDIHRocm91Z2ggdGhlIHN5c2ZzLA0KPj4gdGhlIEFEQyBjYW5ub3QgZGlzdGlu
Z3Vpc2ggYmV0d2VlbiB0aGUgUlRDIHRyaWdnZXIgYW5kIG90aGVyIHZhcmlvdXMNCj4+IHRyaWdn
ZXJzIHdoaWNoIGNhbiBiZSBhdHRhY2hlZC4NCj4+DQo+IA0KPiBJJ20gbm90IHN1cmUgdGhpcyBs
aW5rcyBpcyByZXF1aXJlZCBidXQgSSB3aWxsIGxldCBKb25hdGhhbiByZXZpZXcuIEV2ZW4NCj4g
aWYgaXQgaXMgbmVlZGVkLCB5b3UgY2FuIHN0aWxsIHVzZSB0aGUgcnRjIG5vZGUgdG8gZGVzY3Jp
YmUgdGhhdCBsaW5rLg0KDQpBY3R1YWxseSwgdGhlIFJUQyBub2RlIGNvdWxkIHBvdGVudGlhbGx5
IGhhdmUgdHdvIGRpZmZlcmVudCBBREMgDQp0cmlnZ2Vycy4gVGhlcmUgaXMgYW5vdGhlciBPVVQx
IGZpZWxkIHRoYXQgY2FuIGRvIGEgc2Vjb25kIHRyaWdnZXIgZm9yIA0KdGhlIEFEQyBvbmx5IGZv
ciB0aGUgbGFzdCBjaGFubmVsLiBGdXR1cmUgZGV2ZWxvcG1lbnQgbWlnaHQgYWRkIHRoaXMgDQp0
cmlnZ2VyLCBzbywgd2l0aCB0aGF0IGluIG1pbmQsIEkgdGhpbmsgaXQncyBiZXN0IHRvIGxpbmsg
dGhlIGV4YWN0IA0KdHJpZ2dlciBhbmQgbm90IHRoZSBSVEMgbm9kZS4NCg0KPiANCj4gLS0NCj4g
QWxleGFuZHJlIEJlbGxvbmksIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBl
bmdpbmVlcmluZw0KPiBodHRwczovL2Jvb3RsaW4uY29tDQo+IA==
