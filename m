Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1994E2B1A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 15:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbiCUOpw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 10:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349559AbiCUOpw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 10:45:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244623D1E7
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 07:44:27 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6D004817D8;
        Mon, 21 Mar 2022 15:44:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647873865;
        bh=fyrDJHtezxZT4W21LloeF9hEe7cqFDvKo3iHjkTL91Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T+2zAjIp9o85cr2ZVwhzNTpwdkt0NVksfXIlEZjtj2ptGGuzAT4AB4oGkkP3kyWow
         qq6SSxM6X76H24gB2nUEHtVDMX9g9odeiAz0zzIOTAw/No8/LYAgobbFOxL71XrGqv
         0xa/csqElAgHwrPPl62L0OvtgKIofGj4MAnCAVhpMaSEdq507tszlgg07Vibc3UpFO
         m5H68r7ovVlljWxmU/4bfZ5dAg79Z2Ek2vv3tP4vCEFoTHaRaYO+aAb/AUyWtWZjDK
         Xdvj/o03NjSN5BLi29rB3kDpDzHXhEGRAh/YbPyJjTKiE6Em84n8LLv8dBCvwEb16d
         pTgKwZlvnAJnw==
Message-ID: <8c5772a7-6939-ac33-7b10-acded2b7b9ac@denx.de>
Date:   Mon, 21 Mar 2022 15:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 10/10] iio: adc: ti-ads1015: Switch to read_avail
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220320181428.168109-1-marex@denx.de>
 <20220320181428.168109-10-marex@denx.de>
 <CAHp75Vekt0aOcKMfXDhZJaC80DoqTZH30pMj6qFDhgG-guSdcg@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAHp75Vekt0aOcKMfXDhZJaC80DoqTZH30pMj6qFDhgG-guSdcg@mail.gmail.com>
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

On 3/21/22 10:27, Andy Shevchenko wrote:
> On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Replace sysfs attributes with read_avail() callback. This also permits
>> removal of ads1115_info, since the scale attribute tables are now part
>> of chip data.
> 
> ...
> 
>> +static const int ads1015_fullscale_range[] = {
>>          6144, 4096, 2048, 1024, 512, 256, 256, 256
> 
> Keep a comma at the end.
> Also applies to the rest of the modified data structures below.

Why ? We don't expect these arrays to grow new values, if there is ever 
some new ADC, it will likely have its own array.
