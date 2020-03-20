Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D530C18CC00
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 11:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCTKz1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 06:55:27 -0400
Received: from www381.your-server.de ([78.46.137.84]:36214 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTKz1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 06:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pjk74y3vgIFREqLU0eWx0kkZhk75Smxzw2D9SkS0MZY=; b=L8+oB5QL4mDsYgRolT/46aJePe
        MJlOSYYO3Jjg6Ro6iW6uOhax9vY5JJMTcvLmjDmBjSv7opyobPuSHDlieiOdil/kWKypdPIvq5mIF
        QEx3TAGKyclO48PQi9N33YM6p/wVHuc4t6INpiZfVN8Bs13DE3h+zH2/BXKbM61zR63aA7mFeS6rY
        j3H4a7zFI5k2sEZ7LkVhI6FT8zKFIzUOcTyjFUb5LuTxRBcNydxukfrvENxoLA3o0vQ093bQSMqM1
        nCX2habqeXl0YFpJW0qqWEFp2+xot0hHs5i9exgXFUpGJfg6xSYOJ1rWp95ZLac8OPn9Nw0ZUG8wz
        Ufl7iYxg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jFFJG-0000yU-6Y; Fri, 20 Mar 2020 11:55:26 +0100
Received: from [93.104.114.206] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jFFJF-000IoB-VD; Fri, 20 Mar 2020 11:55:26 +0100
Subject: Re: [RFC][PATCH] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <253007c8-38ed-acd8-a506-b22f34d03997@metafoo.de>
Date:   Fri, 20 Mar 2020 11:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320104031.31701-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25756/Thu Mar 19 14:11:06 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/20/20 11:40 AM, Alexandru Ardelean wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Before activating a buffer make sure that at least one channel is enabled.
> Activating a buffer with 0 channels enabled doesn't make too much sense and
> disallowing this case makes sure that individual driver don't have to add
> special case code to handle it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> * Found this relic-patch in our tree, from 6 years ago:
>    https://github.com/analogdevicesinc/linux/commit/6d680e49d459c
>    It got moved around a bit, and this is the current form in the ADI tree.
>    So, this is also a bit of an RFC, but if the idea is valid, maybe it's
>    worth considering upstream. I don't know of any arguments against it,
>    but I could be surprised.

Hm, a bit weird that this one never made it upstream considering how 
simple it is.

Did you check that the issue still occurs? I can't see anything in the 
code that prevents it, but who knows, maybe it was fixed by something else.

> 
>   drivers/iio/industrialio-buffer.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4ada5592aa2b..f222a118d0d3 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1031,6 +1031,12 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>   		return ret;
>   
>   	if (insert_buffer) {
> +		if (bitmap_empty(insert_buffer->scan_mask,
> +			indio_dev->masklength)) {
> +			ret = -EINVAL;
> +			goto err_free_config;
> +		}

Since the check is so simple it might make sense to do it as the very 
first thing before iio_verify_update().

> +
>   		ret = iio_buffer_request_update(indio_dev, insert_buffer);
>   		if (ret)
>   			goto err_free_config;
> 

