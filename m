Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFAD281837
	for <lists+linux-iio@lfdr.de>; Fri,  2 Oct 2020 18:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbgJBQrR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Oct 2020 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Oct 2020 12:47:17 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74AFC0613D0
        for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2020 09:47:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d197so2246876iof.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2020 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Li4M3GK5y6x0SzTfqjxLLA9AT+ROiUGVRcFqRzm5Djg=;
        b=a1gXL5toNpXLmacnL7yhtJtYu+HmO+zq2HSfVRcyZ9z5aGYPOUMcOsxSjRxLjTiwhj
         zJBgESeE1qI3ToOAsK8MZWwKmHt51a3nMoD6FLDGupRKEjHEktpPC4yX8sNz7w/nKYtr
         hL0t3LhSNNDXOlNOrlInWA796iaMFGVw4FjQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Li4M3GK5y6x0SzTfqjxLLA9AT+ROiUGVRcFqRzm5Djg=;
        b=BMWeKTm7QCz6woatoKQA/h7JWU9NlC6eeO8aNmXjQ+TrOzWXrMEHGXDx6wEEVRmO62
         Fct6Kw1Zs2XtbTlCRpMstLZ2twdSEyF+U11nQ726j2eyGJIMRmPy+bkohl9Gql2lxEfp
         UtXISfOW3iiyAHnpVJKL/DJq6yrIFXc+GzEpkDGVsJlXdA2DvFqK4iHNGkGvfNU2gFT+
         lhUYt/DPcGr6lFGxNAxYztduPRPh6CX9Gl7hH+H1FrGwcnYsK7rOtThkt+o/QLVaKnP7
         6t63aI8Ir9UJCFuUpK5HQZ6BTcGJbC2GSWb9R7S/9g4wRBgoRX7Lug+fPcTYAHHeFhVY
         fn5A==
X-Gm-Message-State: AOAM530gNQ+quDwBhoubZR66PZvguaBbseWCXpsPdkDQIEV1Rl7qIY0T
        zBxUN1mvjD+SMZRNpNw1vsSy1Q==
X-Google-Smtp-Source: ABdhPJzrfRpNIYzV2uFrhJdCHt/QTSYBKDnpK2pS6zKI5Da6BP91uaqOQt3S2LEYZ+yKmaDKjo66AQ==
X-Received: by 2002:a05:6638:10e9:: with SMTP id g9mr2960820jae.139.1601657236070;
        Fri, 02 Oct 2020 09:47:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h2sm932771ioj.5.2020.10.02.09.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 09:47:15 -0700 (PDT)
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
To:     Joe Perches <joe@perches.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-iio@vger.kernel.org,
        drbd-dev@tron.linbit.com,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        David Lechner <david@lechnology.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
 <CAMj1kXGh+CzuXkAnqsoMO2A3T1p=D6uFOV347Ym5+VFn5U1gWg@mail.gmail.com>
 <20200929124108.GY4282@kadam>
 <alpine.DEB.2.22.394.2009291445050.2808@hadrien>
 <5f0d2b20f5088281363bb4a35c5652a2c087f159.camel@perches.com>
 <cd75e2d1-9923-b725-78cd-fd5611431584@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <81b94c3a-43d6-c9f5-0bc0-43bf65b3d5fc@linuxfoundation.org>
Date:   Fri, 2 Oct 2020 10:47:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cd75e2d1-9923-b725-78cd-fd5611431584@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/29/20 7:42 AM, Shuah Khan wrote:
> On 9/29/20 7:34 AM, Joe Perches wrote:
>> On Tue, 2020-09-29 at 14:47 +0200, Julia Lawall wrote:
>>> On Tue, 29 Sep 2020, Dan Carpenter wrote:
>>>> The times where commas are used deliberately to replace curly braces 
>>>> are
>>>> just evil.  Either way the code is cleaner with semi-colons.
>>>
>>> I also found exaamples like the following to be particularly unforunate:
>>>
>>>                                  fprintf(stderr,
>>>                                          "page_nr %lu wrong count %Lu 
>>> %Lu\n",
>>>                                         page_nr, count,
>>>                                         count_verify[page_nr]), exit(1);
>>>
>>> The exit is very hard to see, unless you know to look for it.
>>
>> I sent that patch last month.
>> https://patchwork.kernel.org/patch/11734877/
>>
> 
> I see what happened. This patch touches lib, cpupower, and selftests.
> Guess lost in the limbo of who takes it.
> 
>   tools/lib/subcmd/help.c                    |  10 +-
>   tools/power/cpupower/utils/cpufreq-set.c   |  14 +-
>   tools/testing/selftests/vm/gup_benchmark.c |  18 +-
>   tools/testing/selftests/vm/userfaultfd.c   | 296 +++++++++++++--------
>   4 files changed, 210 insertions(+), 128 deletions(-)
> 
> I can take it through one of my trees.
> 

Rafael, Andrew,

This patch is now applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git 
fixes branch.

This spans pm, kselftest-mm tests and tools/lib and has been
in limbo for a few weeks for that reason.

I decided to take this through kselftest tree to avoid having
Joe split the patches.

thanks,
-- Shuah




