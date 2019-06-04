Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6034BAB
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2019 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfFDPLg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jun 2019 11:11:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42564 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfFDPLg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2019 11:11:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so8457642plb.9;
        Tue, 04 Jun 2019 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jDLUJPykC5/Y1mNCCU1kADVW3AUxBzLw3C7Ot4NO/8Q=;
        b=MUfYX4GItKkRpkJ42mRt71QxBcAaWcnQJDgiNK/S38Vzuk1umd7Q3fm6lAuUd4VWrl
         lqGi7lV5C25v2FcO9xhoxARBBEKME5XDjGKW2WljEp5btv3tMJ5SSUV7UPF7BHboJlGy
         /g1d//6fAy/cS88Eqy5amrYF/acmEl+Ic6ATRa09kaAtQ4GjytRjPqkZsh7rhdJYtttf
         ywJMILfOPSYwl1y8MIs+XmDXOQR3KxsuV3nTYvl2qSTjhlmGKn9H3giw0DsrY9oAytQe
         R9cLbCgJ+8h+5+ZnWzr3rNzatR7Qg7neyerzGvTfRsFKOghGYcCafw2d6u66HB+7+jgw
         rNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDLUJPykC5/Y1mNCCU1kADVW3AUxBzLw3C7Ot4NO/8Q=;
        b=ZgHaj8S7crniyQHmJtMnz6WTNZQdNi9vDUjCl9tLOsl1kddormahf93X5VAzgDitNq
         RDzpP26DMvU/hJkUC8r20J9o7bDhDEBWx72vTrRpMj/z0riORYQmVY85rSF0Oo8b7XXF
         k03/KCRqP3pVmCnOzLFgeeZ+Nb4QTQeRr9Qq3mPo7Ru75P9PZ+ovSWnHTuQfRPdmuqtY
         wyhVnZqBK7BCMcHZgJvPlj+BDNhR1mMZ444xmJxLzsJLSPADPCz7YFs1jv7dIHTlNecm
         cHvOUIdTO0Kfi2sFui0D+ZtWt8xf3DB5U6jX58UhyTfme552vA+eq0Ftz5Q3mzLc6QQ+
         Yhpw==
X-Gm-Message-State: APjAAAVCXbQEpF4GuAVd+7K3i93+qoIzeQaXEySgOy3lW8A+oDeZHfls
        6DvR8a3Gh5FK+tWyGoLt/VM=
X-Google-Smtp-Source: APXvYqzrVlMOw4ymbe2FZBKLaK7Rxa6KBNW6v9wcab/jwPl92urYS5Lx6wquBTKoFq+2/IclK9PdrQ==
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr34427172plt.92.1559661095252;
        Tue, 04 Jun 2019 08:11:35 -0700 (PDT)
Received: from icarus ([2001:268:c0e2:41af:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id d3sm13939380pfa.176.2019.06.04.08.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 08:11:34 -0700 (PDT)
Date:   Wed, 5 Jun 2019 00:11:15 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] counter/ftm-quaddec: Add missing dependencies in
 Kconfig
Message-ID: <20190604151034.GA12804@icarus>
References: <20190604140326.12295-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604140326.12295-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 04, 2019 at 04:03:26PM +0200, Patrick Havelange wrote:
> This driver uses devm_ioremap and of* functions. This fixes a
> linking failure with e.g. ARCH=um.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
>  drivers/counter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 233ac305d878..c9e3f5c98484 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -50,6 +50,7 @@ config STM32_LPTIMER_CNT
>  
>  config FTM_QUADDEC
>  	tristate "Flex Timer Module Quadrature decoder driver"
> +	depends on HAS_IOMEM && OF
>  	help
>  	  Select this option to enable the Flex Timer Quadrature decoder
>  	  driver.
> -- 
> 2.19.1

Fixes: a3b9a99 ("counter: add FlexTimer Module Quadrature decoder counter driver")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Jonathan, would you pick this up through IIO?

Patrick, I noticed the FlexTimer Module Quadrature decoder driver is
missing an entry in MAINTAINERS. Please submit an additional patch to
address that as well so that we'll have a point of contact listed for
this driver.

Thanks,

William Breathit Gray
