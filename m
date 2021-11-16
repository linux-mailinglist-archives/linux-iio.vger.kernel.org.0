Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B187452E6B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 10:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhKPJyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 04:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhKPJyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 04:54:25 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C6C061227;
        Tue, 16 Nov 2021 01:50:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u11so16961558plf.3;
        Tue, 16 Nov 2021 01:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOEo7+eEw7HOmFubNhZ5NIb+kpAjTOtWN/+/owTaRTQ=;
        b=lg9HAcs2AQJqwWwikf1xHuQykcP79WUH7MT8HXFxMccsym9AafWmijDfhnYN3IoL1n
         sCpQHuwA5+jhCEoEYCIb+y+unEBRQu3KKD1Dbslf5hQmMxoDMIbutJMfca4UlZcvK41b
         qes4oeREIyGgdWeqjv3KMc6JFd+E/Pm/pIh/7BG1E5+8SLEBgZ3kDYnzioKkZINroEEG
         sNxTqo1aqhCYSNWoRDtkavrL3cF1Wt0H+sMunaGS4OoCQIGiC5qCwt02Nn8aUEyCzZNg
         3tKexTVRSn75VsedToXCGH8ntvBgaDVv5VLWiSBOD1uc/rCiWnwK0Nfr9de4KUQHGeqs
         17hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOEo7+eEw7HOmFubNhZ5NIb+kpAjTOtWN/+/owTaRTQ=;
        b=iD8oLVNne8yiwbJbW0HLfCyHGX1GYFwpEmftgcc3a1MlSjq/I1udEeB3Yi53SOEX3W
         4is/p22xDke3Ol+pcNPvo1LyOVYklAzlw/3s2XQG66rEGKJaggt85OqBQI63vlxSRghV
         LSZgrfqEw/zWli0bnbhr/K48s3TctOz1YU/SfYnqte2sXKDca8AS1AY/SFWK+PECbXQ3
         D9khVmIGcQ670O/BtOZwKMU/nKgIosRcjwChtZpng0etdocl58ykV4rTHH9tVtmS/e/p
         7XP9oWFcAC1OjMo9HRkowqgpZQbMdmJ7rHwr3biXi+RpvGIF4hbQsNKg0HFqAgHbgSoK
         fp0A==
X-Gm-Message-State: AOAM530TyEs8ceYvbjoRgNTduLnYyVjn3orijW2ZQJBWNbRm3G1mTjLX
        nv5Ho+FgNg5INaOV4rHcdZ0EysPwPSB/3quRo+Q=
X-Google-Smtp-Source: ABdhPJxjkwFXdhzCHzbozqRCnmGohriRD2ActA2SYX/tVP+evd9ZLHyQZfBC+bl7MpvRwzONNxG00ZpuXMx27S39qkk=
X-Received: by 2002:a17:902:748c:b0:142:5f2f:1828 with SMTP id
 h12-20020a170902748c00b001425f2f1828mr43623292pll.4.1637056215138; Tue, 16
 Nov 2021 01:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20211115141925.60164-1-paul@crapouillou.net> <20211115142243.60605-1-paul@crapouillou.net>
 <20211115142243.60605-2-paul@crapouillou.net>
In-Reply-To: <20211115142243.60605-2-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 16 Nov 2021 11:50:03 +0200
Message-ID: <CA+U=DsoJWgifThUwcQ61M6851H7JVKH2s_O3=JJ0CsPeX8wdoA@mail.gmail.com>
Subject: Re: [PATCH 13/15] iio: core: Add support for cyclic buffers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 4:22 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Introduce a new flag IIO_BUFFER_DMABUF_CYCLIC in the "flags" field of
> the iio_dmabuf uapi structure.
>
> When set, the DMABUF enqueued with the enqueue ioctl will be endlessly
> repeated on the TX output, until the buffer is disabled.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/industrialio-buffer.c | 5 +++++
>  include/uapi/linux/iio/buffer.h   | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 30910e6c2346..41bc51c88002 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1600,6 +1600,11 @@ static int iio_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
>         if (dmabuf.flags & ~IIO_BUFFER_DMABUF_SUPPORTED_FLAGS)
>                 return -EINVAL;
>
> +       /* Cyclic flag is only supported on output buffers */
> +       if ((dmabuf.flags & IIO_BUFFER_DMABUF_CYCLIC) &&
> +           buffer->direction != IIO_BUFFER_DIRECTION_OUT)
> +               return -EINVAL;
> +
>         return buffer->access->enqueue_dmabuf(buffer, &dmabuf);
>  }
>
> diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
> index e4621b926262..2d541d038c02 100644
> --- a/include/uapi/linux/iio/buffer.h
> +++ b/include/uapi/linux/iio/buffer.h
> @@ -7,7 +7,8 @@
>
>  #include <linux/types.h>
>
> -#define IIO_BUFFER_DMABUF_SUPPORTED_FLAGS      0x00000000
> +#define IIO_BUFFER_DMABUF_CYCLIC               (1 << 0)
> +#define IIO_BUFFER_DMABUF_SUPPORTED_FLAGS      0x00000001
>
>  /**
>   * struct iio_dmabuf_alloc_req - Descriptor for allocating IIO DMABUFs
> --
> 2.33.0
>
