Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1423F8B6
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHHUHM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 16:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgHHUHL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 16:07:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A98C061756;
        Sat,  8 Aug 2020 13:07:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f10so2785340plj.8;
        Sat, 08 Aug 2020 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiCenb5vX6dJuKnVeIHYtfpTZiB8QcQyZGTetv9DPOc=;
        b=lFVDLSY7VsBKcLcjFlyRYW5BGeOL+Sx4ZFqlgN3tH75pBxcn+6zjnmCxNhGfVYhYuE
         Sr1pnCzIyrdU24BuU6L+Vdd0mCqiHjsWx+wEADZL5IkjwUVUnfMIcyrGs+XNAsx63Nn/
         kJZBiuZn7mBL28Sn3Hq06N4T59tBRosqBV+e06ndqfCJUY+wpsQvrOcRUALYbXkVTRPt
         i7pUntfcoD2C8s1STFqKDr937fzT/T1GWAwFyrIX5pLoRjqwMsjxIPbAUGZRx04vWOtZ
         e2WuRXOr81EgWc7Y2Dm8FiIlI5Kq2stZ79hmF3bDEQZC6Dzf/2s7MvwxgWFwXo3uCMvD
         h3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiCenb5vX6dJuKnVeIHYtfpTZiB8QcQyZGTetv9DPOc=;
        b=jKH2l7EDmNsvfWCDpVwO/qO9bR2eiOxBTPou0mRSuFgaASYZTllI+3731XThv/Fhz8
         e0RgVOEQA1Deti/FE1fJ6cP4oGGDRSZ/xj2YfbGtcdqXes02FgeIT+AZVZUyP+YpVuPS
         3qnJnvUotKNzB6VndiqpUT30hrckjY0a4ScvmQwxul2O08kcsQm/4byqudicaYP4GJa3
         WLxi+OMi+EoWSB/S0VMAyfD3Eqq7TN1UOyjV+U+Jdg3/8tYWMPHqCECkVfHCxSgT9Tgl
         8pL2/S6tOCmTLvLYVs8Jyh+kinghIyjTcwxI7n+vsVXrbA0cLzPloEYlksbZBl5ZINk6
         AhpQ==
X-Gm-Message-State: AOAM533jo6FGJEQ2Y7B4JlCHNH0FzORj3GfjCe8vIVoXEGCrjz5kreG6
        RR1AgswVcMiCIlcklwfri4vPWgJ3BWYul9py88g=
X-Google-Smtp-Source: ABdhPJx3m3z8wLpeaUy6bo8RBwuhpiSY+3pnNM2wrC+7RR+7r+qCmBiLSKNdfzMCnAjiOa+z/Qs/lEcLuwFT4pzD3sU=
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr18475941pla.18.1596917229824;
 Sat, 08 Aug 2020 13:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200808121026.1300375-1-cmo@melexis.com>
In-Reply-To: <20200808121026.1300375-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Aug 2020 23:06:53 +0300
Message-ID: <CAHp75VeY9MgqenaCDJww4m+T6fpYeaGgPr8QXCYLxyx36BHnJg@mail.gmail.com>
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

So, we are closer, but here is one remark, it's not good to send a new
version if you are not going to address _all_ comments (it's fine to
do, but you need to answer first why you are not going to satisfy
them). For example, explicit castings here and there, voodoo
arithmetics is left uncommented.


-- 
With Best Regards,
Andy Shevchenko
