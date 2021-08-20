Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C53F27A5
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhHTHbC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:31:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48062 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhHTHbB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:31:01 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17K5BSkV019307;
        Fri, 20 Aug 2021 03:30:10 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00128a01.pphosted.com with ESMTP id 3aj61f0px8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:30:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be9EGEHwfnp24VEO9Ml3Wj0lS3SlMPlgKjnsIh6b2D5vRdl6dHZYB/rGmLlihAjz4jyE8djyd/2giYDU5+HUZbjeeVEgmC5kLKo4PV54cLy7cazPoEbwXD3xSIOGc9eaGZAbUFXB7mxm+Jce0n7cNEgJ5hJJW1adyDn2KcNKBwEAua4+pPef7auTi4GsC8RiOhCndzEGsEiostYHWzMSY2JT/WnOIH5HuwQv+O07Rx5ar98t5M9J4rHVNVFs9ORLqaQ/5yF2IrXzZS+x5MAJDvW6hnqAsEpZtrI1waWvu0Sf6vnkkNeLmDEuvfX/o1kgb4WqbHU8mA+iIgr7Y/8Pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEXINNl/BEVH2w2NpEteMGMYhvwmTjK/rd8Ij9sFzGw=;
 b=oX6gF7Mgcez8vrASQEaqUU30JwbNNHN0T8CaluAr+c7xSeGs9/lK/x2La27HkIDlHqlMxZdu/8elOv4YkezJA2CBkq83kWU85e472TxRw19VzsihbdmZsF3m8dlSfpzRl8bYzViaGUzLWsJq+P9mEO7WFQxX+9Ohs/WISL7Kh4BRWyAsryG4RkNSwDtxwAju0FSkoq7H9l+ZwmhA3/UmLNhwlggnAV5mtcmQS/PIBILgMI1AwkXM+6FQFFYYNuzpeFfIp+WCLy0Tmx7GAz5vGDEL6fllY7rrTsY3AUYY1rwD3VXP1Vz2xvyIfcMKld3UlchHrG6R2PbPlIvTldKRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEXINNl/BEVH2w2NpEteMGMYhvwmTjK/rd8Ij9sFzGw=;
 b=mkKgqmwAPCJBMtcw2b8MtXCu7Wvx4hBn9VN/0a+9l0hqsnIf8ECEwln7pSb8h+3YBQZj9ZtDzmyQ0n+OHZMPwAi7RQm7Mcxb+FeLur/B7Csm1cl7Bq2qZ3GiyRruQqn1soi0/eJBapZbzIQ9D8Bx17z2kxZ3EMGtmYGgoP44Wio=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by SJ0PR03MB5902.namprd03.prod.outlook.com (2603:10b6:a03:2da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 07:30:07 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:30:07 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 10/16] iio: adc: max1027: Prevent single channel accesses
 during buffer reads
Thread-Topic: [PATCH 10/16] iio: adc: max1027: Prevent single channel accesses
 during buffer reads
Thread-Index: AQHXlCHwwUDElOtgskK3oBAOzRZBB6t7/uqggAACwAA=
Date:   Fri, 20 Aug 2021 07:30:07 +0000
Message-ID: <SJ0PR03MB6359DB255A253092BFDC04F499C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-11-miquel.raynal@bootlin.com>
 <SJ0PR03MB635942A6E93291B5134350B799C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB635942A6E93291B5134350B799C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE56QXlOR1V6TldVdE1ERTRPQzB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEY3dNalJsTXpZd0xUQXhPRGd0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpNME9D?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGd5TURZd05EZzFORE00SWlCb1BTSXlWbVJpU0RK?=
 =?utf-8?B?WE4yOW9hSFpDYWxKR01VTlpRMWcwSzJOVVVEQTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRXJkVE13ZVd4YVdGaEJZVXRyY1N0QlV6RnpRamR2Y1ZOeU5F?=
 =?utf-8?B?Sk1WM2RJYzBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dea6c66-8775-40e6-2910-08d963ac55dd
x-ms-traffictypediagnostic: SJ0PR03MB5902:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR03MB59025815B5AAA400B656852B99C19@SJ0PR03MB5902.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6F54F5c8NN2nraRuF+6jaVlY6gI9QWb9QtjTovR+OhpauwGNce4AxwOCT7kLyAo/w0mOTGRTR9VPPXGHaDNbFniIUAl8R8KpSBl0F1VpGQnBEMyzNaTSf34WyoWqTTOV/aay2x89Tw7FbDHVtwyJXVvu4nSqHKZR7uJAoHHUca7odqK9NR/YHTP+ibCizKH+TzuRuemM/n6E2OUpEfdinN3hA7qOMevaoqIPSC8mcOmOFhPEvEoC3BFKz18yLy9kDFs4c/nsAh5sB/CmDMi5b6baaWV+M445bfPyUNfrBK8M9cm41lvU7N/l25RSOZhoxXdnSIYJFqU/9kra8rU2PFN/gvYQ0LO77YeSfy1QjUwv4JLJOYnxyeb7lQt1SBAKkueYKJCBVMZXeDsinOOUsF+TPn5mJ8KeZ2mZ94xo8HSQuTJlSSHhC91+RwxahTk6ml5vPJ7c4ZamPotZU/tiu5ovlgnlTn+TgpigOYHkKYMSxF1/Fblu3X7QtPAEp98SHkrrFU3OfnPiIYCxQs62ieYjHBm0OySeNW3lPWa0sQOFSHlNmQWsDEWHkl4z5JHaDxflihSY82sFGevAMH0qCaN1bvCL3HqNTlvNVSVGVQ3eEFf1ydv5AQ5wgtyrQvT8TTQofCYbvBBppoIgD66BcKjb3DmNKqcx5Hn6Hs1wFm3w4Zcilgc8wPn8X6rBBwBHc/k1vDw/WsE5D4Q0H8ZFUpBLAKTZNJ8ThDptVVLUqQNOYEuCJGW41EM6ND5z/gLKHBhbblwelIhSjZO0rrrHyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(71200400001)(54906003)(66946007)(76116006)(26005)(52536014)(2906002)(186003)(86362001)(53546011)(64756008)(66556008)(66476007)(66446008)(966005)(5660300002)(478600001)(4326008)(33656002)(83380400001)(8676002)(7696005)(38100700002)(55016002)(122000001)(2940100002)(38070700005)(316002)(9686003)(110136005)(6506007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1VZNVYrYVhyYktSYTB2TkIvSHFDN29wSFBpYzMveGhTcWJwY0FrTHY3amdJ?=
 =?utf-8?B?VkxQejFYWlpVQmZVY01rRngrcjBlckoyT1RUTy9obTZ1R0dGZFN5V3lRQmo2?=
 =?utf-8?B?VEdhTXpHbW84WnJoM0RnL2ZBZkRHNmJyb09XSG54YkhPMkFjZFdOcHNhNVE0?=
 =?utf-8?B?YTU3WjlUT2lqQjJpc1Q0TWJYbzFPR2d5MjQ1RldNcmV4UFpFRlFwd1VFVUV5?=
 =?utf-8?B?cjlPMVAzWHVQU1p2dlNuOE5PQWNIbW5rRDcwWTQ1R3NpMnZId0FjTlFVaytp?=
 =?utf-8?B?L2hBQ3N3QWRHdU9qbGdaWi94ZXJEbTVUSDMrWFZKQ0ZJL01VTHl3U2kvRFFu?=
 =?utf-8?B?UzYzZTYzWWdPRW5IdHV1cUJWVGFKMS95eHo5c3MxZkU4K3N1KzFOMy9EWlJM?=
 =?utf-8?B?MmlUWmpMSnkwSmhTbVAydmJDYlBQR0Y0U09Zc3pNM2tqbHN6MHJ4U29wUER6?=
 =?utf-8?B?M0JFVUlFaFEzUVFYZm90cldWSU93TlduTnpZclZJUDI1KzBNWVFpZ04xenRJ?=
 =?utf-8?B?c0twcytnWm4wTzdGRXhnL0wrQzNQVTNnc3l1MXkxM1ZvbHpjZ3hJa2cvWGVy?=
 =?utf-8?B?Yi9kU3o5alMybWpaWFJzWEIzaWs0c3M0Zk9EZkpKL2hra3dlaE1HYVhpdFRG?=
 =?utf-8?B?ZXNJSXRiWW5QQ1IrSlhIYUs4N0xFVFdWVUNuMzE1eElKdGMxRGFMcUtieXpw?=
 =?utf-8?B?MHZJNVlMZ1loVVB2VHRHbWdYdE5sampIa0NodktndUVqbVJEeTB3TmFvN1d4?=
 =?utf-8?B?ejA1OFJQbWtkSzc2TWZUNWtXcFhERmFYaTFDL2NCQzhwa0d2elpqSkthRmty?=
 =?utf-8?B?ZXJNa01KUDVpM2RXMWNZL0dBWm45TWRpQ1pXdzRWQ1lEYnVnVkRmM3A3aWdl?=
 =?utf-8?B?cUQvZHRTVlMzaHM0NnRQTkFzOVB4SVdrZjFQS3M0dzFlakNOcGFsZ3hLRDNU?=
 =?utf-8?B?bWtqN0tXbkt2TVZyQ0pHWHIydENMbWRNcjB1ZUZQYURQM3NtMVB2RExYVlJ6?=
 =?utf-8?B?WFBFb2xiSENvUmxRaU1vamljODNCV0ZrZzVlWDBoOWlDUWxQeFg2eTVqenZO?=
 =?utf-8?B?TEs3Z3FuWjhRdXFRZXA2U1NUbzRqK3FySzNkSnRKWGtCbjM5Rk1mZTdpNGw4?=
 =?utf-8?B?LzMxYnQ0MDIyYThmQmhwdm5mYzBuZloydkhDZGJNd1JCc2xSZHd5cDR0YzVV?=
 =?utf-8?B?VGIzbXRlUFVvV214OWltaERlV3BNZmRZRXJsK2luYnB2N1hidGFnYktMK3k1?=
 =?utf-8?B?MUZqYkZlcDdVWE1yMjEyRGpRR08yRE44MENPa05mb1lGVUE5S3p3RCtBM3Zk?=
 =?utf-8?B?eUs4K0JtczZUZ1FCamRrbUpKNlVJYjR5OUhBZ3J2Ni9HZmtqZnlDMlBSdEJ6?=
 =?utf-8?B?RUIreUJRYUw4UllBN3RFQVNqRFE5TVFseTl1R3BpUGZFV1ZIV0p2bzdtL2RV?=
 =?utf-8?B?VlJWSGtPcUZQSmR5VG9XY1lDdXc4YmZyNS9iTEROU1AyaklhTithYWJMRlNH?=
 =?utf-8?B?eThxcnRUYWlKUnJ3di8zcUdMaUY3aFY4TmpVQ0Nlb2RTdFpDOUJqZHk2RThq?=
 =?utf-8?B?OUhkS01oR3dIMjBtcUhBbEV3U2xGcVREYzBaR0YwNGJjK0dUc1k3WFNKYnU5?=
 =?utf-8?B?ajdxbC9mdDVZeE1HK1IweUpHbjZ1RmJmTmQrc011QndRVFJFRk01Q0xIYXRs?=
 =?utf-8?B?OGh1aHpFcmhseFJyMk4zNUZtNHdRemZUSU5NVUtveGcwOXdCK0J2RE5wcU1j?=
 =?utf-8?Q?T6Huiur1Ju+YNouGfLq8o9tzIwUBdKGmvHN7aF6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dea6c66-8775-40e6-2910-08d963ac55dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:30:07.4642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZislyLdCbz/FO/9TEsuUJW+hk+d2KJC9LXyZGH1yURasyPydczg0oXzi0l54P2GObIFaP/0sf/7xJbGLrCSEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5902
X-Proofpoint-GUID: bDaLtSFw7LBdHuNZK-OswRRFbSE_GtV8
X-Proofpoint-ORIG-GUID: bDaLtSFw7LBdHuNZK-OswRRFbSE_GtV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108200043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2EsIE51bm8gPE51bm8u
U2FAYW5hbG9nLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjAsIDIwMjEgOToyMSBBTQ0K
PiBUbzogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT47IEpvbmF0aGFu
IENhbWVyb24NCj4gPGppYzIzQGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNA
bWV0YWZvby5kZT4NCj4gQ2M6IFRob21hcyBQZXRhenpvbmkgPHRob21hcy5wZXRhenpvbmlAYm9v
dGxpbi5jb20+OyBsaW51eC0NCj4gaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDEwLzE2XSBpaW86IGFkYzogbWF4
MTAyNzogUHJldmVudCBzaW5nbGUgY2hhbm5lbA0KPiBhY2Nlc3NlcyBkdXJpbmcgYnVmZmVyIHJl
YWRzDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiBGcm9tOiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4u
Y29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE4LCAyMDIxIDE6MTIgUE0NCj4gPiBU
bzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNl
bg0KPiA+IDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gQ2M6IFRob21hcyBQZXRhenpvbmkgPHRob21h
cy5wZXRhenpvbmlAYm9vdGxpbi5jb20+OyBsaW51eC0NCj4gPiBpaW9Admdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFsDQo+ID4gPG1pcXVl
bC5yYXluYWxAYm9vdGxpbi5jb20+DQo+ID4gU3ViamVjdDogW1BBVENIIDEwLzE2XSBpaW86IGFk
YzogbWF4MTAyNzogUHJldmVudCBzaW5nbGUgY2hhbm5lbA0KPiA+IGFjY2Vzc2VzIGR1cmluZyBi
dWZmZXIgcmVhZHMNCj4gPg0KPiA+IFtFeHRlcm5hbF0NCj4gPg0KPiA+IFdoZW4gaGFyZHdhcmUg
YnVmZmVycyBhcmUgZW5hYmxlZCAodGhlIGNudnN0IHBpbiBiZWluZyB0aGUNCj4gdHJpZ2dlciks
DQo+ID4gb25lDQo+ID4gc2hvdWxkIG5vdCBtZXNzIHdpdGggdGhlIGRldmljZSBzdGF0ZSBieSBy
ZXF1ZXN0aW5nIGEgc2luZ2xlIGNoYW5uZWwNCj4gPiByZWFkLiBQcmV2ZW50IGl0IHdpdGggYSBp
aW9fYnVmZmVyX2VuYWJsZWQoKSBjaGVjay4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvaWlvL2FkYy9tYXgxMDI3LmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5j
IGIvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0KPiA+IGluZGV4IDIyM2M5ZTRhYmQ4Ni4uODM1
MjZmM2Q3ZDNhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMNCj4g
PiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+ID4gQEAgLTMzNSw2ICszMzUsOCBA
QCBzdGF0aWMgaW50IG1heDEwMjdfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYNCj4gPiAqaW5kaW9f
ZGV2LA0KPiA+DQo+ID4gIAlzd2l0Y2ggKG1hc2spIHsNCj4gPiAgCWNhc2UgSUlPX0NIQU5fSU5G
T19SQVc6DQo+ID4gKwkJaWYgKGlpb19idWZmZXJfZW5hYmxlZChpbmRpb19kZXYpKQ0KPiA+ICsJ
CQlyZXR1cm4gLUVCVVNZOw0KPiANCj4gSSBndWVzcyAnaWlvX2RldmljZV9jbGFpbV9kaXJlY3Rf
bW9kZSgpJyB3b3VsZCBiZSBhIGJldHRlciBvcHRpb24NCj4gaGVyZT8gVGhlcmUncyBub3RoaW5n
IHByZXZlbnRpbmcgdGhpcyBjaGVjayB0byBwYXNzIGFuZCB0aGVuLA0KPiBjb25jdXJyZW50bHkN
Cj4gc29tZW9uZSBlbmFibGVzIHRoZSBidWZmZXIuLi4NCj4gDQoNClRha2luZyBhIHNlY29uZCBs
b29rLCBpdCBzZWVtcyB0aGF0IHRoaXMgY2hlY2sgaXMgYWxyZWFkeSBkb25lIFsxXT8gQW0gSSBt
aXNzaW5nDQpJIG1pc3Npbmcgc29tZXRoaW5nPw0KDQpBbHNvLCBJIHRoaW5rIHdlIGFyZSByZXR1
cm5pbmcgd2l0aCB0aGUgJ3N0LT5sb2NrJyBoZWxkLi4uDQoNClsxXTogaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5j
I0wyNDcNCg==
