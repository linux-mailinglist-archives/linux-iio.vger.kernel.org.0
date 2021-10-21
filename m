Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55D4435D4F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 10:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhJUIux (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 04:50:53 -0400
Received: from www381.your-server.de ([78.46.137.84]:59826 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhJUIuw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 04:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=N0t3tI0x09UykVrDlWJfBqg4gVODEbxL8QBgQkCO018=; b=YsdIss7DHX2bmPBjv3VK9gu8Cj
        gnJioT2zEhf5RlFQwu+5LoTlYosq4n6K3cG+kXJGkCoaDQHVJ5SiocNA+fL3SBfPTKYB6502ySraE
        BMm6ymM+Afr51ItLWQpFQNIjv6gItMrbZsgElaVJ2Tei9FFGo+6hrrGCe74fe2Ckd/3zUhbqM6iTQ
        Ae1YDcH/4ouH2dFQzGzMQGSq4dnZ7rZ/tmBJKZhZrBgN39XsKUQcI0iiHUdS8Nw/OxvtVa3sEtFBU
        ksHenlR7qZ+Fce4ZQ+Soy3tPEChyKwpjeFduk2FSu6ynRqIrjDm5y4PsQgu1N6YV9NB6DBHX4LIOe
        C1lwKa2w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mdTkX-0000wi-6O; Thu, 21 Oct 2021 10:48:33 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mdTkX-000RM3-2v; Thu, 21 Oct 2021 10:48:33 +0200
Subject: Re: [PATCH] iio: adc: ina2xx: Make use of the helper macro
 kthread_run()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211021083917.2024-1-caihuoqing@baidu.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6699a823-b7b4-6453-aec0-95058b26c27f@metafoo.de>
Date:   Thu, 21 Oct 2021 10:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021083917.2024-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26328/Wed Oct 20 10:18:39 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/21/21 10:39 AM, Cai Huoqing wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Hi,

Thanks for the patch, this looks good!

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
> [...]
>   	if (IS_ERR(task))
>   		return PTR_ERR(task);
>   
>   	get_task_struct(task);

This is unrelated to this patch. But I wonder do we really need the 
get_task_struct()? The driver calls put_task_struct() right after 
kthread_stop().

kthread_create()/kthread_run() and kthread_stop() already do reference 
counting of the task, so we are essentially just double reference 
counting. Maybe you can send another patch to cleanup the 
get_task_struct()/put_task_struct() in this driver.

> -	wake_up_process(task);
>   	chip->task = task;
>   
>   	return 0;


