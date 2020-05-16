Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1BD1D61A2
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgEPPBV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:01:21 -0400
Received: from mail-co1nam11olkn2053.outbound.protection.outlook.com ([40.92.18.53]:18898
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbgEPPBV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4YpEP/sw3JzB45djXpuP06B6Dh1FRD0RE/7PSVCCkW/nlNKLpO2Cr4GehOHllRdZjr504laLrFlm9+rHneeytwOj5h+BW1QdgfaCr2BSIkJgj3X3LVlnBeryRHRnLaQ7UuSugXVWXV3suoy4tCT7IONA6Ov2kpJLciKCfvbM2a1vELSzuCxpJtPDHPbSS9RnOFX2QLszYEmXOEHFbDsZhu8l06mfi/6MOOH1OHSEsgqG/NonswbZaR/3vN8z4tvuPu6AHnFQ7+IhRq2YJMW3LWhbXXFOefJcwcegD+vi4pssTqwNm5PEpPa359pGbshi6xkIeeZ6+/iunIGaNqHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKYPrbLLH0zey5RDCnODvwFhAbbAAMcADgkAeug7UmY=;
 b=QdWB8SufXGblKJ1Av/jKr6E0+A30+ibw7tqw0KMieZ/kruSkyzZIOmdvvZ5WdQ9vdWgTrd7eknFBv+G1/7WvSRpzGvZIoDQRNedN50ziI+Ki3WXvwQqSD+JmP3ClooPdwKbZ9UysSE4Biy2R/yg73+EF/dAGTs93n/ioPygIHHLnWLi+FC+cGWU9GjNJwYVRRKlyQDeMcIpA1J9+ZJ+X3SGOA4QrDubcw5A/B9aBx7iW5F4bfHIg42Qi2hwqnVuVwo6y1uMEeqfHlQjKgrsux2KnP0M6un/uQcbtysn+b0NFFkBdJ2mJz5janHlfw4Z63ZOEQqTtCKq3VDSBoc8xsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::47) by
 BN8NAM11HT176.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::459)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Sat, 16 May
 2020 15:01:18 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::4c) by BN8NAM11FT067.mail.protection.outlook.com
 (2a01:111:e400:fc4b::415) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Sat, 16 May 2020 15:01:18 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:6FC5C8971829A278AEA81B4B6594B0212808137AFEEE10917CCB04C0F3FF419F;UpperCasedChecksum:FB07F5EB6FB9E3D045476D9317AD197A4EAA3FA0E4187E7F3AF833840A7A0573;SizeAsReceived:9152;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 15:01:18 +0000
Subject: Re: [PATCH 0/2] iio: adc: Add a current from voltage driver
To:     Lars-Peter Clausen <lars@metafoo.de>, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linus.walleij@linaro.org
References: <BN6PR04MB066014AF936EF8ADCBF011A1A3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <d5f785bf-15f5-9ca5-f7f8-863c74447010@metafoo.de>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660FED60AD7BE9AD09B56A8A3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Sat, 16 May 2020 08:01:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <d5f785bf-15f5-9ca5-f7f8-863c74447010@metafoo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:301:1::16) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <533ffd2c-cef7-5501-61ab-30b4b25a179b@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR11CA0006.namprd11.prod.outlook.com (2603:10b6:301:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Sat, 16 May 2020 15:01:14 +0000
X-Microsoft-Original-Message-ID: <533ffd2c-cef7-5501-61ab-30b4b25a179b@live.ca>
X-TMN:  [9i5ediAuayKoDwRGk8m8xY4uc84Q82mwxuMPR3dj2IkVKopRcM7zWVvyfUtK5mVX]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e5bf508e-876e-471f-397c-08d7f9a9fb0e
X-MS-TrafficTypeDiagnostic: BN8NAM11HT176:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: queiJcYZiEeem0Ac/hfKKPiDK0VOFH5EYVjZvmftttsoMn7tYfL4OA9gXXZqvKJeuvvc1bxrdSv/SaGfYHjE3zYh940yhi3kS96mVlitqUf2sQjYSOySlDNfkFtHcUZ9nV+e0U9nh4bYoL7sTpeamMlI23MoVPNssXFGHrRO4HUO77w+dcNrbvWjbyX8RUnvPKzTRn8/VNedMjIwKRpSkavRoQTRQjZzaEzgiYYKcCqaJZTwHD5liR0oQwYU2kUd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: WE4ZWEN7WzIv+U816R5JLPG0EVfTc+DgaRx0SS1B3kqzPhT2DNIR/mGgRIidEH0phZ3aPvP70m3/bqpTjbvDngRyloudJXEwb2Eo0e+1pxFAIjAt4mVbMtn40I/+fP6Jt3S91G+q/PgiZy4fvSWgGishwHeWsn8knVY/W1bzYDNolWl6s73o5GoMar04RWQQQ9VuwInxiF1TxcG9ZIAJgg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bf508e-876e-471f-397c-08d7f9a9fb0e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 15:01:18.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT176
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Oops, sorry about that, you're absolutely right.  The current-sense-shunt part
of iio-rescale is exactly what I was looking for.

Thanks,
Jonathan

On 2020-05-15 11:28 p.m., Lars-Peter Clausen wrote:
> On 5/16/20 4:26 AM, Jonathan Bakker wrote:
>> In the discussion around adding the GP2A002 light driver, there came
>> up the question of what to do when a system emulates a current ADC
>> by using a voltage ADC and a resistor.  Rather than adding it on
>> a per-driver basis, it was suggested(1) to add a minimal IIO driver
>> to support this situation.
>>
>> The new driver is fairly simple - it simply takes a voltage ADC and
>> a resistor value in ohms exposed as the scale and outputs a current.
>>
>> It has been tested on a first-gen Galaxy S device which has the above
>> mentioned GP2A002 chip connected to the voltage ADC resistor complex.
>>
>> 1) https://lore.kernel.org/linux-iio/20200202150843.762c6897@archlinux/
> 
> Hi,
> 
> There is afe/iio-rescale.c, which I think already implements this functionality.
> 
> - Lars
> 
> 
