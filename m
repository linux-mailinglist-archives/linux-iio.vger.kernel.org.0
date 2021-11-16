Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17740452C9F
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 09:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhKPI0K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 03:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhKPI0I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 03:26:08 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96620C061570;
        Tue, 16 Nov 2021 00:23:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so15117186pjr.5;
        Tue, 16 Nov 2021 00:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+vKQR2yjsr4EpvmyaU72REwMRnHBJTnUozWbZ4+OkE=;
        b=cBuE7Usu1jQbcBJMZKMLs7FbU7IGjsBMIpTOA2j2S4GoI8Ks0C7VsFzJqeAzPk3S/c
         gun3rgx7ykHpO2INlKwu5qY6x933MZqNwW/idwm4bI15InCICTmbeB9KL4OUGS+xt6IQ
         hiYZ2+3xFWnYzXT+dtXst5y/WUx5ZJUVoS1V16BEwiKDIHgimE79zAR4M6up0Yc7xorb
         CjVYYkymFZAzc5c3lsrKRPu0udULmHG0QylJmywi2ZQRexr3gWjVZQxtZMXanoHlSkiP
         wOHLT1FJag2QBjKOD9NwfmvomENUzhMIMeJY6sDVCSNkc1ZfpFiRZl9c2Y2+HknyvRAb
         E5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+vKQR2yjsr4EpvmyaU72REwMRnHBJTnUozWbZ4+OkE=;
        b=P14mQMfB+BzGgwzalj9uviL2u3SPStDfPATCoO5oaj2kouGj99Rfy02gqKp2NYltAa
         aGrAzVJtFB6HOi1jvvAo3uY0Wzt4PBa33mfF+oPKPcxYVhXWMkwgRBPHzyjv9MINhcLD
         6OmnIFtc90yox645O0pLeDKWSw/q/U7MwqC1wBo1KKOSLgh2sv9oDqKVQyTVBxwdExQp
         vZw/1DS6xt1WZs59ZYWMD3+dyBrujtETqiR0ds70SbJwJ9cjKK3m4+hIqWlUTk4lmCTO
         IVRau86omgeuLk8CSz9hkyp3cfB2Lj6KeOWvQ4KCpTlVaFj8EBjuFDa+14F1IUFikNYL
         QlVw==
X-Gm-Message-State: AOAM533arS+PHc31ZHFELHECs/0euktfk6LnKvyV+lAwUTnjBWJ/8pEh
        4ETn3AIo2AZT2uzkbwu6ge5MOPe1daByv3odboQ=
X-Google-Smtp-Source: ABdhPJxKZE+MWVQYmW3TQ0WM6WxO4BDm1lvKTnO98Ys/xKMCj83AX9173FQ5v5JK7vIKCh+0yQ0SvV40PcqU1lVdg3w=
X-Received: by 2002:a17:90b:4b83:: with SMTP id lr3mr73448586pjb.98.1637050991159;
 Tue, 16 Nov 2021 00:23:11 -0800 (PST)
MIME-Version: 1.0
References: <20211115141925.60164-1-paul@crapouillou.net> <20211115141925.60164-3-paul@crapouillou.net>
In-Reply-To: <20211115141925.60164-3-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 16 Nov 2021 10:22:59 +0200
Message-ID: <CA+U=DsqGZvCdVcEyTW7YpQOaPG7RMUzziN83d_ChnvNeFv3Paw@mail.gmail.com>
Subject: Re: [PATCH 02/15] iio: buffer-dma: Remove unused iio_buffer_block struct
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

On Mon, Nov 15, 2021 at 4:19 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> This structure was never used anywhere, so it can safely be dropped.
>
> It will later be re-introduced as a different structure in a
> different header.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  include/linux/iio/buffer-dma.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index d4ed5ff39d44..a65a005c4a19 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -17,11 +17,6 @@ struct iio_dma_buffer_queue;
>  struct iio_dma_buffer_ops;
>  struct device;
>
> -struct iio_buffer_block {
> -       u32 size;
> -       u32 bytes_used;
> -};
> -
>  /**
>   * enum iio_block_state - State of a struct iio_dma_buffer_block
>   * @IIO_BLOCK_STATE_DEQUEUED: Block is not queued
> --
> 2.33.0
>
