Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81762C3EDB
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 12:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgKYLOH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 06:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgKYLOH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 06:14:07 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA1C0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:14:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w6so2018098pfu.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XiPqGph6Bh+YxiJiwEZreboroC5yxHM7BxNSZTaDSsk=;
        b=msGGxnOlPCZtUAVSm8Lb4A8cXEi+tTdJ7YCy3QfRTOS0g+GjTbp+ZUtICQTAnaj8DC
         b4EaxMJiaMQsoU/ZzLBsU+mPYz9WUo1BMP00QKEwDbeDLyxGHaHuzJh34X88Ul6wtHfN
         by2smCFNEe8RFBvP8tkePSs8MFdIuEMIgLDqOw22xqEH9VS+5mAgERngDj1eqfur1dvR
         xfTvTaP4V3opUDNo9HE5Zt8xiELMfZ9gf2e7TwTIlfjFlvP7dMOT7RYLutxsTNCl7YDs
         uE9CtKzfmg1En6fgZadBMpIX0qJsf5bh3h92luFiPhMVcAInlfKPrCEVE42plzRfC9dw
         gYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XiPqGph6Bh+YxiJiwEZreboroC5yxHM7BxNSZTaDSsk=;
        b=TM8+lCGXTZXz0E25orHdiKLXBhCiYwrcgMLEeYgf9pYDgmRvkLAk0Xf4Q5lf+ydjq0
         C34K8WhhQdhEiMQr/Isr6wrDyABRRFj4sCtbAAtb1mqoQW32kDOzogvm/87QZCfQmYAU
         J8Rgn8xfVnoJEbTJBUwYUdq1WmK5hlP1vAN8dG0dYGaECPfklPNuvMRHNeXm8gMncZL3
         rX3phcX964PcBuOC/18nWvr34zOEaZ/rZJ6a9qehsfkYxI1hfFEYHg3XvgyY4xYLYzBO
         mbVh/jlQ5UkR3wjoY3tUnJJFXhQkzMYXgJDGAEQ+IDgEtV2UlbludW/bvz8IlyFg+oOk
         sRZg==
X-Gm-Message-State: AOAM533M/ksT2TfceB8vqSoV+CZNfETJwWhEhroyOvwSZdoKmm8wXpEB
        vcsELgt9LVgY4fQaR9DRElvZb1266TuePQdb4+gX891ytAtkXudk
X-Google-Smtp-Source: ABdhPJzwkIvXa9QiZgeUXjddAOi4Z3eYFpFc0BzlHIaqhPKUZ1wd1oQ3ZAurjyrvvif48AjoWf5D1Bj8fiovhK51wNA=
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr3523011pjf.181.1606302846772;
 Wed, 25 Nov 2020 03:14:06 -0800 (PST)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 13:14:55 +0200
Message-ID: <CAHp75Vfz2P=U6CFY4824hPLSSDQNh4wATE_=JjA63fXyYCpsrQ@mail.gmail.com>
Subject: fake ACPI IDs in the drivers
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Recent discussion [1] [2] around faking ACPI ID in RTC subsystem and a
sudden check [3] (due to last Hans' patches related to ACPI based
systems) of IIO makes me wonder if we may start cleaning drivers from
faked ACPI IDs and establish a stricter rules for the ID table
entries.

Thoughts?

[1]: https://lore.kernel.org/linux-rtc/20201112130734.331094-3-ch@denx.de/
[2]: https://review.coreboot.org/c/coreboot/+/47235
[3]: git grep -n -A10 -w acpi_device_id -- drivers/iio/

-- 
With Best Regards,
Andy Shevchenko
