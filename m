Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655C8360E81
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhDOPQQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbhDOPPH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:15:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FD0C06175F;
        Thu, 15 Apr 2021 08:14:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c17so16264955pfn.6;
        Thu, 15 Apr 2021 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ax39KJeRsWzONrhn+72TkNapDpAhRxhVHYcwUNfI7/8=;
        b=dZXTlmwxnwELuSG5gVg7O/1XlkljIXnmaZxoSsrmXYAif0qd0cS2nLBV31LseGwAww
         08AZo0PIV9odOFgEtGAoQWBGVis/cpRaldCoMSgWx0i8u3k4eVdGECk2soddkRtwXr8W
         goG25yIsWtbaRs4263s3TAzPuDz4xEVthaSwE0PSnmyj2wnXsT4D3uqzUe74laAsfCR3
         MQSfG5xqP9CGq5I/QyeX62oZhM24rciIbTqtir2WC5A6knnDxSt7RtEd+shZndTNr08p
         mpUHl+Wi+PbhhT5515odVLZx/3VzDUQWi+fZApvrNtlCzuIaZIE/IU4atSpxhtB0XLJd
         qUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ax39KJeRsWzONrhn+72TkNapDpAhRxhVHYcwUNfI7/8=;
        b=q2nMUCLyJBQExynUQRijrLm1g37hFO02WL6hfGqJLZSPcZszJtEM9aTupnQ0Ns9Vqd
         BsUcI82fIjvWWNJWh6bC5J2hgqlFsRhme0c/87qXZG45X+JDiWrTjsEf1PM59Y5TglDV
         ISmAWTyjDJxwyGEc6omDbfEhr9mOcu5QRfyu4867shjHQ6DNtkXmWEaEAii7crFvM1/0
         8PpcMsJVnPlcG1jZ0IagxRuJ+R6W130Z8gjuYpmbg4sJ2MemAFWx1Zk8hp/MYuz1pTTX
         kt1lQJBA/rdR0otTF18yWRj9kSJtJym3FDmUR3N081cliMisE/AmjmmqvnvInHyRtjpB
         twRg==
X-Gm-Message-State: AOAM531+UyY0gQ3zv2FwZB4CJZSwntrsg972xzEzduEwNlo+6jBzDkcD
        LhavriAsKfH9tfNHbcnAzgJ6ElxyqeA=
X-Google-Smtp-Source: ABdhPJy7h45A/JGY8V4v3PNXukYZA8GUaHq8q5XZTPvNARGrwJyJ1oIa8vavVXfsZ1NSqZbWbAyD3Q==
X-Received: by 2002:aa7:864d:0:b029:24b:dd03:edec with SMTP id a13-20020aa7864d0000b029024bdd03edecmr3764464pfo.18.1618499683934;
        Thu, 15 Apr 2021 08:14:43 -0700 (PDT)
Received: from syed ([2401:4900:2eec:4193:f802:b600:e94c:55c4])
        by smtp.gmail.com with ESMTPSA id u5sm684396pfn.155.2021.04.15.08.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:14:42 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:44:31 +0530
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
Subject: Re: [PATCH v10 04/33] counter: 104-quad-8: Return error when invalid
 mode during ceiling_write
Message-ID: <20210415151431.GB8933@syed>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <98676f9a2e9cf991d7a002b3b264cca774e5b3c8.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98676f9a2e9cf991d7a002b3b264cca774e5b3c8.1616150619.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 08:00:23PM +0900, William Breathitt Gray wrote:
> The 104-QUAD-8 only has two count modes where a ceiling value makes
> sense: Range Limit and Modulo-N. Outside of these two modes, setting a
> ceiling value is an invalid operation -- so let's report it as such by
> returning -EINVAL.
> 
> Fixes: fc069262261c ("counter: 104-quad-8: Add lock guards - generic interface")
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 4bb9abffae48..233a3acc1377 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -714,13 +714,14 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
>  	switch (priv->count_mode[count->id]) {
>  	case 1:
>  	case 3:
> +		mutex_unlock(&priv->lock);
>  		quad8_preset_register_set(priv, count->id, ceiling);
> -		break;
> +		return len;
>  	}
>  
>  	mutex_unlock(&priv->lock);
>  
> -	return len;
> +	return -EINVAL;
>  }
>  
>  static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
> -- 
> 2.30.2
>

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
