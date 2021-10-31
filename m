Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B294B440D93
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 10:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhJaJSZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 05:18:25 -0400
Received: from www381.your-server.de ([78.46.137.84]:60860 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJaJSY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 05:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=w4QgHRp/dBNud25Gy7hZMq6UQTWVvCGTtGaPXsJk0EM=; b=bw1AyYIFhAOjH2VZZsbXFdhram
        IVP7fFTfAArYALpfSTfeeBlcHHpWznoSAUiTRjJ6s9O8C2eDBwYhclxK+3/zQnPIkyFr5sHf+JZM5
        BiQ+VZv9h7MppZ6R6+fQULJh60QrLvFvvSqNnV0/yFbLklxKFvgzzXZT7CYAkm07VBd3XCG8ILamD
        JO85rFPGNcBVVK27HSbsqQyXAFW7i6FIl/rzI6D1dMAiUitUWGwDaEJLdJNVOzX3y4jKlT/FvOkis
        sTv3anN4hfl13sfjlo/mxMso6omfO1RKPhOzk/l0Yx5FuhYHMiJhTxCuxAuIjd96nvbbKRNLpJm04
        +srgVAmQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mh6wS-0009cu-7D; Sun, 31 Oct 2021 10:15:52 +0100
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mh6wS-0005Mv-2c; Sun, 31 Oct 2021 10:15:52 +0100
Subject: Re: [PATCH 2/2] iio: viio_trigger_alloc(): Correctly free trigger on
 error
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20211031073231.13780-1-lars@metafoo.de>
 <20211031073231.13780-2-lars@metafoo.de>
 <CAHp75VfT-VgMODDdZCy8ERh1Uw8HVR6YuzmTukeP+nHbrx++sg@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <cfa7d882-7825-74d6-ff50-d8bd85dbf0f1@metafoo.de>
Date:   Sun, 31 Oct 2021 10:15:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfT-VgMODDdZCy8ERh1Uw8HVR6YuzmTukeP+nHbrx++sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26338/Sat Oct 30 10:21:41 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/31/21 9:54 AM, Andy Shevchenko wrote:
>
>
> On Sunday, October 31, 2021, Lars-Peter Clausen <lars@metafoo.de 
> <mailto:lars@metafoo.de>> wrote:
>
>     Once device_initialize() has been called on a struct device the
>     device must
>     be freed by decreasing the reference count rather than directly
>     freeing the
>     underlying memory.
>
>     This is so that any additional state and resources associated with the
>     device get properly freed.
>
>     In this particular case there are no additional resources
>     associated with
>     the device and no additional reference count. So there is no
>     resource leak
>     or use-after-free by freeing the struct device directly
>
>     But in order to follow best practices and avoid accidental future
>     breakage
>     use put_device() instead of kfree() to free the device when an error
>     occurs.
>
>     Signed-off-by: Lars-Peter Clausen <lars@metafoo.de
>     <mailto:lars@metafoo.de>>
>     ---
>      drivers/iio/industrialio-trigger.c | 12 +++++-------
>      1 file changed, 5 insertions(+), 7 deletions(-)
>
>     diff --git a/drivers/iio/industrialio-trigger.c
>     b/drivers/iio/industrialio-trigger.c
>     index 93990ff1dfe3..d566e8d4a14b 100644
>     --- a/drivers/iio/industrialio-trigger.c
>     +++ b/drivers/iio/industrialio-trigger.c
>     @@ -480,7 +480,7 @@ static void iio_trig_release(struct device
>     *device)
>             struct iio_trigger *trig = to_iio_trigger(device);
>             int i;
>
>     -       if (trig->subirq_base) {
>     +       if (trig->subirq_base > 0) {
>
>
>
> >= ?

I don't know. 0 is not supposed to be a valid irq number. And we 
kzalloc() the struct, so if it hasn't been explicitly initialized we'd 
get 0.

The way the code is at the moment we'd never end up here without calling 
irq_alloc_descs(), so it is either a valid irq or a negative error code 
and I can see why you might want to use >= for consistency and symmetry.

>
>                     for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER;
>     i++) {
>                             irq_modify_status(trig->subirq_base + i,
>                                               IRQ_NOAUTOEN,
>     @@ -541,11 +541,11 @@ struct iio_trigger
>     *viio_trigger_alloc(struct device *parent,
>     CONFIG_IIO_CONSUMERS_PER_TRIGGER,
>                                                 0);
>             if (trig->subirq_base < 0)
>     -               goto free_trig;
>     +               goto err_put_trig;
>
>             trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
>             if (trig->name == NULL)
>     -               goto free_descs;
>     +               goto err_put_trig;
>
>             trig->subirq_chip.name <http://subirq_chip.name> = trig->name;
>             trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
>     @@ -559,10 +559,8 @@ struct iio_trigger *viio_trigger_alloc(struct
>     device *parent,
>
>             return trig;
>
>     -free_descs:
>     -       irq_free_descs(trig->subirq_base,
>     CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>     -free_trig:
>     -       kfree(trig);
>     +err_put_trig:
>     +       put_device(&trig->dev);
>             return NULL;
>      }
>
>     -- 
>     2.20.1
>
>
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>

