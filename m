Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C322B09B1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 17:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKLQQC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 11:16:02 -0500
Received: from www381.your-server.de ([78.46.137.84]:57360 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgKLQQC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 11:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=d8x8Foilk6qHJkAC/FTtooebxxTve4qGtSTr90knXjE=; b=DSqkqFqU8Vy2bjGnSbqwniS6Me
        eUBUCsv+wmZX5U6u5yXq1vjIvOjNPXrP1K6vg6YH3ZJuV4yc92RiEgFJTVIAXD7gNS4zHflRylo64
        w1t7LmUL/u7ROeFnQI6vak8PJ0z5FJ+7k7yI5qF/Jzm9kx/vI0NgpEbJToUMjocwB92conEglJpt3
        XmNwbJlMb9vmUHpm1lpx+YK+tK5HLC9pyhOduQaXPhaSP8e6prnMSzltBdWvE1GNBGqHHqtsSvVMN
        oCig0DXHhJKPzPjznXze5RmHSVTQ4FH5GzN71BdPUiHl6fLj5vV0GF0cJU8oTNcqpyeGYseIBMjGM
        vFg03Qhw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kdFGP-0007NL-Bo; Thu, 12 Nov 2020 17:15:57 +0100
Received: from [62.216.202.98] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kdFGP-0003lA-7T; Thu, 12 Nov 2020 17:15:57 +0100
Subject: Re: [RFC PATCH 1/1] iio: buffer: Sanity check buffer callback
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20201112151334.32167-1-nuno.sa@analog.com>
 <20201112151334.32167-2-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e8da8110-d029-fa1d-1732-e147e30e2850@metafoo.de>
Date:   Thu, 12 Nov 2020 17:15:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201112151334.32167-2-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25986/Thu Nov 12 14:18:25 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/12/20 4:13 PM, Nuno Sá wrote:
> Make sure that a callback is actually present before trying to call
> it...
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>   drivers/iio/buffer/industrialio-buffer-cb.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
> index 47c96f7f4976..b4385f59399d 100644
> --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> @@ -27,6 +27,10 @@ static struct iio_cb_buffer *buffer_to_cb_buffer(struct iio_buffer *buffer)
>   static int iio_buffer_cb_store_to(struct iio_buffer *buffer, const void *data)
>   {
>   	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
> +
> +	if (!cb_buff->cb)
> +		return 0;
> +
I think it makes more sense to check this once when the buffer is 
registered instead of every time we want to call the function.
