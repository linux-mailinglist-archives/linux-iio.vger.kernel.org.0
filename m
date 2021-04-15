Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316BF360EAD
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhDOPUX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbhDOPTv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:19:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDDDC06136E;
        Thu, 15 Apr 2021 08:16:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d8so12230584plh.11;
        Thu, 15 Apr 2021 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lr7yrzY+nk0m4HxiHE2dv7ykdCcOOQqJTWXcZt1WofE=;
        b=BynvbTh7cWAIV3l1bLcy9XsS6kzSwDQgySlTMzPvNADW3hjmi2PUh5Jo+DzlnOxI5c
         8NAgCaR1/2CToDoUS3yA1ELLe7zWL1kRv2O0zalghfKH3bF7961SM1dNDjQNY7gjrD9W
         aXNopHC1Txedyjc/sZs7/l9hEJhSiVQ50M3rEelZsBehJvYguAoBh7z72A53ZcMJdSpM
         sbmOP+0PCAANJHOi1r59OVINKtNHetDIx9Xyjayit1TLikg2+78xQ5VN8kIDhAFYzu/e
         ggBjknvH0QKrnvgr0D3+neQO88fqPjL/6iILuHtKK0REfJ4uWQio/Y2ABimrLmOTAFxn
         6VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lr7yrzY+nk0m4HxiHE2dv7ykdCcOOQqJTWXcZt1WofE=;
        b=pt1vtwfkRvi0qNgY3hh/Oc2SbZvqu/H9pT5qFduk2TutXI5/gXdaGpFyNdNN4GiCfW
         YY94AJrQrCMuwN7tgtP4PY549vKp+F6VDW0lIqy2zu43zU9F8mZho7nJAlEYtb7lkWpm
         9cIkLYfP2+EIqUDNLTDkbg1cY/I54xT2hAFZgt5FXWv8J5RojGG8mNH7ZU81Fwk/uk1S
         Qp85WnMNS9bNTx+GMOgC8fNFz5FhgjKHq5KJ8uFUbR/hrkRfoHBZlbFsg8soquCzXf3p
         FvAVonOaCUC6GwLLB+11LPUKsa0MJA0dCcc/vpZX8eBO849k8pH8vj+eVyhPafquJ9No
         hgHQ==
X-Gm-Message-State: AOAM5331Jz339vRjtJP2LV+aZouEAQCWu2NOBOxDkOI8RfiK1gg/wYbd
        Z6ua3/3SLKIyJt9OxDLI3Wo=
X-Google-Smtp-Source: ABdhPJyJJppaqi4uKuIVw8D2RITj+pIvSst8bI5s51uwBYjYsXVSsz9lqzc37KC4puLzydWbhV9Ktg==
X-Received: by 2002:a17:90a:ba09:: with SMTP id s9mr4429648pjr.133.1618499799099;
        Thu, 15 Apr 2021 08:16:39 -0700 (PDT)
Received: from syed ([2401:4900:2eec:4193:f802:b600:e94c:55c4])
        by smtp.gmail.com with ESMTPSA id c21sm2730490pgl.71.2021.04.15.08.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:16:38 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:46:29 +0530
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
Subject: Re: [PATCH v10 06/33] counter: 104-quad-8: Add const qualifiers for
 quad8_preset_register_set
Message-ID: <20210415151629.GD8933@syed>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <4a227eea6fa6aa1648fb0ccba6e924b6f95b2752.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a227eea6fa6aa1648fb0ccba6e924b6f95b2752.1616150619.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 08:00:25PM +0900, William Breathitt Gray wrote:
> Add some safety by qualifying the quad8_preset_register_set() function
> parameters as const.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 0fd61cc82d30..51fba8cf9c2a 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -632,8 +632,8 @@ static ssize_t quad8_count_preset_read(struct counter_device *counter,
>  	return sprintf(buf, "%u\n", priv->preset[count->id]);
>  }
>  
> -static void quad8_preset_register_set(struct quad8 *priv, int id,
> -				      unsigned int preset)
> +static void quad8_preset_register_set(struct quad8 *const priv, const int id,
> +				      const unsigned int preset)
>  {
>  	const unsigned int base_offset = priv->base + 2 * id;
>  	int i;
> -- 
> 2.30.2
>

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
