Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC89125414A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgH0Izv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgH0Izu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 04:55:50 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55298C061264;
        Thu, 27 Aug 2020 01:55:49 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 5so3770008otp.12;
        Thu, 27 Aug 2020 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYRU5RWjdCABcW+SWFbp3Yrowl6dALpg4gGN9PPMym4=;
        b=NU6KxZo/Iocb1DwO8n2E2MmxQxjBz2QmvF6tuBRu/iXnmUOHthNxzm8LmtICLTuW1q
         W7cR9OOP5WiyZFhHBnj9HnPZgnLKBqljoZKc1H7WR2AgHS2gt2i+EI4VamX98hMKz+v4
         MlSIRxfx4Wtwpw5DUksXVn2aKQSE7rjY3AuVpocTsN4WSthyGK3E98tFYBGTaiZIyvHk
         e0s/kC6il6ZhcB3FvfbkGUI2NIEU5LgRiqENR8ShqRGjmnJH3uGl8J5cUA61r/zRms/M
         HXBdTKOY3u+LnMkAnxlOYE28knMiU0xVrl0nt+mtNIF5/rjKCWvpxofnnE4VLDMHeVVT
         6hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYRU5RWjdCABcW+SWFbp3Yrowl6dALpg4gGN9PPMym4=;
        b=lspfdG3GVDDEusxG51MKZLvI42v2KUzkoWGoxtDyse15nwCS3/cQ+IReitRbfNUJtF
         bc88qaSGxrW9+lMQQtoRXi/qGjHhBLmMz98j/X8pZSem5L/dPMAmyL25N22Uq3VY/AO4
         q0Q10PXXJ/lPsRmTHiimb8MZltCk6nwxpolbgmctPTPjcYnLvQP9MQcmGQJ+saher/US
         twdt3Sp38zueCbV7iCPXINAJ279wnLCAR4TXVE0vr62hD7AQg9WUssBXG/PEnUUQaEoh
         /zBmkoyXhSiuM5UKcO/TOTp+wLgKnEqZDnFIa3yvlGAnTe4pOYaCgt0hswse7FGSAWrF
         I4oA==
X-Gm-Message-State: AOAM532nkMJI4bUpIwyoX0n8q7ZsB4OfKwMqiCEIl3ZQrPxiFLWAHwQG
        Q/obR90Sp9Zq6go3sKoRQpn3G8dgzoRj/qWcyQM=
X-Google-Smtp-Source: ABdhPJyYmnPw+UXq5Pnbrb1d8+Ls6OeV0jJ9/BCH19PZH76AENpdIFCNPcG4tB6nf4A3wQ8tAgaLGVlATIaLG7vJeOg=
X-Received: by 2002:a9d:4c04:: with SMTP id l4mr12187928otf.207.1598518548666;
 Thu, 27 Aug 2020 01:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200826063850.47625-1-alexandru.ardelean@analog.com> <20200826120042.200364-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200826120042.200364-1-alexandru.ardelean@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 27 Aug 2020 11:55:37 +0300
Message-ID: <CA+U=DsrMDSTQKEc2_3+W8u4bLraAowVB3nB4huKY--v8gnds2Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: stm32-dac: Replace indio_dev->mlock with own
 device lock
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <jic23@kernel.org>, alexandre.torgue@st.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 26, 2020 at 3:03 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock. The lock protects against potential races when
> reading the CR reg and then updating, so that the state of pm_runtime
> is consistent between the two operations.
>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---

Forgot the changelog here.
Apologies.

Changelog v1 -> v2:
* removed whitespace change for 'common' field
* updated comment about the lock usage

>  drivers/iio/dac/stm32-dac.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index 092c796fa3d9..7a8aed476850 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -26,9 +26,11 @@
>  /**
>   * struct stm32_dac - private data of DAC driver
>   * @common:            reference to DAC common data
> + * @lock:              lock to protect the data buffer during regmap ops
>   */
>  struct stm32_dac {
>         struct stm32_dac_common *common;
> +       struct mutex            lock;
>  };
>
>  static int stm32_dac_is_enabled(struct iio_dev *indio_dev, int channel)
> @@ -58,10 +60,10 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>         int ret;
>
>         /* already enabled / disabled ? */
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&dac->lock);
>         ret = stm32_dac_is_enabled(indio_dev, ch);
>         if (ret < 0 || enable == !!ret) {
> -               mutex_unlock(&indio_dev->mlock);
> +               mutex_unlock(&dac->lock);
>                 return ret < 0 ? ret : 0;
>         }
>
> @@ -69,13 +71,13 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>                 ret = pm_runtime_get_sync(dev);
>                 if (ret < 0) {
>                         pm_runtime_put_noidle(dev);
> -                       mutex_unlock(&indio_dev->mlock);
> +                       mutex_unlock(&dac->lock);
>                         return ret;
>                 }
>         }
>
>         ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&dac->lock);
>         if (ret < 0) {
>                 dev_err(&indio_dev->dev, "%s failed\n", en ?
>                         "Enable" : "Disable");
> @@ -327,6 +329,8 @@ static int stm32_dac_probe(struct platform_device *pdev)
>         indio_dev->info = &stm32_dac_iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> +       mutex_init(&dac->lock);
> +
>         ret = stm32_dac_chan_of_init(indio_dev);
>         if (ret < 0)
>                 return ret;
> --
> 2.25.1
>
