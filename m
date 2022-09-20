Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124C65BE780
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 15:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiITNr2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 09:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiITNr0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 09:47:26 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068BDB1FE
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:47:24 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KBXdoQ025096;
        Tue, 20 Sep 2022 09:46:34 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jpn469hrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 09:46:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCe5h7zQTspH8GLMPXvemL2YmhwLzbLfX+6KBWV3G9N9gq8RagpwlvbHvawFF/FxM7HAAv12Xe1yjG47h9bW+fjm8yzBtdtdk+4MTE2UaSl+c3uaLWtfPi4pO1Jpy/8HTLQ4j2zEJoITwDbpBAMVeRzoqAc4JjyFhP8DR1ef0kCNkvvMrzC9pHQo943cqehlyF1ZY7uXu7M5FB+mF/P8gIQ4iE0KJS67+g6QVdUMAcdqBIzlolFjtj7wzTkkyI+5aHsJnhDll+INS2wkXbUjkWGqoQEkufIJatEpGEQ3+fdJQ9/kQlaeDySzPsWANmjT4q35gWy3edZkMk/ZWURJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8jStzY+ympfaiOcVVk0ltCD9eHN/kybD6t2F4PI25s=;
 b=BDTpYfaVJjpALXbZFDB8PqOzn8CGsng0u7yd5nRJposX9oSkmCa9EkEPg5jRx/RCFA+EGzf20cOSVarDlV//j9qiuQHwIrctgVeb19hga+aDQLSe1Bct0a+EobwWzUQaB74x0FuHSVGAQcqeAB3pRSuvuSoRvHkYgxCgoACmHwoeNhxXwBCAMoExC++7qVVJPeQP5erulakhYuzcRHZd2wIv1OO0iUOHt7RCtLTrMH/5QDckE/jiIPwgBc70Elm43dz/be+VCzP10c1ERAsh0tdba+EPnydnJn+sgspZRHMhbOdqde02gW0/4CYtJRFdJLf6b1YZlcNFZ/JTEgc8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8jStzY+ympfaiOcVVk0ltCD9eHN/kybD6t2F4PI25s=;
 b=5l+4raxRPy1a+JlJg1D3e3aAh2G6Jebo56hWbsw/wPqq/B24YJBcm9S7j6r1bvddE8IOYpGL7wADvfFXzGzLmv0DABrLkZk//wUBuxExCWGoZH1CyO03d02TMVde8Bgll3lfc07glY3+E2m+my3EhZz4p+San4Or9jmk7uX3Gbs=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by CH2PR03MB5301.namprd03.prod.outlook.com (2603:10b6:610:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 13:46:31 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 13:46:31 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        "Regus, Ciprian" <Ciprian.Regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: RE: [PATCH 03/15] iio: adc: axp288_adc: do not use internal iio_dev
 lock
Thread-Topic: [PATCH 03/15] iio: adc: axp288_adc: do not use internal iio_dev
 lock
Thread-Index: AQHYzOQIymh9N1coy02EoQxRaaErGa3oS7kAgAAA4JCAAAXUgIAAAIsAgAAAwCA=
Date:   Tue, 20 Sep 2022 13:46:31 +0000
Message-ID: <SJ0PR03MB6778EEF81693C026CE131B49994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
 <20220920112821.975359-4-nuno.sa@analog.com>
 <CAHp75VeA48FbKy2uUjW4T19=Vn-UEznT7prkXZq4sdZ4Q9o-YA@mail.gmail.com>
 <SJ0PR03MB6778FFE254E9DDC103258FE8994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
 <CAHp75VdVbkXCC1PpT4h-+4HHpZX-zK34xH9dVG8vGcpQhXaQHQ@mail.gmail.com>
 <CAHp75VfdUOTd9tRXdTVq_prNf_T2=iQ4tEjusHC=gXDZvb3Qeg@mail.gmail.com>
In-Reply-To: <CAHp75VfdUOTd9tRXdTVq_prNf_T2=iQ4tEjusHC=gXDZvb3Qeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFlUQTVZMll5T0dNdE16aGxZUzB4TVdWa0xXSTJZakF0WW1ObU1UY3hZelEx?=
 =?utf-8?B?T0RneVhHRnRaUzEwWlhOMFhHRXdPV05tTWpobExUTTRaV0V0TVRGbFpDMWlO?=
 =?utf-8?B?bUl3TFdKalpqRTNNV00wTlRnNE1tSnZaSGt1ZEhoMElpQnplajBpTXpNd015?=
 =?utf-8?B?SWdkRDBpTVRNek1EZ3hOVFV4T0RrMk5qZzBOamMzSWlCb1BTSlhOR05KUVRk?=
 =?utf-8?B?dGNHbHVWa0ZXWkhCS2RYbEhaMVJNTmxWeWVXTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTkdjVkJXYVRrNGVsbEJXRU5ZYWswd1V6ZDFkV1pqU21WTmVs?=
 =?utf-8?B?Sk1kVFkxT0VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|CH2PR03MB5301:EE_
x-ms-office365-filtering-correlation-id: c881f870-8766-435e-0005-08da9b0e864c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASvh5CKEcnSGqbyx0Ia1kzyP0Gz0Nzy9VJhPVntvxGqT01FPouqJPTLKnJTA/sb7C0ziQsfHpI7m0yy8DclukrDqu1Abrbm+erR1f39SmMDsgcQ+0RGCxf8iyt0cTyjXCs16EcpGnjIeYtzkOfa4V2m143Be1lNu84cvntMR4KXTZQORFiKlpqvNrarhfz+XpEs0HFdVPDQN+oETaQ/pS4GAoN6nd2y+x4VNsDSxJy8/gNZTYQn2BagAzG/oIlpwl2aCaA6KzPSq6IRXjcXTHBQesixFXzKf2JwJ6VAUlENQLv41neE6factCbk0WkEaffk+t3S3eI1/xFi/LwoGKYxpGTORtGHuGEXjvj+/Ro/Ei5gEkus8Im9IyWBICwTOpnLzQicxDkEIZ+q6yerjXnlQiCjp+B0tfj3WgJM4XK7zR9Oi7Gj+XUGFFEVac46h1Hleea+XAP/64vz+2TupzBHU+uRgVXpATIoO7LPg/guV89pYsxpf1lOItw70sQ6+inzMHD1FmEEp1tEKwZL75elUESm1PkL1ntKf/gpUprCyhAnFvhCfful6xCwH0cDlAtfEEzQL2kh3j3x53U8xjf5SrYf8su/4h0oJOfX8djJg/Mm1fC8iaqGAgUGDpTfduL/yDGbrgHosSTGO3z5vgiUYRSQ7CDl0s27PEGK09goZgDu7IChVYbnrS4jZctEiUlS/HlfjEce2l2SYESCQoqWks4wTPLpW7asV0+NCampdBLW+XPSiOFslenNkwmQYmKNRhE6H2sshs8U98CCM6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199015)(2906002)(54906003)(38070700005)(7696005)(66446008)(66946007)(53546011)(41300700001)(6506007)(64756008)(55016003)(4326008)(33656002)(76116006)(8676002)(66556008)(83380400001)(6916009)(66476007)(7406005)(316002)(52536014)(7416002)(5660300002)(186003)(8936002)(71200400001)(478600001)(86362001)(38100700002)(26005)(9686003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1NBYmRCVkpiVTcvTTFlelZnQzNtT0R6TE9xQm9XU08raHNyUlcrTXlGZWlY?=
 =?utf-8?B?REU2eEJDVGxsa0RkdzdEaCt2Q05EWUNUV3hwdEVYcDlPU3hrTGM0blNKbk9n?=
 =?utf-8?B?RDUxY1ZzOGR5QldXRGVLeThJYjVjWDVxcjc1ZnlaZGNZVnhuUi9XdnBSSHRT?=
 =?utf-8?B?WFRCcE5JQ1lRQnFYOVJST3lpSlF1bTI3dXlvL3Nzc0xzMUZhS2g1b3NCRW9j?=
 =?utf-8?B?bHlwaXAwREdBYUM1NktZcGV6T3RNeHlJWDIvMFZZV3I3VVpaQURrTVdtM2Zm?=
 =?utf-8?B?dzVsMjVhQVpKemhBZmd0eHMrODBDTnk4Z3hZM0lENWVrbTZ6ejgyY2lSblBT?=
 =?utf-8?B?a0lidXRraXlSQVFFN3hXR1FLL3Rkc1ZxVElzUVdYZGw1VjFvZ2FFRWZoRFFK?=
 =?utf-8?B?aUdrbnNYa2lLYzR2bDlQaGZSang5TWlkL2tLTSs3dFRBb1R3TVFiK3ZoekF6?=
 =?utf-8?B?KysrQ2lWVHlWVFpFRkVPcHBsNVRCQkV3d0VXTHdJMldQeXpIMHU3VlEvTm5P?=
 =?utf-8?B?TU80eXBoWS81MksyczRSQlI2SHRIaklIakw5MVBncVNUK2VCM0pBNmFWVVdE?=
 =?utf-8?B?MXV4Q3hXQ1p4UkhibFlScjNPUGRSTlk2V05yV0F1M2VtRkpMU3B5MnZDbFh1?=
 =?utf-8?B?cTVld0RzSUNxNGtNbXlTT2F0cHI4dkc1QTBnczBkM1J3RkQ5c3FkWUFvTTh4?=
 =?utf-8?B?NGJEWUFDVVdBRjNSUWdDR1B2STllTjBPWC9JWUNNUkRhMjhkelR5Q0pQbGN0?=
 =?utf-8?B?eFlGOVZuamFOM2NSbCtDa1ZXd0NLRmpIeGYrNDYweWlxM2t0cWhtNkZ5WFpu?=
 =?utf-8?B?SG9kQnYwVEhSbzVpdVlHWGd5QVg0WXp2K2RPaml5TGEyVjc1NStIZW9xUTJW?=
 =?utf-8?B?dlJydjlCVUVLZlpKTk4zLzJVOGFnZFRwaXNua1AwWlFGTTF6Y1FpYW1hdTNv?=
 =?utf-8?B?b3hLZXc4NG1VZW1aOXhBTFhWemVkK0NCR21XT3VkaGQ5c3hFVFNRR2lwelhL?=
 =?utf-8?B?bDhSOGhQOXozOWtyRzA2NTYrMjRsMXBzMWcyRHE4N2t3NVcyNlQzSGI0anda?=
 =?utf-8?B?RmpSQWFYSnZIako1SlpWOHlTVmFVbGFJK3BxS1pCYWhVc0U5UC9adkxvcUVI?=
 =?utf-8?B?OExoSXEyY0ZSdHBLL2ZqWHFUblNtWVN2UktxYXJXZUN4Ky9lOUlmN0tlUVVV?=
 =?utf-8?B?SW0wQktkcXB2Z2thbEdkNFhTdnZWcHdzdVZDSWh3WFlCemtPbXNqdmw2cG9E?=
 =?utf-8?B?Mnc2azdBcVJERGk1MDNtdEtCL2FjUXMvYVRDaUhPbHNSa3hLY21wMHlxaEx2?=
 =?utf-8?B?b2lxd0pzUjNOV0ZaY25rbEVySkhDdVNjTjBHTmVIZlNYSW9VVHhnbnNMRFo4?=
 =?utf-8?B?WHJJZmpvcENvLzB3RlJ1WDllMW5vNzdUb3RETUNjL0dOYlV5ZjZqNVpMekIw?=
 =?utf-8?B?d3k3Q1haU2pGVVNGNUFHTnRSWXF5S3lUdGwrZGVjRWx6NFZYQWxZeVg5WHh2?=
 =?utf-8?B?R3BCOEZYQkxOVGNKZFJWV1JQVWZFUnJ4QmVoenRqSEJRWXRMVEtiNi9vRkhC?=
 =?utf-8?B?cVhHdThOQW9XZURlNjdrUzl4TXAvUzNlQ2Y2YWNCZWdSM1JYK2FaTEtKclhx?=
 =?utf-8?B?WlVnQlpJamIvM2hKQWtqQTZjVzlZRzZvbTVNOWNkZ2ZqaWRsQ20zelFZenZC?=
 =?utf-8?B?WXVqbTV2cFAyalNMazJkaWFHb2xPZlh3VTg4LzlyWmRRQU5DdkthbWRTaUFS?=
 =?utf-8?B?Q2dGSWRLK29IS0VPOGdkMW14bDhhcUdnWXRPV1Bad1NWRTFLeVA2bkVjSnJN?=
 =?utf-8?B?RCtwWlYxSjFjVENSby83S2F3Z2NhcWZIcTF2TW1hRkxaUDhZcys0RjFMejk0?=
 =?utf-8?B?RTFtb3hHZVF1OXFpYkZmeHdWL0R5WlE5Q1BsT1FMam1mZFFXNE9sSHlJNDcv?=
 =?utf-8?B?NnlCd2Q0dTg4MitxNWZmNWtNdnlVRTM3cWZGb3pKN3p2VlRrRm1hNEwxSGU2?=
 =?utf-8?B?WFdIeGVUalVBNmJpYUNGN1ZUaktiTS83RVJGbVBUeGFtQ2hiSFp6eGVDZ0hR?=
 =?utf-8?B?dVpybmZiWW0xcC9PdG85SWVsQVR3RXZDQzB6bEI5YXpaZzlaeWN0YnpRN29D?=
 =?utf-8?Q?RTJUH86CwZM33X0PJ4yFHxePU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c881f870-8766-435e-0005-08da9b0e864c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 13:46:31.1165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KE9wVcQ8OsDk1QnzAeN6OU7+e0P2BtdWVXlKhPE8qxcqd4OKUVQKEkekGXNc3ufBIWD20PGUsdpOfyVlloCyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5301
X-Proofpoint-ORIG-GUID: dvUnRtM8uzoL9bMdOgV4pSe0ithSwjn8
X-Proofpoint-GUID: dvUnRtM8uzoL9bMdOgV4pSe0ithSwjn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200080
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIg
MjAsIDIwMjIgMzozOSBQTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4g
Q2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtcm9ja2NoaXBA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYW1sb2dpY0BsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1pbXhAbnhwLmNvbTsgbGludXgtDQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmc7IENodW55
YW4gWmhhbmcgPHpoYW5nLmx5cmFAZ21haWwuY29tPjsgSGVubmVyaWNoLA0KPiBNaWNoYWVsIDxN
aWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgTWFydGluIEJsdW1lbnN0aW5nbA0KPiA8bWFy
dGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT47IFNhc2NoYSBIYXVlcg0KPiA8cy5oYXVl
ckBwZW5ndXRyb25peC5kZT47IENpeGkgR2VuZyA8Y2l4aS5nZW5nMUB1bmlzb2MuY29tPjsgS2V2
aW4NCj4gSGlsbWFuIDxraGlsbWFuQGJheWxpYnJlLmNvbT47IFZsYWRpbWlyIFphcG9sc2tpeSA8
dnpAbWxlaWEuY29tPjsNCj4gUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRy
b25peC5kZT47IEFsZXhhbmRydSBBcmRlbGVhbg0KPiA8YWFyZGVsZWFuQGRldmlxb24uY29tPjsg
RmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgQW5kcml5DQo+IFRyeXNobml2c2t5
eSA8YW5kcml5LnRyeXNobml2c2t5eUBvcGVuc3luZXJneS5jb20+OyBIYWlibyBDaGVuDQo+IDxo
YWliby5jaGVuQG54cC5jb20+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBIYW5z
IGRlDQo+IEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsgTWlxdWVsIFJheW5hbA0KPiA8bWlx
dWVsLnJheW5hbEBib290bGluLmNvbT47IEplcm9tZSBCcnVuZXQgPGpicnVuZXRAYmF5bGlicmUu
Y29tPjsNCj4gSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT47IEZsb3JpYW4gQm9vcg0K
PiA8Zmxvcmlhbi5ib29yQGtlcm5lbGNvbmNlcHRzLmRlPjsgUmVndXMsIENpcHJpYW4NCj4gPENp
cHJpYW4uUmVndXNAYW5hbG9nLmNvbT47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9v
LmRlPjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IE5laWwgQXJtc3Ry
b25nDQo+IDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT47IEJhb2xpbiBXYW5nDQo+IDxiYW9saW4u
d2FuZ0BsaW51eC5hbGliYWJhLmNvbT47IEp5b3RpIEJoYXlhbmEgPGpiaGF5YW5hQGdvb2dsZS5j
b20+Ow0KPiBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+OyBPcnNvbiBaaGFpIDxvcnNvbnpo
YWlAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAzLzE1XSBpaW86IGFkYzogYXhw
Mjg4X2FkYzogZG8gbm90IHVzZSBpbnRlcm5hbCBpaW9fZGV2DQo+IGxvY2sNCj4gDQo+IFtFeHRl
cm5hbF0NCj4gDQo+IE9uIFR1ZSwgU2VwIDIwLCAyMDIyIGF0IDQ6MzcgUE0gQW5keSBTaGV2Y2hl
bmtvDQo+IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToNCj4gPiBPbiBUdWUsIFNl
cCAyMCwgMjAyMiBhdCA0OjE4IFBNIFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+IHdyb3Rl
Og0KPiA+ID4gPiBPbiBUdWUsIFNlcCAyMCwgMjAyMiBhdCAyOjI4IFBNIE51bm8gU8OhIDxudW5v
LnNhQGFuYWxvZy5jb20+DQo+IHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiA+ICAgICAg
ICAgaW5mbyA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gPiA+ID4gKyAgICAgICBtdXRleF9p
bml0KCZpbmZvLT5sb2NrKTsNCj4gPiA+ID4gPiAgICAgICAgIGluZm8tPmlycSA9IHBsYXRmb3Jt
X2dldF9pcnEocGRldiwgMCk7DQo+ID4gPiA+ID4gICAgICAgICBpZiAoaW5mby0+aXJxIDwgMCkN
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIGluZm8tPmlycTsNCj4gPiA+ID4NCj4g
PiA+ID4gQ29uc2lkZXIgaW5pdGlhbGl6aW5nIGl0IGFzIGxhdGUgYXMgcG9zc2libGUsIGxpa2Ug
YWZ0ZXIgSVJRIHJldHJpZXZhbA0KPiA+ID4gPiBpbiB0aGlzIGNvbnRleHQgKG1heWJlIGV2ZW4g
ZGVlcGVyLCBidXQgbm8gY29udGV4dCBhdmFpbGFibGUpLiBEaXR0bw0KPiA+ID4gPiBmb3IgdGhl
IHJlc3Qgb2YgdGhlIHNlcmllcy4NCj4gPiA+DQo+ID4gPiBBbnkgc3BlY2lhbCByZWFzb24gZm9y
IGl0IChtYXliZSByZWxhdGVkIHRvIGxvY2tkZXAgOndvbmRlcmluZzogKSA/IEp1c3QNCj4gPiA+
IGN1cmlvdXMgYXMgSSBuZXZlciBub3RpY2VkIHN1Y2ggYSBwYXR0ZXJuIHdoZW4gaW5pdGlhbGl6
aW5nIG11dGV4ZXMuDQo+ID4NCj4gPiBZZXMuIE1pY3JvLW9wdGltaXphdGlvbiBiYXNlZCBvbiB0
aGUgcnVsZSAiZG9uJ3QgY3JlYXRlIGEgcmVzb3VyY2UgaW4NCj4gPiBjYXNlIG9mIGtub3duIGVy
cm9yIi4NCj4gPg0KPiA+IE9UT0gsIHlvdSBoYXZlIHRvIGJlIHN1cmUgdGhhdCB0aGUgbXV0ZXgg
KGFuZCBnZW5lcmFsbHkgc3BlYWtpbmcgYQ0KPiA+IGxvY2tpbmcpIHNob3VsZCBiZSBpbml0aWFs
aXplZCBlYXJseSBlbm91Z2guDQo+IA0KDQpUeXBpY2FsbHkgbm90IHJlYWxseSBuZWVkZWQgZHVy
aW5nIHByb2JlLi4uDQoNCj4gTm90ZSB0aGF0ICJtaWNybyIgaW4gdGhlIGFib3ZlIGNhbiBiZSBt
dWx0aXBsaWVkIGJ5ICdrJywgd2hlcmUgJ2snIGlzDQo+IHRoZSBhbW91bnQgb2YgZGVmZXJyZWQg
cHJvYmVzIChwcm9iYWJseSBub3QgdGhlIGNhc2UgaGVyZSwgYnV0IGFnYWluLA0KPiAiZ2VuZXJh
bGx5IHNwZWFraW5nIikuDQo+IA0KDQpXZWxsLCBJIGRvbid0IHRoaW5rICdtdXRleF9pbml0KCkn
IGRvZXMgdGhhdCBtdWNoIHRoYXQgcmVhbGx5IG1hdHRlcnMgaW4NCnRoZXNlIHBhdGNoZXMgYnV0
IG9rLCB0aGF0IHJ1bGUgaXMgaW5kZWVkIGEgZ29vZCBwcmFjdGljZSB0aGF0IHNvbWV0aW1lcw0K
bWFrZXMgYSBkaWZmZXJlbmNlLiBBbmQgc2luY2UgSSB3aWxsIGRlZmluaXRlbHkgbmVlZCBhIHYy
LCBJIGNhbiBtYWtlIHRoYXQNCmNoYW5nZS4gV2hlcmUgYXBwbGljYWJsZSwgdGhlIGJlc3QgcGxh
Y2UgaXMgcHJvYmFibHkgYmVmb3JlIHJlZ2lzdGVyaW5nIHRoZQ0KSUlPIGRldmljZS4uLg0KDQot
IE51bm8gU8OhDQo=
