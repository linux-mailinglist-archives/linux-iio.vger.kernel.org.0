Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F6B1B1ADE
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDUAoP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgDUAoP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 20:44:15 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0625AC061A0E;
        Mon, 20 Apr 2020 17:44:15 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f19so13244645iog.5;
        Mon, 20 Apr 2020 17:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y33m0qM4MU8o/YqA8J+GwhvwHxaN6NvMUsP4KLKq/IQ=;
        b=AwxXoC2qfLdGf+xI91LfiMyFT5rUKt9K7auNtevNJIPerrA/6CgcqSFfzfrGSQ47fy
         qDrEpoobbIVWZer7JrButrtZiiGmeCfXeTczxYv6LRZ3YmqwIJR5M261e853EIFYiN2u
         dIk1iAdQAo1uYRi9kc+mYdXaFnXVEo2QPAd28vxzuOkjknkTnecdYOYEpbNeaA18SKCL
         5GVOA7ty4I1aq9WLMwlDmUguc75ZcShWCosX7r6ImGKW4TSibm8sk4xXm+JEuh3bDQAO
         vwTba10K9NEy9OcrSVALS21jCeqd+pGJ9DiGWdAOV22JiNUIixJIeVzUZ0dhdiO+jliG
         dXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y33m0qM4MU8o/YqA8J+GwhvwHxaN6NvMUsP4KLKq/IQ=;
        b=Y6iA97XOt4d7JOgg3h/GlvpXpEHJTGTkbWyb9G2B2qg0TDTrcVzguFrm6KbkCQ68Qu
         EPwD69DO9Zo0jL2DJAlGUO7TYC+5N0P0QUp9EKoRQowcpHHgbku52MVzSZYlgWQwvHXW
         YPTJ2pP0utA0XAIPwhOJruUzNhuGHTKJdq3P2RlO70y5tjEY0txecXj/OC7kAg/iK8jw
         LM/c5U7akXs21t3FAT9ggpBRMshz6j2cmANfng100aGz/YQLbLBOwB9sk/+QyAVw/980
         pxOgqbdfcQmMEOi61mXd0SAwCfUlFaX44rmqBl7nRiJi8mxjTdFmxqDwl/OiV7FqfOni
         M/uQ==
X-Gm-Message-State: AGi0PubGUl/ktw3u7tpW2b8f2b8VoCsVT9VovXJd0fEsn7/cx2e6CwTf
        91BI2bHYV6X6suI75NXRytmXXNAWzQhglLupQy4=
X-Google-Smtp-Source: APiQypJVvfz70h2+81nxjES7i+sYM8+j8QyDLTDRGtJUKqTZUcdRvBl/IN39lKKtD694tQ0KwCXmgRsZzJUWt2+lOYc=
X-Received: by 2002:a05:6602:1695:: with SMTP id s21mr18542477iow.40.1587429854456;
 Mon, 20 Apr 2020 17:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200420084210.14245-1-m.othacehe@gmail.com> <20200420084210.14245-4-m.othacehe@gmail.com>
In-Reply-To: <20200420084210.14245-4-m.othacehe@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 03:44:02 +0300
Message-ID: <CAHp75Vc+pgSUfFSxHxw7wtPxbDSzO8muv435GWy_2R_d6SOXoA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 20, 2020 at 11:44 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:
>
> Add sampling frequency support for ambient light and proximity data on
> VCNL4010 and VCNL4020 chips.

...

> +static struct attribute *vcnl4010_attributes[] = {
> +       &iio_const_attr_in_illuminance_sampling_frequency_available.dev_attr.attr,
> +       &iio_const_attr_in_proximity_sampling_frequency_available.dev_attr.attr,

> +       NULL,

No comma for terminator line.

> +};
...

> +static const struct attribute_group vcnl4010_attribute_group = {
> +       .attrs = vcnl4010_attributes

Leave comma at the end in struct member definition.

> +};

-- 
With Best Regards,
Andy Shevchenko
