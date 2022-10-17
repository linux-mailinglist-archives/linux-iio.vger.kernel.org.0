Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63848600DC5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 13:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJQLaS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 07:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJQLaM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 07:30:12 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138E4C2FA
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 04:30:04 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H9OwrV001862;
        Mon, 17 Oct 2022 07:27:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3k7pmbjv4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 07:27:21 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29HBRKNo003171;
        Mon, 17 Oct 2022 07:27:20 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3k7pmbjv4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 07:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdtMcCFvY4zQZu/e0D+iKrDmEJOtRDK9bu2CYMQyZTFukUIljGbGNegQVeuablAfSSksroU0DLraYa0Rm7XM8+npss1XsuUV14oDOKtNxO/EPgckkPd+PcarmODxvbpd5OH2+USS0GtN0G/MuEkBKpwOlIu7n11/ZuZd6oc1zSQbv9EDdIkwRnf64q5HvJ+AZrts3Jh+9qkt+0j+CEXaa5yYEOyrUjWQrjvf5XXm2cxckyRPXQP/MAwVp1qfpeGD3Qek+TMor2rAQhy8oxlMFrvXfytIOdQJi/OWNPiyxyKHm0iq1b7ppTBcGi2sZ1IxgCRm0Gr9lCxicAa43pzBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nChYMJsokXNvYCcyGFSE9Ru4cUwRmt2ULQQDBu1bJM8=;
 b=f8JzexDsfsjHRfsjv5QsYG+jTC2JlivfUSMERTkprzcCXLpl3zLy5CSo4P3646j31/Yhp4hb7/aveWU2cSGUaeNzdsEnC1kwq0kfXb1Qr8RPMLutfZ0zwng3pyI9AEpYnoC0F6p6OB3CnpYoe3MmNVPi2q1Pjvgno5yFb9+I9XIR/8G9kMymjL4X/xT6hISGll4/Lc05KURBuGzw9yC9cocI4OIspBEEeJ/k9G3k5YKacfDZ0Q2KcNGeJx2nOBCMHmnHwFByOBsOCllDVM0phNUBYcbo4kEG3hRivTJKqG3Zf9NZ+M+uQTAf3DdqkxsWkFGwb+f54Jb+cn3zMHWQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nChYMJsokXNvYCcyGFSE9Ru4cUwRmt2ULQQDBu1bJM8=;
 b=hKlgKXBqOY3EJAdCw+Lf9RpZbaTLbNGU/9uLL3ktekDMyWxgm2aCNNS1bA45bmthlbWRMJkKnKDd5Ug72yj9WFzUdZE5VRxjSzlWsWaR+UueyxWnQttcHLBdD7PMhSXxpx+Vi7qGsorTdJH9+kTNgJKIIRl31KmvyXyWdFTxxtw=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by CO1PR03MB5795.namprd03.prod.outlook.com (2603:10b6:303:9b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 11:27:18 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 11:27:18 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 00/14] IIO: More devm_regulator[_bulk]_get_enable() users
Thread-Topic: [PATCH 00/14] IIO: More devm_regulator[_bulk]_get_enable() users
Thread-Index: AQHY4X0YKOMfYYw5qk+gDmZJq9NrUa4Scr2A
Date:   Mon, 17 Oct 2022 11:27:18 +0000
Message-ID: <SJ0PR03MB6778419C9CE3DC0C5DF33BDF99299@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221016163409.320197-1-jic23@kernel.org>
In-Reply-To: <20221016163409.320197-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYTYyNjFlOWEtNGUwZS0xMWVkLWI2YjctYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGE2MjYxZTljLTRlMGUtMTFlZC1iNmI3LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMzk2MiIgdD0iMTMzMTA0Nzk2Mz?=
 =?iso-8859-1?Q?UyNDI3MzY5IiBoPSJtRzdNTVNCRW16OEY2ZDJEWmYwNVlWS2o4akU9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJwdFh4b0crTFlBWkNmcExrdThBVkprSitrdVM3d0JVa0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|CO1PR03MB5795:EE_
x-ms-office365-filtering-correlation-id: a7aeabca-34ab-408a-cc77-08dab0328cc9
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aWR3dHw9JHFsadzvlrLAjrYEcXplNHYKRvkfR+1Y57OEA29NvGE1SJhFiQ11ZyrrhGPT5lX0KqkAEtF7yXjB4Ehqjt5hH/cKMp89avpZuN4Tgc2pugRg+0Ed8G8Lz7LUtcy8LcEZu0oM+xJvFfQW5f7Z1oqu3RGnOrD3NAQq9Un+q17X8oh9cp7LSDSQv17NirTzFewIkk/2yttikV2JGogYyvgoU/bf2e70zl/mgiAfsdyoHDp549kCHrS4jhu+G5+vYumOPkHg/Vx3vGjqo8sNaG76W2Q2hpTSeBUQzkmQ6kIWtj8iwJeg6qYLSlBsiemcsL0MnWIDCHvyKYSnm0Ue/pm1Qw3t4a2WRGinhwUN3z4mc14K3X+Xu/mt8wIkccNvspSMlMVVHinRsNgdklb9R3zSbtcnXSEuoGSYuVm040aMLpCMnhD/N/Syt8+paf2TrxSEVo2ivOkw7eXI34DyAghFHnXjk1Us1SCGDLE5mAy56llJIX4f8cKJf6+uFdr2vLQH5rPZcO9byfkGiv5qrELxiV47gkhNzA3CY+uZnWUjxvwsVWfhBGNByii/Mkw+7VXAkiy61DJ/9Inl0L2b3Pzr81pjGjCBBrII5OUG34q6Bu72rccKoViMN6EEPY/ey6e7IlhupEyhgPSyTYb3Iji/K3cfg8h8epjn+Vf9xnV2+h38VBTmXh/pxXwEme2ZOXrH+QSTGVDEmP71OjXl/eWu3N3U/qQ7Uu3xOzFpqMp7laYQ2mhbDtiya527vDxgSPgVLTOhyEtjTlTShqbyZAtCUBMWRCjphdz9w7eAQEwi/t6j9QNR3hnI/N87hkbxnZ7F7T77Mn4QahX8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(38100700002)(478600001)(66899015)(71200400001)(38070700005)(122000001)(186003)(33656002)(316002)(8676002)(4326008)(64756008)(66446008)(66946007)(66476007)(66556008)(110136005)(54906003)(76116006)(6506007)(7696005)(5660300002)(26005)(53546011)(41300700001)(52536014)(8936002)(9686003)(7416002)(55016003)(86362001)(2906002)(83380400001)(26730200005)(19860200003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D4eaOosYmi7nKdwp5hX6DhYU78zmiJfaaGUbPow13JIyimHBPReOzBW/v/?=
 =?iso-8859-1?Q?y3R7MP1eBEXTuY7UFOlM3mJy2bvkt/9reAA15G8BjUX0vFMjUsqtX+UVeL?=
 =?iso-8859-1?Q?QGkVvQYoPC21coXRtFtpMl7Re2FNkA4YJWNMhUXMjJIDqncjn5utWqg4Uj?=
 =?iso-8859-1?Q?bxkGPTl7PUEglrdheBTTrmMheDD3WiG9N3UEdA+th0xVAZ7eGePSUr4LzC?=
 =?iso-8859-1?Q?X1sxbdAi9y6FKxHRrqdJh4C7uo8BcrRKpTA93DxRrhYjxRfNyLVhiFL9I+?=
 =?iso-8859-1?Q?vRWc5KXoxP+8H0NqY9+RUHGhq0zjg8MxoCv4jD+MU26s1wbgohurBpr64B?=
 =?iso-8859-1?Q?0kKDpXsS9+fK431vQyfZYFiC+d3KfEdYOdwmCM7LbZkXZZRSW9GlJXNj7q?=
 =?iso-8859-1?Q?19eGABuO1Sk5zZiK+GFK5UR6Wrnv/0trl+zrDHZNnuXpIC47YYwKboh00Z?=
 =?iso-8859-1?Q?r06EMvpU05KrMkjeaUb221S+NSczk6W0NdXgZA5NzrtLL2CT2apX6tVMJv?=
 =?iso-8859-1?Q?/JahsGKNGiOx85JL9JtWr5FrPug7ZOC9SoSIUI2ObnFnZAdDgpx9LToEYc?=
 =?iso-8859-1?Q?Q0LOL4EOE++phVC5/30uAWZchgZoGTjA6tx/U87L2YH7J0pk5BuptH/cZ7?=
 =?iso-8859-1?Q?59DN1TJ9y9DCFx2GTOnETEOVcqZXWXaMn1zKxOPaRvEP/AJuplyCXISpRq?=
 =?iso-8859-1?Q?aOd4fJhExDh71BfJVZOTG0daAFFyIyXy1cbGY6mTJo4z6jFNZhwkR5N6e8?=
 =?iso-8859-1?Q?oks5mal2hgajlJp/IxaTaIhRmlKotfJtxyT8g0NIipwEbzWfdA3sDlK5cn?=
 =?iso-8859-1?Q?W+6bQOJ0kqdECMt356wmsZtAHdS2dWwyYSCphtEYBngilDqIKq4GVJKljE?=
 =?iso-8859-1?Q?5mFea3ljdZOAogjJpUxOPWjHSXKxo3lrKAwtkdPnWu8Ax9JDzwQMJZYZJa?=
 =?iso-8859-1?Q?z2xCsbEkJYYL9TkfyT2HG9+D2FcjqBxG4YeGxHB/jLfo/aSnt61Bc0rZs1?=
 =?iso-8859-1?Q?aVyav2gljo9WV/9T54HGzBbtSCuBOJd6wo6X/fFxVIRiaVhEyVyoyvpqRJ?=
 =?iso-8859-1?Q?PidjTGHe17HE4cTdIaeyYewQSnV8617Fy5fF72XtyDdMCBdq9plDnmLw3o?=
 =?iso-8859-1?Q?UiQDvIe36pEbbkF/xwyam2o6CdPfY+dQuE85I+aR5f26Qz+Lz1hzW5EHfU?=
 =?iso-8859-1?Q?wzFBqXagmHvQoyFtDqT1Uxu8z5ARUOUsK3o8EV21+XnbsxPgDPzZTzUQgD?=
 =?iso-8859-1?Q?eUWOYI3mamMKb+FpapVRGEQOVRm8F8SwjxwLC0yE5Z+O77I20eAQoD0ni2?=
 =?iso-8859-1?Q?morQfHVfgmW4kvbsWbN2dSPDr7qqFUorLazbXMXoCJCIWT5hGNyxVH+Ws4?=
 =?iso-8859-1?Q?Ag3TP3dAXwWwJzX499eJ94qttOszex8LLvUqYhdpIczmdbZn6yqOb/HoHC?=
 =?iso-8859-1?Q?t0mhqIdFsbbnu4SaM4qRAUB0N/Zt9IECXIXHzGDUTRPspmCcpSGn2A/uXa?=
 =?iso-8859-1?Q?H+bu7Vpp9usR8Zzwc0CmFcr06RP78Sk7vKhCD6iGnrEL+D95xadoglU+Cc?=
 =?iso-8859-1?Q?JmXvdZf7h1oysphNMe2GG8QYCE5/0YjeMj3ficpfSC+7izz2UvA/WKfiBm?=
 =?iso-8859-1?Q?lQynkUDamZran/CULWUx5eNtdzacHArlHx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7aeabca-34ab-408a-cc77-08dab0328cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 11:27:18.2145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OOXeUHsEcxbbtG6plgQ4pD/2KKyFLp4IZ6zfTS4a2OgcjP/tdIRaG1Yip09ymhgdf2HYTzD0n4suqx/KfJXYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5795
X-Proofpoint-GUID: ZKKT6X6Yva6am6Hw9aTCCeiClFxLkUu2
X-Proofpoint-ORIG-GUID: vkrjfGsi5wReBkdeZKZlNOiBZhnLoxfU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_09,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170066
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, October 16, 2022 6:34 PM
> To: linux-iio@vger.kernel.org
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com>; Tanislav, Cosmin
> <Cosmin.Tanislav@analog.com>; Jagath Jog J <jagathjog1996@gmail.com>;
> Sean Nyekjaer <sean@geanix.com>; Dmitry Rokosov
> <DDRokosov@sberdevices.ru>; Linus Walleij <linus.walleij@linaro.org>;
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Hennerich,
> Michael <Michael.Hennerich@analog.com>; Lorenzo Bianconi
> <lorenzo@kernel.org>; Martyn Welch <martyn.welch@collabora.com>;
> Gwendal Grignou <gwendal@chromium.org>; Stephen Boyd
> <swboyd@chromium.org>; Tomasz Duszynski <tduszyns@gmail.com>;
> Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Subject: [PATCH 00/14] IIO: More devm_regulator[_bulk]_get_enable()
> users
>=20
> [External]
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Also one general devm conversion that was too easy to ignore after
> dealing with the regulators.
>=20
> These new macros allow dropping of some boilerplate.  They are not
> useful in many cases in IIO because they do not expose the
> struct regulator, however for simple drivers that just turn the power
> on at probe() they ensure that it is turned off again at remove.
>=20
> Jonathan Cameron (14):
>   iio: accel: adxl367: Use devm_regulator_bulk_get_enable()
>   iio: accel: bma400: Use devm_regulator_bulk_get_enable()
>   iio: accel: fxls8962af: Use devm_regulator_get_enable()
>   iio: accel: kxcjk-1013: Use devm_regulator_bulk_get_enable()
>   iio: accel: msa311: Use devm_regulator_get_enable()
>   iio: cdc: ad7150: Use devm_regulator_get_enable()
>   iio: st_sensors: core and lsm9ds0 switch to
>     devm_regulator_bulk_get_enable()
>   iio: frequency: ad9523: Use devm_regulator_get_enable()
>   iio: humidity: hts211: Use devm_regulator_get_enable()
>   iio: light: ltr501: Use devm_regulator_bulk_get_enable()
>   iio: light: noa1305: Use devm_regulator_get_enable()
>   iio: proximity: sx_common: Use devm_regulator_bulk_get_enable()
>   iio: pressure: ms5611: Use devm_regulator_get_enable()
>   iio: pressure: ms5611: Switch to fully devm_ managed registration.
>=20
>  drivers/iio/accel/adxl367.c                   | 28 ++------
>  drivers/iio/accel/bma400.h                    |  4 --
>  drivers/iio/accel/bma400_core.c               | 29 ++-------
>  drivers/iio/accel/fxls8962af-core.c           | 24 +------
>  drivers/iio/accel/kxcjk-1013.c                | 25 ++-----
>  drivers/iio/accel/msa311.c                    | 21 +-----
>  drivers/iio/cdc/ad7150.c                      | 18 +----
>  .../iio/common/st_sensors/st_sensors_core.c   | 39 ++---------
>  drivers/iio/frequency/ad9523.c                | 22 +------
>  drivers/iio/humidity/hts221.h                 |  2 -
>  drivers/iio/humidity/hts221_core.c            | 27 ++------
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  | 65 ++-----------------
>  drivers/iio/light/ltr501.c                    | 27 ++------
>  drivers/iio/light/noa1305.c                   | 26 +-------
>  drivers/iio/pressure/ms5611.h                 |  4 --
>  drivers/iio/pressure/ms5611_core.c            | 49 +++-----------
>  drivers/iio/pressure/ms5611_i2c.c             |  6 --
>  drivers/iio/pressure/ms5611_spi.c             |  6 --
>  drivers/iio/proximity/sx_common.c             | 23 +------
>  drivers/iio/proximity/sx_common.h             |  2 -
>  include/linux/iio/common/st_sensors.h         |  4 --
>  21 files changed, 57 insertions(+), 394 deletions(-)
>=20
> --
> 2.37.2

For all patches but patch 13/14,

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

For that one, you can add my tag after addressing Matti's comment.

- Nuno S=E1
