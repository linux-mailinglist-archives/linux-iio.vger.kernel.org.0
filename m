Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F890554777
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jun 2022 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiFVJcN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jun 2022 05:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiFVJcL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2022 05:32:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF02A38BFB
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 02:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW/S+PstN5t7gxAnBY5Mpo7WVOdeXYcSy+HDLOtAUu9lrNFFm8KKhfUcsXsQbx1PyjWJaP1EKiGG2knAUujhG3+spCcC77Na+Kltav178jAR5R0NR/U1qPmAOg3iUpKhC0J2lf8OnVH+mJ14zvSrwYq4agheYX8DYrQ1Iqr59eeYTtBUvsXvKAM6zEGagG0xhP/rn6sYLWjhZgKkwTezboa0k5/M9C/CmbV7obszB5BJpuY1w3SbZd2Lzop0O/RpKtuIwpBVykWJwPB7oxaS08imwdanv8WqNArrPfjrqrk/H3aATKoGoEDfUWWQaseV+Z+Mz/4yaLLaxkvFIjCA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSvCUsNuhHIl34QzUzqsPEnh2hNZNE4VFgkBcVQyyk4=;
 b=O/XoVPKg9Ld4KvmW+Ohvdpc5NzW9pi0CcunibFC19h0IKTrSEnXAYeE/UMqmhRv+o9tV2P3JwyL0votbdZgcmdemNZ3KnwXSuyIOh4cbcPw+LwQwESJvAvYbzYB2FZZYSyJrKof6+1l9YsYvaWFRXyXkorohZaPYbzqy/UMYs39f2QNGDIoDw1/y7IprYLVHb4PtiLLQ2la+A1FRKgujMrfLTMrGlRnSRwO9+uY/nStmCE+Ed4LAdUZpkwKSNT27ogJEIS7OxpdEXsw2HZ/JF6OSwmLFEnIRWL+ilv2fk/EqX2ylAobMLcfFM/GTszH8b5N2tzxYQ4UX8z5ojA0vVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSvCUsNuhHIl34QzUzqsPEnh2hNZNE4VFgkBcVQyyk4=;
 b=DMg144ZYVkEKjAOutJFcck8jL2HdHImGFcoYFfwKGkS2BZEAQq9IvinE7w+P7QmNW5k52QlEqPB+REhUMI9crqv+AR0tWZ69kDyCgzTpIBZPCyNqwrBAhtLODhTefxwJn3dBLbjJQTAW8iTHork/Q+GOBWAWxS3e/gLZcT7RGeU=
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com (2603:10a6:208:5d::20)
 by AM6PR04MB5527.eurprd04.prod.outlook.com (2603:10a6:20b:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 09:32:07 +0000
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::f843:aee5:eb45:dfdf]) by AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::f843:aee5:eb45:dfdf%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 09:32:07 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?gb2312?B?TnVubyBTqKI=?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 27/36] iio: adc: imx8qxp: Switch to
 DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
Thread-Topic: [PATCH 27/36] iio: adc: imx8qxp: Switch to
 DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
Thread-Index: AQHYhayJj0PaKLofHEuZ1hWMYzkxHa1bKmGw
Date:   Wed, 22 Jun 2022 09:32:07 +0000
Message-ID: <AM0PR04MB40015D1B86DEE5B339DBBA3390B29@AM0PR04MB4001.eurprd04.prod.outlook.com>
References: <20220621202719.13644-1-jic23@kernel.org>
 <20220621202719.13644-28-jic23@kernel.org>
In-Reply-To: <20220621202719.13644-28-jic23@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28d4e054-29ce-4416-8054-08da54321345
x-ms-traffictypediagnostic: AM6PR04MB5527:EE_
x-microsoft-antispam-prvs: <AM6PR04MB5527E0A2FCBADA46C7474E2F90B29@AM6PR04MB5527.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cs1K3VPI2i6RmRlI6LzKR/OWknOXh6ZlNTepFtjs/+0zhmNRcfvvayLtR0jAERoB/9Ir/IaT7ai49fZSvp6qbKUfF7+JDaRzHN7WwOaKO81za2p13Jw4y8BkZ8g9y7xFEuiCNo7df7bm3wH51vgSYCBKIYWwITB3u99ImvX+USsA9SF2qYQKsZ3LLME9N5qItrZ+5QOpFUq5uCWMZ4RCuIzTHy/iqmwr90532Kvcil9sd/pGAVQRq5OTi0e8e1yNpxmp/TJ1M0BokJonsZW1nrDbje7j80vdrGIvc6kxNlXKD1bMddaNa7h4Sd9ZsLjBBHZIwrh1WmrWU/DksRmT/xEEmyn5qJ78EdjzYozJ2Pw71z701T1RsvqPnUauDzRmlANFXBciW7FCKred9+XX7sDF0QqF5JFbi81meb+Cd3wkdxo7o3o4ZT35VbmwqPO7pn0MScdkO1Uu7aYmtE1wAZ/LxKcnC8iWL2PqzVrZ1JH5xflpKt8t8ry/PuUKf6zwcUtud1B4qAXDYNzg75wWv8Jkysc4EP9xN9weaIDsBeHHZOe/KBSC3EhfcTHxeaoOiL2LxDgoItReYqtzUhZOMp1GKY4Oun/hKt8Okh0qx/9r+VyRDGduI3mCY4q/Vztvc26VyhMudi7spveBuYPMBvzABeOP/3AZ/ZZoxhhdZAUPyCNDZ3Yccnianm+R0u2Kt/0SnFP+qJr3kdO140NI07I3ZHqfBU56nYO9GWDYjKfWYrv0dtleN6XWgCLC5pDCpE2Jok1XapkSmiaFH4+rZK4ncft7Ry+kA7ahaPiuyQc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4001.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(26005)(7696005)(9686003)(53546011)(478600001)(6506007)(122000001)(71200400001)(38100700002)(110136005)(38070700005)(186003)(41300700001)(7416002)(66946007)(7406005)(4326008)(5660300002)(64756008)(66476007)(66556008)(76116006)(8676002)(66446008)(33656002)(2906002)(316002)(83380400001)(8936002)(54906003)(86362001)(55016003)(52536014)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?U2EweDZZKzBuTkUrZkZweUd1NndrZnA5RkE0V2oxZnB1MnFOMHV5ZXYwbWZU?=
 =?gb2312?B?UkU0cU1VTjBjWlFQRWVQcTVDNlFDZUkvTk5Vb2h5bU8rdE84V1o0TUJ3ZU9k?=
 =?gb2312?B?NHpua3FDVzlCajVpbVBpbnNBRkdJQktJZzNUSUd5Y01DNWVtN1Y1dWxnZFVF?=
 =?gb2312?B?NHJSUDMyREhiME1yVk0vQ2tML0xaZlFZWWNpNXBuT0pETFNFckZVcy9JSnp4?=
 =?gb2312?B?cytVRjZKSk1aSFNDLzE5YVQzQ0N0OVRoQmhIMnBsVi8ydDVZa1g2VHBKM3Fs?=
 =?gb2312?B?OUliRW9rR2RyZTdaSjdqUWU3aDhyNlBJVTZNTzlWQXpGdHQxbmw3T1lEcUp6?=
 =?gb2312?B?VWVZQ3gyUEViUWh0aVdYSndCOEpWeGtaUHQwWjNuSXcwY05OSVFnZmxuRi9Y?=
 =?gb2312?B?cloySncvNXZuMmFURnlqSU5rbnBnQlUrU3BjRU5pS1lqMSt4ZXg0NmtjcmNW?=
 =?gb2312?B?N2RPNytTVkJLQlVHLzNsSk45M0Ezb1h5TyswOTRCN2dWMmhrSkFiSjJZSmFI?=
 =?gb2312?B?Mkhrd3VsZmoyODdaWkZSZG1ici9oZG9CZGxTczFGNk91cFMzNmFlK0xFY0Ns?=
 =?gb2312?B?OEx5eFUxWHhLVWJjWmdJZXhWS1NMdDRJOFlpTkZDRXdrTFRvQVF5WUxCV0FE?=
 =?gb2312?B?VUZRQVYyV244anROcUxzRzltY1NoRjBqc0NLaXJqRFFrMmlLcXRwT2JqWUVj?=
 =?gb2312?B?OUkxSnBXbEZBalNZRGxrbllvdzEwNWhtTkhxd3FicHJxOTBNNGRYM3ZGdkdT?=
 =?gb2312?B?WmlaQmhJQUI4czJGUnBlVzJ1YU5aZGREbVR6ck01ODJWRWFic3FoWWVoK0h3?=
 =?gb2312?B?WWNlK2FESy9tbzB2T2U4Z1pVY2VtMEtFWVBrZm1wbm5QRGdCU01jelNQVjd1?=
 =?gb2312?B?NHowS240WFNQWHVjQ3ZES0NLbFhTb01GQjFEME1tTUg5cHdUa25DREhBdnN2?=
 =?gb2312?B?SEtSc1R1SGNwWTRQS3RaTlhPNS8xamVvcHBYc09nekpGd0lYdWFkUWxPSEZW?=
 =?gb2312?B?Z0M0TlFWTlhLQWJQT1NYUzRNVmk4VndEeE1MeUxHbk5YSTh1cHRGOFNFbWNW?=
 =?gb2312?B?cnRhZGw5aVl2ajFhMVljckRDOHMzRi9ES3hobmVDWWhVMlRUbkhEM1pGYzdO?=
 =?gb2312?B?cFozRlQ4YndqYW14cm4yd3E5NG1jNkZXYmM5WGFBYW10Wm0rR2ZzbktIQVM1?=
 =?gb2312?B?SjVQOVlwNXIyTGZxcVZ0bHB4eHZYVzR2VVBuSzdZb3RqSjlWSGJ6WDlCTmpD?=
 =?gb2312?B?REVacTZHWDArbmFBd0JCcHUzQU1qR0dNMUxpdlM4RFltRjlJTzQxZUVkWTdZ?=
 =?gb2312?B?eW91U1JMRHIvMkJnaWJaOVBZeGdTVE1RbGtHbkVLQURSUGNCczlGY1VobXJw?=
 =?gb2312?B?R05Ya3FWdzIzUmV4akZ1Y0pFM05XbE15MVd3UzR0Qk0wMHQ2Z2pNRDFwRHND?=
 =?gb2312?B?dng1amhhd1l3ckFoSHN5V2RYdVRNb3hmcVV2U1kxNGRSenZvU3EwT0ExWVJn?=
 =?gb2312?B?WWp2UTNUQnNzQUxsU3VSYkMyMTluZER3TGpHQWhrT0JqeDhobXFSbGRoNENy?=
 =?gb2312?B?SG5KL1d6eEN0MjVEOVBCd0Z1cHlMVzFaeHZuUEtJRjJJZGhlL3puclFla2Zv?=
 =?gb2312?B?dThkdk1EbnloSmxaR1BEcXBnSjEwUjhCaThMSkFCSnNMUDlHRERna3c4MHVG?=
 =?gb2312?B?WTdxeWVLL0lFY1pzWDdMdHNOeG80K2loSEZYb0lZWW5rdFF0VUhRVEMyQnpm?=
 =?gb2312?B?c09MQzl5QWJaUGh0ZHVkQkhISHlzVFlzQ1RIdVI4ajFaZVJyczlNR0ZrTFNm?=
 =?gb2312?B?N3hwbjUzbkpYbzMyNE1iaUlWOUdnQXh3bzRPeWN2MXd6ZVM2L21CYVZZNkxW?=
 =?gb2312?B?ejRncE5ucCtDWkxsSW5RUlNxekRTTW9VZ2ZMc1JBS2VGdVV6ZjJDZ0YxeElJ?=
 =?gb2312?B?eG9zT3c4QWlabFoxN0xvcDlZODN2RTBKU0VNb3p2cVJ4c3pia0p0RExpRmNh?=
 =?gb2312?B?TG1uTEhIOEx2SVMwZXpzU1oxeWY2YlRQVkpwL0FwSUJmRS8vYklIRHBQb2RK?=
 =?gb2312?B?cEVjcGo1WkR1bXoyVTNYa041Vk5nSmpwQzVZUnZybTc0Zys3U1lOMlFHZVh6?=
 =?gb2312?Q?qxwo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4001.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d4e054-29ce-4416-8054-08da54321345
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 09:32:07.4141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnhCtngrpfI613FudgAIQOfkngOeWTIWpwYzUE8caiV5jds45V093mzQsE5LZ8PX9/uIT0tOTCEjJBjBeQXU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo21MIyMsjVIDQ6MjcNCj4gVG86IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0
Pg0KPiBDYzogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29t
PjsgQnJpYW4gTWFzbmV5DQo+IDxtYXNuZXliQG9uc3RhdGlvbi5vcmc+OyBEYXZpZCBIZWlkZWxi
ZXJnIDxkYXZpZEBpeGl0LmN6PjsgQ2FpIEh1b3FpbmcNCj4gPGNhaS5odW9xaW5nQGxpbnV4LmRl
dj47IENocmlzdGlhbiBFZ2dlcnMgPGNlZ2dlcnNAYXJyaS5kZT47IEVucmljIEJhbGxldGJvIGkN
Cj4gU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+OyBFdWdlbiBIcmlzdGV2DQo+
IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+OyBHd2VuZGFsIEdyaWdub3UgPGd3ZW5kYWxA
Y2hyb21pdW0ub3JnPjsNCj4gQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgSHVpIExp
dSA8aHVpLmxpdUBtZWRpYXRlay5jb20+OyBKb2UNCj4gU2FuZG9tIDxqb2UuZy5zYW5kb21AZ21h
aWwuY29tPjsgSXNtYWlsIEggLiBLb3NlIDxpaGtvc2VAZ21haWwuY29tPjsNCj4gTGFycy1QZXRl
ciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlq
QGxpbmFyby5vcmc+Ow0KPiBMdWRvdmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWlj
cm9jaGlwLmNvbT47IE5pY29sYXMgRmVycmUNCj4gPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNv
bT47IE1hcmN1cyBGb2xrZXNzb24NCj4gPG1hcmN1cy5mb2xrZXNzb25AZ21haWwuY29tPjsgTWFy
dGluIEJsdW1lbnN0aW5nbA0KPiA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT47
IE1hdGhpZXUgT3RoYWNlaGUNCj4gPG0ub3RoYWNlaGVAZ21haWwuY29tPjsgTWljaGFsIFNpbWVr
IDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT47IE1pcXVlbA0KPiBSYXluYWwgPG1pcXVlbC5yYXlu
YWxAYm9vdGxpbi5jb20+OyBOdW5vIFOooiA8bnVuby5zYUBhbmFsb2cuY29tPjsNCj4gUGFydGhp
YmFuIE5hbGxhdGhhbWJpIDxwbkBkZW54LmRlPjsgUGhpbGlwcGUgUmV5bmVzIDx0cmVteWZyQHlh
aG9vLmZyPjsNCj4gUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXgu
Y29tPjsgUmlzaGkgR3VwdGENCj4gPGd1cHQyMUBnbWFpbC5jb20+OyBSb2FuIHZhbiBEaWprIDxy
b2FuQHByb3RvbmljLm5sPjsgU3RlcGhlbiBCb3lkDQo+IDxzd2JveWRAY2hyb21pdW0ub3JnPjsg
VG9tYXN6IER1c3p5bnNraSA8dGR1c3p5bnNAZ21haWwuY29tPjsgWmhpeW9uZw0KPiBUYW8gPHpo
aXlvbmcudGFvQG1lZGlhdGVrLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPEpvbmF0aGFuLkNh
bWVyb25AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDI3LzM2XSBpaW86IGFkYzogaW14
OHF4cDogU3dpdGNoIHRvDQo+IERFRklORV9SVU5USU1FX0RFVl9QTV9PUFMgYW5kIHBtX3B0cigp
DQo+IA0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5j
b20+DQo+IA0KPiBTd2l0Y2hpbmcgdG8gdGhlc2UgbmV3ZXIgbWFjcm9zIGFsbG93cyB0aGUgY29t
cGlsZXIgdG8gcmVtb3ZlIHRoZSB1bnVzZWQNCj4gZnVuY3Rpb25zIGFuZCBzdHJ1Y3QgZGV2X3Bt
X29wcyBpZiAhQ09ORklHX1BNIHdpdGhvdXQgdGhlIG5lZWQgdG8gbWFyaw0KPiBhbnl0aGluZyBf
X21heWJlX3VudXNlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpv
bmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gQ2M6IENhaSBIdW9xaW5nIDxjYWkuaHVvcWlu
Z0BsaW51eC5kZXY+DQoNClJldmlld2VkLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5j
b20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvaW14OHF4cC1hZGMuYyB8IDEzICsrKysr
Ky0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2lteDhxeHAtYWRjLmMgYi9k
cml2ZXJzL2lpby9hZGMvaW14OHF4cC1hZGMuYyBpbmRleA0KPiBlOGM5YTY5ZTEwZWIuLmU0ODQ0
Njc4NGEwYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2lteDhxeHAtYWRjLmMNCj4g
KysrIGIvZHJpdmVycy9paW8vYWRjL2lteDhxeHAtYWRjLmMNCj4gQEAgLTQxNyw3ICs0MTcsNyBA
QCBzdGF0aWMgaW50IGlteDhxeHBfYWRjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+
ICpwZGV2KQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyBfX21heWJlX3VudXNl
ZCBpbnQgaW14OHF4cF9hZGNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
K3N0YXRpYyBpbnQgaW14OHF4cF9hZGNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gIHsNCj4gIAlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gZGV2X2dldF9kcnZkYXRh
KGRldik7DQo+ICAJc3RydWN0IGlteDhxeHBfYWRjICphZGMgPSBpaW9fcHJpdihpbmRpb19kZXYp
OyBAQCAtNDMxLDcgKzQzMSw3IEBADQo+IHN0YXRpYyBfX21heWJlX3VudXNlZCBpbnQgaW14OHF4
cF9hZGNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlyZXR1cm4gMDsN
Cj4gIH0NCj4gDQo+IC1zdGF0aWMgX19tYXliZV91bnVzZWQgaW50IGlteDhxeHBfYWRjX3J1bnRp
bWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3N0YXRpYyBpbnQgaW14OHF4cF9hZGNf
cnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBpaW9f
ZGV2ICppbmRpb19kZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIAlzdHJ1Y3QgaW14OHF4
cF9hZGMgKmFkYyA9IGlpb19wcml2KGluZGlvX2Rldik7IEBAIC00NjgsMTAgKzQ2OCw5IEBADQo+
IHN0YXRpYyBfX21heWJlX3VudXNlZCBpbnQgaW14OHF4cF9hZGNfcnVudGltZV9yZXN1bWUoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiAtc3RhdGljIGNv
bnN0IHN0cnVjdCBkZXZfcG1fb3BzIGlteDhxeHBfYWRjX3BtX29wcyA9IHsNCj4gLQlTRVRfU1lT
VEVNX1NMRUVQX1BNX09QUyhwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQsDQo+IHBtX3J1bnRpbWVf
Zm9yY2VfcmVzdW1lKQ0KPiAtCVNFVF9SVU5USU1FX1BNX09QUyhpbXg4cXhwX2FkY19ydW50aW1l
X3N1c3BlbmQsDQo+IGlteDhxeHBfYWRjX3J1bnRpbWVfcmVzdW1lLCBOVUxMKQ0KPiAtfTsNCj4g
K3N0YXRpYyBERUZJTkVfUlVOVElNRV9ERVZfUE1fT1BTKGlteDhxeHBfYWRjX3BtX29wcywNCj4g
KwkJCQkgaW14OHF4cF9hZGNfcnVudGltZV9zdXNwZW5kLA0KPiArCQkJCSBpbXg4cXhwX2FkY19y
dW50aW1lX3Jlc3VtZSwgTlVMTCk7DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgaW14OHF4cF9hZGNfbWF0Y2hbXSA9IHsNCj4gIAl7IC5jb21wYXRpYmxlID0gIm54cCxp
bXg4cXhwLWFkYyIsIH0sDQo+IEBAIC00ODUsNyArNDg0LDcgQEAgc3RhdGljIHN0cnVjdCBwbGF0
Zm9ybV9kcml2ZXIgaW14OHF4cF9hZGNfZHJpdmVyID0gew0KPiAgCS5kcml2ZXIJCT0gew0KPiAg
CQkubmFtZQk9IEFEQ19EUklWRVJfTkFNRSwNCj4gIAkJLm9mX21hdGNoX3RhYmxlID0gaW14OHF4
cF9hZGNfbWF0Y2gsDQo+IC0JCS5wbQk9ICZpbXg4cXhwX2FkY19wbV9vcHMsDQo+ICsJCS5wbQk9
IHBtX3B0cigmaW14OHF4cF9hZGNfcG1fb3BzKSwNCj4gIAl9LA0KPiAgfTsNCj4gDQo+IC0tDQo+
IDIuMzYuMQ0KDQo=
