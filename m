Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68CF5956C2
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 11:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiHPJlO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 05:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiHPJkT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 05:40:19 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34BBBF2
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=yihkoBO/Dy4FnV/5wBSubcJVcXV/eRF3FkM8sJzm8RA=; b=Jq7fkSINujChyxw8U9Lp/7ckol
        pkp89Cf16fQjdfuHN0BaZs9z50Y3/oqGMmjeJU3vkD2RKpb39Zb1fKeKdCyvEgw637oJlbyvEd9Ax
        r63q2yY5PP20NOWNR8vYefe0GdLPMBR5D6EaBLGySVKM9XI+lWq44d0gfBtUH8+fAM7Vt0CkVCMa6
        OCZ+O+rI92sHb7BNY3PwFQtrS4oXhgNmzKdHETo+ky0H4C1Xaa1r60pcMBFyafK9VxYtD/ZTppb5s
        rIJjcRd0WzaDffuUts4ZmxbY0H8MJE6rzNxj1vj14beO8SmMWKfpXzT0gunYXzX/xPXcKH7I/76dC
        VnSBcH0A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1oNs5y-0009XH-Jk; Tue, 16 Aug 2022 10:38:42 +0200
Received: from [2001:a61:2a3c:f01:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1oNs5y-0005Sx-4q; Tue, 16 Aug 2022 10:38:42 +0200
Message-ID: <bd8472f2-e4d0-2a63-98a5-5e1fe8ad6255@metafoo.de>
Date:   Tue, 16 Aug 2022 10:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 06/13] iio: adc: rockchip_saradc: Benefit from
 devm_clk_get_enabled() to simplify
Content-Language: en-US
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        David Wu <david.wu@rock-chips.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Simon Xue <xxm@rock-chips.com>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
 <20220808204740.307667-6-u.kleine-koenig@pengutronix.de>
 <20220813173142.76774c97@jic23-huawei>
 <CAHp75VeUV2+-V=TbQwx4Chr-xWU4AmRq-mG8Z8XTkwQmx4qvhQ@mail.gmail.com>
 <20220814213058.dgoxpkoxpn6s4ojj@pengutronix.de>
 <CAHp75VfD9xoDYyWH3NB9btNW2pBmTH_jBmwjOSUbOQ+Ei_k20w@mail.gmail.com>
 <20220815074149.jrkeevc3uxoo6ueb@pengutronix.de>
 <CAHp75VchZKRNtMU1awDczfx=Qq8_JsywXvLtrJJCY_8Y=n1W0g@mail.gmail.com>
 <ec9275fd-cc9a-0f42-0595-d37fb3d568b6@metafoo.de>
In-Reply-To: <ec9275fd-cc9a-0f42-0595-d37fb3d568b6@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26628/Mon Aug 15 09:51:41 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/16/22 10:27, Lars-Peter Clausen wrote:
> On 8/16/22 10:20, Andy Shevchenko wrote:
>> On Mon, Aug 15, 2022 at 10:42 AM Uwe Kleine-König
>> <u.kleine-koenig@pengutronix.de> wrote:
>>> On Mon, Aug 15, 2022 at 10:30:45AM +0300, Andy Shevchenko wrote:
>>>> On Mon, Aug 15, 2022 at 12:31 AM Uwe Kleine-König
>>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>>> On Sun, Aug 14, 2022 at 10:01:08PM +0300, Andy Shevchenko wrote:
>>>>>> On Sat, Aug 13, 2022 at 7:21 PM Jonathan Cameron 
>>>>>> <jic23@kernel.org> wrote:
>>>>>>> On Mon,  8 Aug 2022 22:47:33 +0200
>>>>>>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>>>>>>>
>>>>>>>> Make use of devm_clk_get_enabled() to replace some code that 
>>>>>>>> effectively
>>>>>>>> open codes this new function.
>>>>>>>>
>>>>>>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>>>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>>>>> This might have side effects as it now enables the clock before 
>>>>>>> calling
>>>>>>> the clk_set_rate(). Also changes the clock start up ordering. 
>>>>>>> Neither is that
>>>>>>> scary a change, but on really fussy hardware they might cause 
>>>>>>> problems.
>>>>>>>
>>>>>>> Add a few rock-chips people who have sent patches in last few years
>>>>>>> to hopefully take a look or even better run a test.
>>>>>> I believe you found a bug in the patch. The possible solutions are:
>>>>>> - not take the patch
>>>>>> - disable and re-enable clock around clk_set_rate()
>>>>>>
>>>>>> IIRC clk_set_rate() will spit a WARN if clock is enabled.
>>>>> You mean in general? I think that's wrong. There might be some 
>>>>> clks that
>>>>> do that, but I'd consider them strange. If you ask me, calling
>>>>> clk_set_rate() for a *disabled* clk is the strange concept ...
>>>> I think it's correct from the logic and electrical perspective. That's
>>>> why the preparation and enablement are separated in CCF. But please
>>>> double check, because I can't remember everything by heart.
>>> In my book the separation is done because "enabling" has to sleep for
>>> some clks (e.g. PLLs) while a sleeping clk_enable() is bad for various
>>> use cases and most clks don't sleep for enabling.
>> Yeah, but the idea of changing clock rate on the fly may produce
>> interesting side-effects on hardware level (with PLL latencies to lock
>> the phase and possible glitches). So, changing clock against enabled
>> hardware (not in reset / power off state) seems not a good idea.
>
> The clk_set_rate() API will internally disable the clock, if the clock 
> chip requires it. See `CLK_SET_RATE_GATE` flag.
Sorry, I misremembered. If `CLK_SET_RATE_GATE` is set `set_rate` will 
return an error if the clock is enabled when `set_rate` is called.
>
> But I tend to agree, the better idiom is to `set_rate` we should do 
> that before `enable`. This will avoid any unintentional glitches on 
> the clock signal
>

