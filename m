Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FBD2E2239
	for <lists+linux-iio@lfdr.de>; Wed, 23 Dec 2020 22:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgLWVnM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 16:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLWVnM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Dec 2020 16:43:12 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB3C061794;
        Wed, 23 Dec 2020 13:42:31 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j20so314681otq.5;
        Wed, 23 Dec 2020 13:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VmrWLe4I4zuTOgIyNJuVjkGWRkDBtXR16ouccbG+D18=;
        b=Hq/SwR6LFIkvuXGbd1to5P+I/xPkuOA4CkggPjxoozQPm+SC/3SEG9BsiovEctHy5Z
         qAUdGg/P7UQzeRSkWmTSpLKRPohFDak3XMT3+6aoFjtSyFr80kQxLuOBfYPqsLsah0+z
         uI0ElJOi3/Arpi3jpOGvnV+8uSbVOwusc1CMVSiUfawz06mZKG2m6eUWUDNJbGTQCFG2
         l4Q7lu2qp77v36Y2ouYAT0mFbuzi9/wqYxvg5NSDa9ITQVMTIEolKR/ImGaBF1b5ilXj
         +g14+O6NPHRwl4PvlNDis6Iis2zNcCyD2S4xC8D9L9mg68nAJpcw7fbMWWXoWWjJW9zI
         VbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VmrWLe4I4zuTOgIyNJuVjkGWRkDBtXR16ouccbG+D18=;
        b=DPaHVnHkSq6f6bz0c+6VDWeVfxtUwhUv8wOGCGo7+qR64ukvknY6Cw0AdxOr7c+tfg
         UXH2lutFNW2t1GsyCMQqmh+fNaAu2axqX2BK7vjOhC+daf+xbFmvO3xYpgGi9NKRrqsH
         qZlaBqIXWxaE050KkLcyfPRZd5u0sB0w8gDHaX20mF/3sIPjDRg3WNabTerTvnEiaRqN
         OHVFBhohyQUSxAopu1pm2fMbpAIL14FmEfJeH04RJWXe0U5sQrsYfBaeXQsIjdR4KKkS
         Hg0no6TAegxEwtYXFsd5XCPEYMpSs1CZohmNbZ+s1Gj37AaUR1uzjw8upjhmZ9uOZFxW
         jpYQ==
X-Gm-Message-State: AOAM531It2OLsrtQ0n+XRx7zzeCtn/W46vAcqFFHISnwxNS3JBri7z8I
        Tj0cvWBc2PNLrzH9P1Ttrp2S4SENsx8=
X-Google-Smtp-Source: ABdhPJxN4hoLbZZLl1Sqvblt3jGAsevFLmV2swOxk5s3dAjiQVD7g0CdJUoe2WUgh/sN8SBnWcpgjg==
X-Received: by 2002:a05:6830:20d5:: with SMTP id z21mr20640036otq.310.1608759750742;
        Wed, 23 Dec 2020 13:42:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o49sm5925007ota.51.2020.12.23.13.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 13:42:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (ntc_thermistor): try reading processed
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20201219224143.686074-1-linus.walleij@linaro.org>
 <6d339a6c-6f8c-4a5e-718b-c90a9fbb8c01@roeck-us.net>
 <CACRpkdZTVAoDbbJqTJbxv1ZDyAMsB_h9TAdKKbxqBYGp4-b_jg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <d990e08f-6f18-836d-89a5-01102a4faa45@roeck-us.net>
Date:   Wed, 23 Dec 2020 13:42:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZTVAoDbbJqTJbxv1ZDyAMsB_h9TAdKKbxqBYGp4-b_jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/23/20 1:08 PM, Linus Walleij wrote:
> On Mon, Dec 21, 2020 at 5:15 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> -     ret = iio_convert_raw_to_processed(channel, raw, &uv, 1000);
>>> -     if (ret < 0) {
>>> -             /* Assume 12 bit ADC with vref at pullup_uv */
>>> -             uv = (pdata->pullup_uv * (s64)raw) >> 12;
>>> +             /*
>>> +              * FIXME: This fallback to using a raw read and then right
>>> +              * out assume the ADC is 12 bits and hard-coding scale
>>> +              * to 1000 seems a bit dangerous. Should it simply be
>>> +              * deleted?
>>> +              */
>>
>> The hwmon ABI specifically supports unscaled values, which can then be
>> scaled in userspace using the sensors configuration file.
>> Given that we return the pseudo-scaled value to userspace today,
>> it seems to me that it would do more harm to change that instead of just
>> leaving it in place.
> 
> I see.
> 
> I tried to drill down and see the history of the driver and in the
> original commit all values are scaled with the function
> get_temp_mC() which indicates that the driver has always
> intended to return millicentigrades, not unscaled values (as
> far as I can tell).
> 

Sure. That isn't the problem. I didn't say that the value reported
to userspace _shall_ be unscaled, I said that the ABI supports it.

We are not discussing your patch here, just the comment. You don't
answer the basic question: What should the driver do if the iio
subsystem only delivers raw values ? I suggested we should just keep
the current assumption in this case, ie do the fixed conversion,
and let userspace handle any necessary adjustments. You seem to object.
With your patch, we get a comment in the driver suggesting that some
code should be removed. In my opinion, such a comment comment does
not add any value. Ether we drop the code or we don't, and I dislike
removing it.

That results in my usual fallback: When in doubt, do nothing.

Guenter
