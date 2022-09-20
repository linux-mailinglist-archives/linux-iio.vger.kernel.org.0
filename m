Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDEF5BE6E0
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiITNTc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiITNTa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 09:19:30 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD952127B
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:19:27 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KBVxEc006285;
        Tue, 20 Sep 2022 09:18:29 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jn835ngb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 09:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOLF4hNfwrePZ7YWdDHnxOQlxtKSR51wQLydytlvdva6bJP9wLuDSkXgQ0sGeeBs8IkrTVEcCgPjeh1ioSmq9xFDRJDlfzOrSCgxB7tQQTV1U3FPcuxbwbo1Uqvo9cYeplNjtrAFBli9woK5JitF8y8Z5byXLTNo+HKc525vViqvofn499pKLTdnS67oQ4/NxE9mNLbBV4j7FnArPcJd47st0SkTrU+Z7orLQan4vY8cM/Unh6+viLWtFaqV124Lt/2E/htIK9fk0G6sDm5r4E4jQz0pcegDZsmm9WkFqnwYyhGCMeBd5wFjFOdEsidixcMsbIAbmaRZwtD4drfClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/AZ72RX2Uj6MqZQVOeEoMfKVXMk7YkNdsxh8ASB4TY=;
 b=J6PNjr7DURt8RMi4kZBlRziQQKWCZmOdMMHmlx2/JFTpZIIgam40Ex8lWCNGIuqmHcv3ovFWbaAmciv93tUSt709zb5uSyQh5E+8OxvQjC2fQBfk9AMneBCHoYK7cAR2aTZTcFEiVc9aqMkoI5xmfcxHcOXRXyddZ4cOf4m5DnN3jRug8RY7B20p6cQi+a1koJ8kzwDDJw/Ql+CTX99aqnQUQMBxvxI2CMzPYLqW3gVycIGURmYPXuDkBneINF5f2R/90wVQU+a8OAODfgSQE/BwdTrdPoc2tX+raX6VeAWTnGa0+VDuUNug9zg6NSb6+6n8mOU6fXg/jEhIzWEQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/AZ72RX2Uj6MqZQVOeEoMfKVXMk7YkNdsxh8ASB4TY=;
 b=whw2j5G1CA6jgSByz2xhspkj7cIy7zLUyP8vBAFbE2W381fUE05VfSbg76V8MvlKIgHIHe6Xx+ZRgJcgLkzNZxHzV2BKSYYMy3GWE8IudVCgYeothqiPf+/ftiuabvMPxgD1wCvVRmsHke1Jjvw+1LnPXDXX0auVZk5838XlVXQ=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 13:18:27 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 13:18:27 +0000
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
Thread-Index: AQHYzOQIymh9N1coy02EoQxRaaErGa3oS7kAgAAA4JA=
Date:   Tue, 20 Sep 2022 13:18:26 +0000
Message-ID: <SJ0PR03MB6778FFE254E9DDC103258FE8994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
 <20220920112821.975359-4-nuno.sa@analog.com>
 <CAHp75VeA48FbKy2uUjW4T19=Vn-UEznT7prkXZq4sdZ4Q9o-YA@mail.gmail.com>
In-Reply-To: <CAHp75VeA48FbKy2uUjW4T19=Vn-UEznT7prkXZq4sdZ4Q9o-YA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFlqUTFZVFF4TWpZdE16aGxOaTB4TVdWa0xXSTJZakF0WW1ObU1UY3hZelEx?=
 =?utf-8?B?T0RneVhHRnRaUzEwWlhOMFhHSTBOV0UwTVRJNExUTTRaVFl0TVRGbFpDMWlO?=
 =?utf-8?B?bUl3TFdKalpqRTNNV00wTlRnNE1tSnZaSGt1ZEhoMElpQnplajBpTWpReU1D?=
 =?utf-8?B?SWdkRDBpTVRNek1EZ3hOVE0xTURRM09UUXpOelE1SWlCb1BTSk9WbTVMVFZW?=
 =?utf-8?B?RGMyRm1SM2xNTjJ0SllXRTJWMmxvSzNKbU5YYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSkdVbkpLTWpnNGVsbEJWbE5QTm1KMWNIbHFUMXBXU1Rkd2RU?=
 =?utf-8?B?WnVTMDAxYTBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: b4531ae4-e49e-4370-bd2e-08da9b0a9a72
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6wUTfnuiC8iHUlY7mANbIUOZIHFZRNbSp1yc6BJMiVgBzQvG5SzsN5US41IvsJ4CJJYyUQuuY3+nXOmSB85xUufp6w+niPQtEDwglDGBOr7V5qOnOSvoQ0Qw9rt8gdOVkJE9lRixcysLE9RA7daLUzyEMCN5Tc8aE41+rE9roCkcTrotRqXGJcvVRlPYhU0PIr/G9xzXM3PmSXVEbwBo4dXUITKxqoSqffzzTe7vc22Jscq+QTNwcVAUWcL7wnh4sbW6gwsnhkWx7MHWWHXmAe6HnFGUZHjp0vZkCKwJ5CcQn0odOopd6zN2RkXy1q1NKm0MTL7pu9iLHWqqi1Rf59zCdOCwr7ySnxTaHiAhrg5ktPJatZqPUpFgwnLlE7cxtzQQ4pIE0ybeaQNdpZ/SL/IEp+7CpGxmkPsSMk8yjDkK1vOPwl1OVgMYGWiMgMkkcsDMaf1yk3OGRA0EXgcHNYnjAAfaAKnJOCaJbt/cGZbBsgSrv+6ZDtCkij/DjIemdt9Bmi77DjGBWdg6uTVeXQ6ZR2j9aiurnRgFkdOirRsXSYWGsoU/gfE/yCqjEH2SowR2C/Kh3wQ4qRFdBazrusl0IuiAxCC9ejudgWAjur0OY7YjpI0HdzSHB3nS/N3xdrz8FdbH/F78wIiIg2qc3pdYVEn/jb4j+tsILvKgymkQJ7fQ8ubk5OyQjkLqz4B2EI8mRDkHGPMZSTN5FYh2KpQlYI2gcXolYn5lyLo9tVtOZ6B0dG1TsfrwiZvCfaBACkqloEiqG6EaywX8ewQUfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(53546011)(52536014)(7416002)(7406005)(5660300002)(2906002)(83380400001)(7696005)(38070700005)(316002)(41300700001)(66946007)(122000001)(186003)(38100700002)(64756008)(86362001)(66556008)(8936002)(66476007)(66446008)(9686003)(26005)(8676002)(478600001)(71200400001)(33656002)(54906003)(6916009)(6506007)(76116006)(4326008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEFZcmtRRlJBSkRMMWFWWG0rdjNNTTdvR2JIbzMzcTJhMGF1NFZnVVpraGxT?=
 =?utf-8?B?TzVyTFkwS2tQKzMvdWtkVWtzVGdyWjQ4ZXQ0aXdmL1ZaeXlrZ3oxVktKcm5v?=
 =?utf-8?B?QjdRbWRhSk9lajNHd1Y2NU12WUJiVjZPTUV3MUFCcGY5WXlLbzNtSE9YME16?=
 =?utf-8?B?L3NKR3pLdXA2YTg5TTdkQmMxcG1ySnZ6K0JCcmt5SnlrWERpVkswRVkzQklT?=
 =?utf-8?B?TS9FdzJ0cGhwcWJLYi9zRHYrTzI4WHh0aWl4TTU2VEVWVmxIb0RscnpKeUhm?=
 =?utf-8?B?QWZvNW5kOW5xS1hRb1g3MEREdTVES2k1WVBZZitodUUwMnNSdlU1dVE4TmxM?=
 =?utf-8?B?UjJaZnI2U2JTeWVGbDhXOC9BbE1FajAwbDJnOVNqK0hiSEhqYW9YRUI5Nmh5?=
 =?utf-8?B?K051NG9sT2RpSEZ5Q0oyWE50SDVwanZJckpjcS9tNDRDaWI3Y25KdzB3c0RT?=
 =?utf-8?B?bGEwL3Y3ekRDSzZIOXF3ZVlJcU14ZmZVN0VYWGFFaFRpOVhQd0N2QWt3WEhU?=
 =?utf-8?B?Q2RtRURKVy9ENU1JbGZFRlRweVZJaFRrNkE2V2dRMU1RNkNEMFIySWxPYzBG?=
 =?utf-8?B?NWxBTlR5OFY3UTVQbFJ0cTdFVXFjV25Zc2ZDZWVwUDY0MU5IQjk2azg1cjZv?=
 =?utf-8?B?cWpZWnlLWVdBQ0pzSGwycTBuMVZsc0FMVGpjcExZWmlSUDhOQ1FjSXk2MU9S?=
 =?utf-8?B?d2hYK3liY3l6SFRndm93UTVtczg3L1lHaENsYWZaUFplMTV2ZXZBR3p2Tksr?=
 =?utf-8?B?blVVRjM2REJydjFWY2N2cWFWeWo0UlJnYkhWQjJrM1VVd3VSaTNScmJIcGox?=
 =?utf-8?B?aUFiS0ZmTzh0ZXdkOVAyRTFNVVVabGttclh2MWloTWRKR0FuMHJORHJkL3dQ?=
 =?utf-8?B?Z2w4WXpEVzRJak05azF5cUp1QVN4dFVZb2hnZUlBQ1Y3WjNCYytLTkwvK1Bn?=
 =?utf-8?B?MHlYMHpIK3VNbHRWVmEwcXpEYXBVSERYcVJzSUNGZWV4U0hXSkhrdGhEZmUr?=
 =?utf-8?B?ZVRYY3VjbVBaZjZHOVRkUmdPWDAybm5HaVNaeFl3ZGZCUDdMQUJISTNoTDRa?=
 =?utf-8?B?YVNZTXU1emx6VE52VHJGTW1yVGZoRncxUGdvU1F5WVB3Q2FrcVBsNjMxUWly?=
 =?utf-8?B?M01YUUphemFiSFliTzBSQ3J2SFFONWZJa1JISnlqaDZ6dVNFMUJUaXNxYnVu?=
 =?utf-8?B?MnlSbUwzbXlnVyt0QklJZEx0cS9nelZIODAxeFFtWlVMazZIWlI1Vk9ralov?=
 =?utf-8?B?RFRGZFZ3REhhbzlscHlEclU5dFl5UVZnSldGV0pOdmQycmdHajUwNHZOYW1x?=
 =?utf-8?B?cnQwMlJqZTNRYzgyOCtPSkRNai9XUXkxbW1FZ0YxcHZ5dkdBQlo5VGIzaEVH?=
 =?utf-8?B?VDlGVnRsdEV5VjJKd0xTTitwT3pPZisvRGpjL2dSTlB1ZEltbHMzbTVmQUVF?=
 =?utf-8?B?WXVGL29GZ3Y1dTZHZkVUbEp6eFp5WmNaWDgwaFhQSVQydmxZTDlXY2tERjd1?=
 =?utf-8?B?Z25PMFc0OXFaV041eG5BWjF6d2t4ZEI2bXlOQldsSHJCZlpMT2Vod2dyV1lX?=
 =?utf-8?B?VjJjbVpKenlXREVteXdjbDJGZlFCWGVrOUhyMERQc2dBNlM1em1qanQ2MnBq?=
 =?utf-8?B?cGdEQmRJVlArVVlMWG5rcmFCekR4ZGZtT2FOellWS2ViWG5LTU92aWpVRUU0?=
 =?utf-8?B?Yjdqc1MzOHNmcHdCaDlibHJXL3puaEZmQTltUE9aSHhJN0RDL0xiQ0FwZWY5?=
 =?utf-8?B?Ri82MUZuU0E2SFFwYy9mK09Ma2pnUEVqYll6WkMwdGVJd0VrdDQ4N05UdnJi?=
 =?utf-8?B?Zm5tcy9vVnlFb29kZG1SazBUVjRxdjU2Z2EydEtDd1Nib29VbDRMRWpUQ3Vr?=
 =?utf-8?B?TmZFQjdNN1oyellaZU9Sb0hYd2ZQNlVHL0VWVjVINURITzhoMGs1UzE1TUpq?=
 =?utf-8?B?TERZR3VkSjdFeTNFN1IxY1lLSVZMYWRJSlo3MHZpOXFHTTNJZXNiMUY2R1NJ?=
 =?utf-8?B?VGVpdW5vNXd6WllwZ2VIbVE4elhBQ1ZUU24wQTFHcHhQd3RHOTVUUWpzeVB2?=
 =?utf-8?B?Mk5PUlpRUlhGc0VkdThZaytvRjlZWndWVHhUU09nK1pubTJyZW5hUU10RzQx?=
 =?utf-8?Q?ReX4Vxkbbx0NfdJbatMuxrg/b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4531ae4-e49e-4370-bd2e-08da9b0a9a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 13:18:26.9223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYbbkfnB9CZ3HfD5nEq0M9GEScRlslTMUNJNuPxvT+HZE5yMlr47n0K+vpQpZEIf/r582lBBIUUkB7EqIFzxFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
X-Proofpoint-ORIG-GUID: F2tmKtrtvzCPrTa7gYGW9piqO4Tv9613
X-Proofpoint-GUID: F2tmKtrtvzCPrTa7gYGW9piqO4Tv9613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200078
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
MjAsIDIwMjIgMzoxMyBQTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4g
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
cm5hbF0NCj4gDQo+IE9uIFR1ZSwgU2VwIDIwLCAyMDIyIGF0IDI6MjggUE0gTnVubyBTw6EgPG51
bm8uc2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgaWlvX2RldmljZSBsb2NrIGlz
IG9ubHkgbWVhbnQgZm9yIGludGVybmFsIHVzZS4gSGVuY2UgZGVmaW5lIGENCj4gPiBkZXZpY2Ug
bG9jYWwgbG9jayB0byBwcm90ZWN0IGFnYWluc3QgY29uY3VycmVudCBhY2Nlc3Nlcy4NCj4gDQo+
IC4uLg0KPiANCj4gPiAgICAgICAgIGluZm8gPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ICsg
ICAgICAgbXV0ZXhfaW5pdCgmaW5mby0+bG9jayk7DQo+ID4gICAgICAgICBpbmZvLT5pcnEgPSBw
bGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+ICAgICAgICAgaWYgKGluZm8tPmlycSA8IDAp
DQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBpbmZvLT5pcnE7DQo+IA0KPiBDb25zaWRlciBp
bml0aWFsaXppbmcgaXQgYXMgbGF0ZSBhcyBwb3NzaWJsZSwgbGlrZSBhZnRlciBJUlEgcmV0cmll
dmFsDQo+IGluIHRoaXMgY29udGV4dCAobWF5YmUgZXZlbiBkZWVwZXIsIGJ1dCBubyBjb250ZXh0
IGF2YWlsYWJsZSkuIERpdHRvDQo+IGZvciB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzLg0KDQpBbnkg
c3BlY2lhbCByZWFzb24gZm9yIGl0IChtYXliZSByZWxhdGVkIHRvIGxvY2tkZXAgOndvbmRlcmlu
ZzogKSA/IEp1c3QNCmN1cmlvdXMgYXMgSSBuZXZlciBub3RpY2VkIHN1Y2ggYSBwYXR0ZXJuIHdo
ZW4gaW5pdGlhbGl6aW5nIG11dGV4ZXMuDQoNCi0gTnVubyBTw6ENCg==
