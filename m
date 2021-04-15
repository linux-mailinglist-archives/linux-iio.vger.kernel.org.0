Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ECC360EAE
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhDOPUX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbhDOPTw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:19:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB700C061761;
        Thu, 15 Apr 2021 08:17:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id p12so17119576pgj.10;
        Thu, 15 Apr 2021 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pqvughkl2U3sNrUOp5/BQIl3EtqX5v4D36UESHq6XxI=;
        b=ZLeuNCpgMvYWfWuOgwjPr7Cf8KUdN8cCNqyp8fB9UBdYrNF1jNFznBPjf9rwzf9nFR
         5PHeeeIQcc5HvY+Vk6QrJ9EvQxde5PB11U2mx04I+k/YRDzBvMTxSa58wdDPLu2Xl+on
         JkCuglzKGBqBWJ7PWbHJT8QJOJh9P/keTBljuIhfnt4hx/yS89xYQCrD9syl0PoTnHzY
         Y38tgKsb27a9hMQanI5OBr+XwcC2x731Tl3bqSkmkpFaKgQ48pxsT+m+fmniv6RPh4Gs
         dnByGC7B4yKMbGCF8y6a7im8SmFShLkObEAdpIAkFdoJ5qITRJVq5rFXus6J9wCrztEG
         6G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pqvughkl2U3sNrUOp5/BQIl3EtqX5v4D36UESHq6XxI=;
        b=SPeLnBXWlCAHDuJjQ2X9yFofQpaK1fZAyxcZ1R0781cSWwBt5N7Q8Ce8yLWTmCXGS8
         i8w6q9fIzY5pbMtSz0xg71rgwbq/sc6OD9HCsBgLgEoAN35WyA4cgUs21+TPurIe2RwX
         nzjEs6NUif1aln5Hg13k3o+PF7lexLWRNG6yFdm27cnpl880enAFKapM4IX9sFsYANYl
         gxDFHApOFrfmjNaq4+MU3p+VIoPurw/i5KSn26sVeB8h/D6cdakINQHm6877Z/jvsswt
         0qgx2Fc+SakLCDIyOCJe/0Rradv4Knq1mq+Kip2x51cS8Tkrn0K8Rl0H2L11+NTlJ9c1
         g4SA==
X-Gm-Message-State: AOAM533l6SBcjek0aHH/ulwbqIgYlVXpWFxichaXHshFwWtDIR/ASqon
        713R3QUffAJNUD8lbWGtMWU=
X-Google-Smtp-Source: ABdhPJw9RfWCve4tuPvWcxnZszPpQBIDcBfoCjS8aUF0YN1sMeYniNrvO8KBuCLifuBM6oW3x3WSKw==
X-Received: by 2002:aa7:9316:0:b029:244:7616:edc7 with SMTP id 22-20020aa793160000b02902447616edc7mr3676280pfj.19.1618499847345;
        Thu, 15 Apr 2021 08:17:27 -0700 (PDT)
Received: from syed ([2401:4900:2eec:4193:f802:b600:e94c:55c4])
        by smtp.gmail.com with ESMTPSA id k3sm2569617pfh.12.2021.04.15.08.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:17:27 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:47:16 +0530
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
Subject: Re: [PATCH v10 07/33] counter: 104-quad-8: Add const qualifier for
 functions_list array
Message-ID: <20210415151716.GE8933@syed>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <c3d989972172945bbc616c973c1a759df5fa3d19.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d989972172945bbc616c973c1a759df5fa3d19.1616150619.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 08:00:26PM +0900, William Breathitt Gray wrote:
> The struct counter_count functions_list member expects a const enum
> counter_count_function array. This patch adds the const qualifier to the
> quad8_count_functions_list to match functions_list.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 51fba8cf9c2a..ae89ad7a91c6 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -193,7 +193,7 @@ enum quad8_count_function {
>  	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
>  };
>  
> -static enum counter_count_function quad8_count_functions_list[] = {
> +static const enum counter_count_function quad8_count_functions_list[] = {
>  	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
>  	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
>  	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> -- 
> 2.30.2
>

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
