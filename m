Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E54EBE939
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 01:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbfIYXvQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Sep 2019 19:51:16 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39321 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfIYXvQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2019 19:51:16 -0400
Received: by mail-yb1-f195.google.com with SMTP id u15so240551ybm.6;
        Wed, 25 Sep 2019 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HftsytVFMDTMjOvjkbAMtOhlArps9/JX9Jjmc9dLKZQ=;
        b=aRlz1iQuE+DjKNGAM7trfsPQap93p8t0nJittzSw4bImFRHDIPK/liL5FFSH4YeMQj
         vHILMM2idG5jniZtDrdJwOeYc4fXDlsUIgOHIuZYBnDVLGMnjFG9Pco+v30nyJhbfKXV
         7UOwOhQA1di5+a5aHFLllQDKIw6Cy0cXW74hEhU0exHySTBzlIAk6QYTZkvemxUGz1RQ
         Mzz9+EhJRX1UeSC3i+UowJKRdzfw1p17ibcL+AVmaGOQxtTYr1DKbZTW2QnKw/vftMbJ
         894qarwDx0379RAILnV8XbCaHnNDLhMrRgvD92UEixSTyZtACQJ6Tz+SShy5oAOx9a8F
         AqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HftsytVFMDTMjOvjkbAMtOhlArps9/JX9Jjmc9dLKZQ=;
        b=Uclvb5RuOMIyv3Z/ONoLz5/mXmy8Fm3rad0N375I+A0LQdzAy43oZl/SDIJ4F7y8YH
         mIfZVY1X2B4L89EI2U/g4/k6DhH79SMfi6SmLDDea2u/YX47qJMXbjQ2Ct3r1VeyS2dO
         8zXD5dHosivtXxMhO2DfyXi4P73iRwRSA/oTfUpkD9fayYflzdjjNqu7mtRKT6QDVDXx
         nfPEO0VoXeE1rsGrzaa/fH+hD51btnv+7FUfMaLbRicXumS/SnPW39a/Ea9crlDrxsDW
         8XZQOkxq9PgPVmunyCJt2fIv7DXcBQDL75b4AFkuzpoY/TAe12jWWhTPKwuKTG7FrkcO
         gbNQ==
X-Gm-Message-State: APjAAAUGaHynGxDF0pJP6S+pJ+6+00dz2I0y10HhlJbN3FSG5A+iVh6w
        KYKymLuqztIpY5IBTkvUDlA=
X-Google-Smtp-Source: APXvYqypcMHL6DNYe5cgfBsTpZAtPJ4UmiYZB77bn3AlK9hPiQ22hhfSjd8Qceo0JYVvlFvvpD/+6A==
X-Received: by 2002:a25:a246:: with SMTP id b64mr174608ybi.187.1569455475601;
        Wed, 25 Sep 2019 16:51:15 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id p204sm58674ywp.110.2019.09.25.16.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:51:14 -0700 (PDT)
Date:   Wed, 25 Sep 2019 19:51:12 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        jic23@jic23.retrosnub.co.uk
Cc:     jic23@kernel.org, alexandre.torgue@st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-lptimer-cnt: fix a kernel-doc warning
Message-ID: <20190925235112.GC14133@icarus>
References: <1568809361-26157-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1568809361-26157-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 18, 2019 at 02:22:41PM +0200, Fabrice Gasnier wrote:
> Fix the following warnings when documentation is built:
> drivers/counter/stm32-lptimer-cnt.c:354: warning: cannot understand
> function prototype: 'enum stm32_lptim_cnt_function'
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index bbc930a..28b6364 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -347,7 +347,7 @@ static const struct iio_chan_spec stm32_lptim_cnt_channels = {
>  };
>  
>  /**
> - * stm32_lptim_cnt_function - enumerates stm32 LPTimer counter & encoder modes
> + * enum stm32_lptim_cnt_function - enumerates LPTimer counter & encoder modes
>   * @STM32_LPTIM_COUNTER_INCREASE: up count on IN1 rising, falling or both edges
>   * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 quadrature)
>   */
> -- 
> 2.7.4

Fixes: 597f55e3f36c ("counter: stm32-lptimer: add counter device")

Jonathan, please pick this fix up through IIO.

Thanks,

William Breathitt Gray
