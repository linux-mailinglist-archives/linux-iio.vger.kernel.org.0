Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CFE1DEC46
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 17:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbgEVPlR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 11:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgEVPlQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 11:41:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27567C061A0E;
        Fri, 22 May 2020 08:41:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e11so4403130pfn.3;
        Fri, 22 May 2020 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkeVeEmTaIjxtOxUWFezjp2IkJ1MY8WBHQ8sSrPjR8g=;
        b=HYUOUocOBHB8kAf7NZwqO8nrAIOrnuMHJZwpK5m7aC9RrHGNjP6CftTCecVIjBErpr
         TbYsin/LsUEUZId3ViDg556fbFF2SxbBAqtK7gBIivTR9zJ9SanrtHxRwvuYI+zeWK1g
         4RJj3TWGwhIU/qEsYCt1eBUonliqYlWk5cz2AFWCXmKgJJiWKyYrEzwfZGyf2cRwy/2A
         bDn2W1liPSFTH9UZGgnqds1H86Fw6NEVN3uXEIxhNjXS8TdnsVM2dgL0b2TENMuyKxBp
         k4Qnr9obs6ZnEaWBNVAJcJSzw5EqSaKbFdGS4AUUd0915M0ycd/z2Ng1Sl3NY+11uXpb
         3neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkeVeEmTaIjxtOxUWFezjp2IkJ1MY8WBHQ8sSrPjR8g=;
        b=W0f7aW0TIUgAGTkyHcdUk9Icw80/lqFJct1/MXeaOLglaYw+BnETtrPrD/KqynjbZD
         71byfvaR/0IXE+BfFopUsrKRGcmRXOkOhEoD861t8L1cTd3FirN8xWOlRBSkTk/c8hQZ
         odeAaiF/ZNtvWOCakV/Ni/4GI26nFWGmxfwJZDJNV0N2QSFHUARfmJvG2AmM/gZVke9w
         EvvrhlcQ2Cu4AFKfHnhpmnFpURwXBxki9i21c8rtWEf4wfQI/mgfeWxi5KLi+yL2yDna
         XjbYm/i57Fn2w7SPvA//zhU9WMcF/pqjxPibjolCMRlHepbSUmVPHcx2ab6cRFoD/Vss
         lTIQ==
X-Gm-Message-State: AOAM5331lGc8Nz0mCjh6kO1a2nssMA1gKd110WVvNM30Fs7riGIfHJLK
        EWA1xApBcDuu7cWAubnPZARBej1f7MGV6kQkLGE=
X-Google-Smtp-Source: ABdhPJxTXftG09+ACXZlzPxanrfzRxC2kKKAPbtxSlZCVYuUYz2NVESO1cgy56CqWcfFZB0Vrkcnd6C4NSkbkMXkf98=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr13726609pgb.74.1590162075719;
 Fri, 22 May 2020 08:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org> <1590157452-27179-6-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1590157452-27179-6-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 May 2020 18:41:04 +0300
Message-ID: <CAHp75VeAoOahk2BDSZjCBUnJGb-Nn-ewQXDDkuj8v6_c3m1YZA@mail.gmail.com>
Subject: Re: [PATCH V5 5/5] iio: adc: Clean up ADC code common to PMIC5 and PMIC7
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 22, 2020 at 5:25 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> This commit includes the following changes:
>
> Add a common function used for read_raw callback for both PMIC5
> and PMIC7 ADCs.
>
> Add exit function for ADC.
>
> Add info_property under adc_data to more efficiently distinguish
> PMIC5 and PMIC7 ADCs.

...

> -       if (of_device_is_compatible(node, "qcom,spmi-adc7"))
> -               indio_dev->info = &adc7_info;
> -       else
> -               indio_dev->info = &adc5_info;
> +       platform_set_drvdata(pdev, adc);

Ping-pong style of series. Can we convert to .info before we introduce
above check for compatibility?


-- 
With Best Regards,
Andy Shevchenko
