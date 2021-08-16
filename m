Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D903ECFC7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 09:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhHPHzW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 03:55:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2538 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234563AbhHPHzU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 03:55:20 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17FKb6hF023567;
        Mon, 16 Aug 2021 03:54:34 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by mx0a-00128a01.pphosted.com with ESMTP id 3afa381akc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 03:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSB83yzQz/VwXchQ1VWE9745GEkYDA0mCnwwhxQ6UikNgyu8GtlkR+buCHPLyGh04r1tPmN12aCi1Hyq6dQAHCESTn+44418EO+oRXt1OKwf9TqVTMMB1EQ+m0qbWbKjswaC78sv0R63OeTLLVJvTYrUwShcZ3yHsCC5ucy2HyreUiY3gxkpANw21R/omg6IqYEPLF1V1fWPsmJ1tGUPbD6ri+D5mdXigZYL5rhgnphvf7OKMfpPRJ9vCS5pgyuYOZOrngG85VFSvCEykMV9jWWQw0iyzqFs4AqwQ+n9vmZud5TF2I1FWjWhIh6WZlX/f1z9Bq3EtNjsZysKSu4n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDJtISNwJ4/wJuIp0b2a5QBJ7HCVTCscKP9BSBJ/YNs=;
 b=RgWCbTmJj3ILv3/ZIWkhtZWFDM9qyJjXYY6i71o1KQXNyRq4f6/GRzHWylQBtx9w16L3JnpMxyhhjYcr0ZXjFBfSK7sw4kgGphvTVqxbYleIoScAYyoNDjJ9ja1FselZQ2oESdosibkCRbzJmCDaYG52LOJBFKOC+BmQzWfeXJUs7Ejv5pWxZvq2APDdo3XO1ti9QHLa5w51+8Y7ywwFcJSDyEd+nf/Qmm0F0kV9vTks9pSMBcqV13qQ7ASF6aRg7xaA4WZNoff4s+JsjlRqZ9Ouj5W6N+NScPMqp+T+bVOjldx8y6SyY0gVE5MVbGGisG5W2/tU7GnjlGE2PLgNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDJtISNwJ4/wJuIp0b2a5QBJ7HCVTCscKP9BSBJ/YNs=;
 b=li3FDQDjcckUkm41XELTIuCLAhYdvsOPZ4w+79/w/DlKipDBRaki7zkIggpCfg00vHBEd+kKjlrtdY/E8PQshBi4g8yIM6WBjkfbw4/wj5GHdB1fWI7jmQweEcTOfG9v0psSU1iUVC78wrch+yZ2fhPMvuQXFB8pPcPgrNivhCs=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 07:54:32 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.021; Mon, 16 Aug 2021
 07:54:32 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: ad5770r: make devicetree property reading consistent
Thread-Topic: [PATCH] iio: ad5770r: make devicetree property reading
 consistent
Thread-Index: AQHXjoTpWS49/XePMUytpStcxW5zfKtud/2AgAD4urCAAANBAIAAEoswgAB044CAAQ8qwIAADCQAgAAhX3CAAfbiAIACmpHA
Date:   Mon, 16 Aug 2021 07:54:31 +0000
Message-ID: <PH0PR03MB6366A5DE7A67BE19759E929499FD9@PH0PR03MB6366.namprd03.prod.outlook.com>
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
In-Reply-To: <20210814170204.387bf394@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1tWXpNV0ppWkRjdFptVTJOeTB4TVdWaUxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhESm1NekZpWW1RNExXWmxOamN0TVRGbFlpMDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTkRJeE55?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTFOelF3TnpBek1EVTNPRFF5SWlCb1BTSTNibUkwVldR?=
 =?utf-8?B?NWQwWlhRMkZPVEZoaFoxTkpOVFl4ZGpONmJXODlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTjVjRFZ5ZUdNMVRGaEJWek5JU1ZKRFQwMTBZVEZpWTJOb1JV?=
 =?utf-8?B?azBlVEZ5VlVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 15cb9d52-37b2-44dd-32f2-08d9608b151e
x-ms-traffictypediagnostic: PH0PR03MB5847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB584703870CD87EF95A64E47E99FD9@PH0PR03MB5847.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mjczmz0iNmeRzcguQoHjD6EMS58ykClo3nh7aLgvGRcmiCphvaNw6KnXCbazATLSMCXpoHQZuznIBHRLIMXsEZvNX2MwXEJ3I3WXAuiQg6XJStwWCZUAnaelrPQL1tZ8uOJz2Y9yPpEeizJ4XGppVU1R+nbVJBBmuldV/mgTmdnVe+kQI+5Q3cqMGBqVOBpT38ourahYoNfU0AyNR7xdkldE5Penv8ei0oAJ7diWGRF10G1niLZQcrOzEjlCQTYZFFaeA9Yhm0PSdEW1+6gosF+EXnT2EBwwhrrkc/XzQW14UvVtvSkwwb4Z5lKZ/aMMqd/7DqNIh9rjBDPHuQUZrnzyJ0+fLKY3JPjoqxJ63WqCHmuMr6kGTQZdPxUAjIZ3f0I4atFSuCSI/enlm4DoSBJLDW3BmgvxLOZYioC4DoJQfhjtmVddZVMaUOz6gv7e8vnk+GLS9KJkIYqLxU7zT9AW3VfcuTlroiU8/qX8MCH/M4/itkr+u1XDiC1i2xiS0+9ulPOczFZ8KmWPyFsNm8GwZom/ihuCPvWi4PEI8hEDCfNj4qYhf8Gz2VE3PLLt0haJbs8EY51yl6uJCZ81wJHofYaxc1jeGl8R8oveIFlpP4C8xbItrILaexfZY1VMmqAfPFpaXyZh6RSr7Q9jSpz8NmcdOUUrLiL42UAKic2Aof1c6GcLdVTRGe+gm/SXOZ77uY1O9t/Plh9e3t9/8drxrzCw00cb9S7rq6KqFtlEDsEEOwd75aco109ejCqxhC7RmhFwTrK7/giy07cBnX2kO6llwtpruuYjduBg9k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(86362001)(52536014)(26005)(53546011)(2906002)(71200400001)(6506007)(5660300002)(83380400001)(4326008)(122000001)(316002)(9686003)(66946007)(966005)(66556008)(64756008)(66446008)(38070700005)(38100700002)(6916009)(55016002)(33656002)(478600001)(8936002)(54906003)(7696005)(76116006)(186003)(8676002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHpKSjhzZ3VCcnpLVXVJZWttNG1TVnMxbitWMGx6TVdPSUxKaWc3SzZyQmdH?=
 =?utf-8?B?aStYaXJXd2lCaldVeGNPNExXaDVoUVVWZmZnb2NkRzV1STQ1cHNPTmo0a3da?=
 =?utf-8?B?L2FMUGZ2bldoY0swWVhncWhwUndsc0pUY0grKzlJTkRUbHp1bGV2OWZyYTht?=
 =?utf-8?B?M0I4QmQ4czJlSjl6YkU2aDlNUXdTalFMVUhqUzRNbU8xdjVqOVdCd3VhQkFu?=
 =?utf-8?B?MHVKemVkVStpc2pMdjA2TTlRdGczdUI1c24rc3hrOTBMTmNEcVRVbDFwRHBT?=
 =?utf-8?B?QVoyNmJCZS9aQ2lwM3BSMnlQMU8yVGtTcFpmTWEyNlpHMkcyczV5dWgvQzZT?=
 =?utf-8?B?MStVYmNWalRzTHlvS2ZxS08wWVlIcmxDMVFHcWFCMmJjQUdiaEh0cWk4TlRK?=
 =?utf-8?B?ZEpHMHF2RnZyYTlkM2RCUWdLOFF3L2p1eVk2cVFZSUcxVGd6MVI4eUF1ZTZk?=
 =?utf-8?B?dms5ZHd3d3ZHUE14ekRSeWlVaWNVS3h5TU1JUmRYQS80RlV1eG5hUTFsOVYr?=
 =?utf-8?B?NHplT1YxU1pUblBCYnNXeHNBVG1FT2FrdGRiZ2dYYVM4RVpxbE81OFhNRUdJ?=
 =?utf-8?B?cStJckovK2xQbHpCUlRaSThJanh1TTBaNEpWMTRFcGdkbldDR2lQTUpOYWxm?=
 =?utf-8?B?dDNHazhJNENvNzVrQlVSRVdDMjB5dEdRS3U3ekUvNm9xeDNmWVRlN2JHQ2RV?=
 =?utf-8?B?ZDRuTlBwZTZPK3hUaGZPZjRES0RLdVJ0UTJnbTdaYkxYZmYyWm9pRGR4WEpn?=
 =?utf-8?B?QmxsdEJYamxDdkhkYUtGaENUdlEzVElSUWQxTTRpMHloUW5XZkNHandiZnBR?=
 =?utf-8?B?a1NzSEN2Q1BzYkdlMllKVHlOT2lTVlJ1VzI1WUtSMllJUG42ZFdqd0hGa3RE?=
 =?utf-8?B?SEFackJZVmo5WFlLS2xOZlV1TytBVUlMWGQ5NEx4UGlLQzcvQkFJUmJmckRv?=
 =?utf-8?B?eUlGeENmTVBheXA4VXIxcUZLZ3VBZGdJNUdHRzBPa0JlOGlPblBoakNhWWNP?=
 =?utf-8?B?T1FzNFBLblZOOENrS0huQk9iMVJOZGlwMFJSOHRJc3YraFhOZVU4ait1SVpq?=
 =?utf-8?B?ZlRJVHRnS0ZZYlRKbEgxSUNBRlJtdlcwRVQ1TVJ6b3lhczFPdXhRWURRYmxB?=
 =?utf-8?B?Z1M1VmtHVzRidkhuMzNCNW9LekdwK0FVTllpSWZuOXRwRkZ0dXc5ZGI4Z285?=
 =?utf-8?B?NU5nQ3RkZzYyZUtFSjBoZ3RhUmVHZXdQYjB3VlFiZjFiN2VDaFF1MzVnc3Nk?=
 =?utf-8?B?LzF2ZitvUktvNDI2bnlnUnE0L054M1AvVzdIV08rSHFTQmpkUXJ2MFkxWXQ3?=
 =?utf-8?B?bUpzZDFFQjEycXFmZ0lvVlQvVzJ6ampBcm1rWjFFZEx5S2VoUXN3c2tzTlNB?=
 =?utf-8?B?R1lPL05tVkN6aWlEWnVHZERBR1U4Z05VN1JxZENLYmVhWEc5Rmg3eC9jcTJO?=
 =?utf-8?B?VkZkbWEyOGJEM2dTcG5XeWlEZUE4NXpOSGF5VmJ2azhNaEhoZUo3QVVHNHJP?=
 =?utf-8?B?MStvOU80TUwxdXcvNk1LbVBqcVJWQ0REeDlpbmdDSXhLWXBFS2RvMm43R0lI?=
 =?utf-8?B?ZldRM2kzS2U3UklpZ0JERXFUUUZnS0NUdndyVUdMbWJOZ2J3ZXMyYVlYRHpk?=
 =?utf-8?B?Y0U5T2o2dlprMXFZbktWd0tpR2s5NDhBSmprbFNvemp6c05pdExTTzI2d1E4?=
 =?utf-8?B?dkFsU0QycXMwS0JmSDNMb1dJWDZoRXN2dW4vdWFXdWJQK0ttMW9SNzR5VTN2?=
 =?utf-8?Q?N/rWy9VKS12aYQANVXpNZwZPZ1yMhgcjedFXxf9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cb9d52-37b2-44dd-32f2-08d9608b151e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 07:54:31.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOe3Nz9ltOuKr8TAzXixalH17JDKIMB8oFG3SX72qWurEgRr8rQpIrS1kSRDwZmDqCQ8hKaWocgKx9JFpi9G9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
X-Proofpoint-GUID: qnlmElfrcssIjdUXsFL99Sb7xvAmMgWz
X-Proofpoint-ORIG-GUID: qnlmElfrcssIjdUXsFL99Sb7xvAmMgWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-16_02,2021-08-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108160050
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAxNCwgMjAyMSA2
OjA0IFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBDYzogQW5keSBT
aGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgUm9iIEhlcnJpbmcNCj4gPHJv
YmgrZHRAa2VybmVsLm9yZz47IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47
DQo+IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IExh
cnMtUGV0ZXINCj4gQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBpaW86IGFkNTc3MHI6IG1ha2UgZGV2aWNldHJlZSBwcm9wZXJ0eSByZWFkaW5nDQo+IGNv
bnNpc3RlbnQNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIEZyaSwgMTMgQXVnIDIwMjEgMTA6
MDU6MTcgKzAwMDANCj4gIlNhLCBOdW5vIiA8TnVuby5TYUBhbmFsb2cuY29tPiB3cm90ZToNCj4g
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQW5keSBTaGV2
Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBB
dWd1c3QgMTMsIDIwMjEgMTA6MDUgQU0NCj4gPiA+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFs
b2cuY29tPg0KPiA+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBsaW51
eC1paW8gPGxpbnV4LQ0KPiA+ID4gaWlvQHZnZXIua2VybmVsLm9yZz47IEpvbmF0aGFuIENhbWVy
b24gPGppYzIzQGtlcm5lbC5vcmc+Ow0KPiA+ID4gSGVubmVyaWNoLCBNaWNoYWVsIDxNaWNoYWVs
Lkhlbm5lcmljaEBhbmFsb2cuY29tPjsgTGFycy1QZXRlcg0KPiA+ID4gQ2xhdXNlbiA8bGFyc0Bt
ZXRhZm9vLmRlPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gaWlvOiBhZDU3NzByOiBtYWtl
IGRldmljZXRyZWUgcHJvcGVydHkNCj4gcmVhZGluZw0KPiA+ID4gY29uc2lzdGVudA0KPiA+ID4N
Cj4gPiA+IE9uIEZyaSwgQXVnIDEzLCAyMDIxIGF0IDEwOjQ3IEFNIFNhLCBOdW5vIDxOdW5vLlNh
QGFuYWxvZy5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBSb2IgSGVycmluZyA8
cm9iaCtkdEBrZXJuZWwub3JnPg0KPiA+ID4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTIs
IDIwMjEgNToxMSBQTQ0KPiA+ID4gPiA+IE9uIFRodSwgQXVnIDEyLCAyMDIxIGF0IDM6MTQgQU0g
U2EsIE51bm8NCj4gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+
DQo+ID4gPiAuLi4NCj4gPiA+DQo+ID4gPiA+ID4gPiBDb3VsZCB5b3UgZ2l2ZSB5b3VyIGlucHV0
IG9uIHRoaXMgb25lPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlcmUncyBubyBjb250ZXh0LCBi
dXQgSSdtIGFzc3VtaW5nIHRoaXMgaXMgaW4gY2hhbm5lbCBub2Rlcy4NCj4gS2VlcA0KPiA+ID4g
Pg0KPiA+ID4gPiBTb3JyeSBhYm91dCB0aGF0LiBZb3VyIGFzc3VtcHRpb24gaXMgY29ycmVjdCwg
dGhlIGJpbmRpbmcgaXMgZm9yIGENCj4gPiA+IGNoYW5uZWwNCj4gPiA+ID4gbm9kZSBbMV0uIFRo
ZSBkcml2ZXIganVzdCBnZXQncyBpdCBhcyAnbnVtJyBbMl0gd2hpY2ggaXMgbm90DQo+IGNvbnNp
c3RlbnQuDQo+ID4gPiA+IE5haXZlbHksIEkganVzdCB0aG91Z2ggY2hhbmdpbmcgdGhlIGRyaXZl
ciB0byB1c2UgcmVnIHdvdWxkIGJlDQo+ID4gPiBlbm91Z2gNCj4gPiA+ID4gYnV0IEFuZHkgbmlj
ZWx5IHJhaXNlZCB0aGUgcXVlc3Rpb24gb2Ygc29tZW9uZSBiZWluZyBhbHJlYWR5DQo+IHJlbHlp
bmcNCj4gPiA+ID4gb24gJ251bScuLi4NCj4gPiA+ID4NCj4gPiA+ID4gPiB0aGUgYmluZGluZyAn
cmVnJyBhbmQgbWFrZSB0aGUgZHJpdmVyIHN1cHBvcnQgYm90aCBpZiBuZWVkZWQuDQo+ID4gPiA+
ID4gQ29uc2lkZXJpbmcgdGhlIGF1dGhvciBvZiB0aGUgYmluZGluZyBhbHNvIGNoYW5nZWQgdGhl
IGJpbmRpbmcNCj4gPiA+IGZyb20NCj4gPiA+ID4gPiBudW0gdG8gcmVnIHNob3J0bHkgYWZ0ZXIg
YWRkaW5nIHRoZSBiaW5kaW5nLCBJIGRvbid0IHRoaW5rICdudW0nDQo+ID4gPiA+ID4gc3VwcG9y
dCBpcyBuZWVkZWQuIElmIHNvbWVvbmUgdXNlZCAnbnVtJyBhbmQgZGlkbid0IHJ1bg0KPiA+ID4g
dmFsaWRhdGlvbiwNCj4gPiA+ID4gPiB3ZWxsLCB0aGF0J3MgdGhlaXIgcHJvYmxlbS4NCj4gPiA+
ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBTbyBJIGd1ZXNzIHRoZSBzb2x1dGlvbiBoZXJlIGlzIGp1
c3QgdG8gY2hhbmdlIHRoZSBkcml2ZXIgdG8gc3VwcG9ydA0KPiA+ID4gYm90aA0KPiA+ID4gPiBy
ZWcgYW5kIG51bS4NCj4gPiA+DQo+ID4gPiBBcyBmYXIgYXMgSSBnb3QgUm9iJ3MgYW5zd2VyLCBp
ZiB0aGUgYmluZGluZyBuZXZlciBoYWQgdGhlICdudW0nLA0KPiA+ID4gZHJvcHBpbmcgaXQgZnJv
bSB0aGUgZHJpdmVyIGlzIHdoYXQgd2Ugd2FudCBub3cgKGFjdHVhbGx5IHlvdXINCj4gPiA+IG9y
aWdpbmFsIHBhdGNoKSBhbmQgdXNlcnMsIHdobyBhcmUgJ3RvbyBtdWNoIGNsZXZlcicgOi0pIHNo
b3VsZCBoYXZlDQo+ID4gPiBoYWQgcnVuIHZhbGlkYXRpb24gZm9yIHRoZWlyIERUcyBiZWZvcmUg
cHJvZHVjdGlvbi4NCj4gPiA+DQo+ID4gPiBUYWtpbmcgdGhpcyBpbnRvIGFjY291bnQsIEknbSBm
aW5lIHdpdGggdGhlIHBhdGNoIChidXQgdXBkYXRlIGENCj4gY29tbWl0DQo+ID4gPiBtZXNzYWdl
IHRvIHN1bW1hcml6ZSB0aGlzIGRpc2N1c3Npb24pDQo+ID4gPiBSZXZpZXdlZC1ieTogQW5keSBT
aGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiA+ID4NCj4gPg0KPiA+IFlv
dSdyZSByaWdodC4uLg0KPiA+IEpvbmF0aGFuLCBkbyB5b3Ugd2FudCBhIHYyIHdpdGggYW4gdXBk
YXRlZCBjb21taXQgbWVzc2FnZT8NCj4gDQo+IFBsZWFzZSBkby4gQWxzbyBwbGVhc2UgYWRkIGEg
Zml4ZXMgdGFnIGdpdmVuIHdlIGFyZSB0cmVhdGluZyBpdA0KPiBhcyBhIGZpeC4gIElmIHdlIGRp
c2NvdmVyIHNvbWVvbmUgaXMgdXNpbmcgdGhlIG51bSB2YXJpYW50IHRoZW4NCj4gd2UnbGwganVz
dCBoYXZlIHRvIHN1cHBvcnQgYm90aCB2YWx1ZXMgYXMgYSBmaXggdG8gdGhlIGZpeC4NCj4gTm90
IGlkZWFsLCBidXQgYXMgb2JzZXJ2ZWQsIGhvcGVmdWxseSBwZW9wbGUgYXJlIHZhbGlkYXRpbmcg
dGhlDQo+IERUcyAod2hpY2ggYmFzaWNhbGx5IG1lYW5zIG5vIG9uZSBpcyB1c2luZyB0aGlzIGlu
IHByb2R1Y3Rpb24gb3INCj4gaXQgd291bGQgaGF2ZSBiZWVuIHBvaW50ZWQgb3V0IGJlZm9yZSku
DQo+IA0KDQpXZWxsLCBJdCBzZWVtcyB3ZSBuZWVkIHRvIGdvIHRocm91Z2ggdGhlIHN1cHBvcnQg
Ym90aCAnbnVtJyBhbmQgJ3JlZycNCnJvdXRlLi4uIEkgZGlkIHNvbWUgZ2l0IGJsYW1pbmcgYW5k
IGl0IHR1cm5zIG91dCAnbnVtJyB3YXMgYWN0dWFsbHkgc3VwcG9ydGVkDQppbiB0aGUgYmluZGlu
Z3MgWzFdLiBBZnRlciBzb21lIHRpbWUgaXQgd2FzIHJlcGxhY2VkIGJ5ICdyZWcnIFsyXSBsZWF2
aW5nIHRoZQ0KZHJpdmVyIHVuY2hhbmdlZC4uLiBJIGd1ZXNzIHdlIGhhdmUgYSBzaWduaWZpY2Fu
dCB3aW5kb3cgb2YgdGltZSBoZXJlDQp3aGVyZSBzb21lb25lIGNvdWxkIGRlcGxveSBhICp2YWxp
ZGF0ZWQqIGRldmljZXRyZWUgdXNpbmcgJ251bScuLi4NCklmIG5vIG9iamVjdGlvbnMsIG9uIHYy
IEkgd2lsbCBqdXN0IHRyeSB0byBnZXQgJ3JlZycgYW5kIGlmIG5vdCBwcmVzZW50LCBmYWxsYmFj
aw0KdG8gJ251bScgYmVmb3JlIGVycm9yaW5nIG91dC4NCg0KWzFdOiBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0
Lz9pZD1lYTUyYzIxMjY4ZTY4Y2ZkYzFhYWJlNjg2YjE1NGQ3M2Q4YmY0ZDdlDQpbMl06IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21taXQvP2lkPTJjZjM4MThmMThiMjY5OTJmZjIwYTczMGRmNDZlMDhlMjQ4NWZkNjcN
Cg0KLSBOdW5vIFPDoQ0K
