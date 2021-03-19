Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C023423A8
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 18:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhCSRuC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCSRt7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 13:49:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5744C06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 10:49:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v3so4194798pgq.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+uc078/ytbmfzSvwcCyQhTlXKa+P1OdGqk3qvv9m9w=;
        b=hEsqPPV1EMmEGnmeGAtf0yhdImu7WRdKkuiETfmCetiBWl9iMdasvecCwrcIktTtlF
         DYDC4LdVKg08JsyNEbJ9TUDqexWFDxFxwEJ3SfCPay3Vk88c3k4Dy6uyDyTtvduV3jQo
         /r1Hz9RF3GQH8gEiuTe0aJRMRQ1yof9gQmbuYQC9zgiLZDKUAdLQLUlhNsYKPnenyCNt
         ZVWsmLtKprzinzETtELLvEc45goyPtkW48SaxjYyJXzBuaEWvksWOr/Ix2JJ2BGoPv+C
         DVcp/BOtwPeTLLDxlIl0wzrSDuDHzhCmpzdASbrKeDxzFh4bacG4cWrN2rlIRYZM8LBo
         gWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+uc078/ytbmfzSvwcCyQhTlXKa+P1OdGqk3qvv9m9w=;
        b=AjQ6oor5jyoySnK5XwN8yyoG8x+4EOKC5ZPqFcz0lWv+CzHJjPhjj2U2m/rvD4X6YM
         +jfzJ//Obumu0ZBGJO0xMN0fRbOI15M4RwkHkc91MPkH/OItU4vH899vxM7FAKQMe1D7
         AnNa2zn4Z11wcxb8zrVz/iZE93BH7cP8Ob1/mRQwow1oxwX12hub/1hft84NR/mtlmCM
         zYfH2/Z5S1W/C3U5jGpYBxRszvuZBuvBIFxiGElRu5JPDnHllIyXOhwQTa9Kkh/RpUNp
         GVJlQAvzk2qPEzAvoMW3znsnNQhN5wOL1DRi34Kt331ZPzaQE9eKU2kgaEBDj0artGlP
         L0vg==
X-Gm-Message-State: AOAM532KBIVpzuv4/lwMjQ5z4dZY5w8WbPFu4f9W5ageP1o83mhRwJ5z
        h1HMRqocJmYg1bhwskm8WyJKv/f3XeqNy6D1KFA=
X-Google-Smtp-Source: ABdhPJy8AUQmUiLVuidk5ORxcyh9LaXo8f+ys72uCi9YKA8efJ97/1jOH9WzgBFAA7uXaX+sXX2fVze4J5pgES5yT/0=
X-Received: by 2002:a62:e50f:0:b029:214:8e4a:ae46 with SMTP id
 n15-20020a62e50f0000b02902148e4aae46mr634420pff.73.1616176199311; Fri, 19 Mar
 2021 10:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210319165807.3639636-1-gwendal@chromium.org>
In-Reply-To: <20210319165807.3639636-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 19:49:43 +0200
Message-ID: <CAHp75Vep=SXxMNs+8MinL_1BXyozrz8cYDZCH8A06a2dppoD0w@mail.gmail.com>
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
> converting calls of_property_read_...() to device_property_read_...().
>
> A bug was uncovered: if "semtech,combined-sensors" array was less than
> 4 entries, its content would be ignored, as of_property_read_u32_array
> would return -EOVERFLOW.

After addressing comments, feel free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

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
