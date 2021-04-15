Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E39360ECA
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhDOPVO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhDOPUo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:20:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13230C061346;
        Thu, 15 Apr 2021 08:18:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so14605672pjh.1;
        Thu, 15 Apr 2021 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SELYhFsoJ14huwJ/81lZrO7K/RlYVZsAtlNmnDERCiA=;
        b=ZI671EdEu1bon8uIgOvGwowDhQ13B2JIDEO/kD8JYyATC14G92a5kP5sHVv6wbZwDx
         0PfOrtoNeOE/QaNnyI1Of4OO3RVD7Jr2vhsTh9WZojTIsVfBaTsATTm0aFM2U00Qc5A+
         R1LR1t7izz1GC7ra79nP7uC/trxTlWYJtUkAZ4zkvnhYOAbvGWKqoePvIW0ZRneXIyX2
         ZVK5itundPzYMqHM91lhdISmGXf2tw3t+y6W0kh45ch8euiECEIN3brid1AQp9Y4YHLu
         Gxk5sbNimGuXXtx07i8eFBt+aT4clvmHpgcxF+lZjd21Ls5r28WTb+pVL58QsiedF/pu
         WdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SELYhFsoJ14huwJ/81lZrO7K/RlYVZsAtlNmnDERCiA=;
        b=hdvcsx9zGAteKRJeyXrzK8Ew2WibpLYbOoJ7ANuI81WJZ5s0E/UZMJVBHR9j0btgs5
         NHPp8561vJhO4i087zB9q/+DvBY5kpJ7o18l6ZHmK9rj331YiLLCFu+afMSAzTA31dJz
         Lm2CbIHkYtLCFTuffnXjRvq0+jp6717ioNFKQB+8qlsCGMwoS9ZEngKgAuduGT0Q+GMs
         5c7I65WJ5ODfyrU1IlEkBdgqfnNPzSN0JyqY5ZQAhj3NOuqGvSP0+n2SKL/9EkW1z5Df
         ym3q7VOC+Zi0GJehFhJMc7COKAPn+li89X5U8Grn2kupICzyalLYo0n5AX1yc4LQmXcd
         EAPw==
X-Gm-Message-State: AOAM5301HbOXg61UFxZEs+046uSkM4/vhF6yHmm6QeblE/7gCmw2MhcP
        iyAwxBBKuBxCCVavbAkdnwM=
X-Google-Smtp-Source: ABdhPJwDaxWbyUYsT+6Y0TgJvYm+wGJXs4Tq4yCoVzPQ2K3KmNAugBIF77jk66vaujtfhsW8k4s80Q==
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr4525666pjb.205.1618499906610;
        Thu, 15 Apr 2021 08:18:26 -0700 (PDT)
Received: from syed ([2401:4900:2eec:4193:f802:b600:e94c:55c4])
        by smtp.gmail.com with ESMTPSA id f18sm606961pfk.144.2021.04.15.08.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:18:26 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:48:13 +0530
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
Subject: Re: [PATCH v10 12/33] counter: 104-quad-8: Add const qualifier for
 actions_list array
Message-ID: <20210415151813.GF8933@syed>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <92caedb694b4c66d9a5e9190f8c4545ae28dd418.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92caedb694b4c66d9a5e9190f8c4545ae28dd418.1616150619.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 08:00:31PM +0900, William Breathitt Gray wrote:
> The struct counter_synapse actions_list member expects a const enum
> counter_synapse_action array. This patch adds the const qualifier to the
> quad8_index_actions_list and quad8_synapse_actions_list to match
> actions_list.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index ae89ad7a91c6..09d779544969 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -305,12 +305,12 @@ enum quad8_synapse_action {
>  	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
>  };
>  
> -static enum counter_synapse_action quad8_index_actions_list[] = {
> +static const enum counter_synapse_action quad8_index_actions_list[] = {
>  	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
>  	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE
>  };
>  
> -static enum counter_synapse_action quad8_synapse_actions_list[] = {
> +static const enum counter_synapse_action quad8_synapse_actions_list[] = {
>  	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
>  	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> -- 
> 2.30.2
>

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
