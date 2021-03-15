Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF433ACDC
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 08:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCOHzy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 03:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhCOHzq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 03:55:46 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE4AC061574
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 00:55:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y20so14040376iot.4
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 00:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOHnCr3sP2/TkcDXXuXO4GXc00bYMmteFSDJDLh0Wcg=;
        b=ZqsUW7AH1LSZkLhzUFghGAxT74MdwbJhM+069ETnT+FpOxpRxQW/0KFbq/mYjd7mdd
         pVmBEe+5hPiJW2cIQukJ3NqaaFA+tafhIsC9/PxTuit5gkSZVBJld0b+yqzB1izsr7gg
         0A9i5L0hj4H2jErev3B5jsQZ38eYn7awrkewtP8xzcUnPItpVDmwoU6IO5jTc6jDkp5x
         n+WQYpJ5pE+FMiCjJs02h5XJCbSsfZdp/rxlIQSIp+P76rTGFgEeL88AGS/Lap3+Gude
         TeuT3ZrdEW28EG5zZaMZZI7542Slsy8vIxbTtkKBkUFOCw9/Qtu8HJ0DOSSPOuXemV3W
         LwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOHnCr3sP2/TkcDXXuXO4GXc00bYMmteFSDJDLh0Wcg=;
        b=kuq5qC1E9aTEtXGCcwF7MOdJivxRib4wHNWk33I2GIRWNtUKr6n8lCDt/qLJw5H6m0
         aOg98vMNk/+sb4MaZVc5/VSDBvWvu+0gANZoOxD5M7wxlgP+lUBSPGe4qaVkToNQsVHp
         3dGDMDh4SUm788mVdi4mYHFp0vrw+sUrADM3WvVUN7qu3ipUw6To2Whm9FWNKJZGj6+v
         qk+Bn+MHwO/4zQiDP0Im310Vrfwqi8Fczo/e63w3o9s91tTvVtiGJtQjmzCQ9V2hdj3l
         Bc9hXhTx25jkFMtuqBSD8phKXRWwhCWRQxJW7yYxNab9ma/B2JIw5GQt+/bEp72GSc8F
         Euag==
X-Gm-Message-State: AOAM533ex4dpOZuWPGkPq5hm4EBNIDCmFApbSXvN/hRL6X9PEVjH9CJ6
        T9+D3R1+ixM/uXXsbSDj/dDziweHja48Fx+SxmgrEViBnmi3Ag==
X-Google-Smtp-Source: ABdhPJzY9Z6+3ep+ljLLTrN8Wk0zCUesZxBz/NMQblDOwOQYncqBrUkhnKyZcqqkBRP+JFcdlD+JJqhDjccy7f/ofXM=
X-Received: by 2002:a02:8545:: with SMTP id g63mr8379408jai.79.1615794946090;
 Mon, 15 Mar 2021 00:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210314164655.408461-1-jic23@kernel.org> <20210314164655.408461-9-jic23@kernel.org>
In-Reply-To: <20210314164655.408461-9-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 15 Mar 2021 09:55:35 +0200
Message-ID: <CA+U=DsqS3wu9mGDJ-jbYLPStXVtHZQH4Dk30G2aRDUWaBR2KZg@mail.gmail.com>
Subject: Re: [PATCH 8/8] iio: buffer: kfifo_buf: kernel-doc, typo in function name.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 6:49 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Should have been _kfifo_ and was _fifo_

oops

Acked-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> ---
>  drivers/iio/buffer/kfifo_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index 4ecfa0ec3016..d72cfb354be6 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -180,7 +180,7 @@ static void devm_iio_kfifo_release(struct device *dev, void *res)
>  }
>
>  /**
> - * devm_iio_fifo_allocate - Resource-managed iio_kfifo_allocate()
> + * devm_iio_kfifo_allocate - Resource-managed iio_kfifo_allocate()
>   * @dev:               Device to allocate kfifo buffer for
>   *
>   * RETURNS:
> --
> 2.30.2
>
