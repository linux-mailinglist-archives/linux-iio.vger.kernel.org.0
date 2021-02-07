Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF9312459
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 13:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBGMps (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 07:45:48 -0500
Received: from www381.your-server.de ([78.46.137.84]:39570 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBGMpr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2021 07:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=uZtjBowzu9Xg2WkrzgOFz+YcliJRAWL+U/mfXNDKPPg=; b=HhhlFvmiOisAmd1z2XTc/YvvPg
        n1nyNU4ZHcvwJiXMHRlIcJRHBEpRjIN8x4Rl1o/PB0I4F4yooUH2Xa+MMNaoZALx0p24sGsi0PjtJ
        VmEIsUzHQJm3w06glpqIH6+dM521geFvs1AtZHRv/e2FJT0DedfDCuJbtVmEICrY9N7uRsfvvRTLT
        9ohYFPV2XFvJMhNVx21KtY+KnLzBJ3zA6K0mutgWG6DQE/zYyedDTlGaJg7L5ah9BtsuTbZ0SKHeM
        l2wnXc01DhyRkr2LyZaP2vNk+MO9dUndlRwuGu9Eyr/+ZNAuaEnKHPfOo6Aq0/x5CoxFEkxXvaJc0
        Heab6bkw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1l8jR1-000DmY-Mr; Sun, 07 Feb 2021 13:45:03 +0100
Received: from [62.216.202.92] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1l8jR1-000DSl-JU; Sun, 07 Feb 2021 13:45:03 +0100
Subject: Re: [PATCH 3/3] iio: Add basic unit test for iio_format_value()
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20201215191743.2725-1-lars@metafoo.de>
 <20201215191743.2725-3-lars@metafoo.de> <20201229181658.5aa5e8d4@archlinux>
 <a856bbff-a292-b988-84e2-cfd3223f220e@metafoo.de>
Message-ID: <8ae67298-5365-6549-1ccd-7de577ca3939@metafoo.de>
Date:   Sun, 7 Feb 2021 13:45:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a856bbff-a292-b988-84e2-cfd3223f220e@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26073/Sun Feb  7 13:23:32 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/2/21 3:59 PM, Lars-Peter Clausen wrote:
> On 12/29/20 7:16 PM, Jonathan Cameron wrote:
>> On Tue, 15 Dec 2020 20:17:43 +0100
>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>>> The IIO core provides a function to do formatting of fixedpoint 
>>> numbers.
>>>
>>> In the past there have been some issues with the implementation of the
>>> function where for example negative numbers were not handled correctly.
>>>
>>> Introduce a basic unit test based on kunit that tests the function and
>>> ensures that the generated output matches the expected output.
>>>
>>> This gives us some confidence that future modifications to the function
>>> implementation will not break ABI compatibility.
>>>
>>> To run the unit tests follow the kunit documentation and add
>>>
>>>    CONFIG_IIO=y
>>>    CONFIG_IIO_TEST_FORMAT=y
>>>
>>> to the .kunitconfig and run
>>>
>>>    > ./tools/testing/kunit/kunit.py run
>>>    Configuring KUnit Kernel ...
>>>    Building KUnit Kernel ...
>>>    Starting KUnit Kernel ...
>>> ============================================================
>>>    ======== [PASSED] iio-format ========
>>>    [PASSED] iio_test_iio_format_value_integer
>>>    [PASSED] iio_test_iio_format_value_fixedpoint
>>>    [PASSED] iio_test_iio_format_value_fractional
>>>    [PASSED] iio_test_iio_format_value_fractional_log2
>>>    [PASSED] iio_test_iio_format_value_multiple
>>> ============================================================
>>>    Testing complete. 21 tests run. 0 failed. 0 crashed.
>>>    Elapsed time: 8.242s total, 0.001s configuring, 3.865s building, 
>>> 0.000s running
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Series looks good to me, but I wonder.  What is convention wrt to
>> MAINTAINERS / Acks etc for self tests?
>
> Let's ask Brendan.
>
Jonathan, since there hasn't been any additional feedback should we just 
apply this series?

Thanks,

- Lars

