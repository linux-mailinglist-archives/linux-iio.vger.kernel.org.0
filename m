Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEE377D86
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 09:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhEJHzN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 03:55:13 -0400
Received: from first.geanix.com ([116.203.34.67]:58530 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhEJHzM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 03:55:12 -0400
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 67736468164;
        Mon, 10 May 2021 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620633246; bh=zpKUyJqSq7e88ZBcJAhoYfLo1E8NTxjf+fdtYV/W39A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=b3h0n4NgeDbpICf9B9/5vuqXqTRxezjkHnGH8MutW4L32eMLkhVOAWBJ6ov3mTeib
         uuJfW+wcLgJPS050VSOFfvod1Kj9mg7DXS7K1SBotL9O/ombuL/z89aqyiNjuBJWcc
         VsjzBbqKmGXzV4S9qzLt0NUOKyglKie0H3Jgy21M0+ikZ+ETghslky/qrBfkDMZvdX
         5NiNOXljppa7Izrm2qLDjyg3wLno9ZEfy1lCJ/L8ifd3yEA1g+uQQkUbHXeVKjkEu7
         WB3NmAXZKehMrrYUI0q6M3DuT6nH5oayyVw5Enz15vZtCHQkKXlMhsfxBzsb6lIUC6
         vmXIPTYkr4o0g==
Subject: Re: [PATCH v5 5/6] iio: accel: fxls8962af: add hw buffered sampling
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
References: <20210506070940.312959-1-sean@geanix.com>
 <20210506070940.312959-5-sean@geanix.com>
 <20210508173947.47d18328@jic23-huawei>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <f50d0b0f-f00d-35c9-9cf5-2a9e9ffaa8ca@geanix.com>
Date:   Mon, 10 May 2021 09:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210508173947.47d18328@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08/05/2021 18.39, Jonathan Cameron wrote:
> On Thu,  6 May 2021 09:09:39 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
>> When buffered sampling is enabled, the accelerometer will dump data into
>> the internal fifo and interrupt at watermark. Then the driver flushes
>> all data to the iio buffer.
>> As the accelerometer doesn't have internal timestamps, they are
>> approximated between the current and last interrupt.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> 
> Hi Sean,
> 
> Couple of things I adjusted whilst applying this.
> 1) trigger.h isn't used as no triggers are involved currently in this driver so
>    I dropped it.
> 2) kfifo allocation etc has changed in the IIO core whilst this driver was in
>    development. Now we have devm_iio_kfifo_setup() which does everything your
>    locals _setup() function does. 
> 
> I've made changes for both of the above whilst applying so please take a look
> at the result which I'll shortly push out as testing for the autobuilders to
> poke at as well.
> 
> Other than that I tweaked a bit of whilespace in the id tables in patch 1.
> 
> Series applied to the togreg branch of iio.git but initially just pushed out as
> testing to let 0-day work it's magic.
> 
> Thanks,
> 
> Jonathan
> 

Hi Jonathan,

Guess it's okay, but I can't find the patches here:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg

:-)

Br,
/Sean

