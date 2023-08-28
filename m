Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85DD78B295
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjH1OFY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 10:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjH1OFT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 10:05:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2092.outbound.protection.outlook.com [40.107.114.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E671D106;
        Mon, 28 Aug 2023 07:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL1qEBJD+RyeRyflciYGZ20k5E4rH6jHcS1joni2bGxDWWV7ajUhZ9qUp4+OaNz6PY8ZlHA4Ia6H88PXZCiUJPHDxZ19ZmYePUJOp6wMTUkW+X1WFtuzoh74r4jXOCygWO3Z7G3Pxylj2SKe/mamwH35WBt2qKRCr9GFn7MGPMOC9129D9qxDHC4H0V+xZ2I0YhGF2pv1f/FnOggcL42UmbS0aUrRPuqgw1znS1Ya4JMf6sg5kOQBuvDP4i6eLI6jU+TDPZVM0hW/Ac1+W367KoOkUM3uXnhpm9xlaVoD0IxZRJzWHdUFvB3VMFBJXbOzR27BDJs4e2GQrjQoY2I3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi766OIzXibcokcFKpknOKCVDgQgvPY695ICAkFzRJU=;
 b=ESN0zRY1fbUw/wGOh2V1U668W6lVe7B+SilSUdyrcvci9F6esxjKV0wnmnfp2UpGuOGgF6PTBXVJB6KGyRswRVCzgr8qI5OKR8ssMVAn1foboP0AW3CLhYMD2NQZZbTfClGmIKLjeWg8f73arkmGkNq02pMsYQ4GxyR3Hhp46lP0lrcnsRQhsamuSExrFv6b1/d2EeaNqSbunTkE7Iy0Y++SUshc2wrDjIM66XX6d1/zBwpDV2mTC6eWPPPtl3j+qRncoNLhcNGSvE2+UVOdnu0pP4M8iZbcpJlTshxbh3K+9ZNtZTSzQ7zHmDcjbmJ3nLg6gwjdmJUwWCxanqo6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi766OIzXibcokcFKpknOKCVDgQgvPY695ICAkFzRJU=;
 b=cRPJ9+fb9LPUQQQhqy7SbdZ/46EYJi1mWqGs3KEm79GyD5bjqt1/gRFiXUeIJLCDE8UNQavjjkZjRq2FIG9jeOhBB0IaFCVn5LsgWdi835l+fJmEcXWvJkNCztQEIr6eYgcjuiuJ4T9rWOTSWHLHuNAY6QYuhAywxRzRCyitf3k=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB11418.jpnprd01.prod.outlook.com (2603:1096:400:3b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:05:13 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 14:05:13 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: RE: [PATCH v2] iio: chemical: vz89x: Convert enum->pointer for data
 in the match tables
Thread-Topic: [PATCH v2] iio: chemical: vz89x: Convert enum->pointer for data
 in the match tables
Thread-Index: AQHZ0gbUmy/zC4DAjkC8+0qQGcYEt6//tC6AgAAASjCAABLagIAABasg
Date:   Mon, 28 Aug 2023 14:05:12 +0000
Message-ID: <OS0PR01MB592236BFA965886D6CBAED0D86E0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818190429.338065-1-biju.das.jz@bp.renesas.com>
 <20230828133525.5afaea4f@jic23-huawei>
 <OS0PR01MB59225F5472B4BE500429394C86E0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUEtjrEUCPk_G-kAyp8oEDu21oU+BwWVCZ8N4JJ6VTJUg@mail.gmail.com>
In-Reply-To: <CAMuHMdUEtjrEUCPk_G-kAyp8oEDu21oU+BwWVCZ8N4JJ6VTJUg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB11418:EE_
x-ms-office365-filtering-correlation-id: 2d3e585d-52a6-477b-6a2e-08dba7cfcc3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NM1D2fENLHqxFaNhLAzXEHMEN0YrnrtLPF6Mbw72g24/4KS4ygdyZxI2I7iY+Z6gTS3PLFbRt0XUndBKafGFEFXRzsr/PQvVogCdoJidxAf8RxZBfZxxUZp7M9ZwP2ir5pKFfoN4dUtZe+uNK/RI+Y3Rw7POybdggvGv+G5v/lOFwnJlFhCL9lVhQ3tk1XbY1WTbXH/FzY+G+dN5b9l5wl27JOYk24YpLrEuOqNk5c8vGvjiTiNu6xFegIqEALwCNZEwgBABOFL0uZqGbwUd6j7CwGUD0itGe5PxJNc5W+1tCNFiykoGBpDXhLJaORk99EEROzJC7V6a8FDOeC517zAedPikyI2D8nrpcSgfdGka5uBfTc/eBul5RhJ/glwecoeFWzruuc4sOJRWQOmPy5ma1smeU5yaDMGMiLj21FDCZzzLVlGZpi29oTZNqljylUEIVZJx2Re0QhPLk0pg9Og+ugsf06xpCTNck6OrBjLwqssvbjm8vabI/OIc+iHIjtEBFT0RUnEpLbnpvEWT65xGanqfu39urtdfsUTItU00ND/6DrKJ8/IUv2agh6B08A1TacRPKnyUXae1NbX9XaiC7y5O58LJC7SkECVl/6bLBjDMV5b9RYF4n6RM9MYG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(1800799009)(451199024)(186009)(5660300002)(8936002)(8676002)(4326008)(52536014)(316002)(26005)(66476007)(76116006)(66946007)(54906003)(41300700001)(66446008)(64756008)(66556008)(2906002)(6916009)(478600001)(71200400001)(7696005)(6506007)(53546011)(9686003)(55016003)(122000001)(38100700002)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVVKNUFXdWh0cGgyajVZMEJodkkwV0l1dE5wZ0twMlZ6blhNcTByakNUb3Jo?=
 =?utf-8?B?WERyeENiZk9PV3dXZnFVNVNEeE8xNGRZK0htWmM1RGV2TFdqUGZ2OU1kdVJm?=
 =?utf-8?B?QTd3djU0aFI0TTJ0Y3YzL3k5azJxb1ZYL1F2V095MnNHek1mNStQN2NobmxL?=
 =?utf-8?B?aVg1RFAwQXRmbVJlNUtjTlNCb0ZmSmxOUXZhT2VIakZlUEorV0NEakNIQUpy?=
 =?utf-8?B?dWcvRStWcGwvZi9RZWJvTjlWcElEd2xsWVF6TjR0ZWMycCt4SGlOSU9KbWoz?=
 =?utf-8?B?YkZpeFZQZ0h0WlVIV3Zidk40OGZSaDRVWXRTcUtxbGl3OU9vWUViWWpTOERP?=
 =?utf-8?B?WU5MaWlXaDdzWlpHZG9IcERuditFZWYxMGVZVkZJQ0J4K3F4QmhJRlBubVR3?=
 =?utf-8?B?Zi84c0ljYno0eGsyZEdHTE10clF6K1FmbC82OWgzRXBybVlIZFlDa29sWFh3?=
 =?utf-8?B?Uzh0ZUtYQ3h0RUJqYnBPUGxkWURkNXVZSEkzNWwxNjdHd2RuR1I1b0Zoay9q?=
 =?utf-8?B?bzR5OGF2N0dkSzc4bWdSK21pSFhRUFVoeHBNR3JqZXd3aVZrOS9DYjN5cEhK?=
 =?utf-8?B?K09Ea2xRd1ZScTkxMTJ0blN2SjRzR2tmMW1aMmJydE9lNjVNaWRUOXF5WGxJ?=
 =?utf-8?B?cjVTTXQrUmIrUzRCbVNXSUVEYmVvRkJYYVhBcEN5eHIzeTBWWE5GbnZaMzUz?=
 =?utf-8?B?R29mck1EU3FVYjJrcDFBcU84MU9RakFuWmJ1OERPcHhGYjNsblNXeVlKZVFu?=
 =?utf-8?B?TzVLTWhFTlllelZaZXBEeDV4Zkx2YmNFL0dkM240ekJFcDhJK3JmdUtoVzNJ?=
 =?utf-8?B?bE5nMmtDOE54QTJ6Rk1XN1FzQ3pucm9YUWpNZUNCUGQ0c2dZYmh0ZXp6Q2VC?=
 =?utf-8?B?dlkrdXNPNjhrRW9yai8xOGNlYi9UdGxyMStZVnpwZncwdTFNWi8vb2FHbjFp?=
 =?utf-8?B?MUhQQThnMGZRNmkzVFY4TVRENUdBMEdQSWxNTko4d0ZaZFZFeEFNblYzNjh4?=
 =?utf-8?B?b3dxNEJtaHc5N01zcVIycDBYY0pMSkkzbUlUNk9Jd3FLbVJCUUVEOXpKTEY3?=
 =?utf-8?B?SkVNaDJHNndsSGVWVEZiRzBweHFoZDFOTWIrWU9hZTU3UzdCVVlFSmt3RXNa?=
 =?utf-8?B?aWpBSVFxUDMyQXQrQXpoejlGaEN5Vkd2MEVzWjNkUXQvS1Zjb2R0SzVJa0xH?=
 =?utf-8?B?dlNLMXNwa1F3Sm1IV1pURnQ5WnIrSXJQT1hIeldKaFNLd2cvM0hCV1ZNY1p6?=
 =?utf-8?B?Y3JqRGpNdlJ4RHE0V3FPbzZXVWp4V0dLNCtobGhPK2lBSml4c1F1N1dDbzRK?=
 =?utf-8?B?N2pYaDlkby9yVVdOT2Y1M0xvQVVna2Z1aUEwaXRNWGMzSlF0eHd3L2J6bXBu?=
 =?utf-8?B?ZU1sNy9OcHA0MGNUdktsSWxZOGVuMmpUcWdvME96K2RlaStLelpwU3FZczdw?=
 =?utf-8?B?VHBheG1vNzVncFJKNE9xSzhaVXpmdGMwQVdqQ1Y5aXErL1lXYytGa0pJY1Ft?=
 =?utf-8?B?RXJwTllzVnJVYmNRMFJrK3UyVjhaeWxQQjcvRlUybjRiY3dsMzUvZTJRRE1I?=
 =?utf-8?B?OE1acndYZm5DQXIzcEFSczlnYWg2a3U1czd0MTlITE1pMlY3QisweTNPNTNQ?=
 =?utf-8?B?bTY4ajdrdGZDd1B1emQ1QXM0blVVS3krSkVkeTFaL0hpSHNsR0N3aG9pL3lr?=
 =?utf-8?B?MXJ1V3M3SUdWRXdYSEpienl4d3lKMnlSMXZtR2dva2NrbXdFVVdiZ2ZCUWlI?=
 =?utf-8?B?ZXZBYU1iQTFSUURhRGJQRTNnMFN0TzRPL3d3TVI2SUJYbS9xTWdZZFE2M3dM?=
 =?utf-8?B?MkhtQ3dqbHNmOVpKdjlZKzAwVFVNeFpyZ2tLMm5rL3hVcmV3MFdjdUlEcmxl?=
 =?utf-8?B?YS9aT2VQNnUrUXdTR1ZnR2IrcTBibktxNmFtVGpObWlmVVlaQjh2SS9id3dW?=
 =?utf-8?B?RzhHNnVzcDVOSVNEMXpKTjA4ZUVGcjQwZ0RGd3FhekdnQmplUUptK0RxMFps?=
 =?utf-8?B?NVh6Z2RreHJHRVduUEMzaWNJQWVINGwvZHJBTkxvNzY0L2xBaTVWTVlPdVJQ?=
 =?utf-8?B?S09EWm1wRSsrdVNKRGZrSGFycGpmYUhVRmNSOVpjd2lCRy9JQi9kUGFKYzNt?=
 =?utf-8?B?VXgwa3RNbndmUzN5K2ZWbHJFeVNteXVmdWtxSG5jNGJORUpsQTZFT2dwUTUy?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3e585d-52a6-477b-6a2e-08dba7cfcc3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 14:05:12.9491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilOVAd5B0kMudxWfiHv4QlTATG6BSn/iN1lGSAeynhKu6g/Oezl0Xxiz3yIi9nmz2aCeNiXsHr5PmcS8CYnwnlexr+lOb2DVViRu9m41xhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11418
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGlpbzog
Y2hlbWljYWw6IHZ6ODl4OiBDb252ZXJ0IGVudW0tPnBvaW50ZXIgZm9yDQo+IGRhdGEgaW4gdGhl
IG1hdGNoIHRhYmxlcw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIE1vbiwgQXVnIDI4LCAyMDIz
IGF0IDI6NDPigK9QTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdy
b3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gaWlvOiBjaGVtaWNhbDogdno4OXg6
IENvbnZlcnQgZW51bS0+cG9pbnRlcg0KPiA+ID4gZm9yIGRhdGEgaW4gdGhlIG1hdGNoIHRhYmxl
cw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgMTggQXVnIDIwMjMgMjA6MDQ6MjkgKzAxMDANCj4gPiA+
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+
ID4gPiBDb252ZXJ0IGVudW0tPnBvaW50ZXIgZm9yIGRhdGEgaW4gdGhlIG1hdGNoIHRhYmxlcywg
c28gdGhhdA0KPiA+ID4gPiBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoKSBjYW4gZG8gbWF0Y2ggYWdh
aW5zdCBPRi9BQ1BJL0kyQyB0YWJsZXMsDQo+ID4gPiA+IG9uY2UgaTJjIGJ1cyB0eXBlIG1hdGNo
IHN1cHBvcnQgYWRkZWQgdG8gaXQuDQo+ID4gPiA+DQo+ID4gPiA+IFJlcGxhY2UgZW51bS0+c3Ry
dWN0ICp2ejg5eF9jaGlwX2RhdGEgZm9yIGRhdGEgaW4gdGhlIG1hdGNoIHRhYmxlLg0KPiA+ID4g
PiBTaW1wbGlmeSB0aGUgcHJvYmUoKSBieSByZXBsYWNpbmcgZGV2aWNlX2dldF9tYXRjaF9kYXRh
KCkgYW5kIElEDQo+ID4gPiA+IGxvb2t1cCBmb3IgcmV0cmlldmluZyBkYXRhIGJ5IGkyY19nZXRf
bWF0Y2hfZGF0YSgpLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBBbmR5IFNo
ZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+DQo+ID4g
PiBCaWp1LA0KPiA+ID4NCj4gPiA+IE1ha2Ugc3VyZSB5b3UgY2MgdGhlIGRyaXZlciBhdXRob3Jz
IGV0Yy4NCj4gPg0KPiA+IE5vcm1hbGx5LCBJIHJhbiBhIHNjcmlwdCBhZ2FpbnN0IHRoZSBwYXRj
aCB0byBnZXQgZGV0YWlscyBhbmQNCj4gYWRkaXRpb25hbGx5IEkgYWRkIEdlZXJ0LCByZW5lc2Fz
LXNvYyAsIEFuZHkgaW4gQ2MgbGlzdC4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYSBu
ZWVkIHRvIGFkZCByZW5lc2FzLXNvYyAob3IgbWUsIEZXSVcgOy0pLCB1bmxlc3MNCj4gdGhlIHNw
ZWNpZmljIGRldmljZSBpcyB1c2VkIG9uIFJlbmVzYXMgcGxhdGZvcm1zLg0KDQpUaGFua3MgZm9y
IGxldHRpbmcgbWUga25vdy4gU29ycnkgZm9yIHRoZSBub2lzZS4NCg0KQ2hlZXJzLA0KQmlqdQ0K
