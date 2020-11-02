Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31402A2641
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 09:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgKBIj4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 03:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgKBIj4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 03:39:56 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9BC0617A6
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 00:39:56 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id l24so13487076edj.8
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 00:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smS1Q7PTGYl/it8iArEBOUfy3XGW9AyAE4tKm3iDIRQ=;
        b=gMUAyGpxpb58h+N2xXKp5HXZPxTSgcJrqV00YYu3uvO0SiETm7PSD7KYl+WHu3lBvb
         LLUX5POR650c5Nz7pd0idmKGW70EYG4ryEhNOuHisZQohHSbF0zJIBfC3WDrXRY9o0oo
         DYIwdg2BExHy2/uLyT69Sk4fEOIYjJZt/JlEqPaCzY7FXvgqb5UVKYiYX3oDybNoHBwk
         +7ZlYJ0esc5PZhCtwTOj+EaAl9ll6hQONmSYm2OvB2xyX4TseSHUot+CGkoi7+6bIv9t
         /JF7Upfko9SMVseKqEXWevscRknvVrGLGrh37ahFzO620YNi36dmzGNsFC1hk7KHhkEW
         Vn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smS1Q7PTGYl/it8iArEBOUfy3XGW9AyAE4tKm3iDIRQ=;
        b=erTA0ygaJ1Tqalo8a+zXBFMrxyVLbw7/DLbYdOGWLU8dFX/kNxVFnt8MI/dbWF+sNU
         SFgFk9ev/7ET1QUji2G2iEbDYBto2NfYG4o/Q5efkKlmRcxvUJDFrM42mma6U3p4Xtr+
         7/UHqsUEgPkFuD6ZXChYN3MO3fRxN8E8kAKpHnm8dZeQT9u5ALg3CH8Gswhrn2aK1CVj
         2kteAPXnXbfxRGZhrjmmHVy5SfjBWP6Ardwt5DJjYEvIoEpX8NRM2SyEKXg/YKoh34IR
         ZxAN9hcrq48kBeyZDXF76mkXwxAUdiSRpQitUqr8N1q5OlGcAPmYk1LKnfxmdmQ0s7q1
         vp5g==
X-Gm-Message-State: AOAM532w+YsaTe+ZHXo85W1bqTfhMun4ZgpY/vvEAXhvLyAJLfIGTsa6
        OrbW87qY1VgLOR5Yy2nJj99Cmt/se75/52P0ABbFWQ==
X-Google-Smtp-Source: ABdhPJxTFP9Vbppje5a53EWx8P7IDRRaTAc2fzTg2IqzLS2XtdKl3Yqbneo+Mlfa/K+FLdCkXC9z1sAnJ9eMIhy4Bfo=
X-Received: by 2002:a05:6402:495:: with SMTP id k21mr15615893edv.232.1604306395005;
 Mon, 02 Nov 2020 00:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20201026133609.24262-1-brgl@bgdev.pl> <20201026133609.24262-5-brgl@bgdev.pl>
 <20201029154118.12fd6c23@archlinux> <CAMRc=Mfun85W+ZfJqaXohCQ8tNGDxjxmvdFuwsQ07jMhG+vU7w@mail.gmail.com>
 <20201031111003.75a4f6d0@archlinux>
In-Reply-To: <20201031111003.75a4f6d0@archlinux>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 2 Nov 2020 09:39:44 +0100
Message-ID: <CAMpxmJWoEGFaX5czVSFd4D2Mhkp_jF7ZQg9TtDGs_tRiYWmupA@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio: adc: xilinx: use devres for irq handling
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 12:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
>

[snip]

> >
> > Hi Jonathan,
> >
> > My two priorities for the ordering of this series were: correct
> > end-result and not breaking anything on the way. The latter
> > unfortunately gets in the way of cleaner looking intermediate patches.
> >
> > I tried to not alter the ordering in which the resources are freed at
> > any step. As devres release callbacks are called *after* remove() and
> > in a reverse order to how they were registered, I needed to start from
> > the bottom of the remove() callback and convert the last operation,
> > then go upwards from there.
> >
> > If I tried to do it from the top - I probably could remove labels
> > earlier and in a cleaner manner but it wouldn't guarantee
> > bisectability.
> >
>
> Maybe best plan is to squash last 3 patches into one?
>
> I suspect that's going to be easier to review.
>
> Jonathan
>

Sure I can do this.

Bartosz
