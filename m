Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DD228852
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGUSfG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUSfF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:35:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB023C061794
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:35:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s189so12321996pgc.13
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJ/q59E0YTcw7SgEB8izgcQwhk8BEcW2mZ+xSbmf7TY=;
        b=ia5L2vzmMRud9uwejTx+j2URLJJZjBnhraGW/zFxSxVW5UjKXDT7wUHEYFHUUiTVZs
         geFawdWte2u9jWSoZd6pdlYn98uw5BxovVMB8PBJfFyYc5UgZb1HdcCnRdpsfmRiLsjD
         Q2JXyb/nRK2owIcrhm8UW540q76SKDXMIYjMkOKTZAI0pf7kHP11OWyjLvTkiA6aRRdb
         r4Yjtbt8q1lEdOU7OK3OpknjNV2ocX08ZQM1VMDZJYt/Y2G4wKYAZoxjSOSAYXfBoRJb
         TzKglLIEnvOyFnSNoMS4R0/DJ0DPjAaT3mX4BlVtBPnw2BOvhs/WOnqaQ/fCQM9XH4h2
         vi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJ/q59E0YTcw7SgEB8izgcQwhk8BEcW2mZ+xSbmf7TY=;
        b=Qe4Q5VcHO7fxKYg0Q37oalBBPGE+jjPQcc504qyysntL2BTAeyGS8oftgmRlNW5uEL
         zKUcRT3Ell+V3Ee7rbi/kuhzBivm4KlfN1xZoyouY4/LKC/G66CU7lIBEc46DUMKL87E
         6A2a9QQNoFrv0sLt7IAHhhP0JwhNP6qdjM8m4rtvlkt7Wd+KbQL5tFKuOhobGACXEY0f
         rPdc20TcW/17MN1eCbNugVDKEFza/dM0aITCBTSARvLsYeevpp/2VquuZZ9kHy7OSI3v
         DI1CyoxHPdxcipym+7iKTMIDBTSVH6DepOEsrROodcH9KrYf9FHyPFACoAgGcQiC75h/
         U/+w==
X-Gm-Message-State: AOAM5328XHd9/U8wq6QAcf91DlR9e/EZxrF+ZKsmkIEIRibPhW38Bb0Q
        vWC+dcZleE6saA65JXU6b6l7p7+OHSq/9hL0srw=
X-Google-Smtp-Source: ABdhPJwLIrTqdMXk4PQr4lizTMpEKqFk/X/lskKN3anQfNMt/DcH0tp8I8yRjbdaBnk5LyGI9kmfWqkjSBd6GWQN5tw=
X-Received: by 2002:aa7:8bcb:: with SMTP id s11mr24575541pfd.170.1595356505199;
 Tue, 21 Jul 2020 11:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200721171444.825099-1-jic23@kernel.org> <20200721171444.825099-6-jic23@kernel.org>
In-Reply-To: <20200721171444.825099-6-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 21:34:48 +0300
Message-ID: <CAHp75VftkmabMn1qdJy4Pp0dQPsX1Fcia84PjTAv-xr1BdJStQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio:adc:bcm_iproc: Drop of_match_ptr protection
 and switch to mod_devicetable.h
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This driver cannot be instantiated from ACPI due to it's use of
> syscon_regmap_lookup_by_phandle() but in the interests of clearing
> this anti pattern out of IIO, let us switch to an explicit
> check in kconfig and remove the protections on the of_match_table

Kconfig

> The switch of header is because we only use of_device_id
> in here and that is defined in mod_devicetable.h not of.h.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> ---
>  * Use Kconfig change to make it explicit you can build the driver
>    without OF, but it won't do anything terribly useful.
>  drivers/iio/adc/Kconfig         | 2 +-
>  drivers/iio/adc/bcm_iproc_adc.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 66d9cc073157..f495d01a79b9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -340,7 +340,7 @@ config AXP288_ADC
>
>  config BCM_IPROC_ADC
>         tristate "Broadcom IPROC ADC driver"
> -       depends on ARCH_BCM_IPROC || COMPILE_TEST
> +       depends on (ARCH_BCM_IPROC && OF) || COMPILE_TEST
>         depends on MFD_SYSCON
>         default ARCH_BCM_CYGNUS
>         help
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 936da32faa9d..44e1e53ada72 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -4,7 +4,7 @@
>   */
>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/mfd/syscon.h>
> @@ -617,7 +617,7 @@ static struct platform_driver iproc_adc_driver = {
>         .remove = iproc_adc_remove,
>         .driver = {
>                 .name   = "iproc-static-adc",
> -               .of_match_table = of_match_ptr(iproc_adc_of_match),
> +               .of_match_table = iproc_adc_of_match,
>         },
>  };
>  module_platform_driver(iproc_adc_driver);
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
