Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11775F88BF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 04:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJICA3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Oct 2022 22:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJICA2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2022 22:00:28 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863725E92
        for <linux-iio@vger.kernel.org>; Sat,  8 Oct 2022 19:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXChXI4cmbka3CZK0rLrAx0a9kxy3X51pnAChSROYQ5i0BInCosylkRmwnq63yDMPLwI62B1U3Whd6fEsvrJOrDZ/yT5Jh1OFs/Z0RCheZ5sdqCpFte7Qrta+rMs5Ou4AWjjmVpaZfkBqqVqZVr/9/Tfi9YdLG5MtCGHPUmWT53v/4WskP5nNVV1Gc1c4eN+CIXC8Wlh1u+5A/8PHnVIQvsWSoIwojaygrVd2W+vFgjlQ/5cNwdsW9DpidySC/TaC/ZPgGiR2UEbSUwNbw6VsNuTBWsa0AxxTJIgGldsiPlnyd1JblSLXcLXzfljCf4YKlyCPU+SgJWSRRue1Zikzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liZ31wP6QORVfa+SMvib1JOaxr9D767eAu5e5hCQV0Q=;
 b=ivY4H3+cMwgXvCIAnmyjDhAleTX66HUHNf0FEmC1oeBWStEdTyv49MFZC2LOCHqIHLcZmhLuV/52P3zne5VZOiIMH9niCB2/aGryet3vZPeAv87X0xutoftkxLAwOrRoqiMO0bU4NL6fa6zktKgBrr0rS7wah2zOeMfcK3Gsb8oYR5c9sau3Pc80hAVyMFJBzMI9FoWbIrefnCqDoGhrQfe1shxbg6APVn5nEtyOMjzfnyQkC3Hgivd6npPvWX47bG4A+MZR/nxo60EPbP3HbET/s2x87EgnH/RwJrk0kepRBvFabhZho6FSjHaAhzKHGqiWTLzjfrU7Oxu5IUBY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liZ31wP6QORVfa+SMvib1JOaxr9D767eAu5e5hCQV0Q=;
 b=MvmBHwAi8jcaHTOepcpe0GEWvqZJAVUkF8tC1JRcJMDyD36CXp1WmdQhseQfNNepTiDHI9phrodQ0csGji1N8Je/o/aNqUKZDZjMiNB1f8qNe90kfndDyCosvwlEdJM0VyicAuu2zVKkXr1arnKZGrq6yxKjQo4LSNFsPQMq2uI=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB8929.eurprd04.prod.outlook.com (2603:10a6:20b:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 02:00:23 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27%3]) with mapi id 15.20.5709.015; Sun, 9 Oct 2022
 02:00:23 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: RE: [PATCH v2 03/16] iio: adc: imx7d_adc: do not use internal iio_dev
 lock
Thread-Topic: [PATCH v2 03/16] iio: adc: imx7d_adc: do not use internal
 iio_dev lock
Thread-Index: AQHY1/gW7NTxo5eNQUeCUIIL3winEa4FVYXA
Date:   Sun, 9 Oct 2022 02:00:22 +0000
Message-ID: <DB7PR04MB4010D3A27C8C6FAF87187F4690219@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
 <20221004134909.1692021-4-nuno.sa@analog.com>
In-Reply-To: <20221004134909.1692021-4-nuno.sa@analog.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB8929:EE_
x-ms-office365-filtering-correlation-id: bbc63855-f3d7-461b-8aee-08daa99a06c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wD7RZMVlOuD2kQ3FxNS3SZZMl5GiJTO7EiqpYQjIkfyWZvgTCZHNV+qGY4mSxzXzDcHnzWieyC4RjMvAIUK4hc9Tn0d/Uwre4uOrpe94en1aYVoDWA8ZPh3Bo/8p92+XOTNWyvQ93KhBaaZlx97tKBfM5H5N+oHfao5GU3/Q1F8P9dMAQZ7jgQGB2Skf9TO7t70x7tGxsFUZbZgGyfp61lFRw0l6EbbV7R4YJqs1MWE/ly5/bD7kVFEXOySQqq3/zwwryNAP+iLnL4M3aHQRVFuQgBYYG8pVm/HxxyUsmsiLsA1aNbKCqGc3p+c6LI2g2fz2ua3xfcz5U9CuuI2Uv1MzE/vdGR3BBTVNVZX/Q2t68zQwuLbgkOaj/BDAfOwY7zScBY0MCFgSJBLBv1+J5g/gOlb0IV7oP4e26E9q5v13fjnHgyyyoZllLJDj0iRXVad9v2NnEkRxyUP6NjaqFuEw/3SKgWEreAwcvFD0sgAjoph+xmk1GBIvP7Wz8peOhWwLwBYK/ThYIxPubyvuMclhp4lf3p2HUArArlmi9JnkZuW2uhMzUriH4c5l+XD5vkV+Rh2GcAZC4SNp1T308ZfmdnQrqF7grk3UgAi5/1Hm0jhk6I7f/81rOA533P7dMLZIG1vcCGiM3hjRTGcAd3wa8b4mE7y2MhP4oxAxn+Xa1g9Y9dfClr6WvXACbBpkKvhNU0XTn4+m3hZtckymsMyedB0T8lqrm6pL2RDvTI1VBaeqr02SHWFdhExSHQxs/MXbnDypgqhOqE41U9Z6z3lVAYHxZE+DL3tdRsdkmdCNtl7pGaoswDZDhnQKRwwx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(66476007)(33656002)(38070700005)(38100700002)(122000001)(55016003)(86362001)(66556008)(8676002)(4326008)(64756008)(66446008)(76116006)(66946007)(71200400001)(316002)(110136005)(2906002)(54906003)(41300700001)(8936002)(7406005)(7416002)(52536014)(5660300002)(83380400001)(186003)(478600001)(9686003)(6506007)(7696005)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVA0MXVFVDNhQ2V2L0RaKzlvU1JmU0ZDOHkwRk9yMXhFUDZ3a3lSRXVDb0k2?=
 =?utf-8?B?a2dDYU0zOXAwdERabUdDUjkweHpTdGFGSmVnbVlPb0c4Ry9OdUJPaEMxdFVU?=
 =?utf-8?B?Sm9xcEI3a1JlMUthWlRiRzRVTDdSVEN6NzQ0TFRLQXBQQnhDQ21ONWJzZGRl?=
 =?utf-8?B?TjRuYUl5WTNSZVF1eGFlTDRsUXhCcUF5MDVzcnpJWG41ZWJwWjloRjFaRktG?=
 =?utf-8?B?cGxOZFoxWUM4Rmo2YmdpbU1DUy9sTmE4WnhxV0JWSXFkU1VLVU04VUdYY0Vx?=
 =?utf-8?B?T1RqNElYdlkyVnhHR1czOG5iRlp0VERlb01aU3k1YnRlNGFZdVE4MXR5cnRP?=
 =?utf-8?B?SGx4WEFPeXFVV0h0VmV4Z0NaUXhOQzlsZjY0ZFc2VFhIOHJ6MWRQQTkybXh4?=
 =?utf-8?B?dFB5Y2JqanUvalBmb3UvbDNYSEl1ejgyV2pPU0JEZ3dPeW1Ba05zRVB1VlJV?=
 =?utf-8?B?eDlRQmYvVjg4TTRCVkc2SzV3bndhR01USUp4YXk3RmVFbU1WbU42QUxHRVBr?=
 =?utf-8?B?b0dxNUdDMDVqZWdTYmQ3L1h0U3JJS0kxSVNtYnZabmdHZTVOV0hXT2pHQWo2?=
 =?utf-8?B?czRPcXlTeU04aFdPTFF0bFlzaVh4WktrK24vRHBva0puUXRTM0RzYnVuSlVF?=
 =?utf-8?B?S3lPamN6emVPa2pvOUEwY3FsYlVaUHVqRWtrNzYyVW16K24rb21XdHQ4YVYz?=
 =?utf-8?B?MFNDUlhVOUVJS3R5RzJ0bFExU1Z1ZkJDK3l3b0lReHIvOThvekgvNWZJWThm?=
 =?utf-8?B?eWZvVmFWeW90Z1VEeVl4cW5yUEdwSTd5OEpveEJIS0Y0WVhvVVQzMXhvZWhG?=
 =?utf-8?B?d2VUdDNNYVFrM3ZxMVZGQm1Pd2NMSzhPR3EvdVZ0MVdvNXg5TTR0Y3pFNklv?=
 =?utf-8?B?NVNVYldpbll3dGJyK0djKzN5SENpS2xTdm9WejVqS04rckxVQnBnTkZCK0U5?=
 =?utf-8?B?K29rc1AvV0svWVNyTXgrc3NzTDJxem1OMzZGQW9JMnVxaHpSWnNLK1E4dHB3?=
 =?utf-8?B?bDNGN0l5cnQwY21FeE5MRlJhMGdCVWpSMXNSL215dlkxeGJOVWhkVk1UaUNL?=
 =?utf-8?B?b3ZxUHpuT0dIVWdZaUFYVWpHeDVmMWFlWTh2Kzh2WjFkSldkMng4MHQ0THhU?=
 =?utf-8?B?cW1ERVZGaEMrNStNT1o3ei8yeVpyeTNBQkFwdGMwM2djWmJEVzUzNmplRFFW?=
 =?utf-8?B?c0dGOE9TcDBtMVRQZHNhVWJyOVl1eERkd1llZmN6VXBZR1FZUms0QVNra0Ja?=
 =?utf-8?B?bzR6N2hib1BXNDhzRW9zRHRVRzNPOFgrNWdRWC9oVk5nOS85cXIxNzV6VWpK?=
 =?utf-8?B?akFCM1F3REJ0UGg4NlRpczdBMzZ2NWtmRFFrN0pURllDUGFQNHNYREtSRjFt?=
 =?utf-8?B?a3dseHZCNVdxOUtNQXhHK1NuT0IvbGViTU1IY1EyYnRBRnZkSERiVHYwTURj?=
 =?utf-8?B?Y08yR1ZjUzJEM0lpZUhkNzZuTkU5L1psOTlneWpYMjVsc05wV2hncytrTDdU?=
 =?utf-8?B?TTEyd1puSnp4Zm1LL3cxUVpFT0NlaUc0UkRwU3lWbWR2WHE2VTdlY2F0UFZX?=
 =?utf-8?B?MW1DSDJFU0ZXREE3OFRTTzRJU1lJd3dSc1JJdHBUYjloSlBHRTJMSlNqK3h0?=
 =?utf-8?B?UHFob2xCNHNKYlhZTkJqWGFSMmMwUUlhSEw1OHlyenZvL1hCSzY2YjA2OG4r?=
 =?utf-8?B?eFdWOXA5Z1NuV3FmQXRWVVBZQXZ6NE5NRWtURnBnTDFHdHJCUTRHcnQrdFlU?=
 =?utf-8?B?ZFZhalFlSWJ2ZlkwcWtDR1ordS9LMG5yVmNQVkxLWG41NXY3eHFqMFpaTjVO?=
 =?utf-8?B?SXBxVGhWY3QzR1ZpMGpHakVaWmhydGRUcXRheDYxMTk3c3dBcUtNOUdzQ2Zs?=
 =?utf-8?B?UFZSVkRxa0t4dWdiOTdKY0M3b1d3b3ZObExORnB2M2dsR3VQYWRGaTREeWh6?=
 =?utf-8?B?SkdGY3VmNDJYR29zZjcwVjV2N2JRdlhpNjlkUmhjR1o0SHY1SzBITk9yaUpF?=
 =?utf-8?B?c0Qvc3lPY1JkUStkNTRoMUtWVkdyL1Y5d3RMVnhyVDMyZ0Z1MjhSQjJ3bXh3?=
 =?utf-8?B?VXhxYi95TVpIR3o4bVhBTzVhN05KSU82ZXFjdllyYXBPOEpCcEhqdWJGRzMw?=
 =?utf-8?Q?D6Uw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc63855-f3d7-461b-8aee-08daa99a06c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2022 02:00:22.9373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 504jSy5Mig5e/I5koByWaDP17wBOjK8Z4zE6kqxmKaRItcy9sSZMoPEROUBPqoGvWgzX3ZygRr9lnt6IIAtYPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOdW5vIFPDoSA8bnVuby5zYUBh
bmFsb2cuY29tPg0KPiBTZW50OiAyMDIy5bm0MTDmnIg05pelIDIxOjQ5DQo+IFRvOiBsaW51eC1h
bWxvZ2ljQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+Ow0KPiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
Q2M6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+OyBNYXJ0aW4gQmx1bWVuc3Rpbmds
DQo+IDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdvb2dsZW1haWwuY29tPjsgTmVpbCBBcm1zdHJvbmcN
Cj4gPG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsgTGFycy1QZXRlcg0KPiBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBKeW90aSBCaGF5
YW5hIDxqYmhheWFuYUBnb29nbGUuY29tPjsgSGFucyBkZQ0KPiBHb2VkZSA8aGRlZ29lZGVAcmVk
aGF0LmNvbT47IEFuZHJpeSBUcnlzaG5pdnNreXkNCj4gPGFuZHJpeS50cnlzaG5pdnNreXlAb3Bl
bnN5bmVyZ3kuY29tPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPGtlcm5lbEBwZW5ndXRy
b25peC5kZT47IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+OyBDaXhp
DQo+IEdlbmcgPGNpeGkuZ2VuZzFAdW5pc29jLmNvbT47IEJhb2xpbiBXYW5nDQo+IDxiYW9saW4u
d2FuZ0BsaW51eC5hbGliYWJhLmNvbT47IENpcHJpYW4gUmVndXMgPGNpcHJpYW4ucmVndXNAYW5h
bG9nLmNvbT47DQo+IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IE51bm8gU8Oh
IDxudW5vLnNhQGFuYWxvZy5jb20+Ow0KPiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU+OyBBbGV4YW5kcnUgQXJkZWxlYW4NCj4gPGFhcmRlbGVhbkBkZXZpcW9uLmNvbT47IEZs
b3JpYW4gQm9vciA8Zmxvcmlhbi5ib29yQGtlcm5lbGNvbmNlcHRzLmRlPjsNCj4gTWljaGFlbCBI
ZW5uZXJpY2ggPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBPcnNvbiBaaGFpDQo+IDxv
cnNvbnpoYWlAZ21haWwuY29tPjsgQ2hlbi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPjsgQ2h1bnlh
biBaaGFuZw0KPiA8emhhbmcubHlyYUBnbWFpbC5jb20+OyBWbGFkaW1pciBaYXBvbHNraXkgPHZ6
QG1sZWlhLmNvbT47IEFuZHkNCj4gU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNv
bT47IEplcm9tZSBCcnVuZXQNCj4gPGpicnVuZXRAYmF5bGlicmUuY29tPjsgQm91Z2ggQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPjsgS2V2aW4gSGlsbWFuDQo+IDxraGlsbWFuQGJheWxpYnJlLmNv
bT47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtQQVRD
SCB2MiAwMy8xNl0gaWlvOiBhZGM6IGlteDdkX2FkYzogZG8gbm90IHVzZSBpbnRlcm5hbCBpaW9f
ZGV2IGxvY2sNCj4gDQo+IFRoZSBpaW9fZGV2aWNlIGxvY2sgaXMgb25seSBtZWFudCBmb3IgaW50
ZXJuYWwgdXNlLiBIZW5jZSBkZWZpbmUgYSBkZXZpY2UgbG9jYWwNCj4gbG9jayB0byBwcm90ZWN0
IGFnYWluc3QgY29uY3VycmVudCBhY2Nlc3Nlcy4NCj4gDQo+IFdoaWxlIGF0IGl0LCBwcm9wZXJs
eSBpbmNsdWRlICJtdXRleC5oIiBmb3IgbXV0ZXggcmVsYXRlZCBBUElzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEhh
aWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCg0KVGhhbmtzIQ0KQmVzdCBSZWdhcmRzDQpI
YWlibyBDaGVuDQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2lteDdkX2FkYy5jIHwgMTQgKysr
KysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2lteDdkX2FkYy5jIGIv
ZHJpdmVycy9paW8vYWRjL2lteDdkX2FkYy5jIGluZGV4DQo+IDg2Y2FmZjFkMDA2Yi4uMjJkYTgx
YmFjOTdmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvaW14N2RfYWRjLmMNCj4gKysr
IGIvZHJpdmVycy9paW8vYWRjL2lteDdkX2FkYy5jDQo+IEBAIC0xMyw2ICsxMyw3IEBADQo+ICAj
aW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRh
YmxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgv
bXV0ZXguaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4NCj4gDQo+IEBAIC0xMDgsNyArMTA5LDgg
QEAgc3RydWN0IGlteDdkX2FkYyB7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiAgCXZvaWQg
X19pb21lbSAqcmVnczsNCj4gIAlzdHJ1Y3QgY2xrICpjbGs7DQo+IC0NCj4gKwkvKiBsb2NrIHRv
IHByb3RlY3QgYWdhaW5zdCBtdWx0aXBsZSBhY2Nlc3MgdG8gdGhlIGRldmljZSAqLw0KPiArCXN0
cnVjdCBtdXRleCBsb2NrOw0KPiAgCXUzMiB2cmVmX3V2Ow0KPiAgCXUzMiB2YWx1ZTsNCj4gIAl1
MzIgY2hhbm5lbDsNCj4gQEAgLTI5Myw3ICsyOTUsNyBAQCBzdGF0aWMgaW50IGlteDdkX2FkY19y
ZWFkX3JhdyhzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiANCj4gIAlzd2l0Y2ggKG1h
c2spIHsNCj4gIAljYXNlIElJT19DSEFOX0lORk9fUkFXOg0KPiAtCQltdXRleF9sb2NrKCZpbmRp
b19kZXYtPm1sb2NrKTsNCj4gKwkJbXV0ZXhfbG9jaygmaW5mby0+bG9jayk7DQo+ICAJCXJlaW5p
dF9jb21wbGV0aW9uKCZpbmZvLT5jb21wbGV0aW9uKTsNCj4gDQo+ICAJCWNoYW5uZWwgPSBjaGFu
LT5jaGFubmVsICYgMHgwMzsNCj4gQEAgLTMwMywxNiArMzA1LDE2IEBAIHN0YXRpYyBpbnQgaW14
N2RfYWRjX3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2DQo+ICppbmRpb19kZXYsDQo+ICAJCXJldCA9
IHdhaXRfZm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJsZV90aW1lb3V0DQo+ICAJCQkJKCZpbmZv
LT5jb21wbGV0aW9uLCBJTVg3RF9BRENfVElNRU9VVCk7DQo+ICAJCWlmIChyZXQgPT0gMCkgew0K
PiAtCQkJbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gKwkJCW11dGV4X3VubG9j
aygmaW5mby0+bG9jayk7DQo+ICAJCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gIAkJfQ0KPiAgCQlp
ZiAocmV0IDwgMCkgew0KPiAtCQkJbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4g
KwkJCW11dGV4X3VubG9jaygmaW5mby0+bG9jayk7DQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAgCQl9
DQo+IA0KPiAgCQkqdmFsID0gaW5mby0+dmFsdWU7DQo+IC0JCW11dGV4X3VubG9jaygmaW5kaW9f
ZGV2LT5tbG9jayk7DQo+ICsJCW11dGV4X3VubG9jaygmaW5mby0+bG9jayk7DQo+ICAJCXJldHVy
biBJSU9fVkFMX0lOVDsNCj4gDQo+ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX1NDQUxFOg0KPiBAQCAt
NTMxLDYgKzUzMyw4IEBAIHN0YXRpYyBpbnQgaW14N2RfYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+
ICsJbXV0ZXhfaW5pdCgmaW5mby0+bG9jayk7DQo+ICsNCj4gIAlyZXQgPSBkZXZtX2lpb19kZXZp
Y2VfcmVnaXN0ZXIoZGV2LCBpbmRpb19kZXYpOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2X2Vy
cigmcGRldi0+ZGV2LCAiQ291bGRuJ3QgcmVnaXN0ZXIgdGhlIGRldmljZS5cbiIpOw0KPiAtLQ0K
PiAyLjM3LjMNCg0K
