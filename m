Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB93D3F275C
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbhHTHNS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:13:18 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18188 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238727AbhHTHNQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:13:16 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JK78LX020126;
        Fri, 20 Aug 2021 03:12:25 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahk6ynqd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:12:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iwy1llkQnPB6hGiiAHkVPFa1zOLx2cLtZ1mAkOqVsHbL4tMNyKhbF/n+h1c06BFEC/MTPRxfdHDFEDpqWGagalqxknnnRGnTkug112dIX7bfesaS99kU5mXkpDcVjWJzdg9adGPRTcR3y7n0g9RU/4XESThf7CgPzaso0mw4jkNlF2f1jenlJJpcU5fq4Ca0+65RdtuBlmpxQXZVrlny9AbJXpR3ppVbdAOJIx87biOCkw6WAr8lmtcaMsGpiu18ruZubw9J17N0yRG3/nj+PPpx4aNqOIyXC/wC6epfiTdp5c5evd9se9IaglTAx88/0muX1a2zl5fk180ySFPB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L3cp/dhn/N0XrDorrVneJYta5rHwgGhPbQV8jabC+o=;
 b=fcNyHOZjc3ROvwEcQZX2OhVyuEMyuE++fZ4dOFYt2BuubX0KhkAkKuFDuYziyrmBhTItBSBYzWJ2iFpjDknfFxPpXoLvZI7bfjS9e67bjPDc1uiWN1HB3/c3KQRp5iDKt9KFVU3Gs5wX08FEn0VHH9kTfIgSLpML1EMidgALps8N4QinwRXX3YP14loOkN6TKu0WAOyCl8TfsuffHvBTiybIlwznCIJia8KB6xL06fVlIkM3nzrAhka3Rov4Eqm6qNSm9EcmmS7P6rvEx6ZuS9YeDHJHCeXCDWyaFg6jVRUcSvML2rZCCSvFHaJvirieYqX+W3C6ujH1NAZnI4vxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L3cp/dhn/N0XrDorrVneJYta5rHwgGhPbQV8jabC+o=;
 b=zUi/87130BHIwcKVjWaPpgtNr/S11yX/uAlW4MMaWw8zZ3p0kHdSyhqWGkNcwhmmLxLvB+Yvc4NsVpvd7NvOo71/1uouimHLhKsxnVjMgiSD3snE+6AukdpWTCbLKcu+hXRLNCg5pcek1xdwDSybGoh0sqZg6yGAkL7OWYtJ9zM=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB3957.namprd03.prod.outlook.com (2603:10b6:a03:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 07:12:22 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:12:22 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/16] iio: adc: max1027: Lower conversion time
Thread-Topic: [PATCH 04/16] iio: adc: max1027: Lower conversion time
Thread-Index: AQHXlCHbqMegc9FjHkyxY9G1IXEYeat7/SVw
Date:   Fri, 20 Aug 2021 07:12:22 +0000
Message-ID: <SJ0PR03MB63596BA4C8C798F61D1F086E99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-5-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-5-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpqVTVNakV6TmpRdE1ERTROUzB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHWTFPVEl4TXpZMkxUQXhPRFV0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRZME1p?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGN4TkRFME1EZ3lOakU1SWlCb1BTSjVVbmsxUlRZ?=
 =?utf-8?B?dlJrNHdSbGhDTjFrelZXWllabmRMVHpjelFVMDlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRTNhRTl4TTJ0d1dGaEJaRUZyVG5Kb05XMXNTbXd3UTFFeWRV?=
 =?utf-8?B?aHRZVlZ0VlVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVUpQV1VkalowRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZDYUVGSVNVRmhVVUpv?=
 =?utf-8?B?UVVZNFFWcEJRbkJCUjAxQlpFRkNjRUZIT0VGaVowSm9RVWhKUVdWUlFtWkJT?=
 =?utf-8?B?RkZCWVZGQ2JFRklTVUZOVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIw?=
 =?utf-8?B?VkJZMmRDY0VGSFJVRllkMEpyUVVkclFWbDNRakJCUjJ0QlluZENkVUZIUlVG?=
 =?utf-8?B?alowSTFRVVk0UVdSQlFuQkJSMVZCWTJkQmVVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZC?=
 =?utf-8?B?UVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf: true
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bf50f71-e1c2-4ab4-c807-08d963a9db4d
x-ms-traffictypediagnostic: BYAPR03MB3957:
x-microsoft-antispam-prvs: <BYAPR03MB3957DBD4C846079BE589CD5D99C19@BYAPR03MB3957.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vb2KoRhPiqlD5flz1CKGm0qDWuBpCpUz0pO2E3hWF/yM5DxxlwiTzr9uT/yMlJLPK6CrR35yz826fZ4isO43Awhy1pVu3W3IV1A9vWA6mt9sLGdsMOMf8gWxpu2oF78fBKLqxIyN/4ewoSIijaUEBcsj8QNwg6dFCod0GPzNBMMrxbhV8PGH43H2Ju5lmJiVU/bgr3vqgZ0u4bjrc++9JMb9L47U/1IjeK7m4JrZ1NMOs4aQMMAHnsOnn6+1vZdyDlP3CBxkHGSdeBzAiTC05re4JUhUmUt26bLyDRnZDvCscGJTDe6opLEOTRq0+TPAXFaIGWcJiV4alRQ/yOThAWfF5kGnPGZyyR8tDSLHpaCOMS/exqnIOmZUK8aRC9/Ustv+gymtRzhbfJxiUX3j8KduaTuc2YSd3qxI9epyRqKYw6+XvMquZFQgdgQNm7Gzh1Tec2CN8URBTdzxCFhUFyncfpXR+TVsNVe8yiYEFTf6Fuu/kkNXVOWHAEKjMPNwrnn7uP1Hv4FZ8C2SFlQOxz+N1Z3XUileJZ1NMfSfBFsUDKgMpOFL7ILLvLbzN8ti4NkjtPRs9jEp7fzmS7dnSvtGS2nullirWjmyyNfPQv7o6U+pSbSCfAt3VIcJdFYL+L8o/Bylp5U6NowjtrPrIk0AIF0Pn4qp3pMnGzgGYMEFnB34wp+rNvxU8QM2uQUshAT9m4VALyzo2PqaMjougA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(66476007)(53546011)(26005)(66446008)(6506007)(38070700005)(4326008)(66556008)(52536014)(64756008)(71200400001)(55016002)(9686003)(54906003)(2906002)(8936002)(76116006)(66946007)(110136005)(86362001)(8676002)(83380400001)(122000001)(7696005)(5660300002)(38100700002)(33656002)(186003)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGVZME1IamhDY2VhTUlMNnNhTUxZSklQaUdacU9LSFkvTFJGR05pWmVneWdh?=
 =?utf-8?B?NW1sTi9VY0Uzcm5KbmhGeE5qbkxEWkFXelNYSnhuWnJSdEhIVDlPS0ptaDhP?=
 =?utf-8?B?YlhONmxUNEV4aExSWi8rV2VPTnNReFR2UEl3aFVYVkNNUlFMczFzWENpTHNq?=
 =?utf-8?B?b1RIU2JIZTZGMk84TGdIQnBEMGF3UnZnUFI4bG9IUk45Z0wwT2h1bmlwbUJT?=
 =?utf-8?B?TDEvWXhEV2liOEtJeUZ3L3hiaExlaTRyS0NwS3UzVUJPVC8rZHk1eEV2UGZ4?=
 =?utf-8?B?amhxWDdGMmZiWWpEVUNSYnJOeWgrZTF6b1FZTkVjQnNGbllvZFE1TjRRR3RT?=
 =?utf-8?B?bHljY3htSVB6dW5DbitCRzh4eDBid0FzYmliSTFhY1k5WERQRmRLTHFSbldQ?=
 =?utf-8?B?RGpkeDM3Z3hqdThZZXRneW1JQjU0RW5ReUEzQ1RQYzFCTndXK1N5OG9yUWVq?=
 =?utf-8?B?M1lZbDVqbDlqbWp2MTJoYXpUb2E2UGlmU1ZXTzFEQ2hidlkwcG03NjBaT2ZL?=
 =?utf-8?B?cW8xTzJXUUhCcG9UTEl1UWFjdzRTZGNOQ0pxLzZ3ZEZUT3REYnl4cHZVdlEy?=
 =?utf-8?B?SHY1SHJ4eUw2V1FEcnBIVHdzNFpmcG5YM0hjbmJGamZ0WkFhZStpTGxOc0pV?=
 =?utf-8?B?eWgxSW1yWmtXVDYwZksxS0kwK0xUWFd1cEsxU2Z2SmEvSFoxME5kcngxY0k2?=
 =?utf-8?B?NjJLU1M5cXdqYlE2L3plRklxRjl1Z2V3REFWY3JSZVB1THdPdFZBQm94cWpV?=
 =?utf-8?B?dTZKUDdXM0FoTmpXVWVKdjFWTWRGUURpK0NKaS83MlltdmppSko1MXRlbWdG?=
 =?utf-8?B?R0huWlh6a1gyZFRYMnlOS05FNG5MUW5pa3RLdXdTbjFuYTR4OWYySk1aWjdv?=
 =?utf-8?B?NjlvNGdXRjhlRk15dnFKUWtVKzA0ZXBCUURuWC96ZUN2REtCUlVzZXVBUHpw?=
 =?utf-8?B?c0NSWGZUQkNoSDVYTitrRElOVnZFWUdoRGd4YmVWYSs4bkwyRGRoTGhDT21K?=
 =?utf-8?B?OStXNkpyK0lCQ3JOZlA0YlZqNG5hMjJuWWEyWmVXcWZXdHEwbkVNUzlEb21E?=
 =?utf-8?B?TGVSSmtsTm0rMWpFSkpEcXYwYjhTRGh3dE5hNFY0R0tTSXJJUXRTT1FtekE4?=
 =?utf-8?B?aGVYSTRkMDNJQUVnK1BibFBXbU0zNDBKakt4dWh2RGw4QmxObmhUUDFxN0pj?=
 =?utf-8?B?WnB5TFNRWVhuNWlXdmdJK2djYUxMa1UrdWpFWXI0RUpFaFh6WEpJSFNwRzNF?=
 =?utf-8?B?T3Nxb0NUcTNGdThPUzUxZU90VEE3TkJnOUh5ZTRXd1FhWHY1Y01lbmsyUFp5?=
 =?utf-8?B?VGhTc20ySkJyYTU0L09KWW9DKyt6dU5aZWJndmVHR3N3c21WMEZRcFc4N0Y1?=
 =?utf-8?B?WmxlQ1VkS1RQVG00Mm0zMWh4REdlMU9oRjNIUmFvRjc1czFwaHZYNTlYM3Nj?=
 =?utf-8?B?RHp5SVNRaVB3Q3dZbDMwRlYwaTlZMVRFQ3dJd2dKVVlHeUlRbS90YmlCZ21I?=
 =?utf-8?B?dFp1R083WTM1YkluaG5sNmRvMGxYLzFkRzNOU3dQclhkaFpPbi9PcForV3Jr?=
 =?utf-8?B?eTNBL20zU3cza2paTnpGcm5SYTdGd2g2UnlsU2ZveUphUmdxdXBpdWJ4WjIw?=
 =?utf-8?B?dEl5bXJzZDBpcUxmNlUwbnNpRUtFem51NWMzRjlsN1FqdVZkdGtqc0g0NUc5?=
 =?utf-8?B?MGhpVmRPbTJ2c21ScUh1d1F2dzBvUGlSSFg0LzNrd0ZvQWYxcGR1c2Rpd0p5?=
 =?utf-8?Q?cofcVtHyofeQ1J9C00pn58evvRKGJSGOqf8dwGh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf50f71-e1c2-4ab4-c807-08d963a9db4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:12:22.8272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51Er6bNlz/l3PgzFUVXZT6jGUw/Ww+Sk8yCHFKxFP816z0BoC5xY4EMCJRybHyeTc535NyAOWnnhnEKkzRwj5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3957
X-Proofpoint-ORIG-GUID: 3EIQYd5eHi-Ne0YtXzbKGg9tmc5IbSfL
X-Proofpoint-GUID: 3EIQYd5eHi-Ne0YtXzbKGg9tmc5IbSfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=830 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200041
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTgs
IDIwMjEgMToxMSBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDQvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBMb3dlciBjb252ZXJzaW9uIHRpbWUNCj4gDQo+IFtFeHRlcm5h
bF0NCj4gDQo+IFdoZW4gb25seSBhIGZldyBjaGFubmVscyBhcmUgcmVxdWVzdGVkLCB0aGUgY29y
ZSB3aWxsIHJlcXVlc3QgYWxsIG9mDQo+IHRoZW0gYXMgbG9uZyBhcyAtPmF2YWlsYWJsZV9zY2Fu
X21hc2tzIGlzIHByZXNlbnQsIHRodXMgcmVkdWNpbmcgdGhlDQo+IGltcGFjdCBvZiBhbnkgZHJp
dmVyIHNpZGUgb3B0aW1pemF0aW9uIHRvIGF2b2lkIGNvbnZlcnRpbmcgdGhlDQo+IHVubmVlZGVk
DQo+IGNoYW5uZWxzLg0KPiANCj4gRG8gbm90IHNoYXJlIHRoaXMgYml0bWFwIHdpdGggdGhlIGNv
cmUsIHdoaWNoIGlzIG9wdGlvbmFsIGFueXdheS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9p
aW8vYWRjL21heDEwMjcuYyB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jIGIvZHJpdmVycy9p
aW8vYWRjL21heDEwMjcuYw0KPiBpbmRleCA4YWI2NjBmNTk2YjUuLmQ3OWRhYmYyMDU2NyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0KPiArKysgYi9kcml2ZXJzL2lp
by9hZGMvbWF4MTAyNy5jDQo+IEBAIC00NTcsNyArNDU3LDYgQEAgc3RhdGljIGludCBtYXgxMDI3
X3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlDQo+ICpzcGkpDQo+ICAJaW5kaW9fZGV2LT5tb2RlcyA9
IElORElPX0RJUkVDVF9NT0RFOw0KPiAgCWluZGlvX2Rldi0+Y2hhbm5lbHMgPSBzdC0+aW5mby0+
Y2hhbm5lbHM7DQo+ICAJaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgPSBzdC0+aW5mby0+bnVtX2No
YW5uZWxzOw0KPiAtCWluZGlvX2Rldi0+YXZhaWxhYmxlX3NjYW5fbWFza3MgPSBzdC0+aW5mby0N
Cj4gPmF2YWlsYWJsZV9zY2FuX21hc2tzOw0KPiANCj4gIAlzdC0+YnVmZmVyID0gZGV2bV9rbWFs
bG9jX2FycmF5KCZpbmRpb19kZXYtPmRldiwNCj4gIAkJCQkgIGluZGlvX2Rldi0+bnVtX2NoYW5u
ZWxzLCAyLA0KPiAtLQ0KPiAyLjI3LjANCg0KUmV2aWV3ZWQtYnk6IE51bm8gU8OhIDxudW5vLnNh
QGFuYWxvZy5jb20+DQoNCg==
