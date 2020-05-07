Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAAD1C809C
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 05:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgEGDqT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 23:46:19 -0400
Received: from mail-bn8nam11olkn2105.outbound.protection.outlook.com ([40.92.20.105]:3265
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGDqS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 May 2020 23:46:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6RU40mxfE/ETXWqX7lULOs5+WgvJsquNu8n0tiqmxk6APKMfxqVFXyaeTHEEfsEPgxb5XT22BKI0866Hp0krt8oZs3iBWLAGLdx2I1CBG82ApBdMVCl+Aj3Glc0HppIUzqLcNN4TZhbL6JfDZT5WvB/b6Gt5Q380WkgqMAgLu4L9jtIgY+yyfLjgKXEcD0mYmPItXab41bpnBwoJSA2C6+dKvoT7W3f88S6xeLGr5aAHq5GbF5iyyvjd5hwha0YzBnJlBQ1UBkf0JtF3DHIuVqts7PdU7uTDc073ik7JBJQx7xJcUyhCwpBaLtTHsRHIE1ck4RIdpRfMVjNk2y2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmDWlafs14Q6VMNAJHrSpZQMRnRb/5cs5bsIzxKI0cc=;
 b=er0gLHOsKtI6pAE99dPnT+zu5y9nAIy51lLYj3KLgTxGRC7bFQiPe0kBf0Qc8LIQFzeG3fTgiVpGfjcYresH2/PIIdtZTNBl8pAR2ZofG8SeDAOp7ggIlGRtqeHiksJAiv6a1ihSwhxsDIE14xIuZeJ0WTj2g9dHsvz8rejxIM4HOUB9QnrCuajfi+VWhVlvDCvdzOvLgvrEcUBHv89we5VyxAS6/KLR60Oq+PH7ePOlQJN9Qho2TZyKQ51VGtA4KOpaMQ9P8DX6ccl/AZZMocBgISpt8qULShvgXJgMC9a6mPui+ldrnLL3LTZFU6hyMaW5QzIISrlf1GiGGWZrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::46) by
 DM6NAM11HT205.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::408)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 03:46:16 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::50) by DM6NAM11FT046.mail.protection.outlook.com
 (2a01:111:e400:fc4d::121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Thu, 7 May 2020 03:46:16 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:C64A0D1C153867C6508DF9CF4C46FD056C7998A7E745EC5D91E008066963A8B5;UpperCasedChecksum:29CAB8839F0C089A5EBE16CF563B443A6A0F09687527BF45B8C9A99B4AE4A1DB;SizeAsReceived:9673;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 03:46:16 +0000
Subject: Re: [PATCH 2/5] input: misc: bma150: Conditionally disable bma023
 support
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
References: <20200503172206.13782-1-xc-racer2@live.ca>
 <BN6PR04MB0660B420EFA83668BBF4F315A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
 <CACRpkdb3kG=7SQg8RGh1F=8=_mivV6p_zxpodFT=M-f3PmiyYQ@mail.gmail.com>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660BA0E181869F866594E98A3A50@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Wed, 6 May 2020 20:46:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CACRpkdb3kG=7SQg8RGh1F=8=_mivV6p_zxpodFT=M-f3PmiyYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:300:94::30) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <684cc7d2-eb84-d20a-8167-baa9b8481fbd@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR19CA0068.namprd19.prod.outlook.com (2603:10b6:300:94::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 03:46:14 +0000
X-Microsoft-Original-Message-ID: <684cc7d2-eb84-d20a-8167-baa9b8481fbd@live.ca>
X-TMN:  [P1Gdv29WsRGTIvD4UhhxdaGFBX63zmW5MY41hHHiQhJkokaREGIBjHlghwolm+eu]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 058380fa-2608-4b6d-f129-08d7f23931a1
X-MS-TrafficTypeDiagnostic: DM6NAM11HT205:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvHprMXW5AZf4lw4xUlHvj/dzwQF8wzAQBST42yfL6gB6BgmFwxxIICX7E6KoLt/U0zPvO0S/ev1iBpuHGvOLxi9PXWGOW0CRliGH0+uaT4oL7OnHFl/m3DD/rU5ptNLu8nyCNtuUVDu0bSYgFcJY2qSvXslAluQfB0Fj/sE7TqW9UCH4cQ/PEIYhdYlftQNnxN70Q/tvrNlixqqt4sRDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: c6LMankO2Ajf3jUDX00QucY5sdzf2jDTWVo0MxCgQYVWEOxMVcJw39iLvR1NBokYj57WbKwbzpIulozBnFjNlHYNmYrZcilXBj4iUKQm5X+ONTUyn8Js7eS1ddOEvjWhMvOagG0aYWs4OlQj/KdcE4LBCZVNvqt74vc7MRsO14PLUK7Z5ovYobxNZ5B/y+psXOyY26u+0lgOIsA/FOQcQA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058380fa-2608-4b6d-f129-08d7f23931a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 03:46:16.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT205
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Linus,

On 2020-05-06 5:46 a.m., Linus Walleij wrote:
> On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:
> 
>> The bma180 IIO driver has been extended for support for bma023.
>> However, this could cause conflicts with this driver.  Since some
>> setups may depend upon the evdev setup, disable support in this
>> driver for the bma023 only when the IIO driver is being built.
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> 
> I would just fix this with KConfig instead, like add mutually
> exclusive depends on these two drivers.
> 
> Set this input driver as:
> depends on BMA180=n
> 
> And the IIO driver as:
> depends on INPUT_BMA150=n
> 
> It's a rough measure but this input driver should anyway
> go away.
> 

Ok, sounds good to me.  If I include a patch removing the input driver, can I just drop this patch entirely?

The only in-tree user of the input driver (based on i2c ids) is Intel Mid.  Not sure what the kernel policy on dropping drivers is.

> Yours,
> Linus Walleij
> 

Thanks,
Jonathan
