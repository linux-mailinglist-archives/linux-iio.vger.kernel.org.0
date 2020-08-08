Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF023F8AC
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHHT4T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 15:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHHT4S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 15:56:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70AC061756;
        Sat,  8 Aug 2020 12:56:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so2618857pjx.5;
        Sat, 08 Aug 2020 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDYGtlGJMPqtKT8d06JsQQyg69R5Q6wEWblS1ZG0C9Q=;
        b=NZ9oVA73B5IDm6gV2F4aTD42gCZyN7pW/08XBIGrysN7CRFvUclL6WCsOStZcTo6Px
         AUJQLKKHV2s74JGLbMZIZWlh/tcvHASC/Lqrl2ZMVJ6l5EKqCujDyOOK2idtSJVZjn53
         wcZ5PsfXtvjXc0F9VBqkEsaxVhNvY+ekNH2FtMWONPIrsliLkr+diZCtFufj+Y+vIRMj
         fpSBLRKU3CdnVUrSGLxNGLa8LuzB6yGlyiXfRUmFQXODkG7V0Jw+cGqHSNCYVSZqG0Ly
         M5j4TgcRwaeBHQ30TdCtjXhMisEAfrmlOvuDCv1MGNLYaP6uSKlJDCdFNqT8/GepiSAc
         /MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDYGtlGJMPqtKT8d06JsQQyg69R5Q6wEWblS1ZG0C9Q=;
        b=kxBLmqcWLmQ+2HaVVfJUWjqpaSEHE/R2GnozKAMuBKwp5fbfN2qirEb/vIDbcUQH80
         R6gJ2yXJqygYnRPwnRvzQcC/+A+vz/dNtvYitUZ3nJxyUwMfLMlF+a2v/59DwFaaiEWc
         0odFDBHrSTbFq7gdskjV6TcoL3bfXaq6+C1jSbhGUIrs3hXip2SoqVMaaQWnleko/e8D
         Wn06LW+Rff19s7UfVrf5l0BWWsmvWR6Gc+vFms7ZF1xD7lcu7jADzYRkmwHtz+CAaWvu
         b98kx5+kf8qtiB1JrHviklR260/1ylXtkymjh5fffWj22JUJ61cQ0QYnignhV5EOEfB/
         EKJg==
X-Gm-Message-State: AOAM5324GyJD1i0eq6Soor97yW1FKUW93Mdn46HHPLrbcWbnBIY+wXeV
        ZZK8NaTUe5kDjMn1OG4NofShwNMC7Kk7zjsWhiQ=
X-Google-Smtp-Source: ABdhPJzlVIRP/+qhkkY9G9Xx6QikFoD7nm8StpMEQoKrqtVG9sC1BK5ABqDe0w79wny6k42Lzp/eaEnhQzeCCGXnjpI=
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr20314602pjb.129.1596916577544;
 Sat, 08 Aug 2020 12:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200808121026.1300375-1-cmo@melexis.com>
In-Reply-To: <20200808121026.1300375-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Aug 2020 22:56:01 +0300
Message-ID: <CAHp75VfVOra76YGtqDY6ZR+8-_fW2kgKhf-_Mv5mDa5Epdv5NQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] iio: temperature: mlx90632: Add extended
 calibration calculations
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 8, 2020 at 3:10 PM Crt Mori <cmo@melexis.com> wrote:
>
> Since the second patch is dependent on the first and was still not
> merged, I have decided to send them together. First patch just makes
> second one more readable as it splits out the repeated calculation and
> that enables the second patch to tweak the variable to the new
> condition.

I guess the above is not true anymore, b/c it's already 4 in the series.

Thanks for the changelog, nevertheless!

> V4 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
>          - Move the function creation for Ta4 to first patch
>          - Add kernel doc patch for documenting internal struct
>          - Add patch to convert while loops to do-while loops for
>            polling
>
> V3 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
>          - Change commit message text to more proper English as per suggestions
>          - Drop unneeded brackets and parentheses
>          - Use defines from limits.h
>          - Remove userspace typedefs as leftovers from porting
>          - Testing of timeout loops with iopoll.h was no successful,
>            because delay between measurements is 10ms, but we need to
>            fill at least 3 channels, so final timeout should be 40ms
>            which is out of scope of usleep function
>          - Fixing some typos in comments
>
> V2 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
>          - Convert divison back to shifts to make it more readable
>
> Crt Mori (4):
>   iio:temperature:mlx90632: Reduce number of equal calulcations
>   iio:temperature:mlx90632: Adding extended calibration option
>   iio:temperature:mlx90632: Add kerneldoc to the internal struct
>   iio:temperature:mlx90632: Convert polling while loops to do-while
>
>  drivers/iio/temperature/mlx90632.c | 251 +++++++++++++++++++++++++++--
>  1 file changed, 236 insertions(+), 15 deletions(-)
>
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
