Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867A523F8B4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 22:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHHUEy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 16:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgHHUEx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 16:04:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C36AC061756;
        Sat,  8 Aug 2020 13:04:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so2722620pgl.11;
        Sat, 08 Aug 2020 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JvgM3A3AS88B6CE2Iu3gBSdhU33dVCIZM65D3EoVHxY=;
        b=SbGD0rkx1uJDTMiCBpeKCB/P+vZ82WPSbfb7MgqDBp8nEtGo9Eh0THBRBNwnmGOqyD
         s1ZuFjI3XheWb9s36eAgdjE3QbRiNDs6Z3XkRyA2r307QVx+OPRP0JZk0ZoUJhAiG/kW
         usj22LVY6WNxqjEcEiTS2OVJNX25gsWeWSNsvBVsoYI7scX5QxczkZzT02tAc3ZgJ8Fs
         BLNISdfmTzZYKZr4qxagm+VLlpUBu1N8oq3mK9lkUYH9bbr9c4k3Xle8U4wmbYQ8X+JL
         MNSAnfkZoiSScV7gA0FNVWYL5a0l/LjMHp2aK2BFlF+fhujfc5T5YcESrkVSF7jGtAMf
         E5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvgM3A3AS88B6CE2Iu3gBSdhU33dVCIZM65D3EoVHxY=;
        b=fv9UXyUcc2BF0aWxYiAxnagOjIIkleOTsrHWY4MlBgo0XA14813AUddEyKyAqSXmIh
         U5XwqZZ4BcvkyQ72Cjh1LnC5xjm/fXj/wTQ7/Cpxuh1u4WJD25oNrRFazxNv+1n1WYQS
         pFUzFv7rd7QBdqhhruGvjcv7pj0yqyeY3yni2m/0nZMz8DvuiNNvdIKniNFueX59cbpZ
         x9zmVjriiH5bkK+NgHf3FJwdEur0Qp+6Rnwdl2sxLI/HLBnZRQSiW0gg3XwN2TiaGQWI
         iH16E/QRFmRh0eP3JugPoDlH1FkAJxgRAkJYdAFXqTkFl4LVFLuzmia0tJx/1+i1asKV
         1KoQ==
X-Gm-Message-State: AOAM532/ZzkGgj04dMcj/9wFTe0lHUhkmM91OFhEex4sJ6GTAB9ZfNuF
        T+ARYUiiMx0kXMKrBpHqV4H9DzMMc2stJquhoQk=
X-Google-Smtp-Source: ABdhPJzzcX/C/z6uh/k539yhKugrjvBgaWehO2hdalkJS3xfEoD+ao64eLZdVM3iaV1gVCsFOFdszE2j12pqAtg0cMQ=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr18362478pfc.130.1596917092580;
 Sat, 08 Aug 2020 13:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200808121026.1300375-1-cmo@melexis.com>
In-Reply-To: <20200808121026.1300375-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Aug 2020 23:04:36 +0300
Message-ID: <CAHp75Vf=woP2FLnRX-sGa+5uksXU=g0hbGOxXQwcjRpQQS=7qQ@mail.gmail.com>
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
>
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
