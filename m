Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8B18F30D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 11:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgCWKmX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 06:42:23 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:21079 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgCWKmW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 06:42:22 -0400
IronPort-SDR: v57Mr7kaObUdgeBj/f/KUMoUJ5j3R81yPUWLIXllIZuBYkmbhu8SijGbAoIik9MP0Wlxa58Zzj
 yCYAAsARq00rFcHl4TvxKWPg+AUIw+ohD5xWZ62/8r7YvatmFoCio+uK/Yt4tnNYD1lqf81of7
 nxrmBSffhHdM2N+6tmn+331+XqgIEFdfUfHgQaqTv9/xxsWyqYTU7zmUKwmDzcCLYtVlsMNhkh
 yq9tB6bPmQ7ERPe+03yANDh9tXEFNmyXtRO6DiJFbGHZdqfCZiiddc1tlVYpNJuIwiLZnFLj+0
 M/U=
X-IronPort-AV: E=Sophos;i="5.72,296,1580799600"; 
   d="scan'208";a="69815413"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2020 03:42:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Mar 2020 03:42:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Mar 2020 03:42:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKWfHIH7TB9nXwC4AlOtDgs4PKFHwITddf3ABQDHvOOgQNhNwMXuFPt0UJ2sqrrsbhXRsoTFdY2zUKVqRyWVu9c0oZZ21di60q99kK5bmXrTx3HuQuEsut7o75xHml666Cwuhmd6XkcXoZcrpLt6b0Q2+IznWTszH0adxqwDHIQ8D/0Y4JRoEaEN7eYS57tnOyk1XFHXZ/32eQXnPZqdQKU7TSitaKpwfu5yepxu8JTwiolx3wwOO5F+cIf4N+yr4oAtNukTMV4Fh6D7upVlmO+gKbQWdMpA0pTkJVL9TTntcYUjh2N6y0tiLxAA417NlMoE+N5FuD6ZBd4aMGAGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JY6qpyo+yshj9POOfT2uMlso2WMNE9dwzh6iOCCVtg=;
 b=eLqEj5rllA67O3nTGSFGFzwoHhcRux385fNKLhQ1cuMGpewa+Kd3Ig7TmrTjJUtqzO749P+ybuevb45wJR91ebnGqWcDtbeGvM6iFlhPhcpXWr94cUlyaxGwkg1M90bDAAFKX4Pznf8+FWIhPkpT4mHj0zqbNpDRbjM8UyYd5m5JB5T1aV69bV4KFR5A3BUC6UofSab8oL2h/qpxmopb0kmbV6x+2HIVX+ZiMzvyL2b3cqP294sf6hcbn89hJ5n/T4gvZQKqeDNUYhge+OFJQ9gglAz9QcRSJOUxmi/IAVc/W1UaaVoLuyiCoN5gHG5S6ah4e9NgQz7RFpCDLZVnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JY6qpyo+yshj9POOfT2uMlso2WMNE9dwzh6iOCCVtg=;
 b=UcMP+iACD/ogI04kIkb/xFMbt59Qxsr5YnghPjGCqyvDI2dZzb0tJIOk6SgypIoRjmzcpiNShn/qw7xfNFqZee8nUKqzwSVBDZ0uaEj+ZlIbJvSBZUAFAzLJbXA/kybaujHDABC0BDAUTZxAEcjSiYetmS+KXUws+4hKrS9l50Q=
Received: from DM6PR11MB4123.namprd11.prod.outlook.com (2603:10b6:5:196::12)
 by DM6PR11MB4252.namprd11.prod.outlook.com (2603:10b6:5:201::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 10:42:19 +0000
Received: from DM6PR11MB4123.namprd11.prod.outlook.com
 ([fe80::f42c:82b3:ecda:5ff4]) by DM6PR11MB4123.namprd11.prod.outlook.com
 ([fe80::f42c:82b3:ecda:5ff4%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 10:42:19 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 1/3] iio: adc: at91-sama5d2_adc: fix differential
 channels in triggered mode
Thread-Topic: [PATCH v3 1/3] iio: adc: at91-sama5d2_adc: fix differential
 channels in triggered mode
Thread-Index: AQHV1dqFsAVAQA8Fs0errk5mUZMqBagHxLQAgE6PCoA=
Date:   Mon, 23 Mar 2020 10:42:19 +0000
Message-ID: <5c0829d6-3b8d-0efc-0ffc-042727cb9115@microchip.com>
References: <1580216189-27418-1-git-send-email-eugen.hristev@microchip.com>
 <1580216189-27418-2-git-send-email-eugen.hristev@microchip.com>
 <20200202110206.7326ce4d@archlinux>
In-Reply-To: <20200202110206.7326ce4d@archlinux>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-originating-ip: [86.120.188.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc701c65-661d-444a-6655-08d7cf16dcdf
x-ms-traffictypediagnostic: DM6PR11MB4252:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB42521138B6FB150BE11F41DFE8F00@DM6PR11MB4252.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(31696002)(53546011)(8676002)(86362001)(8936002)(2616005)(81166006)(6512007)(81156014)(66476007)(71200400001)(76116006)(64756008)(5660300002)(66446008)(26005)(66556008)(66946007)(36756003)(2906002)(316002)(6916009)(6506007)(31686004)(6486002)(478600001)(186003)(4326008)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4252;H:DM6PR11MB4123.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JvBOvfVO/BC8FxbqhQXfNnUJdePCA/yMZ9axu8sh9NDRUBO19Z4Df8dNacPrbwXcq61YdwsgDTJm9sVgyODHVr4DUv4oSGzMFUqc5dbYPDWi3W2L26BcO6hf8TCApZxjKEZqP6/yMuB2vqlF7Q5cVL/giUmS+DV8AQUmh8bqe+H5WvDps7V02q8X9ZproFBYpJhWwr1/ulKT6AtddnikyPgTyiVVyKmVtAPml4nFEe/+i/4Ms7Mcyp1f4BjEHxMmVICK5yz+yH6iH4hAXoGa1pfbzwwz1frbaKR3YjbwyVCvJXkSiU+0+TWHubQWu7bl2Bdrx/s8N8lVmAp7kxkAPnd/Lhek2zaqaZD2EMgqOBSt7Oiqt1hzM9mrDw9fwca/L1HM0DInyZCRGcpI1V3DFzezX1PSvP2CAjLyDNoeyGc7UZvukmQi8XilJDQjF+TT
x-ms-exchange-antispam-messagedata: 9+k+keZboyXtSN6dUN3nDXfwCVX4yEgA8Z9eoe/yOk7vyZPl4iZPRdPP/XfOxOaivi4B338tYh0MZA8uGMaoHdUBNl07yldwsfSPrV/E2lk64M8TZljyme4Bk0jXtc66x2bCb1VQAbHFZN6UlhrycQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E38F89B21C5D104882476C94951021F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fc701c65-661d-444a-6655-08d7cf16dcdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 10:42:19.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZjISqWR4GoN3fr5nLREkbwa/alkp+jC7j2kAUWVoyUKAJjciAAkIvtofL6x76OqkKvPVHD8I++PR1MBPk3Owh3DxQAV+8FMQpJwRz9VvFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4252
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMDIuMDIuMjAyMCAxMzowMiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gVHVlLCAy
OCBKYW4gMjAyMCAxMjo1NzozOSArMDAwMA0KPiA8RXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29t
PiB3cm90ZToNCj4gDQo+PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3Jv
Y2hpcC5jb20+DQo+Pg0KPj4gVGhlIGRpZmZlcmVudGlhbCBjaGFubmVscyByZXF1aXJlIHdyaXRp
bmcgdGhlIGNoYW5uZWwgb2Zmc2V0IHJlZ2lzdGVyIChDT1IpLg0KPj4gT3RoZXJ3aXNlIHRoZXkg
ZG8gbm90IHdvcmsgaW4gZGlmZmVyZW50aWFsIG1vZGUuDQo+PiBUaGUgY29uZmlndXJhdGlvbiBv
ZiBDT1IgaXMgbWlzc2luZyBpbiB0cmlnZ2VyZWQgbW9kZS4NCj4+DQo+PiBGaXhlczogNWUxYTFk
YTBmOGM5ICgiaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGFkZCBodyB0cmlnZ2VyIGFuZCBi
dWZmZXIgc3VwcG9ydCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5o
cmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+IEFwcGxpZWQgdG8gdGhlIGZpeGVzLXRvZ3JlZyBicmFu
Y2ggb2YgaWlvLmdpdC4gIE5vcm1hbGx5IEkgYXZvaWQgcmViYXNpbmcgdGhhdA0KPiBicmFuY2gg
YnV0IEkgbWF5IGRvIHNvIHRoaXMgdGltZSBnaXZlbiBpdCdzIGN1cnJlbnRseSBtaWQgbWVyZ2Ug
d2luZG93Lg0KPiANCj4gVGhlIG90aGVyIHR3byBwYXRjaGVzIHdpbGwgaGF2ZSB0byB3YWl0IGZv
ciB0aGlzIG9uZSB0byBnZXQgdXBzdHJlYW0gb2YNCj4gbXkgdG9ncmVnIGJyYW5jaCB3aGljaCB3
aWxsIHRha2UgYSBmZXcgd2Vla3MuDQo+IA0KPiBQbGVhc2UgZ2l2ZSBtZSBhIHBva2UgaWYgSSBz
ZWVtIHRvIGhhdmUgZm9yZ290dGVuIGFib3V0IHRoZW0hDQo+IA0KDQpQb2tlICENCg0KRXVnZW4N
Cg0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2
MjoNCj4+IC0gbW92ZWQgdG8gdGhlIHN0YXJ0IG9mIHRoZSBsaXN0DQo+Pg0KPj4gICBkcml2ZXJz
L2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIHwgMTUgKysrKysrKysrKysrKysrDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1h
NWQyX2FkYy5jDQo+PiBpbmRleCBlMTg1MGYzLi4yYTY5NTBhIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPj4gKysrIGIvZHJpdmVycy9paW8vYWRj
L2F0OTEtc2FtYTVkMl9hZGMuYw0KPj4gQEAgLTcyMyw2ICs3MjMsNyBAQCBzdGF0aWMgaW50IGF0
OTFfYWRjX2NvbmZpZ3VyZV90cmlnZ2VyKHN0cnVjdCBpaW9fdHJpZ2dlciAqdHJpZywgYm9vbCBz
dGF0ZSkNCj4+DQo+PiAgICAgICAgZm9yX2VhY2hfc2V0X2JpdChiaXQsIGluZGlvLT5hY3RpdmVf
c2Nhbl9tYXNrLCBpbmRpby0+bnVtX2NoYW5uZWxzKSB7DQo+PiAgICAgICAgICAgICAgICBzdHJ1
Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hhbiA9IGF0OTFfYWRjX2NoYW5fZ2V0KGluZGlvLCBi
aXQpOw0KPj4gKyAgICAgICAgICAgICB1MzIgY29yOw0KPj4NCj4+ICAgICAgICAgICAgICAgIGlm
ICghY2hhbikNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiBAQCAtNzMy
LDYgKzczMywyMCBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX2NvbmZpZ3VyZV90cmlnZ2VyKHN0cnVj
dCBpaW9fdHJpZ2dlciAqdHJpZywgYm9vbCBzdGF0ZSkNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgY29udGludWU7DQo+Pg0KPj4gICAgICAgICAgICAgICAgaWYgKHN0YXRlKSB7DQo+PiArICAg
ICAgICAgICAgICAgICAgICAgY29yID0gYXQ5MV9hZGNfcmVhZGwoc3QsIEFUOTFfU0FNQTVEMl9D
T1IpOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChjaGFuLT5kaWZmZXJlbnRp
YWwpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb3IgfD0gKEJJVChjaGFuLT5j
aGFubmVsKSB8DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVChj
aGFuLT5jaGFubmVsMikpIDw8DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEFUOTFfU0FNQTVEMl9DT1JfRElGRl9PRkZTRVQ7DQo+PiArICAgICAgICAgICAgICAgICAg
ICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29yICY9IH4oQklUKGNo
YW4tPmNoYW5uZWwpIDw8DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QVQ5MV9TQU1BNUQyX0NPUl9ESUZGX09GRlNFVCk7DQo+PiArDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgYXQ5MV9hZGNfd3JpdGVsKHN0LCBBVDkxX1NBTUE1RDJfQ09SLCBjb3IpOw0KPj4gKyAg
ICAgICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICAgICAgIGlmIChzdGF0ZSkgew0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICBhdDkxX2FkY193cml0ZWwoc3QsIEFUOTFfU0FNQTVEMl9DSEVS
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUKGNoYW4tPmNo
YW5uZWwpKTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgLyogZW5hYmxlIGlycSBvbmx5IGlm
IG5vdCB1c2luZyBETUEgKi8NCj4gDQoNCg==
