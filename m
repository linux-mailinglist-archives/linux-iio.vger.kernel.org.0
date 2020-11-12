Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72872B09BD
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 17:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgKLQUz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 11:20:55 -0500
Received: from www381.your-server.de ([78.46.137.84]:35794 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgKLQUz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 11:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=VfhCIUmI57CSq6RPOlZaUg7VuZTb6Ns6DoK9glWxmjw=; b=RRH4kpZKKhpCIVJESxYXLYofsX
        5zqSh29viQlj1laGwKaF4DopffFB7KW2zBDGzvW/y3PjF4WcK2kEGRaObkFJhoeUgRteaojrqr4W4
        LNJo1JBEp0o4rfLcr1L/fm0sIEiDQHw8TpMBYFNdli6Ldp4dqcBJhakVIMPY8kPTVMxIwuHFG7jbW
        kPGPRljjzkNIRrU12EBy9NeHn3S2nxd7yUk+aEgTvnsUD/PK3IJmTrx3WjeLLLGfFbpCIdAVGz8PG
        Fgl9ZeUMUkV4wmutOA0GVXAak/co4ALN6QVsTLnznEjbtdDlPzljBCMuycftUSfwmNAv4HAjSMyjc
        MbQ6FxHA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kdFLB-0000P5-IZ; Thu, 12 Nov 2020 17:20:53 +0100
Received: from [62.216.202.98] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kdFLB-0000bv-Bz; Thu, 12 Nov 2020 17:20:53 +0100
Subject: Re: [RFC PATCH 1/1] iio: buffer: Sanity check buffer callback
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20201112151334.32167-1-nuno.sa@analog.com>
 <20201112151334.32167-2-nuno.sa@analog.com>
 <e8da8110-d029-fa1d-1732-e147e30e2850@metafoo.de>
Message-ID: <7698e67d-fa41-0264-17e2-247b913c1a03@metafoo.de>
Date:   Thu, 12 Nov 2020 17:20:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e8da8110-d029-fa1d-1732-e147e30e2850@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25986/Thu Nov 12 14:18:25 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/12/20 5:15 PM, Lars-Peter Clausen wrote:
> On 11/12/20 4:13 PM, Nuno Sá wrote:
>> Make sure that a callback is actually present before trying to call
>> it...
>>
>> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
>> ---
>>   drivers/iio/buffer/industrialio-buffer-cb.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c 
>> b/drivers/iio/buffer/industrialio-buffer-cb.c
>> index 47c96f7f4976..b4385f59399d 100644
>> --- a/drivers/iio/buffer/industrialio-buffer-cb.c
>> +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
>> @@ -27,6 +27,10 @@ static struct iio_cb_buffer 
>> *buffer_to_cb_buffer(struct iio_buffer *buffer)
>>   static int iio_buffer_cb_store_to(struct iio_buffer *buffer, const 
>> void *data)
>>   {
>>       struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
>> +
>> +    if (!cb_buff->cb)
>> +        return 0;
>> +
> I think it makes more sense to check this once when the buffer is 
> registered instead of every time we want to call the function.

Sorry, should have read the cover letter more carefully. What you write 
there makes sense.

