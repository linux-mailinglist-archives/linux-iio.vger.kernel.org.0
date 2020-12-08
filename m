Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B159B2D3638
	for <lists+linux-iio@lfdr.de>; Tue,  8 Dec 2020 23:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgLHWZo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Dec 2020 17:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730781AbgLHWZo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2020 17:25:44 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D9AC061793
        for <linux-iio@vger.kernel.org>; Tue,  8 Dec 2020 14:25:03 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id f29so3874712uab.0
        for <linux-iio@vger.kernel.org>; Tue, 08 Dec 2020 14:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxYYdD625aASAaVaKZf+ek64hWUOmEA30M0W7p5diOs=;
        b=PWCPTPXdf9qzkpa8lQrpH0dg+cA2CjB8tVpfj3R15FX88qylOFpgSJt6UiRye6R/Xi
         aLLzYbaTq8/LqfFulq/ntwHbHeb7wmAAEBKarvhDc+O1d2rO6Ue+8tP6oQT+UyHlyE2i
         UnZP7lb07czgcJmcm1C5mfNG8xfH9K7FwigtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxYYdD625aASAaVaKZf+ek64hWUOmEA30M0W7p5diOs=;
        b=aLdcpL9f926FaAiv06qyy9CWB4Qc2/AcYIPxU+evj5uxtz0CFb54UdDNtX64DYkj+N
         EcdjMr4ejMDfjwQfqcccK8qPqk4iQKIyb64B/qKWOuHrvQbT7dV1RhY3TRZwlbYnVbXy
         0KRJjPu10Hn1r4e8Ih8183M/ZmQwhwVV+oBE5V8vtg9rAmxBBg0m5wJxrH45UgCiQwbv
         UgStMnehG3ggGFbRQNo1mGn2NG4u0MRDF+0ytCI1fe4T7m7D5vb4qz3ik3evoMAwKrQj
         AMYEglo2P38Uy2hHS7ntJF/3Asyt4bM1FtXTWEFdbJ60tKjSmbVEG+MiPoJo8p2Htgc6
         GGLA==
X-Gm-Message-State: AOAM532iw9SeyoZT+WDFjSiDpRghsEvU2y6Hc60t2DT/sqKE8kBUWLJn
        ZetmTOHdPhA08XyBgA72+eVskntU7j5ADA==
X-Google-Smtp-Source: ABdhPJzQS9YK5V4grNWuwR2o8CtC3PU5yRx2AuhiaTxzS8T+DL8vPdmR08pkQbQe3K1aLELRk0D5CQ==
X-Received: by 2002:ab0:1d17:: with SMTP id j23mr18004705uak.88.1607466302811;
        Tue, 08 Dec 2020 14:25:02 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id q23sm3322vsm.27.2020.12.08.14.25.01
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 14:25:01 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id w190so62339vkg.13
        for <linux-iio@vger.kernel.org>; Tue, 08 Dec 2020 14:25:01 -0800 (PST)
X-Received: by 2002:a1f:3fc9:: with SMTP id m192mr214325vka.17.1607466301140;
 Tue, 08 Dec 2020 14:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20201202200252.986230-1-swboyd@chromium.org>
In-Reply-To: <20201202200252.986230-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Dec 2020 14:24:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VQ5GxedWDm6cFfTirEFCS2Mmb--Ey8s_cnSyPSE3MPmA@mail.gmail.com>
Message-ID: <CAD=FV=VQ5GxedWDm6cFfTirEFCS2Mmb--Ey8s_cnSyPSE3MPmA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: sx9310: Fix semtech,avg-pos-strength setting when
 > 16
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Wed, Dec 2, 2020 at 12:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This DT property can be 0, 16, and then 64, but not 32. The math here
> doesn't recognize this slight bump in the power of 2 numbers and
> translates a DT property of 64 into the register value '3' when it
> really should be '2'. Fix it by subtracting one more if the number being
> translated is larger than 31. Also use clamp() because we're here.
>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v2 (https://lore.kernel.org/r/20201120182944.543428-1-swboyd@chromium.org):
>  * Use clamp()
>  * Add comment to clarify
>
> Changes from v1 (https://lore.kernel.org/r/20201120073842.3232458-1-swboyd@chromium.org):
>  * Changed ternary to consider 17 to 31 as the same as 16
>
>  drivers/iio/proximity/sx9310.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
