Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F4C6995F6
	for <lists+linux-iio@lfdr.de>; Thu, 16 Feb 2023 14:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBPNkz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Feb 2023 08:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBPNky (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2023 08:40:54 -0500
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3265247435
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 05:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Q5qJ0V6GoQhxv2SEYcaND2D7F8g0E9Je29oFGNogLrc=; b=P5Bkq2syWsz1qq5XLvqbI25gNE
        Th2ZkAWLSuNMUBjjouONYOdnOthY3yvpQX27SHRL8A3jQcsn4uv/SLXoPQtqFoifWMyANeRlw2Ef1
        CtPvpZKJNiu9kGo1pJcsyV5tBCha9YcvwSD0sMLXMYGuJI48tfSm8wC8BHCE+t8Sl2C4vYaoOD6o/
        7TAIF4S7xhhafivt0ANqel6i9JlqM+MD9aPAGNGZEqocuRzNUre1l+SMDUrVx8o/+w6UAxeL7dDWI
        q/kwpwTdgCedKzY4E9lu7Z7bBjNgrdR0u6bjMns+NFxSHlQ8QklCC3Nm/WgNpyqKz2jSDQd9XOuF0
        Qk3fP88g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pSeVF-000MJ1-2y; Thu, 16 Feb 2023 14:40:49 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pSeVE-0000wG-QC; Thu, 16 Feb 2023 14:40:48 +0100
Message-ID: <2e2ea230-792f-1487-e6c1-ae5a88b63f11@metafoo.de>
Date:   Thu, 16 Feb 2023 05:40:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] iio: buffer: correctly return bytes written in output
 buffers
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>
References: <20230216101452.591805-1-nuno.sa@analog.com>
 <20230216101452.591805-2-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230216101452.591805-2-nuno.sa@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26814/Thu Feb 16 09:40:04 2023)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/16/23 02:14, Nuno Sá wrote:
> If for some reason 'rb->access->write()' does not write the full
> requested data and the O_NONBLOCK is set, we would return 'n' to
> userspace which is not really truth. Hence, let's return the number of
> bytes we effectively wrote.
>
> Fixes: 9eeee3b0bf190 ("iio: Add output buffer support")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/iio/industrialio-buffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 228598b82a2f..c56cf748fde1 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -220,7 +220,7 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
>   	} while (ret == 0);
>   	remove_wait_queue(&rb->pollq, &wait);
>   
> -	return ret < 0 ? ret : n;
> +	return ret < 0 ? ret : written;
>   }
>   
>   /**


