Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCAF44F91B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 17:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhKNQoD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 11:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhKNQn6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 11:43:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F50C061746;
        Sun, 14 Nov 2021 08:41:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b15so60493271edd.7;
        Sun, 14 Nov 2021 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyZJLsZ5/TWd3NStdktYvMZTubMFBn2FLa8gh1z/nug=;
        b=hkj6kHSlpMVk4CZY6LNpv0TzFaBQfQIs/VqaUM5Ewn24WCHXwS2GlG93QEhpopV/Fm
         YPJ/tKc6leIdHVIVBbJHMuHdDrBXYirqXNfVgDKWMEcrA55CJ+1dEbO/haWpzyaZrWHk
         vovPCl6lFCW5zGi34bg5Ax+Dgxt5IUF65zC12OL4t93LTeGaQP7+uiOv4SL1haj1BB1Y
         CY+q5aKjeYg5sm0aBv9tcgYzm2sY8KcZD7X/XZPY3F99tO7jyx6SNV8pfau5Pykxt4Ed
         UusBMpevcXSjIDCiLU/vcSDteEIhfvBCoeDD/8OCJxw96/7NIeud1kLgq2yi5LgyTAcf
         kfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyZJLsZ5/TWd3NStdktYvMZTubMFBn2FLa8gh1z/nug=;
        b=kMxl4vdv2V9QldOuOw3MVLgXh92d0MG9EIjk0+gRd6cGDbwIftzTgkcrIz1iDYGkVn
         HJkpCEvcCuqxWovJdxdtc2OcM67qq7rOC3jKWyixbUTwthH8uIocGZBIUp8qC870fPmA
         OpkmliWH8E4ebAV/eCN3NE3Me4ZDR0mAq6MvHIwpKka2GfWaOK6JKrleyzH8pLITLTvh
         bEBHmXaAtXHcwinCpes3ikWmiRQ1miurX0zORnR2qzm1YMF7p2kPy1h48+bT8sz+LR3d
         RcF2Jy8Xo11WPMPrzZOo+CleGsU2U4RODgIWWZLa684/0km9fWT8gDRyKk9WIyoEVnIl
         COsA==
X-Gm-Message-State: AOAM532W64ukMKSxCxfbZ06CjbRIeL35boSEauIZmfflDhOROLGkXz9z
        nQ7PxVGEJv4iAq6XAT5k30u69tb2y57wlNYkI7TwlFl+YdM=
X-Google-Smtp-Source: ABdhPJwGAGuQp+5WefeXVaLtnzBsjZjeKyjIyHYFgoSq4xVQYwGNzr6C+rHDRJJ4IhThlzecrRX0UOSiD+DIVaov/8w=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr15958820ejb.69.1636908061637;
 Sun, 14 Nov 2021 08:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20211114163444.21669-1-rdunlap@infradead.org>
In-Reply-To: <20211114163444.21669-1-rdunlap@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Nov 2021 18:40:25 +0200
Message-ID: <CAHp75Veeppry=SHk0NUxpHVKbefCgRqDvi+PFJCiCABDSYg-HQ@mail.gmail.com>
Subject: Re: [PATCH v3] mips: bcm63xx: add support for clk_get_parent()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 14, 2021 at 6:34 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> BCM63XX selects HAVE_LEGACY_CLK but does not provide/support
> clk_get_parent(), so add a simple implementation of that
> function so that callers of it will build without errors.
>
> Fixes these build errors:
>
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
> ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
> ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'

Some nit-picks below.
Otherwise looks good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Suggested-by?

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Artur Rojek <contact@artur-rojek.eu>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> v1 and v2 were:
> [PATCH] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors

> Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")

Not sure why it's here. What does (the location of) this tag mean?

>  arch/mips/bcm63xx/clk.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> --- linux-next-20211112.orig/arch/mips/bcm63xx/clk.c
> +++ linux-next-20211112/arch/mips/bcm63xx/clk.c
> @@ -381,6 +381,13 @@ void clk_disable(struct clk *clk)
>
>  EXPORT_SYMBOL(clk_disable);
>
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +       return NULL;
> +}

> +

Perhaps it's not needed even if the rest have it (I mean blank line).

> +EXPORT_SYMBOL(clk_get_parent);
> +
>  unsigned long clk_get_rate(struct clk *clk)
>  {
>         if (!clk)

-- 
With Best Regards,
Andy Shevchenko
