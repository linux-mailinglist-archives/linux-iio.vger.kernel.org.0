Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7D033234D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 11:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCIKrZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 05:47:25 -0500
Received: from www381.your-server.de ([78.46.137.84]:42714 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhCIKrD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 05:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=NALcjZ87C3P+VhME/YiHKRq8c3p+GMMkN6MjAkCFdI4=; b=Z0V+6rVWLgSfaifeTsSw+HHbGq
        oqjg1vvMv8kFzZGagBpUyMcU5OSazck52rn6tWYdHmmto05kgZpThmRez9m1w6+ISHiQecmthZYC0
        ylLPWr2feAt325JqC+XoXMsc7GsgKhO+JP0pY+sQstjOymopPkiK/Po2CcYclfEmE40nwguzfrkXJ
        l/GymazGOPpBL4vWEQYuWw7Bn8KI0x48f38HGBRi0eG8Uyks5ip3ACntSx2CM+K7BpVRZgruvpRTI
        HyNjSNvsQPMCB4+VbJ3AtRKpH0SQLG5p6bzIA5NyYVPZYarYXkiWeGRIyil+ylPFaCfgQZh/+RNXw
        q+ji7BLA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lJZt8-0002wR-Tg; Tue, 09 Mar 2021 11:46:54 +0100
Received: from [2001:a61:2aea:a901:224:d7ff:fe9f:8154]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lJZt8-000DA7-Ot; Tue, 09 Mar 2021 11:46:54 +0100
Subject: Re: invensense mpu9250 ak8963 and devicetree
To:     Philippe De Muyter <phdm@macq.eu>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20210303153145.GA30260@frolo.macqel>
 <BL0PR12MB501190F3812AA541BDBEF625C4979@BL0PR12MB5011.namprd12.prod.outlook.com>
 <20210308130630.GA3363@frolo.macqel> <20210308172427.000032d2@Huawei.com>
 <20210309101126.GA11691@frolo.macqel>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c5860a82-e3ba-3409-a711-847c8bcf7e1e@metafoo.de>
Date:   Tue, 9 Mar 2021 11:46:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210309101126.GA11691@frolo.macqel>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26102/Mon Mar  8 13:03:13 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/9/21 11:11 AM, Philippe De Muyter wrote:
> Hello Jonathan,
> 
> Thank you for your answer that led me to the explanation.
> 
> On Mon, Mar 08, 2021 at 05:24:27PM +0000, Jonathan Cameron wrote:
>>
>> That's odd because you should get a stub regulator... For simple cases
>> where the regulator is always on, there is no need to specify a regulator,
>> you can just rely on the regulator framework giving you one that basically
>> does nothing.
>>
>> Could you have a look at why you aren't getting a dummy_regulator from the code
>> just below here?
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L1948
>>
> 
> I use a kernel provided by nvidia that is called tegra-l4t-r32.3.1, but
> is based on v4.9.
> 
> Although the patch that provides automatically stub regulators
>   4ddfebd3b "regulator: core: Provide a dummy regulator with full constraints"
> is older than v3.13, I have found in the commits of my kernel on top of
> v4.9, this one
[...]
> And CONFIG_REGULATOR_DUMMY is disabled in the default kernel configuration
> provided by nvidia :(

To work around this you can add a fixed-regulator to your devicetree and 
connect it to the IMU. 
Seehttps://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/fixed-regulator.txt

- Lars

