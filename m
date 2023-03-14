Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C736BA1BC
	for <lists+linux-iio@lfdr.de>; Tue, 14 Mar 2023 23:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCNWDd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Mar 2023 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCNWDc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Mar 2023 18:03:32 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75346EBE;
        Tue, 14 Mar 2023 15:03:30 -0700 (PDT)
Received: from [192.168.1.114] (unknown [185.145.125.162])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5583C44C1001;
        Tue, 14 Mar 2023 22:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5583C44C1001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678831408;
        bh=4kMHYT1IN6A48eC47RXjXJUdm2BSqBgx7qSDD30l1aQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eeEtBE8KZMbswFarCOJf4d89i3WHoJ1VjD1/z2k4KzJ37Erxd9JCwt5VWCKFfSWIB
         CV5U8hsJbKQ+In8SdIHIa/0sjdByv3rBFP7eEzgwjoBYVt93rxuFhbM0vvghQdj93j
         qGFADEBF/rxiVNp7rNYtuZpUNMnRObS5ep5fgx+M=
Subject: Re: [lvc-project] [PATCH] iio: adc: qcom-pm8xxx-xoadc: Remove useless
 condition in pm8xxx_xoadc_parse_channel()
To:     Andi Shyti <andi.shyti@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, lvc-project@linuxtesting.org,
        Kasumov Ruslan <xhxgldhlpfy@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-iio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>,
        Jonathan Cameron <jic23@kernel.org>
References: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
 <CACRpkdan0Vt_T3aRVAK4rd=hQV=MOARm9Wq7sD8rjoisTW6Dkw@mail.gmail.com>
 <20230314212851.hqbzs5hhed5apcv5@intel.intel>
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
Autocrypt: addr=khoroshilov@ispras.ru; prefer-encrypt=mutual; keydata=
 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
 kK2E04Fb+Zk1eJvHYRc=
Message-ID: <9aec4249-6457-4e3b-13dd-baf02d4fbfad@ispras.ru>
Date:   Wed, 15 Mar 2023 01:03:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20230314212851.hqbzs5hhed5apcv5@intel.intel>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15.03.2023 00:28, Andi Shyti wrote:
> Hi,
> 
>>> The left side of the loop condition never becomes false.
>>> hwchan cannot be NULL, because it points to elements of the
>>> hw_channels array that takes one of 4 predefined values:
>>> pm8018_xoadc_channels, pm8038_xoadc_channels,
>>> pm8058_xoadc_channels, pm8921_xoadc_channels.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> I am not impressed with that tool. See below:
>>
>>> Fixes: 63c3ecd946d4 ("iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC")
>>> Signed-off-by: Kasumov Ruslan <s02210418@gse.cs.msu.ru>
>>
>> (...)
>>>         hwchan = &hw_channels[0];
>>> -       while (hwchan && hwchan->datasheet_name) {
>>> +       while (hwchan->datasheet_name) {
>>>                 if (hwchan->pre_scale_mux == pre_scale_mux &&
>>>                     hwchan->amux_channel == amux_channel)
>>>                         break;
>>
>> NAK have you tested this on a real system?
>>
>> Here is the complete loop:
>>
>>         hwchan = &hw_channels[0];
>>         while (hwchan && hwchan->datasheet_name) {
>>                 if (hwchan->pre_scale_mux == pre_scale_mux &&
>>                     hwchan->amux_channel == amux_channel)
>>                         break;
>>                 hwchan++;
> 
> ops, yes, sorry, I overlooked at this... This becomes NULL at
> some point as there is a sentinel in the _variant structures.
> 

Could you please clarify what do you mean.

As far as I can see sentinel is an "empty" element of xoadc_channel in
the array, i.e. hwchan->datasheet_name works as a sentinel while hwchan
is always non NULL.

--
Alexey

