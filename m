Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC774D710A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Mar 2022 22:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiCLV3d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Mar 2022 16:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiCLV3c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2022 16:29:32 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0DF3B016
        for <linux-iio@vger.kernel.org>; Sat, 12 Mar 2022 13:28:25 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 59620820A0;
        Sat, 12 Mar 2022 22:28:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647120503;
        bh=xTg+o/9xPTyGbOFmHq9ueD9uv0y3EcHtwzjUDhpN4mM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BQOiAI/ewbOQBMror4I2ib7iZhNez5kBfXxePLu3DYsn3IFWwmWxVmXHLZmm1Wwg2
         hi8WpM+ZMBZN61Im4lRqDkFRhrD/rqVJuIOvz7aULu3E1o9yHTOb92EpFLtAUXCRQJ
         6fBJdRogAU89yPS2PnOTOHh28YVczCYizDBe2N/Xt6c0xXz9nhEHuElZcVr9Io77n4
         dQZtF32A2IdE5n8zwC1itZW2bz9wse/FGbinj7qKDHYazBX1NGcoMUrbZsaqPBjds0
         mes1OLWrGj2kmkqVijJqrTAwWYDzm4eW1+YE0q+I8yp18psjiDqd9tEMkSnMPzpoMZ
         k0txjdaxuZ4cA==
Message-ID: <65e934d0-b002-1cf1-1b4d-1ff53d04df50@denx.de>
Date:   Sat, 12 Mar 2022 22:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 7/7] iio: adc: ti-ads1015: Add static assert to test if
 shifted realbits fit into storagebits
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220311184925.99270-1-marex@denx.de>
 <20220311184925.99270-7-marex@denx.de>
 <CAHp75VdS+VRFSu8q3Si4yVEJd3aYxoFBaz4cYh7PXLGCLmNvaA@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAHp75VdS+VRFSu8q3Si4yVEJd3aYxoFBaz4cYh7PXLGCLmNvaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/12/22 13:19, Andy Shevchenko wrote:
> On Fri, Mar 11, 2022 at 8:50 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Add compile-time static_assert wrapper to verify that shifted realbits
>> fit into storagebits. The macro is implemented in a more generic way so
>> it can be used to verify other values if required.
> 
> Thanks! I think we may leave it to maintainers to decide if it is
> worth adding or not.

Right, that's why I placed it as 7/7, since the macro is ... not pretty.
