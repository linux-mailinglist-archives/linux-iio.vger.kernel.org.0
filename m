Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721BA34A615
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 12:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCZLF1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCZLFX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 07:05:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A128C0613AA;
        Fri, 26 Mar 2021 04:05:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x126so4604063pfc.13;
        Fri, 26 Mar 2021 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5knUKXVVKxRJONjueLpXy7ReVPJOZ75MKPSZM1uQdo=;
        b=otA0taK5wnEcZZykRCyngxZy4Dy3Obi1w373TgctCzmBPHiQ2uryS2yQHLLBqC7urK
         ubIloxEgipB32vzKtN9ZP7ofV6vmxkKmIOvoHIY0Uwf7XFqUAo4Ia0vxV4aeF8axhkxf
         5ggPj9CtPpwtCAaoVeyIZAi+qPtw7R7kPFLWfRZZR66W8FS0WE8nhoCKVACz1aM0Cfyw
         tvTCHcau2O4WipJ/2+jJWPL5QZZqQ7o9nSN8+3BYJ3NzA6iGnkWBZb1GpZa+cHvL3IEl
         dY7KtdW3PkTHRTv6kEhRbbSEmDaKiSU2MencJtLwyhKAuWneegzCpOlJhZqSwoon3O3e
         IXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5knUKXVVKxRJONjueLpXy7ReVPJOZ75MKPSZM1uQdo=;
        b=Q87vFPmEdvPZMQPsnUK7geHVGQd+fLdbKInRFKyR9CqFTTIx8WDD08a29MVellUYNU
         WwwHdcfd3o0RBQAW7ES3gR2VyJRAgMKTr8FwW1h/UHLF4+xEqxiTcfDdlEnbJGaQBYKv
         YuexkaQuQ9LQwmK3pFT4P7yR9pekF4ZggdStCH11Yypj2Ml9liC00vmg6JSGmpWwVwFW
         M2clIMBZgVkrlM2i+IYavYLGJkAoIZFW5LBl+3zwLrYfLcys+8om/R4cur2ImptCC5Oc
         KRRfOQruH8H8bNbwXBdGZui8mG2UNdf7oWeg0F6XQ29+JEBsbZO4I1Dl6xl1Y+v/APUk
         Sa/Q==
X-Gm-Message-State: AOAM533b2h4gkQd9T65lPGJVsgvGIbSjjFBJPtryKb30EfP4zn0nGdVl
        U2sYJ6nDU5QlPV0wjghTxxGuyDoSu1ljZglzN+k=
X-Google-Smtp-Source: ABdhPJzxTzOqXI+5objm1Fz7b6fFXsYMsgcmUXUKgksUBM6mSIOmYSKjLehZMEqBZWX5+Y9OmNdG4Qa7QIPcgT4Bf7Y=
X-Received: by 2002:a65:4bc5:: with SMTP id p5mr11476249pgr.74.1616756722718;
 Fri, 26 Mar 2021 04:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210325220505.14507-1-joe.g.sandom@gmail.com>
 <20210325220505.14507-2-joe.g.sandom@gmail.com> <20210325234343.GA1959978@robh.at.kernel.org>
In-Reply-To: <20210325234343.GA1959978@robh.at.kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Mar 2021 13:05:06 +0200
Message-ID: <CAHp75VdvC-jzq1yTJkRV-FaKa525n9smi=C6Ne4BK13Jmep45A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Added AMS tsl2591 device tree binding
To:     Rob Herring <robh@kernel.org>
Cc:     Joe Sandom <joe.g.sandom@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 26, 2021 at 1:43 AM Rob Herring <robh@kernel.org> wrote:
> On Thu, 25 Mar 2021 22:05:04 +0000, Joe Sandom wrote:

...

> > Datasheet: https://ams.com/tsl25911#tab/documents

Not necessarily needed in this patch, but it's harmless.

...

> However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.

Joe, seems you missed this part of Rob's message when resending.

-- 
With Best Regards,
Andy Shevchenko
