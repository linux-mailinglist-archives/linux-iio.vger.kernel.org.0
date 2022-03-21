Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E14E2B09
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 15:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349522AbiCUOn1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349457AbiCUOmu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 10:42:50 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F0518B7B9
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 07:41:23 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 57EBC817D8;
        Mon, 21 Mar 2022 15:41:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647873681;
        bh=fhaFsjqH19272iNuO2ZIgHbktnn6ioGHlIE7CPaqdts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qmj4f7s0dJMMoFV6FZcpj7flTsgQI1A4JNNrLtAeoVmhhAu0ISFOZCYwo4p8pjPKv
         2Ah9pOO71RmlmgsL1U0uVFozunU9QvHN5IHah7/k7kKW+ClOKT0AKkWnMu1h4NyHb1
         9ZWY51JE2XjvRrkI4ihgDuU/4hyV9tbnmp74aoL2DE5WZZpuPje7z0Wp3lVRLQT3kw
         B0qLRRpUDMleqpYtPyZJFVJH7F7v9hIl7bg/E1YJV6vaYGUvnProopvWYyvba3LJzB
         yNbxxG0w+4OW+5Gjry8UrqWJyZWnFhRakxRXOsjkvBEo5WBmqWN/z3p7hn+mKpV/4s
         /7GGXYsefjumw==
Message-ID: <cd805097-b670-95dd-4298-72880a0e0a6d@denx.de>
Date:   Mon, 21 Mar 2022 15:41:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 09/10] iio: adc: ti-ads1015: Replace data_rate with
 chip data struct ads1015_data
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220320181428.168109-1-marex@denx.de>
 <20220320181428.168109-9-marex@denx.de>
 <CAHp75VczHX=0yZLjDyLdVjLW6ZRz4-ipJN0VERVj0qhp8CEWFQ@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAHp75VczHX=0yZLjDyLdVjLW6ZRz4-ipJN0VERVj0qhp8CEWFQ@mail.gmail.com>
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

On 3/21/22 10:26, Andy Shevchenko wrote:
> On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Instead of storing only data_rate in private data, store pointer to the
>> whole chip data and use the data_rate from chip data throughout the driver.
>> No functional change. This is done in preparation for switch to read_avail().
> 
> switching

Fixed

> ...
> 
>>                          if (period <= ads1015_comp_queue[i] *
>> -                                       USEC_PER_SEC / data->data_rate[dr])
>> +                                       USEC_PER_SEC / data_rate[dr])
> 
> I would put these two to one line.

That'd make the line over 80 chars long, is that OK in iio now ?
