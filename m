Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06C3F4BE1
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhHWNw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 09:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWNwZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 09:52:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6375FC061575;
        Mon, 23 Aug 2021 06:51:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u15so10595485wmj.1;
        Mon, 23 Aug 2021 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=grHlTpaRkCmdCSG4Kz5PeLTfu9q+9hdgMA5QHBIPirk=;
        b=EF0NgJ7BZ7KozqQXBSjLRguH5ie4StFr9uqNXoMD+xfy211ySKHJ+KFF+tFlhYSYVj
         CbG2DD3vZOeE0AO6CpTQkdm/JyE16PUDJTg3Q8muWqYH3C932Y7ebmf4z1vB/NttnZY0
         5ney5OYr4bUTirp5fmzVZfGWlCcCrNZV+50pOK5pIZho7VC/cnOeNxjFUQ7fcLhIVUdl
         6+8AQFN/wdIYy/rLcVTJpBFgljtjgJ9oiDri6oB4E93zStJKGEJvkAyKFSdGrvUu1Fmj
         M8RIHtWUIaMBOGPBSB+GBkt7SGJDqIKySIEam66ilqOUKb6w33feFqS0LN/GW7RuQD9W
         Mk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=grHlTpaRkCmdCSG4Kz5PeLTfu9q+9hdgMA5QHBIPirk=;
        b=c2YaUebjTgyvREvWzJKnMbh7CiyMdgqcDzMGZ6CNg9E7b9YeQ4I1htsUzqPQno/fvc
         Mm4J12UnXiIXUc+SAjjYBRYXVPvrmBk46axwwoMuVwQxAuPwmqVdptxYz0OEJJROHQuB
         XPKeKJvF4tKlISHZzJUleWzB1hHe5MGf6tSauyoFWIfigHXc00qmCuP2j+vD5+xyLlhb
         ScEyfV0O2AZ09GGoFwhYiO/1KMnBtieQk08okNbp/wZMA/L4lOEAitnN9b+R0VgXkhPi
         AlNwDP71aoq1U9snitV+rKWI7XVQvpauhs8rsS6DHHDQc/rlyqYF7OKqvROt4aFsublN
         AHBg==
X-Gm-Message-State: AOAM531q5yjvfVcLf7+O4SA4e5INOXo/hl/md5QbaZmXvMyCIaaYkYVw
        r1QNEMoq6tWUg2apPi2EtDE=
X-Google-Smtp-Source: ABdhPJzSKuJDkGBav4aEO8tyZv1+fgDy6QOqLEnyX8LyIDohUuKibZPlXjuFsAjsrj8gjAGwchQrfw==
X-Received: by 2002:a1c:7e8a:: with SMTP id z132mr16322219wmc.75.1629726700959;
        Mon, 23 Aug 2021 06:51:40 -0700 (PDT)
Received: from nunojsa-N551JK ([2001:a61:2531:cb01:1061:e4b5:709f:d9ad])
        by smtp.googlemail.com with ESMTPSA id m39sm20959410wms.36.2021.08.23.06.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:51:40 -0700 (PDT)
Message-ID: <0d872fd789603a2d4dd74594f841d4bea7de38d3.camel@gmail.com>
Subject: Re: [PATCH v4 2/6] iio: kfifo-buffer: Add output buffer support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Mihail Chindris <mihail.chindris@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com
Date:   Mon, 23 Aug 2021 15:51:39 +0200
In-Reply-To: <20210820165927.4524-3-mihail.chindris@analog.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
         <20210820165927.4524-3-mihail.chindris@analog.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2021-08-20 at 16:59 +0000, Mihail Chindris wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Add output buffer support to the kfifo buffer implementation.
> 
> The implementation is straight forward and mostly just wraps the
> kfifo
> API to provide the required operations.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  drivers/iio/buffer/kfifo_buf.c | 50
> ++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/iio/buffer/kfifo_buf.c
> b/drivers/iio/buffer/kfifo_buf.c
> index 516eb3465de1..7368db2d5c32 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -138,10 +138,60 @@ static void iio_kfifo_buffer_release(struct
> iio_buffer *buffer)
>  	kfree(kf);
>  }
>  
> +static size_t iio_kfifo_buf_space_available(struct iio_buffer *r)
> +{
> +	struct iio_kfifo *kf = iio_to_kfifo(r);
> +	size_t avail;
> +
> +	mutex_lock(&kf->user_lock);
> +	avail = kfifo_avail(&kf->kf);
> +	mutex_unlock(&kf->user_lock);
> +
> +	return avail;
> +}
> +
> +static int iio_kfifo_remove_from(struct iio_buffer *r, void *data)
> +{
> +	int ret;
> +	struct iio_kfifo *kf = iio_to_kfifo(r);
> +
> +	if (kfifo_size(&kf->kf) < 1)
> +		return -EBUSY;
> +
> +	ret = kfifo_out(&kf->kf, data, 1);
> +	if (ret != 1)
> +		return -EBUSY;
> +
> +	wake_up_interruptible_poll(&r->pollq, POLLOUT | POLLWRNORM);
> +
> +	return 0;
> +}
> +
> +static int iio_kfifo_write(struct iio_buffer *r, size_t n,
> +	const char __user *buf)
> +{

nit: I would align this with the open parenthesis...

- Nuno Sá


