Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8970F43E920
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhJ1TzR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 15:55:17 -0400
Received: from www381.your-server.de ([78.46.137.84]:58168 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhJ1TzR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 15:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=unEhKMWELovPqvf1Ykfw+b6GFq7qikv6XNXLkRDETFk=; b=UvT+sY8Adj74G6lon48o5eKEWt
        npagaGyYEJCmIHW6m9Eq72o2KzUOB69nK21KFjQAnJ4F/Ja+3pD5kR2AQXPZwe/GmR8VrTdMinZ9m
        i6onw03aqNVHtPvZ5iJ8XbFMwpSvBUgqCYdhm7L1MlkP6l0DW/wEKq6NGOOwgTKYJNLubga/kgpDO
        9Bc11PILWBoeeVhXOdccUJSFlyxJdqVH+9jXySZ+QQxMJgwbx68M3oRjW3so+qjhfzi6OMTOAKLT9
        g9Umq7Km/d4SeaLj/Zx2eryB0Wvay6ALiX3f4f0OwDXIBUZkfpS9v2mrWDSXisl286jYytkrZ+QAK
        SZK9XR2A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mgBSA-00090R-Uc; Thu, 28 Oct 2021 21:52:46 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mgBSA-000LMW-Ls; Thu, 28 Oct 2021 21:52:46 +0200
Subject: Re: [PATCH 1/2] iio: mma8452: Fix trigger reference couting
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20211024092700.6844-1-lars@metafoo.de>
 <20211028150731.753d4e40@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3bf78fdf-c6df-dd77-a1f1-61800c0ebe37@metafoo.de>
Date:   Thu, 28 Oct 2021 21:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211028150731.753d4e40@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26336/Thu Oct 28 10:21:55 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/28/21 4:07 PM, Jonathan Cameron wrote:
> On Sun, 24 Oct 2021 11:26:59 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> The mma8452 driver directly assigns a trigger to the struct iio_dev. The
>> IIO core when done using this trigger will call `iio_trigger_put()` to drop
>> the reference count by 1.
>>
>> Without the matching `iio_trigger_get()` in the driver the reference count
>> can reach 0 too early, the trigger gets freed while still in use and a
>> use-after-free occurs.
>>
>> Fix this by getting a reference to the trigger before assigning it to the
>> IIO device.
>>
>> Fixes: ae6d9ce05691 ("iio: mma8452: Add support for interrupt driven triggers.")
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Gah. I thought we'd gotten all these years ago. I guess this one slipped through
> the net.
Btw. we already have iio_trigger_set_immutable(), which handles the 
reference counting. I was think of adding a iio(_device)_trigger_set() 
that does the same except not setting the trig_readonly flag. And then 
eventually move the trigger to iio_dev_opaque. Any concerns with this?
