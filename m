Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA886298294
	for <lists+linux-iio@lfdr.de>; Sun, 25 Oct 2020 17:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416041AbgJYQhQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Oct 2020 12:37:16 -0400
Received: from vern.gendns.com ([98.142.107.122]:34436 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394728AbgJYQhQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Oct 2020 12:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NBfwltQtyYpg7GITsQ/G8RNoybCIgINYiN5thq4NeEg=; b=o4AC4MetqhXYPjVOnQ4oz2hZ/L
        fZeGe0nFQSh2RIXNFC638uS5DkWBm54/DizpesFLoggLIGkC02+2uY48Qb6pmYmX7kp5vJSiJn2k0
        /aRfILZIrKt1LulmlU5LvKl7rlSLQPB28PXxLTJU0Ixfs7aQL1tNQQBXBt1xXZaT3WC86aLrGnCOl
        H8HPL8jJqYrhhwBgAdXeEc0nCp+74MSUVucnGxpHX/ACut1i5iWOkqX6lUoLbhKaOZNGCpZn1V++h
        f1Tl9H0pkhL2942lcYJrSzbowJ0NFg8NKlhYbQRTHl+hkcDtO38wb4NnU90aIw2Fkm2KrXLWyLfxl
        EDG+cnrA==;
Received: from [2600:1700:4830:165f::19e] (port=37618)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kWj13-0005Vi-VJ; Sun, 25 Oct 2020 12:37:10 -0400
Subject: Re: [PATCH v5 3/5] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
 <181eb08a-be0a-f7cc-259d-b2a0f279950b@lechnology.com>
 <20201018164905.GD231549@shinobu>
 <fe46666a-4b2f-31f4-b91d-50c33aba0e56@lechnology.com>
 <20201025125557.GA3458@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <e616b7f5-2e58-4b61-5a13-f64875c542d6@lechnology.com>
Date:   Sun, 25 Oct 2020 11:36:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201025125557.GA3458@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


>>>>> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
>>>>> index e66ed99dd5ea..cefef61f170d 100644
>>>>> --- a/drivers/counter/counter-sysfs.c
>>>>> +++ b/drivers/counter/counter-sysfs.c
>>>>
>>>>
>>>> Not sure why sysfs changes are in the chrdev patch. Are these
>>>> changes related somehow?
>>>
>>> Sorry, I forgot to explain this in the cover letter. The changes here
>>> are only useful for the character device interface. These changes
>>> introduce the extensionZ_name and extensionZ_width sysfs attributes.
>>>
>>> In the character device interface, extensions are selected by their id
>>> number, and the value returned depends on the type of data. The new
>>> sysfs attributes introduced here allow users to match the id of an
>>> extension with its name, as well as the bit width of the value returned
>>> so that the user knows whether to use the value_u8 or value_u64 union
>>> member in struct counter_event.
>>>
>>
>> Are we sure that all value types will always be CPU-endian unsigned
>> integers? Or should we make an enum to describe the data type instead
>> of just the width?
> 
> It should be safe to assume that the character device interface will
> only ever return CPU-endian unsigned integers. The device driver should
> handle the conversion of any strange endianness from the device before
> the character device interface, while userspace is the one responsible
> for interpreting the meaning of count in the context of the application.
> 
> Let's create a scenario for the sake of example. Suppose we want to use
> a counter device to track the vertical position of a component moved by
> a linear actuator. The operator considers some vertical position as the
> horizon, where anything above would be a positive position and anything
> below a negative position. The counter device stores its count in
> big-endian format; but the system CPU expects little-endian.
> 
> The flow of data for this scenario would look like the following (where
> BE = big-endian, LE = little-endian):
> 
> +----------+         +---------------+          +--------+
> | Raw data | - BE -> | Device driver | -> LE -> | chrdev | - u64 ->
> +----------+         +---------------+          +--------+
> 
> At this point, the userspace application would read the unsigned integer
> from the character device and determine how to interpret the position --
> whether the count be converted to a signed value to represent a negative
> physical position.
> 
> Whether or not a position should be considered negative is dependent on
> the user application and context. Because the character device does not
> know the context of the user application, it should only provide
> unsigned integers in order to ensure a standard interface for counter
> devices; userspace will be responsible for interpreting those counts to
> something meaningful for the context of their applications.
> 
> William Breathitt Gray
> 

Sounds reasonable to me.
