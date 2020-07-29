Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDE6231CCE
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 12:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG2Kir (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 06:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Kir (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 06:38:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFFC061794;
        Wed, 29 Jul 2020 03:38:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so12739529pfu.1;
        Wed, 29 Jul 2020 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOt4am3ptH3bamAsHkPtkKBdiD36zwsqmzqbepXBWe8=;
        b=XD6KRO6w63ECQYGfBkLoQt17DuEmY+HHbmecVpVQ/Dye7/R2WatECNMg/Cmyx+/ouM
         H7PfoB/r8C97XyCP5VsRUc3AeK6wOAUOuIXALkj8koSqlFAVZNvUm2G9+eRtjVm18cbj
         b1Ioczc3J0prvsJyRP0nWrBEh7bq1/Ham3sd/hGY7c/PweS5ZcmTxX8lQLoWBkZWIL9g
         ldith4ETV8JcFUWzZukT22w67q7FSMFR1M10L6GgqVMdSaSVI7xIs87KJt+RWXHeI0nc
         IgPXyewpZr3MuTmUDEP+bWVriX264EIFBYgwI3zkjBSshDX9D847ePk7/dejH6pnp7Fa
         FbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOt4am3ptH3bamAsHkPtkKBdiD36zwsqmzqbepXBWe8=;
        b=LCQGiPEwf562ba9Ovu9fQPUYNXDUAPuD6OHEBmOCfuAZWwDl2pYpou4W1dD/tQE01Y
         qOwZIYdvKo7GDMM1BUNWFn/VjxMNj6e7fmdIZW96v42tZ/Uk5rjvQrnlMdb64R0DuCEY
         pLR+Ea6tEXUJaN8s7JoyOfRVtjywQUMvKUrfuJJK1C+k92e2cwSXkrETDJw3Mrbpa8+G
         7HRTQe7ck4k9VD51oz/OWY/PZZDudQcOYGUDpL7nnAh6snZCzEB0RB/GYSPDl0NEy08G
         s2RTOvGIHcKVZB8zm5Lq60ylGz11DWO3oCX2acXlm8nETmEwNH4C85zmpp+2nDsHr5PN
         ywgw==
X-Gm-Message-State: AOAM532OWX/8WVPY6O3UxVlq+VYFTneDoFQX0UHVSipg1p9a6BZL+EeN
        3REmVt1tUsvZOU0/U08Ds51S5V30K5tN69OlvZo=
X-Google-Smtp-Source: ABdhPJzC1lAmhZulWVw4qiVD9FP1U166ENhLOQOFnXgSQ/Llia+le+rSXDIzcFNIr0FAW8wTygu45FQnF6S8QQzNE3w=
X-Received: by 2002:a62:758f:: with SMTP id q137mr10134826pfc.170.1596019125374;
 Wed, 29 Jul 2020 03:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VcmMf5dt7mu9N0C=6Rej-WzZ0EpzntHYCQkgNLVZkPbgg@mail.gmail.com>
 <20200729081155.3228-1-b18007@students.iitmandi.ac.in>
In-Reply-To: <20200729081155.3228-1-b18007@students.iitmandi.ac.in>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jul 2020 13:38:28 +0300
Message-ID: <CAHp75VdCBWLLMT7jm0CO+oK8eZf7cSMOM5sb9xZ1Po1_YFAMxw@mail.gmail.com>
Subject: Re: [PATCH -v2] Staging: iio: Fixed a punctuation and a spelling mistake.
To:     Ankit Baluni <b18007@students.iitmandi.ac.in>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 29, 2020 at 11:12 AM Ankit Baluni
<b18007@students.iitmandi.ac.in> wrote:
>
> Added a missing comma and changed 'it it useful' to 'it is useful'.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>
> ---
> Changes in -v2:
>         -Remove space before ':' in subject line.
>
>  drivers/staging/iio/Documentation/overview.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
> index ebdc64f451d7..00409d5dab4e 100644
> --- a/drivers/staging/iio/Documentation/overview.txt
> +++ b/drivers/staging/iio/Documentation/overview.txt
> @@ -9,7 +9,7 @@ The aim is to fill the gap between the somewhat similar hwmon and
>  input subsystems.  Hwmon is very much directed at low sample rate
>  sensors used in applications such as fan speed control and temperature
>  measurement.  Input is, as its name suggests focused on input
> -devices. In some cases there is considerable overlap between these and
> +devices. In some cases, there is considerable overlap between these and
>  IIO.
>
>  A typical device falling into this category would be connected via SPI
> @@ -38,7 +38,7 @@ series and Analog Devices ADXL345 accelerometers.  Each buffer supports
>  polling to establish when data is available.
>
>  * Trigger and software buffer support. In many data analysis
> -applications it it useful to be able to capture data based on some
> +applications it is useful to be able to capture data based on some
>  external signal (trigger).  These triggers might be a data ready
>  signal, a gpio line connected to some external system or an on
>  processor periodic interrupt.  A single trigger may initialize data
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
