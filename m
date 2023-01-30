Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAA7680F35
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 14:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjA3Nml (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 08:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjA3Nmk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 08:42:40 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2121.outbound.protection.outlook.com [40.107.21.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E3F14489
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 05:42:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odMvFOSikG8ZVhOzMLockG5bOuXcTO5YJckrcLNW+IijPJRC/Q2p7OsH2sk+cG70oxKtcFFzrvJckgLcqoqXSSCVlfNiK6yhVr+xZidSikg82OL1DL313qXFJmL5w1IZeB+d/7/feNnB023NdWhzZsaeosTsI0dy4GlUVhLgRwSbyopVLkU4UcPEtMUHPaPZXaMgV4hbzcgBBD1PVVGD8HVkMPyo5N4VIKqyb7aFHYJzQCyzKjUwFfmZpZMR6kNp42RgcN8LZI6pMpiGeJnq3pGagLLLOZGJCudu2P70eKTrT9y4GMVa8XkNW14XghLxS7NhsCvhEX/Ely+0cjKLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZwbvXAVPoId7Cqk/9oCMZgG6eeoTmi/GCaeRtu3Ud8=;
 b=FO7+oWv1mAhp3Cl23SgsVYqCq2AWn4UF0lKZDKinhCsldZgQTneg1ICM32sYrRZkfrIMPT+f6J8UOY1c4PoBAlek86TDwRq3Awz2nihaORF7IL7O9TIMytuSTmIXTY3OPrK6RVPF5jaQ2tFXGlbgpXww2+2CX+FJOWe4l5vw95oLqItSdNWTtI5CMYxNYrMengU/iZqxH/3bYrxLfPav+GbupBqB3JjBHo6itQ8mX0todt+PsaRHgSxQqMUWkZwjo9+L32BzQ+sQJpBKiLzXxUSHo/eENQCQUbneP8whAXqikBDapPOathWpTm3vqgd4T7Mmi8wEPuVhEUhaI2GsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZwbvXAVPoId7Cqk/9oCMZgG6eeoTmi/GCaeRtu3Ud8=;
 b=HDdyiU5KY+Y9zD9Sf3R268CDww7reYcZF8ZIhaUJrcri1+2VvfbgeO162Q0BeEwb24nrNbu1WZ69plgOmZTIThhjZ3WYNxEgOKDrNl+zQJNhLvK8b+tBCcjITwE7QR0RXuD3f7gX3R3kD64TALCcI+KcT9I/VyYPvDf0UCJfjrU=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR2P281MB1589.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:88::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 13:42:29 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8%6]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:42:27 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: ROHM ALS, integration time
Thread-Topic: ROHM ALS, integration time
Thread-Index: AQHZNKMVIPWNlUK74ku14mYbRomWqa627POAgAALKIA=
Date:   Mon, 30 Jan 2023 13:42:27 +0000
Message-ID: <9b3dcc7a-a0f8-38ee-4381-d330004d436f@fi.rohmeurope.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
 <20230130130231.000013b6@Huawei.com>
In-Reply-To: <20230130130231.000013b6@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR2P281MB1589:EE_
x-ms-office365-filtering-correlation-id: b04ab923-fd29-48bb-73d6-08db02c7d3a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPIgeGRY4H5/HAcDMaesFjoLbPSHJJCMdFaykZGEEz5dDnVwAfvTVLirllx5kuPXcJDjgV9btlxwvLmsp5zlJ4MrwhH9CnUrGS8N/fQcr+mGPlDKyApBIrSCOFYbZdFaGaGIaEOeUHO4/FBMMujipx/4WFtpvwsFKOvirBwO3webMfa4eHu1ws+Mqyz5xrUwA31T+dztYi5R5FyRtuNnUI3UisqSFgTB42oSr3ay6NUgj9Y5zE+1KSEoteaBYuKKFAwicOrj4nGSyQcFy8HZzHmRJu4ZoIS6SY+H8f/7Sonn4HvpHfiz5QIYn622ZXc8CT7by6AbPcaSXIWebROl0WxZDizpP3EgIxHDaRJT8xoA6kkwc79pLDvlURtGJtfA+31t58AdMhPFKFknvx2imx6Ad+k06lZTEEW4YrXt5U/CO95cNK+e9cV489cO5PdqLDfYDD+BSkgpufR+tZ6ZIRwyJllUPHcBeZDPt0jsELnV0G/CXTX8BFe1O82gWz7kmrk2oQNcWYV1wdW3bp+G7/m/g5dmF2WpzRLFIi6PbU/on8vNC7yKXja57yx2vhLtcLQFet/oxpt65QHm9UYHrnTZmqKfrGzEtCbDeXe4hXa6E7XJYLUeqodgWbIKk2DEYK88A7pCK5RjjKjrl0XDo8LrvJj8xMyCdtqp/tNydPjf/W7gpCkAsOQzJJayn750neL18YktJ2WF10gaFaG4t2sZ2yhi3BWGsYVcC5Vwa41ALQx2a2493JK5G1NLAQKygc7UlRxP1Wh0e3NzopZ8Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(346002)(39840400004)(451199018)(83380400001)(38070700005)(2616005)(86362001)(31696002)(122000001)(38100700002)(2906002)(71200400001)(53546011)(6506007)(26005)(186003)(6512007)(478600001)(8676002)(66476007)(66446008)(64756008)(66556008)(66899018)(8936002)(4326008)(91956017)(41300700001)(31686004)(76116006)(66946007)(6486002)(54906003)(5660300002)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXprSmh6K1BPeDFId2FpNkl4SWVWaGoyeDNBUjQ2Wmk4cFhvaWwxNjRHSzd2?=
 =?utf-8?B?MGFzM05YT3dQMmdTMzhpNGZNZENnY1BZMHMycjQ1YlJieFFiMVdLQlRQOTRz?=
 =?utf-8?B?TlltUmZja3R1cm1CZ1pUOU9PM0RqVTFyZmJwcjBPMW9IYittaUIwcmcwRi9G?=
 =?utf-8?B?Yzk1TkI3SklKU3ErWGJxMDNlUUdHV3BSSGVRMm16TTZnUTdpSEc4dldQdEl1?=
 =?utf-8?B?ejY0QjR0QlRHTVVSUlhZenV0ZUFFRmVBbXhrMUYvaHczTGt0Y2JEaHdQMm1M?=
 =?utf-8?B?RUdEdE1ZUmVBNFhmSnRDYVZtUVNRNFlUektpN1QwSkt4UGU2S2U3anNVbVJK?=
 =?utf-8?B?OG1md1VRWXhIWXRiREk3cGZ2ZWdUajJzcTVvUWtkZFZucTVkeDgyWnVUZzRa?=
 =?utf-8?B?aHA5ZDNKVXBhM0pEVHVzS29PRmh6MExTM2pkYXVDWFpyaE5iUjFUakxIMmkr?=
 =?utf-8?B?aXFIaEdnV2F0cjZrSGdUbGNvSkY0bCsxUmw5Mi9KbzJVRHhkMVdXUXpKNzJy?=
 =?utf-8?B?dlFBYlVMKzNKb0JRWUR2UmhDVFJjdlQwY3NWamd0TTBEZG5MTThIdE1wQ3N5?=
 =?utf-8?B?VEg2bm9ucDhtVkNXd05idWk5eEV3aHAzcG1zR0U2NnlnVkhIZ3Uyd0ljOTY3?=
 =?utf-8?B?SlV6MUp2bmtwMW1tUml4NVRnUm9jY3N0cUttSlV5Mm9GZXc0TmJGOWxYeWdo?=
 =?utf-8?B?REl1TmlYK1A5dzA3bUhlYmI1RG5JRVQzSTY2WlRMdmVwOU9PS2dFNFQ1Qjdw?=
 =?utf-8?B?MXlrYlFOTE5IdjVJbjVIR2xZRzUxK2NRRlIxeEZHUEdyazdCMzRTaFBKQTg5?=
 =?utf-8?B?S05qaTdPeUJXbXJmYWhBNzQzc3JQSEV2U0lNdGZqNzZmUUwxUG9sRWtMWWFH?=
 =?utf-8?B?ek1HSGNqSytJNzlaNEU5V2p0NWlhT1hydW1jSFUvNjEwNE1QaW0xaEV6V2Zt?=
 =?utf-8?B?dWNycWFJNkNBRnFINmVwWmZ5YUpnbENJbmNYS1RpY0RZcUVjKzNzbXdtUFh6?=
 =?utf-8?B?T3l0UE5vaTZlVEoraHB1RGh5bUVWMkQrVVhmbU9QaGJoMVZLOExoanlBdEFO?=
 =?utf-8?B?N0F4NTA3REFwdUVQSHAzOWNhRmQyODFVZzJBeVJ3M2daZm12S2RMS1JVZGRk?=
 =?utf-8?B?WWk4b2psZXVHT2V4V29tVEFYUlMrMDVYRmszcDF5amg4R2ZIaGFMU0dkSVV5?=
 =?utf-8?B?RzZOTVJvUVMveVY0cU1WWWFZUFlnVG4zU1Ixc1dYTjFvZXlQWERIYnF1aVJD?=
 =?utf-8?B?c1Q1bDB0Vkt2Q3ZoSUNCeHlXRnZWdkc1M0V1aVpTcWJuVzNFSGFaSVU5VFgr?=
 =?utf-8?B?dENjMFJMa1pGdko3T2NyZUE4WlJJNGhNODZBZ1pRNHFUa0QrQlNJdXRJc0hJ?=
 =?utf-8?B?M0tEOXFZdGRXdndQRUJRWTFwV0x5ajc4b3FieGZYcEduUVBEQjM3QjNBamNW?=
 =?utf-8?B?NW81V0NPQzJnaklqekFnamNMU1NZenRiRUx4cHRudm80c0huMGxIZ3BkZmpJ?=
 =?utf-8?B?WmY5OFVHZjNsaDhxamVROW5yeDhFY003TXBZN1YvS0J3b2YyZ3VubU1JZFNS?=
 =?utf-8?B?bkZOanBoYWVDUXFKQXl6MnljaW1qSUhRbHpnWU9WQW1zV29YZ3NZcjB1N1RE?=
 =?utf-8?B?dnpoUVBVd0pjWi9IMGNuNWdPbnR1cTRPNEpoaDRPWUE4RlVyaVVQaXJkWi9y?=
 =?utf-8?B?bFAzblNuV2FLODZ5bUYxVWpVQVNKb2pnZmtPYmZCeldLYlFLcGF6Q1pjaWMv?=
 =?utf-8?B?VjJyNjFXLzVFMFh4WWJWM0sxTFkrUERzQnNSZ1g3c3ZLZndsMTl2NHYzOS9z?=
 =?utf-8?B?amxDaW4xa0g1UlR3enlNMDZCeWh3dExtYzdKaEdQTVRnaTJSZnJQVzV2VnNL?=
 =?utf-8?B?RXpiR1RMbm1uY1pxNHhZMTBFdldOOVNtS2p5S1hZQ0NuYmFKa0hoenpSbVFs?=
 =?utf-8?B?R3NKMkx6cXdUMjEvZE5FbHZ1QjRocFdQSHNZQmNNQ2hkK1BDN3ZGelVnTDhZ?=
 =?utf-8?B?R1Azd3dDY3dlQXZ4cGl0NlVNcFpqcHBub0RMbWVjOXdRV0lwdDh3L3NwSzVm?=
 =?utf-8?B?U1h5KzRtRWdVazZoTS94OGc1ekxNN3BEUzM4RW0xVWd6elNJTHFObXhCc29n?=
 =?utf-8?B?emJRZG9jb3l5ZW9mOWlHdytKaEdWQnpNb0szMU9HdEwzOEtITFp4NndyY3Rq?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F693756C3239347A0E45F99FFC7AAE5@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b04ab923-fd29-48bb-73d6-08db02c7d3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 13:42:27.4950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2cDD4fbvjdBO7o/bHGD3zDvGfEEB0A6/lpNOwu8CEUV4SFnPYsMTvuPVy2IhIRlz7LIkUxaR8OtSZmBqUu9u8uAkVFBIWNoGZ7677g6b2N1BM6RIa5RauR5iuFyMjed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1589
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMS8zMC8yMyAxNTowMiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gTW9uLCAzMCBK
YW4gMjAyMyAxNDowNDo1MyArMDIwMA0KPiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50
QGdtYWlsLmNvbT4gd3JvdGU6DQoNCkhpIEpvbmF0aGFuISBUaGFua3MgZm9yIGEgX3ZlcnkgZmFz
dF8gcmVzcG9uc2UhIEl0J3MgbmljZSAiY2hhdHRpbmciIA0Kd2l0aCB5b3UgYWdhaW4hDQoNCj4+
DQo+PiBJIGhvcGUgdGhpcyBpcyBhbGwgT2sgZnJvbSBpbnRlcmZhY2UgUE9WLg0KPiANCj4gVGhp
cyBtYXRjaGVzIHdoYXQgSSdkIGV4cGVjdCB0byBzZWUuDQoNCkdsYWQgdG8gaGVhciA6KQ0KDQo+
PiBOb3csIGZpbmFsbHksIG15IGRlYXIgcGVyc2lzdGVudCByZWFkZXJzIC0gdGhlIHF1ZXN0aW9u
Og0KPj4gQXMgbWVudGlvbmVkLCBzZW5zb3IgYWxsb3dzIHNldHRpbmcgdGhlIHNhbXBsaW5nIHRp
bWUuIEkgdGhvdWdodCBJJ2xsDQo+PiBtYXAgdGhpcyB0byB0aGUgSUlPX0NIQU5fSU5GT19JTlRf
VElNRS4gVGhpcyBjb25maWcgaXMgbm90IHBlci9jaGFubmVsDQo+PiBpbiB0aGUgaGFyZHdhcmUu
IEFnYWluLCBteSBsdXgtY29tcHV0aW5nIGFsZ29yaXRobSB0YWtlcyB0aGUgaW50ZWdyYXRpb24N
Cj4+IHRpbWUgaW50byBhY2NvdW50IC0gYW5kIGNoYW5naW5nIHRoZSB0aW1lIHNob3VsZCBub3Qg
YmUgcmVmbGVjdGVkIHRvIHRoZQ0KPj4gSUlPX0xJR0hUIGNoYW5uZWwgdmFsdWVzIChvdGhlciB0
aGFuIGFjY3VyYWN5KS4gSG93ZXZlciwgdGhlIHZhbHVlcw0KPj4gc3BpbGxlZCBmcm9tIHJhdyBJ
SU9fSU5URU5TSVRZIGNoYW5uZWxzIHdpbGwgY2hhbmdlIHdoZW4gaW50ZWdyYXRpb24NCj4+IHRp
bWUgaXMgY2hhbmdlZC4gU28sIHNob3VsZCBJIHVzZSB0aGUgaW5mb19tYXNrX3NoYXJlZF9ieV90
eXBlID0NCj4+IEJJVChJSU9fQ0hBTl9JTkZPX0lOVF9USU1FKSBmb3IgSUlPX0lOVEVOU0lUWSBj
aGFubmVscz8NCj4gDQo+IEFoLiBUaGlzIHByb2JsZW0uIFRoZSBtaXh0dXJlIG9mIHR3byB0aGlu
Z3MgdGhhdCBlZmZlY3RpdmVseSBtYXAgdG8gc2NhbGluZw0KPiBvZiByYXcgY2hhbm5lbHMuIEFz
IF9zY2FsZSBtdXN0IGJlIGFwcGxpZWQgYnkgdXNlcnNwYWNlIHRvIHRoZSBfcmF3IGNoYW5uZWwN
Cj4gdGhhdCBoYXMgdG8gcmVmbGVjdCBib3RoIHRoZSByZXN1bHQgb2YgaW50ZWdyYXRpb24gdGlt
ZSBhbmQgYSBmcm9udCBlbmQgYW1wbGlmaWVyDQoNCk91Y2guIEkga25vdyB0aGF0IHRoaXMgbWFr
ZXMgcGVyZmVjdGx5IHNlbnNlLiBJdCBpbmRlZWQgbWF5IG5vdCBiZSBjbGVhciANCmhvdyB0aGUg
aW50ZWdyYXRpb24gdGltZSBpbXBhY3RzIHRoZSBzY2FsZS4gVGh1cywgaXQgaXMgdmVyeSByZWFz
b25hYmxlIA0KdGhhdCB0aGUgZHJpdmVyIGNvZGUgc2hvdWxkIGtub3cgdGhpcyBhbmQgbm90IGxl
YXZlIHRoZSBidXJkZW4gdG8gdGhlIA0KYXBwbGljYXRpb25zIDovIE91Y2ggYmVjYXVzZSBub3cg
SSBuZWVkIHRvIHRyeSBpbnZlbnRpbmcgdGhpcyBsb2dpYyBpbiANCmRyaXZlciBteXNlbGYgOykN
Cg0KPiBhbmQgaXMgdGhlIGNvbnRyb2wgdHlwaWNhbCB1c2Vyc3BhY2UgZXhwZWN0cyB0byB1c2Ug
dG8gdmFyeSB0aGUgc2Vuc2l0aXZpdHkuDQoNClllcy4gTm93IHRoYXQgeW91IHdyb3RlIHRoaXMg
aXQgc2VlbXMgb2J2aW91cy4NCg0KPiBUaGF0IG1ha2VzIGl0IG1lc3N5IGJlY2F1c2UgaXQncyBu
b3QgYWx3YXlzIHRvdGFsbHkgb2J2aW91cyB3aGV0aGVyLCB3aGVuDQo+IHRyeWluZyB0byBpbmNy
ZWFzZSBzZW5zaXRpdml0eSwgaXQgaXMgYmV0dGVyIHRvIGluY3JlYXNlIHNhbXBsZSB0aW1lIG9y
IGdhaW4uDQo+IFVzdWFsbHkgeW91IGRvIHNhbXBsZSB0aW1lIGZpcnN0IGFzIHRoYXQgdGVuZHMg
dG8gcmVkdWNlIG5vaXNlIGFuZCBmb3IgbGlnaHQNCj4gc2Vuc29ycyB3ZSByYXJlbHkgbmVlZCBw
YXJ0aWN1bGFyIHF1aWNrIGFuc3dlcnMuDQo+IA0KPiBTbyBpbiB0aGUgaW50ZXJlc3RzIG9mIGtl
ZXBpbmcgdGhpbmdzIGVhc3kgdG8gdW5kZXJzdGFuZCBmb3IgdXNlcnNwYWNlIGNvZGUNCj4geW91
IHdvdWxkIG5lZWQgdG8gcHJvdmlkZSB3cml0ZWFibGUgX3NjYWxlIHRoYXQgdGhlbiBhdHRlbXB0
cyB0byBmaW5kIHRoZQ0KPiBiZXN0IGNvbWJpbmF0aW9uIG9mIGFtcGxpZmllciBnYWluIGFuZCBz
YW1wbGluZyB0aW1lLiAgIFlvdSBjYW4gYWxsb3cgcmVhZA0KPiBvbmx5IGFjY2VzcyB0byBhbGxv
dyBhIGN1cmlvdXMgdXNlciB0byBmaW5kIG91dCB3aGF0IHdhcyBjaG9zZW46DQo+IElOVF9USU1F
IGZvciB0aGUgaW50ZWdyYXRpb24gdGltZS4NCg0KUmlnaHQuIFRoaXMgc3RpbGwgbWFrZXMgc2Vu
c2UuDQoNCj4gTm90IHJlYWxseSBhIGdvb2Qgb3B0aW9uIGZvciB0aGUgYW1wbGlmaWVyIGdhaW4g
dGhvdWdoLiAgSSBkb24ndCBsaWtlIHVzaW5nDQo+IEhBUkRXQVJFX0dBSU4gZm9yIHRoaXMgdGhv
dWdoIG1heWJlIHdlIGNvdWxkIHN0cmV0Y2ggdGhlIEFCSSB0byBjb3ZlciB0aGlzDQo+IGFzIGxv
bmcgYXMgaXQgd2FzIHJlYWQgb25seS4NCg0KV2VsbCwgSSBkb24ndCAoeWV0KSBoYXZlIHRoZSBu
ZWVkIGZvciB0aGlzIGJ1dCBpdCBpcyBnb29kIHRvIGtlZXAgb24gDQptaW5kIDopIEl0IHNob3Vs
ZG4ndCBiZSBhIGJpZyB0aGluZyB0byBhZGQgcmVhZGluZyBvZiAoaGFyZHdhcmUpLWdhaW4uDQoN
Cj4+IFNvcnJ5IGZvciB0aGUgbG9uZyBwb3N0LiBJIGRvIGFwcHJlY2lhdGUgYWxsIGhlbHAvcG9p
bnRlcnMgb24gbXkgam91cm5leQ0KPj4gdG8gd3JpdGluZyBteSBmaXJzdCBsaWdodCBzZW5zb3Ig
ZHJpdmVycyA7KSBBbmQgeWVzLCBteSBwbGFuIGlzIHRvIHNlbmQNCj4+IG91dCB0aGUgcGF0Y2hl
cyAtIHdoZW4gSSBmaXJzdCBnZXQgdGhlIHNlbnNvciBoYXJkd2FyZSBhdCBteSBoYW5kcyA7KQ0K
PiBObyBwcm9ibGVtLiBMaWdodCBzZW5zb3JzIHRlbmQgdG8gY2F1c2UgdXMgbW9yZSBBQkkgaGVh
ZGFjaGVzIHRoYW4gYWxtb3N0DQo+IGFueXRoaW5nIGVsc2UNCg0KSG0uIFRoaXMgaXMgdGhlIHJl
YXNvbiB3aHkgSSB3YW50ZWQgdG8gYXNrIHRoaXMgcmlnaHQgYXdheS4gSSByZWFsaXplZCANCnRo
YXQgd2UgaGF2ZSBhIGtlcm5lbDwtPnVzZXIgQUJJIG9uY2UgdGhlIHN5c2ZzIHN0YXJ0cyBzcGls
bGluZyB0aGUgDQp2YWx1ZXMgZnJvbSB0aGUgZHJpdmVyLiBJdCB3b3VsZG4ndCBiZSBzdWNoIG11
Y2ggZnVuICdmaXhpbmcnIHRoaXMgbGF0ZXIgb24uDQoNCiAgKGRvbid0IGdldCBtZSBzdGFydGVk
IG9uIHRoZSBvbmVzIHVzZWQgZm9yIGJsb29kIG94eWdlbiBsZXZlbA0KPiBtZWFzdXJlbWVudCBp
biB3aGljaCBpdCdzIGEgbGlnaHQgc2Vuc29yIGFuZCBhIGNvbnRyb2xsYWJsZSBsaWdodCBzb3Vy
Y2UpLg0KDQpIbW0uLi4gSSB0aGluayBhIGNvbGxlYWd1ZSBvZiBtaW5lIGRpZCBhY3R1YWxseSBv
bmUgc3VjaCBkcml2ZXIgKEFGQUlSIGEgDQpCSDxhZGQgc29tZSBudW1iZXJzIGhlcmU+KSBub3Qg
c28gbWFueSB5ZWFycyBhZ28gOykgTm90IHN1cmUgaWYgaXQgd2VudCANCnVwc3RyZWFtIHRob3Vn
aC4NCg0KRm9yIGFuIG9jY2FzaW9uYWwgY29udHJpYnV0b3IgbGlrZSBtZSBpdCBjb3VsZCBiZSBo
ZWxwZnVsIGlmIHRoZSBkZWZpbmVzIA0KbGlrZSBJSU9fSU5URU5TSVRZLCBJSU9fTElHSFQgaGFk
IGRvY3VtZW50YXRpb24gaW4gaGVhZGVycyBleHBsYWluaW5nIA0KZm9yIGV4YW1wbGUgdGhlIHVu
aXRzLiBNYXliZSBhbHNvIHNvbWUgd29yZHMgYWJvdXQgdGhlIA0KSUlPX0NIQU5fSU5GT19JTlRf
VElNRSBhbmQgSUlPX0NIQU5fSU5GT19TQ0FMRSBhcyB3ZWxsIDspIEkgZ3Vlc3MgSSBjYW4gDQpj
b29rIHNvbWUgZG9jIC0gYnV0IG9ubHkgZm9yIGNvdXBsZSBvZiBkZWZpbmVzIHdoaWNoIEkgaGF2
ZSBkaXNjdXNzZWQgDQp3aXRoIHlvdSB0aGlzIGZhci4gRG8geW91IHRoaW5rIHN1Y2ggY29tbWVu
dCBkb2NzIHdvdWxkIGJlIHdlbGNvbWUgLSANCmV2ZW4gaWYgdGhleSBjb3ZlcmVkIG9ubHkgY291
cGxlIG9mIGRlZmluZXM/IE1heWJlIG90aGVycyB3b3VsZCBjb250aW51ZSANCmZyb20gdGhhdC4N
Cg0KWW91cnMsDQoJLS0gTWF0dGkNCg0KLS0gDQpNYXR0aSBWYWl0dGluZW4NCkxpbnV4IGtlcm5l
bCBkZXZlbG9wZXIgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KT3VsdSBGaW5sYW5kDQoNCn5+IFdo
ZW4gdGhpbmdzIGdvIHV0dGVybHkgd3JvbmcgdmltIHVzZXJzIGNhbiBhbHdheXMgdHlwZSA6aGVs
cCEgfn4NCg0K
