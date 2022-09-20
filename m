Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30495BE6D7
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 15:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiITNQi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 09:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiITNQf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 09:16:35 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD93F1C8
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:16:33 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K95cxX022643;
        Tue, 20 Sep 2022 09:15:35 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3jnav6h4hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 09:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5mfrsqqvQ1UbDNEGi/hJazcX6X3fb4PuUjFuCtNAEKaqxAR1q4Z7a06YDpcjNVInkLap86ODZy9bdqVwi8k/kb+hcBWrjJCyAMRJ7yBdlGm0K+HOzjbFSuUu1Cx7XJwEUVIc8TEKk5wFF5+cCHnLAycsHyeyHGhdYey2Ky3S8QKCq/uqul33dJBoJxj/q27IqW3ocEGBw/0tmdMkvy1ctxDu02rzEGEFv+uoDBomb4ZtJQ0kyI5xt50OJgeyR+9qeSagt8UzH/vgx6InKz2mEqvppUJM3h3qSU6TL3ZOZ+kC7E0dLunpGdx5lSeT3PFFKgBmRMUy19WFhGRulAaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jmduEM6PT1dWgHBO3qU0HsFtgw1Sm3CD2dkKvpB3r8=;
 b=U8BIlEaKtGieJx9NCOUaNaeef/BSR03ockiGzuqB/YoUFcfIhFrM3A4glgW5LkOe35Z/xQnZ2BcYJkhKvazEwAPZ6zqAwkuvyg5EOwLaqFdpTSb+1Y20XYB2q2l4gS3aBar1wrj6jXQFSPN7D6y3aVG7V34i2LJ22NBVP3vL3ARvla2uaAaNNspggfZMch3JYG5hCo4xuMQ4cGDl+fyDWocM2jwj2wRRkDQ8oaE1DOrqZdP0wD75kvtxRYmWEvAWnEsJ5h2efVMYMTbASFPycjBzbF9eNh8SuCDQq7nPKPA+6mbIYUNs63wR/gHO6rOtyUOwontUmX8jejNsbzcyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jmduEM6PT1dWgHBO3qU0HsFtgw1Sm3CD2dkKvpB3r8=;
 b=Pu1cMDbFHtJzDKF0kt9reACX4a40Z5aRk/fWqhfr/nXHZsYLLnNfmwSxSxKx+StN+lLnM6vK5hkCn4N8WTm2h1gapxXn3DZbCezfDXZ/bOfRpxhqE/0CJtOnQUO6TaJD4U4UEl6AWs80rSiCFwziNVBmzJhL2/lXOk2ibsH9rbw=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 13:15:32 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 13:15:32 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        "Regus, Ciprian" <Ciprian.Regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: RE: [PATCH 13/15] iio: health: max30100: do not use internal iio_dev
 lock
Thread-Topic: [PATCH 13/15] iio: health: max30100: do not use internal iio_dev
 lock
Thread-Index: AQHYzOQjbRUEqbyqqEWl3fSbr1pF7a3oPcCAgAACdlCAAAaNAIAAAo9Q
Date:   Tue, 20 Sep 2022 13:15:32 +0000
Message-ID: <SJ0PR03MB6778761640C55A5022F40822994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-14-nuno.sa@analog.com>
        <20220920142319.61557023@xps-13>
        <SJ0PR03MB6778FC7FD469F7C2BC7FB9DB994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
 <20220920145534.0bdd4e69@xps-13>
In-Reply-To: <20220920145534.0bdd4e69@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5HTTNZbUZpTkdRdE16aGxOaTB4TVdWa0xXSTJZakF0WW1ObU1UY3hZelEx?=
 =?utf-8?B?T0RneVhHRnRaUzEwWlhOMFhEUmpOMkpoWWpSbExUTTRaVFl0TVRGbFpDMWlO?=
 =?utf-8?B?bUl3TFdKalpqRTNNV00wTlRnNE1tSnZaSGt1ZEhoMElpQnplajBpTnpZME1D?=
 =?utf-8?B?SWdkRDBpTVRNek1EZ3hOVE16TXpBNU16RTBOamN4SWlCb1BTSTBNMlZIVEUx?=
 =?utf-8?B?UVJEWjBkWEV2TTNGT2JucE5jMVZJYTBVM1JUQTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSjJOV2hCVURnNGVsbEJVM1JxU1ZoRGVIVnRkR1pMTWsxb1kw?=
 =?utf-8?B?eEhObUV4T0VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVmcxYkRKTGQwRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|PH0PR03MB5847:EE_
x-ms-office365-filtering-correlation-id: f2721f93-13aa-4493-0331-08da9b0a328e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMnX++5w6t5jZPacuqi49VVlWJ1PMI86lUqOSnnq+lKvcXTighopJkDdYGsOQ/QbF3Omd/gI2uc+FOcHcU0+0wJqC+U3aBHFWW4sJRY82NsS4XxOD5S/1/Efyhy7g4s+D9fMclqgKKaad9o4ZEkl9OmJmMtW6EEgnE53UmewPpEGw9G2vkPxM/VjfuZFiV3PJK2hxtFw3lCOWbILmYTDJgoT3BDw3Wf5yt+X8BX1AsfChqt8Ycsa5TBlaw45+5AapG6+ng+ziFC+5SOe1HkIeoO6SBTROgVi7lvC9uThiQKn7fWlOZH0yh+mSAKcUVTDhGCsMPXgqWDB/EcuPRCCy/mYCIiQinhPPFBjN59oMBmONZCX+6ndUNFZCo5o3KXGeBw30Zv8gp9+lHoBEgK67DqJpf+40BJ8cpfok4rg0HnsApZsNEKzGNbjdIut/GRIfiIoLVUMgn6iG101wpAyF2EPRHiqfDz9kUdhROGBph5OGdzH+UIIaeOJnIb1UmNWg5qyReMc6ImYALSdBx84XVnmNmuWXUe0otN//ohacXGnNvgcqcX73wM7QJ1CijFqz76AOkZZ+2WqactQDQGdMpv+E2iEMb+znG2gvVXg4XMgulkYIF8AFvyO4jqK6fvJjiRYnRl54TuReo8InCZYf6h7JR5O3G4uXEmlVdXDrIY18oj9Az1ug+lVLDMlyD+WvzEYcUhjvcIFKANUrpfuYU94vzX58pTdYxDP+0FNaEAKXKwEaoz8O+hlsPXYIa6ahjkkKTF+zl743/TlG5sxnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(53546011)(52536014)(7416002)(7406005)(5660300002)(2906002)(83380400001)(7696005)(38070700005)(316002)(41300700001)(66946007)(122000001)(186003)(38100700002)(64756008)(86362001)(66556008)(8936002)(66476007)(66446008)(9686003)(26005)(8676002)(478600001)(71200400001)(33656002)(54906003)(6916009)(6506007)(76116006)(4326008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3hGeDR1eEFlS1YvbU5lcVh3VEE4RkFjUWtycWM4M0NyQ0VaWjlTd3RqY1lo?=
 =?utf-8?B?L21YUmZ5cHJhdmJHY05rUmlFaVpMaWgxQlI2bS8ycTNjNEZTdnFmT1l3RlR5?=
 =?utf-8?B?aWE1cDNnNU9wT1NPc2l6d24vdDU4SGVMaWFIU213c2VJL0QvMW5ETlpZWHdV?=
 =?utf-8?B?SWIrT1o3VDBzZGVZU0U2TkNxcVpPZ3VwQlZFdXpQRFI5ZzZYczVVcjRjM0xC?=
 =?utf-8?B?UGdHbEt4UnM1enM4MlJGR1B2N29PdmVFK1lla2xCSG9VcDkwOHhTSC9jeDgx?=
 =?utf-8?B?MU45eXBScDFWWXh4ajhhSFA0ZytuVUV1cDFEbzQxZjJUc3J0NzlJVnYxdWtK?=
 =?utf-8?B?M0NLOGtBNkVEMGY0TTFxV0dVLzY1amZDYmpHZ0E1WVZQV3ZDc2hkUWFybmI2?=
 =?utf-8?B?L3R5Y3RCTGk5WG9SdlZBWGdBKytSeFgvdmorQnl1NXRpTG5adHk5NDVBMXRW?=
 =?utf-8?B?Q2NzTnVJVWFUNDcyS3JlNklaclhQSWFveHorZGpJS1FidFViR2cxME85VGc0?=
 =?utf-8?B?djZWYVgvSkZpcHFPbVZhY0ltMzMyV0I3QnRnZGF1NjU1cms0dVBMeFp4V09r?=
 =?utf-8?B?Y3FUcXNDUnJKUDhwbzRyWjVUN1pZTkU4MDNDUmxBL3lEc2ZiVVBnbm0rb2Ex?=
 =?utf-8?B?Z2JZaXNDOU1KZUQ0cmJEVE1aVll2aktPczg5N3ZzUGVKTVNaU1BNTllFQ2tj?=
 =?utf-8?B?SkZQZ3pFbFdKOG9YWGdaaUhCTVZBRHJXYm4wdjhOV3h0MDVYUHZpQjJvMDNW?=
 =?utf-8?B?Qm9ja1cyaTE4UkxwbVlCeEFrUGNXUURqbEtZUFEySzh2S241SWhmWVptdldo?=
 =?utf-8?B?dEYwUGtOZGtRWC9lSDVlak54aTNCZGI3bzhtMTJsZ25UNzd1dU1CVmIxS3dS?=
 =?utf-8?B?bUtuSVRsTGRtR3lLeDFucWMrMHpXQmdNZlVHZ3hubndxSnhyMWhCd3h0REZG?=
 =?utf-8?B?SFcyaDVSakc3WlBnSGxtTy9lalQ4Ri9TMU9HaCtCU2RDUlJId3lHVEhkK1Mx?=
 =?utf-8?B?OXc0REZtcUdSaHdWQjY3YUJ6WTdKME1LVjBMaGNsZWI4Y0l6amxqaWEycmtM?=
 =?utf-8?B?MTIyS0RJaXQ5QVIvTG5GaW43SURXN3pqeUMwbWJWSUdFdDNpb3BOUVYyU2lE?=
 =?utf-8?B?RmNKRzNWZWdWbTc4RDV4VGdwRHJBbGVzMXl5clM5cVlZeXV0alhsUWZHU21j?=
 =?utf-8?B?TmVISUpSVTY4cG9GbDR3RGV0cDR0UXo2TzF4YWQ3enBJaUtBNGM2bkF1L05q?=
 =?utf-8?B?eE9IY2VaOTRmbkJDZDNuMHdoenRNMHVvZGxlRVhhbVovSTY0aDRuQ0hWcExZ?=
 =?utf-8?B?TVZSNTZjQy9XaHZFWGc3cGpRYWsxZzY4cm8vMmFhMlNMRktFOEMwbmZQaXFB?=
 =?utf-8?B?Mk8zaHJlMjRIY2N5VC92MkdMbmVpaEVqVVFxa0szek5SKzA5SWV0OVNCZkpD?=
 =?utf-8?B?YmFtSndxM0pIRUlMYmhUVkUvU2Nscm1BcEhqUjA0SUhEVzNuYXF3VlhVbXZ5?=
 =?utf-8?B?dk9LTUs3VTQzZ0ZnK1YxZFJ3N1YyWkF5TzAwWjZ6Ly9lMWI4K2N3OXZBSDB1?=
 =?utf-8?B?T2ZNcVE5OE9FS1JHczdLT3VGaDVHYmhaM2FlTVRRSkl0eDRtaURNaU5XdGVh?=
 =?utf-8?B?WjVBZTlwUXdSL1pEa09jU216aFZ2UDdvQ3krazBmS3FTbXJwcC9mRDJ2ZmNQ?=
 =?utf-8?B?Sk5hWDUveW5kTGFKR21EejBnT2xIaDJtREhkR0o2c0M0bm1TbzBYMXQ1T0Jk?=
 =?utf-8?B?eDJLMUxJS2ZvU25SV1VKSi90d3AvUU1Wbm1BVEdwZVAyUzR2VmkxV1FnaExz?=
 =?utf-8?B?Y3NoYWNlSmhHaGdONGpWZ0FwNEU2d3dzRG8yS05JUWIwWm1yWFp3aEdET1la?=
 =?utf-8?B?SkFOdDd5SnRQUVdCSEVwYWc4OVNRZ2FObEVHQ0M5MmRDTEFzdHVqSWFtcnAx?=
 =?utf-8?B?ZjQ1cEpxV0FUaE1LVk1HUitJYWFtWEIxUWhmUVYxRmJmZW1ReG9NWFZnV2FH?=
 =?utf-8?B?NWtOYUtvWGFmY3lqVkh4UTRZR01yOUlwTlpucm1PRkdmOFJoQW9xbHNtZlVR?=
 =?utf-8?B?Ly93RTUyKytLK2RMeDJ5enl3cjhiN3AveGhGVEdMQUgvSFJvNEhybHA3TVkx?=
 =?utf-8?Q?6oUB6Er6rGR268u5qVO5XdDxm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2721f93-13aa-4493-0331-08da9b0a328e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 13:15:32.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msHJpvmU40fCVKxqV2Y6I7K7426D+AF4xzKFJdKdNdNDTnXUjyxeeE3tBmKuygCvEc5io6VX9depvedS4EohXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
X-Proofpoint-ORIG-GUID: VTYtTCW0iu_5MpuwSnF6fnF_BRILC9p8
X-Proofpoint-GUID: VTYtTCW0iu_5MpuwSnF6fnF_BRILC9p8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200078
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDIw
LCAyMDIyIDI6NTYgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
OiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXJvY2tjaGlwQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWFtbG9naWNAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtaW14QG54cC5jb207IGxpbnV4LQ0KPiBpaW9Admdlci5rZXJuZWwub3JnOyBDaHVueWFu
IFpoYW5nIDx6aGFuZy5seXJhQGdtYWlsLmNvbT47IEhlbm5lcmljaCwNCj4gTWljaGFlbCA8TWlj
aGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IE1hcnRpbiBCbHVtZW5zdGluZ2wNCj4gPG1hcnRp
bi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU+OyBDaXhpIEdlbmcgPGNpeGkuZ2VuZzFAdW5pc29jLmNvbT47IEtldmlu
DQo+IEhpbG1hbiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+OyBWbGFkaW1pciBaYXBvbHNraXkgPHZ6
QG1sZWlhLmNvbT47DQo+IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9u
aXguZGU+OyBBbGV4YW5kcnUgQXJkZWxlYW4NCj4gPGFhcmRlbGVhbkBkZXZpcW9uLmNvbT47IEZh
YmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IEFuZHJpeQ0KPiBUcnlzaG5pdnNreXkg
PGFuZHJpeS50cnlzaG5pdnNreXlAb3BlbnN5bmVyZ3kuY29tPjsgSGFpYm8gQ2hlbg0KPiA8aGFp
Ym8uY2hlbkBueHAuY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgSGFucyBk
ZQ0KPiBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT47IEplcm9tZSBCcnVuZXQgPGpicnVuZXRA
YmF5bGlicmUuY29tPjsNCj4gSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT47IEZsb3Jp
YW4gQm9vcg0KPiA8Zmxvcmlhbi5ib29yQGtlcm5lbGNvbmNlcHRzLmRlPjsgUmVndXMsIENpcHJp
YW4NCj4gPENpcHJpYW4uUmVndXNAYW5hbG9nLmNvbT47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFy
c0BtZXRhZm9vLmRlPjsgQW5keQ0KPiBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwu
Y29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8amljMjNAa2VybmVsLm9yZz47IE5laWwgQXJtc3Ry
b25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT47IEJhb2xpbg0KPiBXYW5nIDxiYW9saW4ud2Fu
Z0BsaW51eC5hbGliYWJhLmNvbT47IEp5b3RpIEJoYXlhbmENCj4gPGpiaGF5YW5hQGdvb2dsZS5j
b20+OyBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+OyBPcnNvbiBaaGFpDQo+IDxvcnNvbnpo
YWlAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEzLzE1XSBpaW86IGhlYWx0aDog
bWF4MzAxMDA6IGRvIG5vdCB1c2UgaW50ZXJuYWwgaWlvX2Rldg0KPiBsb2NrDQo+IA0KPiBbRXh0
ZXJuYWxdDQo+IA0KPiBIaSBOdW5vLA0KPiANCj4gTnVuby5TYUBhbmFsb2cuY29tIHdyb3RlIG9u
IFR1ZSwgMjAgU2VwIDIwMjIgMTI6NDQ6MDggKzAwMDA6DQo+IA0KPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxA
Ym9vdGxpbi5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMjIgMjoy
MyBQTQ0KPiA+ID4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+ID4gPiBDYzog
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gcm9ja2NoaXBA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGxpbnV4LWFtbG9naWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgtaW14QG54cC5jb207IGxpbnV4LQ0KPiA+ID4gaWlvQHZnZXIua2VybmVsLm9y
ZzsgQ2h1bnlhbiBaaGFuZyA8emhhbmcubHlyYUBnbWFpbC5jb20+Ow0KPiBIZW5uZXJpY2gsDQo+
ID4gPiBNaWNoYWVsIDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgTWFydGluIEJsdW1l
bnN0aW5nbA0KPiA+ID4gPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+OyBTYXNj
aGEgSGF1ZXINCj4gPiA+IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgQ2l4aSBHZW5nIDxjaXhp
LmdlbmcxQHVuaXNvYy5jb20+OyBLZXZpbg0KPiA+ID4gSGlsbWFuIDxraGlsbWFuQGJheWxpYnJl
LmNvbT47IFZsYWRpbWlyIFphcG9sc2tpeSA8dnpAbWxlaWEuY29tPjsNCj4gPiA+IFBlbmd1dHJv
bml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBBbGV4YW5kcnUNCj4gQXJk
ZWxlYW4NCj4gPiA+IDxhYXJkZWxlYW5AZGV2aXFvbi5jb20+OyBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+Ow0KPiBBbmRyaXkNCj4gPiA+IFRyeXNobml2c2t5eSA8YW5kcml5LnRy
eXNobml2c2t5eUBvcGVuc3luZXJneS5jb20+OyBIYWlibyBDaGVuDQo+ID4gPiA8aGFpYm8uY2hl
bkBueHAuY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgSGFucyBkZQ0KPiA+
ID4gR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBKZXJvbWUgQnJ1bmV0DQo+IDxqYnJ1bmV0
QGJheWxpYnJlLmNvbT47DQo+ID4gPiBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNoLmRlPjsg
RmxvcmlhbiBCb29yDQo+ID4gPiA8Zmxvcmlhbi5ib29yQGtlcm5lbGNvbmNlcHRzLmRlPjsgUmVn
dXMsIENpcHJpYW4NCj4gPiA+IDxDaXByaWFuLlJlZ3VzQGFuYWxvZy5jb20+OyBMYXJzLVBldGVy
IENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47DQo+IEFuZHkNCj4gPiA+IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+ID4gPiA8amljMjNA
a2VybmVsLm9yZz47IE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT47IEJh
b2xpbg0KPiA+ID4gV2FuZyA8YmFvbGluLndhbmdAbGludXguYWxpYmFiYS5jb20+OyBKeW90aSBC
aGF5YW5hDQo+ID4gPiA8amJoYXlhbmFAZ29vZ2xlLmNvbT47IENoZW4tWXUgVHNhaSA8d2Vuc0Bj
c2llLm9yZz47IE9yc29uIFpoYWkNCj4gPiA+IDxvcnNvbnpoYWlAZ21haWwuY29tPg0KPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCAxMy8xNV0gaWlvOiBoZWFsdGg6IG1heDMwMTAwOiBkbyBub3Qg
dXNlIGludGVybmFsDQo+IGlpb19kZXYNCj4gPiA+IGxvY2sNCj4gPiA+DQo+ID4gPiBbRXh0ZXJu
YWxdDQo+ID4gPg0KPiA+ID4gSGkgTnVubywNCj4gPiA+DQo+ID4NCj4gPiBIaSBNaXF1ZWwsDQo+
ID4NCj4gPiBUaGFua3MgZm9yIHJldmlld2luZy4uLg0KPiA+DQo+ID4gPiBudW5vLnNhQGFuYWxv
Zy5jb20gd3JvdGUgb24gVHVlLCAyMCBTZXAgMjAyMiAxMzoyODoxOSArMDIwMDoNCj4gPiA+DQo+
ID4gPiA+IFRoZSBwYXR0ZXJuIHVzZWQgaW4gdGhpcyBkZXZpY2UgZG9lcyBub3QgcXVpdGUgZml0
IGluIHRoZQ0KPiA+ID4gPiBpaW9fZGV2aWNlX2NsYWltX2RpcmVjdF9tb2RlKCkgdHlwaWNhbCB1
c2FnZS4gSW4gdGhpcyBjYXNlLA0KPiA+ID4gPiBpaW9fYnVmZmVyX2VuYWJsZWQoKSB3YXMgYmVp
bmcgdXNlZCBub3QgdG8gcHJldmVudCB0aGUgcmF3IGFjY2VzcyBidXQNCj4gdG8NCj4gPiA+ID4g
YWxsb3cgaXQuIEhlbmNlIHRvIGdldCByaWQgb2YgdGhlICdtbG9jaycgd2UgbmVlZCB0bzoNCj4g
PiA+ID4NCj4gPiA+ID4gMS4gVXNlIGlpb19kZXZpY2VfY2xhaW1fZGlyZWN0X21vZGUoKSB0byBj
aGVjayBpZiBkaXJlY3QgbW9kZSBjYW4gYmUNCj4gPiA+ID4gY2xhaW1lZCBhbmQgaWYgd2UgY2Fu
IHJldHVybiAtRUlOVkFMIChhcyB0aGUgb3JpZ2luYWwgY29kZSk7DQo+ID4gPiA+DQo+ID4gPiA+
IDIuIE1ha2Ugc3VyZSB0aGF0IGJ1ZmZlcmluZyBpcyBub3QgZGlzYWJsZWQgd2hpbGUgZG9pbmcg
YSByYXcgcmVhZC4gRm9yDQo+ID4gPiA+IHRoYXQsIHdlIGNhbiBtYWtlIHVzZSBvZiB0aGUgbG9j
YWwgbG9jayB0aGF0IGFscmVhZHkgZXhpc3RzLg0KPiA+ID4gPg0KPiA+ID4gPiBXaGlsZSBhdCBp
dCwgZml4ZWQgYSBtaW5vciBjb2Rpbmcgc3R5bGUgY29tcGxhaW4uLi4NCj4gPiA+ID4NCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiA+ICBkcml2ZXJzL2lpby9oZWFsdGgvbWF4MzAxMDAuYyB8IDI0ICsrKysrKysr
KysrKysrKysrLS0tLS0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9oZWFsdGgvbWF4MzAxMDAuYw0KPiBiL2RyaXZlcnMvaWlvL2hlYWx0aC9tYXgzMDEwMC5j
DQo+ID4gPiA+IGluZGV4IGFkNTcxNzk2NTIyMy4uYWE0OTRjYWQ1ZGYwIDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL2lpby9oZWFsdGgvbWF4MzAxMDAuYw0KPiA+ID4gPiArKysgYi9kcml2
ZXJzL2lpby9oZWFsdGgvbWF4MzAxMDAuYw0KPiA+ID4gPiBAQCAtMTg1LDggKzE4NSwxOSBAQCBz
dGF0aWMgaW50IG1heDMwMTAwX2J1ZmZlcl9wb3N0ZW5hYmxlKHN0cnVjdA0KPiA+ID4gaWlvX2Rl
diAqaW5kaW9fZGV2KQ0KPiA+ID4gPiAgc3RhdGljIGludCBtYXgzMDEwMF9idWZmZXJfcHJlZGlz
YWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAgCXN0
cnVjdCBtYXgzMDEwMF9kYXRhICpkYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiA+ID4g
KwlpbnQgcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJLyoNCj4gPiA+ID4gKwkgKiBBcyBzdGF0
ZWQgaW4gdGhlIGNvbW1lbnQgaW4gdGhlIHJlYWRfcmF3KCkgZnVuY3Rpb24sIHRlbXBlcmF0dXJl
DQo+ID4gPiA+ICsJICogY2FuIG9ubHkgYmUgYWNxdWlyZWQgaWYgdGhlIGVuZ2luZSBpcyBydW5u
aW5nLiBBcyBzdWNoIHRoZSBtdXRleA0KPiA+ID4gPiArCSAqIGlzIHVzZWQgdG8gbWFrZSBzdXJl
IHdlIGRvIG5vdCBwb3dlciBkb3duIHdoaWxlIGRvaW5nIGENCj4gPiA+IHRlbXBlcmF0dXJlDQo+
ID4gPiA+ICsJICogcmVhZGluZy4NCj4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gKwltdXRleF9sb2Nr
KCZkYXRhLT5sb2NrKTsNCj4gPiA+ID4gKwlyZXQgPSBtYXgzMDEwMF9zZXRfcG93ZXJtb2RlKGRh
dGEsIGZhbHNlKTsNCj4gPiA+ID4gKwltdXRleF91bmxvY2soJmRhdGEtPmxvY2spOw0KPiA+ID4g
Pg0KPiA+ID4gPiAtCXJldHVybiBtYXgzMDEwMF9zZXRfcG93ZXJtb2RlKGRhdGEsIGZhbHNlKTsN
Cj4gPiA+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVyX3NldHVwX29wcyBtYXgzMDEwMF9idWZmZXJfc2V0
dXBfb3BzDQo+ID0gew0KPiA+ID4gPiBAQCAtMzg3LDE4ICszOTgsMTcgQEAgc3RhdGljIGludCBt
YXgzMDEwMF9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2Rldg0KPiA+ID4gKmluZGlvX2RldiwNCj4gPiA+
ID4gIAkJICogVGVtcGVyYXR1cmUgcmVhZGluZyBjYW4gb25seSBiZSBhY3F1aXJlZCB3aGlsZSBl
bmdpbmUNCj4gPiA+ID4gIAkJICogaXMgcnVubmluZw0KPiA+ID4gPiAgCQkgKi8NCj4gPiA+ID4g
LQkJbXV0ZXhfbG9jaygmaW5kaW9fZGV2LT5tbG9jayk7DQo+ID4gPiA+IC0NCj4gPiA+ID4gLQkJ
aWYgKCFpaW9fYnVmZmVyX2VuYWJsZWQoaW5kaW9fZGV2KSkNCj4gPiA+ID4gKwkJaWYgKCFpaW9f
ZGV2aWNlX2NsYWltX2RpcmVjdF9tb2RlKGluZGlvX2RldikpIHsNCj4gPiA+DQo+ID4gPiBJIHdv
bmRlciBpZiB0aGlzIGxpbmUgY2hhbmdlIGhlcmUgaXMgcmVhbGx5IG5lZWRlZC4gSSBhZ3JlZSB0
aGUgd2hvbGUNCj4gPiA+IGNvbnN0cnVjdGlvbiBsb29rcyBsaWtlIHdoYXQgaWlvX2RldmljZV9j
bGFpbV9kaXJlY3RfbW9kZSgpIGRvZXMgYnV0IGluDQo+ID4gPiBwcmFjdGljZSBJIGRvbid0IHNl
ZSB0aGUgcG9pbnQgb2YgYWNxdWlyaW5nIGFueSBsb2NrIGhlcmUgaWYgd2UganVzdA0KPiA+ID4g
cmVsZWFzZSBpdCBubyBtYXR0ZXIgd2hhdCBoYXBwZW5zIHJpZ2h0IGFmdGVyLg0KPiA+ID4NCj4g
Pg0KPiA+IEkgY2FuIHNlZSB0aGF0IHRoaXMgaXMgb2RkIChhdCB0aGUgdmVyeSBsZWFzdCkgYnV0
IEFGQUlLLCB0aGlzIGlzIHRoZSBvbmx5IHdheQ0KPiA+IHRvIHNhZmVseSBpbmZlciBpZiBidWZm
ZXJpbmcgaXMgZW5hYmxlZCBvciBub3QuIGlpb19idWZmZXJfZW5hYmxlZCgpIGhhcyBubw0KPiA+
IHByb3RlY3Rpb24gYWdhaW5zdCBzb21lb25lIGNvbmN1cnJlbnRseSBlbmFibGluZy9kaXNhYmxp
bmcgdGhlIGJ1ZmZlci4NCj4gDQo+IFllcywgYnV0IHRoaXMgaXMgb25seSByZWxldmFudCBpZiB5
b3Ugd2FudCB0byBpbmZlciB0aGF0IHRoZSAiYnVmZmVycw0KPiBhcmUgZW5hYmxlZCIgYW5kIGJl
IHN1cmUgdGhhdCBpdCBjYW5ub3QgYmUgb3RoZXJ3aXNlIGR1cmluZyB0aGUgbmV4dA0KPiBsaW5l
cyB1bnRpbCB5b3UgcmVsZWFzZSB0aGUgbG9jay4gQWNxdWlyaW5nIGEgbG9jaywgZG9pbmcgdGhl
IGlmIGFuZA0KPiB0aGVuIHVuY29uZGl0aW9uYWxseSByZWxlYXNpbmcgdGhlIGxvY2ssIElNSE8s
IGRvZXMgbm90IG1ha2UgYW55IHNlbnNlDQo+IChidXQgSSdtIG5vdCBhIGxvY2tpbmcgZ3VydSkg
YmVjYXVzZSB3aGVuIHlvdSBlbnRlciB0aGUgZWxzZSBjbGF1c2UsDQo+IHlvdSBhcmUgbm90IHBy
b3RlY3RlZCBhbnl3YXksIHNvIGluIGJvdGggY2FzZXMgYWxsIHRoaXMgaXMgY29tcGxldGVseQ0K
PiByYWN5Lg0KPiANCg0KQWhoIGNyYXAsIHllcyB5b3UgYXJlIHJpZ2h0Li4uIEl0IGlzIHN0aWxs
IHJhY3kgc2luY2Ugd2UgY2FuIHN0aWxsIHRyeSB0byByZWFkDQp0aGUgdGVtcGVyYXR1cmUgd2l0
aCB0aGUgZGV2aWNlIHBvd2VyZWQgb2ZmLiBJJ20gbm90IHJlYWxseSBzdXJlIGhvdyB0bw0KYWRk
cmVzcyB0aGlzLiBPbmUgd2F5IGNvdWxkIGJlIHRvIGp1c3QgdXNlIGFuIGludGVybmFsIGNvbnRy
b2wgdmFyaWFibGUNCnRvIHJlZmxlY3QgdGhlIGRldmljZSBwb3dlciBzdGF0ZSAoc2V0L2NsZWFy
IG9uIHRoZSBidWZmZXIgY2FsbGJhY2tzKSBhbmQNCm9ubHkgdXNlIHRoZSBsb2NhbCBsb2NrIChj
b21wbGV0ZWx5IGRpdGNoaW5nIHRoZSBjYWxsIHRvDQppaW9fZGV2aWNlX2NsYWltX2RpcmVjdF9t
b2RlKCkpLi4uDQoNCk90aGVyIG9wdGlvbnMgd291bGQgYmUgdG8gaGF2ZSBoZWxwZXJzIGZvciBh
Y3F1aXJpbmcvcmVsZWFzaW5nIHRoZSBsb2NrDQooSSB0aGluayB0aGlzIHdvdWxkIGRlZmVhdCB0
aGUgaWRlYSBvZiBub3QgYWJ1c2luZyB0aGlzIGxvY2sgYXQgYWxsKSBvciBoYXZlDQpBIHZlcnNp
b24gIGlpb19kZXZpY2VfY2xhaW1fZGlyZWN0X21vZGUoKSB0aGF0IGRvZXMgbm90IHJlbGVhc2Ug
dGhlIA0KbG9jayBpbiBjYXNlIGJ1ZmZlcmluZyBpcyBlbmFibGVkLiBBbnkgcHJlZmVyZW5jZT8N
Cg0KLSBOdW5vIFPDoQ0K
