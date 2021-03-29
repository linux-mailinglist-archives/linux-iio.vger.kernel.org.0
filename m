Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF64A34C4BC
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhC2HS7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 03:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhC2HSo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 03:18:44 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739D9C061574;
        Mon, 29 Mar 2021 00:18:44 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r17so4271852ilt.0;
        Mon, 29 Mar 2021 00:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipGIX5vIwXmNlWMmQnWuyNW0ntYcVKs6pD8ajiwAnug=;
        b=XyZL/W8VaxFDzjFLaaYW/fQo+48ztvKqEBg+KJxrYfBdVANhaJ1U3TLOtlYswRQkap
         1lFPil6jY9ZwtJ8qKXZ0AcTcsVOpByWh2kz7E/BcqFWe7/mkw3uOMGgGnqbE0dCsugaZ
         248C5uWfZJAcfMnGGkS1Vf/H6ARTbkOnYnNSyHOdC9TxblQ5cUj8qF0I66wSl6CBQnuh
         e4sV05K0uGcVI0jJ5OsMxNaHBaIYDAWAd7X7i2YWm+VyIpySXjm42YueJxQDKvSOMPJn
         yuUFAKlp2UB1qx9owUfcR4Gdt56qzzbkkfQP3LkszC879mU9WdQSFGA/loe/Klt+JCbW
         Gx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipGIX5vIwXmNlWMmQnWuyNW0ntYcVKs6pD8ajiwAnug=;
        b=GjV3cewFIio2XYL6zBd6Kh2u2gyyIfzCZQNbqlKtk/Hkri6JSEhJxbhsygld4Vl2LC
         FTtpN8c87vitGhqvuKYSTxqojaLIQWMs5Nl3xG8FA87UNl7dqRPKcFzo1MWzmSZ2oFWL
         2YkXDL1P9ADfAxcBwzteXIxzY6sSvZixOVRqjCSggcgriFxd1oiRFq5qL9SYJSWiM6W5
         y9nWbqCjguVMgqoDpJ4jqlAJDlXE3IgxbTzjAAswKHqqgyJJFPX1CaPSi9coBiLvv8FO
         MWk3xNFzKimUvRE4qzHA7+PyqiTy8H4V3rE/LLI3p6gSEw186PVwRcz6JBAc1guGrX5P
         8cZQ==
X-Gm-Message-State: AOAM533a3/tLo54Vp/JLtze1751SbDrzAptsRvZGuPRyu+rZiQ8SJRbP
        LsFoS0wJdydPzxkIUjovBCkU2ys1ze5ERNGyGFGfMhF+qmFoUA==
X-Google-Smtp-Source: ABdhPJxgoEy+504UKzc83Pshb0sd4GwTxbG1/5jJB/P/wMWiVbHYiQiSccfdpfpCm+G/V2KxS41eSBOAm9n5Nr5g37o=
X-Received: by 2002:a92:194c:: with SMTP id e12mr19805012ilm.292.1617002323859;
 Mon, 29 Mar 2021 00:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616966903.git.lucas.p.stankus@gmail.com>
In-Reply-To: <cover.1616966903.git.lucas.p.stankus@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 29 Mar 2021 10:18:32 +0300
Message-ID: <CA+U=DsqOq2ZYRTy-VG-N-5fb_9TY6RNa4KM1uVdQb6eW-6VH6w@mail.gmail.com>
Subject: Re: [PATCH 0/3] iio: adc: ad7923: convert driver resources routines
 to device-managed counterparts
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 29, 2021 at 12:48 AM Lucas Stankus
<lucas.p.stankus@gmail.com> wrote:
>
> Following the initiative proposed by Alexandru, this patch series aims
> to convert the ad7923 to use only device-managed routines.
>

This idea is becoming popular it seems :)

Thanks to Lars for pointing out that spi_set_drvdata() omission.
With that fixed:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

If you want, you can also search for more of these xxx_set_drvdata() omissions.
There were more conversions to devm_ that forgot to remove those.
Maybe a cocci script would be nice to find them.
But all this is optional. Only if you want.

> Part of the driver was already using devm_ functions, so it was possible
> to convert the remainder of it without much hassle.
>
> With that, the deregistration function was no longer necessary and could
> be entirely removed from the driver.
>
> Lucas Stankus (3):
>   iio: adc: ad7923: use devm_add_action_or_reset for regulator disable
>   iio: adc: ad7923: use device-managed function for triggered buffer
>   iio: adc: ad7923: register device with devm_iio_device_register
>
>  drivers/iio/adc/ad7923.c | 39 +++++++++++++--------------------------
>  1 file changed, 13 insertions(+), 26 deletions(-)
>
> --
> 2.31.0
>
