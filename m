Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD37598036
	for <lists+linux-iio@lfdr.de>; Thu, 18 Aug 2022 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiHRIjg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Aug 2022 04:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiHRIjf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Aug 2022 04:39:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AC4B07C6;
        Thu, 18 Aug 2022 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660811974; x=1692347974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=61pZAZc8hCqNMZLP4LcRP+Cd+5dKJIe+zUE66FtVR9E=;
  b=vVr21s7C17B5tk6ZiLyW9jI4sM1J3VYCAOCB7ocwQ6WUZLjWZZ+kMy8Q
   gJxq966+jn5nrHWRGYxNqXwINU/1ae/2adm1XrYHUqmBe0HAG4df0sWOi
   uJRL5DGsbvbrlb5DhSZm9+nEhV0CQeihwmlW9588ydWVOzAgOsILiy7Cl
   MmPjEOOwbnuDmYPsugi0h68CtAVGupl3rDMYTtxxsGv/LXTQ6YOM6pSpm
   g2z38Se+J8oy8B3HVy/B6hMJJjjeUc9JQFvhpO7oO1E/Vo3Tr+vnmiLg9
   HxUquno0dto+zjRVhnR2DgcAcvL3AdEVqXutjJc598jev9COVhgeP8If7
   A==;
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="176743693"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2022 01:39:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 18 Aug 2022 01:39:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 18 Aug 2022 01:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG+EEFa8HEIai+WvV4tgdxH6DIcVnwzUQqQkpuqv6kaajSz3CjHP+TmhrMt/BAWT3IT08lWroQ8+FYlSwrQsvi/A9Uxd3WLgo8f8zU1Li0Lr/G9JAmHKrdU+ZjdJhLD/wInDfUFdGyjfieUVqXr+22ZJABfHNsAefl0Up1GFKmW9BSxmJ9JXfY3CHagBq3nFVosk+EaGb5N4nj48PzJy3CIlLEoScnIU6svXGMyb50ImAY+YWLnghw3PB0YUF9vY7gc7efioGFUOuNlNYYehUzGq8WL3rJTDc3Uw0Z9EfWJSpO+uXzQb2RMTkpyh8SB8w5ZA0LhuPzeo6CHrnB8VUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61pZAZc8hCqNMZLP4LcRP+Cd+5dKJIe+zUE66FtVR9E=;
 b=Sdvt8K8FDpAMalyHPlrJ4eHEilNqoKXgjSwm+CzSl/yFk7/8PImSiaAuU8R0CrhjGQ77rA3ZuckrHrTjcRNZ/Yvjree0w+EmRxRdW5ZziNrhT0sZmp2As2R4ZjIs7P0qLzRIl8apZ0HsobP/ZDAqIVO9P2YRGn/etqp47H+SGAIxv5MueqIaXQ+Vbhnq91UgAFBsJgUhDH4HTluaLKkZqWnIR1rQHnsymNTNG4YxOCd23YQ+G4dAI0/ckSnwsczSdfQj1a2oxSpwLczjyvlyOSxrsMTOaRAqsxpWo4vvLXvwdSUc3pd1hUkn2KsmjlntPsdU8gZJRCqMNtpUItsgMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61pZAZc8hCqNMZLP4LcRP+Cd+5dKJIe+zUE66FtVR9E=;
 b=Lbzg7OJrko9o3hA2RTzgowmuABE2urYe/ov7Qz1XXUEoREg8t0p2wMt9ovgpffot9kx1QmB2IkkFGfqc5r0DAMEOSx15DUvgHmjRFpaTh+u3D/YfoapbO8PeIyilDGmIHAYE+rrjOIp9Eafq4MsAaiqXLA+xr5Jd0KMA4XFZn8c=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 08:39:27 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::7c6d:be4a:3377:7c4a]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::7c6d:be4a:3377:7c4a%5]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 08:39:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jic23@kernel.org>
CC:     <nuno.sa@analog.com>, <openbmc@lists.ozlabs.org>,
        <linux-imx@nxp.com>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-iio@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-arm-msm@vger.kernel.org>, <gwendal@chromium.org>,
        <sravanhome@gmail.com>, <tmaimon77@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <lorenzo@kernel.org>, <festevam@gmail.com>, <shawnguo@kernel.org>,
        <olivier.moysan@foss.st.com>, <tali.perry1@gmail.com>,
        <thara.gopinath@linaro.org>, <bjorn.andersson@linaro.org>,
        <arnd@arndb.de>, <benjaminfair@google.com>,
        <Nicolas.Ferre@microchip.com>, <rafael@kernel.org>,
        <venture@google.com>, <kernel@pengutronix.de>,
        <fabrice.gasnier@foss.st.com>, <daniel.lezcano@linaro.org>,
        <bleung@chromium.org>, <yuenn@google.com>,
        <miquel.raynal@bootlin.com>, <alexandre.belloni@bootlin.com>,
        <rui.zhang@intel.com>, <linus.walleij@linaro.org>,
        <cbranchereau@gmail.com>, <cai.huoqing@linux.dev>,
        <avifishman70@gmail.com>, <Eugen.Hristev@microchip.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <lars@metafoo.de>, <andy.shevchenko@gmail.com>,
        <groeck@chromium.org>, <paul@crapouillou.net>, <agross@kernel.org>,
        <amitk@kernel.org>, <Michael.Hennerich@analog.com>,
        <haibo.chen@nxp.com>, <quic_jprakash@quicinc.com>
Subject: Re: [PATCH v3 09/15] iio: adc: at91-sama5d2_adc: convert to device
 properties
Thread-Topic: [PATCH v3 09/15] iio: adc: at91-sama5d2_adc: convert to device
 properties
Thread-Index: AQHYmmZH+bXCt9SIWESU/qLNP3LjdQ==
Date:   Thu, 18 Aug 2022 08:39:26 +0000
Message-ID: <74283196-81d9-4df5-5426-b054a0c73f82@microchip.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
 <20220715122903.332535-10-nuno.sa@analog.com>
 <ada4c2a2-e13d-77aa-f489-7cc0a063adbd@microchip.com>
 <20220806194935.383bf393@jic23-huawei>
In-Reply-To: <20220806194935.383bf393@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76f09bac-2218-4d4c-aed4-08da80f528e7
x-ms-traffictypediagnostic: SJ0PR11MB4893:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oU5lk11NBJCNL4vsVsOyY1odlX6F6HuPKBa+hF6zPsWgiqvY8EAsLz65au6MUAihqB8EplagAOy2j5ADgRjQp79rUoeCYCFAm90D4N41l+imlMPR8+Tvh0nyeGF9H+kNh+hQ0YHIsXGZLzNcvoPdEPYdRPqyBqbmnt7f1biRmGMdEIorylkkXQnfcWbeVtoSSIFJK0RDxtjYN8/IeLdit/j0NCUrb5bWMGcoMq4YtsiyRVfjOlpXSLFnIESlmWEH3T2/phmShpwWIGvjUxwGsZZu0ch3/EktKXqLibU1Kp0dy1yUJhe5GZX7wMqAN3hokrIZZQirkSdtWdFtPP1PxdKUoJgvq6Kug3zECqZkoCWoSD/iqDzXj1h9rSsua2XPD49nyzU3vnn1WJ0zeFMzlaJfayuzR9DudTvxvPTFLk5qAoHXqkamHWuLPLmymu/iIoT9eCELF+K1bYGiaxFhWbG5YnGA5Iy1LNZogYT6fkdnyXJbhJH8JrlaD7ZJ7vPH8NYGSrRI+Po/Q18LLNRaKbS7r4Vk6HK2Nb6lIpl137G2Jmy62iBrFgQtfGZxbNus4GuTto2olIW/M9SBM//PBF/Gfx0BdbGSl2q8r5PRk5FGFVxJexft99AD6al0sM/wOQKxHZtMBz92/9wl/M8729uGoLDkbSwS4Y026V9XqOPEYYezu1uKdwKb8fNm8gAxXV1oaMIKQFk2UYxTioi5esPZ/4Se0L8derEPh5bhYVfh6m1Kv4+qyoIBtp8Tw1MUangpG42MTTAj2nJrN4+ckdjhwsDS3NHFZw5mcXakXfSi5oFYAj4GMd22HjQuikrtr9xI7AnxPWTFAf8nkz9e2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(396003)(136003)(376002)(7366002)(38100700002)(122000001)(26005)(7416002)(5660300002)(6506007)(7406005)(6512007)(8936002)(478600001)(38070700005)(6486002)(86362001)(71200400001)(66476007)(76116006)(41300700001)(53546011)(83380400001)(45080400002)(4326008)(66946007)(91956017)(8676002)(2906002)(6916009)(64756008)(66556008)(31696002)(316002)(31686004)(54906003)(186003)(2616005)(36756003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm5La3NHN0VmdDVIVi9mNEhoYzJUYVliWDVHcTNJeFNTMDA5TUtrbHp0enhE?=
 =?utf-8?B?cFlLQmxvSkpKWlRYU3IzdUswRmxQYjYxSjJxdXVSaFFvNXUzT3lFOEw4T1RG?=
 =?utf-8?B?V2Q5Q1FPQ0EvQWhaRmxMeWxndVJ3VXFEOVdLZnAwSnRDVWIxT2M2aUdKcDFt?=
 =?utf-8?B?QVJJWDJUSTQwQXdsMDVEeWNuVjNYU2FDOGZvbzd4QXNsekp4bUJzeG55cUdF?=
 =?utf-8?B?NG9mQ0kweHk5K3FXd3VvcEJzQmRxVGJRbG84SlJyVjd0R0IybVh4dXFMeW5x?=
 =?utf-8?B?QnJ1cHZmYm1oM2pUU01QS2FPMGFsVXl6YzBoUVZPdDdSTHR4YnhFTW5EV1E1?=
 =?utf-8?B?SG1Jb0xTVXFDK2JQbVE2SG14MHVPaUJsNmlvMUF3SjRic1BsWC90L29BZy91?=
 =?utf-8?B?RVJOZmNmTnA3QmdjL3kwRk01QXhQTEdCbUE5bitMZTkxcmFtaEcxVGVhQ2Nt?=
 =?utf-8?B?bnV2aG53RkxCRXNrTEhReHN1aWdNdFA4cHNvaGNkV0lGNHVibEo1aGtBZENR?=
 =?utf-8?B?bElQZ0lZNUovZ1JkeDJHNEM4dUVIMFYvWmhmaG56V0hjM2xWRFlzNmhLcTRI?=
 =?utf-8?B?RnFpRnc2cWtYTjJ4VmZybEJjaHp1bnNrLzBvM2w5K3dRcTloeVBCbXRjcGVm?=
 =?utf-8?B?ZVZTbm1LVDlPUUlKMHcwbUZKa25mekN4QWRFL0FzcmYzL2phbWNSUnJtOGhN?=
 =?utf-8?B?bi9keXBMZkFQb3dMaTVRTXk0QXZGU0hSV0JZSExBSUh1cVpqVEVwdkFTSzR1?=
 =?utf-8?B?QjJUYmRxYzdOc2VMcjg5UnREamVZR2ZEUTBOZW9IanZsejc0NkE4c0hMN2Va?=
 =?utf-8?B?WXNUNzJHaEltOHhNbEVRNk54akZkRUtHNGZJbnFkQVdocWY2aE1KdDVtaUNT?=
 =?utf-8?B?RVRVKzFLNVk1aWQvOGV5QWJnYTRzWFRPQXRVNVNKOW4yQzF2dkhoZURQK08r?=
 =?utf-8?B?OWdZQXZTbnQ1RklRUFRsNXEyclRCc0NNVXEveElRdjlYWnhUVFNrcHo2T052?=
 =?utf-8?B?ZnhPa05FRWRCckVWdCtNNElBQUJhdnJvZ1U3MDBqWDZVNjJHUzUvV3NqYlo3?=
 =?utf-8?B?dHdXWkN4dWhKUU9hdzVqWE80dUQ5a2lYdm1NenFsbXdvTUpoVjg4MG1KVHBs?=
 =?utf-8?B?dU1ZTm9kdXJTM01HRVZNZ2FLTXMremYyaGZXUEoybmJiOGJHbnJBV2ZLSkpQ?=
 =?utf-8?B?NU5rZEYzOFhsaExuUzg4dXRpMkFyUlVyUC82OUVPZHR6TkpXSlFVYVExa3pa?=
 =?utf-8?B?bVVudHpoODlMdTgxL2pYclFoUktsSzBtY3E2Zm9oejM4cHdWRk9FWUtFMXM5?=
 =?utf-8?B?Vjl5RkFjUTdOVXdJbzJUTHo3SGNSZmFnUVhKTFA1VzluNDMvTXplZXIyc3c0?=
 =?utf-8?B?OWNPeWhNSkhxSjJ2MTRjeDNGcVJYdWo1bzQvSDF5VEtDS3ZNa2dLaWNBalFY?=
 =?utf-8?B?bzdYeDBQSUd1QUlHTVpSZDFBTHByWXZUNjhJaEl1aUpFY0RrM1RQRnhsWENS?=
 =?utf-8?B?aTF3VXdGcDZRSE5PUlNQOFFFMXZJQjdhOWZtWTlybDg2ekNVZ3hHelRCTU5z?=
 =?utf-8?B?NkhSV3owY3drQ3EwaDU1WFMzbmN0c0lJL3hJQXRsTW52djBxcDJIamhHR0Mx?=
 =?utf-8?B?NUo3OFA4UHQ4TGtsWTdOZ3k2UW4zeVNlM0MwREwzOFZSRGxSM0hqR0FKT0lO?=
 =?utf-8?B?MFF1SWtEekI0UDlodUR0Rm9ScFVtWGpZL2NQTkpUOWRCY3JVdEJuWmM4YzdW?=
 =?utf-8?B?YnlUZEtsNnhmcVJaRGxmTUZOWWh3YzhIa3hKYWpzV0dzam5TOHcxajFqenBh?=
 =?utf-8?B?c0F2MW5BWFhSVmpTYW1LMVh2Z2Rhb0dSb0pKeCtIUG5BN0JGaTFpSVh2YkxX?=
 =?utf-8?B?Z0IyODdJRzVJM3FVTU45Smw1QkowcVRxL2JvRzlDMlNHZVJZZ3JKdnhxOEd0?=
 =?utf-8?B?WDc0eXFoTndWNzdPZGdLU3BES0d2eDV6REhJSlNuNlRkZUxXMXFXUnlac0tU?=
 =?utf-8?B?ekhPVUM0Z2xZT1Q3OEtPcGhXUks3Uk41aStveFhMb3o4T05hb3FwUzdOeFhI?=
 =?utf-8?B?TFplbXZ1dkdkOGlxaCtZbDd3YXl6ZU4wZnVYT0I4RHNYWmgxeHF3RWZ1cXEz?=
 =?utf-8?B?SjRKNFhRUTVZQk9pbWM0WUl5dFB2cGRHV0w3MlJYNzY5bUdyc0tFUDhUQ1lJ?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC4847CF47760E4FA8D44E14338E1DE2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f09bac-2218-4d4c-aed4-08da80f528e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 08:39:26.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xM1CGubOM0Mmd8kjvzfAr0odCOB7VNKcU0nPkk949pzwvz+QhqODxDkQJ/PqRSydE7sqUxpmwfKIwChPEODaNCtrg2xRmAIVzeeBY5+LHuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4893
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMDYuMDguMjAyMiAyMTo0OSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIDE4IEp1bCAyMDIyIDA1OjIx
OjQ3ICswMDAwDQo+IDxDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+
PiBPbiAxNS4wNy4yMDIyIDE1OjI4LCBOdW5vIFPDoSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE1ha2UgdGhlIGNvbnZlcnNpb24gdG8gZmly
bXdhcmUgYWdub3N0aWMgZGV2aWNlIHByb3BlcnRpZXMuIEFzIHBhcnQgb2YNCj4+PiB0aGUgY29u
dmVyc2lvbiB0aGUgSUlPIGlua2VybiBpbnRlcmZhY2UgJ29mX3hsYXRlKCknIGlzIGFsc28gY29u
dmVydGVkIHRvDQo+Pj4gJ2Z3bm9kZV94bGF0ZSgpJy4gVGhlIGdvYWwgaXMgdG8gY29tcGxldGVs
eSBkcm9wICdvZl94bGF0ZScgYW5kIGhlbmNlIE9GDQo+Pj4gZGVwZW5kZW5jaWVzIGZyb20gSUlP
Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4N
Cj4+PiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwu
Y29tPg0KPj4NCj4+IFJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFA
bWljcm9jaGlwLmNvbT4NCj4+DQo+IA0KPiBIaSBOdW5vIC8gQ2xhdWRpdQ0KPiANCj4gTG90cyBv
ZiBmdXp6IG9uIHRoaXMgb25lIGJlY2F1c2Ugb2YgQ2xhdWRpdSdzIHNlcmllcyB0aGF0IEkgdG9v
ayB3aGlsc3QgdGhpcyB3YXMgdW5kZXIgcmV2aWV3DQo+IEkgaGF2ZW4ndCByZWFsbHkgY2hlY2tl
ZCB0aGUgcmVzdWx0IG9mIGZvcmNpbmcgaXQgaW4gYnV0IHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0
aGUNCj4gdGVzdGluZyBicmFuY2ggb2YgaWlvLmdpdCBmb3IgYW55dGhpbmcgc2lsbHkgdGhhdCBo
YXBwZW5lZC4NCg0KTG9va3MgZ29vZCB0byBtZS4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpu
ZWENCg0KPiANCj4gSm9uYXRoYW4NCj4gDQo+Pg0KPj4+IC0tLQ0KPj4+ICBkcml2ZXJzL2lpby9h
ZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIHwgMzAgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
DQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5j
IGIvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPj4+IGluZGV4IGZlMzEzMWM5
NTkzYy4uZGY3MTY1ODRjMTE3IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hdDkx
LXNhbWE1ZDJfYWRjLmMNCj4+PiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2Fk
Yy5jDQo+Pj4gQEAgLTE2LDggKzE2LDkgQEANCj4+PiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVw
dC5oPg0KPj4+ICAjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4+PiAgI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPg0KPj4+IC0jaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+Pj4gKyNpbmNsdWRl
IDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4NCj4+PiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RldmljZS5oPg0KPj4+ICsjaW5jbHVkZSA8bGludXgvcHJvcGVydHkuaD4NCj4+PiAgI2luY2x1
ZGUgPGxpbnV4L3NjaGVkLmg+DQo+Pj4gICNpbmNsdWRlIDxsaW51eC93YWl0Lmg+DQo+Pj4gICNp
bmNsdWRlIDxsaW51eC9paW8vaWlvLmg+DQo+Pj4gQEAgLTY1MCw4ICs2NTEsOCBAQCBhdDkxX2Fk
Y19jaGFuX2dldChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LCBpbnQgY2hhbikNCj4+PiAgICAg
ICAgIHJldHVybiBpbmRpb19kZXYtPmNoYW5uZWxzICsgaW5kZXg7DQo+Pj4gIH0NCj4+Pg0KPj4+
IC1zdGF0aWMgaW5saW5lIGludCBhdDkxX2FkY19vZl94bGF0ZShzdHJ1Y3QgaWlvX2RldiAqaW5k
aW9fZGV2LA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0
cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmlpb3NwZWMpDQo+Pj4gK3N0YXRpYyBpbmxpbmUgaW50IGF0
OTFfYWRjX2Z3bm9kZV94bGF0ZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgZndub2RlX3Jl
ZmVyZW5jZV9hcmdzICppaW9zcGVjKQ0KPj4+ICB7DQo+Pj4gICAgICAgICByZXR1cm4gYXQ5MV9h
ZGNfY2hhbl94bGF0ZShpbmRpb19kZXYsIGlpb3NwZWMtPmFyZ3NbMF0pOw0KPj4+ICB9DQo+Pj4g
QEAgLTE4NzYsNyArMTg3Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2luZm8gYXQ5MV9h
ZGNfaW5mbyA9IHsNCj4+PiAgICAgICAgIC5yZWFkX3JhdyA9ICZhdDkxX2FkY19yZWFkX3JhdywN
Cj4+PiAgICAgICAgIC53cml0ZV9yYXcgPSAmYXQ5MV9hZGNfd3JpdGVfcmF3LA0KPj4+ICAgICAg
ICAgLnVwZGF0ZV9zY2FuX21vZGUgPSAmYXQ5MV9hZGNfdXBkYXRlX3NjYW5fbW9kZSwNCj4+PiAt
ICAgICAgIC5vZl94bGF0ZSA9ICZhdDkxX2FkY19vZl94bGF0ZSwNCj4+PiArICAgICAgIC5md25v
ZGVfeGxhdGUgPSAmYXQ5MV9hZGNfZndub2RlX3hsYXRlLA0KPj4+ICAgICAgICAgLmh3Zmlmb19z
ZXRfd2F0ZXJtYXJrID0gJmF0OTFfYWRjX3NldF93YXRlcm1hcmssDQo+Pj4gIH07DQo+Pj4NCj4+
PiBAQCAtMTkyMCw2ICsxOTIxLDcgQEAgc3RhdGljIGludCBhdDkxX2FkY19idWZmZXJfYW5kX3Ry
aWdnZXJfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+Pj4NCj4+PiAgc3RhdGljIGludCBhdDkx
X2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICB7DQo+Pj4gKyAg
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPj4+ICAgICAgICAgc3RydWN0
IGlpb19kZXYgKmluZGlvX2RldjsNCj4+PiAgICAgICAgIHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAq
c3Q7DQo+Pj4gICAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4+PiBAQCAtMTkzMyw3ICsx
OTM1LDcgQEAgc3RhdGljIGludCBhdDkxX2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPj4+ICAgICAgICAgc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPj4+ICAgICAg
ICAgc3QtPmluZGlvX2RldiA9IGluZGlvX2RldjsNCj4+Pg0KPj4+IC0gICAgICAgc3QtPnNvY19p
bmZvLnBsYXRmb3JtID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPj4+
ICsgICAgICAgc3QtPnNvY19pbmZvLnBsYXRmb3JtID0gZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRl
dik7DQo+Pj4NCj4+PiAgICAgICAgIGluZGlvX2Rldi0+bmFtZSA9IGRldl9uYW1lKCZwZGV2LT5k
ZXYpOw0KPj4+ICAgICAgICAgaW5kaW9fZGV2LT5tb2RlcyA9IElORElPX0RJUkVDVF9NT0RFIHwg
SU5ESU9fQlVGRkVSX1NPRlRXQVJFOw0KPj4+IEBAIC0xOTUwLDM0ICsxOTUyLDMyIEBAIHN0YXRp
YyBpbnQgYXQ5MV9hZGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+Pg0K
Pj4+ICAgICAgICAgc3QtPm92ZXJzYW1wbGluZ19yYXRpbyA9IEFUOTFfT1NSXzFTQU1QTEVTOw0K
Pj4+DQo+Pj4gLSAgICAgICByZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihwZGV2LT5kZXYub2Zf
bm9kZSwNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhdG1lbCxtaW4t
c2FtcGxlLXJhdGUtaHoiLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JnN0LT5zb2NfaW5mby5taW5fc2FtcGxlX3JhdGUpOw0KPj4+ICsgICAgICAgcmV0ID0gZGV2aWNl
X3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgImF0bWVsLG1pbi1zYW1wbGUtcmF0ZS1oeiIsDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnN0LT5zb2NfaW5mby5taW5f
c2FtcGxlX3JhdGUpOw0KPj4+ICAgICAgICAgaWYgKHJldCkgew0KPj4+ICAgICAgICAgICAgICAg
ICBkZXZfZXJyKCZwZGV2LT5kZXYsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgImludmFs
aWQgb3IgbWlzc2luZyB2YWx1ZSBmb3IgYXRtZWwsbWluLXNhbXBsZS1yYXRlLWh6XG4iKTsNCj4+
PiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+PiAgICAgICAgIH0NCj4+Pg0KPj4+IC0g
ICAgICAgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIocGRldi0+ZGV2Lm9mX25vZGUsDQo+Pj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYXRtZWwsbWF4LXNhbXBsZS1yYXRl
LWh6IiwNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzdC0+c29jX2lu
Zm8ubWF4X3NhbXBsZV9yYXRlKTsNCj4+PiArICAgICAgIHJldCA9IGRldmljZV9wcm9wZXJ0eV9y
ZWFkX3UzMihkZXYsICJhdG1lbCxtYXgtc2FtcGxlLXJhdGUtaHoiLA0KPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzdC0+c29jX2luZm8ubWF4X3NhbXBsZV9yYXRl
KTsNCj4+PiAgICAgICAgIGlmIChyZXQpIHsNCj4+PiAgICAgICAgICAgICAgICAgZGV2X2Vycigm
cGRldi0+ZGV2LA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICJpbnZhbGlkIG9yIG1pc3Np
bmcgdmFsdWUgZm9yIGF0bWVsLG1heC1zYW1wbGUtcmF0ZS1oelxuIik7DQo+Pj4gICAgICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQo+Pj4gICAgICAgICB9DQo+Pj4NCj4+PiAtICAgICAgIHJldCA9
IG9mX3Byb3BlcnR5X3JlYWRfdTMyKHBkZXYtPmRldi5vZl9ub2RlLCAiYXRtZWwsc3RhcnR1cC10
aW1lLW1zIiwNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzdC0+c29j
X2luZm8uc3RhcnR1cF90aW1lKTsNCj4+PiArICAgICAgIHJldCA9IGRldmljZV9wcm9wZXJ0eV9y
ZWFkX3UzMihkZXYsICJhdG1lbCxzdGFydHVwLXRpbWUtbXMiLA0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZzdC0+c29jX2luZm8uc3RhcnR1cF90aW1lKTsNCj4+
PiAgICAgICAgIGlmIChyZXQpIHsNCj4+PiAgICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+
ZGV2LA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICJpbnZhbGlkIG9yIG1pc3NpbmcgdmFs
dWUgZm9yIGF0bWVsLHN0YXJ0dXAtdGltZS1tc1xuIik7DQo+Pj4gICAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+Pj4gICAgICAgICB9DQo+Pj4NCj4+PiAtICAgICAgIHJldCA9IG9mX3Byb3Bl
cnR5X3JlYWRfdTMyKHBkZXYtPmRldi5vZl9ub2RlLA0KPj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgImF0bWVsLHRyaWdnZXItZWRnZS10eXBlIiwgJmVkZ2VfdHlwZSk7DQo+
Pj4gKyAgICAgICByZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAiYXRtZWwsdHJp
Z2dlci1lZGdlLXR5cGUiLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZlZGdlX3R5cGUpOw0KPj4+ICAgICAgICAgaWYgKHJldCkgew0KPj4+ICAgICAgICAgICAg
ICAgICBkZXZfZGJnKCZwZGV2LT5kZXYsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgImF0
bWVsLHRyaWdnZXItZWRnZS10eXBlIG5vdCBzcGVjaWZpZWQsIG9ubHkgc29mdHdhcmUgdHJpZ2dl
ciBhdmFpbGFibGVcbiIpOw0KPj4+IC0tDQo+Pj4gMi4zNy4xDQo+Pj4NCj4+DQo+IA0KDQo=
