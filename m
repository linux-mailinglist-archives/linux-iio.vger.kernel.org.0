Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294F2CCBAA
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfJERa1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 13:30:27 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37157 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJERa1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2019 13:30:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id z125so3235338ybc.4;
        Sat, 05 Oct 2019 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SFxd5AapzSICM/6Xgqhe/u9Vw5QC679Bx+c0QdN9hnI=;
        b=C4StFwvN+lCG1jC5GtRTymuZCkTXZueajmp5oKh8q2nS/QR4Y2Oo9mBbom6a6lMX/v
         f60G7QcnH8JR/KGokgFN2ry3x3ceJqyt0nyeTAkLqQ7SsSWqzosmkiLWW2dB85RQWaUZ
         84ubNkcrNehQ4E0ryRIKFRdhvYl+I1a/sJrA/gvfYI/XHD28QUBdpd3oOhyXrN43bQK5
         q5eNY46ePlOob7dDWUIctgZzkEKPabn+3FopVzptgyXTYfM8jYbTjnBHttfjXTT6iDQk
         zucn3Ajq0P4wByuR6wWzOPHXuIzhE1ag6cVKPVQBA1dLhD2+UnXqTF4K7mG2A79O+zOM
         ziPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SFxd5AapzSICM/6Xgqhe/u9Vw5QC679Bx+c0QdN9hnI=;
        b=J7BlL7nMIjw+3RN71fvDqaEh4cU1FkNodsC/HTY8ifcmh8fZPkiySvaCE6vdaVe0v4
         e/H+m1C8dxCL14QCMk/WdrLdNLXN7kvBuSUHsPUFkM4M+jp4EWezaOzMzMvpIbDq4vty
         fVG2Ks/rNdRnsPUTDXrg2f1QuPZot7LEByrThkgKlZogf0uRLtGm8F1b0ps5n2GFfkoQ
         bTXw1AJKFkgvM9nZgi2vJTaH5nQcvgzvbVnIMO6SYlM/Y0ZLzMRfdoYRp1cnd/mnGY0S
         oGDMqq1kgjAthy6UYcp+fzYUQS2gzVcVCYbQMM3eZi38GEg95jopHpBjYKvE1lOItA3h
         VrUw==
X-Gm-Message-State: APjAAAU1ZK0BVN82X3o+jD1ZCP082pCoyZgqTk9eiRN8YJ7T2TJcUU8S
        6T9zzyHnT17vjndq4voANOY=
X-Google-Smtp-Source: APXvYqzmQLtqtYywZioGiUcaIwSMLMNOrMMcyq48VNb2gTooHR+RghLWiW32nmaFQGBN3NvDc+DJ6Q==
X-Received: by 2002:a25:7701:: with SMTP id s1mr6210156ybc.286.1570296625972;
        Sat, 05 Oct 2019 10:30:25 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id 12sm2546780ywu.59.2019.10.05.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 10:30:25 -0700 (PDT)
Date:   Sat, 5 Oct 2019 13:30:04 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Colin King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32: clean up indentation issue
Message-ID: <20191005173004.GA7431@icarus>
References: <20190925095126.20219-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925095126.20219-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 25, 2019 at 10:51:26AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an if statement that is indented one level too deeply,
> remove the extraneous tabs.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 644ba18a72ad..613dcccf79e1 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -219,8 +219,8 @@ static ssize_t stm32_count_enable_write(struct counter_device *counter,
>  
>  	if (enable) {
>  		regmap_read(priv->regmap, TIM_CR1, &cr1);
> -			if (!(cr1 & TIM_CR1_CEN))
> -				clk_enable(priv->clk);
> +		if (!(cr1 & TIM_CR1_CEN))
> +			clk_enable(priv->clk);
>  
>  		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
>  				   TIM_CR1_CEN);
> -- 
> 2.20.1

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Fabrice,

I noticed the TIM_CR1_CEN check is happening before the
regmap_update_bits call for the enable path, while the disable path does
the check after. Is this logic is correct.

William Breathitt Gray
