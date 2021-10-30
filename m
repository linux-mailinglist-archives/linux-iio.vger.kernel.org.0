Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C564440898
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 13:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhJ3Lhw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 07:37:52 -0400
Received: from www381.your-server.de ([78.46.137.84]:55904 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhJ3Lhv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 07:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=rlkZcO5//VQhwA/dAF9FH2LPb/Za4ywcwqSgdhu+Gj8=; b=QNqIznzRUS9Yh2Q4zhGhEwBBnn
        /S8a1+Irw3/iDxrYf4g5DzPImMrZ9sVU8iWFTOlV1aIy/JAQFT8wiHz78NuwEpskYh3Ax2yPIeNFW
        6nQerhpToJSuhDD0EXVpBg3Gx6OHplKqY6dRJ/Yu4hAZ/6/SrDsJWqIIyd7Ev7sTdS1l/W9WH6pDH
        APxGt6obe/0Ra+55308UP79rI245mt/O9IwM00eCT8rTB2gJfDk1nQa6MS4u4oiJa9SCv6dZcJVSh
        Nkh05LMtWRH0gfSWnkIH1rVwi/ZZtY2RFYNVSfy6Ec5ISzwq1IsRwLijBh1NTeBGs1zWHBK+ms4H5
        q7pf2rRw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mgmdr-0006kp-F3; Sat, 30 Oct 2021 13:35:19 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mgmdr-000DNO-9N; Sat, 30 Oct 2021 13:35:19 +0200
Subject: Re: [PATCH 1/5] iio: Use .realbits to extend a small signed integer
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
References: <20211030111827.1494139-1-gwendal@chromium.org>
 <20211030111827.1494139-2-gwendal@chromium.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c71a2781-f5f6-0725-dbdf-aaa823883be1@metafoo.de>
Date:   Sat, 30 Oct 2021 13:35:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211030111827.1494139-2-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26338/Sat Oct 30 10:21:41 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/30/21 1:18 PM, Gwendal Grignou wrote:
> When calling sign_extend32() on a channel, use its .realbit information
> to limit the number of bits to process, instead of a constant.
>
> Changed only simple sign_extend32() calls, when .realbits was defined in
> the same file. Use 'grep -r sign_extend32 $(grep -lr realbits drivers/iio/)'
> to locate the files.
>
> Some files were not processed:
> gyro/fxas21002c_core.c : function parameter changes needed.
> health/max30102.c: Incomplete channel definition.
> health/max30100.c

I think this is good work, but it seems a bit out of place in this 
series. I think it will be easier to get this reviewed and merged if it 
is submitted independently. It might make sense to only have the sx9310 
changes as part of this series and send the other ones as a separate patch.

What's also missing in the commit description is the motivation for 
this. The generated code will be a bit more complex, so there needs to 
be a good justification. E.g. having a single source of truth for this 
data and avoiding accidental mistakes.

The patch also uses `shift` were applicable, which is not mentioned in 
the commit dscription.


> [...]
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 1eb9e7b29e050..355854f0f59d2 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -74,7 +74,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>   			    int *val, int *val2, long mask)
>   {
>   	struct mpl3115_data *data = iio_priv(indio_dev);
> -	__be32 tmp = 0;
> +	__be16 tmp = 0;
>   	int ret;
The be32 to be16 change might warrant its own patch. This is definitely 
changing the behavior of the driver. And I don't think it is correct the 
way its done. For the pressure data it is reading 3 bytes, which will 
cause a stack overflow.
>   
>   	switch (mask) {
> @@ -96,7 +96,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>   			mutex_unlock(&data->lock);
>   			if (ret < 0)
>   				break;
> -			*val = be32_to_cpu(tmp) >> 12;
> +			*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
>   			ret = IIO_VAL_INT;
>   			break;
>   		case IIO_TEMP: /* in 0.0625 celsius / LSB */
> @@ -111,7 +111,8 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>   			mutex_unlock(&data->lock);
>   			if (ret < 0)
>   				break;
> -			*val = sign_extend32(be32_to_cpu(tmp) >> 20, 11);
> +			*val = sign_extend32(be16_to_cpu(tmp) >> chan->scan_type.shift,
> +					     chan->scan_type.realbits - 1);
>   			ret = IIO_VAL_INT;
>   			break;
>   		default:

