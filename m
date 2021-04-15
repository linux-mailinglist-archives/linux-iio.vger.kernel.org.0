Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2179360E9A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhDOPQl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbhDOPQE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:16:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784BC061756;
        Thu, 15 Apr 2021 08:15:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so14575570pji.5;
        Thu, 15 Apr 2021 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RuiLtWNxMd40+FIGD3C4gu6eExR7oO+TwAUL1WIQWJQ=;
        b=CMPu8NaC9ExpNZ0knaznfSJByoJpBOrJtdzfENSlzZRfqG3kbCaBVUqgdk2SACGwjg
         CCdcwj+XP2KaHnzx0XfSo4BnkYfN7mToSyu/4dqrMmYbp8GJ6q+WX9lPIDfOqFP1EVIW
         bPHSizmQGrP2TFSBW/+95v40fFxCWys8tzhdBfI/Ajp4MgUWEw+Tx722u4UfaviA/s2H
         Amj7/5nfJhhsn9Lq7n9zSnbYwTI5Vr9DCBT3uVTLljjez5t6bhudDSJa/7AMbK645+iE
         +Ug9EVzEYqFX+mSFlYf+ov5w2YIBMSyroseGomvZtWGs/OwYL3UrPaAJ1O0BnwJa42PF
         hkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RuiLtWNxMd40+FIGD3C4gu6eExR7oO+TwAUL1WIQWJQ=;
        b=RrOrlPgzuksKG1Oeagm4sEEVkYLELFcTK99w6I55q1Wda94092pp/IBl7JXOAUNFus
         NdJEiOVclU+Exc2B3MsVJMLLzTQPHpR6TDnLzZPuMmT5YlqIizbm6xjKfZg16jcEob7+
         tL/KRYDylGkKKJkhUKty+wBh56XE+V28y+NfGz7QYkFX+Qd7ZHTgyqtfqUVP1eMwWTUD
         47NrRRH1h8tYsq/pvXWFHBV2hkRMxpDoSh0Hh2+8LaX+Sf5DC4e3b2mifu4T1ov2lvpH
         w2NgimeC4Vv0bD+GVqTxVi8lfl1RM2mkcuGHW6DVPPAkXjWuGWE23Ekuf1N2ufOrpZ+O
         sq0w==
X-Gm-Message-State: AOAM531z77HyKjhBRja+Fk879Tz71AHVosJA7YGvVT4FYNdpynNF1/8m
        eeCMWr5EM0VbdkrM3nEB7w4TtUvObpw=
X-Google-Smtp-Source: ABdhPJwNs29RBYXQcWurs9YVnGIS/ETzTjJ4BFbp9aGhG6Ko7ult4MqFLvrwpLHUmzefnsw1es3yZA==
X-Received: by 2002:a17:902:a515:b029:eb:2723:3fde with SMTP id s21-20020a170902a515b02900eb27233fdemr4416016plq.56.1618499739213;
        Thu, 15 Apr 2021 08:15:39 -0700 (PDT)
Received: from syed ([2401:4900:2eec:4193:f802:b600:e94c:55c4])
        by smtp.gmail.com with ESMTPSA id m7sm2711418pjc.54.2021.04.15.08.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:15:38 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:45:28 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
Subject: Re: [PATCH v10 05/33] counter: 104-quad-8: Annotate hardware config
 module parameter
Message-ID: <20210415151528.GC8933@syed>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <203f1b6084ed86a6696eb422bcadc0955c6427bb.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203f1b6084ed86a6696eb422bcadc0955c6427bb.1616150619.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 08:00:24PM +0900, William Breathitt Gray wrote:
> When the kernel is running in secure boot mode, we lock down the kernel to
> prevent userspace from modifying the running kernel image.  Whilst this
> includes prohibiting access to things like /dev/mem, it must also prevent
> access by means of configuring driver modules in such a way as to cause a
> device to access or modify the kernel image.
> 
> To this end, annotate module_param* statements that refer to hardware
> configuration and indicate for future reference what type of parameter they
> specify.  The parameter parser in the core sees this information and can
> skip such parameters with an error message if the kernel is locked down.
> The module initialisation then runs as normal, but just sees whatever the
> default values for those parameters is.
> 
> Note that we do still need to do the module initialisation because some
> drivers have viable defaults set in case parameters aren't specified and
> some drivers support automatic configuration (e.g. PNP or PCI) in addition
> to manually coded parameters.
> 
> This patch annotates the 104-QUAD-8 driver.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 233a3acc1377..0fd61cc82d30 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -21,7 +21,7 @@
>  
>  static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
>  static unsigned int num_quad8;
> -module_param_array(base, uint, &num_quad8, 0);
> +module_param_hw_array(base, uint, ioport, &num_quad8, 0);
>  MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>  
>  #define QUAD8_NUM_COUNTERS 8
> -- 
> 2.30.2
>

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
