Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA801C80A8
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 05:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgEGDtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 23:49:23 -0400
Received: from mail-co1nam11olkn2042.outbound.protection.outlook.com ([40.92.18.42]:60609
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGDtX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 May 2020 23:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMSaXUqIB4D8s/6a3KdOakYsLpOxLzmh8pcLLdH8+RKW4jE0GVQTTCdNor/J6RLvrADJlMPB5Oicts+Y1r1MnTNYXDimYdNElXizv7NBbKi1JQtm8Cct+FEJLzXtPvcatqkQDN5pL005EMNCA6/wTmo31usXwiZKnRXX5P4vqVYqkE+i7WC85eltGDnZkwEIMa03CfJ7UT8ZJbmuh97KMKsTWGSjkm3+WEBV4yRTdGOGdwDiqVR6I8TcYTSkba3mCBVDTAqXK0cFWUuVX+5yHJDRL5R9NRkKWk0FJptEapv5h9QNUcwJs5VWsUj1Dpt7zho2E6Khda1gsjyATiV5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7WS0ep6Pof67yFRn3nDZEba4oGZkhMCcHX7e4vT7vE=;
 b=A4RCxDHP2vdqAQwTaV2UAmCW/RHDNTTFcrNcZYB49QG/BCDLHcw+TdsR/zxCTO4ZxKGb0waAnKTEPLedPHDXvd1r1p4ssbUtjIU152gf2JuW8HhAQFaSgfz3ZTh8Gwn6GjeeQ5yYKdZhYQzOC2LfFS6FzBjDA37UeE9+k/3TR9SZXJ1CoifGT6JNP/+vaMt7RQyCbhvKAe3ezdPYCJgQ7FFVIhUgt5u41LGbtuk7epkl4BODZjzaEMUJ4/aa2UFEDn7kTqpkZa9uzZAJBcZWEDIla+FiChnyIzZEk2ok+m16eqf6Sa1ChOHCRtvfUCyF8wYphM9Qk1upqdJ3CMgvcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::52) by
 DM6NAM11HT211.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::260)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 03:49:21 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::50) by DM6NAM11FT046.mail.protection.outlook.com
 (2a01:111:e400:fc4d::121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Thu, 7 May 2020 03:49:21 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:D62C5FD99AA6B2C7BB5B5814B373DA82F85035C1579510770DE4DCDFC959F25C;UpperCasedChecksum:E72F6D97373CD4F15348698307B3CF6FE7D5D32898808A3C7BC0E0F56EC93F3D;SizeAsReceived:9609;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 03:49:21 +0000
Subject: Re: [PATCH 0/5] iio: accel: Add bma023 support to bma180
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
References: <BN6PR04MB0660046ABD79433EA94A85A9A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
 <CACRpkdbb89q2FRJZ1=2QoQs8JFYcwWpNZwJUbnjsVvZYEE-LKw@mail.gmail.com>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660BD7ABF64EC0C19A65A03A3A50@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Wed, 6 May 2020 20:49:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CACRpkdbb89q2FRJZ1=2QoQs8JFYcwWpNZwJUbnjsVvZYEE-LKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:300:16::24) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <1bb115be-fb1a-2024-d42f-4886f4cf207d@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR13CA0014.namprd13.prod.outlook.com (2603:10b6:300:16::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend Transport; Thu, 7 May 2020 03:49:19 +0000
X-Microsoft-Original-Message-ID: <1bb115be-fb1a-2024-d42f-4886f4cf207d@live.ca>
X-TMN:  [guzGGOMzR893nySBwTW0D24rgCeYJMv37PiOHM3O8jvitFAJljdWPSVHhpCYxaG9]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 76cc8ac4-9800-48a5-0dfe-08d7f239a006
X-MS-TrafficTypeDiagnostic: DM6NAM11HT211:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0SlhJ89kHbXu+2bL3mhpeRiKukjGmTJntsSk8GLGk32f7onWt3yOjIv5YWSIf0SGgmPP7NesMkPg2i2eQCJYRYuYlNeqCcymhiEwbxFJIlYGYUS/yk081BNEoA+PxF40SFSPysnz7dl+gSzIrMTQNBc10GRN8rhmzOULe/BEWOHxp3SSJz5WXTLmJO4K1t+FB3jS1j6E5D77A8yfnbWWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: KdSp707CMaCaKb/T+6/RBiFX+R6hGsSF48youbVNqH7rSIqb2emCzhDCE4m40CgAf+OQPBGyLDzOdobsj6Oju4U91aTREh2mQDClzRjHVIOPlgi4Ii3ppEen+QJlDNGsplangyM7FUejLM8VdBH5DeAYJ7gBX4rGNna3yRL2LyEQ50tu5mTGd91ZcEOl5h1wLDrq2LBMsUo/1hKLzdahKA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cc8ac4-9800-48a5-0dfe-08d7f239a006
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 03:49:21.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT211
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Linus,

On 2020-05-06 5:47 a.m., Linus Walleij wrote:
> On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:
> 
>> This patchset adds support for the bma023 three axis accelerometer
>> to the bma180 IIO driver.  The bma023 is found on several ~2010
>> phones, including the first-gen Galaxy S series.
>>
>> The bma023 differs from later chips (bma180, bma25x) in that it
>> has no low power but still working mode and no temperature
>> channel.
>>
>> The bma023 is already supported by a misc input driver (bma150), so
>> when both are enabled, the iio driver is preferred.  The bma150
>> is very similar to the bma023, but has a temperature channel.
>> Support for the bma150 is not added in this patchset.
> 
> I'd say, if it's not too much trouble please also patch in
> support for BMA150 and SMB380 to the IIO driver so
> we can delete this old Input driver, we have done this
> before and thes "input drivers" are just causing headaches
> and wasting time for the Input maintainer.
> 

Looking at the bma150, it looks the same.  The temperature is implemented
slightly differently than on the bma180+ (unsigned vs signed) but should
be quite easy to add.  I'll add a new patch for it in v2.

> It can be in a separate patch set from this one if you
> don't want to get stuck on this.
> 
> Yours,
> Linus Walleij
> 

Thanks,
Jonathan
