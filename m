Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D2723EA61
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 11:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgHGJcr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 05:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgHGJcq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2020 05:32:46 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229CC061574
        for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2020 02:32:46 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id a5so1226450ioa.13
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2020 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2e+C7cne98K7WAXGpHGymF2mpr0Yj6NJ2Dg7lBo/rwk=;
        b=llZzgkuPfcTI3rprKRKI7TMEvFqdP8V3RtrN7Tun6gLDkDTjS8mLrNv+RNHTZ9qPD7
         Tbvv27PX0AnxEIJhtibKbXx25NzVSwTpD4oYBHjZeC9MLuiXRoid+OCyv+WGPySPelWd
         +Qi3Xw9YYDtIrMu05AVwpc+F23d6wim1zg39587yWp4ddnGyu10tlf/fGZLgY1YWb7Bc
         YM06oU/OFu76FVq9W+d9DigW5uKigRT94tki+FdOtKJoAbl760uR11fQ5OHw9o0GEuC4
         lv5OeEfkoV7wb0Lt/Vcztkm5+vy8jywMllI2HEQM5X5vZYsfIM0UZhfpHDjT3fCCccPp
         +J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2e+C7cne98K7WAXGpHGymF2mpr0Yj6NJ2Dg7lBo/rwk=;
        b=RYJAGdg/HuiHcnxvAbEQ+8NqBoR7PSW7DGe638cJdPrDZsYG/y0oBwImiL3hy7rsO8
         3gy68scSasOdJq69xTqYelM3VGGSYXC+t97Mbb/WoszyiBMjOY5joaUi4wPsnuju4h0H
         cJ4TsSUXDmBwuFF7yKdxFSpKuK5LMB8EZscuvfswj5j2OUR5qoqGn5BtIASenWwUDiaK
         q5LgzwznNqj1BdUMP/5IHm1IDN+ocl+m44DZmLqN7iykVChaObAG8vVzX05o63byziBg
         mcm1nl9FUj3hQtqA3bR6stZBv5rAilPMPyhFwgshPSCereraYJbf7V5uo54nrNISl3In
         90sA==
X-Gm-Message-State: AOAM531lOZUN4n3Xifbaj3zYAo8oh6R/eodB7VTcx4XU0PDM7sYUDeAQ
        PGwTgg4LpOcUuBe1OFFrFG1L2JrbsHzFeJbIKxW6zA==
X-Google-Smtp-Source: ABdhPJysjNOsmaMfanSJt9eSDzN7H1m/TOUGUUbOwKXNqwiJbBKQpcrCzOMMLc4bnqEQ7WkMdFmqvT9iz2gQtLyq6jk=
X-Received: by 2002:a02:cf26:: with SMTP id s6mr3856158jar.44.1596792765360;
 Fri, 07 Aug 2020 02:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200807091900.967047-1-cmo@melexis.com> <CAHp75VcJ_h2_Lkn2DiG1B5AOQGmsRx5N5jU2ADX5bgq2cqBnYg@mail.gmail.com>
In-Reply-To: <CAHp75VcJ_h2_Lkn2DiG1B5AOQGmsRx5N5jU2ADX5bgq2cqBnYg@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Fri, 7 Aug 2020 11:32:09 +0200
Message-ID: <CAKv63uvo3ovJbcSV011-1MSExGvNFRFPKV9hCZ+niT6bqKMKGw@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: temperature: mlx90632: Add extended calibration calculations
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 7 Aug 2020 at 11:29, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 7, 2020 at 12:22 PM Crt Mori <cmo@melexis.com> wrote:
> >
> > Since the second patch is dependent on the first and was still not
> > merged, I have decided to send them together. First patch just makes
> > second one more readable as it splits out the repeated calculation and
> > that enables the second patch to tweak the variable to the new
> > condition.
> >
>
> When at it, bump the version relative to the maximum of all patches
> involved, like v2 should be for all patches in this series.
> So, there is -v<X> option to git format-patch to help with this.

Thanks for the heads-up. I was doing this by hand so far :/

I assume there will be some comments, so I will follow this in future
submissions.

>
>
> --
> With Best Regards,
> Andy Shevchenko
