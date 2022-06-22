Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5355462F
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jun 2022 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbiFVJbO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jun 2022 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiFVJbL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2022 05:31:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F483818C
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 02:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN52d4zRtYlKYn48CTJJ34d/fC63zva0Fkje7ZLX6QC1sGXjVmF5sx91ozV+aRQWl6DkBdAjHSZxunIokopYHYjQkzLwa4EFEwkO2nBOdHyI8mQyFlYQfLbbJhqCHIlhR8y3dSejnKckFoFyfhP7K7VqpLR9CAHb6jgJvIygRPhZb6wNLLp1VrDRcH/cDcDAWQe+v1v78Ru7gxw8DgWwcBtV735iGWXR+otTdDsv8OtMQrEq+jBo7Ld+KivYHpuTjmZIglNp9gRDKRfPIxaJAr+DXTJX3Q935UExxRdmO5qlbuCw8+7dmNdHs3VhfWqIyNjfUjjQ95HjNxAuzwTk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+1EOKsOlaSBIUf1DdaVkWJ+l0GhJgFoSoLjGyYekSE=;
 b=i6sPFYy9R1RZAMB/P3ePagKBg+T39lt5DVFnwFUwU590ZReV/tPI8ubW+6FdqoMuiA8FY5/o1G4nDqHyGh3U1Fyaq7YwyZMeo4WQ2WTheyAJOet7a8N9xCTpYHR5YFzMEd04GcGvi7y6Sn5MRIHPRFrHdLU3/XH849fQj1jUfqdoC/sfL/geJO1wRkk2Fhoyv1kAuCKV6UVB3yjmcTGm5NLGMuJh/k9+RJ74NQYFgwZslr2gObPSaqm7yIfXg5upNukqIdlL/Ne6tHYlnlJjO6ggxrONgmqDbVULPxMiYESe8kRWePHWFdWWKlXCcPAAFERN9lYEiiRfP2VxEgp7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+1EOKsOlaSBIUf1DdaVkWJ+l0GhJgFoSoLjGyYekSE=;
 b=MZ7cCsCz2gLnmLKqBylhqxipa8v+us2tyYQgFeo3ZsV0LAag3O8BQCbfbymNtOF07lS4X6jiAnVOI2qi79qy4rZMq001XIjCkb2apYqNPDE5NUvaxB/SewK5T6LFFZ/ElhqKtl7tGB6kEl/y8C800IL+v55n+35sFK0H0KWTo7E=
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com (2603:10a6:208:5d::20)
 by AM6PR0402MB3592.eurprd04.prod.outlook.com (2603:10a6:209:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 09:31:07 +0000
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::f843:aee5:eb45:dfdf]) by AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::f843:aee5:eb45:dfdf%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 09:31:07 +0000
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
Subject: RE: [PATCH 04/36] iio: adc: imx7d_adc: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Thread-Topic: [PATCH 04/36] iio: adc: imx7d_adc: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Thread-Index: AQHYhawap6YJuDfMsUmCwM3u/SZYtq1bKhBQ
Date:   Wed, 22 Jun 2022 09:31:07 +0000
Message-ID: <AM0PR04MB4001536EBB010D6D2DDD39B190B29@AM0PR04MB4001.eurprd04.prod.outlook.com>
References: <20220621202719.13644-1-jic23@kernel.org>
 <20220621202719.13644-5-jic23@kernel.org>
In-Reply-To: <20220621202719.13644-5-jic23@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a4fdbd3-145b-4680-41df-08da5431ef85
x-ms-traffictypediagnostic: AM6PR0402MB3592:EE_
x-microsoft-antispam-prvs: <AM6PR0402MB3592B1F31734FD1B83B044DB90B29@AM6PR0402MB3592.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OnGn1vN5JC7kmhmEmgiQJ98yWxRknspPocDmWTppd/np/zAIZk7RphCm+Vn42mR0jqDwNvDXh7KmmNCdHr9IAJgAif5x/COGclLnVIQutm/GlF7aNQwd3Hx0kbFEiiZKwpZ5PHzmftqlZ2N9itgatkQ5jrr5xvQjcV2dbEv5U1Kjl6x5tv0soKmB1yFzFxASc+wd73XqZYSfJkfUIxsKxuKadNOwnA8AHL41rk/FxvvwR81Is3hmXSiDHPySQwdq68HNuoZbC49rQfc285VqyUIqrY5dkl4Nx0AwDgGVNgc6VMgKx7dzotqf8X6sAGyl4cU7Khh4nytffLOzsuib+8yLT/SKX61wl+4iC3tACWAg44e0drtcrllLqDpQ9F6Ew1yQ61iF1LhKSNMx8GoXTi9MKihKHf0Xa4QOrcHnkxmSDP54/1uHHmDEWSw7C0asT/6bDfkpar+q4WG8YeCjpejPWtV5av5Z2XOdmqV4e8qPKl9IJkhY4GNG9+GSoRE9tWPRaqAz3GJtFJyoFnGdpOInVDPUOGsXcta4ZQUq5ekYG7HP96G8Fv/yua1PZTXPQz94oXWy90YZvCliCkwJ+wnb2FLaMiPlEPRhhXr8B2pd9g1RA+EQWiZXVfxARiTKOL/JfT2Y8jYjMFHsozrEePTEsXCFq+lMVZ7aj8pbXPc9J/clClHz1P90fsiBO4oQ7yLobybvwpv6tkerALg4G+AIfA6iD8EhJR40PxQoGBResL1+9Esoe5v5j1HkH1Ua
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4001.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(316002)(8936002)(54906003)(110136005)(478600001)(7696005)(5660300002)(38070700005)(86362001)(53546011)(122000001)(52536014)(38100700002)(6506007)(9686003)(26005)(83380400001)(7406005)(55016003)(66476007)(66556008)(66446008)(71200400001)(76116006)(8676002)(64756008)(4326008)(186003)(41300700001)(7416002)(66946007)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S2dMMVluQnEwTk5kamlnelpoRTAxNnZrRFFEQTJmMGwxbWJ0QnVaaGpSYS9I?=
 =?gb2312?B?QnpYODVXQ25TWnBNYXlUTElUVEdNRnB4ZHQ0UGM1UVhjOXh3TUgwY0k3Wjc5?=
 =?gb2312?B?NGdqMkJ2N0FYUVlYSHR3UzhUR3ArWDhWcWc3eXFqQlFrYTFOa25MVVo1SkdI?=
 =?gb2312?B?MXM3WlpWMFVSMURZN3F0eXNGMUNHeFFlZzBpMVlYM21OVjlBa3JIdXY1cWhW?=
 =?gb2312?B?VE5mQXprdlFXL2NtWnFsL1NMTHVHR1p4RHhYclc4NGIyTVB1WVhPSVJ3RHNi?=
 =?gb2312?B?NWNTdG1kbVYwM0RuaytRTXlkdGZDOGZUR1lEODF1TTF3OWxhQklrUG54ZEFw?=
 =?gb2312?B?TU52Nm9EK0pWV0lmeElkK1dSNjFWVk56QldTcHFMMjk3R05VRmlyMHdmZTE2?=
 =?gb2312?B?ckFQdDRuZTNZclJlaWFST3NZbXJJR1hKbi9OajYyQzZDSkRFS1lQL2p1OUpl?=
 =?gb2312?B?UERWUlNiYkhHSHh4ZkZ5M29kbjRIbTRQajlZQklBSkRFMXJ1NzdXMU9DTzQ1?=
 =?gb2312?B?Y2lYL1krRlJXZE5PWlJMck5BSm04U2xacGJUdEhYTTc2bExGTXJSY281L0c0?=
 =?gb2312?B?OVFqTHVSSk4zUWN2YXdEOWpyZFovTVUrQkVrTGx4d2lHWndVV04xQkl5RmFE?=
 =?gb2312?B?RWljVUd0cjBKTXNaSU9SMXR4emNoRzR5SDJwU3lhQmtjaGxCdXkrRVlJcUZp?=
 =?gb2312?B?Um9VWXFhNUJkQ294V2V2RnFEaUZnQlB3Z3pydFAzR0tLRGF2QUVKbVlEazVj?=
 =?gb2312?B?bGxTVVlYUTVJT25HZ3JCb0VFTEhvMmE3dDZtSDBmZSt2SzRxeG1WSTBNMGdi?=
 =?gb2312?B?aEFiWEFDWjQyV29BWkM5Z2NHd2tGQUpJZXgxcjVPb1FBN1BZR1Bud1F2bWFG?=
 =?gb2312?B?RmNPdTBPZmt6anFCUXBTdWM4ZkxDTmNSNXVHVGlGMk9pbktaNEoybzM3WUVQ?=
 =?gb2312?B?aHRNRXAyN0lUSkNlUnM2S0hsVTNGZTNveHNNYVpkeGtRNmxvYnhwSW1GZHNE?=
 =?gb2312?B?QVYyZmR3V0FDNGJMbGVUR29iTytHYjg2ZjJVZzE2ZDVzRXhGc2FjTjRwVXdH?=
 =?gb2312?B?MnBnNkNvQXc1UUdleG5aNFhLRGI2cjdVRmxnM2lrRjFMWXE0TmlzT0ZBckpv?=
 =?gb2312?B?TEpmbFR4dXA0MWthL3JJZDhJbUVkREQyK2E0MW5MNGNwV08yNUNqTXJwUExo?=
 =?gb2312?B?a2FsRWNwdmQvR1U0QUdiZm41aGNza0FXQ1VTNW1HSFFLWExPOFExNG9zbmZT?=
 =?gb2312?B?SXFZb3IwcFEyWnRiWHRBbEZyTmJlRmN2L29pQmszam9kaERSTjkzWE5mUitN?=
 =?gb2312?B?d1Q4bmJjVjFNUUVpOGw1ajMzczk5R1ZXWWpxb0p1ckNHNHNLTFBJbWwxOWFq?=
 =?gb2312?B?MW1HK2FoNVVaT05kL3ZMc1lqNnU2WHRkSHIwVHRGc2p4YzBIUmlWbGI0NGNC?=
 =?gb2312?B?aTJZNnN1S3pJZnM5MDFJUmtvYjhrMlQrbFlsajAreUE1V1NnMDhRTHRJOHBZ?=
 =?gb2312?B?blRxNTF4ME0weEZ5MktYZ2xpaml4Z2YwaWIyd0NxbmpncmNBWTZPN0FZWWI3?=
 =?gb2312?B?OWx5OFFIZnJHNjI1QTRBMkRvblpybDZySUh2SVNGMlFsbnpVTXZONjRQdmRI?=
 =?gb2312?B?blZaTXE1dFVCcjlRdktmVUVyNmZzZHBrcThUTmxHTUZ1dyszMnBuMGhMTzZW?=
 =?gb2312?B?d1VQRnZiM2xpRkFPZTU5a2djVk12aUxPZk9zby8zRHEwdmxmaWlFVzJoRUxQ?=
 =?gb2312?B?SFRkYWxIeFpQcjBYRFMzc0svbktSZnlic3NaVUk5SEFNOGd6d0JxMGpqd1NV?=
 =?gb2312?B?MW9lSW1ETmVXS0M2cFZlOStNMzlPYzg1UExVcmJqdGpQRlJzaFBVNmVJSk5E?=
 =?gb2312?B?OHNqRHRoc1M1RFFwZnhvQnZLYUdOczI3RTN0cVgySE9DMGRYNXk3aUJSYzRR?=
 =?gb2312?B?N1BEbjVJQW9pRHRSRG5lZjBCMUlYeERtZEJ4Z0duTjBjWnUvcWJmOHVGbGJw?=
 =?gb2312?B?bDVxTUs2Mmt3TG5Ba21tVWVWd2N1aWZjaFFKaDlGVU8wRDZFMDFjUm40d2xF?=
 =?gb2312?B?VEtpK1VUL3NiVmEvM0UxckNxak5oTkZ4VGMxd3lNNFBJcTVBN1pOdWx3ODNn?=
 =?gb2312?Q?O9RzXZsd0mommfNlXWX3K769C?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4001.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4fdbd3-145b-4680-41df-08da5431ef85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 09:31:07.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFSrBOFkmYvz+Qv0Kldd6BCcHgdsAIEvvzozbiIhyaMAIUCo/0hzSY/+8pF37i3f9ODgX/2/asALof1A5/AU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3592
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
bWVyb25AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDA0LzM2XSBpaW86IGFkYzogaW14
N2RfYWRjOiBTd2l0Y2ggdG8NCj4gREVGSU5FX1NJTVBMRV9ERVZfUE1fT1BTKCkgYW5kIHBtX3Ns
ZWVwX3B0cigpDQo+IA0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9u
QGh1YXdlaS5jb20+DQo+IA0KPiBJbiB0aGlzIGNhc2Ugd2Ugb25seSBnYWluIHRoZSBhYmlsaXR5
IHRvIGhhdmUgdGhlIGNvbXBpbGVyIGRyb3AgdGhlIHN0cnVjdA0KPiBkZXZfcG1fb3BzIGJlY2F1
c2UgdGhlIGNhbGxiYWNrcyBhcmUgY2FsbGVkIGZyb20gcGF0aHMgb3RoZXIgdGhhbiBzdXNwZW5k
DQo+IGFuZCByZXN1bWUuICBJbiBnZW5lcmFsIHRoZSBwdXJwb3NlIG9mIHRoaXMgbmV3IG1hY3Jv
IGlzIHRvIGFsbG93IGF1dG9tYXRlZA0KPiByZW1vdmFsIG9mIHRoZSBjYWxsYmFja3MgYXMgd2Vs
bCwgYnV0IHRoYXQgZG9lc24ndCBhcHBseSBoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9u
YXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiBDYzogSGFpYm8g
Q2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogSGFpYm8gQ2hlbiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2lteDdkX2FkYy5j
IHwgNSArKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvaW14N2RfYWRjLmMgYi9k
cml2ZXJzL2lpby9hZGMvaW14N2RfYWRjLmMgaW5kZXgNCj4gMTE5MjE3YWYyYmRlLi44NmNhZmYx
ZDAwNmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9pbXg3ZF9hZGMuYw0KPiArKysg
Yi9kcml2ZXJzL2lpby9hZGMvaW14N2RfYWRjLmMNCj4gQEAgLTU0MCwxNCArNTQwLDE1IEBAIHN0
YXRpYyBpbnQgaW14N2RfYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAtc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKGlt
eDdkX2FkY19wbV9vcHMsIGlteDdkX2FkY19kaXNhYmxlLA0KPiBpbXg3ZF9hZGNfZW5hYmxlKTsN
Cj4gK3N0YXRpYyBERUZJTkVfU0lNUExFX0RFVl9QTV9PUFMoaW14N2RfYWRjX3BtX29wcywNCj4g
aW14N2RfYWRjX2Rpc2FibGUsDQo+ICsJCQkJaW14N2RfYWRjX2VuYWJsZSk7DQo+IA0KPiAgc3Rh
dGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW14N2RfYWRjX2RyaXZlciA9IHsNCj4gIAkucHJv
YmUJCT0gaW14N2RfYWRjX3Byb2JlLA0KPiAgCS5kcml2ZXIJCT0gew0KPiAgCQkubmFtZQk9ICJp
bXg3ZF9hZGMiLA0KPiAgCQkub2ZfbWF0Y2hfdGFibGUgPSBpbXg3ZF9hZGNfbWF0Y2gsDQo+IC0J
CS5wbQk9ICZpbXg3ZF9hZGNfcG1fb3BzLA0KPiArCQkucG0JPSBwbV9zbGVlcF9wdHIoJmlteDdk
X2FkY19wbV9vcHMpLA0KPiAgCX0sDQo+ICB9Ow0KPiANCj4gLS0NCj4gMi4zNi4xDQoNCg==
