Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647BD23F73B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHHK3i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 06:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgHHK3i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 06:29:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8ACC061756;
        Sat,  8 Aug 2020 03:29:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s15so2303840pgc.8;
        Sat, 08 Aug 2020 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMuzX08ks4Pi6hqwcqcEba13N3oB4kmmw049KdwaPL4=;
        b=dDTfHLZ4J0jxeFiQwNhDFbVnurxLUKnHy6N8szRC1dlgXgZurV7wvEpJ300X+AoW5I
         MtjQsTD97x+eILlp2fKp3W8CohdFOzz1BymAPyqTZbkRWWYJSoB10UJq+FXNJqONVE+d
         SBuxhB/J/fDUIzmNFSeDlfDHi6bL2jgw5DGblhxqWeZ6KLTBmQWuMO5j71bGde88ZIrX
         nmqpsqzcO9Tc1ZjQyUCeTWBuxfYDlpjmRMofPeIO6lxYnDPEsx9G0Fu1Z1ZRXdmflRsG
         PBffVyWSuWMtnEW5lZLK0/SeL8C8Y/C6z72OviaU1gxmdQ0hdJ/kMwLBbC0Inp/YyDW6
         hJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMuzX08ks4Pi6hqwcqcEba13N3oB4kmmw049KdwaPL4=;
        b=qTRw54QcP0JWg5R6LnopeeGlFnp24o0D8ZNh1Mqc7s4XoorMH94kc9yzMnAz1GFf5m
         tm43j9KnMunrpBwL+w+1lPncj3W7DpJvdVisdMf94eROVMhdA0XDX03N2i4ruApxxB48
         fQSEE3ceMbpfLz9fFJ/bBsXcJYkwuu3tGhM98gPGSsVVU/vdge1TemJJXXklLHX+zPC7
         Z6opwNSMYqzEyADem0FPRveUO75mXsZrL/O9acd0o7qMvRgZpqcZoDvsouweIAQBvJjA
         yXzRDMdZjacdOPkqJSexL2fOKqy7BTo6w7u7dYKnatRYQLATEbJhZZh1/ulS1+oNsW5n
         KJBw==
X-Gm-Message-State: AOAM533nRB/LhHgCBQZOdvFnHq5LMhAvy5gWycHWKYMfWlTQdDyAjX6G
        dINL+rOE/GSXZOZE1HgRdoZrKSMhtv9yt7hcoZXvpqY4kzM=
X-Google-Smtp-Source: ABdhPJyaC8AY/XBoJwPuplHBsBCpyOhrB/+sdblKonKxa3WSKQJWaZ6gyFbbV28CEVmckRbn5oO2IHrFZRnBKm7wDB8=
X-Received: by 2002:a63:ec18:: with SMTP id j24mr10194559pgh.74.1596882576098;
 Sat, 08 Aug 2020 03:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200807232104.1256119-1-cmo@melexis.com>
In-Reply-To: <20200807232104.1256119-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Aug 2020 13:29:19 +0300
Message-ID: <CAHp75Vfio8RN9XpSPn2jL7WDCitbO0=BfjB85E5edZQs-7OxqQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] iio: temperature: mlx90632: Add extended
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

On Sat, Aug 8, 2020 at 2:22 AM Crt Mori <cmo@melexis.com> wrote:
>
> Since the second patch is dependent on the first and was still not
> merged, I have decided to send them together. First patch just makes
> second one more readable as it splits out the repeated calculation and
> that enables the second patch to tweak the variable to the new
> condition.

Neither here nor in the individual patches I haven't found a changelog.

> Crt Mori (2):
>   iio:temperature:mlx90632: Reduce number of equal calulcations
>   iio:temperature:mlx90632: Adding extended calibration option
>
>  drivers/iio/temperature/mlx90632.c | 233 +++++++++++++++++++++++++++--
>  1 file changed, 223 insertions(+), 10 deletions(-)
>
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
