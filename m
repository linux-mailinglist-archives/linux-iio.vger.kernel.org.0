Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426A27A1217
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 01:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjINX7J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 19:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjINX7I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 19:59:08 -0400
X-Greylist: delayed 813 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 16:59:04 PDT
Received: from mx0c-0054df01.pphosted.com (mx0c-0054df01.pphosted.com [67.231.159.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01B6269D
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 16:59:04 -0700 (PDT)
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EKXVNi021257;
        Thu, 14 Sep 2023 19:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=selector2; bh=QaYdDofVvjtOkgUoEOm+Hxav0VOMpWXIXblgaOMUts8=; b=
        qznxZmI6/EPdNZy6Y6WcSpiqPlVV2WblVSLyA2Bl+q+Bx+7fTfFqvnH++uhC9iYA
        EbnumTMRNd6p9txQrEWY+8is8C5MB5wI7OiqRbh0DW/FGu74RFivF8d7uy6nygfi
        jfMnujcBQEAxuSSIxgCoFFkV8P+xS173YnXG0edE4godSMuNQwjsgAYu6dRs8a+/
        Su54uJYvkf5a3D5Y3zFQEm0VkLTyk20gkzu7pY0Aa0yE7DWW1YLDQ78Ivwz/Cvts
        63LS+WJNHY75FqMCXYlf6OnjGvhfpv2jJEXzqrbLlfsLEX5fd6IZ64UmfJzNFBbc
        DOCUjrXxXJsU+Gh5GK+ZWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=selector1; bh=QaYdDofVvjtOkgUoEOm+Hxav0VOMpWXIXblgaOMUts8=; b=
        ZiR6+b9OlE2/GsSw7rAFeiaTlRLh2O9hVYLlf5If9+/Qm1PV0eiGA4bUfF9tktes
        ctzVIZl9qgnVHWzfg1Fzn5Ieuu4ILgrX/iSJDI4uCQrleipb87imjLsJKiLJB9oA
        KxNTFmLvGO9BgwceKcN397+nFTmM+TETzD1e+3uu6oc3QLKMHguzLqWBMClLCgvf
        UBEFd4Rdh9HNGNtr3XFZbz3ETAN/ZHQBBq711gqzaf6GE0m2CAmWEK1C0WGI/w0H
        qDe0iMH6Q2mhIPlCmYvKlzDj5oBb8Y8aMpY18ENzGpFHiBZrU3rtrTQAnmPkuns9
        GBjpa+oQWb55eaziLMKLcg==
Received: from can01-yqb-obe.outbound.protection.outlook.com (mail-yqbcan01lp2235.outbound.protection.outlook.com [104.47.75.235])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3t2y8v2kt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 19:45:04 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpC/H2betTft+K+RQYOM/yk0ryLnejFIbseHJrRmVMdG9o/46UUL8yGa+kVxrBEhd4SSfFbLewWskyE/yFoDJDS4JQ76s65Td+dhhGm/pKwJJPdqiHBEewVHA8nZNmLe2JUou7jwUlXPvPxSlQ0OQwcuOL42p+ErriYXhXr/6paWS1NIbLBtfFHko1RwoTOfirHm64J5E0gzhax6wAXeeVLS4e3nBaBls2eK8IqSAWiCivSC31HtZcFPYaaRXbFgw1wZUiw4uhK1CDaartH454zLPapj6JfcdeHsoJd9VMunCB/m2mYivNB11ac12EKpPF7VKShmfK6CavmPgRixnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaYdDofVvjtOkgUoEOm+Hxav0VOMpWXIXblgaOMUts8=;
 b=cPn+X2bv96S201wPxuqBk7ip7cPpNA9S2RuBxfkfH4Qc0gi1BEdvp8MXmON8OlbW+daF4NE5BmjiubYDyN8tqw67HQt5jMe/8FiEH03px5choKqh4hjgyXI6CpqPjMp04sED2LMV0HsKFiYplPhfLZOOaeG/PpcaWsHmBLFZpELFgG7LkQO65RuGM6HFaRZAAZ5fnODbKBC4DW7EXwOQxSgZkBJyNKUg7xZraf5Qf3B9IU7/K+GqrMtsw/aJKL1OIK7LIDkxWua7o4Nmtb8VbEYZzd6N0pH5eioziDEx6LDCli8D4oK288f1G/urgs45qe0CR2dsPlr6k21kNNjizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YT2PR01MB6642.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 23:45:02 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec%3]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 23:45:02 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "michal.simek@amd.com" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: xilinx-xadc: Don't clobber preset
 voltage/temperature thresholds
Thread-Topic: [PATCH 1/2] iio: adc: xilinx-xadc: Don't clobber preset
 voltage/temperature thresholds
Thread-Index: AQHZ51Hmy93igAb85U+3DP3X13bIOrAa/FEA
Date:   Thu, 14 Sep 2023 23:45:02 +0000
Message-ID: <aaf5b4e3e5a87e8beee5218cd73ed018135f28a3.camel@calian.com>
References: <20230914212432.2842010-1-robert.hancock@calian.com>
         <20230914212432.2842010-2-robert.hancock@calian.com>
In-Reply-To: <20230914212432.2842010-2-robert.hancock@calian.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB8838:EE_|YT2PR01MB6642:EE_
x-ms-office365-filtering-correlation-id: b410567e-6b25-4f81-b3ed-08dbb57c9d7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dq5KHWp3i/4YmJZ45jWHhXJGC2f1hkRQmq/BdOn6uFf7miHzlJz1ksis74PcgH6dVSTCVPB+WQszpWhRixpBxQbOHFPlSMy+Tm4xrJctHcNWuZGd5IB93IfakS0WnnyD/LPEY9+ZoCbjbnVAbdYWhXqrPlxGVcbMGRm6Du54azsOYCHo2dS1VoN1Qepak+rDnzE6VRnH071l1s6HR37ElPBHTh1G1IrMVIzphlwATk12mwCJFpGWoj5WBXHKmYqlAZi4+4DbmKmZQETGh6HMworW+Wf0tPXJGcmYYQJrWAvmXM/IX6VrFLaGJJEf0pwUXDhBgII1PiOQJhc2tGTVxrNmRnp8c5vpaxDZBzTFKEppXHUBI5lfX94gbf2l4S7k8ds6xiDphmnDx1eotI7MFxyqpfnax/JIIPIWLWZ6w2oOzVpH5MGIPu89ItCkokhuVwo/TPcUSR71YuKCjfaiBDRs04bO9TwPagBc9xmFWDfDyWIscyTQgpN6eWMzjGUHkUhLP7JWWABPwEp0ohxCkq35VrmPuIn5aKF2IXZqtCsk9ljODvy9Mbfheu2FH4Z0fcCqeo5L1HVtmTC7IBQCuzgiLyvganTh9gMH5a4ajtbde0d5LTIwb+Dn35f6PhK2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(66946007)(76116006)(41300700001)(54906003)(66556008)(64756008)(66476007)(6512007)(316002)(6916009)(36756003)(5660300002)(44832011)(83380400001)(122000001)(2906002)(86362001)(38100700002)(38070700005)(66446008)(2616005)(8936002)(8676002)(4326008)(478600001)(71200400001)(6486002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUM4LzBNWEhjb0taYXlNTXVQNmYyU0k1V3VScVNURWJJdmxJUmVMM3g3Q1FB?=
 =?utf-8?B?K2xqMVh3TjhPcytkdDVkaDJUa08rb2xQdmN2MVR0eGtxZXR1MGc1aXJwV0Yx?=
 =?utf-8?B?Q3VObERsU1A3am5objJhTlUzTFZHZkxya1pKV2N3dHJTaGtVUHNkUUNFK0Yx?=
 =?utf-8?B?TFF2ZEM4eklwekRiSTVDbk5NMGxpNXNaZCtmbytIR01BakFxbEltUmZUMnlW?=
 =?utf-8?B?Y0hkZjdkemVrZDVHNDR5WGpxK0VJYnpocmtpNUxHQ1RTb3pFbFFhUEIxZDNm?=
 =?utf-8?B?M01PUFVoRVc0bXMyWHR0RnpRZEdLQS9XTlNWLzhoa2x0YXZCcDVyZmlSOE5n?=
 =?utf-8?B?MHBkNDBTSk5uMURvamZBemRVbkNMdkoyS3pTbFFtWlNUZ3l2ekRYbTdvaVU1?=
 =?utf-8?B?K1dSOGtlNFZDTkRiRytNNlZHblN4aWNyNDJHdVkzQkdUdkFSWXVySnNPSjVs?=
 =?utf-8?B?ekhSWmZpNzJheGlZRGlOTWJKYkMrazhSczBNd2tVUWVYd1N5Y2hlanlnNnNk?=
 =?utf-8?B?Q3JxR2RBQTIycFhPUWduSGJTd0xMQXBuVktjUjhoU1VmcGZ2NnFzcnJFWC9N?=
 =?utf-8?B?aG5VSzkySmg5TVAzSEZhNmlRdHFvUDlRdGluNWs4TGVkS0ttdmdFODZMN0dO?=
 =?utf-8?B?VDNlZ3dIS1NDdi9IWTJ1M20vZ3I3SzQ5Vm5zaUFqTlZhb1NOVHkrMzRtUVd1?=
 =?utf-8?B?aVVXSURSYUtETmZVcW1wVHBuUFFlaFFiUzVsSDhabm1sZXhDTnYzdUoxRDV1?=
 =?utf-8?B?RkdqMmYzeHcwVndSRDZSWDVVWXIxOHBRWkpTekZMWE1pRDF2eVdNUC93UUJ3?=
 =?utf-8?B?UXdPWnNJZ3AyOWdMQUppbXNNUWlVSWp3NWU2VTlFY0F5WS80dmZBZE9GSXJk?=
 =?utf-8?B?TmZkNUFtVmRvY1B1M3NLY1BidXZidUpJM0lyY2hvMi9CaGxQV1N2dTB0RUoy?=
 =?utf-8?B?MkVlSHhCRm12ODhJa0JhS2Y2LzV6RDQwaTZLRE4zTWVJL3VNZ3lDUnQ0ejZm?=
 =?utf-8?B?NVpzSFZOeDFURTNyaVRRdkRVYmF5TWt6UkdXbi92RlNHVlB1MXB4bjc3aWVE?=
 =?utf-8?B?WHFVbWh2eDFYNlUvMVRtRDN6MHpLdUFpS3c2UElMTlZCUmRSQjlvbGU3cWU2?=
 =?utf-8?B?Yi8rK2YxMnVOQkRTeGhEWkVaZ0MwaTdwcDVHZHdrcEhNNnQzY2hMY1BCK1NO?=
 =?utf-8?B?THBidDFsRWRUZnFCVDczN0dOVnlxT2FKbGE3YThldG9IVFZxMDFRQmd3a3Na?=
 =?utf-8?B?M3pCRXlJbkttSGlPdTRucUhydld0T2d1Rlk0c3Vha2I2c2ZjRHVwckF3blZl?=
 =?utf-8?B?a1NLNm1PRmNISGU4UmxmVU9mamdMMmdNdXdKYXZuYWNPMDhmbmR1MGl1ZlFr?=
 =?utf-8?B?QXFibWpIVmczTE5XcFI0dGZicGhWRDhjYU9ickR2ZXNrMGtkSDVlZyt4LzhB?=
 =?utf-8?B?d2w0T28wZGgzelowNkNPdlpuS2hOK3JTRE1CMHJOSkNpZGZiOUdBOHBmSmlG?=
 =?utf-8?B?ODB0YmZoL1RrcWFZcVdPNnVTZngwcDFqbmJYSTIzeEFSa1JXS016ZkQ5MzZC?=
 =?utf-8?B?Y0R1SHFQT1UvVVpnSXpsWlFFWit6V0kxd1pGdVhUVWdCK21zMURFcm5CcnQw?=
 =?utf-8?B?b1d5VXZuVkhEYXhjS2kzRncrREQ0K0RRK0taa0NocXkzZ2oybGs3MGZlbDJo?=
 =?utf-8?B?MUdldW1lY1lBQTRWeU0xbUo0RS9CZGszSE5yay9oanVkQTNkS1VsbGpYVWdu?=
 =?utf-8?B?WTRRWC9EL3I4QXI5c0NaOHJLL1dVVEphaytuZSsyT0R0eThrN3NZUFFjZ1Q1?=
 =?utf-8?B?dk9lWHpiWCtwWUJNQXpFNUt5TGJxdlozMUlYSXQ3U2NHcUI1M3hVdzRLT2pr?=
 =?utf-8?B?WmpnMGFWRTFCaUVEaFNEb3F4WUxZUEp0enBQNm1FV2pLVjl5Ym9IMnY3V3g1?=
 =?utf-8?B?STVCdkx3VnVEUEF0WTlJZjloQitKZFB6ZXFmYkhkMGtyTUc4WUxPaDQzTGZB?=
 =?utf-8?B?OGlCc1VyYWdNSmlkbkNCQnVPT0Mvb0o5a3NUMmVvbCs2R3drN0lNVUFpTDJ4?=
 =?utf-8?B?Z2llQ1pySElsZ2hPd2pVRmFjdFlYS0w5RlUvRVIrdjloYUJTalRiR3M5Um0r?=
 =?utf-8?B?M05oL0JaV2NjelpLYkNia2h1Z1JrWWFoS0xtOHZBWm83MnoranNod0FweUx1?=
 =?utf-8?B?Sk54dWc0OHdJMjR2YzIvUGtSQXRaUE1ieVI5Rlo5dkx1eVVUVEIyaS83M0dT?=
 =?utf-8?B?ay9NUXRsL2pVQ0kxanJkcTdGMmJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <246A3BE86913414C9D345FA2E935F2AA@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fpsZNATumj2/8mZAaj0kOuAxX1+xVJQy8e/uyc7QaFOfzh6wBjA6hf6pMAGNT6s/G+hQymkShhIkJYF8NkpOF2Bs5Ndin5DltJ8v2SzmsdUwMBOhWOSdL2mtP3TzzpFsDZoxVFPce9y5RmX5sdERIJL+EwaVkqHPiyuwO+0evJJ8VHRnhnZLxSS4f6KWlufjyJMwe4LOW82Osdm6qTgjlpIrP569fVsTUryG8FB0MZRli7lzBFLci3jZmltuk0TSijHp7fwpX7GJ/ykgbVoCN90kMaT8uxyJWttCRP90+T93MmZyB7BRg1JbwzD99Bk6hep0rCdy2X1tny/9Ff10dog6ckqRL2MRfoKevCPVxDNG50lGbm+VmdqLzIYLsXaDLjewJsmp9FUjUofB0SRhgtOwL8tj7sC7jUgi7MfyFk9QghIY9N32i8eh6kxGSmpPJyvObw5nLeDTOgQGNtIhs/HOqzCzVn0+xE2cyNp5xrRFLY1NUB9D0NpMCGuxApK1ZCcoy6Ebe7np4QhhXEv4LiVy3wHxJ0wiL3FNsMwoodT+6RVQIPiGOFXkFXFkZJeVCpjSEnVZQKJsqLbMOZ9mM5bAjg0bo/ylasi3OZ5azB/kJ+5DArIhv7SuV77oX4ni0cgrviSrcbrlhNVvqS28z9kjUVOs2V4QFpmfA6kAEnqkDGfSrvyN93AKdq4cV92874hE7Oc7bvg8DPuCdJbWMZJzIWtyeqhUBAXEhkq7bnkccyyIbXFxwyzDRz7+RIscxrbXm0M1PX9K4URHHJUVehYmbNeTJ6r4hbTdnI5Lkzkdb9eQBCTiObzzQYSTNdeDmN5qHXL8wypYPrwQlJngaVk/dJrIvPuNmWkaL1d6GrfwR/4p44drdajGUW3v/SGFvVe6nJL6Knk7qxhcYJMWGut9d/S3INmTzDwilcp12eI=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b410567e-6b25-4f81-b3ed-08dbb57c9d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 23:45:02.5262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/DyXojRiS3GWrJimyqN2TQlad9WCmEesx5awlxx4RSx5iwVgURTad8ltiLwnnO9jPBEN6jllROiWSTp90RayB0VP97AnWB0xye1UbzSKHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6642
X-Proofpoint-GUID: -Hzo3FmSUZz4D2KDf_vma1ZlE9QjGXgT
X-Proofpoint-ORIG-GUID: -Hzo3FmSUZz4D2KDf_vma1ZlE9QjGXgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTE0IGF0IDE1OjI0IC0wNjAwLCBSb2JlcnQgSGFuY29jayB3cm90ZToK
PiBJbiB0aGUgcHJvYmUgZnVuY3Rpb24sIHRoZSBkcml2ZXIgd2FzIHJlYWRpbmcgb3V0IHRoZSB0
aHJlc2hvbGRzCj4gYWxyZWFkeQo+IHNldCBpbiB0aGUgY29yZSwgd2hpY2ggY2FuIGJlIGNvbmZp
Z3VyZWQgYnkgdGhlIHVzZXIgaW4gdGhlIFZpdmFkbwo+IHRvb2xzCj4gd2hlbiB0aGUgRlBHQSBp
bWFnZSBpcyBidWlsdC4gSG93ZXZlciwgaXQgbGF0ZXIgY2xvYmJlcmVkIHRob3NlCj4gdmFsdWVz
Cj4gd2l0aCB6ZXJvIG9yIG1heGltdW0gdmFsdWVzLiBJbiBwYXJ0aWN1bGFyLCB0aGUgb3ZlcnRl
bXBlcmF0dXJlCj4gc2h1dGRvd24KPiB0aHJlc2hvbGQgcmVnaXN0ZXIgd2FzIG92ZXJ3cml0dGVu
IHdpdGggdGhlIG1heCB2YWx1ZSwgd2hpY2gKPiBlZmZlY3RpdmVseQo+IHByZXZlbnRzIHRoZSBG
UEdBIGZyb20gc2h1dHRpbmcgZG93biB3aGVuIHRoZSBkZXNpcmVkIHRocmVzaG9sZCB3YXMKPiBl
YWNoZWQsIHBvdGVudGlhbGx5IHJpc2tpbmcgaGFyZHdhcmUgZGFtYWdlIGluIHRoYXQgY2FzZS4K
PiAKPiBSZW1vdmUgdGhpcyBjb2RlIHRvIGxlYXZlIHRoZSBwcmVjb25maWd1cmVkIGRlZmF1bHQg
dGhyZXNob2xkIHZhbHVlcwo+IGludGFjdC4KCkFwcGFyZW50bHkgdGhpcyBjaGFuZ2UgaXMgbmVj
ZXNzYXJ5IGJ1dCBub3Qgc3VmZmljaWVudCwgYXMgdGhlIGRyaXZlcgppcyBhbHNvIGRpc2FibGlu
ZyBhbGwgdGhlIGFsYXJtIGJpdHMgd2hpY2ggYXJlIG5lZWRlZCBmb3IgdGhlCm92ZXJ0ZW1wZXJh
dHVyZSBzaHV0ZG93biB0byBhY3R1YWxseSBmdW5jdGlvbi4gV2lsbCBmb2xsb3cgdXAgd2l0aCBh
Cm5ldyB2ZXJzaW9uIHNob3J0bHkuCgo+IAo+IEZpeGVzOiBiZGM4Y2RhMWQwMTAgKCJpaW86YWRj
OiBBZGQgWGlsaW54IFhBREMgZHJpdmVyIikKPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgSGFuY29j
ayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvaWlvL2FkYy94
aWxpbngteGFkYy1jb3JlLmMgfCAxNiAtLS0tLS0tLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMTYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy94aWxp
bngteGFkYy1jb3JlLmMKPiBiL2RyaXZlcnMvaWlvL2FkYy94aWxpbngteGFkYy1jb3JlLmMKPiBp
bmRleCBkYmE3MzMwMGY4OTQuLjg4ZDUyM2FjNzg4MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lp
by9hZGMveGlsaW54LXhhZGMtY29yZS5jCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL3hpbGlueC14
YWRjLWNvcmUuYwo+IEBAIC0xNDI5LDIyICsxNDI5LDYgQEAgc3RhdGljIGludCB4YWRjX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UKPiAqcGRldikKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJl
dCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gwqAKPiAt
wqDCoMKgwqDCoMKgwqAvKiBTZXQgdGhyZXNob2xkcyB0byBtaW4vbWF4ICovCj4gLcKgwqDCoMKg
wqDCoMKgZm9yIChpID0gMDsgaSA8IDE2OyBpKyspIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLyoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogU2V0IG1heCB2
b2x0YWdlIHRocmVzaG9sZCBhbmQgYm90aCB0ZW1wZXJhdHVyZQo+IHRocmVzaG9sZHMgdG8KPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogMHhmZmZmLCBtaW4gdm9sdGFnZSB0aHJl
c2hvbGQgdG8gMC4KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChpICUgOCA8IDQgfHwgaSA9PSA3KQo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGFkYy0+dGhyZXNob2xk
W2ldID0gMHhmZmZmOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbHNlCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB4YWRjLT50aHJlc2hv
bGRbaV0gPSAwOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSB4YWRjX3dy
aXRlX2FkY19yZWcoeGFkYywgWEFEQ19SRUdfVEhSRVNIT0xEKGkpLAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGFkYy0+dGhyZXNob2xkW2ldKTsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gLcKgwqDCoMKgwqDC
oMKgfQo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgLyogR28gdG8gbm9uLWJ1ZmZlcmVkIG1vZGUgKi8K
PiDCoMKgwqDCoMKgwqDCoMKgeGFkY19wb3N0ZGlzYWJsZShpbmRpb19kZXYpOwo+IMKgCgo=
