Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF52A28F8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 12:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgKBLXz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 06:23:55 -0500
Received: from www381.your-server.de ([78.46.137.84]:56998 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgKBLXy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 06:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=PCZHFLApwWzJFRgcfAJ8XmJ1FShjYVdLWpXLojDmDa0=; b=gaAmv2TPU0yfr38wyXOAtgDVAv
        yo65/5OyKZXvnwlYzH5HBrvFiorYYUNedE2ubKdYA/fg5k02KDwS3OW/cWlGZiIo74895yPsaU3Eb
        JzlhbCv6HR5g65XRiYAGQvh17L70nFjZ2Y/LJGaQpWBjP88ZYW7Gu4NvLFz09/K1JG5JQS8q7G+XL
        Mn1tLKa7YH89EZsJ8UOZE92B5lyltNzuxJ+iBclbtSi98X8RW+YB3f4uO2LzcPez0yvQzrdbculCo
        SMAdjc3h8vPN1KJavNreXs6Kd5JGWNRh+VjjEuKXk1HFptkINZaWG9tz4A7TC75vauo8eNjkY4z/n
        sYeR2Jqw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kZXwB-00008l-0M; Mon, 02 Nov 2020 12:23:47 +0100
Received: from [62.216.206.177] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kZXwA-000OMJ-TG; Mon, 02 Nov 2020 12:23:46 +0100
Subject: Re: [PATCH 1/1] iio: industrialio-trigger: Use 'gnu_printf' format
 notation
To:     Lee Jones <lee.jones@linaro.org>, jic23@kernel.org,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org
References: <20201102111725.1048562-1-lee.jones@linaro.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6b5807c1-08af-2633-3352-bd7ae084cbe2@metafoo.de>
Date:   Mon, 2 Nov 2020 12:23:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102111725.1048562-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25975/Sun Nov  1 13:18:14 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/2/20 12:17 PM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
>
>   drivers/iio/industrialio-trigger.c: In function ‘iio_alloc_pollfunc’:
>   drivers/iio/industrialio-trigger.c:338:2: warning: function ‘iio_alloc_pollfunc’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Jonathan already sent a similar patch. See 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd7798cbd28044a3026619e36993160ba8fa118d 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd7798cbd28044a3026619e36993160ba8fa118d>

>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/iio/industrialio-trigger.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 583bb51f65a75..1d65c83439d84 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -320,6 +320,7 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p)
>   }
>   EXPORT_SYMBOL(iio_pollfunc_store_time);
>   
> +__printf(5, 6)
>   struct iio_poll_func
>   *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
>   		    irqreturn_t (*thread)(int irq, void *p),


