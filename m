Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E0DB29E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2019 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391079AbfJQQlk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Oct 2019 12:41:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33408 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfJQQlk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2019 12:41:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so2448757lfc.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Oct 2019 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9bizna7G7Om3cZn0nGwpOJh+7ANQ7i4dkTdpQcsQemg=;
        b=U11ac5DMRhZGtPTItC96uDP1/7ern8vUSY1yJnP3PYjGQ7MkncbdJmxx/QO3XleNvW
         uKiR/4P3sAKygclkhCwcjlhRpykROLBPBZcgKr5pTSsLR6ZAgWuY9FBlHg967HUejwBP
         5n/fNb2IjYYtNmNNE/JnGJgUmsTedynMwFVe4HixHTcwrkbMT1//RFcP/2Oj3s+isB2a
         ktS4beNpeBA38JVq+Zf7pczt07Q6kFRr9jD3zMycxklP3OeubnpuAODie+vtsbyJd4+c
         KsIb4P/+KX08hozW4Gc7hHLWTtWqMNCWOH4lu9Gsys6793STO5s4+llRapIUWYbYc5GK
         oogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9bizna7G7Om3cZn0nGwpOJh+7ANQ7i4dkTdpQcsQemg=;
        b=r1aexvPwv2JsC4RouKTtIbjaSztDSrMEM0hHmiGXWn/ocDOWtfLld9fUNroK+U1er1
         iTUCk3bDkqUGss4IzNtn5u09tFxswIdX+ZWTOsrlcfnOS1BOY3lqC77YFnr/AB3yBAMm
         TYf4PfsuaZZR8Qn6D9Wsm4CPRo9qYsFUFdEh7jE/K1x3VlxAEXYwXce01Px7VfqYm7eR
         3U2lczvgDD6Yp8p3XRahITXvFv+9Z/28MnsTqLLGaSeMa+IZqQWYq3YLp+vOH2uVhE5R
         upqVv7RCp2B2xJDpzRZ9XXn0sdw0WUeTGgxNg+CBJBUOHfO6IDYw3GSrdNX4IzBzxRvp
         i/5A==
X-Gm-Message-State: APjAAAVWiKfN7+CmnoBzEfRMUDLF8ArCdtHvYYQxsfdoRMIghwaBjjNV
        IBPTC5GpI7mcPDBykYHAqGUhS+ndHVA=
X-Google-Smtp-Source: APXvYqw4LQv8H1Cdp6BH1KVjhiPYaar7N842a35LQQz5klHIK0WbdiJddHe/ZpI5GdG4IccIyKm/Ww==
X-Received: by 2002:ac2:5c1b:: with SMTP id r27mr2988752lfp.172.1571330497836;
        Thu, 17 Oct 2019 09:41:37 -0700 (PDT)
Received: from localhost (89-70-31-203.dynamic.chello.pl. [89.70.31.203])
        by smtp.gmail.com with ESMTPSA id q3sm1110896ljq.4.2019.10.17.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 09:41:36 -0700 (PDT)
Date:   Thu, 17 Oct 2019 18:41:12 +0200
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH] iio: chemical: sps30: Explicity truncate constant by
 masking
Message-ID: <20191017164112.GA5100@arch>
References: <20191013095515.1438147-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191013095515.1438147-1-jic23@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 13, 2019 at 10:55:15AM +0100, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> When breaking up a constant to write to two 8 bit registers
> it isn't obvious to sparse that it was intentional.
>
> CHECK   drivers/iio/chemical/sps30.c
> drivers/iio/chemical/sps30.c:120:30: warning: cast truncates bits from constant value (8004 becomes 4)
>
> So in the interests of minimising noisy warnings, let us add
> a mask.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  drivers/iio/chemical/sps30.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index edbb956e81e8..acb9f8ecbb3d 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -117,7 +117,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
>  		break;
>  	case SPS30_READ_AUTO_CLEANING_PERIOD:
>  		buf[0] = SPS30_AUTO_CLEANING_PERIOD >> 8;
> -		buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
> +		buf[1] = (u8)(SPS30_AUTO_CLEANING_PERIOD & 0xff);
>  		/* fall through */
>  	case SPS30_READ_DATA_READY_FLAG:
>  	case SPS30_READ_DATA:
> --
> 2.23.0
>

Thanks for catching this.
Acked-by: Tomasz Duszynski <tduszyns@gmail.com>
