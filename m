Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633B5BE932
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 01:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbfIYXtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Sep 2019 19:49:32 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46058 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733228AbfIYXtb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2019 19:49:31 -0400
Received: by mail-yb1-f194.google.com with SMTP id w125so93375ybg.12;
        Wed, 25 Sep 2019 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k9mLt3xvBGQYqXgvvuQtbv73TYKlfgFjBjUgVp0qnQw=;
        b=Mz6cTUt84IXGgN7GfbtlAUT3P8OZ4XIjQsUqjicxykyuBsc/2+eKucFV2n7wBOek5d
         hDv6yELVsr93aswKiKh6beCWKN8KxGzQBFSz5l96eLf366E8/U5yJgkF2onOLEzYuGpy
         MmqUd83SpWPMlbOiClqh7uF+xJLtaYqHE9kf9PLonOfFzjLkOqHPrhry9UaKNfh4FKdt
         UlI1a1E3Jks+g635OnXG/EIMyRUidmRSooforLC0eH4yh1FVK1vwNVh5/1runhUUkqRq
         d4coagceYif32HrnlJUericT2nGAVxG6WhJHXsT7p2UdxrYY2lxgSMdeBiNs0EUU/RGT
         ZVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k9mLt3xvBGQYqXgvvuQtbv73TYKlfgFjBjUgVp0qnQw=;
        b=donOyxaQiKzfM1zbbVtlxCeYtif8bEqfIvYpDcRrKKywqhhFULA660rIRRS96F+yI3
         pqfDG36d/vYt51FCjv2U8dl5utoz7Em/Lcp5R775GIbDyUXYV96l7Gs6oGgDu99lv3nn
         G/aRRsFJ1LQboYHwkxqbkDHS5kVejIeLrgjy+ujFoKmJHwj/p2GUbrYoQMiKOEOjDgDN
         uYEF5YEHEa/3GZ6bPgCQWMVmRkglAGM2bqGvpXGNcwB6UkughhpgaC5xkySjeaS2C+kN
         jrezYAkVmXPWLMdSyXCZPiMVES03JMpT52+9z8aCKb3cjGncPnYUE5e84cd4aAQWV6il
         1zsw==
X-Gm-Message-State: APjAAAU+sxCFFpaQaoR5iduoeF2i4LAFu4oEjDDnQojECYMeajO8FxOC
        I14s3EedZFVEz3jxvjyGtQk=
X-Google-Smtp-Source: APXvYqwR/caITcJ282u+zi2PrD7+FaXW9ELk/UeVSqScZoBfsW21TB7udKc9KZYQBZ1Bf/aHmdEpfw==
X-Received: by 2002:a25:e0d4:: with SMTP id x203mr157687ybg.131.1569455370860;
        Wed, 25 Sep 2019 16:49:30 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id i14sm56666ywe.107.2019.09.25.16.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:49:29 -0700 (PDT)
Date:   Wed, 25 Sep 2019 19:49:27 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        jic23@jic23.retrosnub.co.uk
Cc:     jic23@kernel.org, alexandre.torgue@st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: fix a kernel-doc warning
Message-ID: <20190925234927.GB14133@icarus>
References: <1568809323-26079-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1568809323-26079-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 18, 2019 at 02:22:03PM +0200, Fabrice Gasnier wrote:
> Fix the following warning when documentation is built:
> drivers/counter/stm32-timer-cnt.c:37: warning: cannot understand function
> prototype: 'enum stm32_count_function'
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 644ba18..e425dd1 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -28,7 +28,7 @@ struct stm32_timer_cnt {
>  };
>  
>  /**
> - * stm32_count_function - enumerates stm32 timer counter encoder modes
> + * enum stm32_count_function - enumerates stm32 timer counter encoder modes
>   * @STM32_COUNT_SLAVE_MODE_DISABLED: counts on internal clock when CEN=1
>   * @STM32_COUNT_ENCODER_MODE_1: counts TI1FP1 edges, depending on TI2FP2 level
>   * @STM32_COUNT_ENCODER_MODE_2: counts TI2FP2 edges, depending on TI1FP1 level
> -- 
> 2.7.4

Fixes: 597f55e3f36c ("counter: stm32-lptimer: add counter device")

Jonathan, please pick this fix up through IIO.

Thanks,

William Breathitt Gray
