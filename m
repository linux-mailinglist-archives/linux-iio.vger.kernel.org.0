Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC04879C2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jan 2022 16:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348111AbiAGPdO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jan 2022 10:33:14 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:3634 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239528AbiAGPdN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jan 2022 10:33:13 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207DSrlg010635;
        Fri, 7 Jan 2022 10:32:59 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3depemg9j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 10:32:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnpL0NIfAG5K2ES2NiTwCscA/soC7OAzIk/N5QlYy160T5sF2YOMjW6LhhxOetPtOLQuKVwPlFhj25iKvJCfPh8s0zp8kRO4BkgY4DwcIMUcOuS2OG7zH2MD5y4UI+YFKfxXTRNtGGdztUytW/bPguwg+jmsI0HMD/M1PYc8UHKpHFio55IDnVamcOGGXrXf5IfTYy6JzlB4qsoQclVbdyq/BpraPrp1DHmISPq0MHN5cSzB8Kcj7Uv0gQTh30HUvTT0NIhau0nlpk1zg73fimWYroDVHsDdj9QsUA2hZXdD7wArXVkVqJuaYqdoJ/PxX0MnCpn7gMy4oSza+EP4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTLOhqRvX8jclf1NRYwkzBnOD0Cbc2X1yEMQoTnxDVY=;
 b=nahV270esWdpmk3vXTxt6N/xURjYKyEaK/6xinPCqfw8uz80WqmO3t23RKF+BESAmjxQZSr9/CVveUxpyX8PUyCHqF9Vr6PNptenUHiwpPODDRacBYsIR/hFAlfeLRY/8HkOTa9dVgVUNT/r0cPkUgHPuEC+2bgNlLAs5nof/V60s7+9fmPT20+NyfRNVLRh5I6AU0QP6QTXAqGckgoXL6eR7rhjEF+W+FSNLSkK/e7F/jvcB+0oW7gc9v7drRC3/KFjpg5XBR/KjYexBr2SjrVy9q7ef2dpD19DPvOn+t+3cSDjvtOE1zHNlea8t4IzMzrJK6skRZ11N692zEd3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTLOhqRvX8jclf1NRYwkzBnOD0Cbc2X1yEMQoTnxDVY=;
 b=V8rAhgbNDr2VynVOF2mOg7lkP4T/rzPm/d/1D0i2TvRSD5i3lN1PyRy+chwoHOtU9usicL/6PKtTcCXW8zIjx9RGVLt+5zFFx2Iwr4i5l6T0HMmLLulS+6DY5sqvb6dG4wbyNa6o2NHfCkIFc6YEKcTlsppW8gSg55tuXaMmJ9Q=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6544.namprd03.prod.outlook.com (2603:10b6:510:b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 15:32:56 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5%5]) with mapi id 15.20.4844.016; Fri, 7 Jan 2022
 15:32:56 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 0/3] Add support for LTC2688
Thread-Topic: [PATCH 0/3] Add support for LTC2688
Thread-Index: AQHX8QuS6uX62toBMk61zhKgva+GI6xLPaOAgAyStvA=
Date:   Fri, 7 Jan 2022 15:32:56 +0000
Message-ID: <PH0PR03MB678656127DFB38D7E94F17FD994D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
 <20211230151357.6c7dea0d@jic23-huawei>
In-Reply-To: <20211230151357.6c7dea0d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1UUmtaREF5TldFdE5tWmpaaTB4TVdWakxUaGlZakV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhERTBaR1F3TWpWaUxUWm1ZMll0TVRGbFl5MDRZ?=
 =?utf-8?B?bUl4TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTlRjeE1D?=
 =?utf-8?B?SWdkRDBpTVRNeU9EWXdORE14TnpVeU16QXhNRGc1SWlCb1BTSndlbWM0U0Zk?=
 =?utf-8?B?UFNVNVJkbU13Y0ZaeFN6UnRlRzlOZVN0SmFVVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVRm9RMnN6V0RKM1VGbEJWbTVUYUhsME56SllUVXhYWkV0SVN6?=
 =?utf-8?B?TjJXbU4zYzBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-ms-office365-filtering-correlation-id: c235d3cf-2f97-4dc4-724b-08d9d1f2fab1
x-ms-traffictypediagnostic: PH0PR03MB6544:EE_
x-microsoft-antispam-prvs: <PH0PR03MB654469FB08B1152501D8D0B4994D9@PH0PR03MB6544.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ErizRpu1mGQfJB8vX1mMeyvKYFDu4qO38+lXtiLMooItxk78YQqE03MDRIs6hCYRMHfHsYm9i/9hUIYKaipuKIVvvTuk0YKGA9+08DrgXA1VUBTdidwvvFe2bshjffG4s50NG/CYEM5HG2EDF44rmwLPuv1Y8+iYIMgVnhhUqi2bhg4Aa+d3FMkph0hQvwyeyxKxrhlsQ83MYKK+o8TED7ygeYQGVgTasSsKwdQeGZgmBRrKdkQdow5K53cnguZy75f7zcIubVT1O29YulrROfO2Hc09oWT0XHTeosdksEiDnspEY6NxdN+1+HZVZreGPflFALtEaaDqo7tmTr9fOo8LWGDoBF6TDlxOyBRqiUdxoCdqKPC6Drsct/sCNtpmhE3IKpPAYLQ+j/XgVkrCdaRj5UOB9dznCGNmJSJ/n77WZHgEAQu6KlTAKwxbX93Q3+H2drTbg77ahsoxkDEZ6adiv3NCVlN+0PhBHnPEVN/89ZDceebjMlR90oGXkiGyd1tDPDteeHHeh/cMc+eCI9H4vqGe1mo+OeBViusmHBbvwP/MB3R1yTUwwIQe5Aem7bB/OaBFw1wGI0GmbkZfh/I2pWNvrW9fhUDXJShs0RFUc2dHqPkszOyJG+w7B/s3R207PSPbhKip0lZLm26pDyhRQSOh/OpPvBOnKSAPESLHRdlgGofSoZPRnG19BcWyd2pHG93gYJkxh2D/QRF/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(53546011)(7696005)(508600001)(186003)(71200400001)(8936002)(86362001)(6506007)(54906003)(2906002)(38070700005)(4326008)(5660300002)(33656002)(8676002)(76116006)(55016003)(52536014)(66476007)(107886003)(66446008)(66556008)(66946007)(9686003)(6916009)(38100700002)(316002)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0haWkxPUWk0QWNmWm9VakZSRE0rSmpIdU1xa2d0bFNqcHJyalJWWEh1QXBY?=
 =?utf-8?B?UzN6RHdnZ1V0MWsxVkNTbFBnN2F1R1lrWlVPbVBLRCtOREVaSG9uYWxqR05n?=
 =?utf-8?B?TlgxMnZqODNYS1gwcVUvSXl6YytQNWxYK0ZwOG9tc09XbC9RamY1V1FsWjc3?=
 =?utf-8?B?SlNHZTd3eFowa0ZublhkdUswenRiS2ZqdlFxa0UydGJwTmErVjhwOFUrV0Qy?=
 =?utf-8?B?TXVFejVqR1Z3dEhoeEd4cmVSNExTK0taMDYxUy9OK0FHYUtKYkpDWXBuSHlh?=
 =?utf-8?B?ZTlobWh1MkRnbTlXc3VZNW8wNTVTL29XdmduazJXQjlLSERWYURIbDFTRElW?=
 =?utf-8?B?NTY3Rm0raXA3TGxqUytKR2hYYWdlMUhNY2t6REd3cU1FRzA5UzVndDNhRDM2?=
 =?utf-8?B?U2pEMDJzTmhCSzBUNzZrM25EbkZrRWJoZWpUdmc3WjNrdm9VRFZaWGoyQ3JC?=
 =?utf-8?B?dXM3SndIVnJnNm9zcW1LYkx4ZWJDUS9lWTgrcUdVcEs3WDFEdHN4d3pIT3dV?=
 =?utf-8?B?SnloWmZkUzZKTHk0OGgyT2lQSW9waXk1Q0dEMHFxOUQ0SWVQREdNWEhWTHlj?=
 =?utf-8?B?SnZGYXdkazk1dkZ5U2xUSStyR1lKN3ZmOFc5NU5ybWF6L2MraVlrWnRSZmRU?=
 =?utf-8?B?cCtlMHhMV1FiTEozYy9La3NDNzg3dEpPNUdkWWRpaG5oT2puSXpMcEVIZXJH?=
 =?utf-8?B?eDYxOFJieXI0N3BEQ1VaY1FJeVcyTTROb09BeVBQMDNkTlV4OCtlc0JCQ1Nr?=
 =?utf-8?B?Mndsb2hKMDZsMDBQTW1WUzNyRU5EbGlCWDBrdWtsOHhBMCs2NGdVaXNOMGZK?=
 =?utf-8?B?S1lXb2Q3dUM0NXQxUnFzUEhOVU1FZUxVemxJaHFBV29KSlNTM1B1VTJwVXFv?=
 =?utf-8?B?ZmJRRlpnNC9rU0pVRVF5WUVjaWFGWWJ4UE5jQm1LclNHdUp3RXhta2FoNGp0?=
 =?utf-8?B?RlI1amkySndka2wwdXpKSUloMVppVmtzWHBSU2hFQXgySnpVR1BZcitDVG5Q?=
 =?utf-8?B?MVhnekxjYkhKQ05WVGhvVVdRbE1pYVgzZXFybVVuVElleU9nT21NeUtTdkFv?=
 =?utf-8?B?OUZLR0NiM3BHdFordGlTU0tjZThuSURvTlB6aFduZWkwQS9QeGtZaTlzNEFV?=
 =?utf-8?B?cUFPYU1qNEViUFMwWDFSV01VeUZnUi9TN1dwdDloRkNBcVozcEFmbStXYmVS?=
 =?utf-8?B?a2xlK0VLMlpQL3E1T1hwa0RDNVNMQWtjV0NySGtrdHN0WTArd2ttM0RJUVhq?=
 =?utf-8?B?T1NqanlNMmNxTkYwV3BFd2gyRllEaEI0dHlJVWZNRkh6Q3V0eHpGRmljMUVW?=
 =?utf-8?B?RG01eHBoSC9kM2tEVE4xUTdLL1piNUl1a1Jadmx3ODVDeFplUXVPQ0RaMDJY?=
 =?utf-8?B?M1JWRDZ6ZWdsRjNIai9DbGZqa1VUQXdGMFRxVVdVRzlGUytHTzA0dWpHZmhJ?=
 =?utf-8?B?Rk1zb044OWJCdS8zWGJGZWdwc2Q5VXBJL2hWOVI1V0ZMUUxjRjR5YStOU0o5?=
 =?utf-8?B?NUlpZDdCN3Byci9KUWw2cFFsYW5OLy9CNlg3emZhdTd2ZjFGSXp5NG1tMlhj?=
 =?utf-8?B?SVdWUkE5NmxCYTRGUjlaa3MvZVpHSGZHcDQ5MHRHMjlOTzh6ZXh6WGFiS3Jt?=
 =?utf-8?B?ZTVYcW5Wb0FWQ0VMYVV6N3d4bG8xNjBzY1ZwMER5YTNLbjJGL0lmeE1wOGZO?=
 =?utf-8?B?eXJSODZ4RlQvMExOazMreWk2NnFBeTVTdWlQRDB2aVFBRmtxbWpXdmsxbXhV?=
 =?utf-8?B?UUFHcFhLWkhXOTFPVFZ1cS9odkl3M1Q1NFdkL2E0RHovOStUeUxqbWZZdVk3?=
 =?utf-8?B?bW9DM1hMcjdTQnNSaVVJY1pYZ2pPS25ZSU1sUFNpM25OdWo0NVBURmVaQUhX?=
 =?utf-8?B?ZDQ5YStML0g1eDcxYzcreHRwNklDQnEwK3h4eEY5RGFIWS9ZNndoc3ZrRWg2?=
 =?utf-8?B?Mjl0Z1Rjdyt3dER3M2FMY0pCS0RzcEdHbnJIb0JPY0dXeGtpYVpYWlBQUXB1?=
 =?utf-8?B?S2xCSld4Q0dCaTQ2eHdTbjlxaFE0N25xNFlidUdhZ214cVU2dktYSGlpbnhC?=
 =?utf-8?B?SmlrUEZxblZYTmhRakp2LzE2SWhnMG9NYzlkQ2tBY3lBQUNQL1VneXdJSGhP?=
 =?utf-8?B?VGRvRzJnSVlVWUx3QVlhcHYzbGFMTE9YWVZEYmNJb1o2ZExhQkgvakoxV0xy?=
 =?utf-8?B?R2JKZXM2b01ucm16UGJySUx3Y1pXTVh1emhPcmVDVWw5Tk1pOU9nWFg0UTRa?=
 =?utf-8?Q?s+9EbXn3w1zk31sR9cxJ4RDXJOzqOYfJK2tY3m2i2c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c235d3cf-2f97-4dc4-724b-08d9d1f2fab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 15:32:56.6453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FEC959tvyplzM8JveedFhWrXliBZbb0+2W8ea2U/T1nQR4lHdN82zZIlbx169lvqhO4HkL+rF2z1fyZiNcVbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6544
X-Proofpoint-ORIG-GUID: kLlmTj8hMy958xe4nwlMHOFJUZDz2pTb
X-Proofpoint-GUID: kLlmTj8hMy958xe4nwlMHOFJUZDz2pTb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_06,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070105
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNClNvbWVob3cgSSBmYWlsZWQgdG8gc2VlIHRoZXNlIHJlcGxpZXMgYW5k
IG9ubHkgd2hlbiBJIHdhcyBhYm91dCB0byBzZW5kIGEgdjIsDQpJIHJlbWVtYmVyZWQgdG8gZG91
YmxlIGNoZWNrIDopLiBTbyBsZXQncyBzZXR0bGUgc29tZSByZW1haW5pbmcgcG9pbnRzIGFuZCBJ
J2xsDQpzZW5kIHRoZSB2MiBuZXh0IHdlZWsuDQoNCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8
amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDMwLCAyMDIxIDQ6
MTQgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENjOiBsaW51eC1p
aW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgUm9iDQo+IEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0Bt
ZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFs
b2cuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvM10gQWRkIHN1cHBvcnQgZm9yIExUQzI2
ODgNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgMTQgRGVjIDIwMjEgMTc6NTY6MDUg
KzAxMDANCj4gTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRo
ZSBBQkkgZGVmaW5lZCBmb3IgdGhpcyBkcml2ZXIgaGFzIHNvbWUgc3VidGxldGllcyB0aGF0IHdl
cmUNCj4gcHJldmlvdXNseQ0KPiA+IGRpc2N1c3NlZCBpbiB0aGlzIFJGQyBbMV0uIFRoaXMgbWln
aHQgbm90IGJlIHRoZSBmaW5hbCBzdGF0ZSBidXQsDQo+ID4gaG9wZWZ1bGx5LCB3ZSBhcmUgY2xv
c2UgdG8gaXQ6DQo+ID4NCj4gPiB0b2dnbGUgbW9kZSBjaGFubmVsczoNCj4gPg0KPiA+ICAqIG91
dF92b2x0YWdlWV90b2dnbGVfZW4NCj4gPiAgKiBvdXRfdm9sdGFnZVlfcmF3MQ0KPiA+ICAqIG91
dF92b2x0YWdlWV9zeW1ib2wNCj4gPg0KPiA+IGRpdGhlciBtb2RlIGNoYW5uZWxzOg0KPiA+DQo+
ID4gICogb3V0X3ZvbHRhZ2VZX2RpdGhlcl9lbg0KPiA+ICAqIG91dF92b2x0YWdlWV9kaXRoZXJf
cmF3DQo+ID4gICogb3V0X3ZvbHRhZ2VZX2RpdGhlcl9yYXdfYXZhaWxhYmxlDQo+ID4gICogb3V0
X3ZvbHRhZ2VZX2RpdGhlcl9mcmVxdWVuY3kNCj4gPiAgKiBvdXRfdm9sdGFnZVlfZGl0aGVyX2Zy
ZXF1ZW5jeV9hdmFpbGFibGUNCj4gPiAgKiBvdXRfdm9sdGFnZVlfZGl0aGVyX3BoYXNlDQo+ID4g
ICogb3V0X3ZvbHRhZ2VZX2RpdGhlcl9waGFzZV9hdmFpbGFibGUNCj4gPg0KPiA+IERlZmF1bHQg
Y2hhbm5lbHMgd29uJ3QgaGF2ZSBhbnkgb2YgdGhlIGFib3ZlIEFCSXMuIEEgY2hhbm5lbCBpcw0K
PiB0b2dnbGUNCj4gPiBjYXBhYmxlIGlmIHRoZSBkZXZpY2V0cmVlICdhZGksdG9nZ2xlLW1vZGUn
IGZsYWcgaXMgc2V0LiBGb3IgZGl0aGVyLCB0aGUNCj4gPiBhc3N1bXB0aW9uIGlzIG1vcmUgc2ls
ZW50LiBJZiAnYWRpLHRvZ2dsZS1tb2RlJyBpcyBub3QgZ2l2ZW4gYW5kIGENCj4gPiBjaGFubmVs
IGlzIGFzc29jaWF0ZWQgd2l0aCBhIFRHUHggcGluIHRocm91Z2ggJ2FkaSx0b2dnbGUtZGl0aGVy
LQ0KPiBpbnB1dCcsDQo+ID4gdGhlbiB0aGUgY2hhbm5lbCBpcyBhc3N1bWVkIHRvIGJlIGRpdGhl
ciBjYXBhYmxlICh0aGVyZSdzIG5vIHBvaW50IGluDQo+ID4gaGF2aW5nIGEgZGl0aGVyIGNhcGFi
bGUgY2hhbm5lbCB3aXRob3V0IGFuIGlucHV0IGNsb2NrKS4NCj4gPg0KPiA+IFRoZXJlIGFyZSBz
b21lIHN0dWZmIHdoZXJlIEknbSBzdGlsbCBub3QgMTAwJSBjb252aW5jZWQgdGhvdWdoOg0KPiA+
DQo+ID4gMS4gb3V0X3ZvbHRhZ2VZX2RpdGhlcl9yYXcgcmVmZXJzIHRvIHRoZSBkaXRoZXIgYW1w
bGl0dWRlLiBUaGVyZQ0KPiBhcmUgc29tZQ0KPiA+IGRpZmZlcmVuY2VzIGJ1dCBpbiBlc3NlbmNl
LCB0aGUgc2FtZSBzY2FsZSBhcyB0aGUgcmF3IGF0dHIgYXBwbGllcy4NCj4gVGhhdA0KPiA+IGlz
IG5vdCB0cnVlIGZvciB0aGUgb2Zmc2V0IGFzIGl0J3MgYWx3YXlzIDAuIFRoaXMgaXMgc3RhdGVk
IGluIHRoZSBBQkkNCj4gPiBmaWxlIGFuZCBiZWluZyBhbiBhbXBsaXR1ZGUgaXMgbW9yZSBvciBs
ZXNzIG9idmlvdXMuIEhvd2V2ZXIsIEknbSBub3QNCj4gPiBzdXJlIGlmIGl0J3Mgc3RpbGwgdmFs
dWFibGUgdG8gaGF2ZSBhbiB1dF92b2x0YWdlWV9kaXRoZXJfb2Zmc2V0Pw0KPiANCj4gSSB0aGlu
ayBpZiB3ZSBoYXZlIG91dF92b2x0YWdlWV9vZmZzZXQgdGhlbiB3ZSBzaG91bGQgaGF2ZQ0KPiBv
dXRfdm9sdGFnZVlfZGl0aGVyX29mZnNldCB0byBhdm9pZCBhbnkgcG90ZW50aWFsIGNvbmZ1c2lv
biArDQo+IGFwcHJvcHJpYXRlDQo+IEFCSSBkb2NzIHRleHQgdG8gbWFrZSBpdCBjbGVhciB0aGF0
IHRoYXQgdGhlIG1vcmUgc3BlY2lmaWMgX29mZnNldCB0YWtlcw0KPiBwcmVjZWRlbmNlLiAgSSBo
YXZlIHNvbWUgdmFndWUgcmVjb2xsZWN0aW9uIHdlIGhhZCBhIGRlYmF0ZSBhYm91dCBhDQo+IHNp
bWlsYXINCj4gY2FzZSBpbiB0aGUgcGFzdCB3aGVyZSB3ZSBoYWQNCj4gaW5fdm9sdGFnZVhfb2Zm
c2V0IHRoYXQgY292ZXJlZCBsb3RzIG9mIGNoYW5uZWxzIGFuZA0KPiBpbl92b2x0YWdlOTlfb2Zm
c2V0DQo+IChudW1iZXIgbWFkZSB1cCkgdGhhdCBqdXN0IGhhcHBlbmVkIHRvIGJlIGRpZmZlcmVu
dC4gIE5vdCBzdXJlIGFueQ0KPiBkcml2ZXIgdGFrZXMgYWR2YW50YWdlIG9mIEFCSSBwZXJoYXBz
IGFsbG93aW5nIChub3Qgc3VyZSBpdCdzIHdyaXR0ZW4NCj4gZG93bikNCj4gYSBtb3JlIHNwZWNp
ZmljIGF0dHJpYnV0ZSB0byBvdmVycmlkZSBhIGdlbmVyaWMgb25lLi4uDQoNCk9rLiBvdXRfdm9s
dGFnZVlfZGl0aGVyX29mZnNldCB3b3JrcyBmb3IgbWUuIEkgd2lsbCBhZGQgaXQgdG8gdGhlIGRp
dGhlcg0KQUJJIGFuZCB3aWxsIGp1c3QgcmV0dXJuIDAgKHdoaWNoIG1pZ2h0IG9yIG1pZ2h0ICpu
b3QqIGJlIGVxdWFsIHRvIG91dF92b2x0YWdlWF9vZmZzZXQpLg0KDQo+ID4NCj4gPiAyLiBGb3Ig
bm93LCBpZiAnYWRpLHRvZ2dsZS1kaXRoZXItaW5wdXQnIGlzIGdpdmVuLCBhIGNvcnJlc3BvbmRl
bnQgY2xvY2sNCj4gPiBhcyB0byBiZSBnaXZlbiBhcyB3ZWxsLiBXaGlsZSB0aGlzIG1ha2VzIHNl
bnNlIGZvciBkaXRoZXIgY2hhbm5lbHMsIEknbQ0KPiA+IG5vdCBzbyBzdXJlIGZvciB0b2dnbGUg
b25lcy4gSSBjYW4gZWFzaWx5IHNlZSBhIHRvZ2dsZWQgY2hhbm5lbCBiZWluZw0KPiA+IGNvbnRy
b2xsZWQgYnksIGZvciBleGFtcGxlLCBhbiBob3N0IEdQSU8uDQo+IA0KPiBJIGFncmVlLiAgQnV0
IEkgdGhpbmsgd2UgY2FuIHJlbGF4IHRoaXMgd2hlbiBuZWVkZWQgcmF0aGVyIHRoYW4gaXQgYmVp
bmcNCj4gbmVjZXNzYXJ5IHRvIGFsbG93IGZvciBtb3JlIGNvbXBsZXggdG9nZ2xlIGNvbmRpdGlv
bnMgZnJvbSB0aGUgc3RhcnQuDQo+IEdlbmVyYXRpbmcgYSBjbG9jayBkcml2ZW4gc2V0IG9mIHZv
bHRhZ2VzIGlzIHByb2JhYmx5IGEgY29tbW9uDQo+IHVzZWNhc2UNCj4gZm9yIHRvZ2dsZSBtb2Rl
IHNvIGZpbmUgdG8ganVzdCBzdXBwb3J0IHRoYXQgb25lIHVudGlsIGFub3RoZXIgdXNlY2FzZQ0K
PiBjb21lcyBhbG9uZy4NCg0KRmFpciBlbm91Z2guIExldCdzIHRoZW4gbGV0IGl0IGFzLWlzLiBF
dmVuIHRob3VnaCBub3QgdGhlIG1vc3QgbmVhdCB0aGluZyB0byBkbywNCndlIGNhbiBhbHdheXMg
dXNlIGEgZml4ZWQgY2xvY2sgdG8gb3ZlcmNvbWUgdGhlIGNvbnN0cmFpbiBhbnl3YXlzIDopIC4N
Cg0KPiA+DQo+ID4gMy4gRGl0aGVyIGNhcGFibGUgY2hhbm5lbHMgYXJlIGJlaW5nIHNpbGVudGx5
ICJhc3N1bWVkIiBieSB0aGUgZHJpdmVyLg0KPiA+IE5vdCBzdXJlIGlmIGFuICJhZGksbW9kZSIg
ZHQgcHJvcGVydHkgd291bGQgbWFrZSBzZW5zZS4gSGF2aW5nIHRoaXMNCj4gPiBleHBsaWNpdGx5
IGNvdWxkIG1ha2UgaXQgZWFzaWVyIHRvIGV4cHJlc3Mgc29tZSBkZXBlbmRlbmNpZXMgaW4gdGhl
DQo+ID4gYmluZGluZ3MgZmlsZS4NCj4gDQo+IEkga2luZCBvZiBsaWtlIHRoZSBhc3N1bWVkIGRl
ZmF1bHQgb2YgdG9nZ2xlIGlmIHRoZSBwaW4gaXMgd2lyZWQgdXAsIGJ1dA0KPiBpZiB5b3UgcHJl
ZmVyIGFuIGV4cGxpY2l0IGNvbnRyb2wgaXQgYmVjb21lcyBhIHF1ZXN0aW9uIG9mIHdoZXRoZXIN
Cj4gUm9iIChhbmQgbWF5YmUgb3RoZXJzKSB0aGluayB0aGUgYmluZGluZyBpcyBzYW5lIG9yIG5v
dC4NCg0KV2UgY2FuIGxlYXZlIGl0IGFzIGlzIGZvciBub3cuIEhvbmVzdGx5IHRoZSBtYWluIG1v
dGl2YXRpb24gZm9yIGl0IHdhcw0KdG8gZXhwcmVzcyBzb21lIGRlcGVuZGVuY2llcyBpbiB0aGUg
YmluZGluZ3MuIExpa2UgdGhlIGZvbGxvd2luZyBwc2V1ZG8gY29kZToNCg0KaWYgYWRpLG1vZGUg
PT0gZGl0aGVyOyB0aGVuDQogICBhZGksdG9nZ2xlLWRpdGhlci1pbnB1dCBkZXBlbmRzIG9uIGNs
b2Nrcw0KDQpUaGlzIGlzIG5hdHVyYWxseSBvbmx5IHBvc3NpYmxlIGlmIHdlIG1ha2UgY2xvY2tz
IGEgcHJvcGVydHkgb2YgdGhlIGNoYW5uZWxzDQpvYmplY3QuLi4NCg0KPiA+DQo+ID4gNC4gRm9y
IG5vdyB0aGUgY2xvY2tzIHByb3BlcnR5IGlzIG5vdCBwYXJ0IG9mIHRoZSBjaGFubmVscyBvYmpl
Y3QuDQo+ID4gVGhlIHJlYXNvbiBmb3IgdGhpcyBpcyB0aGF0IHdlIG9ubHkgaGF2ZSAzIHBvc3Np
YmxlIGNsb2NrcyBmb3IgMTYNCj4gPiBjaGFubmVscyBzbyBJIHdhbnRlZCB0byBhdm9pZCBnZXR0
aW5nIGFuZCBlbmFibGluZyB0aGUgc2FtZSBjbG9jaw0KPiBtb3JlDQo+ID4gdGhhbiBvbmNlLiBC
dXQgdGhhdCBpcyBub3QgcmVhbGx5IGFuIGlzc3VlIGFuZCB0b2dldGhlciB3aXRoIDMpIGl0DQo+
ID4gY291bGQsIGFnYWluLCBtYWtlIGl0IGVhc2llciB0byBleHByZXNzIHNvbWUgZGVwZW5kZW5j
aWVzIGluIHRoZQ0KPiBiaW5kaW5ncw0KPiA+IGZpbGUuIFRoYXQgc2FpZCwgSSdtIHBlbmRpbmcg
aW4gZG9pbmcgdGhpcyBwcm9wZXJ0eSBhIGNoYW5uZWwgb25lIChhcyBpdA0KPiA+IHRydWx5IGlz
KSB1bmxlc3MgSSBnZXQgZmVlZGJhY2sgb3RoZXJ3aXNlLg0KPiANCj4gSW50ZXJlc3RpbmcgcXVl
c3Rpb24gb24gaG93IHRvIGRvIHRoaXMuICBNYXliZSBhIHF1ZXN0aW9ucyB3aGVyZQ0KPiBSb2In
cw0KPiBpbnB1dCB3b3VsZCBiZSBwYXJ0aWN1bGFybHkgdXNlZnVsLiAgTGlrZWx5IHRvIGJlIHNp
bWlsYXIgY2FzZXMNCj4gc29tZXdoZXJlDQo+IGVsc2UgZnJvbSBhIGR0LWJpbmRpbmcgcG9pbnQg
b2Ygdmlldy4NCj4gDQoNCkkgZG8gdGhpbmsgaXQgbWlnaHQgbWFrZSBzZW5zZSB0byBoYXZlIGNs
b2NrcyBhcyBwYXJ0IG9mIHRoZSBjaGFubmVsIG9iamVjdCBhcw0KaXQgaXMgaW5kZWVkIGEgcHJv
cGVydHkgb2YgdGhlIGNoYW5uZWwuDQoNCkFuZCBhcyB3ZSBhcmUgbGVhdmluZyB0aGUgY29uc3Ry
YWluIGZvciB0b2dnbGUgbW9kZSBjaGFubmVscyAob2YNCnByb3ZpZGluZyBhIGNsb2NrIGlmIGEg
dGdweCBwaW4gaXMgcHJvdmlkZWQpIG9uZSBuZWF0IHRoaW5nIHRvIGhhdmUgaW4gdGhlDQpiaW5k
aW5ncyB3b3VsZCBiZToNCg0KZGVwZW5kZW5jaWVzOiBhZGksdG9nZ2xlLWRpdGhlci1pbnB1dCBb
ImNsb2NrcyJdDQoNClJvYiwgYW55IGlucHV0IG9uIHRoZSBhYm92ZT8NCg0KLSBOdW5vIFPDoQ0K
