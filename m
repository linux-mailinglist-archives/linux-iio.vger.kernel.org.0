Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF797CF077
	for <lists+linux-iio@lfdr.de>; Thu, 19 Oct 2023 08:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjJSGxR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Oct 2023 02:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjJSGxQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Oct 2023 02:53:16 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2116.outbound.protection.outlook.com [40.107.114.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EF511B;
        Wed, 18 Oct 2023 23:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaeMnLPiZusjVlkmHEizKeJjSjYEl0RK+WA/YXte5KIpnyLWgCdAauM/zYS7iJXURdzz+O36oxam74ROrxMHUQj2z3fKcrIEp7B5+WFlXg4CeUfeGCBXy57kBOcJUxqwXL0QyWgPnXWnbt4Sy/FKpkev92XR9oxRjNjJLcBAALBRaMp173NyUYZUdcqaEtJyDZ0+gYgfNl2MeV8LgU6hG1JzWR56ostj1SbI03C7p/9Gt53R7RAT+S89EWL8otfSo273Na/xBv7sp+7hg2k6DDiGF7o/F8srH2gIDTAiu2Lm+ZVu5hii5lkKYrngPoRPjKEOT7E4g4iavZheIYyRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPqkPQalm63vzvXTuv18Mpt2FIlEYXGRgOgtCLBG/PU=;
 b=jUS40hFk8q2ht4HS5cZsI0VDXt+8IaokfkB8ayUso7hsyEYNFfADCWyti3jT6AImW7is3YsTgB6EGtFyceChIo0GrNawaaIawXqmc86Xgg0xoSvhdYMonJMEyUpxKPzuP0tcSc5fDpuROCeR3elUtrz62YcnYr6R2KpfFtsc8wCDQ8eGRjnwZ/h7paG0+FTxzDirp7d7YikER7yugEvmADolqWEUwa6mYcLdoPtEBahqkYaKsG3tBjdI42aRVXZMQRFoxyBDvWHfDw80591ZRKDqIjfyyHyylORwVtXF5WdTWHN4VYAAyFgooGkpmB8w5LNQMBpNdHCU2Mlex/OxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPqkPQalm63vzvXTuv18Mpt2FIlEYXGRgOgtCLBG/PU=;
 b=C0CfcjsfiBNwR1UQclUr8bZNxG2b0fWO4MXbf+szUqRBC9zAPSX76ig1kF6ObhAFono6bH0PuSqT6apDQcSER/etO5qL5YHAKlYIAvTM7hPllVFA03AZD5MoQdB8Za97YhGlicY0OCCW31rkguTWfm/o5zCHpckWbcDpL0XD0iM=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYAPR01MB5868.jpnprd01.prod.outlook.com
 (2603:1096:404:8052::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 06:53:06 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::c90e:cd43:c967:5218]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::c90e:cd43:c967:5218%5]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 06:53:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?utf-8?B?QW5kcsOpIEFwaXR6c2No?= <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Thread-Topic: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Thread-Index: AQHZ0al0blpUu/Wm+0SusYyQOb+0BLBO2cgAgAClowCAANSSgIAACZOAgACvvWA=
Date:   Thu, 19 Oct 2023 06:53:04 +0000
Message-ID: <TYCPR01MB11269EEF17ABCE541CC7B38CE86D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
         <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
         <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
         <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
         <20231018204533.39399b0b@jic23-huawei>
 <82b99e17f45b09623eeaed12e4fac12609c15426.camel@apitzsch.eu>
In-Reply-To: <82b99e17f45b09623eeaed12e4fac12609c15426.camel@apitzsch.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYAPR01MB5868:EE_
x-ms-office365-filtering-correlation-id: 7e47f994-0c83-4ae0-c470-08dbd0700b5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X7Xwt5P5SAhJdZyK3VK1izrs7FocjGX4jFtB5u68oPQkuMNhAMa9IpCCJp/yEntO5wlV/8ALVqIp+rg4vXsOw9bmJhhBhp1LiO5c+AGl6yXDh7gYHhb8qJtqqc2jaPIUTsU6VdYZWzsUZE5Jh0QfC5o1AUDRMGcyyqKiLDfBmyqYGacvD+pKXPLBtWzk3y+MPEcs27jSQkQJX27Pa4xHvVw0fJANQNJNBqWBRXBjqtmqVyGFmmNhiE2J6nAmxtKFfohTlPOj3yehkjJmBVMHgpwoHGAEBCF8gu3mM+uyiT0iF04O7BcXS9xxTLC0z8ce+ncYj63n/9nmEkSlVvwSFQkulbuYDCckkER0eC+28yLncBAa21T6GNwcG92VjeQ8ncjQgKxOmWqsphqyUwpbMCI6P4cLm0yci8AJfbpPK6Q4D6VpvhmUxIWu+r7GUkjRhiWMSwE2zSQHyjowTXO1KEpD7GgnRx5+0N6S9K0gDB7dhFfN8rtTuSrozCNWIoTcMlPg/GXu0uMRIWXX2/5+xvITFAFQ/cQxRfmMSFCbRm1af51jNITOKOSIg5lnLw7gpp4Pi6LVZOPTawwkUoixw1IBoiose05VJOiBVkeDBw7HKibJH088EEqZ7huyfJPr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(38100700002)(55016003)(83380400001)(66476007)(66946007)(5660300002)(41300700001)(54906003)(76116006)(8676002)(4326008)(64756008)(52536014)(2906002)(66556008)(8936002)(66446008)(86362001)(110136005)(316002)(53546011)(7696005)(6506007)(478600001)(71200400001)(33656002)(122000001)(9686003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTk5ckdXSEpzaDNaTC83K3FObDNHOWpEN3Mzb0s5R3FmQWRFZzNLT0VMVEFN?=
 =?utf-8?B?c0I5ejRuNlJ2TTZlMDF6RzI5TkJMcCtnQ3QvaCtSS1U4ekFDNGJSRTRIT21m?=
 =?utf-8?B?RHY1Vy9QRkJrK01aLzdEUnpEUjBTbjhIZ1B1Mm5yU3dxWDFqdHJGWUtiUlZZ?=
 =?utf-8?B?VzJ3VkExYW9JVHMvWTNPQ084Z2RYQnlJWUprcTdnRTdEbWFFUE53ekRWd0FK?=
 =?utf-8?B?SGd3WlVZYkFlMWRkSlpuZncxSlBlZytxd2MxZmVmbVdDdHNud0c2aUZnQjYy?=
 =?utf-8?B?eE56eEpvczY0SFRNY09Nc2VjanBFNlN6ek14Sm10M2RDQUdEUGtJZkR5ZmZH?=
 =?utf-8?B?cGRUY0kweUF1VVdxTEN6bzBNTkpibWlGcUlSSzI4azQxdEhKVXpVZFNrcjRX?=
 =?utf-8?B?UVpqdXJiMUFkb1lYQ1hJYkkvcXllZkQycjVWV1k5WWZpdXlJUm9FRnZlcndV?=
 =?utf-8?B?dTFnbDFWN21BOGQwTjNPT0hNWG9yVGYraHhqZlFKeHg1WjJMbkZrbzZ5Vktr?=
 =?utf-8?B?aFF3bGFHM3V6alBiWUpRTU5pL1BJejRGM2wrVFdOd0FIa3lZRnFhZ3I5endX?=
 =?utf-8?B?TXpzcmg5eVhZU0FSYWxDTWp5YS9zbTQ5cEVOclFYc2g0aTczdTVxU05XcWxi?=
 =?utf-8?B?aEsrRjhzbTJVdzBhNGNvUFphWGdyWDRKdmplMXFvT2N0Q1F2dm1lUlhlSDkx?=
 =?utf-8?B?eHd3dVh4ZVVXbkJ3SloxYm92V09aZXlaUU94L3lHRDZpOWlLRmNnZHBjQmdY?=
 =?utf-8?B?by9oVFRsczhwQVpPMEIrczBhZXlJU2tJU3pGdTdwanZLR2tXczk1RldjY1pN?=
 =?utf-8?B?Z3V3bU56ZTZ0M2oyOFhMaW1lRVRibTBaQXhueVdGVU5sS2JjdG1pQmsvK0xI?=
 =?utf-8?B?Ym5DVktuVW9PZ3lTUDlDSGU3a1YvZjdRTVpVV2tCeGczYm12OFpxdlREcFQ4?=
 =?utf-8?B?SERReDBMMGJyUFduVjM4TnBKalQxQzl4dmhBRFRBTnBVZ0FtbFpQblRJbzht?=
 =?utf-8?B?NkVpNXF0a1pqbFh3aEphOE1RRGxGOFRlcW1MTzcxSHVUSzdhOGthNk9DOVBp?=
 =?utf-8?B?MVMybEkwQjM4cHlZQnNqK2pwNWp1OERKOTRxZkdxdWZnVEd6ODhhVGxUTkNW?=
 =?utf-8?B?QlljRE5yZVJwUlpFdHYxSU8vbXdGZUFnNnB6Z05ES3IxeHdOVXVXSVRHWG13?=
 =?utf-8?B?Yno4am5qSXFWKzNLUzRTTy9MU2Y3VER5ajRLaW1kS2Z1UUpCL01vTXRkSnRQ?=
 =?utf-8?B?bG1iQy9sQkFtRllGTS9RcHNCV3dzUUlLc2FPOThDRW5PT1VWaFdCZDFRMUNR?=
 =?utf-8?B?bno4NnpNWUIwN29NVWY0bmFJNzV2REJyYTdWOUVod0dyemdiamQ0dzJWTE55?=
 =?utf-8?B?YXhmZ0ZtVytybnoyUTFmcDd3RFdpM3FoOVBmMThzd092RGJhOGdLN2F3Wlpr?=
 =?utf-8?B?NUFiMjlGZGVNcWlGVWlnc0V3amtlSkVRbHUyZXU1OW1RSFVFbkdWOGtOZmhq?=
 =?utf-8?B?Q1h2ZGdEbjh2bzFTNnV3ODk3Yk5SV3lEZFA1ZTdiM2p6d29xbzM5d05leWls?=
 =?utf-8?B?ZHJPYmkvcTdRMUluc0ovWk9NcjJzV1RCL0xISGlZOUpYYkVxWHZqd3NvbkJE?=
 =?utf-8?B?ZlM4VDdoMlpERkVuL2pRMkdiVkZTRTZDSmZnNXVpNmJ5TVR4dkZSbTdXb0ZU?=
 =?utf-8?B?dHJLZ1hNcmVaa1hrdFg2VllrWlVYR1JPOU1pVC9LejEzL2Fpdm9KWjlRUUFV?=
 =?utf-8?B?UEhSeHRBa09qS3lRQ3BPVkdQWHJva0Z4ZzlNaUZKVW5QVmdiUmtrdGFNdldM?=
 =?utf-8?B?QmNGeTVTbXVYeUZyMWZwVm80dHF4QkZYTVRUcFh5Wlk5aDl3eEY3aEo3K3BJ?=
 =?utf-8?B?ZzNHNkZYOVlzMFdkYzdJcW5vZEdQYnlISVdvVER5WjlMbU1NSEQyWGJKWmJP?=
 =?utf-8?B?U0ZoMEMrb3NOV2RBTjBhMG50bjQybzJqTHpoNTVXdDg1TUFrOXRjc1RQb2JF?=
 =?utf-8?B?MDZ0bWZGRllxdFBscFFFSVZ3ZFRXTkFmK3o3Q0dlOHVFZzRQTmN1YkRNVmlL?=
 =?utf-8?B?YTVjTUloWmZLdm1nZXJhbC9ZUkNKRDJBdElHMzkrcDdxOXpncnRBaE9tRTFn?=
 =?utf-8?B?WW9Sa1VJa01iRzI5bXQ5Z3o2MHZ5QmZVZk01d00rcWxTK29rSXFidVZBeWZm?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e47f994-0c83-4ae0-c470-08dbd0700b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 06:53:04.8634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8S+jV2dYaz2+8q6TAfRezm+ZiaegL8g/zpT0iHg1tPpwA6pfZJQpuPqjwuWRZPYoIJCofzH9419FqGGvSZr4Nytdue6KICjJejVDE1K82Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5868
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5kcmUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzVdIGlpbzogbWFnbmV0b21l
dGVyOiBhazg5NzU6IENvbnZlcnQgZW51bS0NCj4gPnBvaW50ZXIgZm9yIGRhdGEgaW4gdGhlIG1h
dGNoIHRhYmxlcw0KPiANCj4gQW0gTWl0dHdvY2gsIGRlbSAxOC4xMC4yMDIzIHVtIDIwOjQ1ICsw
MTAwIHNjaHJpZWIgSm9uYXRoYW4gQ2FtZXJvbjoNCj4gPiBPbiBXZWQsIDE4IE9jdCAyMDIzIDA5
OjA0OjQ0ICswMjAwDQo+ID4gR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9y
Zz4gd3JvdGU6DQo+ID4NCj4gPiA+IEhpIEFuZHLDqSwNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIE9j
dCAxNywgMjAyMyBhdCAxMToxMuKAr1BNIEFuZHLDqSBBcGl0enNjaCA8Z2l0QGFwaXR6c2NoLmV1
Pg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IEFtIEZyZWl0YWcsIGRlbSAxOC4wOC4yMDIzIHVtIDA4
OjU1ICswMTAwIHNjaHJpZWIgQmlqdSBEYXM6DQo+ID4gPiA+ID4gQ29udmVydCBlbnVtLT5wb2lu
dGVyIGZvciBkYXRhIGluIHRoZSBtYXRjaCB0YWJsZXMgdG8gc2ltcGxpZnkNCj4gPiA+ID4gPiB0
aGUNCj4gPiA+ID4gPiBwcm9iZSgpDQo+ID4gPiA+ID4gYnkgcmVwbGFjaW5nIGRldmljZV9nZXRf
bWF0Y2hfZGF0YSgpIGFuZA0KPiA+ID4gPiA+IGkyY19jbGllbnRfZ2V0X2RldmljZV9pZCBieQ0K
PiA+ID4gPiA+IGkyY19nZXRfbWF0Y2hfZGF0YSgpIGFzIHdlIGhhdmUgc2ltaWxhciBJMkMsIEFD
UEkgYW5kIERUDQo+ID4gPiA+ID4gbWF0Y2hpbmcgdGFibGUuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+
ID4gPg0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9hazg5NzUuYw0K
PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9hazg5NzUuYw0KPiA+ID4g
PiA+IEBAIC04ODMsMTAgKzg4Myw3IEBAIHN0YXRpYyBpbnQgYWs4OTc1X3Byb2JlKHN0cnVjdCBp
MmNfY2xpZW50DQo+ID4gPiA+ID4gKmNsaWVudCkNCj4gPiA+ID4gPiDCoMKgwqDCoMKgIHN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXY7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoCBzdHJ1Y3QgZ3Bpb19k
ZXNjICplb2NfZ3Bpb2Q7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoCBzdHJ1Y3QgZ3Bpb19kZXNjICpy
ZXNldF9ncGlvZDsNCj4gPiA+ID4gPiAtwqDCoMKgwqAgY29uc3Qgdm9pZCAqbWF0Y2g7DQo+ID4g
PiA+ID4gLcKgwqDCoMKgIHVuc2lnbmVkIGludCBpOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqAgaW50
IGVycjsNCj4gPiA+ID4gPiAtwqDCoMKgwqAgZW51bSBhc2FoaV9jb21wYXNzX2NoaXBzZXQgY2hp
cHNldDsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKm5hbWUgPSBOVUxMOw0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gwqDCoMKgwqDCoCAvKg0KPiA+ID4gPiA+IEBAIC05MjgsMjcgKzky
NSwxNSBAQCBzdGF0aWMgaW50IGFrODk3NV9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudA0KPiA+ID4g
PiA+ICpjbGllbnQpDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IGVycjsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IMKgwqDCoMKgwqAgLyogaWQgd2lsbCBiZSBOVUxM
IHdoZW4gZW51bWVyYXRlZCB2aWEgQUNQSSAqLw0KPiA+ID4gPiA+IC3CoMKgwqDCoCBtYXRjaCA9
IGRldmljZV9nZXRfbWF0Y2hfZGF0YSgmY2xpZW50LT5kZXYpOw0KPiA+ID4gPiA+IC3CoMKgwqDC
oCBpZiAobWF0Y2gpIHsNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoaXBz
ZXQgPSAodWludHB0cl90KW1hdGNoOw0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbmFtZSA9IGRldl9uYW1lKCZjbGllbnQtPmRldik7DQo+ID4gPiA+ID4gLcKgwqDCoMKgIH0g
ZWxzZSBpZiAoaWQpIHsNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoaXBz
ZXQgPSAoZW51bSBhc2FoaV9jb21wYXNzX2NoaXBzZXQpKGlkLQ0KPiA+ID4gPiA+ID4gZHJpdmVy
X2RhdGEpOw0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmFtZSA9IGlkLT5u
YW1lOw0KPiA+ID4gPiA+IC3CoMKgwqDCoCB9IGVsc2UNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRU5PU1lTOw0KPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiAtwqDC
oMKgwqAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoYWtfZGVmX2FycmF5KTsgaSsrKQ0KPiA+
ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFrX2RlZl9hcnJheVtpXS50eXBl
ID09IGNoaXBzZXQpDQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7DQo+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+IC3CoMKgwqDCoCBpZiAoaSA9
PSBBUlJBWV9TSVpFKGFrX2RlZl9hcnJheSkpIHsNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRldl9lcnIoJmNsaWVudC0+ZGV2LCAiQUtNIGRldmljZSB0eXBlDQo+ID4gPiA+
ID4gdW5zdXBwb3J0ZWQ6DQo+ID4gPiA+ID4gJWRcbiIsDQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hpcHNldCk7DQo+ID4gPiA+ID4gK8KgwqDC
oMKgIGRhdGEtPmRlZiA9IGkyY19nZXRfbWF0Y2hfZGF0YShjbGllbnQpOw0KPiA+ID4gPiA+ICvC
oMKgwqDCoCBpZiAoIWRhdGEtPmRlZikNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVOT0RFVjsNCj4gPiA+ID4gPiAtwqDCoMKgwqAgfQ0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gLcKgwqDCoMKgIGRhdGEtPmRlZiA9ICZha19kZWZfYXJyYXlbaV07DQo+ID4gPiA+
ID4gK8KgwqDCoMKgIC8qIElmIGVudW1lcmF0ZWQgdmlhIGZpcm13YXJlIG5vZGUsIGZpeCB0aGUg
QUJJICovDQo+ID4gPiA+ID4gK8KgwqDCoMKgIGlmIChkZXZfZndub2RlKCZjbGllbnQtPmRldikp
DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuYW1lID0gZGV2X25hbWUoJmNs
aWVudC0+ZGV2KTsNCj4gPiA+ID4gPiArwqDCoMKgwqAgZWxzZQ0KPiA+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbmFtZSA9IGlkLT5uYW1lOw0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+IEkganVzdCBub3RpY2VkLCB0aGF0IHdpdGggdGhlIGFib3ZlIGNoYW5nZSAnMC0wMDBk
JyBpbnN0ZWFkIG9mIHRoZQ0KPiA+ID4gPiBwcmV2aW91cyBhbmQgZXhwZWN0ZWQgJ2FrMDk5MTEn
IGlzIHNob3duIG5vdyBhcyBuYW1lIGZvciB0aGUNCj4gPiA+ID4gbWFnbmV0b21ldGVyIGluIGxv
bmdjaGVlciBsOTEwMCBbMV0uDQo+ID4gPg0KPiA+ID4gV2hpbGUgdGhpcyBkb2Vzbid0IGhlbHAg
bXVjaCwgbm90ZSB0aGF0IHRoZSBvbGQgbmFtZSB3b3VsZCBicmVhayB0aGUNCj4gPiA+IGNhc2Ug
b2YgaGF2aW5nIHR3byBpbnN0YW5jZXMgb2YgdGhlIHNhbWUgZGV2aWNlLg0KPiA+DQo+ID4gV2h5
PyBJbiBJSU8gQUJJLCB0aGlzIGlzIHRoZSBwYXJ0IG51bWJlciAtIGl0J3MgYWJzb2x1dGVseSBm
aW5lIHRvDQo+ID4gaGF2ZSB0d28gZGV2aWNlIHdpdGggc2FtZSBuYW1lLiBUaGVyZSBhcmUgbG90
cyBvZiBvdGhlciB3YXlzIG9mDQo+ID4gZmlndXJpbmcgb3V0IHdoaWNoIGlzIHdoaWNoIChwYXJl
bnQgZGV2aWNlIGJlaW5nIHRoZSBlYXNpZXN0KS4NCj4gPg0KPiA+IFRoaXMgaXMgaW5kZWVkIGEg
YnVnIGJ1dCBpdCBpc24ndCBhIG5ldyBvbmUgYW5kIGl0J3MgYmVlbiB0aGVyZSBsb25nDQo+ID4g
ZW5vdWdoIHRoYXQgdGhlcmUgbWF5IGJlIHVzZXJzcGFjZSBjb2RlIHJlbHlpbmcgb24gaXQuLi4N
Cj4gPg0KPiBBdCBsZWFzdCBmb3IgdGhlIGxvbmdjaGVlciBsOTEwMCBpdCBpcyBhIG5ldyBidWcg
dGhhdCB3YXMgaW50cm9kdWNlZCBieQ0KPiB0aGlzIHBhdGNoLiBCdXQgYXMgbXkgb25seSB1c2Ug
Zm9yIHRoaXMgbmFtZSBpcyB2aWEgaHd0ZXN0WzFdLCB3aGljaCB1c2VzDQo+IHRoZSBuYW1lIGFz
ICJwcmV0dHkgbW9kZWwgbmFtZSIsIGl0J3MgZmluZSB3aXRoIG1lIGlmIGl0IGNhbm5vdCBiZSBm
aXhlZC4NCg0KQXMgbWVudGlvbmVkIGluIHRoZSBwYXRjaC4NCi8qIElmIGVudW1lcmF0ZWQgdmlh
IGZpcm13YXJlIG5vZGUsIGZpeCB0aGUgQUJJICovDQoNCkxvb2tzIGxpa2UgdGhpcyBpc3N1ZSBp
cyBub3QgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLg0KVGhlIHByZXZpb3VzIGNvZGUgdXNlcyBk
ZXZpY2VfZ2V0X21hdGNoX2RhdGEoKSB3aGljaCByZXR1cm5zDQphIG1hdGNoIGFzIGl0IHVzZXMg
RFQgbm9kZSBhbmQgaXQgdXNlcyBkZXZfbmFtZSgmY2xpZW50LT5kZXYpIGluc3RlYWQgb2YgaWQt
Pm5hbWU7DQoNCkFtIEkgbWlzc2luZyBhbnl0aGluZyBoZXJlPyBJZiBpdCBpcyBqdXN0IGEgdGVz
dCBwcm9ncmFtLCBjYW4gaXQgYmUgZml4ZWQ/Pw0KDQpQbGVhc2UgY29ycmVjdCBtZSBpZiBJIGFt
IHdyb25nLg0KDQpDaGVlcnMsDQpCaWp1DQoNCg==
