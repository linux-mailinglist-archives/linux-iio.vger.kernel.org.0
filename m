Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5DD1CB428
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEHP5S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 11:57:18 -0400
Received: from mail-mw2nam12olkn2100.outbound.protection.outlook.com ([40.92.23.100]:14144
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbgEHP5S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 11:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABjZsuFe8tH4uNPR8DT8VJUs0KuZ+5ADzfhMpYQSKtE2kVXNRHZaG77rQoBXrU8i0o6gFRxHbsU1rgJfaGyBsART8gs2gKBVyPymPGhXwpALUUCQ6Q8UuQ82SGlkhL7fODEw2yUnKkoVDP3/hQ90nq/BotJgNl8HinMeIZjzf1kQIFqpaue7F2gk6mbR9d+4ZGho8sw6Jg6tP3yJ6tijG64dnMmqYlD07DG/cojxFhLD35IQ9goiFkbXczrfp6wQj4ShP8XRH6lhXckAsD3N420PEY+5jaT3gk+RaY7NrKq9UUaxKQz5CzzK9GO7KdMK6IqqgwIRSUjQZi4ouUTNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeKlBqQWWhuEKLQhogpt1dyvYTfzHMWHB9BpEl3j4pE=;
 b=PERJ6PpqzxZK2VWrl+F6vMXjhFoYm7KUKY4mY5QYoEJcbLjl7+N9zNQniHYsTK7IiSNMUhmWGVd4oDy2+09NYlVKF97Wf9rhFqP+LDYkO02PrNu4UJolSUvei9H2vK5wL5yc7PObUN9LIhiE4pgyGNjl72fqNBA6mdOjBicMNvFi5W443ngD1/WVb48w2QtaNnoDMpSw/xRWFSumpgvdgMmhcrF09ioj19PDWmm6YqR8STTbg+BeMHJNb0Go2+Fcvfn+anXrU1yeNwyvTMZtXAkmVqlUIkhR26h9Ne6f8NYqWCqQWJekwKUM3GS3xmheEae5HOzSKuRm/XnxzDKNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::45) by
 DM6NAM12HT127.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::176)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.23; Fri, 8 May
 2020 15:57:16 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::44) by DM6NAM12FT065.mail.protection.outlook.com
 (2a01:111:e400:fc64::353) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend
 Transport; Fri, 8 May 2020 15:57:16 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:78E43D6A9D98FE9E7CCBBBB3B16732A3E27544B045E316179504C987EE2CC482;UpperCasedChecksum:33A39E8DE68E2010E1E96726F552B797A379D07E0B003CE7830963932578F91D;SizeAsReceived:9764;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.033; Fri, 8 May 2020
 15:57:16 +0000
Subject: Re: [PATCH 2/5] input: misc: bma150: Conditionally disable bma023
 support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
References: <20200503172206.13782-1-xc-racer2@live.ca>
 <BN6PR04MB0660B420EFA83668BBF4F315A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
 <CACRpkdb3kG=7SQg8RGh1F=8=_mivV6p_zxpodFT=M-f3PmiyYQ@mail.gmail.com>
 <BN6PR04MB0660BA0E181869F866594E98A3A50@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200507042318.GD89269@dtor-ws>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660FB7E230C514608743560A3A20@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Fri, 8 May 2020 08:57:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200507042318.GD89269@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1601CA0010.namprd16.prod.outlook.com
 (2603:10b6:300:da::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <8890a897-f37f-94e4-3c86-7ac3af161039@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR1601CA0010.namprd16.prod.outlook.com (2603:10b6:300:da::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Fri, 8 May 2020 15:57:14 +0000
X-Microsoft-Original-Message-ID: <8890a897-f37f-94e4-3c86-7ac3af161039@live.ca>
X-TMN:  [jZKOyh5g2L8FHAKCl3uYgqzCglv0FRISfN8J2oonFrDVhbXqkxZsCjtCyv6Vm5wD]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 7cfdc31f-10e3-4f9d-3d13-08d7f3687aae
X-MS-TrafficTypeDiagnostic: DM6NAM12HT127:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htorRvgHnRoRsTB2mvzy+0T6NwgyowB0IlP/RXWyUFwjVKTupQ6z3eAK5rttWszH9wK1fb4B4zHrvthBxJscxgDvtz/ExtCqg7TPKE14wgFOzlZGjkZvX6cqs6sPS246xolKW0cG+/mnx4m7pECGCDF3JqXhZCMS1fZIE04d3yLqhSh4gLYAJ7tGXGT2Y/MsoJsWEMOBB9Gcr06EWwRw0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: WgKBQ01znWlkv2Ml36Cv6x9bVuOapHzdQC46sqluek2Rrxfdb9yvsv5uFc2uMEvV1kJkTa1U4jb6iikokrO9jfWLP0MRuINGWkkSpsta+e5lT7nfVkSd0njR6T3XlHl5zyCPvQpyz422VgPSvBY4pUNZ6ZNunjryzNtcOSv/Ipw1Dm8G0r+0LMZHEpAXscS7bvKmhXGCTMHu/CxV1eh0fA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfdc31f-10e3-4f9d-3d13-08d7f3687aae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 15:57:16.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

H Dmitry,

On 2020-05-06 9:23 p.m., Dmitry Torokhov wrote:
> On Wed, May 06, 2020 at 08:46:12PM -0700, Jonathan Bakker wrote:
>> Hi Linus,
>>
>> On 2020-05-06 5:46 a.m., Linus Walleij wrote:
>>> On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:
>>>
>>>> The bma180 IIO driver has been extended for support for bma023.
>>>> However, this could cause conflicts with this driver.  Since some
>>>> setups may depend upon the evdev setup, disable support in this
>>>> driver for the bma023 only when the IIO driver is being built.
>>>>
>>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>>
>>> I would just fix this with KConfig instead, like add mutually
>>> exclusive depends on these two drivers.
>>>
>>> Set this input driver as:
>>> depends on BMA180=n
>>>
>>> And the IIO driver as:
>>> depends on INPUT_BMA150=n
>>>
>>> It's a rough measure but this input driver should anyway
>>> go away.
> 
> Isn't the driver handle more than bma023? I see bma150 and smb380 ID's.
> If we go Kconfig route we will be disabling it for them as well when IIO
> driver is enabled.
> 

Yes, that's correct.

>>>
>>
>> Ok, sounds good to me.  If I include a patch removing the input
>> driver, can I just drop this patch entirely?
> 
>>
>> The only in-tree user of the input driver (based on i2c ids) is Intel
>> Mid.  Not sure what the kernel policy on dropping drivers is.
> 
> Do we still support this platform? I'd start there.

It looks to me like the preferred method would be to also add IIO support for
smb380/bma150, add the exclusive Kconfig entries, and leave the input
driver in place.  Does this work for everyone?

> 
> Thanks.
> 

Thanks,
Jonathan
