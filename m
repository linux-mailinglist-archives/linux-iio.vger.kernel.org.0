Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E0034A61F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 12:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCZLIJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 07:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCZLH6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 07:07:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780AFC0613AA
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 04:07:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso1555979pjh.2
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 04:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/OwgrLHB0R3WT7/McUUo5IStVQyg1I1zxsyK5Hop9w=;
        b=Bg5iSMvWg2QCAi8NBUvUN8YOgwSUNSpZUyLQu8m8uIRD5xlDYtWLCKiwSr7NXP0huh
         Ubt6K2v8oHdjdu7R6gLEg5782KFdcBeymeoreoy1JKbqO8WrKGqOFyK+VVCTsUvrV33g
         WZC6SoSUoW8TW1rwGgDsPyv7BAiK7sNwNBlM6qvaep+yoy/pqz5Bz8TeqGekq1bVxyqC
         Pn96HyV7u4u+/lwNHx96lJ0CqnyL/OvPaIHK0d8Gk4FXoxK/jD3fu7cA0ZHEtAycHgVv
         w+ELdRn7bWp42OCfKlDxUHzw8l9KatbafZFdqzadvSrhZ3AG8Elhn10YOb7Zub2w3Gnm
         WHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/OwgrLHB0R3WT7/McUUo5IStVQyg1I1zxsyK5Hop9w=;
        b=lXFoxn8SdgpYNUK94k/BJaFbVj516YYpylYr5c+tk2Qmyx2Gu7xQdHLuUykbYeGjnr
         sBwjyUMdZ0Gr5PfHIRJ6tCgcO67qBH+mHSw+lpRa9ocWDduvYngj9UnliJXyhO7LwxHv
         YJSlZcOXU8PZZOWXvAaXzP4/qJcKGYsczeTrk1tB+y3iXaG1DHNc8Mw5RpAdQlVcbgtu
         JuJAsnMZU8C5KsHwrWdfvQDh4iNpBR4aC2OEEIYEhYsIvIRErqevf3Pyw+Z/lqism7+q
         VBLBYGXdLPjdAg0RjOlrLfczuNmGGL+Y5Ny11nqXgpjI9NqM71KD+4Ol0SZ/4LdvXpbM
         163w==
X-Gm-Message-State: AOAM533vuc44SDndpCR7gqTAKu3cDcVP6/RY3tBxEQErH8VAdFEq7RFj
        b/s24PBi3AZMHjVXTVof0GZ6g1CY6py3SPxH41U=
X-Google-Smtp-Source: ABdhPJxPIq3WZikgO8QgE9OusAY8HDCfsVw/VyM1w7aqkr52e1xh/XOpOh/LhSp24QrQSZEThowX/oapu/KfQcNpX9k=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr14734470plb.21.1616756877990; Fri, 26
 Mar 2021 04:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOgtOjMw0UDhOgXU=HY=+kUhVU+Ya_N=Mvxj-cA_gvj-r9HwuQ@mail.gmail.com>
In-Reply-To: <CAOgtOjMw0UDhOgXU=HY=+kUhVU+Ya_N=Mvxj-cA_gvj-r9HwuQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Mar 2021 13:07:42 +0200
Message-ID: <CAHp75VcP8CbJ7w-9LjAvg4scKVNtMaMfqzS7umtXhWVnVavmwQ@mail.gmail.com>
Subject: Re: [RFC] GSoC'21 IIO project: Mugil
To:     Mugil Raj <dmugil2000@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 26, 2021 at 11:53 AM Mugil Raj <dmugil2000@gmail.com> wrote:
>
> Hello All,
>
> [Dragos here you have a quick intro about me if you want,
> https://lore.kernel.org/linux-iio/CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com/]
>
> For GSoC'21 IIO project I would like to choose  AD4695/AD4696 device
> for implementing the driver.
> I referred Analog Device, Inc.'s page that lists all drivers and
> their kernel tree, but there is no existence of any compatible drivers
> for this component.
>
> About AD4695:
> - 16-Channel, 16-bit 500 kSPS SAR ADC
> - "Recommended for New Designs" phase
> - SPI digital output
> - Datasheet in [1]
> - Product overview in [2]
>
> Is there any other factor I should consider before choosing a component
> to make a driver for?

I would consider the "popularity" of the component, e.g. how many
questions on SO or similar forums about the component, how many
(broken, ugly, etc) drivers are floating around.

> Do I go ahead with AD4695  in my
> proposal? If yes, are there any recommendations/suggestions you'd like
> to provide for a beginner indulging in making a kernel driver for such a
> component?
>
> Thanks,
> Mugil
>
> [1] https://www.analog.com/media/en/technical-documentation/data-sheets/ad4695_4696.pdf
> [2] https://www.analog.com/en/products/ad4695.html#product-overview



-- 
With Best Regards,
Andy Shevchenko
