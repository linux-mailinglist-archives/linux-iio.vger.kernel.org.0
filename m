Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB96B5275F8
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 08:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiEOGFb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 02:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiEOGFa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 02:05:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E5ABE3C;
        Sat, 14 May 2022 23:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDcS8/tbNMFOTvkW9gS5kRnXKvoKK8aXRkssebGxkMdualnQ2X7xjhQC/zn5vKIC4g7zPcSIiWTR0+ZknaLHb4nxtHVyTwtiLPqlSDH+cGebFkjHFzUNrY5DEU0kK0nqgBRT2GCyYWscCfQVB/MToLyGRjNOnn3DUDKvz0W6g9LajFSm4qUnm6EU3KdX34oINpl+nEbJCWK6Jk8B8hP1J35yDgTyvuSwojiX2gsbkTuCv7IF+bFvbW9YERlqSHP126eLsJEo+ue3/FwZWc0cmbEU5nLxD9s770iHUOBuF+RAEx8B4u/bsEIsMy0dvRtzhnC4dz1eYBcnkGYhXMNyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdepiWB82f/kO5bctp5NbP1i8sk5MVm0BOnLO7Eldds=;
 b=mKwneDNf7THykzP/Iv1Q75J0Bfe95Jw+ccYkXv7Vj4tTEtx+5uWNw67OwlT7PWMXgwc2o/vLvrVNtJ3wWZQ6N553DyVWhDXmDW8xOq1jsFjP04Y/sZhmec6+tSfeDftlE8+xfNTPZlMf6+uwrTSQySEYnydyTpmS+rF3rGJAPg8amI/VnC57d6z15agYNbORmJPW+DM+DqaK74pCTBdJo9gunk2nu60zViwzxe2a1WoYzRME2rkcfb1Z1hLbSkybaMTfTuLL8QwYuxeVYvMK0LbMdLdqRsfMBYSzlFy3HgTnP0u8AvjQvv+WrMK5l4TCH8QY169nnx8sXy86NGdVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdepiWB82f/kO5bctp5NbP1i8sk5MVm0BOnLO7Eldds=;
 b=KujIJ+cVqcvfjPjtlqvTbimi2ctwXwH7WvHocrdglXmqlURVrCKwZ4QOOxLwWKT9AvFWN8PQiIDQEfI0d1UPAvy9p4JQ21neOeKwKHZm2poP9UCaBottWLTaX5+BKeR7LxV7Q/pG3gECQJ9XMyLSXqgCGZU25967fpeUP+kkhZs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10206.jpnprd01.prod.outlook.com (2603:1096:400:1d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Sun, 15 May
 2022 06:05:26 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 06:05:26 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Topic: [PATCH v4 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Index: AQHYZRBpx9oKEzU30UysykMb2VGYRK0e2jgAgACe0XA=
Date:   Sun, 15 May 2022 06:05:26 +0000
Message-ID: <OS0PR01MB5922FF48FA85415457E3378586CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220511082325.36185-1-biju.das.jz@bp.renesas.com>
 <20220511082325.36185-2-biju.das.jz@bp.renesas.com>
 <39a41150-6ac8-e158-f21d-15884b34a6e5@linaro.org>
In-Reply-To: <39a41150-6ac8-e158-f21d-15884b34a6e5@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ab3da55-1f59-470b-fc86-08da3638e814
x-ms-traffictypediagnostic: TY3PR01MB10206:EE_
x-microsoft-antispam-prvs: <TY3PR01MB102061215E2B5ABE0D47844C786CC9@TY3PR01MB10206.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0u/RVCHtgKASBOVyIZiytvMcu3Jx+GYo5QifsYBgy7NhHN9U1FJBd80sXY9eR9mNJ9eX1heIDNvop+J4jj2BfqiTC9ie/zHokNTyRYyje0Rg+UKxHZ3t9pt0RoJ0nB+HjmjK97UPfz1Pi2h8YkrmsD7gRUBxRyKiDslParnKMwm7AyYTUk2DvVPI/igy8LISTkuGn3tLLY6F35bHlaMsnK8f74WGM0wUCiod340rnnAZmcXjQbf7HUOXsOVTAzCFW27TIw7BMVLZe3jw2AIlcD547jBWHSbhUkN64IbmY+eSzZ6hTJcfZFZRkqQA7Po8wtzxPQIrb/6VJeG3CAW1R/XZ78rXSYo5DAUM+wyOoTj/3L4feGnCfeeY0c06kUoRXsroV+lxvMM8kXuwKJb/IKPJWfl8ukUSb0gDeil0V0nZp6NyIbL1/o1dARMxlmllWUDKp34UqQnj61mzSrM01Zq4I0/HbAS2oOW/+yTawbJwbo93j4k4lP4IfZQ8k5y0Y/m7KHGllt2YhZ1MGG4OyRFrZ5jBi/IwgERyGXzNRfEontnWOHs68QFnN+by4U8OKSmRDxZ1xhB7+DtXhcH2jvWhlyILmuLvvo1rlUcSQ3FV0Yru1MYsv5g2ncKNx9qJirsWWU4AUt6i4yPils758FINNA47Rr79gAqWaAZ1GwiQJlcSFHP9mBR+ERl1ocstRmths/z2ljfKLA6X1BcfUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(54906003)(26005)(66946007)(38070700005)(55016003)(9686003)(122000001)(107886003)(86362001)(38100700002)(316002)(6506007)(66476007)(4326008)(52536014)(8936002)(508600001)(66556008)(186003)(71200400001)(64756008)(53546011)(8676002)(2906002)(7696005)(5660300002)(83380400001)(66446008)(33656002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0dOWlgwVUM2RGFyOW8rYkZoVEhybWhjOFBaZkNEcmxlSU1RU3M3R3J3TWNS?=
 =?utf-8?B?cXVURDFleDI3RlJlU2VXV0pxTkVyUVhWUHdpcTVtemlZSzZadmNzK3RQcmJT?=
 =?utf-8?B?aWVUbDlscW5Sc0dsVTJPUVVTeXZiRE9TUVNZeU1mWXBNcXo1eUgwWVhVd1lX?=
 =?utf-8?B?TURSM01YZmJFSDdqOERFeUszb2M0WGhrOXVWSW1tQ3E1eU5ob000amIvM1RN?=
 =?utf-8?B?c09CWHJpUmpKUXFqK0gvckU1QjVaRzJGTEY1cWZHYTlCOE16dE10UlA4SERr?=
 =?utf-8?B?VnZCTGQ5S2RDMWRNUWxFNnNkc3J3dGEyRUE5R3F0L2dGdC9EU0hkMVZ0SjZ6?=
 =?utf-8?B?MFpnYmswU1dOeXNSVUJRR2V5Q1d3ZXVFMXcyUUYyVUR2NURTUThOcW5PUXFI?=
 =?utf-8?B?aUd6TUFCZkprMTZUZ1dYYkRlOFBuSjBvSGZ0ZWN1QnB6ZXYxVHZJNWF1bzlm?=
 =?utf-8?B?c3B0THpnbk5MeTBoZjhzVEwrbmZ2Sm1hbm1ZZytkS1EwMDZFVk5qdFBnV2Y0?=
 =?utf-8?B?bWNTS0pHdXdBMWpVUDdCUmlNdndnQ0FyYjA5OFNMSHFyOU9yeEMwRTdaZlpt?=
 =?utf-8?B?R0p6ZThJRWE4SG9jT3d4Q3V4YjZEOXZaTExGc3VWNFBGdDEzN3BLRlpnZjQ3?=
 =?utf-8?B?S1FBK094ekVnZkVnSkVURGVvaWYvMXloTnhKMkdPSXdpUzhDTms3T0x3Ymhp?=
 =?utf-8?B?dzd1eElUUzAra2daNkNzS1pSNHowN3h3bzNYdzM4NGJoeWs0V09HeHdtUWNM?=
 =?utf-8?B?UXh5RFptZDlrSXY3WDNEb2I3TVovam1zYUN5Um1sdFRmRUdEQTNTNTNzMnpm?=
 =?utf-8?B?Nm5mRENYek5GVGMzMVRlWmVReHF0ZUtCdjVEeFBmNVFjNlpOWUtHU1k2SDUz?=
 =?utf-8?B?dW5tK2VrZVhkTkx0dit3dzZTRit0aFhqekFtWHpSd1QySnBialVNTG9nVTV5?=
 =?utf-8?B?eS9PeXFwSmVWWVR6MDNTUDE0c2I1aFNvZWVlSTRnMHZFQVkzOXRvVExLOW9B?=
 =?utf-8?B?ZWlidG1vaVZROUJUa2h1RVJJZGd6am9KK0thMHNwcW9hL2dQVVphWnJLNVFn?=
 =?utf-8?B?REMrWStFcWZQZTlFQmlRRWtzWW5kUTZrMEJPcDYwUXhZTGtJRjFXNmV3VWJo?=
 =?utf-8?B?Y2xUcWtPbm9LQU51UzlLM240Nlk4K01FeTYvUkhNR2JmRlNCVG5RRXZSb0hD?=
 =?utf-8?B?RndFTlpaNVdTM09YaFFiZ01LUGloNVR4YlNaUyt1NkNpMk9NL2NmZ2o1d09I?=
 =?utf-8?B?MmMwSXRwVGYyeU5DUkVmWHlieG5IK3ZMblpZNU5ORkNvRTdwbU1YbFR4TUhJ?=
 =?utf-8?B?UTYyT2lkQlBIcnBpNzB2b1RpRmRIdlZKeDYzM3pkL2R4S2FIRyswWTJ4azZ2?=
 =?utf-8?B?TzFsbnpFRXRsY0tyRTBNODE4YW8wRXFlazNUM0FYRUlGODZMUk4rQUVtbGt3?=
 =?utf-8?B?cUlJMXQ4S0x3R1dCSDBhRTJFUEpPenlKSHdpbGpNZGlsOE5tdVBlRDd1Sitt?=
 =?utf-8?B?Zi96dmN4d3RxQmxZaTR2OUphdkRoVmlzVk43cTF3aGVOYlFjaVFqOVBIYmJj?=
 =?utf-8?B?U2RvQlVWV2k4NmpBa0dTWWJQalk5aDAwZjRTQnpQSUFMSEFGdzJvcVB1K2ZN?=
 =?utf-8?B?RlZ3anJkdzgrS3ZXckx1Z3FKVGhSTkpRU0F6ZXJuQXdJS1k2SDVXN25YTDhN?=
 =?utf-8?B?dG9xMmJYMm52ZlhYY0RrQktNcTZPMEtOSytkWlBUQ1ZWSmxFeSs5OE94MTkx?=
 =?utf-8?B?Qjl0V2UxWFpneGNseklzL0F1a2EzR1VPY0F6STYzenAwQWhXZ1JLdFR3SzFi?=
 =?utf-8?B?Y25tUWVuN3UxUUFVYTFTaFVNUnZyY25YUFpRdzFPU0dZdjlKOGRWTmlzaUVM?=
 =?utf-8?B?RWcyT3hLNUUrTVgzSmtESS96S0pYRTdzWTZvbHlySnYvWFdKdzFYZ3kwVHVG?=
 =?utf-8?B?Sk95NXhkdDZ4MG14eHdCcU9JZnVCdFJCQ0Y0c1hYbldTODVUdzZ3K3IxTGhs?=
 =?utf-8?B?TTZpWG1QWWVMMjFKaG84M0oxRHdOZXpJVkd4cGJQaHFxa094dHkwcDlWNDNP?=
 =?utf-8?B?UkRyazVWa3QxTVpHaEFtcHJ6b0tja1duZHVERlluemhZLzBWMEsrZmRKdzlS?=
 =?utf-8?B?Tm52VmJUeXVQQmgwTTdUOTIxa0hFWTREUytncVNmUzNCeEdwcHFicWNndC80?=
 =?utf-8?B?VEpkb3JwcjRuVkRnb1dnZG1vTk1aMFZIQk1mc0ZZOWtjaVdDQ0VZVmFPL3RV?=
 =?utf-8?B?alFMM0hpUW10YStvQzh5N1ovalhHTGNjVld5blN0bUdjNC9rVXVXZ1VNVGRh?=
 =?utf-8?B?MzNHR0dEcEhoVkxNQVdmY0I4NDIyd1Z4YUpjU2V5L0ZkOEJCbEI3bEdHTEdW?=
 =?utf-8?Q?JeYkO0NbI7Wm1+GM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab3da55-1f59-470b-fc86-08da3638e814
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2022 06:05:26.5947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPo7q+leHfkD27gnLjzLlXdF8Vi4gcz0ocU6B6QTbVEHSszUgHEtjE95nz4ZSbNljxmFdFsFl9bUBLDDRqGyjuqca1tUFJZLIGDWfDy42cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10206
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzJdIGR0LWJpbmRpbmdzOiBpaW86IGFkYzogRG9jdW1l
bnQgUmVuZXNhcyBSWi9HMlVMDQo+IEFEQw0KPiANCj4gT24gMTEvMDUvMjAyMiAxMDoyMywgQmlq
dSBEYXMgd3JvdGU6DQo+ID4gRG9jdW1lbnQgUmVuZXNhcyBSWi9HMlVMIEFEQyBiaW5kaW5ncy4g
UlovRzJVTCBBREMgaXMgYWxtb3N0IGlkZW50aWNhbA0KPiA+IHRvIFJaL0cyTCwgYnV0IGl0IGhh
cyAyIGFuYWxvZyBpbnB1dCBjaGFubmVscyBjb21wYXJlZCB0byA4IGNoYW5uZWxzDQo+ID4gb24g
dGhlIFJaL0cyTC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiB2My0+djQ6DQo+ID4gICogUmVtb3ZlZCB1
bm5lY2Vzc2FyeSBTb0Mgc3BlY2lmaWMgcmVnIGRlc2NyaXB0aW9uIGFzIGl0IGlzDQo+ID4gICAg
ZXF1aXZhbGVudCB0byB0aGUgbG9naWMgdXNlZCBpbiByZWcuDQo+ID4gICogUmVtb3ZlZCBJdGVt
cyBmcm9tIHJlZy4NCj4gPiB2Mi0+djM6DQo+ID4gICogQWRkZWQgZ2VuZXJpYyBkZXNjcmlwdGlv
biBmb3IgcmVnLg0KPiA+ICAqIEltcHJvdmVkIHNjaGVtYSB2YWxpZGF0aW9uIGJ5IHJlc3RyaWN0
aW5nIGJvdGggY2hhbm5lbCBhbmQgcmVnIHRvIFswLQ0KPiAxXS4NCj4gPiB2MS0+djI6DQo+ID4g
ICogU3RhcnRlZCB1c2luZyBnZW5lcmljIGNvbXBhdGlibGUgZm9yIFJaL0cyVUwgYW5kIGFkZGVk
IFNvQyBzcGVjaWZpYw0KPiB2YWxpZGF0aW9uDQo+ID4gICAgZm9yIGNoYW5uZWxzLg0KPiA+IC0t
LQ0KPiA+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9yZW5lc2FzLHJ6ZzJsLWFkYy55YW1sICAgfCAz
MCArKysrKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvcmVuZXNhcyxyemcybC1hZGMueWFtbA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvcmVuZXNhcyxy
emcybC1hZGMueWFtbA0KPiA+IGluZGV4IGQ2NmMyNGNhZTFlMS4uYWU2MjI2YzEwNDRlIDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL3Jl
bmVzYXMscnpnMmwtYWRjLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaWlvL2FkYy9yZW5lc2FzLHJ6ZzJsLWFkYy55YW1sDQo+ID4gQEAgLTE5LDYgKzE5
LDcgQEAgcHJvcGVydGllczoNCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+ICAgICAgaXRlbXM6DQo+
ID4gICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgIC0gcmVuZXNhcyxyOWEwN2cwNDMtYWRj
ICAgIyBSWi9HMlVMDQo+ID4gICAgICAgICAgICAtIHJlbmVzYXMscjlhMDdnMDQ0LWFkYyAgICMg
UlovRzJMDQo+ID4gICAgICAgICAgICAtIHJlbmVzYXMscjlhMDdnMDU0LWFkYyAgICMgUlovVjJM
DQo+ID4gICAgICAgIC0gY29uc3Q6IHJlbmVzYXMscnpnMmwtYWRjDQo+ID4gQEAgLTc2LDE2ICs3
NywzNyBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiAgICAgIHByb3BlcnRpZXM6DQo+ID4gICAg
ICAgIHJlZzoNCj4gPiAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+IC0gICAgICAgICAgVGhl
IGNoYW5uZWwgbnVtYmVyLiBJdCBjYW4gaGF2ZSB1cCB0byA4IGNoYW5uZWxzIG51bWJlcmVkIGZy
b20NCj4gMCB0byA3Lg0KPiA+IC0gICAgICAgIGl0ZW1zOg0KPiA+IC0gICAgICAgICAgLSBtaW5p
bXVtOiAwDQo+ID4gLSAgICAgICAgICAgIG1heGltdW06IDcNCj4gPiArICAgICAgICAgIFRoZSBj
aGFubmVsIG51bWJlci4NCj4gPg0KPiA+ICAgICAgcmVxdWlyZWQ6DQo+ID4gICAgICAgIC0gcmVn
DQo+ID4NCj4gPiAgICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+DQo+ID4gK2Fs
bE9mOg0KPiA+ICsgIC0gaWY6DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAg
Y29tcGF0aWJsZToNCj4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgICAgICBj
b25zdDogcmVuZXNhcyxyOWEwN2cwNDMtYWRjDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICBw
YXR0ZXJuUHJvcGVydGllczoNCj4gPiArICAgICAgICAiXmNoYW5uZWxAWzItN10kIjogZmFsc2UN
Cj4gPiArICAgICAgICAiXmNoYW5uZWxAWzAtMV0kIjoNCj4gPiArICAgICAgICAgIHR5cGU6IG9i
amVjdA0KPiANCj4gVGhlIGFjdHVhbCB0eXBlIHdhcyBkZWZpbmVkIGVhcmxpZXIgLSBpbiB5b3Vy
IGZpcnN0ICJwYXR0ZXJuUHJvcGVydGllcyINCj4gLSBzbyB0aGlzICJ0eXBlOm9iamVjdCIgc2hv
dWxkIG5vdCBiZSBuZWVkZWQuDQoNCk9LLCBmaXhlZCB0aGlzIG9uZSBhbmQgYmVsb3cgb25lIGFu
ZCBwb3N0ZWQgdjUuDQoNClRoYW5rcyANCkJpanUNCg0KPiANCj4gPiArICAgICAgICAgIHByb3Bl
cnRpZXM6DQo+ID4gKyAgICAgICAgICAgIHJlZzoNCj4gPiArICAgICAgICAgICAgICBtaW5pbXVt
OiAwDQo+ID4gKyAgICAgICAgICAgICAgbWF4aW11bTogMQ0KPiA+ICsgICAgZWxzZToNCj4gPiAr
ICAgICAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgIl5jaGFubmVsQFswLTddJCI6
DQo+ID4gKyAgICAgICAgICB0eXBlOiBvYmplY3QNCj4gDQo+IERpdHRvLg0KPiANCj4gV2l0aCBi
b3RoIHJlbW92ZWQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQo=
