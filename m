Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8435BE625
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiITMpN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 08:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiITMpL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 08:45:11 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55446647E1
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 05:45:10 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K9t3Z2021307;
        Tue, 20 Sep 2022 08:44:11 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3jn80asmm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 08:44:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEWTtnlF4PGYjUFeUVlk/DCdCEy0Ql8MXhc8Gnfc2jlLOpJ+FvuNm3XmTkWeWjRYkQ42CWhqUDly3pS/cBZ4XXEYNqVHqBrMcCpXirt50AuiMpi1Q8+wXe/WzeC1jUN+fj6xOe7F3w/usUTz9gLadVwZXfNrjHFvPF31WL+XlcKvIxcT8+Tx0E2fRyFHhiluEGK6z2RZMtMDx7OWwef0jZFg6XqhUDnTB/pvwvp6Cq3oJUCka9QKkW50IZL39w/6Kl47IyrfME9YADXlArsBAmd59fsL3mIY1VKVcLVUtuNkcbWx5cKQKVXnN8MTRb58rDwlCpAq4ojTpPmA10eiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS1fw0FLmfMIyQkbBuGF2eu2/JjsKZKP6VW4/24+sDA=;
 b=i1iiq37jI1XIG5BeguhMJYcUdwgKGy/cS9WHtp07Zx1tQo6WIeQ2pkQtP0zaY8VXVcyxkqxFfU+vTUDkhftbUAKhg3Cool2p4AGRZw5Wyp6XWWxewfnwP83RGBJM5pAmbGG2yGqJ+WnY7UzWGxYEa4jgSiROafiLt+ft9VmYeNvE5yz/h2JceK5D9aipY8cw4j8HLsUQofaUMUn0EdSLlL6EzjyUOJC1efjb6+azLH6fTDR2+Jv+4V1jMOFp3l2smS3jNeMAwXm+SER7td7dz+iVZmUTMv3dBf381g8jDkbyIQgkjf5uP7Usvjs0XL8bTl6bVLdHDe6wvaV+ni+vgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS1fw0FLmfMIyQkbBuGF2eu2/JjsKZKP6VW4/24+sDA=;
 b=ULwW7U9Vd+oXyGb3bv8YYNElklCtq4WBwVH3YxgKgSMHnLLjztl6WT3i5weUTcT57ORwiU4Y4rMfKP4R6g6ILhJE93iZLLixm3ODskt+WowAblh1dMsb4BQ2dD1W9qs8Y0ZKrwvA+1m8l9AnV+ThhS3yFOrrJpmimjNIvtElwMk=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by MN2PR03MB5230.namprd03.prod.outlook.com (2603:10b6:208:1f1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 12:44:08 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 12:44:08 +0000
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
Thread-Index: AQHYzOQjbRUEqbyqqEWl3fSbr1pF7a3oPcCAgAACdlA=
Date:   Tue, 20 Sep 2022 12:44:08 +0000
Message-ID: <SJ0PR03MB6778FC7FD469F7C2BC7FB9DB994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-14-nuno.sa@analog.com>
 <20220920142319.61557023@xps-13>
In-Reply-To: <20220920142319.61557023@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpUaGxaVFEwTlRrdE16aGxNUzB4TVdWa0xXSTJZakF0WW1ObU1UY3hZelEx?=
 =?utf-8?B?T0RneVhHRnRaUzEwWlhOMFhHVTRaV1UwTkRWaExUTTRaVEV0TVRGbFpDMWlO?=
 =?utf-8?B?bUl3TFdKalpqRTNNV00wTlRnNE1tSnZaSGt1ZEhoMElpQnplajBpTkRrM055?=
 =?utf-8?B?SWdkRDBpTVRNek1EZ3hOVEUwTkRVNE9UWTNPVFE0SWlCb1BTSkplWGxoYkZS?=
 =?utf-8?B?MFEzSmhWa1l5YTFFemQyMWxVWEpKWjNveWQyODlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTk5Zak1yY2pkemVsbEJVMHBDTUc1UFdEaEtWa0ZKYTBoVFl6?=
 =?utf-8?B?Vm1kMnhWUVVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|MN2PR03MB5230:EE_
x-ms-office365-filtering-correlation-id: 6fac1830-b85f-4b3a-e36c-08da9b05cf7a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PidDnrIOxhgwVfu7+F2LmGagjd/7ZAk+E3pPiGaxwXmycPVyn4FccR9/EvyeiKIRiVsfW5aYd7e4YVtajs4LmFLdmkPcKJLArdIQbNcoYNO8ZoZT7FIAsnx/Z8eXZRaMWD3ZOpaWQTkGs3LRQPD+lLQq+suJlLFNoJVef6oTY3XV3ornjoQZYnRnL2vCUt0ee2BoPCKPx7bnUiJBoA34FyzJznZi0Qg7lwcAgxknimU7lGqE5uQvdLlziCxtaJmgQlPeyHqA+jBSZ2aSARAPTPrTxHrpPhiV9bWbnbRflFWN1Ucw3TVD5UDzLis/fthDAJ6Qq/Od6MiHgE22LUJGkz1ZmM5GAM+hj+caYwMUxjk1GV4LgA+JpRP38fJ9uUXsQ9hvT7L9Ltxk0K7A9ZD6Zxt13braoUOiRQSV7WkcLMH25+6kMSjEkHfvICRPriYXxv1Zrn9y0eATHr7xhdnTjfpjxq8AdEBf5xgp+UAPlKakPso/pp4t5Mv7lazzr51rF0x1yqYmfCh8zwhy3ZkV4OMjy6Puq0MOMiSjzJZcw04d14b+k361x6iomkgF+0O6zCEPwxyXH79wyixCjUjG0KgLjc/4Bna5gzscEoBrtwDqcBP0AV48TS3slPVeM/2D3YPwUl0AtJjCKiV+yr8yszxMaO5LnUFIKsfEJxFr4LsMY+TckOHgmgdUw2SoWFVp//ekpH9zvkIGTWBDDVVd15OL0JQB3qnhXSkqhRIZ0Soh16J7/tt+BVqbmmsAQJ0o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(9686003)(53546011)(478600001)(6506007)(26005)(7696005)(71200400001)(6916009)(38100700002)(122000001)(8676002)(316002)(33656002)(86362001)(38070700005)(55016003)(83380400001)(186003)(8936002)(66446008)(66476007)(2906002)(76116006)(7406005)(52536014)(54906003)(66556008)(66946007)(41300700001)(5660300002)(64756008)(4326008)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkpnREl4WGVDMGpvUGZUNGpHOWU4YUswU2lqZVRaaWcwOVJxenlPR1NRZVZs?=
 =?utf-8?B?cmdiNWIwMzJCblZXVUYvM3cva1E4R21QbG56VHkrdi9ybkEzK3dRd0UwR09r?=
 =?utf-8?B?MnFWbnhBYmJQdUtQWHVFL2tWK2p6d0lUL20yQTAyMEQ0dHRoM2hIQkxZUEdm?=
 =?utf-8?B?ZkZBWVdpSmtVcjRFK0tNc3dEZXkzcjcxb25pTmpCRXVjd1dxRlJPUzdtUzBX?=
 =?utf-8?B?bDFRRHIwU2dnRDRqblJydlVIWSt6MlcxVnFURGNCdUFTcGpsU25kSmJGR0Fw?=
 =?utf-8?B?Q2xoT3ErTytVQVl1VmpjV1Ztelp0SndOZzBqMS9YNEpRNkFyUE1ucTZkM0hR?=
 =?utf-8?B?S0haZEpOcmY5VGdpUWdKQ2tXL01FR2trbmNTMmZpZkZMSnk2c1lERzBYMXkx?=
 =?utf-8?B?SjJtZyttbGVhQVlOUEhSN3NoS3diNmU4R1pCSzN0dXNGMGlTTEhFTGFMRnJ1?=
 =?utf-8?B?RzV4NzFvcm1maUpFTEpPWnlONnh5bUFxTzlJVVZJd1BRYWNtZU83cXo5QzhI?=
 =?utf-8?B?aVhhbWlmZFU4WTZEeDJHUG5TWlFUODNtZ3lEVzQzZm1RUjNPNHZ5cHFsZlR5?=
 =?utf-8?B?MDMybTBmMzhvdWp6UWpTSktQa21BYjBoaEQ4bkV5N29yWjB3TDFPaXFlZWhl?=
 =?utf-8?B?VlhSbU9MV2lMcEFhRVB3TmV6UzNLY3dsc1dFRjl4dnVpZStaYm9HVzZGZk1M?=
 =?utf-8?B?TWptbVFDTWN2L0VKWmdYenZXNUtKNExNTC9IL0U0cVQ0bEhVVEdkbjBzRTZC?=
 =?utf-8?B?VjIvcHI5L2JCN1ZESFcrYWxUUzA2ckdKVVZBSEs5Szh6dGw0b3ptdWw1T2dV?=
 =?utf-8?B?bDREd3NOYWx4dGRXSW9qWTNHbDJPY1BZMGNaNWR2ZHhtc2VHdTlKUVB3SUhB?=
 =?utf-8?B?RGZSdGRqeXlRb2JMRjRGVDFNdk13NTMrbjNLRHkzQ2FHZkpYdHc2WWxaeHFy?=
 =?utf-8?B?V1Q4OFJrM2toOVJnNml0WkYzTURoMWdkUGxKaXdHMGd1OVVvM0lDaU5SOXhG?=
 =?utf-8?B?bUpOMEFZbjFQbVpJK3VpelBSZUd4WE83VE4yd3BzU01zMUhZSGhjUGdGSXNl?=
 =?utf-8?B?SVNWS3FLcWZnN2dVYVcwOWFySFFpWXdXZFg3V3hqSWlZSFpnZXJzcFE2Qy8v?=
 =?utf-8?B?bVExQUFjNDZLVFAzeDdITEJwZUEvNjFxaGJISktOeG42eDV1QWR1RlhjVmt3?=
 =?utf-8?B?VEJqb2RSMzIxQTJXWW9rUVQ0R203WXJRelRxWld2Ui9xUlNtc0lJcVdHY1hH?=
 =?utf-8?B?MWFkTTRDVVh5c3hxWE9ZamZvbGFvUTY5WGNKRUtFSFdLTTZtcnZsOVpac05D?=
 =?utf-8?B?ZnZVcEIxczllMXdpVVJhMXVYY25vcExRZVRyUHBaVCs4all2T1cxeVhscVBW?=
 =?utf-8?B?WHp1d2gzNmxkTlVOSmZZVDAzNWJxczd2YnV1YzYyR0ZGOEkyZ01QNDVyUnpi?=
 =?utf-8?B?RXlGc2VZUXZqODhYbzZPZStQYUFDais3eDIxcmdCaTkyZUNiSjdaWmNjNWNC?=
 =?utf-8?B?eDd1c2w5OGhMUEdHbFFMczVqTUVDMm1YYllhQ2FQZ1FVTk1hV3dRWlllYUdu?=
 =?utf-8?B?aUNzRnIwTEkxL1oyVGFtZGdjSWYxZjF2YkFGdWM0Wk9YNEtZMG5ObnhhcUcx?=
 =?utf-8?B?cm41RFJjOUZiLzE3QUozUGtsbFArMGpSK1MrSmtkbzRESFBzSGhaeWdtQzV2?=
 =?utf-8?B?R3M0UDdyYVI4c0djdzdYbFdJTVhSOTZkMzQ2eUgyME9EK1JHeDNsQ1Y2MWkr?=
 =?utf-8?B?WVNHWGl5M1BHY2xpaVA3bXBERTZzTEYxV0xTYWFKRTM1dFVFRFBCOVY5b080?=
 =?utf-8?B?eHg3bHNqdGpYRElSOGlNLzdtQitoQXFUZVQ2SnJ3UTBxQm5aMjRyY0p0d1gv?=
 =?utf-8?B?WWpjajQ1dzZQWk5YL2dzTm95NkV3cU5UdnUzcHRQbFIrZU1aakkrMnVnRitn?=
 =?utf-8?B?dFprcTdFclB6RGVVbUc1ZlZrT2VOcDBhNmcvMVN2aENneEQ0YWMybHdyaGVl?=
 =?utf-8?B?SGFtWkhVaHliMlgxYzlPZVRrZzJKbkFPS1NLTU5UNzcvanRCMzVmcTdXZURM?=
 =?utf-8?B?bGZHTmhmckRpdlRhVzdGNVl6QzBkYjRmOFpVR29QcGdoMHJ0aENiZlVqS1NJ?=
 =?utf-8?Q?AktrPecikcyyFGDPO3ey6NZxL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fac1830-b85f-4b3a-e36c-08da9b05cf7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 12:44:08.4113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xMAp3I7XZw42Kqc1LooVAXho/5GZPa3h0O8M8HfF+3zQZpixvrcI03X8upYD3BKbDiGDCRi/oPI+HfmFNaNSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5230
X-Proofpoint-GUID: M2jtE-r0cVjDgNO1lL89FxRJM7lLDldl
X-Proofpoint-ORIG-GUID: M2jtE-r0cVjDgNO1lL89FxRJM7lLDldl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200075
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
LCAyMDIyIDI6MjMgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
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
ZXJuYWxdDQo+IA0KPiBIaSBOdW5vLA0KPiANCg0KSGkgTWlxdWVsLA0KDQpUaGFua3MgZm9yIHJl
dmlld2luZy4uLg0KDQo+IG51bm8uc2FAYW5hbG9nLmNvbSB3cm90ZSBvbiBUdWUsIDIwIFNlcCAy
MDIyIDEzOjI4OjE5ICswMjAwOg0KPiANCj4gPiBUaGUgcGF0dGVybiB1c2VkIGluIHRoaXMgZGV2
aWNlIGRvZXMgbm90IHF1aXRlIGZpdCBpbiB0aGUNCj4gPiBpaW9fZGV2aWNlX2NsYWltX2RpcmVj
dF9tb2RlKCkgdHlwaWNhbCB1c2FnZS4gSW4gdGhpcyBjYXNlLA0KPiA+IGlpb19idWZmZXJfZW5h
YmxlZCgpIHdhcyBiZWluZyB1c2VkIG5vdCB0byBwcmV2ZW50IHRoZSByYXcgYWNjZXNzIGJ1dCB0
bw0KPiA+IGFsbG93IGl0LiBIZW5jZSB0byBnZXQgcmlkIG9mIHRoZSAnbWxvY2snIHdlIG5lZWQg
dG86DQo+ID4NCj4gPiAxLiBVc2UgaWlvX2RldmljZV9jbGFpbV9kaXJlY3RfbW9kZSgpIHRvIGNo
ZWNrIGlmIGRpcmVjdCBtb2RlIGNhbiBiZQ0KPiA+IGNsYWltZWQgYW5kIGlmIHdlIGNhbiByZXR1
cm4gLUVJTlZBTCAoYXMgdGhlIG9yaWdpbmFsIGNvZGUpOw0KPiA+DQo+ID4gMi4gTWFrZSBzdXJl
IHRoYXQgYnVmZmVyaW5nIGlzIG5vdCBkaXNhYmxlZCB3aGlsZSBkb2luZyBhIHJhdyByZWFkLiBG
b3INCj4gPiB0aGF0LCB3ZSBjYW4gbWFrZSB1c2Ugb2YgdGhlIGxvY2FsIGxvY2sgdGhhdCBhbHJl
YWR5IGV4aXN0cy4NCj4gPg0KPiA+IFdoaWxlIGF0IGl0LCBmaXhlZCBhIG1pbm9yIGNvZGluZyBz
dHlsZSBjb21wbGFpbi4uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8u
c2FAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vaGVhbHRoL21heDMwMTAw
LmMgfCAyNCArKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vaGVhbHRoL21heDMwMTAwLmMgYi9kcml2ZXJzL2lpby9oZWFsdGgvbWF4MzAxMDAu
Yw0KPiA+IGluZGV4IGFkNTcxNzk2NTIyMy4uYWE0OTRjYWQ1ZGYwIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvaWlvL2hlYWx0aC9tYXgzMDEwMC5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vaGVh
bHRoL21heDMwMTAwLmMNCj4gPiBAQCAtMTg1LDggKzE4NSwxOSBAQCBzdGF0aWMgaW50IG1heDMw
MTAwX2J1ZmZlcl9wb3N0ZW5hYmxlKHN0cnVjdA0KPiBpaW9fZGV2ICppbmRpb19kZXYpDQo+ID4g
IHN0YXRpYyBpbnQgbWF4MzAxMDBfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldikNCj4gPiAgew0KPiA+ICAJc3RydWN0IG1heDMwMTAwX2RhdGEgKmRhdGEgPSBpaW9f
cHJpdihpbmRpb19kZXYpOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJ
ICogQXMgc3RhdGVkIGluIHRoZSBjb21tZW50IGluIHRoZSByZWFkX3JhdygpIGZ1bmN0aW9uLCB0
ZW1wZXJhdHVyZQ0KPiA+ICsJICogY2FuIG9ubHkgYmUgYWNxdWlyZWQgaWYgdGhlIGVuZ2luZSBp
cyBydW5uaW5nLiBBcyBzdWNoIHRoZSBtdXRleA0KPiA+ICsJICogaXMgdXNlZCB0byBtYWtlIHN1
cmUgd2UgZG8gbm90IHBvd2VyIGRvd24gd2hpbGUgZG9pbmcgYQ0KPiB0ZW1wZXJhdHVyZQ0KPiA+
ICsJICogcmVhZGluZy4NCj4gPiArCSAqLw0KPiA+ICsJbXV0ZXhfbG9jaygmZGF0YS0+bG9jayk7
DQo+ID4gKwlyZXQgPSBtYXgzMDEwMF9zZXRfcG93ZXJtb2RlKGRhdGEsIGZhbHNlKTsNCj4gPiAr
CW11dGV4X3VubG9jaygmZGF0YS0+bG9jayk7DQo+ID4NCj4gPiAtCXJldHVybiBtYXgzMDEwMF9z
ZXRfcG93ZXJtb2RlKGRhdGEsIGZhbHNlKTsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gIH0NCj4g
Pg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3BzIG1heDMwMTAw
X2J1ZmZlcl9zZXR1cF9vcHMgPSB7DQo+ID4gQEAgLTM4NywxOCArMzk4LDE3IEBAIHN0YXRpYyBp
bnQgbWF4MzAxMDBfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwNCj4gPiAg
CQkgKiBUZW1wZXJhdHVyZSByZWFkaW5nIGNhbiBvbmx5IGJlIGFjcXVpcmVkIHdoaWxlIGVuZ2lu
ZQ0KPiA+ICAJCSAqIGlzIHJ1bm5pbmcNCj4gPiAgCQkgKi8NCj4gPiAtCQltdXRleF9sb2NrKCZp
bmRpb19kZXYtPm1sb2NrKTsNCj4gPiAtDQo+ID4gLQkJaWYgKCFpaW9fYnVmZmVyX2VuYWJsZWQo
aW5kaW9fZGV2KSkNCj4gPiArCQlpZiAoIWlpb19kZXZpY2VfY2xhaW1fZGlyZWN0X21vZGUoaW5k
aW9fZGV2KSkgew0KPiANCj4gSSB3b25kZXIgaWYgdGhpcyBsaW5lIGNoYW5nZSBoZXJlIGlzIHJl
YWxseSBuZWVkZWQuIEkgYWdyZWUgdGhlIHdob2xlDQo+IGNvbnN0cnVjdGlvbiBsb29rcyBsaWtl
IHdoYXQgaWlvX2RldmljZV9jbGFpbV9kaXJlY3RfbW9kZSgpIGRvZXMgYnV0IGluDQo+IHByYWN0
aWNlIEkgZG9uJ3Qgc2VlIHRoZSBwb2ludCBvZiBhY3F1aXJpbmcgYW55IGxvY2sgaGVyZSBpZiB3
ZSBqdXN0DQo+IHJlbGVhc2UgaXQgbm8gbWF0dGVyIHdoYXQgaGFwcGVucyByaWdodCBhZnRlci4N
Cj4gDQoNCkkgY2FuIHNlZSB0aGF0IHRoaXMgaXMgb2RkIChhdCB0aGUgdmVyeSBsZWFzdCkgYnV0
IEFGQUlLLCB0aGlzIGlzIHRoZSBvbmx5IHdheQ0KdG8gc2FmZWx5IGluZmVyIGlmIGJ1ZmZlcmlu
ZyBpcyBlbmFibGVkIG9yIG5vdC4gaWlvX2J1ZmZlcl9lbmFibGVkKCkgaGFzIG5vDQpwcm90ZWN0
aW9uIGFnYWluc3Qgc29tZW9uZSBjb25jdXJyZW50bHkgZW5hYmxpbmcvZGlzYWJsaW5nIHRoZSBi
dWZmZXIuDQpTbyB0aGUgY2FsbCBpcyBuZWVkZWQgdG8gbWFrZSBzdXJlICdtbG9jaycgaXMgaW50
ZXJuYWxseSBncmFiYmVkIGJlZm9yZQ0KY2FsbGluZyBpaW9fYnVmZmVyX2VuYWJsZWQoKS4NCg0K
PiBVbmxlc3Mgb2YgY291cnNlIGlmIHRoZXJlIGlzIGEgaGlkZGVuIGdvYWwgbGlrZSAic3RvcCBl
eHBvcnRpbmcNCj4gaWlvX2J1ZmZlcl9lbmFibGVkKCkiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQu
DQo+IA0KPiBBdCBsZWFzdCBJIHdvdWxkIHNlcGFyYXRlIHRoaXMgZnJvbSB0aGUgbWFpbiBjaGFu
Z2Ugd2hpY2ggdGFyZ2V0cyB0aGUNCj4gcmVtb3ZhbCBvZiBtbG9jayBiZWNhdXNlIEkgZG9uJ3Qg
c2VlIGhvdyBpdCBpcyBkaXJlY3RseSByZWxhdGVkLg0KDQpJbiBhIHNlbnNlIGJvdGggY2hhbmdl
cyBhcmUgbmVlZGVkIHRvIHVsdGltYXRlbHkgZ2V0IHJpZCBvZiBtbG9jay4gSSdtIA0KYWxzbyBu
b3Qgc3VyZSBob3cgY291bGQgSSBkbyB0aGUgc2VwYXJhdGlvbi4uLiBEbyB5b3UgaGF2ZSBzb21l
dGhpbmcNCmluIG1pbmQ/DQoNCi0gTnVubyBTw6ENCg==
