Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B036F06F
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 21:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhD2TYu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 15:24:50 -0400
Received: from www381.your-server.de ([78.46.137.84]:38730 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbhD2TUX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Apr 2021 15:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=7csD2NoB0Ab7nRsjfEMAoDkpgs61EQNnEbP52dtlwbE=; b=JVGhGXPRan+wiqr7pXEIpyl467
        AwvsqY2PnXshL1eltKSaall5/v+796IF4xWNTs0Q7kiPDhacvJRrUYnQ/asXEcFW4Cziln72iVXW3
        GEIl/1KiARiNPp6KSzA5XcQEO/pBIXxkXZBxKEJq6hlqA7TRWxAvkmAhGydSMfyQKq71tuknlokjW
        T6UcCHcANU9FU4XM6MDv4dp83yk4TgcXrxo5PA0jr8/7Ei9srh1gdh9/1Er44m1FGOVUvsAnY33Hw
        mTgtzVUni69kh9QWSomeRNdyLb01o/ivKFEAy95T7RHNOi3yLehY9Mgizj5V9f+r5bihSkfrd4bS3
        hKLdR4Hg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lcCCC-0009SV-1p; Thu, 29 Apr 2021 21:19:32 +0200
Received: from [2001:a61:2bd3:3c01:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lcCCB-000Gkb-Su; Thu, 29 Apr 2021 21:19:31 +0200
Subject: Re: [RFC PATCH 2/4] iio: accel: fxls8962af: add interrupt support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20210428082203.3587022-1-sean@geanix.com>
 <20210428082203.3587022-2-sean@geanix.com>
 <28f1e2a4-b2fa-5e4a-954f-92d90966eaf7@metafoo.de>
 <CAHp75Vd1j=rqmzEuo9fQMYDc+Y1=8kfyVJq6VR4Oip-O918Xow@mail.gmail.com>
 <2cc54acd-1de2-b462-0f77-145244580999@metafoo.de>
 <CAHp75VdptykxXy3dOR4sAZfzezt+7Fdk9yeWczFa1tGCZfzF+Q@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1abf8476-e1e3-5c0e-e480-daa7c291b4c8@metafoo.de>
Date:   Thu, 29 Apr 2021 21:19:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdptykxXy3dOR4sAZfzezt+7Fdk9yeWczFa1tGCZfzF+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26155/Thu Apr 29 13:08:00 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/29/21 1:35 PM, Andy Shevchenko wrote:
> On Thu, Apr 29, 2021 at 12:37 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 4/29/21 11:35 AM, Andy Shevchenko wrote:
>>> On Thu, Apr 29, 2021 at 11:58 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>> On 4/28/21 10:22 AM, Sean Nyekjaer wrote:
>>>>> Preparation commit for the next that adds hw buffered sampling
>>> ...
>>>
>>>>> +     irq = of_irq_get_byname(of_node, "INT2");
>>>> For this I'd use device_property_match_string(dev, "interrupt-names",
>>>> "INT2"). Means it won't try to map the interrupt again, and also this is
>>>> the only place where the driver directly depends on OF, everything else
>>>> already uses the device_ API.
>>> Why not platform_get_irq_byname_optional() ?
>> Because it is not a platform device :)
> Then device_property reading like this isn't really needed.
Why?
