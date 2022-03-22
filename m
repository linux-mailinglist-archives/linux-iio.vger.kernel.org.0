Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4EE4E3D59
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 12:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiCVLTP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiCVLTP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 07:19:15 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2060A811A7
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 04:17:47 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 92C118141D;
        Tue, 22 Mar 2022 12:17:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647947866;
        bh=5nTm9NPsIP9gVgMzrj4eCwrnAPmXxBxrWKcwqVOZtAQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o9zN6P2dXS038nRNezfiaK1MGzDb2yQZM8CX38MyBAMjvoyJo3zEcg4nBEPLl8P0g
         PY5eeibWENoU8kCjavpwpM9tyox/8rvG1bGdFfNN7IZpbBG3lglMiF+kiKVNflPeJY
         qGuwPW/444RaXgAPk9U/GQHLovmtDS7Ze4iO2cm92hqsqamYFWCuyVLgNTJNoM+eOs
         VAymMx1TpfagHkhn5CXhIRrR4ORq7JCkpPWLdC+oeoFZcLQBR8rkMl7Gprmdb9bqTI
         aQP+BMNZwMXjKjYj8sCz68SmyJQy+gyDNQGnkbGSmLnat+UGUqknc7523d7uor2GHI
         uX+snGozqJPNg==
Message-ID: <0dd8aca8-b2e7-5e62-d2bb-969dbc907593@denx.de>
Date:   Tue, 22 Mar 2022 12:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] iio: core: WARN in case sample bits do not fit storage
 bits
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220320181542.168147-1-marex@denx.de>
 <YjhWIN6GsuhPskrs@smile.fi.intel.com>
 <8b6f00be-c520-45c3-4497-d0fc310ff52f@denx.de>
 <Yjijg7m+TnaMs519@smile.fi.intel.com>
 <30a13541-0ffb-a537-e943-3751b7fd316b@denx.de>
 <bd7f7b9853cbea30740af14d29a46f1a9f93a2a7.camel@gmail.com>
 <YjmbstSwzbu5ZdBg@smile.fi.intel.com>
 <220fa73c-5d61-a564-79a3-eabff366964c@denx.de>
 <5be8958b14e252fcad9090ce911caa170e654186.camel@gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <5be8958b14e252fcad9090ce911caa170e654186.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/22/22 11:10, Nuno Sá wrote:

Hi,

[...]

>>>> Arghh, completely forgot about this... Andy is right, maybe there
>>>> are
>>>> other cases (in which case, it would be nice to share :D), but
>>>> this one
>>>> is definitely one of them:
>>>>
>>>> https://elixir.bootlin.com/linux/latest/source/kernel/panic.c#L579
>>>>
>>>> You can have a cmdline parameter to panic on _WARN() and some
>>>> systems
>>>> may have it.
>>>
>>> Yes, I meant panic on warning.
>>>
>>> And I can't imagine that this driver can be system critical to the
>>> extent
>>> that we have to crash the system.
>>
>> Is there something which does trigger a backtrace, but without
>> panic()ing the system ?
> 
> Nothing I'm aware... Other than directly call 'dump_stack()'

All right, dev_err() it is then. I sent V2.
