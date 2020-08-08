Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C960B23F8A9
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHHTzO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHHTzK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 15:55:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D25C061756;
        Sat,  8 Aug 2020 12:55:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so2952925pfh.3;
        Sat, 08 Aug 2020 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aq5q4maU/NLtfclnBFmbWH/OrAD69Y8LSZb+oLjIpWs=;
        b=CCWMCkuZwaAGuNIPNivrorME0Q34cTVkhlc8e0dlNGtDIP7rtgw7D8UQ/W20lWaaRf
         SoYuth/SEBLeKu2T6CBF2Ls/AwVpZsBE03mzRoZkFpGfV4zxWl3+gdT8c7D7nUeaBWHi
         N1/zlpmzjLxckFN6dq/37cwgGMffbSaV0PbDouSmFMyz7gL0By3tim/ZT0ZgttrBDkIy
         zWJk3xo+5qazqK6SwpEf0CVfRmWi9K9q6C2abB7yhQagrWNCH6eEgselGbInMIx2Gph3
         EMpfjna3GJXF1jgncyLD+hCkr13UpAjF0rGPsGt+9KvuSviO4O7MK+8V910i1GRqkDSd
         B7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aq5q4maU/NLtfclnBFmbWH/OrAD69Y8LSZb+oLjIpWs=;
        b=AYIr+8Ycq3zYfc0nz9MdTpboDFMUm4RYQ+q2tB/NrGJkmPVSAcAn3gru4mBSIoBRhr
         sY+P/UPxHoQsUX2OGiVRQHTUaO2LiTONgidEttIy86bEefuyBytYpCcsI/g8AOQpM+sI
         XCgNGPiNnnF5I1fu7G25XTXGwKUwb4u9M38YqShRW5Lb4obQkKJqwaaufcjEl/mdXQ/9
         /atBGXfjZmEKLTPUTCAT+9eavpU2ffa7dBoB7C+GlWjC/wn6Z2gAQWE+ng3lgNPlyNoH
         K4O13yJ/Go6rP1Htvyv8wBDGQ1hbzxopyjJ2p2Wxtkf93XMMziOmAA84GIAxzTDe8Zbj
         q/pQ==
X-Gm-Message-State: AOAM531uQI1l0pswvwy3gjR+vS03kOfP4uXFDhauqseOgdA/gVWywNHZ
        YF3o3LmHsnIyhYP39iRXdKHBd4msoabkZIvZRpM=
X-Google-Smtp-Source: ABdhPJwPC5PepGdr+I2mwacfp3XHhDfPfMUciu4i9uKRM7ywcWp8LfC2HYIUl5jcdeqk6rDg4AP0WA4cnMdwqeRlRZE=
X-Received: by 2002:a63:ec18:: with SMTP id j24mr11582805pgh.74.1596916508144;
 Sat, 08 Aug 2020 12:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200808121026.1300375-1-cmo@melexis.com> <20200808121026.1300375-4-cmo@melexis.com>
In-Reply-To: <20200808121026.1300375-4-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Aug 2020 22:54:51 +0300
Message-ID: <CAHp75VdSpmWwq-zSztw-yG0hDr+N2jzPdzutuieMrMoFDoXC-g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] iio:temperature:mlx90632: Add kerneldoc to the
 internal struct
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 8, 2020 at 3:11 PM Crt Mori <cmo@melexis.com> wrote:
>
> Document internal/private struct for mlx90632 device.

Thanks. The only issue with it is that it should go before the one
that adds member(s) to the struct.


-- 
With Best Regards,
Andy Shevchenko
