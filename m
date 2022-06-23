Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736935572EC
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jun 2022 08:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiFWGPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jun 2022 02:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFWGPm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jun 2022 02:15:42 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB9D3A718
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 23:15:41 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N5QKEw027917;
        Thu, 23 Jun 2022 02:14:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3gsbb7fwmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 02:14:40 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25N5lRc9018589;
        Thu, 23 Jun 2022 02:14:40 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3gsbb7fwmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 02:14:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5ibCLlMcEdh7Ol9l9bxUiO4vnQeXcSTbPNn4ZM4dZw1s/45B8F5qDUs2khGu5+QTJFN0Hb6nWE4QWoYzeH2doV9cqaV9Kj65sEqNpNFMMt5AbSOmlDC5A280tkq5+KnRirGPu/BWymzKltlwO0h6Y2h+xPzGXa+9YobC7gy7zDLdARdc7kdAohNBelRFWursNHOVpwYsrmuGnl4MQNT26F+vjEq2h2GthTbCwlCYvcOp5/hmy8pktKci+Y5qqNb24sD7DB8CExpOtzyZnp/LtwlI0cogbn1mr4ZBPw/rgDN01JyyUgcnUtuiK4FZsumnKOykAbm6IkUptivwzXfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRuol3wxfir383vMy7TS8nUKJvW5L5paNwpCsUbriqQ=;
 b=d6UStpoeVNRHk+mdJU3CIssre96k7e39DwnWe9ZjwzDNEqSqEzPK8GlTCajE5NqQ65+ZHO0AaI0mVSnmgD6KXvqIKYQ99mhOUVAshoyDfeQyjsw5qeNlL6bCRSRXDYpiwLccJ9NBGwQQoF4j8bTwVrcMaDLC8L95m9Wxc0OGNjItG9mz423HxWYQGpwuMiLNlQv2yLerNdZ8BrMQMQflktKbFir3RHjQ1jMvDCPMGVrQqZrj4ZbOmuhR6QlqXqSctqv0HENaDLtxM1Z0dSpRn9ZfaEo9Gk7TxJKVSnpjFFq1g3Qi3SOh0OVI+Yovh0TWf2FmCqh/knWeWpHRZlqWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRuol3wxfir383vMy7TS8nUKJvW5L5paNwpCsUbriqQ=;
 b=aJUjz0ODSn0w5Q67ZzPphbm+MzIaSybuDFkY+E/JMQ/3Y6kxJ6wRv8LkTixvQZ/uJOCoKGsJrdwr75l7XNDwI0lOxhiApSzXmSYHxaa+uZ2dNbgLyv1/Jrg8XHn63t6CdJiRGmMaTJoZRNKn4DUa+1/wy+YoUTBW2VKp3JIt60Y=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MN2PR03MB4991.namprd03.prod.outlook.com (2603:10b6:208:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 06:14:38 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a4ee:b745:7e51:a3e0]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a4ee:b745:7e51:a3e0%6]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 06:14:38 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
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
        Haibo Chen <haibo.chen@nxp.com>,
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
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 25/36] iio: temperature: ltc2983: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Thread-Topic: [PATCH 25/36] iio: temperature: ltc2983: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Thread-Index: AQHYhayAeNq9W1kkfUWvTDTK1RmAJ61chX8A
Date:   Thu, 23 Jun 2022 06:14:37 +0000
Message-ID: <PH0PR03MB678631FF5F87B379B229CD3B99B59@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220621202719.13644-1-jic23@kernel.org>
 <20220621202719.13644-26-jic23@kernel.org>
In-Reply-To: <20220621202719.13644-26-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFl6RTBNR1F6TUdFdFpqSmlZaTB4TVdWakxUaGlaak10Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHTXhOREJrTXpCakxXWXlZbUl0TVRGbFl5MDRZ?=
 =?utf-8?B?bVl6TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTWpFME15?=
 =?utf-8?B?SWdkRDBpTVRNek1EQTBNemcwTnpZMk9UZ3hOVFUwSWlCb1BTSXJkblZ0Vkdw?=
 =?utf-8?B?MVQzQmFXbG95VkdwMlZWRmpPRUZSUm5kTVVqZzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTjVPVnB4UkhsSllsbEJVM2d6WTNSUE1qVnpTR0ZNU0dSNU1E?=
 =?utf-8?B?ZGliWGRrYjBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVXB5YWtwSlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-ms-office365-filtering-correlation-id: 31ac9500-e1bc-4ad2-8427-08da54dfa6e5
x-ms-traffictypediagnostic: MN2PR03MB4991:EE_
x-microsoft-antispam-prvs: <MN2PR03MB4991CBB6BD93FE4BFE2311F399B59@MN2PR03MB4991.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9m6aXaGL/gQh9z+pR7l9NFbENN4QM529w6igAja3BBejVF4AYrmUpm7DWo/AVSAjWkc3Q5/TEDqh+83F1aQmz9bnck7U9qLSrZsG0Sb7TJPJpMdThtqqGHWcQIdAWyJYru3T3aNaP72AH9m4H4ZbXHQkx00nC4aiWXFfDSymECgZOElwkeuRmmOdXYWtSWpQxdfvH9upCuJFHGqr3kYE2qv8uK5ITYoRZ3tsEa0SzNjt7EqKHwbHQwILeYbYZHjqDGjDEBlk0vaiEDhEKjqnsFvzk+sWpnu5MnRnNs0S8+/Geswg4b09C+Kne5yttf/CN9W2InrCpkCT4pmmsMlv/994EqF+vBl/Fi1AwVdpqPYg+ImyBo3lO8MCqM/OlxSj+3x01zul27YkvcmGqolz2KB1N8f4Os5JPPCXsb4ZH/0X6ze9zzJbe1AbTR3/5SaMYDvc+4ZmDaZsFsQUikkw6ENtcTBxJI5vN3PH6AXIdocZcUgfdyoFAtHm155thUArA4hEGk0gyGP3panyjelGevADaAQaKMFW2uLqaQFVGH53tMZdUc+swD9Sh/7slVs0xJXApyhtojNG0z/cLfWBtVa2zYvUTv6P2fQrPRjCNsWw7NeX7kUl2JRYmkO8r4iPFa5Usr/1tKt0mzZbqEbKjWzmOzgbGeqMuvPmd6ru5e/2O3tLJW6a81F8sDEz0KCkRpkwBZ7s1U0UPwzC5dXZyNRlgiBw9lSj1/g6OuNleB1HgjezXqaQF+LhMSlRSshfQcnfvmTUZeVUAdArqQe0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(8936002)(66446008)(71200400001)(33656002)(86362001)(38100700002)(38070700005)(6506007)(54906003)(122000001)(110136005)(4326008)(52536014)(66476007)(53546011)(186003)(478600001)(7416002)(7406005)(5660300002)(66946007)(55016003)(316002)(2906002)(9686003)(66556008)(41300700001)(7696005)(76116006)(8676002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUFGQUtCb090UEYrM0E1MXJSUGV2a0ZodnRxVzN2L3B3RWJaaWd6SGQzOUUr?=
 =?utf-8?B?cEp2ME5XZlQyQlBLbk82bkdOTlhVNS9kbm9vcEIrdFljbHIyaCtoQk1Fb0Z3?=
 =?utf-8?B?ZHM2ei9DSjJFenZOYnc0bUVRSVJ1NFJPdGhMTDFzSEd6a0pPcE0xaFQxU2Rw?=
 =?utf-8?B?WUpsaFhoWkVKZ0h6MWpnU1FDV3doVnlNOGhiTmhnaUFiVndpYjZ3RkR2UWZU?=
 =?utf-8?B?NFIySnpCejV4aDFMdS9LSTAwMFNJK0o5SmlEVTB2N0pPTjB3c0paemNINTdt?=
 =?utf-8?B?Y2xwQ2ZUeUxocFRHRndrZXVsZ2VvZHZCVmFwRFBqTm9kTG1PeG44UVVTdTZN?=
 =?utf-8?B?TFJXZ3ZVUVVWa0pid21LRDlRLzB4MUdIWlpCK2ZQMExTZzhYTWRCbnF0cGJQ?=
 =?utf-8?B?WXJXS0ZsUDZ3a20rWWNNUzczUEpadDQ0cXdIOVhCVVQxbXpXcG5nY2tWVjMv?=
 =?utf-8?B?bVNMaTZsMTZOWnhtZ1FnMjNKc2VmdHl1S2FCbTdVQWFCREk5aWNOODdKMnpI?=
 =?utf-8?B?aU5KQmtXWW1lYXc2bzZXTUQyYm9SM0lLbGlYYitjUTJLeDRrSWluYjFPWU0x?=
 =?utf-8?B?MUZNOWRGcUVnTlI4eGkwU2V2UjZHM0pBWDVaRzZHUCs3YVBBYXZ6bzZhWGl5?=
 =?utf-8?B?RUQxSitET09WTmNGVk1IOTd1azdCUms5dXlJRm1CT3ZPU2xmRGowNmtTS20r?=
 =?utf-8?B?bStXSjY0Sk1ubWQwdjFZMEJzUHVkSUFTUk5oUE5TaHBOOFVrbm9PcU1VSnZL?=
 =?utf-8?B?Rm01b00vR3krL0FDQktqK3EyUEVHZUE4VmdTYW5PTXExeUpna0ZmblNjcmww?=
 =?utf-8?B?Q0hvNTlXYndrSXNnRll5Q3BaR29wR1paa1pONDNUeFdhWnhmR0tzdWh2Zm01?=
 =?utf-8?B?TkdRY1RiZVFrNFFZN28rZ0VBeXNuei9EaGtiQTZGYU9WblB6TW5jQjlNR1ZS?=
 =?utf-8?B?alFIdytVZWNMUCt5UG1UNnpuZDlpeU9ZcXl5MHQ2UGQxRzYyU1l6a3FvV1Zs?=
 =?utf-8?B?NGNxbnNkMy92MGorK2k1a1BIbjJvQThKaXZmWnlYT3VzY0FsalFtaEFuMTN5?=
 =?utf-8?B?TGNldlUrT0liN0JkQWlwRUxTbHEzWHFLSFlVWG10cnBzU3RxQ0l3RnQyZmQ2?=
 =?utf-8?B?Yk9LVXVkdE92VC9tWmY5WWkrdmNUV0pBb25Wd0tDcWl1WWswVWpUVHlrcklT?=
 =?utf-8?B?M2I1dGNhTmlNQVpzV3NxOGYyTGZ2cXRZbkh3Y2lWdEgzS281ZFc2bzZQdExY?=
 =?utf-8?B?ek1wY2ZjRDhvV1hCY1dMU0U0RHVibThWaFgvbTdSRHdNNGp4VktrQUlId0hn?=
 =?utf-8?B?LzJoRmVoTWk3VWM3Mkd2REJkd1JvbWVIL05QQ3dqR3V4ZG5pU0J5bkQwUTg5?=
 =?utf-8?B?VkxkWW4rcXVyM3QyTER1L3psbGtIUUhVb000VzZ2WDE0RXptbUJ5ZythUkh3?=
 =?utf-8?B?YnlIUDRMRTBsQ3pOVjVtZ3l5bDhCc3JZRm5uZExGTThBdUJFOVRhVHVLTU4w?=
 =?utf-8?B?UWRlcFVhU1YzYVdBdUdham5qOFdSN210MW9zaXhqRDkzeFI3TVRjYlJyNHJV?=
 =?utf-8?B?OStWU0ZlMDZ4cTJ3enZDU3pVUG9LaUNjZ0lsUzJvVVJ3Unlrd2RuUGlXa1pM?=
 =?utf-8?B?bUQ0T3B1Uk1GMXdBQmpLeDVoRlhFQlBQOFRXSGRoRFV1bVRnRndaVlZMTStn?=
 =?utf-8?B?aDBsbmMzcU5tZ3BkdlJkaG9ka0U3MDhSbk9mSlhmR0F3dXJHWWNlRmdITWM5?=
 =?utf-8?B?eThxRGtLYVBnTGIvd280WGczVnRXNXVoVnNwN2JIL01rWnludVpqQ0txVkZ5?=
 =?utf-8?B?N3dqS1E2clpmcHBPTFJ1SzFRUUNyRVlsNERXM1FxVzVXQ0prNnpPak9iY0ZO?=
 =?utf-8?B?akgyNCtDTHc4cHVFQXJjTURFYWF5MmxhcnhTaW1HTW85c201RHdTSW04Q3Rk?=
 =?utf-8?B?b3doZUVrdjlJMzB6T2JFOS8vRjRpd0tibEtLWlBNaG1uWWRYaXhpbVVuWWJH?=
 =?utf-8?B?cU1Ud1RReE5EVEpBbzh5TXJGK1JFdXEzRWxqb1g3VjNkOUdkZXJTSHBRUUdn?=
 =?utf-8?B?VlNMME9aeTk0a1BaT3NWcUFCWXl0SHFZQnBudE53T1QrVXM0QVdMUENraWtw?=
 =?utf-8?B?dGczcUZoZVJCL3labnE0SmE3U0RKVU00MkxKajdZcnBKbTA3YWZNQ2Y3WHJU?=
 =?utf-8?B?Zit0VGJKbUlnamc1MWY5R0ZCbnZsV1p5QVJBV0dDeUN5SThjejF3Ty8reUF6?=
 =?utf-8?B?OERCS3VGdlVHeVVIdXFJQmt4Ukt0SGlyRlJnakhnKzJjODd1UFBJSlJSTnc5?=
 =?utf-8?B?RDgzN2p2SS9tZlN1SVMwUXh3MXZaNTJUZkhzbzY2NXVHWlpJZUVpa3V0SFAw?=
 =?utf-8?Q?SEMVa8AQBQoFCdyjXDo8jKwTg41FiqtyDDddkLu4JhzXR?=
x-ms-exchange-antispam-messagedata-1: RUNl0K7DPxcelA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ac9500-e1bc-4ad2-8427-08da54dfa6e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 06:14:38.0377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbdMnLAdiPRICsB2LjLmsT0fudXGE0Asv10s7qSL1C+SJ8jD52KPL9feC3iHCONHKAvoDS6FRIVycYVYMic+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4991
X-Proofpoint-ORIG-GUID: eBTAS1aunuTN75Aq0RKANVw4jxea5SmK
X-Proofpoint-GUID: JBXcNQ9MamcWHcAI_pVNED8utrWhhNw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_03,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=441 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230023
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDIxLCAyMDIyIDEwOjI3IFBNDQo+IFRvOiBsaW51eC1paW9Admdlci5rZXJuZWwu
b3JnOyBQYXVsIENlcmN1ZWlsIDxwYXVsQGNyYXBvdWlsbG91Lm5ldD4NCj4gQ2M6IEFsZXhhbmRy
ZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT47IEJyaWFuIE1hc25leQ0K
PiA8bWFzbmV5YkBvbnN0YXRpb24ub3JnPjsgRGF2aWQgSGVpZGVsYmVyZyA8ZGF2aWRAaXhpdC5j
ej47IENhaQ0KPiBIdW9xaW5nIDxjYWkuaHVvcWluZ0BsaW51eC5kZXY+OyBDaHJpc3RpYW4gRWdn
ZXJzDQo+IDxjZWdnZXJzQGFycmkuZGU+OyBFbnJpYyBCYWxsZXRibyBpIFNlcnJhDQo+IDxlbnJp
Yy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tPjsgRXVnZW4gSHJpc3Rldg0KPiA8ZXVnZW4uaHJpc3Rl
dkBtaWNyb2NoaXAuY29tPjsgR3dlbmRhbCBHcmlnbm91DQo+IDxnd2VuZGFsQGNocm9taXVtLm9y
Zz47IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IEh1aQ0KPiBMaXUgPGh1aS5saXVA
bWVkaWF0ZWsuY29tPjsgSm9lIFNhbmRvbQ0KPiA8am9lLmcuc2FuZG9tQGdtYWlsLmNvbT47IElz
bWFpbCBIIC4gS29zZSA8aWhrb3NlQGdtYWlsLmNvbT47DQo+IExhcnMtUGV0ZXIgQ2xhdXNlbiA8
bGFyc0BtZXRhZm9vLmRlPjsgTGludXMgV2FsbGVpag0KPiA8bGludXMud2FsbGVpakBsaW5hcm8u
b3JnPjsgTHVkb3ZpYyBEZXNyb2NoZXMNCj4gPGx1ZG92aWMuZGVzcm9jaGVzQG1pY3JvY2hpcC5j
b20+OyBOaWNvbGFzIEZlcnJlDQo+IDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+OyBNYXJj
dXMgRm9sa2Vzc29uDQo+IDxtYXJjdXMuZm9sa2Vzc29uQGdtYWlsLmNvbT47IE1hcnRpbiBCbHVt
ZW5zdGluZ2wNCj4gPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+OyBNYXRoaWV1
IE90aGFjZWhlDQo+IDxtLm90aGFjZWhlQGdtYWlsLmNvbT47IE1pY2hhbCBTaW1layA8bWljaGFs
LnNpbWVrQHhpbGlueC5jb20+Ow0KPiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3Rs
aW4uY29tPjsgU2EsIE51bm8NCj4gPE51bm8uU2FAYW5hbG9nLmNvbT47IFBhcnRoaWJhbiBOYWxs
YXRoYW1iaSA8cG5AZGVueC5kZT47DQo+IFBoaWxpcHBlIFJleW5lcyA8dHJlbXlmckB5YWhvby5m
cj47IFBoaWxpcHBlIFNjaGVua2VyDQo+IDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT47
IFJpc2hpIEd1cHRhIDxndXB0MjFAZ21haWwuY29tPjsNCj4gUm9hbiB2YW4gRGlqayA8cm9hbkBw
cm90b25pYy5ubD47IFN0ZXBoZW4gQm95ZA0KPiA8c3dib3lkQGNocm9taXVtLm9yZz47IFRvbWFz
eiBEdXN6eW5za2kgPHRkdXN6eW5zQGdtYWlsLmNvbT47DQo+IFpoaXlvbmcgVGFvIDx6aGl5b25n
LnRhb0BtZWRpYXRlay5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxKb25hdGhhbi5DYW1lcm9u
QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAyNS8zNl0gaWlvOiB0ZW1wZXJhdHVyZTog
bHRjMjk4MzogU3dpdGNoIHRvDQo+IERFRklORV9TSU1QTEVfREVWX1BNX09QUygpIGFuZCBwbV9z
bGVlcF9wdHIoKQ0KPiANCj4gDQo+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNh
bWVyb25AaHVhd2VpLmNvbT4NCj4gDQo+IFVzaW5nIHRoZXNlIG5ld2VyIG1hY3JvcyBhbGxvd3Mg
dGhlIGNvbXBpbGVyIHRvIHJlbW92ZSB0aGUgdW51c2VkDQo+IHN0cnVjdHVyZSBhbmQgZnVuY3Rp
b25zIHdoZW4gIUNPTkZJR19QTV9TTEVFUCArIHJlbW92ZXMgdGhlDQo+IG5lZWQgdG8NCj4gbWFy
ayBwbSBmdW5jdGlvbnMgX19tYXliZV91bnVzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb25h
dGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IENjOiBOdW5vIFPD
oSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IE51bm8gU8OhIDxu
dW5vLnNhQGFuYWxvZy5jb20+DQo=
