Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10FF430C3F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 23:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbhJQVK0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 17:10:26 -0400
Received: from mail-vi1eur05on2128.outbound.protection.outlook.com ([40.107.21.128]:3297
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232986AbhJQVKW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 17:10:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDxltXJivcLia/OlziCMQArRRf+Os1ixlicQMws12YibnKSp2UK5TYY644aLkdhOUgiuMGquvEke7BUdhH6Fvbp5gxtA5PAfBMT25cOq+30LaTnIroosYU+xKaLKAH+rCpKKUQMDW9NYtm5PjnOIftxWCYcE8EA+Ew0SXBGfbSxgNDOxLcntWpQ7Dv2PJp/6fZu9Th1Ez2ZsRD1ttzsmI31cOgYoQnMt1BjNMTILLseGfQg91sY+PDJyGRyiPd4440k/Pdk7lxqNCihaCr/pDAKW3iyISw4MhBo/my2ym4yIkLnJeFlMgmIFA5yGHtIMYRElNyTCKLH40a4Kbj5w+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHxVMPqU/syuKXb3GfM4XgoaWPbx3/JXNpyJ4QkRyaQ=;
 b=BbBqkqyHeDMbn6SRE4F7vzS/nBWMPQHeeIQ/zfc6DvW0IBNJKIRc9U+Co5DJ81PNDe1hgVAeojncBlZyhhEG8UG9ewiKNtuN/qmaW9HFMlbcGOnNVPDn7tY+cg+qgayPLH8sbXGWBkKDp33+s88CyZlIhu34q6pqrLYVF6l1t8Drvbi4B5V7pSFMhpsDvRbwJiB5DnL1w7P+6MTHa5vRKcNPZQbop2mpJ2BEcXWm0VMgfxP9LzfrWVxc+Y3Tx/OOHykpMJiQrL4RlItjxxi2yAX31uzcivS20QTNgsBrHFhtm22GLO8RypPFajLXhxog0xo2YVwTLksdSByX3c9+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHxVMPqU/syuKXb3GfM4XgoaWPbx3/JXNpyJ4QkRyaQ=;
 b=RywCIof7hMXPGtEvO1WVfSHyIc7IioRmQuBm74BQI/c+1doB4UeK1n/hiW6WPYCQh7WnJc86Fc9B8EUZlJ3k7MFAHgMwWaTaljsO+SREie0vyepvOKzp2pdbiBl9i5SpmQTsJUwvXWfKEVm+W9cCSdL/b7K+4ulPwRG1hB8yf4M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2293.eurprd02.prod.outlook.com (2603:10a6:4:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Sun, 17 Oct
 2021 21:08:09 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4608.018; Sun, 17 Oct 2021
 21:08:08 +0000
Message-ID: <5f3b6dd9-b90c-9e54-1772-56a79cc8c1cc@axentia.se>
Date:   Sun, 17 Oct 2021 23:08:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/3] Add settle time support to iio-mux
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        devicetree@vger.kernel.org, kernel@axis.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <7c14fabc-8811-5875-15a0-67884e2da78d@axentia.se>
 <20211017183108.1797d416@jic23-huawei>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211017183108.1797d416@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:7:29::14) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by HE1PR02CA0085.eurprd02.prod.outlook.com (2603:10a6:7:29::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Sun, 17 Oct 2021 21:08:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6796d6d0-5629-468d-1743-08d991b23867
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2293:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2293D4BD9CAA9DC60CA571BBBCBB9@DB6PR0201MB2293.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HILAkP0eIQUghZ8J6UO3p3+6wITNbWtkIjbPd86jfD0Jz+fEXJfmzgE1lZnBXGcQI0KJoOfCjffjQ7gWkGXooChASTwIbTiO5rp3Ih9lPE+DnsYezUuo1V2HNL4N4IqOlp18bfNUYspYoEMtKlg/pwKuWrWvCGQeaeLbgza7Xly1bdZYTHWOyS9LbBjgY6EQvWxyhyfun8KkPbWyBsVJcxeUQOKxYMQ6QDqHbFTnOWLeH4zAElWfWi2AR8V7eADuLjAQrnknzh9rsOROf1VEVIxgJyTsy3M8DN8RCtG1BhwkssXamdo7Kqc9Zkr2WTaFyuxZbYeWZBI7CrTDdc2hMXw08/yb/NIwbTQ3heYf9fUQkCGJdKQ1lQ4W9XcGmxYogIxuNMP3YNeyoEyCJKQBmH+fLisr7y3wdCwoeddf5cPxe3vi0j90QuIpkTJ7GQ02Fqw/zXjGrhnWGPXz3lHUG1oK0VtfzFK8THol1IPRLH/dz5FAzFwA1N2ZxL4eSX3SsDYT0EwSxrJfS1vZP9pHf2xfHrdp5vzRAi7ItsMamQ9LBxDEpgC99622gzWnaTe8yABMQZswV6N4EUwXvTDKej0VzULALZ/f64BAD0QBgDQtgT54kaXNKYyA2hu4QVd+liPAQpJ7pkdT+JFCPypMkcuvBxXhcRSFFMP+0mMC9bpL9fw0dPgaS6WGWZM7O0+0kb07rQ732qz2xTEjBWnbL08fFPaC7MmC/13o1gclNpT8duwNoAePsEr0tW/gdEBcvRWimhz+MiojGux0ruvZEQDGK8zlQtl5CKyuicUKCPF3KKsDsC40r+36I16SaVS0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(136003)(376002)(2906002)(6916009)(6486002)(8936002)(16576012)(38100700002)(316002)(186003)(4326008)(36916002)(5660300002)(66556008)(4001150100001)(8676002)(66946007)(53546011)(66476007)(966005)(508600001)(31686004)(26005)(86362001)(31696002)(956004)(36756003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEJnVzJtUFNpUjZZWTJBUkJ0RDdDRWhpZ1gvRUIyUWREd21sQUZ1ZUs5K3Vr?=
 =?utf-8?B?NFI4d3hDa1lFQzJpZ2RDNUhkVkxtVmJacTRtZk5Ed3JjRG42NkwvV3M3MUdp?=
 =?utf-8?B?c2FLUWVNQTE3R21JWUIzRE9vN29jU2Q0Qzk0eDJFQUpmVTJHUy9Ka2UvTnh6?=
 =?utf-8?B?dHo1NmtZODNJdmsvcS90MkFkZ1c2aGhIZDJ4Ym1ZeERiSjJTZk1LK1V6S29O?=
 =?utf-8?B?d2laL08vUkRQUUkvdXhrRmw3SzJiN2lreFRVRXM3M2NSSm14aFo0WDNQc0xR?=
 =?utf-8?B?MHBCVytLekZPRzR4NHhkNlcvdXduQlRaWkIxRVdXNjhjMkIwR09DaC9ZQW12?=
 =?utf-8?B?Q2F3MUFuV0VSSGRnUHJRMkhtR1U2cit4b1poT0orTjJzQTZhMElLcTZHUUZC?=
 =?utf-8?B?Vnp0T25FelNZclJoeEFFSzF5WFR3ZG92QnJNdzRTaFJIUmdNSDluVTFoZEJY?=
 =?utf-8?B?UkQ0N2t0U3p0MG42d29Zb05wa1I2dUd1L2tCbFNTVjcrc3Z4elU5eUNnYVVV?=
 =?utf-8?B?b0FUVVVJL1JsdHFRcHh5OG4rZUR5bVNlVGw4dHF2eDM1Mm1yM3gyMmtCZm1C?=
 =?utf-8?B?T29qOWNCQ0k3TXQ2ZFZNT3NqcHk2d3JiT0lsaFIyWklOcFZkdkJCYlhGRTM4?=
 =?utf-8?B?Ukk0M1BaMDVtMmVSQWc3SjhhTmpRL2JWdkQ1a2F1QlNqZFFXOXo2YlJMQzNu?=
 =?utf-8?B?S3RjdEZEMVZVSisxNEV0SCtqUTZVcE95YXd0NUFhQzB0K090VzI5RnowNnB4?=
 =?utf-8?B?WU1QMlN2MWpBSGNxbThodVNVVDdYQm9KeTVkL08wTWNRZEhYMFIyeTBEbElw?=
 =?utf-8?B?ak15SGRTY3RrYXBSeUNyeHlSbC9NK2lwMWx2SE15cUZ4Tzk1enNmTEQ2a1Jr?=
 =?utf-8?B?WFN3dFprVGZhanQrY05LTnRBY3hNTGlyS1VGOWx5Q2dxRlp5ZDl6bTlUQllr?=
 =?utf-8?B?SGxsaVlzRmRxV2p6MGRJTWVEMkErNFFhSFREVXd5NkhaSW14eE5RZzMwZk9z?=
 =?utf-8?B?elVtUm0yMVVQSXBXQm02b2gvdHV3L0tqRmVpVVdkbEYvMW5GRnlQWGFnTzJW?=
 =?utf-8?B?cURGZHpxc0Y2NExRZCtybWZhMFpMb3k4RkhyT0VtNUdZUzNwaHQrQzV4cnVS?=
 =?utf-8?B?QUxCV0hrSS84WW91OWhoaTV1bHZnK1p5N1VCa2VkN0gzOUE5MEQveWpCRDlq?=
 =?utf-8?B?RWVwU2JrdEd2eVNkdDlkcWtRSkdkUW5GNjFZL0FuS1Jxck5wRytCMWNZV1Uw?=
 =?utf-8?B?ZS9KK1c5Wjl1NUN3U3JyWXp2aExwcFJFVnhJWmhXemVqb3dJTkRRVG03Ym5y?=
 =?utf-8?B?Z3h5VHBxUXRsNmRxei90Sk1ETEpuQXhvaEM4OTdpWnJ5QUszaGZrQVJteDFv?=
 =?utf-8?B?aU9oVXc0aHM3YVlLWVFBTC9PcVBLL3o5UDV1N2NpUjRQay9Qc0RMYWVnN3pT?=
 =?utf-8?B?dUdkSi9Gem9tR255cWovZmJCbUVNNHNZWnVIcEtKeG9NNDgyc1Awc1hSTjY0?=
 =?utf-8?B?VDZ3SUM4Z0M4RDFvMWtnUG5Od1V0QlZhL3c4TUJRcGpwSk5pYU9xOVQ1M3dR?=
 =?utf-8?B?ZlAzOUo0T1ZNZEtRdmI1NXR0Z0JpYmljUXl2UGNIWnk3dVo4UkF2NmZvcW5K?=
 =?utf-8?B?SkdSZXZVbnNOYnEvaWRwamhLelc5RzgzR3lwbmV5VjJ4TC9ZcnBJRXNYaWFl?=
 =?utf-8?B?SVExY1hQOXNBRGlwcFVyVkczcmtROXkxWXVKUEx4VFgwTFRXZWJqSWlKR0d3?=
 =?utf-8?Q?qjAEh06cmQgz6Fvd8U+UJTivMTYP1OV6vmsnjX4?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6796d6d0-5629-468d-1743-08d991b23867
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2021 21:08:08.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3EdCDjhFyQJF0ES1cP9PQShC5zIqHqx8NnTJpKe1iLmP9Mr5f/NVG4i5EALepI8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2293
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-10-17 19:31, Jonathan Cameron wrote:
> On Sat, 9 Oct 2021 01:09:56 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Hi Vincent!
>>
>> On 2021-10-07 15:46, Vincent Whitchurch wrote:
>>> On one of our boards we use gpio-mux with iio-mux to read voltages using an ADC
>>> from a few different channels, and on this board the input voltage needs some
>>> time to stabilize after a switch of the mux.
>>>
>>> This series add devicetree and driver support for this kind of hardware which
>>> requries a settle time after muxing.
>>>
>>> v1 -> v2:
>>> - Move property support to iio-mux and delay handling to mux core as suggested
>>>   by Peter.
>>>
>>> v1: https://lore.kernel.org/all/20211004153640.20650-1-vincent.whitchurch@axis.com/
>>>
>>> Vincent Whitchurch (3):
>>>   mux: add support for delay after muxing
>>>   dt-bindings: iio: io-channel-mux: Add property for settle time
>>>   iio: multiplexer: iio-mux: Support settle-time-us property
>>>
>>>  .../iio/multiplexer/io-channel-mux.yaml       |  5 +++
>>>  drivers/iio/multiplexer/iio-mux.c             |  7 +++-
>>>  drivers/mux/core.c                            | 36 ++++++++++++++++---
>>>  include/linux/mux/consumer.h                  | 23 +++++++++---
>>>  include/linux/mux/driver.h                    |  4 +++
>>>  5 files changed, 65 insertions(+), 10 deletions(-)
>>>   
>>
>> This looks really nice, thank you! The only question I see is if it should
>> go via my (virtually unused) mux tree or via the iio tree. Yes, the meat is
>> in mux/core.c, but I'm happy to just ack these patches and have Jonathan
>> handle them. But, I'm also fine with handling it in the mux tree (but I'm
>> getting old and forgetful, and it's been so many moons that I need to
>> re-learn the steps).
>>
>> Jonathan, you or me? If you, you can add:
>>
>> Acked-by: Peter Rosin <peda@axentia.se>
> 
> I don't really mind, but the 4/3 and 5/3 have broken my b4 based flow + Rob
> hasn't yet given an Ack on those two, so I'll not pick any of them up just yet.
> I can sort out the two oddly numbered patches if Rob is happy, though they'll
> probably not have the nice link tags that b4 automates.
> 
> Note Rob didn't actually say he was happy with patch 2 yet as far as I can tell.

Getting Rob's ack on 2/3 is of course a prerequisite to 1/3 and 3/3.

Just ignore 4/3 and 5/3 if they are holding things back or are making things
difficult in any way. I'll resend them later if need be, as they really have
very little to do with this series.

With hindsight I should probably have sent them as a fresh series, and I can
re-post them as such immediately if that helps? But then again, maybe that
just muddies the water even further...

Cheers,
Peter
