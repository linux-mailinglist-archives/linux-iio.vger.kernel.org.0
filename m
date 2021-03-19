Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2C3423A0
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 18:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCSRrU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCSRrB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 13:47:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FF8C06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 10:47:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so5243128pjb.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VLEJ18GbAKtVQTsWI6Yc/3T4kStBYCYFCb9luLrpPQ=;
        b=MGwmxyJjPQLvASbQSYRFssqHTMHbatjPF6m2jDrwXR5exiWQpkuuUPB9dyteHs0uzg
         mpUBfKwLHAXoiWLn7xBz/eNwTd/DBpd9J7al3aWsrbMYUGiKFPjInWcLD3HoSfeJ65Et
         4wb3xN8Q3nmdz/268JGE4qb9GmSLfehr6FgTnM+pgIc5tH+ZCl7XBGkyxB/QkTCbf2F1
         U/HzSJ4K+jfGXUZx5UvbRZhm/MSZa3c4SF1Myz+oynArjj44fVi7322EO2dy4aL7GjqE
         3Engw6C/WLXG+KBwH3npJSoTnFchAUs4iEN2UIZb1KJPBDC4ZYf4jqGJpDm+H1ybD5HQ
         Nj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VLEJ18GbAKtVQTsWI6Yc/3T4kStBYCYFCb9luLrpPQ=;
        b=pmQyKMdOM6BioOkddAfbtphPUp0bGpxRkXJDHbda/RJLp7OJimziXEiO27kVpRvSrx
         +c0qtWJTTyPWOQJoflOONL66xon53MJv2h1WWoAk6x5/0coOvmvJa8mTd1+E8Ss+P0AO
         kmJsrxyvGgrOHKOsqqM7qJYbDRVZFFQfS3fv2u3J6Me5C+GXCnW6UJEtz+biNWWNopZN
         Cn8/DoSQ/FJTe20kijOcMRY6r50Bw8xOkFMWhN8eQGcGXVNulMkCC+dgzIcq5nCwezGi
         rms3pyL85/cEvPuiSOwzlJRltgOGxdaKi5bK4ReOiFhQyxHIeaAVyUsQoxS5jx8Fj/G0
         XLBg==
X-Gm-Message-State: AOAM532DdJDkzlp9qbZMuUghB2OuOdw4KSWNoQu+H13amVuBcamokb2x
        1jPIFqTWqYINXLTK0ycJXUhJMyr624eCcVR+ITw=
X-Google-Smtp-Source: ABdhPJzp0KP4MlFpTiNW1DjKCARaWXczb5S72HynbXcBLV2x/1K2S9gJ18QZrL289FEU0dbeQ46uhBsa2q56PBJ0hFQ=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr15320020plq.17.1616176020475; Fri, 19
 Mar 2021 10:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210319165807.3639636-1-gwendal@chromium.org>
In-Reply-To: <20210319165807.3639636-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 19:46:44 +0200
Message-ID: <CAHp75VcSHxRADWVMu8qfNwZrC_XanXTY-0dMfChuDuSemev9jw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] iio: sx9310: Support ACPI properties
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 6:58 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Current sx9310 driver only support device tree properties.
> To be able to use sensor on Intel platfrom, add support to read ACPI by

platform

It's not Intel specific, but any which is using ACPI.

Luckily it's a cover letter only :-)

> converting calls of_property_read_...() to device_property_read_...().
>
> A bug was uncovered: if "semtech,combined-sensors" array was less than
> 4 entries, its content would be ignored, as of_property_read_u32_array
> would return -EOVERFLOW.
>
> Gwendal Grignou (2):
>   iio: sx9310: Fix access to variable DT array
>   iio: sx9310: Support ACPI properties
>
>  drivers/iio/proximity/sx9310.c | 56 +++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 22 deletions(-)
>
> --
> 2.31.0.291.g576ba9dcdaf-goog
>


-- 
With Best Regards,
Andy Shevchenko
