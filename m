Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760D65F88CA
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 04:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJICKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Oct 2022 22:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJICKR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2022 22:10:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248BA2B19B
        for <linux-iio@vger.kernel.org>; Sat,  8 Oct 2022 19:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHYOXM5u72OAwYL1y54UH+FvWkahupC3Nh824pOyWoYM44372F4VTUskWt18L2tvbz5P0BL757keyMlRupY/vAzTA2EvCiT/4VI+rXFQw0WTAkyZZf7JhQWlea1g6+J9ka7PIMtiSu7YTGmyBuPYqRfBp+220fF/mVN7caEWDZn6DvxTddKh6D9SqNr6h57gZ7znNTLNxVOwBmh4TbnJgn1b7f4glLCnJTTgQEX9pjwG6GDlYGXbI+p1Hjjl4BEZXX/A8HrN0shCphSk/RAezf2Q1w2hvcPdyK+R/N+uWI3LEOM0upWHmzw4QWFtrYfJu8Wnfn1WMWpqMsWX/71W0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7rIsjUMpCUx1YFtCidImgSR9WcC6muXqBmq3FuVTq4=;
 b=X7P+IP1eRSxO3IrDDVlOMQw2HIlNkqdLKK3H/QJ+XK0jTvjeAxrcyqbrv73HxZQgpG/poObPqRktMD+8CRbrhycxykRsfNLePGwa59A5UPumgNqDBNp7kvlR6qK3MO8Jx4jTURBfKLmuV92/vnZZWO/5nBEIxNENmgJYoXQah7JKjojd9Vv8cGHdynTldnV7qRvgq1Bj+/En+N1uYTRP9lIEZQ5bl88zFlrwE9KS9TPXLNlrjo70ACevWqSRrq49Tks8t9pD0X1U6GM6ogkDuzQ52g09sJIVepTvVfX9tf505a3StEdlZ6P3KcT3eO6J/3TfVHFPQ6g2EXKbSqCdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7rIsjUMpCUx1YFtCidImgSR9WcC6muXqBmq3FuVTq4=;
 b=Pcc9OmMdtTkKgdMoNCb3RRPGmLQk6yQjCQYC4nw6LjY6UjWIj2G/RlnTvFVVJ40z20g1MqKxds9Ad10gDYJiN/Y7Y0vwuyFOOcpVJjkUYrOWXXjhO1Q21IckZvTtR33qaAKlv1aLzDCBAlnvEpjRS2d4ityZeaOP6X6kkPw+Wdw=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DBBPR04MB7705.eurprd04.prod.outlook.com (2603:10a6:10:209::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Sun, 9 Oct 2022 02:10:11 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27%3]) with mapi id 15.20.5709.015; Sun, 9 Oct 2022
 02:10:10 +0000
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
Subject: RE: [PATCH v2 09/16] iio: adc: vf610_adc: add helper function to read
 samples
Thread-Topic: [PATCH v2 09/16] iio: adc: vf610_adc: add helper function to
 read samples
Thread-Index: AQHY1/goYNHlg+/8fkq8Gq1yMIzB1q4FVz9Q
Date:   Sun, 9 Oct 2022 02:10:10 +0000
Message-ID: <DB7PR04MB4010695F5EB018F5FF95CB0290219@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
 <20221004134909.1692021-10-nuno.sa@analog.com>
In-Reply-To: <20221004134909.1692021-10-nuno.sa@analog.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DBBPR04MB7705:EE_
x-ms-office365-filtering-correlation-id: 407f7218-3f2a-41de-6930-08daa99b6527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H/jQYYHVkQ94MeKoXogIiNGxFEzUO1T11QH3eeG1/KvkHF7k5YTpLSFNXG9dtP9vHZjAYytw0mg/iGZz0VdYj/bZ9+ypTY8L/xxN0rA9PKHmYJ83S/IoU0q/o5ZdpPdxuiw9cwprvH8jkhU+I2PNb6gWhT4F+dwcpiOcW1tx7MJjJU69ffXR5ybkb3F9s90/YDSYQ/2YeRvSqi54DovrINPfCxKCy8k1045ocQSZzhR3kypOvl3qL1RaMXUWWpNkWlMJRZ9GT5C308FmfO0MzsX1OnB6ZrI9yomdk1F2r7WjwGTCe6Y+aWyLzPNsaBUwli8j/jxvnBtPn5IHQIWAHMQ3BFRiNpItizARVQ8XCcb7qhly0djki4ZJP6FjgE/xNtroSUMfikCvwlOYn4svFbZH8GPGIWvEMtOKAL05p3FPQMrKmy3tZRQ9lHQEH99PU7FLSMRrhdQAnZPqEFuVxUacWXque67+C41xO7Vq9dL2N7s69IT1+occNyu3IuFP+m89Okn59K7HTKN+Ofebjhf/qDwjs9ZHx+ev9hDrVTRCzBDgsDonSQBj8C8JrzTi25GjF1FbyY5/c8K4SGOsl+vswg1Wg3CQIKiSu6BjuFoWXgYADKhnUu27YKcR8XhR918puDrXkXnivzinLtEMySJAVxLuZtICt5vhkWyocJmxRiqrA1xCZkgE1PCiVBtTBf3pu5uVVEgu/whxEZ2EqZV6B/QUtY1Gkq59wUgR6LhJDorlt9jEiqUtkDfXFshrQ+oClBAVZle2XwIlLBdv6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(110136005)(8936002)(54906003)(52536014)(55016003)(83380400001)(186003)(86362001)(316002)(9686003)(71200400001)(26005)(2906002)(7406005)(5660300002)(7416002)(478600001)(6506007)(53546011)(7696005)(64756008)(4326008)(8676002)(66446008)(66946007)(66476007)(76116006)(66556008)(38070700005)(122000001)(33656002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkY5SXFhd1Z1Qnl4dHZNazdveFlOTkwrdmlKSkpCT2VIK1VJMUo0QmdrMnFl?=
 =?utf-8?B?ZGtFSE8wajBkelZVaHJsK20zNjFVWFl1ZG1lWEZIR0R5NTM0aGxPT002TEdE?=
 =?utf-8?B?dEljV0kxQ3hjR2duNEdSL2hTck01NzNkZkdaUmliaVRDOXlyZEFCOXFEOUh4?=
 =?utf-8?B?MkVCVnNnUFdhTWxwS3Z5L2tobER3NEowZzFzcUxVSXlueSt0TUNYeW1jUTZu?=
 =?utf-8?B?V05lQVN1SEh6RjFKQU9wL0VyM3RhN2ZzUk1iWDY5U1k1T0E0NTUrZFJ3ak1j?=
 =?utf-8?B?RU1oeWN3TXlKdXRpdVRLSjl6MW5xZTZHL1d3YWNuS1BFSHFldnBOZWZCYVhE?=
 =?utf-8?B?Z2JNbWlYenk4bXhWaFowcTVYZE91dk4wOVp2V1RFOTVDNXRtUkduM0ozT0Va?=
 =?utf-8?B?TCswOTJCT0FwUHlFS0NuUk1rejBqYmVxZlJnRU1yYTBTME9TRU5qaHFId05I?=
 =?utf-8?B?Y05iZmh0aExqL0NxS2w2QjgrZzVtRDlMcUVDS01tRnpTcGhEZlg5YjB3NTFN?=
 =?utf-8?B?bno2bFBuRFhqNkZ0ZjU3aGdZSTFYQXFpOHBXNW1pRUpLekgxQzZ3N1NxYmlC?=
 =?utf-8?B?UWJ0djBIajM2d0xodDFFRHlEUVlpUHVlbEl4MnR2Z0VUeW1IRUVQMDdiUWdv?=
 =?utf-8?B?aXJ1RE5jY2xsdU8wS1pzNmp3UVR2L2NCV2IrYVRITEVyWnB2UVJSOFFIMTBx?=
 =?utf-8?B?WTBRM1BVeDM1OUR2akhxRjNWc01tQXRTUU1LZmVSdytUbm41MnkrVmtPMGJw?=
 =?utf-8?B?empYV2V3Q3lDOHlTRnZIbWtlNFV3eGdkNVF0YWh0ODBVbHFGL1kwTkFEKzZB?=
 =?utf-8?B?SWQ0cTY0bVdaS0VuTHVlY2xYWGpORktUM0NrNHhsaFRWajZEVThHblYveDU3?=
 =?utf-8?B?eXM5R3BGNkpqYjlzNEk5dDJVQ0F4R2tzUGsyS2lpV2RoejRVQTI4aHUvcWFs?=
 =?utf-8?B?a1BPUFRwc2Q4Mk5odzFmTFFXNCtUZlg4NmhlWWFrdFMzL3ZMSGZkNVhya3Yw?=
 =?utf-8?B?NFI2QjVpL1hHVWVYKzcwbnRReGtkcFJRay9RMmhDRzg3ejFvMWpSVkJGc3BY?=
 =?utf-8?B?YjU3VFZGV0Jxek9lRngyeEhsK0JwUzl4b29EUTE3OEJGdW9qcGhoUStzOUx0?=
 =?utf-8?B?L2Z1dUJ1bS9LS0JsVVc3SS9MN1VPRkZUL05sOHRnTS9KVGd4Vy92MUtLUTRu?=
 =?utf-8?B?NVdLaXIyZDlnTWdGRElXWHU0TkhGZ2NBb2gwNFpROHVNYUtnT2RLY2p0K21l?=
 =?utf-8?B?QXNiZjBrWEFYYmFWWnpiRTgyS2FCN2dpYnJOdGx2ZXdza1ZuT1YrWGE2OVVr?=
 =?utf-8?B?K3NYcVdJeEZucmVDdlllQnEzbE1zN05xRlFaeFk0TE9Va01iZ1dzc2lHTVM0?=
 =?utf-8?B?UHUrMTBsa2F1WHM5YVRiTVM4ekJNV3VXRjNxUkF5TjFlYlY2SjJDS2djaFdX?=
 =?utf-8?B?N1NGVDgvRDZXTVNQODdMV0RNK3c2b3VJMUJpQlpLWXNwa3N5NEFoYnlBMjJn?=
 =?utf-8?B?akxQUlVIM3MzVWhnTmw1ODMvUGxlSGNjK2xZQklTbW9MRHJ4Y2dINjZTcXFL?=
 =?utf-8?B?MC9UM2NYSTJLdmhRb2xZMkpxUVgrc2VERWVlWnN3RnNEdjhPMkNPaS8rSVM0?=
 =?utf-8?B?UUovVmgyMmd6UHlkT2FidmFuZHg0UlMxL1ZVSDgrbkhYcVJoR1QxUkswdS9p?=
 =?utf-8?B?NzJ4VEg1L08vOXNDaWhjZGxyRHZIcVdvN0RXRUt4NGpvZ1FtZzlZakoweVJW?=
 =?utf-8?B?Vlo2SmtZd0lncHBZN0JRMkhCb09venBlazFHdzRqT3p5eSs1YnowRGtMK1ln?=
 =?utf-8?B?STkvQnVia3NjbVBOTG1kNktjT08yckUzb3QzTWxiUE90USt2OU1GbllXdGVq?=
 =?utf-8?B?dHNGVWpDeWZpbS9zQldkMWZsVUJaNXIvS1MvOUJ6MEs4SUxYNDRjaWJ3YUJk?=
 =?utf-8?B?MG90OVhEd0ZjaldpQ2V3MEZCVnRVa0libjZiek9nZzBUaFBlYUx3WEpBZ3cw?=
 =?utf-8?B?QzR6SzZ5YlVwSlArT1JVa20xQXVHQjVnVTdBNDBKUXlXS2NMbHlpdDR0R0Q3?=
 =?utf-8?B?QXB1T1ZMdU5hZHNMNEZ4UEhnZExsNU50UWFDNU1xU3dCTW8rTVRweXNQNmdh?=
 =?utf-8?Q?5lqj2Uvcjq6W31D6/VFTB40Ab?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407f7218-3f2a-41de-6930-08daa99b6527
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2022 02:10:10.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIZ0NHVUojeRPORyo95POWLkqEJFZVvhnIlft66AGMjWDMWWMw4N6javGVoVWUnNmx6eSVyiZhAoXDonMj4YBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7705
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
SCB2MiAwOS8xNl0gaWlvOiBhZGM6IHZmNjEwX2FkYzogYWRkIGhlbHBlciBmdW5jdGlvbiB0byBy
ZWFkDQo+IHNhbXBsZXMNCj4gDQo+IFRoaXMgaXMgYSBwcmVjdXJzb3IgY2hhbmdlIHRvIG1ha2Ug
aXQgc2ltcGxlciB0byByZW1vdmUgdGhlICdtbG9jaycNCj4gdXNhZ2UuIEhhdmluZyB0aGUgY29k
ZSBpbiBpdCdzIG93biBoZWxwZXIgZnVuY3Rpb24sIGFsc28gbWFrZXMgaXQgZWFzaWVyIHRvIHJl
YWQNCj4gdGhlIGVycm9yIHBhdGhzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51
bm8uc2FAYW5hbG9nLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5A
bnhwLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy92ZjYxMF9hZGMuYyB8IDk0ICsr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1
NCBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMgaW5k
ZXgNCj4gYzZiMTZjZjZlMzY3Li5hNmY5MTgyZDc3NjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aWlvL2FkYy92ZjYxMF9hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMN
Cj4gQEAgLTYyMiw2ICs2MjIsNTggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3Jv
dXANCj4gdmY2MTBfYXR0cmlidXRlX2dyb3VwID0gew0KPiAgCS5hdHRycyA9IHZmNjEwX2F0dHJp
YnV0ZXMsDQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBpbnQgdmY2MTBfcmVhZF9zYW1wbGUoc3RydWN0
IGlpb19kZXYgKmluZGlvX2RldiwNCj4gKwkJCSAgICAgc3RydWN0IGlpb19jaGFuX3NwZWMgY29u
c3QgKmNoYW4sIGludCAqdmFsKSB7DQo+ICsJc3RydWN0IHZmNjEwX2FkYyAqaW5mbyA9IGlpb19w
cml2KGluZGlvX2Rldik7DQo+ICsJdW5zaWduZWQgaW50IGhjX2NmZzsNCj4gKwlpbnQgcmV0Ow0K
PiArDQo+ICsJbXV0ZXhfbG9jaygmaW5kaW9fZGV2LT5tbG9jayk7DQo+ICsJaWYgKGlpb19idWZm
ZXJfZW5hYmxlZChpbmRpb19kZXYpKSB7DQo+ICsJCXJldCA9IC1FQlVTWTsNCj4gKwkJZ290byBv
dXRfdW5sb2NrOw0KPiArCX0NCj4gKw0KPiArCXJlaW5pdF9jb21wbGV0aW9uKCZpbmZvLT5jb21w
bGV0aW9uKTsNCj4gKwloY19jZmcgPSBWRjYxMF9BRENfQURDSEMoY2hhbi0+Y2hhbm5lbCk7DQo+
ICsJaGNfY2ZnIHw9IFZGNjEwX0FEQ19BSUVOOw0KPiArCXdyaXRlbChoY19jZmcsIGluZm8tPnJl
Z3MgKyBWRjYxMF9SRUdfQURDX0hDMCk7DQo+ICsJcmV0ID0gd2FpdF9mb3JfY29tcGxldGlvbl9p
bnRlcnJ1cHRpYmxlX3RpbWVvdXQoJmluZm8tPmNvbXBsZXRpb24sDQo+ICsJCQkJCQkJVkY2MTBf
QURDX1RJTUVPVVQpOw0KPiArCWlmIChyZXQgPT0gMCkgew0KPiArCQlyZXQgPSAtRVRJTUVET1VU
Ow0KPiArCQlnb3RvIG91dF91bmxvY2s7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKHJldCA8IDApDQo+
ICsJCWdvdG8gb3V0X3VubG9jazsNCj4gKw0KPiArCXN3aXRjaCAoY2hhbi0+dHlwZSkgew0KPiAr
CWNhc2UgSUlPX1ZPTFRBR0U6DQo+ICsJCSp2YWwgPSBpbmZvLT52YWx1ZTsNCj4gKwkJYnJlYWs7
DQo+ICsJY2FzZSBJSU9fVEVNUDoNCj4gKwkJLyoNCj4gKwkJICogQ2FsY3VsYXRlIGluIGRlZ3Jl
ZSBDZWxzaXVzIHRpbWVzIDEwMDANCj4gKwkJICogVXNpbmcgdGhlIHR5cGljYWwgc2Vuc29yIHNs
b3BlIG9mIDEuODQgbVYvwrBDDQo+ICsJCSAqIGFuZCBWUkVGSF9BREMgYXQgMy4zViwgViBhdCAy
NcKwQyBvZiA2OTkgbVYNCj4gKwkJICovDQo+ICsJCSp2YWwgPSAyNTAwMCAtICgoaW50KWluZm8t
PnZhbHVlIC0gVkY2MTBfVlRFTVAyNV8zVjMpICoNCj4gKwkJCQkxMDAwMDAwIC8gVkY2MTBfVEVN
UF9TTE9QRV9DT0VGRjsNCj4gKw0KPiArCQlicmVhazsNCj4gKwlkZWZhdWx0Og0KPiArCQlyZXQg
PSAtRUlOVkFMOw0KPiArCQlicmVhazsNCj4gKwl9DQo+ICsNCj4gK291dF91bmxvY2s6DQo+ICsJ
bXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgdmY2MTBfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldiwNCj4gIAkJCXN0cnVjdCBpaW9fY2hhbl9zcGVjIGNvbnN0ICpjaGFuLA0KPiAgCQkJ
aW50ICp2YWwsDQo+IEBAIC02MjksNTMgKzY4MSwxNSBAQCBzdGF0aWMgaW50IHZmNjEwX3JlYWRf
cmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ICAJCQlsb25nIG1hc2spDQo+ICB7DQo+
ICAJc3RydWN0IHZmNjEwX2FkYyAqaW5mbyA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+IC0JdW5z
aWduZWQgaW50IGhjX2NmZzsNCj4gIAlsb25nIHJldDsNCj4gDQo+ICAJc3dpdGNoIChtYXNrKSB7
DQo+ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX1JBVzoNCj4gIAljYXNlIElJT19DSEFOX0lORk9fUFJP
Q0VTU0VEOg0KPiAtCQltdXRleF9sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gLQkJaWYgKGlp
b19idWZmZXJfZW5hYmxlZChpbmRpb19kZXYpKSB7DQo+IC0JCQltdXRleF91bmxvY2soJmluZGlv
X2Rldi0+bWxvY2spOw0KPiAtCQkJcmV0dXJuIC1FQlVTWTsNCj4gLQkJfQ0KPiAtDQo+IC0JCXJl
aW5pdF9jb21wbGV0aW9uKCZpbmZvLT5jb21wbGV0aW9uKTsNCj4gLQkJaGNfY2ZnID0gVkY2MTBf
QURDX0FEQ0hDKGNoYW4tPmNoYW5uZWwpOw0KPiAtCQloY19jZmcgfD0gVkY2MTBfQURDX0FJRU47
DQo+IC0JCXdyaXRlbChoY19jZmcsIGluZm8tPnJlZ3MgKyBWRjYxMF9SRUdfQURDX0hDMCk7DQo+
IC0JCXJldCA9IHdhaXRfZm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJsZV90aW1lb3V0DQo+IC0J
CQkJKCZpbmZvLT5jb21wbGV0aW9uLCBWRjYxMF9BRENfVElNRU9VVCk7DQo+IC0JCWlmIChyZXQg
PT0gMCkgew0KPiAtCQkJbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gLQkJCXJl
dHVybiAtRVRJTUVET1VUOw0KPiAtCQl9DQo+IC0JCWlmIChyZXQgPCAwKSB7DQo+IC0JCQltdXRl
eF91bmxvY2soJmluZGlvX2Rldi0+bWxvY2spOw0KPiArCQlyZXQgPSB2ZjYxMF9yZWFkX3NhbXBs
ZShpbmRpb19kZXYsIGNoYW4sIHZhbCk7DQo+ICsJCWlmIChyZXQgPCAwKQ0KPiAgCQkJcmV0dXJu
IHJldDsNCj4gLQkJfQ0KPiAtDQo+IC0JCXN3aXRjaCAoY2hhbi0+dHlwZSkgew0KPiAtCQljYXNl
IElJT19WT0xUQUdFOg0KPiAtCQkJKnZhbCA9IGluZm8tPnZhbHVlOw0KPiAtCQkJYnJlYWs7DQo+
IC0JCWNhc2UgSUlPX1RFTVA6DQo+IC0JCQkvKg0KPiAtCQkJICogQ2FsY3VsYXRlIGluIGRlZ3Jl
ZSBDZWxzaXVzIHRpbWVzIDEwMDANCj4gLQkJCSAqIFVzaW5nIHRoZSB0eXBpY2FsIHNlbnNvciBz
bG9wZSBvZiAxLjg0IG1WL8KwQw0KPiAtCQkJICogYW5kIFZSRUZIX0FEQyBhdCAzLjNWLCBWIGF0
IDI1wrBDIG9mIDY5OSBtVg0KPiAtCQkJICovDQo+IC0JCQkqdmFsID0gMjUwMDAgLSAoKGludClp
bmZvLT52YWx1ZSAtIFZGNjEwX1ZURU1QMjVfM1YzKSAqDQo+IC0JCQkJCTEwMDAwMDAgLyBWRjYx
MF9URU1QX1NMT1BFX0NPRUZGOw0KPiAtDQo+IC0JCQlicmVhazsNCj4gLQkJZGVmYXVsdDoNCj4g
LQkJCW11dGV4X3VubG9jaygmaW5kaW9fZGV2LT5tbG9jayk7DQo+IC0JCQlyZXR1cm4gLUVJTlZB
TDsNCj4gLQkJfQ0KPiANCj4gLQkJbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4g
IAkJcmV0dXJuIElJT19WQUxfSU5UOw0KPiANCj4gIAljYXNlIElJT19DSEFOX0lORk9fU0NBTEU6
DQo+IC0tDQo+IDIuMzcuMw0KDQo=
