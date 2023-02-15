Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F47697443
	for <lists+linux-iio@lfdr.de>; Wed, 15 Feb 2023 03:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBOCQp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Feb 2023 21:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjBOCQo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2023 21:16:44 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E474B25941;
        Tue, 14 Feb 2023 18:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iClaXmggSAxap2q9wMTPHyigayRvMNw94m7WObn52gjqscBVZjXq57lfjRqjWZu9OiwWzArdHl6/kNsLEYi+6Lm5zMbtizgnd+9bwBVxeot8FuNhGPWj965hcruEfEkEPnEAxprMytucZ9r9G0jWGQ99meaLebdQEVw686kA6NEnrUTIvJn+/i+apNv0GqH91UzFgrL5qnPBnWWlgxWZbHds9yWd1dj68kuUCTGZaO1JWhcG4ez0X87maQMendPksCKFUjrDnZBiGyLDkwTjVhReK64PAQlsgFsIJUYBsxoZs1agwN6BjynqCswxGbtPvhPMyRbSq7XiYHPZVukYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6fhQfNlmjxW8WWE6jCb/cNLi+6Hes5reJNeNUK3BkU=;
 b=WEjwy8mDTejq5+GMonGa2gjKmarsAjRYrmiyaaVZFoHudLEnShs+d8hKxzVnSvaGeJEPWL0ODRXoAhxr/9BhKjYQTz5jlB3BEHUpsxzVko0MDGLZu9VmU/MjOhmXOq2rSf4G0O6RuzuYRAEVS1ue0pB/aZn3Ou6o2pN7g6FiQ7OEVxUB98VVGF4IcqIZAOoC0Jt+nHxjEGoSh/a1eelQK8eP20LOLQSfMU8aFkw520PQf5D6RjyLoSKmP1HR/eYoYZ+kC4Sq1ZFlw3J2KwHWlNaoLYL8b/KbidprvoixfELqA/0fhIawENoA7XGkVPKY6uaX6HZvCLjgMZfYsJi80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6fhQfNlmjxW8WWE6jCb/cNLi+6Hes5reJNeNUK3BkU=;
 b=pvRWI35dr21Dt2jxzVVh+VU0KfBjZi6VdnIkoGRv8HOGR8Z1oRLhNTvWb3pfTLRZoE1/ONBta73yuka7YrlXf+yUE88B6dDIhv4LeSF5oyGM5y6GYG+bb+8Kl2YFeWitjlofzoF2xEqXPh/oPx8D8zvSRJQcNakF6thWcnLGsFw=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 02:16:40 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::70d7:db71:ec18:f332]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::70d7:db71:ec18:f332%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 02:16:40 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: imx93: fix a signedness bug in
 imx93_adc_read_raw()
Thread-Topic: [PATCH] iio: adc: imx93: fix a signedness bug in
 imx93_adc_read_raw()
Thread-Index: AQHZQIur/KNAywHmxUyQVR4kOvPfO67PRbGw
Date:   Wed, 15 Feb 2023 02:16:40 +0000
Message-ID: <DB7PR04MB40101ADA70EEDE9FE130714E90A39@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <Y+utEvjfjQRQo2QB@kili>
In-Reply-To: <Y+utEvjfjQRQo2QB@kili>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB8436:EE_
x-ms-office365-filtering-correlation-id: 4a09bd8e-f77e-461f-0845-08db0efaac82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yCGoPzssTaLhIkZdoES59qXU7kERCOfiMIjBpD0+le30OaomSZ8YQG+ps2WFLagayRBAc3/5E2cNwNbnABg7cX3rWUX/YBaS5/ioiEX03hCdmBZekM0f/MjK3Nmv7mBo0w02AvgIIqcROwQ5u4qucLHHypWFrOi1l+4K4KiW9nkLqVUQ2sGBxxDIVKHXldOqq1gwauDdJe9EWeirYkK1F8UOQc1fuFTEaPJm9cyW/VO3OYppMtVZA9JoyrXg3NZq3ELJlPSVr9/o66TS4voHc6bLFzwvGgWqVImkjua/9Bxc1Aq285HMlk9efbYa5cP6rEYMfbijPaInM1TmbCsld3mvKbuX/T6jHJ7StXOu0Dshz46Kieo23GEtp/z1FrCN5m2t7C3Uhd4HBNjEWym44ru7P4hDlSUMQBzEpE6UN5ZuTr5lKTxr4IK9Us2BAGIIFKa+eSYeTHxy98ZvjvWkrgoFn6z+rICBQKsrcbgtJ5x7UIzNr+vwfppG+QzUDWr5FuotktkMI6pU5lhRmEHvgGkvVoEfHFTpDwbhWNoizUjObLpLM30soSRezwAGKbFcbyfsroRDI/hGn4GTSYi4qTBVVWRmlNogOkwSNYmslcviyWJNyZr/qipDH1G5YAfyM2JVgjFOaqkTm5tr3dPQq2RXDFjB+/RYLdOVMjxOvwnnzyE1mx6Wtov3GHJcDojchuB+8pcC0Ogdw/Yp2z1oFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199018)(8936002)(38070700005)(86362001)(52536014)(41300700001)(38100700002)(5660300002)(64756008)(6916009)(8676002)(4326008)(2906002)(66556008)(66476007)(76116006)(66946007)(66446008)(122000001)(316002)(83380400001)(71200400001)(478600001)(55016003)(33656002)(54906003)(6506007)(53546011)(7696005)(26005)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QUdraTdUSHRzaktXUDNKUzBCU2hoOEhCRGtGRVJvTFdPWlZmMU9xaHVDYTd2?=
 =?gb2312?B?TkJBeFB3TUYrMytsRE00QVlEcFltN1kzUGhoYmxmUmMwYjdtdlFIUExGWUZo?=
 =?gb2312?B?K0pBaTh0d25XbWQwYTduYzdTM2dyR2NDcXVGT29ucmNNNmhMS3JpekR3NzB0?=
 =?gb2312?B?SlNQNDVnZTVSRW42ak1SWGt6cDFpZFJJU09waTA5bWxQdm5JU3NGNTlyRlJ5?=
 =?gb2312?B?K2FPK29vUE94eEpBREdaNmVOWTR4L293cW5RTVBzclJJbWF0OElUNFpYeDc2?=
 =?gb2312?B?ZUtOK2pMOHNOLzduU3YrczYvc3ZoSzVzWXdoOVZUbldCempZanlacVUrSkEy?=
 =?gb2312?B?Q3FaU3hZU2cxR203bzRVcXpwNk12SmJPV2NNRHE2NFZxL0MraXUrSGVpNk5v?=
 =?gb2312?B?Q2tucG1mMVpOYUR4cGMwbjVSY09Yb2l5eGpTL21Oa2I0UUwwc0MyS29OenZH?=
 =?gb2312?B?RjE2cjBKdHpvR0NPWmhOdEh3UmdXU0dDTFBjV0lodlZoRFR4RUUzVWZHRk1D?=
 =?gb2312?B?KzB3T1FyZzdvUFJqMldzOW9pZ21rZHJOTXdGeFZWWWhWOXJYN1B6OW9CbXB5?=
 =?gb2312?B?R2hweTNoYjVBMERPcDJhV1dQM1pIa1BjaE9taGhuMjFqZmFTUjdweFBXbTFG?=
 =?gb2312?B?ZWQ5c3pIVzBOaUpKZ3pZREM4MTJ0bitneGdqc2pSQ2NodHBWNjRLVXBrZy9x?=
 =?gb2312?B?c3VWMFAzNHpCa2IwV1ZHRFo0dDhROTJNN1p3WUxzdFhEOUdLeDhSTGhQQ0JU?=
 =?gb2312?B?WTQrME9vNzVQYUdhMms3MkJEL0JwUy8yNDJabzVqeDJlMk9ZRHJjUEFLZ1BC?=
 =?gb2312?B?clVZMVZlMEQ5bmhKMHdwQU5qMXQ2R2JtOFNUczZsZUhya0JTUEVGRGJNTlI1?=
 =?gb2312?B?N0V4Z1NUam8rMlptOHRQYmR1b2djYzExejNkbTFTWkNWYS93ZVY4NnVnQzB6?=
 =?gb2312?B?MmlSWDVhSWpjR1M3czNhZkVrRHJtSDRrU1ZXeXpCYXVUTyszVWVFUjJOZ1pn?=
 =?gb2312?B?SktnUGR0QktMMmgrdThXZDUwUjA1dTVHTE5RY2Z5b2p5ZW1HdVBzcG10Q0M5?=
 =?gb2312?B?VERMdmRoejBGVnZoRUxVcytTZ2dwWnRsaEJkamo3Vi93SUNZb2t1bnJzMmJZ?=
 =?gb2312?B?VkNsRS8rdTV0K1NQb3RTOW42ODRVZ3MwTG90dDN2L3hick9WUDhNb0lZSTND?=
 =?gb2312?B?TVk2TVM0d3RSQlRXRzZONWhodTVOdXZZWHlmTGdHcUN0cW9xTWRQVjVBakV1?=
 =?gb2312?B?WSsydU95REFGUFRpd1ZBRklGekZYeE4rNXZteGxKKytUQlZuMGI5Q25WMWhs?=
 =?gb2312?B?R3BlZktCaUtxVktSNGtnVkRFdG84TGFteUZyalFWcXI3ZVE2S1FUbzZTSUxk?=
 =?gb2312?B?c2J2MkJEM1lUSE5hcmNpYzAxNHVOaUNOR2lOWTcvbWhMVnpFUEwrRm5ja2Z2?=
 =?gb2312?B?MVFiVmVpbW1WYTF0V2xOQWNVYzhOSmd6RzhmVUZRNXd4UWwxS3VhWHI0dlV2?=
 =?gb2312?B?WFdLSzk3VWk4Tzg0MXpzVFRYQjV1anJ5MUdQZW90K2lYanpzOG1IT3k4WXV0?=
 =?gb2312?B?RkFYb2RzckJ0cXVWV2NaWDFHb2N0YVp1S0VUK1JsZmplekZDZE1SSXBCa1VD?=
 =?gb2312?B?a0lpd0JvQnFGYkNaL25TdjBoNnBYOThFcjVmeW5GeFFqOStIdStGYUdjUjF4?=
 =?gb2312?B?djlUUGQ0NVlKcVBIZjBnQkFqalhheTh3UFFuWUlzeFFiMVFGdXk2clpscE1l?=
 =?gb2312?B?TFN5c1hPOUpVVHdaZzJ6UGVQelBJOVZTem9WeVEzSlJhOC94SnVqUjdWSlBn?=
 =?gb2312?B?L25sRm9HUmxsemt3dHJPRWpReFZKYmhPVFNPSVpySjMxcU5rZWs4dlRueEk3?=
 =?gb2312?B?QXZZcUYyV1U5alFVR3FZRUo0SE5GWFoyOHR4Q3NLTWQybHdpaXV3RmtUT1Jr?=
 =?gb2312?B?WloxMjg4TW9KN2U5dEpDVzVScFVyT0Rpc3p3aGNWY0FnWWh5M2VKYUVSZitj?=
 =?gb2312?B?WkdvbzEvQmMyVVNrV1pZYVJEMmdGdjRsR0xpdHA2ZlNmY3lrU29GUWZVZXJY?=
 =?gb2312?B?NnlUYlg1djBkOWplUE84YlRDdDlWQnpaZmZJcUFYbkdKRklSTWdxeDhpR05v?=
 =?gb2312?Q?bbVKPljgkq43kzW+E52N8WxzC?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a09bd8e-f77e-461f-0845-08db0efaac82
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 02:16:40.1404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KG5WAzpjr5ujawHGB9/OVkyvBzCKTR9nvQ4i4buXAQ4L1WJ8OEpkvfMp2ALTiTdBuw40P6o09BqpnQakQ5j/0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW4gQ2FycGVudGVyIDxlcnJv
cjI3QGdtYWlsLmNvbT4NCj4gU2VudDogMjAyM8TqMtTCMTTI1SAyMzo0OA0KPiBUbzogQm91Z2gg
Q2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNA
a2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgU2hh
d24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyDQo+IDxzLmhhdWVyQHBl
bmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPGtlcm5lbEBwZW5ndXRy
b25peC5kZT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLWxpbnV4LWlt
eA0KPiA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBr
ZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gaWlvOiBh
ZGM6IGlteDkzOiBmaXggYSBzaWduZWRuZXNzIGJ1ZyBpbiBpbXg5M19hZGNfcmVhZF9yYXcoKQ0K
PiANCj4gVGhlIHByb2JsZW0gaXMgdGhlc2UgbGluZXM6DQo+IA0KPiAJcmV0ID0gdnJlZl91diA9
IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZShhZGMtPnZyZWYpOw0KPiAJaWYgKHJldCA8IDApDQo+IA0K
PiBUaGUgInJldCIgdmFyaWFibGUgaXMgdHlwZSBsb25nIGFuZCAidnJlZl91diIgaXMgdTMyIHNv
IHRoYXQgbWVhbnMgdGhlIGNvbmRpdGlvbg0KPiBjYW4gbmV2ZXIgYmUgdHJ1ZSBvbiBhIDY0Yml0
IHN5c3RlbS4gIEEgbmVnYXRpdmUgZXJyb3IgY29kZSBmcm9tDQo+IHJlZ3VsYXRvcl9nZXRfdm9s
dGFnZSgpIHdvdWxkIGJlIGNhc3QgdG8gYSBoaWdoIHBvc2l0aXZlDQo+IHUzMiB2YWx1ZSBhbmQg
dGhlbiByZW1haW4gYSBoaWdoIHBvc2l0aXZlIHZhbHVlIHdoZW4gY2FzdCB0byBhIGxvbmcuDQo+
IA0KPiBUaGUgInJldCIgdmFyaWFibGUgb25seSBldmVyIHN0b3JlcyBpbnRzIHNvIGl0IHNob3Vs
ZCBiZSBkZWNsYXJlZCBhcyBhbiBpbnQuICBXZQ0KPiBjYW4gZGVsZXRlIHRoZSAidnJlZl91diIg
dmFyaWFibGUgYW5kIHVzZSAicmV0IiBkaXJlY3RseS4NCg0KVGhhbmtzIGZvciB0aGUgY2F0Y2hp
bmchDQoNClJldmlld2VkLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNCkJl
c3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gRml4ZXM6IDdkMDIyOTZhYzhiOCAoImlpbzog
YWRjOiBhZGQgaW14OTMgYWRjIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVu
dGVyIDxlcnJvcjI3QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvaW14OTNf
YWRjLmMgfCA3ICsrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2lteDkzX2Fk
Yy5jIGIvZHJpdmVycy9paW8vYWRjL2lteDkzX2FkYy5jIGluZGV4DQo+IGQ4ZGU4Mjg0ZTEzZC4u
OGM2OGYwY2Q0OGYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvaW14OTNfYWRjLmMN
Cj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2lteDkzX2FkYy5jDQo+IEBAIC0yMzYsOCArMjM2LDcg
QEAgc3RhdGljIGludCBpbXg5M19hZGNfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYNCj4gKmluZGlv
X2RldiwgIHsNCj4gIAlzdHJ1Y3QgaW14OTNfYWRjICphZGMgPSBpaW9fcHJpdihpbmRpb19kZXYp
Ow0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9IGFkYy0+ZGV2Ow0KPiAtCWxvbmcgcmV0Ow0KPiAt
CXUzMiB2cmVmX3V2Ow0KPiArCWludCByZXQ7DQo+IA0KPiAgCXN3aXRjaCAobWFzaykgew0KPiAg
CWNhc2UgSUlPX0NIQU5fSU5GT19SQVc6DQo+IEBAIC0yNTMsMTAgKzI1MiwxMCBAQCBzdGF0aWMg
aW50IGlteDkzX2FkY19yZWFkX3JhdyhzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiAg
CQlyZXR1cm4gSUlPX1ZBTF9JTlQ7DQo+IA0KPiAgCWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FMRToN
Cj4gLQkJcmV0ID0gdnJlZl91diA9IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZShhZGMtPnZyZWYpOw0K
PiArCQlyZXQgPSByZWd1bGF0b3JfZ2V0X3ZvbHRhZ2UoYWRjLT52cmVmKTsNCj4gIAkJaWYgKHJl
dCA8IDApDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAtCQkqdmFsID0gdnJlZl91diAvIDEwMDA7DQo+
ICsJCSp2YWwgPSByZXQgLyAxMDAwOw0KPiAgCQkqdmFsMiA9IDEyOw0KPiAgCQlyZXR1cm4gSUlP
X1ZBTF9GUkFDVElPTkFMX0xPRzI7DQo+IA0KPiAtLQ0KPiAyLjM1LjENCg0K
