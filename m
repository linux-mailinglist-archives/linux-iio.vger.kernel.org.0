Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4C391E09
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhEZRZJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 13:25:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55913 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhEZRYp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 May 2021 13:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622049794; x=1653585794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ieUaTmdH0Ca1obAkOxQ7mkpCnIyNUbjyhI8dwlCieHE=;
  b=2NzDzzsl0s++t+ufz7yGV2ZkIsDUBNYO5aztctHVN+mMZdSH3QjbHhVR
   vtPJD9bVMMB2xVarkQX50y2O+ZKnQnDq+4s9ryqpiUmRte3HrS/zbnNLv
   09c6sF3MXyZqzZIC9SUHnyTWFFZV7mSFrTSTHDm5Ev/z37mx3pOvvpp5/
   OJauyCf+sy7yRlYaaBszAINyeoFRTiIC5kq8QB87MJFD2JIDE+aFtN6Pg
   clIWTAQb1F1mgTOKVaa9yZPwuzrJbqrSZWuxwKmskj+kPwBLnq0KQuTSd
   YTlBkQloOsNfYi5JaW6gQIclwXrwuLnHpkbUfga2fDdQagmBYI3K4n/zq
   A==;
IronPort-SDR: zkPiMsKMx4JQz2aZbhLHzEdoy++UnO4FHerhrsBwcCLZs5eXFbaDF+V5RLwM7Gz24/G3qN0lF6
 hnpzTLJBqac3ed76R8KtRH3yTfJNOJmQeHYhRJtRmlHoG99K1Z/GUHyDRv8NTDeb9iRslrcQ8x
 v02h/Lzv9vWOjhLC8L/RQIn364FBdHJjKBGYQTzUmY00Eu5fguMqNtHNUOZWbOMOMeuS4uglQD
 RhtM92qtcf4SRMQ6ZgaERJKVZLarCwSItGlMab9YxlEITS8zp1T2ScEQ4hG/lmr1nw/NLx1tJt
 hlY=
X-IronPort-AV: E=Sophos;i="5.82,331,1613458800"; 
   d="scan'208";a="123045340"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2021 10:23:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 10:23:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 26 May 2021 10:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOBAgnSmR5rbKQpRmhdqPws557IbDVO/RlCvVK0bsX1/qBbl94B23wz83vRN5w3Xglw6oIvAYYkAmXloBs8PAYyvFwpXzn7uY8wAEvF1kv1qx7a7cv0HRw6OZwXsk0Qzt8fBliNOL70VS0qb9QcR5faS7VoiupcJk9j/ZL/D4NepSkCDqaTnshgn10MBqwxpDBA2GO6Tz/2wweto5CAp50ufkYQyZekSC7oT6qqeXzBaEvWA+vabeod32pG2N+p8nPJvNIsVYET7M6/aIIS9k+LWbkC4oR++fcDyJXMbzKS572msah5OV5ju8t28lcFuZGjoCKWjDUAJiHsZVc9i7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieUaTmdH0Ca1obAkOxQ7mkpCnIyNUbjyhI8dwlCieHE=;
 b=ZodHmi2pSidAARbVgGUrnpQFm3VjRKZVo7ZDKcPYXDu8ERKCqeC/1NNw6oUa/Unw6wn9bG/TaKwNN/1BF32Gea9Vo6QQyiX+SdbBZySghVDMStURRtviPYVfjclaksr9Wt2TYaFV/WQXoA2oeNVf2T89eVIomiojBPFrFZbTDLsuayXHtcqvt3mrzj8WYVNaJGJZIxtmzujbJ6CqdJSgGjr/ojO6lxUne1FVh5T1K3J0lYaSABkNHQDHHdxasyS2cc1+WH6U1Y9YeJEXu4Dgao8j26khZgtVE3laalrOrRltQ8HKRkJusAHkJ2eVv6zTYU4hdx8DgXUTiqQN9P3IdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieUaTmdH0Ca1obAkOxQ7mkpCnIyNUbjyhI8dwlCieHE=;
 b=YGuz2P8AJZ8f/AmOBCvD/p+Cf3WUFu+ZiJ89YIZD9DnpkJJzuYloGnyDooz5PGxzUwxvPXjfSF5rsQGmYOxNt0b0QHUVspMoMzrvUgRzd/PUvgHY6tVukUA8P8b/mdHyN9Dnw2STlN5H/j79i3dgIRmHjLbQXmQcFWQfMtgnWVg=
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 17:23:11 +0000
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::71ec:217b:98c4:4dd7]) by SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::71ec:217b:98c4:4dd7%6]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 17:23:11 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/11] iio: adc: at91-sama5d2: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Thread-Topic: [PATCH 01/11] iio: adc: at91-sama5d2: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Thread-Index: AQHXPq2XSI8GnAOYPkOnN1ndWxRn0ar2KjsA
Date:   Wed, 26 May 2021 17:23:11 +0000
Message-ID: <0384e41b-a995-d9aa-c077-b71917eca45c@microchip.com>
References: <20210501171352.512953-1-jic23@kernel.org>
 <20210501171352.512953-2-jic23@kernel.org>
In-Reply-To: <20210501171352.512953-2-jic23@kernel.org>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.121.125.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52a5b150-5798-47dc-4dde-08d9206af03d
x-ms-traffictypediagnostic: SJ0PR11MB4846:
x-microsoft-antispam-prvs: <SJ0PR11MB48466825143B1D9EE3F86975E8249@SJ0PR11MB4846.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gouKfvAyHH22aR6e1kGKPDDCBPzrqxfBlMfGjNCLqspWEFjKCwVRlisAR8ej64xOsyGM8ISCkPP0+7CVCTh+lA6oTVr3/RzO2vbLymLaGTwIFIa6Utyj/NYgFQ8rtMS6TiacJbwiRsNIY8TYFFZYFQOlxkRzDgPe91fH479HfyOoE5Old5xR1EVFdPbc9xil8VzEgfrudbVmXNzpOrD6tUMC1PWbZn5NHonOpl7vDffxgXG860Iyfu2IXo3jKDA+H2Fdvtp/4HgTm2pnYOZUY7WQprVc+9qACro/LDkgF1IpT5m7NHHmiobNxf8hF4aFmirSdXvAQGtzYwiIaeqDfRbA6Ie9IjF9iw36P++jmZmn7F8IivOrXaKS866IgQuFhciznPW1t+X1wePZKqxEe7hUYLkmq/2EWBXS0hgGOIIUgh+vR3syGZ30vk8TW1Y4cl4f89wulzkWUBzcTajjp/NIqhKFrWy2Z3AkSxYmz8poX9eO5PBm++FODBUYUlANV0+rlgvUsDyv5o5sMVYR0oeMajayur5KleSg0I/Rtk0mODB2s1C8Itx+MY7Bgfkx9G47FgLhZDonz22D/tsO2CzdB4tpDT3EiaKxLgskp8QhaN5yrzLO0lbKf3HzkM/nPZtrnohdnEb7gDYP3y1QBJkTklQqPYtrX4ovm03YIgKcQUk4RHUv6y3hDLaMG+yW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(396003)(346002)(31696002)(66946007)(76116006)(66476007)(91956017)(66556008)(64756008)(2906002)(53546011)(66446008)(186003)(83380400001)(6506007)(8936002)(31686004)(122000001)(4326008)(110136005)(478600001)(8676002)(6486002)(316002)(86362001)(38100700002)(71200400001)(5660300002)(26005)(6512007)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V0FVSTlhQnJ2ZkRjZmlLbjBwVExVM2JiQVYrRUVnU2tmQmh1RURtZENjaytF?=
 =?utf-8?B?OERZS3JwcnpYc28wVGtsOUx6dy92cFBWU1JSNWJrTERTaEZIcXdqVHdjekNt?=
 =?utf-8?B?YytPVEd2Z1NiVStRa244RWlKL1Z4OG1MRW5mWGRLcFVVTWJTdmkrMUxxN2Mv?=
 =?utf-8?B?VFpJWmFnS0pSY1ZaekZGejB1SnJaaVBTOGN2ZHp5SThuQmtLblZsZjZJM25l?=
 =?utf-8?B?VWJQWUZDM0N4d3p1ZmkwLzFpT0JZRGM2OHBQWThtb1NrU1NES3BLeUZTVXlp?=
 =?utf-8?B?NisxTlZZWkFiUWNyNzJxQ3NRS21qd3VjSVlraTJOcEkwN0Jod1BERzl0WlJW?=
 =?utf-8?B?TTdhemZ2TURUakNRb1owTTNkTFI3SnpBSGhpcXc2bzdXdzcxU1B3b1I5OVVF?=
 =?utf-8?B?Mzc0MklaczBUSVI1UjZpMWY1TzE4VWNoR2UvOUYxN3ZybG9SWko5VjAyRkJM?=
 =?utf-8?B?ZVd3Q0w4R0xCWlV5VzZHa1M4R1lQYktnbytDOFNDRzM4YktSRnFzWkNteGV0?=
 =?utf-8?B?MDBDNkxjZjNGcy9yNTRleWlCVnZYT0d2TVB3MGk3UTRyNFBpQTlLM0J1WE15?=
 =?utf-8?B?b25kM2dYMlRMazNtQ0FzK3dwcDFSMjNzWVB1NEFmT3NBVGltV09pbzNnbWpo?=
 =?utf-8?B?REpYQzBMdDZzdnV3Vi9Pd1lpRlpZUFMxd2FMUGE1b3NjS0NvNkNSajVYRGFF?=
 =?utf-8?B?Y2Q1cUVuZXJ2NXdoWmVVclg5ZnExL2FoazYxUzhod2pZMXVMcDJFZHFRV1VT?=
 =?utf-8?B?azRUM0Y1c1UyMWVJTTZ6bUxRODY3S1RQcjRoTGtIZFUySUlGbEVkUDRwalBk?=
 =?utf-8?B?dk5zK01MYlcwUVJ6dUcveW1jeC9yOUVhTU5sTkp3Vm9JeC91eXhKNE83UldG?=
 =?utf-8?B?a1pnLzlCSGdGZ1ZKRjN4OW1OT1lJelpSNllSUEFhYm9DREkxdlUvSHlqdzBu?=
 =?utf-8?B?RFowL3djOVAzVUkzRFpGZVplb2xXeUhKc2RnYVhhTWxtd2ttTmZIampISTdw?=
 =?utf-8?B?VHFvVThkTkFydmNOaWFHSXo5YTJ0Sm5wVVRadHpuTE5rQXJ2elNhZVNBTjdX?=
 =?utf-8?B?bmZmeHhkN2Rjb2FhcmhkVUliL2piMVE2SVg1SzJjVnA2QTA2QUFKVDNIeUsy?=
 =?utf-8?B?UWlXd3hzQ1BnY1N3Z2Z0L0RSVVhOYmNCRnE2eFI4aWtacXM3aGEwWjEyaU5s?=
 =?utf-8?B?ODFnYlM2RTZtUGhJeGVEY2NtdFVzT2h1bVhacGl3MHg2SitnaTZhdXErUS83?=
 =?utf-8?B?YUVZbUJEOE9IL25IZDNZM0ZHVjJMbHR1c2o1WnY0UGE2OW5HalU5NHE5UGdR?=
 =?utf-8?B?ejM1TjRzK05xTlVDWDd4aC91enBkYTVTRG9nemZGN3dTOWRoTTJpWXk1U2pm?=
 =?utf-8?B?WGhTQjZ3MmJESGszdDN2SVMyWlNFeUZmdmRvVGZaVzdjTk1Nd0N0NHg4bE15?=
 =?utf-8?B?enJ3a0FxSjViN2xFOFQ1ZUZmY0R1TVM5Y0lmM1dRYnRWbjN2L24wb1dxUTBr?=
 =?utf-8?B?WEpQSW53TUovMXBCZVBlaEVIUHoyZkh0dm5kbmdFOHlBQ0Y3V3FPSmJraU1N?=
 =?utf-8?B?ZkdmWnQvQmpVbm0wN0tYaG5GQUw5a09zZDlpTVYxTEZXNW9LV2p3c0RTdEh5?=
 =?utf-8?B?VnM2VVFEWVZ1ckIvSFNJbGE4STk0UnZEZ3gwcGh3WElnc2Z1QTdocGR0SzF2?=
 =?utf-8?B?dWNpZTdBaDJKMmFYVUR3d2ZkMDJoZkZtbHVMMnN0QWlVN2hDQ3VBNE56TTNN?=
 =?utf-8?Q?01ZRAl5ORtkJx4qqvo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <96DC99646F184C4D8EB7FF3382B18F66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a5b150-5798-47dc-4dde-08d9206af03d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 17:23:11.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYtgjH4RfRoti8fWmsPC1YVwf5f9u5MazH3Iksj0lu0Pnvfas5xSD9GtKLEPOeatfsB+E7GflO8x4uwUFFfuO/HqMGIBh6BknAWkHzQ2XZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gNS8xLzIxIDg6MTMgUE0sIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IEZyb206IEpvbmF0
aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gDQo+IFRvIG1ha2Ug
Y29kZSBtb3JlIHJlYWRhYmxlLCB1c2UgYSBzdHJ1Y3R1cmUgdG8gZXhwcmVzcyB0aGUgY2hhbm5l
bA0KPiBsYXlvdXQgYW5kIGVuc3VyZSB0aGUgdGltZXN0YW1wIGlzIDggYnl0ZSBhbGlnbmVkLg0K
PiANCj4gRm91bmQgZHVyaW5nIGFuIGF1ZGl0IG9mIGFsbCBjYWxscyBvZiB0aGlzIGZ1bmN0aW9u
Lg0KPiANCj4gRml4ZXM6IDVlMWExZGEwZjhjOSAoImlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRj
OiBhZGQgaHcgdHJpZ2dlciBhbmQgYnVmZmVyIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBK
b25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IENjOiBFdWdl
biBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgfCAzICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIGIvZHJpdmVycy9paW8vYWRjL2F0OTEtc2Ft
YTVkMl9hZGMuYw0KPiBpbmRleCBhNzgyNmYwOTdiOTUuLmQzNTZiNTE1ZGYwOSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPiArKysgYi9kcml2ZXJz
L2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+IEBAIC00MDMsNyArNDAzLDggQEAgc3RydWN0
IGF0OTFfYWRjX3N0YXRlIHsNCj4gICAgICAgICAgc3RydWN0IGF0OTFfYWRjX2RtYSAgICAgICAg
ICAgICBkbWFfc3Q7DQo+ICAgICAgICAgIHN0cnVjdCBhdDkxX2FkY190b3VjaCAgICAgICAgICAg
dG91Y2hfc3Q7DQo+ICAgICAgICAgIHN0cnVjdCBpaW9fZGV2ICAgICAgICAgICAgICAgICAgKmlu
ZGlvX2RldjsNCj4gLSAgICAgICB1MTYgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ1ZmZl
cltBVDkxX0JVRkZFUl9NQVhfSFdPUkRTXTsNCj4gKyAgICAgICAvKiBFbnN1cmUgbmF0dXJhbGx5
IGFsaWduZWQgdGltZXN0YW1wICovDQo+ICsgICAgICAgdTE2ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBidWZmZXJbQVQ5MV9CVUZGRVJfTUFYX0hXT1JEU10gX19hbGlnbmVkKDgpOw0KDQpI
ZWxsbyBKb25hdGhhbiwNCg0KSSBhbSBwcmVwYXJpbmcgdG8gY2hhbmdlIHRoaXMgYnVmZmVyIHRv
IGEgZHluYW1pY2FsbHkgYWxsb2NhdGVkIA0KYnVmZmVyLi4uIGJlY2F1c2Ugd2Ugd2FudCB0byBz
dXBwb3J0IHNldmVyYWwgdmVyc2lvbnMgb2YgdGhlIEFEQyB3aXRoIA0KdGhpcyBkcml2ZXIsIGhh
dmluZyBhbiBhcmJpdHJhcnkgbnVtYmVyIG9mIGNoYW5uZWxzLi4NCg0KWW91IHRoaW5rIGl0J3Mg
cG9zc2libGUgdG8gaGF2ZSB0aGlzIGFsaWdubWVudCB3aGVuIEkgbW92ZSB0byBhIA0KZGV2bV9r
emFsbG9jIGNhbGwgPw0KDQpUaGFua3MsDQpFdWdlbg0KDQo+ICAgICAgICAgIC8qDQo+ICAgICAg
ICAgICAqIGxvY2sgdG8gcHJldmVudCBjb25jdXJyZW50ICdzaW5nbGUgY29udmVyc2lvbicgcmVx
dWVzdHMgdGhyb3VnaA0KPiAgICAgICAgICAgKiBzeXNmcy4NCj4gLS0NCj4gMi4zMS4xDQo+IA0K
DQo=
