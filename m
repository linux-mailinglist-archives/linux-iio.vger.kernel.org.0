Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C843ED4B6
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 15:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhHPNFE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 09:05:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34948 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236741AbhHPNEp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 09:04:45 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17G1GvLH017182;
        Mon, 16 Aug 2021 09:04:00 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0a-00128a01.pphosted.com with ESMTP id 3afe7ast83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 09:03:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSFUnJVQqoo4MevYkdP0eXXfyVS3iPQ48F3PigpC4EVB5ebDX6hCg2b2XjpJbGyalda2XYE/NcCzVagDwLQkoCehO21nRzaajphHXIj6C4Kb0vCZ1HaMwRaHDLBYmnSSL9X+2SYMYKWYWHeh6h0mB6V+LM9Btx8gkj/zd9ysf73V+lQ8YnbmuX5PK86z6/qjvcYaOaTZ0IJH0OVoM54IFdUNdF/vJhs/G+q+SiiRTYeG2ko/1vt17TXLwVUvZyQkejsiaQTCWlDpk0ym3M2b/ojEENCoattRDF7+HvDRnwv+qBtoCITBIo7d312D7fDuj2rWtyeZ4xsFeWkmrnwQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wgj3Z/Xn4i/fgSmC3Dag0rC/RvnvGB2+50ooHM3T3w=;
 b=jpTo/nXwuxYR4K1cqc1s7uu3QVWt0lm0bqQyKZVepY+s9jZWuQ9TLb06SPPNM6Hpp1CAH21Wyqa7ITMOMOcICwp6C+Sla55VRTMH753fCLArFgj7jPiBxOYrPZzxPY45lRRndXRw9fj3ia5/7InQmxFYE4/dCMmOmqPlEsog9NwPbk/1sbgiIiV2MgvdGyOmrNCP2GPAjYMRIT3usPJk/W/PGrH+ZRr38shl5L6Dm9WQA6Sd1/vjTD/7zWQ43inNdjIxYHIxuwnkFTBzcQU9w1eKzHtvnOuRwEzYtiFGQklDcR17QgCkbGWGsClMz/OAHZTVWsI4vf7BFmGOK7z9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wgj3Z/Xn4i/fgSmC3Dag0rC/RvnvGB2+50ooHM3T3w=;
 b=u7bNEBf0E+IeaYdADZ9PYwNMtxS6eKMHakU4VIva+GppBeGjppO1/4O5d3I4WQdf/xdjAtyJ85HNgBNqCx4eKshACYFyB+HnBVjA8TDNrwsxlUKK8TOpPLnyAQ+UWQ/Dx+Wnn94g2qPZbkBUHxTyjQRc6p4yd+m6b50/YIj/s5A=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6236.namprd03.prod.outlook.com (2603:10b6:510:d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 13:03:57 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.021; Mon, 16 Aug 2021
 13:03:57 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: ad5770r: make devicetree property reading consistent
Thread-Topic: [PATCH] iio: ad5770r: make devicetree property reading
 consistent
Thread-Index: AQHXjoTpWS49/XePMUytpStcxW5zfKtud/2AgAD4urCAAANBAIAAEoswgAB044CAAQ8qwIAADCQAgAAhX3CAAfbiAIACmpHAgABLQwCAAAwt0A==
Date:   Mon, 16 Aug 2021 13:03:57 +0000
Message-ID: <PH0PR03MB6366C84B195258BFB4463B3B99FD9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811074827.21889-1-nuno.sa@analog.com>
 <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
 <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
 <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
 <PH0PR03MB63662507607DD7E06995B7EE99FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75Ve=C62FmC20qkLsMVFkc-rbhHqmY2StDtrYqG0=mjtcTw@mail.gmail.com>
 <PH0PR03MB63665918437E96CAF35B7CD799FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210814170204.387bf394@jic23-huawei>
 <PH0PR03MB6366A5DE7A67BE19759E929499FD9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAL_Jsq+joQaYrWNj4sHk4XtTnLurb8vjHrnp2L0yQr3gAJGdLQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+joQaYrWNj4sHk4XtTnLurb8vjHrnp2L0yQr3gAJGdLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5qZzNOVFk0WkRrdFptVTVNaTB4TVdWaUxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEWTROelUyT0dSaUxXWmxPVEl0TVRGbFlpMDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTlRFNE5p?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTFPVEkyTXpRMk16SXpPREU0SWlCb1BTSlFLMnBxUkRG?=
 =?utf-8?B?cUwwaENVRVk0WjBSMkswaHdlV2wyUlVzMloyczlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVSnhSamcwY1c0MVRGaEJZMGgzVjBSak5HMTZSbWwzWmtKWlRu?=
 =?utf-8?B?cHBZazFYU1VaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1743316-086e-4862-5115-08d960b64ed9
x-ms-traffictypediagnostic: PH0PR03MB6236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB6236A454A73FCFD2C6888FBA99FD9@PH0PR03MB6236.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSJfBgjlgHyEJiw1LteiLNNnHw6l3JNHaV+2swS2h5Sx0CX0V/s3gjrokTb2oGGSzthu7bO3xOyF9Ob5oIK/BPLD5qu3d4vCmrRUp9UmSLI3RehWYS2JIruq+wb5cxmo/uwh87C/E99E8gUcFYLQRFZHf4elhbyUILOrJKv+4Nlc0cHc0EbP5oMSvBuR6TF0A0yAKZMjdwRW6Posd5nbLQey7muT8hKaE5rbL1DLgKJ+Vt/prtp2lOQNArZYIXmeJA/u6XR/PppNFMCVHYvJeWP4EhpqP0r7lJU1X+uRZ8XDzyYXI9FdJ2Q8DipqQFrv8+FsiGLQ/a7fAktSF1CDVYcNdhqP2XVjT/fOPcNY+9hy/x2eYce2luQAj3U3Kd7wbcCZr8bVGghjI0YiNUr/Cwd3nepmL9mMeOk8ob4NmO9zM9Xr7qrwU16Vw48+cpGMiKWZxFqSTMZLeYhhis4RNT/GiD4091fq3kCF5hm10o0/O9SKSWqePQDkqfQRS+Q143ocL33MqA/ZOhaYDt+xGNeJucSJWq1/UmgRS65cQvi96YhFWSEkXLZFL9sGJdyiK+sVrjEk8/nxkw15O+YP5f34QZQdpwVim7ZiA9Go8X1XxOH2NsApgEDlu+SpGlgeTrcD/E6jfEnMycVlQCMlHbvOf78v+0j15iwihCiBK230nHwi++Mavkuo9M3bhuPCB8Q/ottPEF+mhNDVg+gWgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(66946007)(6506007)(86362001)(4326008)(8936002)(55016002)(66446008)(64756008)(26005)(66476007)(8676002)(66556008)(76116006)(83380400001)(186003)(316002)(7696005)(71200400001)(38070700005)(5660300002)(2906002)(122000001)(38100700002)(9686003)(33656002)(478600001)(53546011)(54906003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEZkSFNaNHdQem94M01Oa3RvRTB4QUYvS2RyT2Uxemc4d1BEdXBsQ0JhbnZ5?=
 =?utf-8?B?Ty9LZHdjKzZKWmpEM3hXUGJNZFBxVXBsUXZhck1BdDFxUCtCRmF4M3RqU0lI?=
 =?utf-8?B?dE4zSUZxMzY5emVLdERkZWJlQnZkVmo1SFBlWElDc2RXdnE5d2RycS9DZzdF?=
 =?utf-8?B?bmZzZHFOZ0NqVFVQUkVKZUMxUC91NTh6N2lUaWxDdGZjM2lGTVBDSGROMmFj?=
 =?utf-8?B?eTdwNlkwUnBsdCtQZmpvTW1mTXVFQkpMaG1PR1p1YVdVTkYzN1Y4ZFVzeEND?=
 =?utf-8?B?eVdjS3k5aVJyMWxBdkhlUWJrSGpxQUhTNlJPVG1icDc2emJJbkIwVnRpVkFV?=
 =?utf-8?B?SVpiSmY1V25hNWlSeG1HVjZtRmRXMEVYRXhsdVZwQWw5N21mRm1GOGt5T3Av?=
 =?utf-8?B?NG1aRE5yNWlZV1I3b0tadks4U1gyYlZ3YkMwY3ZzYWFxVXJUME9LcVkwYXl3?=
 =?utf-8?B?T3JpTE5wTXVSL1JReVpzVU9ESjBUclIwc1VUdGhGV3ZxcjFRSC9RQ1RqY0RO?=
 =?utf-8?B?TjRRYWFnSm1mQmkvSFhEdFNBUUIzUlJVelY3VWdPdFIzQm5kK0lXSVNyRE9P?=
 =?utf-8?B?bDVmR0ZDNm9YMjFYTWd1RUw1amM3SzQ1Z2lSNTFaWWd6cThEOFVjVlp6R0E4?=
 =?utf-8?B?L2hqd1BmdnZWWDVzTDlkL2MvUWhyU1pXSzBPZUQ4allsQlNSOVd4MEpaYXBJ?=
 =?utf-8?B?eCt2YUExVVNkTThrcERSYzZ1Z29ZQWRQZHpmT0RxR3I2UVVKSlBtNlpETmkz?=
 =?utf-8?B?VjdWcmdiV2lxSmZKVVl1WVp4V0hsc1Y2em1uNjArSEZ6RXZrcSs0dWhIVSt5?=
 =?utf-8?B?K3JlRFZWMlFoTnYyNDBTOGR0UmJFVElaV0FTd1RoZEFieTg0VzVrUThtbDFU?=
 =?utf-8?B?S0x3OXorOCtYWmtLQ0pqNFNOeU9iTHpwQlhMVEpZTGlxV25wR2RxUjBqTkJa?=
 =?utf-8?B?UmhUY0JCTE5IM01hQ2lXOEV6SUhTMW9nbThXUkNPZzF0SXpyV2ZocUZheWd2?=
 =?utf-8?B?TXU5R3BRSDZlRm80RHM3ek1tckUzeFBHZGdHVFA5d05rSlNJeHBJWWp6OFdr?=
 =?utf-8?B?R09KVFNjOWF5RnNtTGpLR0ZxbGE3ZlR3TnJLdG1BODUrUmEyRmFPQmQ3WERU?=
 =?utf-8?B?Nm80OEE4b2tSRk8xeW9YWUpwSWV4OHV0RVM4SnhQRHZuQW9XM1loWDJ1VjZM?=
 =?utf-8?B?cEV0cGdoM2JweWlDRW1ZWm9Wa0VFYnA5MVpRNlhkYjZkSGxtYkZRdmRkMWhP?=
 =?utf-8?B?aFAyYTFzb3lrY3N1UkdqeHhTcnQ0WEw0WUx6S24xQWE2OXhZVnQySU4wT3Jn?=
 =?utf-8?B?SVA5V2Zvd0pOdXlEei9GOHp0cUdBR2tPQ2VLNHNyalI2a2l4QmtlV2tsK1RD?=
 =?utf-8?B?bHZqcWJyWVJNOVY3OTRYSitWc3BPZzlOTmovRzZBZFdBS2JlNG5UT1hDdjRX?=
 =?utf-8?B?K0FsWGVROW8vUitGSElpb1JDY2hGUU42VCtBblFkZElVRlRZdHJ1ZE1tTkJS?=
 =?utf-8?B?M0dhWnE2OEVuVk5Hc2NjRlBabmprWHRHbWhlNUpmbGZkN04zbitmSHczUmww?=
 =?utf-8?B?aGIyN1BzblhTTzlUZTdUeDhhbDZOQS9qVDZURHlZZ3ErUkYxWmRXZHM3S0JI?=
 =?utf-8?B?U3VkNUQ4WFBtRW5ZMWM3Rm5UMzFYSXY5aUt6S3c0YmpzM2VkUzlRNlF2S2RV?=
 =?utf-8?B?Q0lsL2FNTTlPR0lLTE8vSFlWa2VkUXA3akRQeDNYdnY5KzlQblBvaVZ2bXEx?=
 =?utf-8?Q?Ea61EimXvbv3qpHyveig6h79c3BFB7y1pxoad/B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1743316-086e-4862-5115-08d960b64ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 13:03:57.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMLy5fPmcclI5mHobfwTPS6KYIjVpC8vbDX6aliK9Ht28DhTbLZiNk5y7lej36AGmf5mqUF04Gp5SbaWk4wfjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6236
X-Proofpoint-GUID: RtEmbYB6tPb_-nz31Ul0FTyhM0CiwvGY
X-Proofpoint-ORIG-GUID: RtEmbYB6tPb_-nz31Ul0FTyhM0CiwvGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-16_04,2021-08-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108160082
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMTYsIDIwMjEgMjoxOSBQ
TQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gQ2M6IEpvbmF0aGFuIENh
bWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHkuc2hldmNo
ZW5rb0BnbWFpbC5jb20+OyBsaW51eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+Ow0K
PiBIZW5uZXJpY2gsIE1pY2hhZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBMYXJz
LVBldGVyDQo+IENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gaWlvOiBhZDU3NzByOiBtYWtlIGRldmljZXRyZWUgcHJvcGVydHkgcmVhZGluZw0KPiBjb25z
aXN0ZW50DQo+IA0KPiBPbiBNb24sIEF1ZyAxNiwgMjAyMSBhdCAyOjU0IEFNIFNhLCBOdW5vIDxO
dW5vLlNhQGFuYWxvZy5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIz
QGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDE0LCAyMDIxIDY6MDQg
UE0NCj4gPiA+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiA+ID4gQ2M6IEFu
ZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IFJvYg0KPiBIZXJyaW5n
DQo+ID4gPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgbGludXgtaWlvIDxsaW51eC1paW9Admdlci5r
ZXJuZWwub3JnPjsNCj4gPiA+IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hA
YW5hbG9nLmNvbT47IExhcnMtUGV0ZXINCj4gPiA+IENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4N
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzogYWQ1NzcwcjogbWFrZSBkZXZpY2V0cmVl
IHByb3BlcnR5DQo+IHJlYWRpbmcNCj4gPiA+IGNvbnNpc3RlbnQNCj4gPiA+DQo+ID4gPiBbRXh0
ZXJuYWxdDQo+ID4gPg0KPiA+ID4gT24gRnJpLCAxMyBBdWcgMjAyMSAxMDowNToxNyArMDAwMA0K
PiA+ID4gIlNhLCBOdW5vIiA8TnVuby5TYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4g
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBBbmR5IFNo
ZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+ID4gPiA+ID4gU2VudDogRnJp
ZGF5LCBBdWd1c3QgMTMsIDIwMjEgMTA6MDUgQU0NCj4gPiA+ID4gPiBUbzogU2EsIE51bm8gPE51
bm8uU2FAYW5hbG9nLmNvbT4NCj4gPiA+ID4gPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2Vy
bmVsLm9yZz47IGxpbnV4LWlpbyA8bGludXgtDQo+ID4gPiA+ID4gaWlvQHZnZXIua2VybmVsLm9y
Zz47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+Ow0KPiA+ID4gPiA+IEhlbm5l
cmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IExhcnMtDQo+IFBl
dGVyDQo+ID4gPiA+ID4gQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiA+ID4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGlpbzogYWQ1NzcwcjogbWFrZSBkZXZpY2V0cmVlIHByb3BlcnR5DQo+
ID4gPiByZWFkaW5nDQo+ID4gPiA+ID4gY29uc2lzdGVudA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
T24gRnJpLCBBdWcgMTMsIDIwMjEgYXQgMTA6NDcgQU0gU2EsIE51bm8NCj4gPE51bm8uU2FAYW5h
bG9nLmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gRnJvbTogUm9iIEhlcnJp
bmcgPHJvYmgrZHRAa2VybmVsLm9yZz4NCj4gPiA+ID4gPiA+ID4gU2VudDogVGh1cnNkYXksIEF1
Z3VzdCAxMiwgMjAyMSA1OjExIFBNDQo+ID4gPiA+ID4gPiA+IE9uIFRodSwgQXVnIDEyLCAyMDIx
IGF0IDM6MTQgQU0gU2EsIE51bm8NCj4gPiA+IDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+ID4gPiA+
ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLi4uDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gPiBDb3VsZCB5b3UgZ2l2ZSB5b3VyIGlucHV0IG9uIHRoaXMgb25lPw0KPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBUaGVyZSdzIG5vIGNvbnRleHQsIGJ1dCBJJ20gYXNzdW1p
bmcgdGhpcyBpcyBpbiBjaGFubmVsDQo+IG5vZGVzLg0KPiA+ID4gS2VlcA0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IFNvcnJ5IGFib3V0IHRoYXQuIFlvdXIgYXNzdW1wdGlvbiBpcyBjb3JyZWN0
LCB0aGUgYmluZGluZyBpcyBmb3INCj4gYQ0KPiA+ID4gPiA+IGNoYW5uZWwNCj4gPiA+ID4gPiA+
IG5vZGUgWzFdLiBUaGUgZHJpdmVyIGp1c3QgZ2V0J3MgaXQgYXMgJ251bScgWzJdIHdoaWNoIGlz
IG5vdA0KPiA+ID4gY29uc2lzdGVudC4NCj4gPiA+ID4gPiA+IE5haXZlbHksIEkganVzdCB0aG91
Z2ggY2hhbmdpbmcgdGhlIGRyaXZlciB0byB1c2UgcmVnIHdvdWxkIGJlDQo+ID4gPiA+ID4gZW5v
dWdoDQo+ID4gPiA+ID4gPiBidXQgQW5keSBuaWNlbHkgcmFpc2VkIHRoZSBxdWVzdGlvbiBvZiBz
b21lb25lIGJlaW5nIGFscmVhZHkNCj4gPiA+IHJlbHlpbmcNCj4gPiA+ID4gPiA+IG9uICdudW0n
Li4uDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiB0aGUgYmluZGluZyAncmVnJyBhbmQgbWFr
ZSB0aGUgZHJpdmVyIHN1cHBvcnQgYm90aCBpZg0KPiBuZWVkZWQuDQo+ID4gPiA+ID4gPiA+IENv
bnNpZGVyaW5nIHRoZSBhdXRob3Igb2YgdGhlIGJpbmRpbmcgYWxzbyBjaGFuZ2VkIHRoZQ0KPiBi
aW5kaW5nDQo+ID4gPiA+ID4gZnJvbQ0KPiA+ID4gPiA+ID4gPiBudW0gdG8gcmVnIHNob3J0bHkg
YWZ0ZXIgYWRkaW5nIHRoZSBiaW5kaW5nLCBJIGRvbid0IHRoaW5rDQo+ICdudW0nDQo+ID4gPiA+
ID4gPiA+IHN1cHBvcnQgaXMgbmVlZGVkLiBJZiBzb21lb25lIHVzZWQgJ251bScgYW5kIGRpZG4n
dCBydW4NCj4gPiA+ID4gPiB2YWxpZGF0aW9uLA0KPiA+ID4gPiA+ID4gPiB3ZWxsLCB0aGF0J3Mg
dGhlaXIgcHJvYmxlbS4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBT
byBJIGd1ZXNzIHRoZSBzb2x1dGlvbiBoZXJlIGlzIGp1c3QgdG8gY2hhbmdlIHRoZSBkcml2ZXIg
dG8NCj4gc3VwcG9ydA0KPiA+ID4gPiA+IGJvdGgNCj4gPiA+ID4gPiA+IHJlZyBhbmQgbnVtLg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gQXMgZmFyIGFzIEkgZ290IFJvYidzIGFuc3dlciwgaWYgdGhl
IGJpbmRpbmcgbmV2ZXIgaGFkIHRoZSAnbnVtJywNCj4gPiA+ID4gPiBkcm9wcGluZyBpdCBmcm9t
IHRoZSBkcml2ZXIgaXMgd2hhdCB3ZSB3YW50IG5vdyAoYWN0dWFsbHkgeW91cg0KPiA+ID4gPiA+
IG9yaWdpbmFsIHBhdGNoKSBhbmQgdXNlcnMsIHdobyBhcmUgJ3RvbyBtdWNoIGNsZXZlcicgOi0p
IHNob3VsZA0KPiBoYXZlDQo+ID4gPiA+ID4gaGFkIHJ1biB2YWxpZGF0aW9uIGZvciB0aGVpciBE
VHMgYmVmb3JlIHByb2R1Y3Rpb24uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUYWtpbmcgdGhpcyBp
bnRvIGFjY291bnQsIEknbSBmaW5lIHdpdGggdGhlIHBhdGNoIChidXQgdXBkYXRlIGENCj4gPiA+
IGNvbW1pdA0KPiA+ID4gPiA+IG1lc3NhZ2UgdG8gc3VtbWFyaXplIHRoaXMgZGlzY3Vzc2lvbikN
Cj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmR5LnNoZXZjaGVu
a29AZ21haWwuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFlvdSdyZSByaWdodC4u
Lg0KPiA+ID4gPiBKb25hdGhhbiwgZG8geW91IHdhbnQgYSB2MiB3aXRoIGFuIHVwZGF0ZWQgY29t
bWl0IG1lc3NhZ2U/DQo+ID4gPg0KPiA+ID4gUGxlYXNlIGRvLiBBbHNvIHBsZWFzZSBhZGQgYSBm
aXhlcyB0YWcgZ2l2ZW4gd2UgYXJlIHRyZWF0aW5nIGl0DQo+ID4gPiBhcyBhIGZpeC4gIElmIHdl
IGRpc2NvdmVyIHNvbWVvbmUgaXMgdXNpbmcgdGhlIG51bSB2YXJpYW50IHRoZW4NCj4gPiA+IHdl
J2xsIGp1c3QgaGF2ZSB0byBzdXBwb3J0IGJvdGggdmFsdWVzIGFzIGEgZml4IHRvIHRoZSBmaXgu
DQo+ID4gPiBOb3QgaWRlYWwsIGJ1dCBhcyBvYnNlcnZlZCwgaG9wZWZ1bGx5IHBlb3BsZSBhcmUg
dmFsaWRhdGluZyB0aGUNCj4gPiA+IERUcyAod2hpY2ggYmFzaWNhbGx5IG1lYW5zIG5vIG9uZSBp
cyB1c2luZyB0aGlzIGluIHByb2R1Y3Rpb24gb3INCj4gPiA+IGl0IHdvdWxkIGhhdmUgYmVlbiBw
b2ludGVkIG91dCBiZWZvcmUpLg0KPiA+ID4NCj4gPg0KPiA+IFdlbGwsIEl0IHNlZW1zIHdlIG5l
ZWQgdG8gZ28gdGhyb3VnaCB0aGUgc3VwcG9ydCBib3RoICdudW0nIGFuZA0KPiAncmVnJw0KPiA+
IHJvdXRlLi4uIEkgZGlkIHNvbWUgZ2l0IGJsYW1pbmcgYW5kIGl0IHR1cm5zIG91dCAnbnVtJyB3
YXMgYWN0dWFsbHkNCj4gc3VwcG9ydGVkDQo+ID4gaW4gdGhlIGJpbmRpbmdzIFsxXS4gQWZ0ZXIg
c29tZSB0aW1lIGl0IHdhcyByZXBsYWNlZCBieSAncmVnJyBbMl0NCj4gbGVhdmluZyB0aGUNCj4g
PiBkcml2ZXIgdW5jaGFuZ2VkLi4uIEkgZ3Vlc3Mgd2UgaGF2ZSBhIHNpZ25pZmljYW50IHdpbmRv
dyBvZiB0aW1lDQo+IGhlcmUNCj4gPiB3aGVyZSBzb21lb25lIGNvdWxkIGRlcGxveSBhICp2YWxp
ZGF0ZWQqIGRldmljZXRyZWUgdXNpbmcgJ251bScuLi4NCj4gDQo+IE5vIHRoZXJlIHdhc24ndC4g
Qm90aCBjb21taXRzIGxhbmRlZCBpbiB2NS43Lg0KDQpBaGggSSBzZWUuIEkganVzdCBsb29rZWQg
dG8gZGF0ZXMgd2l0aG91dCB0aGlua2luZyBpbiByZWxlYXNlIGN5Y2xlcy4uLg0KDQo+ID4gSWYg
bm8gb2JqZWN0aW9ucywgb24gdjIgSSB3aWxsIGp1c3QgdHJ5IHRvIGdldCAncmVnJyBhbmQgaWYg
bm90IHByZXNlbnQsDQo+IGZhbGxiYWNrDQo+ID4gdG8gJ251bScgYmVmb3JlIGVycm9yaW5nIG91
dC4NCj4gDQo+IFVubGVzcyBhIHVzZXIgdHVybnMgdXAgYW5kIGNvbXBsYWlucywgdGhlbiBJIHNh
eSBkcm9wICdudW0nLg0KPiANCg0KT2ssIHRoYW5rcyEgVGhhdCdzIGVhc2llciBmb3IgbWUuLi4N
Cg0KLSBOdW5vIFPDoQ0K
