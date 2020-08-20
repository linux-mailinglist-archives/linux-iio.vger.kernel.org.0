Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4624BD4F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgHTNCl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgHTNCS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 09:02:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51971C061385;
        Thu, 20 Aug 2020 06:02:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so1007271plr.5;
        Thu, 20 Aug 2020 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYibM4nZuHBMrYP+Q/sPj0AQTR+GDwGSAR8Y/NWctnk=;
        b=J2zpdg4uvWkM+AxZfm6F4NSSU7KrAO9vooe6zhVY3WQ5/KmGGxyvYY54Rb3rg/EYX8
         y798g6fKOaO8Rx9Q01R4Z4yHgF+0an2tvli6c9mliT5rDPLgag24HAhFwm08YcdPGd7Y
         798P9ggmz5+t4EfUkeOPRkLInSIdGhD6Rg8RyCyCMpWwtRHyG4q7z4HU4U3YCkIenFlQ
         0mBSydiYdijFFd+kAUxXretwE0eWZM1wKzCtcKjjRwlPR+J6bqM9MRq7YsH6mhS9k08a
         yqN/c4uM0uohxyZSM+eczTOaPCxI6hNUyYN74n8CbbZnVROTLeoI/igA8F5P0HXEpmPz
         VLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYibM4nZuHBMrYP+Q/sPj0AQTR+GDwGSAR8Y/NWctnk=;
        b=G4S/gsT0uNC5G0TOKm+ZBxZ80YZmT0QSBFmWRLuM2X+TDtdFbV6YOOQNEfi7ywjjDi
         R6upGYCb/iePESVzpglyHXROyINhi/abqQo4OApqE1S+7+LgH6addkXNNqIOjL4eisDM
         ZiVW88sJaGXd0VJS0nFhPla9yCK4XnGG2rjyFMt1V5nC4d9FAY05LR3vS/5QUzZq9jQe
         pHQN+641ls/6rnVFwOU/McETwXcm9SFhcMcCShBtmuD49Za3NTtX2RYw1btsCS5Qe2kS
         Z1LAxZXcUEY+pFvqwLzkuyjiHu0LRtTDGoV+FSgtVf24rCgtmMeGDXjRZr4I978SzEEc
         gF2w==
X-Gm-Message-State: AOAM5327OMVRFbnuUodJs+8VYNje78gRECKC7e+SjVgBGLPBUkETrLAE
        /ERDn/8jPoTqDiKIWuN3seRnCMurAfc1E+W4r5g=
X-Google-Smtp-Source: ABdhPJysZ3zNLRNh7Fh/eSimH65C4QeB35o2i3txUoHTbrlpe0FTZauEgc/5qLddcWnTMJJLrYKrGa1hDqwRHo1ux3g=
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr2473285plt.262.1597928537335;
 Thu, 20 Aug 2020 06:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200818153614.6438-1-dts86@cornell.edu>
In-Reply-To: <20200818153614.6438-1-dts86@cornell.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Aug 2020 16:02:01 +0300
Message-ID: <CAHp75VcpyHgmkerPE7OmkM-FyF1YWLH0u1EPQhaTYcuOYj5htQ@mail.gmail.com>
Subject: Re: [PATCH] iio: pulse: Support PWM capture with TI AM3358 eCAP module
To:     Darren Schachter <dts86@cornell.edu>,
        Christopher Hall <christopher.s.hall@intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Matt Porter <mporter@konsulko.com>,
        robertcnelson@beagleboard.org, Drew Fustini <drew@beagleboard.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc: Chris

On Tue, Aug 18, 2020 at 6:37 PM Darren Schachter <dts86@cornell.edu> wrote:
>
> This IIO driver adds support for PWM capture with the TI eCAP module.
> This driver is based on Matt Porter's eCAP driver from January 2014,
> which was never merged into the mainline [1]. Like Matt's code, this
> driver implements interrupt driven triggered buffer capture. However,
> the driver has been updated based on previous suggestions in the IIO
> mailing list. Additionally, support for prescalar control and finer
> polarity control has been included. Users can now configure the
> polarities of CAP1 and CAP2 individually, allowing for the measurement
> of a signal's high-time, low-time, or period.

Chris, does this ring any bell (in terms of certain functionality of
Time-aware GPIO)?




-- 
With Best Regards,
Andy Shevchenko
