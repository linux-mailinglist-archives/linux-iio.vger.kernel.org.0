Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC868387B08
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349946AbhEROWo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 10:22:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6950 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241291AbhEROWn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 10:22:43 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IEGMg9007516;
        Tue, 18 May 2021 10:21:11 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-00128a01.pphosted.com with ESMTP id 38kuvp3fq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 10:21:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffhfSpQsEjq9Ofl3wWrxyPEx3ZS+9m3zogfwWJ+Qkf4nVwQkXcinyU1sYQGlDtHeJrnNYaSTFa/4YP5NIAdLlu27yYc2rYUeKROhS8WNuzzSEs8TXsqY72HNXbEIdj5Og/r/rpckrKa+LHZBgX4cCB8eBPLs3DuHHgZToZEQPtZp100HU2XhS3bIJakxFWhIMMFmKr0UWgcWIRRMcIRkFeVHlOMJwJm+qlqo0R6CSy2InV2+7YL9MdSes3b1TaiyTV/W7Rum7ARL7ird8FAypLRqHwAmw0HGxXfeti1hUccfOkDH8O5aBbOniz8IkMRbrfLm/+TAdERSRq0SMEv5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1Tz9mIUNDqkAm2mQH/PpcFWkVJK2i/vmZWuKIYmPSc=;
 b=LpQM+A2mDtArJJRoPL10HmMRnD/oVVpWXrWDVgpTU3Q9l9fNxaL8O7QHAShxYKd4clyNBz0dyLz7JGLksI65/lcMwoXPcKuwHMSngadhzusKzpvfKYdz3VYkr8PH6nY7z6MO4WGRVu8/2yE1U1fha75SWMPWhOVPIT3jybeRyeGrNn/+HosIfA7QSWsoGuzbHWpaaJ1ffRBpDGRIZZor74lmNxZMFouv3Zr9g0VWkRkCUd4plTV4PtaPY98ecBc5yP3puQHUb+iVKzcZE+ZaPQC8xE4ZOsIxnLuK3G3rWPoKQSztf28+vDdLXqTYt1tmRBw59jbyiuXGiYmltOy76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1Tz9mIUNDqkAm2mQH/PpcFWkVJK2i/vmZWuKIYmPSc=;
 b=fg+cZXNvyqsUm0GLEEzP3cZ1A5dli/TzbTjwcuq4PYLsfNYfkdVzslFniB0YKefwDul46UccLeBpDiC6hnIesCJf0qlJeyvlfZeW+pmnw9Hs/434ZyghhSSWB5B56mrQIZAWC29GkenAgLswgD7uNil1uAtm0kVLiKKC7dseqPM=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5720.namprd03.prod.outlook.com (2603:10b6:510:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 14:21:08 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 14:21:08 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v4] iio: adis16480: support burst read function
Thread-Topic: [PATCH v4] iio: adis16480: support burst read function
Thread-Index: AQHXN2M4NSNqRiEaEE6KRMvBqtrdh6rDjC4AgA9vwHCABsoigIAPqSGg
Date:   Tue, 18 May 2021 14:21:08 +0000
Message-ID: <PH0PR03MB6366E94DF97823BE26BD0EBC992C9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210422103735.136367-1-nuno.sa@analog.com>
        <20210424123216.317e9b34@jic23-huawei>
        <PH0PR03MB6366E7F728971DAF5B867898995A9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210508155709.38eaaa7b@jic23-huawei>
In-Reply-To: <20210508155709.38eaaa7b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5EYzBPV1l5TWpjdFlqZGxOQzB4TVdWaUxUaGlOVEV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEUTNORGxtTWpJNExXSTNaVFF0TVRGbFlpMDRZ?=
 =?utf-8?B?alV4TFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpFMk9T?=
 =?utf-8?B?SWdkRDBpTVRNeU5qVTRNakV5TmpVeU56VTNPRFUwSWlCb1BTSjFSVGg2TUVF?=
 =?utf-8?B?M2MweERjVmw0YTNSeVJFWk1aREp3YURsUFFWVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVSmxjemRSU2poVmRsaEJVMFZqYzBkaGJHWjROV3hKVW5sM1du?=
 =?utf-8?B?RldMMGh0VlVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRV0pLVUZOa1VVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61d2539e-847f-440f-477a-08d91a082e43
x-ms-traffictypediagnostic: PH0PR03MB5720:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB5720527EAA7FBDE33828523F992C9@PH0PR03MB5720.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3vYGtFCbCLHBdXWjwWoGr/UZH6SrLBiLS+iDVKLKqctc8RNs9nzzBeGag759xUhvbOM/uymFQA0AKqnJo015Wvqeom7Y59vOin4VYjpLgQLkoRlCtcLl1XUWGqbPqxXoqthKEfnJjOt5HfbIi2rqzrCWwEaQT7q9FbjLyaCIrmpDtxQY2HDiSORyqeOUzG0lL7s0kvFkYyWYQqnMGcF7pOL775IPCvvr1oN6X6FdRanQLMRpTCUYgZNm70skzyabE/QulRFijCpxJ8EN+mEnYRXXkz7xDbimrLEpHOHOu9DelzRQyK8t1LEQ9OTIc5YsxaeHfn9jbjhx7r1+8aQk2hlF+6/tZo2jo4gncAlsQ+geVFCFXv59XVVysdmZYKbkn67MT31l8DQlxt4sKrfPn2dXP+SkzJJOkLrMIiRSw+f6DSsNSOx1Dc3fu9XgRWIELCkGeHZUsFpqfwR5vLDzJ3G+T1eniknOBZk9ctmOcUOA3WTDqz1M1tDCN2OyTx8dIp2M1HWxRJhgQ6VRkPrjy6Wcb1/QmBiWZ2C8yMjCQanjN4Vrm/AtugQ9MqYOZcW9YYaLTsrIrTc9fI6XdNKKPaXIbA7xqHSKmkCCfXWSLU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(4326008)(83380400001)(8936002)(8676002)(6916009)(71200400001)(2906002)(6506007)(53546011)(5660300002)(86362001)(7696005)(26005)(478600001)(316002)(9686003)(54906003)(66556008)(66446008)(64756008)(66946007)(66476007)(186003)(55016002)(38100700002)(76116006)(33656002)(122000001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VkFwOER4TGZxeU51cWU4bU95Sm9WWnBHb3BzMlFkQVMrTkR5aTNxSkJvZFJ6?=
 =?utf-8?B?ajU3Mmd1eFJyVThXdjlJb3lOTkU0TjRyYkU1SjU4YW5UbFhGVk1Tc2R6Ukpi?=
 =?utf-8?B?dUFSeTZZYm9DU3dVVGNDQWw0TFB6MXE5RzAxakFRb0dCbEpJZjQvbzFoVjlz?=
 =?utf-8?B?b3pCWUxqNi80SmJsbzFkZzQ2aTQydERMR3RHOWlIL0QxMnMzNFhpdm9aR2Z6?=
 =?utf-8?B?TVJKcFZNRUhGZU5ydUtYaTgvTVFSTmcvNXVDa0QrcGxIZVd2dVU4WUw2eVhl?=
 =?utf-8?B?bGx4TU4zcVBIQjUvd0hrRWVXc1VYVWxhTmsvQmJZRkNreDUzSHl3eFM4L2l0?=
 =?utf-8?B?ODFvVXNvWTAreElxZ2NNYzlDY202bHpkYVBSa3BaQ1EwZHduVDZJdURDREZQ?=
 =?utf-8?B?ZSs0ZkE4NlcvekZYSTRuWTd0VzlsaEEyLzZ0Uk1Dcm9CYzl3K0RPUkRnMUZ1?=
 =?utf-8?B?Ylh5WFduOFV4bVcwWjVQTXlLL2dRbTYxVHhsY2pUNktoOWVkY3dxd0xUU0E3?=
 =?utf-8?B?Sm5STlkwbG1jRzhJRHJxU2VqWGNKSnM5QjVuREpNVGZZVk8vSVNSWkJ2UW0r?=
 =?utf-8?B?bDdzUW5JMDBTLzY3cHNXYW5PVDdEbmRDR0M1THJ4b3lxdGlZdmFEcUFwK1dY?=
 =?utf-8?B?M1Y5bXAxRzZJeWJ3VW9zRVFJUThhZHJGMmpQeGxPSTEwUjlSU2wvT2lZWUdu?=
 =?utf-8?B?Vm9acGZKdnVPY0VSc1VVVllBbURZcGF5Q3ZoY0ZJdG4vaDVremdBbWlqd1pi?=
 =?utf-8?B?YVR2MEJObndYWGRqUkFzak04eW9RQ0NadUtjdnJLbEwvNlhWV2MzWGF1UFc3?=
 =?utf-8?B?SnExWlhnejJzRUVCRG9uTzhpUnUrY2tTOU5kWU0raTArbjdhdnJYR0d2VmxF?=
 =?utf-8?B?SCtadnByZlNQWW9ISjhqczJ3ZHhUTkhVTjhuWEJNc3BSejhqRkFVU21mZk5B?=
 =?utf-8?B?cEpSTVBRbnNmb1ExMElzb2hOWjRjL1cxOSt3N3JTNGMwdmZOdVRMMmN6NHcw?=
 =?utf-8?B?UkRISmVsWlBGdGhNYmV6MmpKdEZiOWpmd21NV1lVejVkZTFlVEhDMlh5VnhU?=
 =?utf-8?B?dnJYcTZSUlhIQkpZaXpoaG9WVzZkRCtBdkNESWJHNzQvdThYZ2dCMDNNZ0w0?=
 =?utf-8?B?MVB0YjFybTBlNFd1VCtmLzFDaWtKbkgzeTI2b0drU3ozako5YjMrYU1Icko0?=
 =?utf-8?B?Vy9Cdkp5RjZyazM1c2pWTzBtYzBBeWY0NFVGQWk3SnVLLzV2L1JuU00wRVgw?=
 =?utf-8?B?aFhLM2xXazBJTk0vVXp3ZjhsZXZiM1J6STRJYXhPcUFoZjcySzJWbktsQWxy?=
 =?utf-8?B?eUVOYlB6T01lT2luVlBKUnJqQU40enA3MWJEYUVTVUJ1RGk2bE9mM1A1ZXoz?=
 =?utf-8?B?dlVSNU9hVFpweW82VzVucEl1MUtlNVVNUnhFSkpDVXhFSVJpcm92VVg1UmRD?=
 =?utf-8?B?Tmlac0Vrc3NyM1RJYlJ5UlBmc1FDcWsxcE5URnBRSTV0Skhqa3BWbHZSNWg5?=
 =?utf-8?B?Nm85dnY0UElQaGdPUWVBY09Ld2xPV3orTHpJY3FoSWlDNVNTc0MrZUlhMUh5?=
 =?utf-8?B?eUtENDRIWGRuY3VUY2ZlbSt6b1BidVVOL1dGbm9ZQ01jdUlpcHRzcUJqNTcv?=
 =?utf-8?B?bUJSeWcxektmUjNaR3hoL1Zzdy8wYkc0NjZxaFZkMXJjMFpucjJHV0hhOTZs?=
 =?utf-8?B?clNkMXJNQ3E4K0dZZThseFMyTDl0VDhLVXdnZTZYRXloY0ducUVKZjl4eXA3?=
 =?utf-8?Q?EvxKIQLkmszlOEe4o8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d2539e-847f-440f-477a-08d91a082e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 14:21:08.5896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbuJSYILOH7PyAZGq2Pa70x3mTHygcgdK7EYBDaXwufGAboAqbA2H/p0HlGhLJDi5DDMpj62eugd+7oe/tw6Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5720
X-Proofpoint-GUID: vEe_Xtk6w7ojQkqnyGsPHoCEJWkhE2RO
X-Proofpoint-ORIG-GUID: vEe_Xtk6w7ojQkqnyGsPHoCEJWkhE2RO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_07:2021-05-18,2021-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180102
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9u
YXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIE1heSA4
LCAyMDIxIDQ6NTcgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
OiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPE1pY2hh
ZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBMYXJzLVBldGVyIENsYXVzZW4NCj4gPGxhcnNAbWV0
YWZvby5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gaWlvOiBhZGlzMTY0ODA6IHN1cHBv
cnQgYnVyc3QgcmVhZCBmdW5jdGlvbg0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gVHVlLCA0
IE1heSAyMDIxIDA3OjE2OjQ2ICswMDAwDQo+ICJTYSwgTnVubyIgPE51bm8uU2FAYW5hbG9nLmNv
bT4gd3JvdGU6DQo+IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiBTYXR1
cmRheSwgQXByaWwgMjQsIDIwMjEgMTozMiBQTQ0KPiA+ID4gVG86IFNhLCBOdW5vIDxOdW5vLlNh
QGFuYWxvZy5jb20+DQo+ID4gPiBDYzogbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgSGVubmVy
aWNoLCBNaWNoYWVsDQo+ID4gPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IExhcnMt
UGV0ZXIgQ2xhdXNlbg0KPiA+ID4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjRdIGlpbzogYWRpczE2NDgwOiBzdXBwb3J0IGJ1cnN0IHJlYWQgZnVuY3Rpb24N
Cj4gPiA+DQo+ID4gPiBPbiBUaHUsIDIyIEFwciAyMDIxIDEyOjM3OjM1ICswMjAwDQo+ID4gPiBO
dW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gU29tZSBz
dXBwb3J0ZWQgZGV2aWNlcyBzdXBwb3J0IGJ1cnN0IHJlYWQgZnVuY3Rpb24uIFRoaXMNCj4gcHJv
dmlkZXMgYQ0KPiA+ID4gbWV0aG9kDQo+ID4gPiA+IGZvciByZWFkaW5nIGEgYmF0Y2ggb2YgZGF0
YSAoc3RhdHVzLCB0ZW1wZXJhdHVyZSwgZ3lyb3Njb3BlcywNCj4gPiA+ID4gYWNjZWxlcm9tZXRl
cnMsIHRpbWUgc3RhbXAvZGF0YSBjb3VudGVyLCBhbmQgQ1JDIGNvZGUpLCB3aGljaA0KPiA+ID4g
ZG9lcyBub3QNCj4gPiA+ID4gcmVxdWlyZSBhIHN0YWxsIHRpbWUgYmV0d2VlbiBlYWNoIDE2LWJp
dCBzZWdtZW50IGFuZCBvbmx5DQo+IHJlcXVpcmVzDQo+ID4gPiBvbmUNCj4gPiA+ID4gY29tbWFu
ZCBvbiB0aGUgRElOIGxpbmUgdG8gaW5pdGlhdGUuIERldmljZXMgc3VwcG9ydGluZyB0aGlzDQo+
IG1vZGUNCj4gPiA+ID4gYXJlOg0KPiA+ID4gPg0KPiA+ID4gPiAgKiBhZGlzMTY0OTUtMQ0KPiA+
ID4gPiAgKiBhZGlzMTY0OTUtMg0KPiA+ID4gPiAgKiBhZGlzMTY0OTUtMw0KPiA+ID4gPiAgKiBh
ZGlzMTY0OTctMQ0KPiA+ID4gPiAgKiBhZGlzMTY0OTctMg0KPiA+ID4gPiAgKiBhZGlzMTY0OTct
Mw0KPiA+ID4gPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJz
QG1ldGFmb28uZGU+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5h
bG9nLmNvbT4NCj4gPiA+DQo+ID4gPiBMb29rcyBnb29kIHRvIG1lLiAgR2l2ZSBtZSBhIHBva2Ug
aWYgSSBzZWVtIHRvIGhhdmUgbG9zdCBpdCB3aGVuDQo+ID4gPiB0aGUgZGVwZW5kZW5jeSBpcyBp
biBwbGFjZS4NCj4gPiA+DQo+ID4NCj4gPiBwb2tpbmcgOikgLi4uDQo+IFRoYW5rcyA6KQ0KPiBB
cHBsaWVkIHRvIHRoZSB0b2dyZWcgYnJhbmNoIG9mIGlpby5naXQgYW5kIHB1c2hlZCBvdXQgYXMg
dGVzdGluZyBmb3INCj4gYWxsIHRoZSBub3JtYWwgcmVhc29ucy4NCj4gDQoNCldhcyB0aGlzIHBh
dGNoIHNvbWVob3cgbG9zdD8gSSB3YXMgdHJ5aW5nIHRvIHN5bmMgdXAgQURJIGludGVybmFsIHRy
ZWUgYW5kDQpJIGNhbm5vdCBzZWUgdGhpcyBwYXRjaCBlaXRoZXIgaW4gdGVzdGluZyBvciB0b2dy
ZWcuLi4NCg0KVGhhbmtzLA0KLSBOdW5vIFPDoQ0K
