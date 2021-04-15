Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FB7360E7E
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhDOPQK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbhDOPO5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:14:57 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C2C06138E;
        Thu, 15 Apr 2021 08:13:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g35so17083082pgg.9;
        Thu, 15 Apr 2021 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i0SWPsbZMrd0nebi+GVIlyiAWrh4CzfKyh+F53eCiJI=;
        b=g3thAUPNolya2yaKXB5KwLtyiplCBRPd1lMgSEU3Gl6ZxCnKYJBgaaqnI7wlZkPPe+
         yKzXoBMZOx6M3RHjZHKdlRMDZHQ4qTtR58jloRXCd3cVfZ/bE2v9KEBYHKOSMHUqBaTN
         859bdOg6morVtwz8+5qEion050CRwOLw11Zoe37RBBJMH+/DfxhiBYIF9OGctrZ07sP5
         8tPRnhWGhxo/DxsQzOUSCyEOFvJYs6Uvb3xP05KjeAuHfTyB0yKsKml22hZmDS3kv0Tt
         nYi14mLivu+Cy+i3mj/ZRE7PbC9q145kAdC5qhpTvM4Ndpzt52CULPUiAAMMSWo5oD2F
         M2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i0SWPsbZMrd0nebi+GVIlyiAWrh4CzfKyh+F53eCiJI=;
        b=XwZ0FEe+AOmWrb7AbwF51qH6rDBLTlYGVAlEAmxzgEc7MgwW2WWtXyDZtiMMefjdrm
         +smrmo3e3wrmSezlUgnURqdHByn+1ceKf1sbV1USPrF2Pj+dqzT11v5KmVg/jZI19pu0
         eO2Oz3dU3VkIkJ2wCje/yFHL2ePwjaHvgugq0cUil0HhH1zi3Dn1eStA+d5YEkVszr5J
         khvRKZupSZKj9i/VOuYhm4OjmPwr0S3Bhe96id/1wO07gpR+Oycz+vk5Uea8V+J6iEII
         EpWqMt+Qc2j859gameWA6APgCpYzrxGNKhWNQcVpFJsBW9CqAg2SOxIusvbS2E/54Mz0
         Y1kQ==
X-Gm-Message-State: AOAM532twWxN8hgMHD+hYjbETzB2jFsThDaGwkzwKR3DoXuknxiZWD+s
        D9gg9qPzmp/jrd5m2q59bD4=
X-Google-Smtp-Source: ABdhPJxYmcljVlbKmo68b2xJsy8My7DGt4PPefNRj1OC73eYNiNx+X83zT/1SrQUwzZfZcCRMywKUQ==
X-Received: by 2002:a63:df56:: with SMTP id h22mr3959816pgj.84.1618499638122;
        Thu, 15 Apr 2021 08:13:58 -0700 (PDT)
Received: from syed ([2401:4900:2eec:4193:f802:b600:e94c:55c4])
        by smtp.gmail.com with ESMTPSA id 186sm2476361pfe.212.2021.04.15.08.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:13:57 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:43:35 +0530
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
Subject: Re: [PATCH v10 03/33] counter: 104-quad-8: Remove pointless comment
Message-ID: <20210415151335.GA8933@syed>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <e53df4416573f16069090f4c660afbd8d501f2a0.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e53df4416573f16069090f4c660afbd8d501f2a0.1616150619.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 08:00:22PM +0900, William Breathitt Gray wrote:
> It is obvious that devm_counter_register() is used to register a Counter
> device, so a comment stating such is pointless here.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 9691f8612be8..4bb9abffae48 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -1082,7 +1082,6 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  	/* Enable all counters */
>  	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
>  
> -	/* Register Counter device */
>  	return devm_counter_register(dev, &priv->counter);
>  }
>  
> -- 
> 2.30.2
>

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
