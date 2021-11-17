Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115F9455005
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 22:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbhKQWBc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 17:01:32 -0500
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:23521
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240952AbhKQWAt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 17:00:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZFqT7DVvT6piFFUNtBr1ifqjeZkkPuzXUG9PfJ7JZascDvVzL81gz3+gL/3y+mmERN3V0TIfJL8oqQ0JbbNWikdQXLUZ3uhdZTVymb4X6QlnrN5tQ4sEKgdPnEDtqLG3mqT0+KIzV055txc2IgwUnm9jlxge4wCBjjYmTjN4DQ44n+l8iCbUOP1AD8V7b5kNJONVH8hqa38WHLPbYH6D5Tijc7YnGmGL94/e/c6hfOiAgenmPNk839wgqrdZsVLY4ZamcyabPPWYlJEdGAFGW16drt3cwTMKzsXXEfxxyGjvY2crZcsF1Jq4a6LgtxNXvXfiY4czKhCuKP5YXTspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg0LOrLBvl1X2Sps7ypCfTQRc6XdgyUtQnPPxrVvH4Q=;
 b=ja/YH5UGvE0FUQ4XcF+ZmSD7TGTE9VTLzr3uAKFAwP1q/3Uoy0MxcMalpoLrt2/NkEyqbur4nV/H4EW8er8AlXeCd1FHR5Mnk8WhVZFNyy7ObU0Y5hTJuwa7bj4GzvjaM9rkVo8pA+ELamZXNcS6RvbM1j1F/A830DL0ytvvkL5kegxIevtwgD0t7s5DMowUjkNM4Qtv2i95Y57Kyg120Y4GD/wofY8gxQMc7pE54lmUZ/j76ABI44KpmsUJ4MtdkZISQNGmjWwBfar77Y+vwIsInFI/Zzcl3ty6Tj64cql2fAVK+aPEgPtSPEYBu/DqIGoRi8EWoHUTr8cw1Cs68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg0LOrLBvl1X2Sps7ypCfTQRc6XdgyUtQnPPxrVvH4Q=;
 b=djuls1aK6PUrpZofIYY4TuoWgs5DxeF3oSjeTd8eeV5MMvBSUbWWLT7BSr03ytcwG3pSFslL2o2cZkyX+Qw9Bc8FMK7GT2SuzCpQ1WAASvUF5z1fsCmAF/Hjjq6lS4mtCfIYc2fafoPCOlW3fNsW2qNXXBoo9sV7LpXaNeGnAXU=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BYAPR02MB4216.namprd02.prod.outlook.com (2603:10b6:a02:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 21:57:43 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%8]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 21:57:43 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Thread-Topic: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Thread-Index: AQHX2vvgYEKxlWeTO0uTBMdVPBYaeqwGbHyAgAFdvfCAAAxGAIAADWQAgAARr4CAAFBMkA==
Date:   Wed, 17 Nov 2021 21:57:43 +0000
Message-ID: <BY5PR02MB69169E3F24E8EBE3DD754AB1A99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com>
 <YZPtW5igA8RBYLWv@smile.fi.intel.com>
 <BY5PR02MB69168A6537474DF8948C3D0BA99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
 <CAHp75VdaO4+DxMn2eJx7t0_UFgrHGV2vgzXvRB=qwZi-ZpMaOA@mail.gmail.com>
 <cf7ad8715a02f3a0e4fe0cd8a270585dcf84bb3a.camel@perches.com>
 <CAHp75VfJBwCcFwbv6fgvwf=Q1UdFXwgNex-4GqKLcf=ZhuqGjw@mail.gmail.com>
In-Reply-To: <CAHp75VfJBwCcFwbv6fgvwf=Q1UdFXwgNex-4GqKLcf=ZhuqGjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28f0b967-35f9-434b-5717-08d9aa154871
x-ms-traffictypediagnostic: BYAPR02MB4216:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB4216CAFE462D60B7E3650827A99A9@BYAPR02MB4216.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HGrhnwXFxe/h/FbMF5kZX7j3KTSCl25Fmdcf8gmv604qQBNhwMGWU+YfKOARpXHH3QfHgxVmSwHSbC01pRmYG0V/Tbul/SbbdBPJL+Rw1i4UIbbGi9mBP3jVr63qhDJ4ME4AoKDzFo6PL23qASecl+41IGdZhHkpz4sfsjHNKgM8ELqFJ+DMrlTtF5F5B0x0oR1ScTLgvSa7NH0lWauErGmnl9CamDrfmlNM88CF8rSLWu7hqkANhtlevQPUiSzdoak1GefKCg+OcKcP7QT49f3s7oZZWJSaLA81ATEvgUVj9/taw/rUm9zxORRpvPH2EJ84efAwfy7mvhcPBzBc8gJIAvBCD9gCDza6law1+h87nWNU6EztvUpa5SdCqtnQf3sElY/Y1La3kx+Ox2uJG69LTMOasov5X3kCjIRol4iPOqB93aZeU9Hi6nVa3VziDghbR/j3BMALyvP6ZHtFeDGOLzAoDuVI+D1/THo8ZkiiD9yIrWwTMwpclE8Xcs7pJR9+YzQgOUlXXZ8Lx+0jEtfRLcLeqmh4XbVFtjFZHz/ARTJyY/eQwGxYhymrOjmcGw1QLELu/WotyhGnuyOV7p1+MFG7PUEVRjocNQ20b2jkfcTCfh6Qdk+ljCuAvBXoTey5nQf/MGqJbE6DRRPz23/5MJbVJSM78k0i23P8YKseUeLdnN/ed3IK2ycR+i8ZiLHk0yTdH6sLfQXKwB/nnzAwMVYEL2QiTRNNNIKMF8JF3WVSsFli/0zBL4ykNdnlTf+Q9UneSK8hE4XSMlEFt3j93COzdSqC6KGxxs8/QEs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(8676002)(71200400001)(5660300002)(52536014)(66476007)(55016002)(66556008)(86362001)(966005)(8936002)(508600001)(38100700002)(64756008)(66446008)(76116006)(122000001)(316002)(110136005)(186003)(4001150100001)(54906003)(33656002)(7416002)(38070700005)(4326008)(9686003)(2906002)(53546011)(7696005)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVhZWU5yQzhzdEhyZ3RiNnZTdFdnUWNaa3hoVTFaTk5iemtXL3ZVRlRXSnNo?=
 =?utf-8?B?Y0xFZmV5YnJ3QnY4cS8rVFM1YkZzMS9jQ0NrNGNXczg3bU1yUnRNV1luNk40?=
 =?utf-8?B?Sm9XY0lvNHBiQzY2RjB6Q3VRN0t1YVpDWlc5THJzaE8vK3p3cFdlLy81L0RP?=
 =?utf-8?B?SmhZTGRPMzdXSGxVOG5vMW1hTFlTOU9nQ0RMNmpKQ2VUQXZVZDlGUzBmcHEz?=
 =?utf-8?B?K2JnOU9McUxBSUllWHdCSUk1aFJJQUs1ZlJDRTh5dUtsa0JCK08wMzBEd0c4?=
 =?utf-8?B?T0NPZWpYRFJtUDZnbm5tZGhxZEtEZUM0bkQ2R3BjUkhFZ1VEVWlGTFlEblpj?=
 =?utf-8?B?eFVFOUQwWW5OeTZ2UENmWW9UVXVWWi91dkpvQkttSHJxRUV4enZYVmw5cW5N?=
 =?utf-8?B?SmlMazhZdnFsTy9WTVVPc2t1YU9HMmlyL3FCZU9qK3VQU3A3a3RDSENlZm9z?=
 =?utf-8?B?V2s1RzdYYjFaRFdlL3ZkWjVvU1hjVUN2cTNQckM5UlVHNzJnRTAwamlKUEF4?=
 =?utf-8?B?TExmN0NsbWZucG5YL3RtTlgraS9vQU90cjVmVzhnTkJrYllXaFYrUzVXSkZL?=
 =?utf-8?B?dU5Rc2I5ZjF0UFpsRHRibkFHRk1nZ21oMzd1L09EZ2NiRnlsL0VjUlJxMGR3?=
 =?utf-8?B?b2k2cWVQZWV1TzhHVXBkbDljWVZLTlNLUkxLTVRMeEM1ZlAzT2s0RS9STnor?=
 =?utf-8?B?VllCWDNHSWc1bVFPb3RNR3A1OGxBVDdUMEoydXpQbklmN25qUGVBS1NuU2RJ?=
 =?utf-8?B?OUVvQ0hTaDA3Tm4zZmFtMkdQRXNacjhTSWVPdGMySmR1S1BPd0NENTdDc1Ra?=
 =?utf-8?B?OUUzemRMUzVjTmtPMEpvVmp1V3V4VVoyMEMvUm1hNDhZdFlzSW9rNDZlWEVq?=
 =?utf-8?B?YWpoVkFRaFhhR1krTy8xT2U3Z2J3SWJLVFNzR21UL2FlSU5TcUJzNVdYQ3hx?=
 =?utf-8?B?ZTh4RlNUOFM3ajZmcVhnUENXMWNteElYVC9GTm9LMkdSUzBDdGdyempURHJu?=
 =?utf-8?B?SW80TEpMOXhsZWNBWWlCR3VuNUZXWDM0UitaT21sajdRRmJzZnhiMkFCME5n?=
 =?utf-8?B?aVJiU2NvRG1qTjUySmZDY0xYK2ZIL3gwMWxEaXBaaXhYVTdiNmVRM1pLOTRy?=
 =?utf-8?B?SVRHS1FWNWxNTWIrcGludDhiZjdqYmNSVnF5UDdnNm1rbHJUZ2JBR1c2UEZi?=
 =?utf-8?B?UDZoRGgvRFRBVEJ4TVBkMXRSa3g2eGtMeUFMdVRRcGF3ZklUdXdLSkpQOWJJ?=
 =?utf-8?B?SFNtdWxwV2xVL0xEVDN3SFF1MzJveUZTcTdXOGNvajhqL2VkUnlYUzcwNTRN?=
 =?utf-8?B?YmpybWJCNGg1VHRBdE9XZDlRVjQzczJ1KzJFMm1SMEpUR0xRZmpmb2daV2hk?=
 =?utf-8?B?bTVPQU5lelcrSkpTcVk3czFrZzFTS0hFV2IwQUVZSXlDVjJNSEdHQWt6WmNM?=
 =?utf-8?B?bVQvK1BWZm13NXBlZnJFRzhnWTJFc1VNZEtsZFpma0I4bmtvOUtmZTZyczRC?=
 =?utf-8?B?d0MzeWxGQmV1aFpVcFljZ0VQNHBPR0dqdERCdFBmeHVYdmpqOEZ5dmIwL3dq?=
 =?utf-8?B?em41Y3huejlQT0d6OUplZUF6RTNsT3VUeWNoR0NLWHRtZ2FqT2R1Y2lhTC8v?=
 =?utf-8?B?VWkyWWNyOUJGbjRiclUzMlg4d2RMSlU5TVArQ3p3M21NQ2dKSGV1ZFdHa1hi?=
 =?utf-8?B?U1VlYXVRS3NzUEg4bHpJeWVEN0x5ZlVkOFhsb1VsN01zNVd0bHIxZHJPQW1t?=
 =?utf-8?B?eTlvZ080bmpVdkJNVENkSU9HYXRwcU9LNnZGL1VCc0RiMllDOGZHSUplR2pU?=
 =?utf-8?B?ZTgxRk9yTFJQZElOSmhpR0hyVHREcmVrd0VjTFNSVWp3cTMrTXRwNU5DUmpL?=
 =?utf-8?B?NStGdjNZa3JCRTB2RlNBc0s3eW1aVUVXUUhuTEx2M241ZlArK3A4ZEFURXFE?=
 =?utf-8?B?ZzJHMHBkQnBMNWhQUEdMbGJiNkt6ci9zYzI4VVBjYmxVaTRTeU52dEo4dU1H?=
 =?utf-8?B?Z1htVHZ6aGtCSERwaVNWcTN2OFJKYTk2Y1FoQ1ZJZ0FubjZMYWVUL3YyTlVi?=
 =?utf-8?B?Q25pc1orbkZQaThLcWNzZnhTeHQ5N1BCRHVENCszTkxqemhIVUUrbkw0UTFX?=
 =?utf-8?B?TW9XekNzZ0pUbmRNaTRjd1huZWR4elcxS2RiTTV1WnRpR3dPVk0vc2pmYm1s?=
 =?utf-8?Q?WFObQYpjS5FN4n798m2nCWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f0b967-35f9-434b-5717-08d9aa154871
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 21:57:43.5082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hjfInz9ihbZ0GhsBg2/Ws/g7T7xXKllbUeBwc/jQuIN6QxfQg3IgYmwmiGSb7HzawD+H9XTeWPoirSNrAOmhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4216
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWls
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5IDE3IE5vdmVtYmVyIDIwMjEgNTowOSBQTQ0KPiBUbzog
Sm9lIFBlcmNoZXMgPGpvZUBwZXJjaGVzLmNvbT4NCj4gQ2M6IEFuYW5kIEFzaG9rIER1bWJyZSA8
QU5BTkRBU0hAeGlsaW54LmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gamlj
MjNAa2VybmVsLm9yZzsgbGFyc0BtZXRhZm9vLmRlOyBsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
OyBnaXQNCj4gPGdpdEB4aWxpbnguY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5j
b20+Ow0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7IGxp
bnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwu
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgNS81XSBNQUlOVEFJTkVSUzogQWRkIG1haW50
YWluZXIgZm9yIHhpbGlueC1hbXMNCj4gDQo+IE9uIFdlZCwgTm92IDE3LCAyMDIxIGF0IDY6MDUg
UE0gSm9lIFBlcmNoZXMgPGpvZUBwZXJjaGVzLmNvbT4gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIx
LTExLTE3IGF0IDE3OjE3ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiBPbiBX
ZWQsIE5vdiAxNywgMjAyMSBhdCA1OjAwIFBNIEFuYW5kIEFzaG9rIER1bWJyZQ0KPiA8QU5BTkRB
U0hAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxh
bmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gU2VudDogVHVlc2Rh
eSAxNiBOb3ZlbWJlciAyMDIxIDU6NDIgUE0gT24gVHVlLCBOb3YgMTYsIDIwMjEgYXQNCj4gPiA+
ID4gPiAwMzowODo0MlBNICswMDAwLCBBbmFuZCBBc2hvayBEdW1icmUgd3JvdGU6DQo+IA0KPiAu
Li4NCj4gDQo+ID4gPiA+ID4gSGF2ZSB5b3UgcnVuIGNoZWNrcGF0Y2g/DQo+ID4gPiA+DQo+ID4g
PiA+IFllcyBJIGRpZC4NCj4gPiA+ID4gSSBkb24ndCBzZWUgYW55IGVycm9yIG9uIHRoaXMuDQo+
ID4gPg0KPiA+ID4gSG1tLi4uIFBlcmhhcHMgaXQgbmVlZHMgYW4gdW5vYnZpb3VzIHBhcmFtZXRl
cj8NCj4gPiA+IEpvZSwgWCBpcyBkZWZpbml0ZWx5IGFmdGVyIE0sIGFueSBpZGVhIHdoeSBjaGVj
a3BhdGNoIGhhc24ndCBjYXVnaHQgdGhpcw0KPiB1cD8NCj4gPg0KPiA+IFRoaXMgaXMgdGhlIHN1
Z2dlc3RlZCBwYXRjaCBiZWxvdyByaWdodD8NCj4gDQo+IENvcnJlY3QuDQo+IA0KPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTExMTYxNTA4NDIuMTA1MS02LQ0KPiBhbmFuZC5h
c2hvay5kdW1icmVADQo+ID4geGlsaW54LmNvbS8NCj4gPg0KPiA+IEl0IGxvb2tzIE9LIHRvIG1l
Lg0KPiANCj4gSG93IGNvbWU/IFNlZSBiZWxvdy4NCj4gDQo+ID4gV2hhdCBkbyB5b3UgdGhpbmsg
Y2hlY2twYXRjaCBpcyBzdXBwb3NlZCB0byBmaW5kPw0KPiANCj4gWElMSU5YIEFYSSBFVEhFUk5F
VCBEUklWRVINCj4gTTogICAgICBSYWRoZXkgU2h5YW0gUGFuZGV5IDxyYWRoZXkuc2h5YW0ucGFu
ZGV5QHhpbGlueC5jb20+DQo+IFM6ICAgICAgTWFpbnRhaW5lZA0KPiBGOiAgICAgIGRyaXZlcnMv
bmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5ldCoNCj4gDQo+IC0tPiBwYXRjaCBhZGRz
IFhJTElOWCBBTVMgRFJJVkVSIGhlcmUgISEhDQo+IA0KPiBYSUxJTlggQ0FOIERSSVZFUg0KPiAN
Cj4gVG8gbWUgQU1TIHNob3VsZCBwcmVjZWRlIEFYSSBhbmQgbm90IHRoZSBvdGhlciB3YXkgYXJv
dW5kLiBBZ3JlZT8NCg0KR290IGl0ISBOZWVkcyB0byBiZSBhbHBoYWJldGljYWwuDQoNCj4gDQo+
ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC0yMDY0
MCw2ICsyMDY0MCwxMyBAQCBNOiAgICAgUmFkaGV5IFNoeWFtIFBhbmRleQ0KPiA8cmFkaGV5LnNo
eWFtLnBhbmRleUB4aWxpbnguY29tPg0KPiA+ICBTOiAgICAgTWFpbnRhaW5lZA0KPiA+ICBGOiAg
ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0Kg0KPiA+DQo+ID4g
K1hJTElOWCBBTVMgRFJJVkVSDQo+ID4gK006ICAgICBBbmFuZCBBc2hvayBEdW1icmUgPGFuYW5k
LmFzaG9rLmR1bWJyZUB4aWxpbnguY29tPg0KPiA+ICtMOiAgICAgbGludXgtaWlvQHZnZXIua2Vy
bmVsLm9yZw0KPiA+ICtTOiAgICAgTWFpbnRhaW5lZA0KPiA+ICtGOiAgICAgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMveGxueCx6eW5xbXAtYW1zLnlhbWwNCj4gPiAr
RjogICAgIGRyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMNCj4gPiArDQo+ID4gIFhJTElOWCBD
QU4gRFJJVkVSDQo+ID4gIE06ICAgICBBcHBhbmEgRHVyZ2EgS2VkYXJlc3dhcmEgcmFvIDxhcHBh
bmEuZHVyZ2EucmFvQHhpbGlueC5jb20+DQo+ID4gIFI6ICAgICBOYWdhIFN1cmVzaGt1bWFyIFJl
bGxpIDxuYWdhLnN1cmVzaGt1bWFyLnJlbGxpQHhpbGlueC5jb20+DQo+ID4gLS0NCj4gPiAyLjE3
LjENCj4gPg0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4g
QW5keSBTaGV2Y2hlbmtvDQoNClRoYW5rcywNCkFuYW5kDQo=
