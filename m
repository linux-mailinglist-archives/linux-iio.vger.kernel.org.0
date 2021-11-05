Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9932F446111
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 10:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhKEJHE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 05:07:04 -0400
Received: from www381.your-server.de ([78.46.137.84]:53610 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhKEJHE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 05:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=3ERJVON27xcB0z4IEBF5AHmN8Vw67kknzNO/pdOijRI=; b=ELJp80fFHYxNskFRI0kIPTceht
        O8COvo5xQws8t3yi0rJg7S6bRFqvUPphU6d909zV0WmTztx5J9hLkfN2g0z2z0kHf9KhXUIPuzaRa
        +kVYfQasZ0CKXzrKIhBKtft+bjp7C+1Y23B6I3kFKYuo5KM8ZlGV8jIORPHTk8WN5CtczGrCoVVsM
        UHRjFlo0OHo1nNqkkxpjJph23lKYQHcH45RdWaxvfVq6b+8wvIf5J+pQiTNf2aYJvheO+S8VYpGcf
        vFwfQ5SVRPwAuLzuU4J+CJImYsQ9YowLS63y0hlC99LhBShc2zLzZJKlw6UCPE8mjsRFWqV0yxHGk
        lUz5lp5Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1miv93-000Gbn-G5; Fri, 05 Nov 2021 10:04:21 +0100
Received: from [82.135.83.112] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1miv93-0007yJ-A7; Fri, 05 Nov 2021 10:04:21 +0100
Subject: Re: [PATCH v7 3/3] iio: test: Add test for IIO_VAL_INT_64.
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vasyl.Vavrychuk@opensynergy.com, jbhayana@google.com,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHp75Vd7Wwka37w-6QTXT9vv13bPiygKryBhQTnyvtTpCNU9qw@mail.gmail.com>
 <20211102073300.13376-1-andriy.tryshnivskyy@opensynergy.com>
 <CAHp75VfafpEBccivDRC2AVVJbZL2Kdq2KeR0yf_nwTtDTxvDkg@mail.gmail.com>
 <6d909cca-46a9-3f40-5d4d-97ef2fbe33e9@opensynergy.com>
 <0c449b88-a6fb-76ca-5c13-807f7728f1da@metafoo.de>
 <a3665295-6415-0c0b-f53d-87f658150991@opensynergy.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <61ddb1da-47eb-bbda-d6a7-98ef19fa494e@metafoo.de>
Date:   Fri, 5 Nov 2021 10:04:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a3665295-6415-0c0b-f53d-87f658150991@opensynergy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26343/Thu Nov  4 09:22:31 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/5/21 9:55 AM, Andriy Tryshnivskyy wrote:
>
> On 05.11.21 10:50, Lars-Peter Clausen wrote:
>> CAUTION: This email originated from outside of the organization.
>> Do not click links or open attachments unless you recognize the 
>> sender and know the content is safe.
>>
>>
>> On 11/5/21 9:45 AM, Andriy Tryshnivskyy wrote:
>>> On 02.11.21 10:11, Andy Shevchenko wrote:
>>>
>>>> CAUTION: This email originated from outside of the organization.
>>>> Do not click links or open attachments unless you recognize the
>>>> sender and know the content is safe.
>>>>
>>>>
>>>> On Tue, Nov 2, 2021 at 9:33 AM Andriy Tryshnivskyy
>>>> <andriy.tryshnivskyy@opensynergy.com> wrote:
>>>> Now it's good with format, but you have missed the commit message.
>>>
>>> Actually commit massage contains a header only (no body message), but
>>> I can add body message too.
>>> Thanks!
>>>
>>>>
>>>>> Signed-off-by: Andriy Tryshnivskyy
>>>>> <andriy.tryshnivskyy@opensynergy.com>
>>>> ...
>>>>
>>>>> +static void iio_test_iio_format_value_integer_64(struct kunit *test)
>>>>> +{
>>>>> +       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>> Shouldn't this be checked against NULL?
>>>
>>> Good question. Truly speaking I've made new test similar to other. And
>>> no other tests has a check for NULL.
>>>
>> The other tests not having it is my fault. There should be a
>> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf) under the allocation.
>>
> Understood. Then If you wouldn't mind I will add assert to other tests 
> too.

Perfect, thanks!

