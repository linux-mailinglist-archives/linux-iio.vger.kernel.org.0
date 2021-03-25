Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E8349452
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhCYOjw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 10:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhCYOj1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 10:39:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F004C06174A
        for <linux-iio@vger.kernel.org>; Thu, 25 Mar 2021 07:39:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u4so3420365ljo.6
        for <linux-iio@vger.kernel.org>; Thu, 25 Mar 2021 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZ7ZzQQzyPlczHBmxaJxZ5vob8Jfx7hgf3DESGzmQyU=;
        b=z0OHkd4UiI7o8JBWrSJeTrBV7UjoGwBTTvUy4a6MrvILfyrui2hjPpdA1RCwZpmNWt
         VEPu8b2HFfy0vf/tYBotCDjCE6Zf+EKKmIGKhxoSjRSoJMq6gV7M+4GrQ9g8qstm7rmf
         oepWvv3SYFddtRcF88P/qgYI6NMqbJX2RYsMlRXgf+/yyHodP+bAn721HGdMrpRtykvt
         fvJVRUCVcmjr37Yv02pLDjH5vW7skcc6em50NKr0HI4g8xfqn56sY9w7q+WNYdf/DDnU
         iOg9NJ5dur0teCx2BgN8Qjn0fWWvztbVd7XioVTtbsRm7Ld3SGK8afCFOTe/MWX/GQbF
         uKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZ7ZzQQzyPlczHBmxaJxZ5vob8Jfx7hgf3DESGzmQyU=;
        b=gBM9HOuDuwZ/euzMTCRCiDnFma8Nz7Z8JSAA7PqGe502obnWa2GmZE8XxJXsVzS6bg
         I4Zw9Z0mn8h2IlL3GRUgrk0CbaaLHYe0Ba1SgV3JcgqhEX8rOpkb4g+mWuyq5VH546Gc
         P3D2A8zg794IFOhccS7GnkbAOvGuNyr6QfnrNwR1O1gYVlLsjLKnX5/v4MGi3NVrt3dc
         X1YNzdBogR3ooFtlMrs+OVClzCRxRsRFW8WpQDrXjaZWTFCiFjxguHZeYKGINFPPAUZe
         D8sqEhbMXBU+ED3jRzVH+WQYQSXYYcY0fEbESIeDFzdvagPtbatVSPrFMTxcuZEeIwXI
         MBHg==
X-Gm-Message-State: AOAM531i8u3m+Jjt5OENESy3PsK8TIdCevg1yX1fce0Ft690oP53YtiA
        qNcnAIbRhWuIEDBquZdqd3dgJhrbtehaElpYW+8rjA==
X-Google-Smtp-Source: ABdhPJxw5xJERp/kEKDXN27ixH0XtE0/BLkg18PhAdrYmZA91ByCzpKkGE4/bi9SgTbntyc6Cx3mlU/cNTBLpBi2PUo=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr6185505ljw.74.1616683164343;
 Thu, 25 Mar 2021 07:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210325131046.13383-1-lars@metafoo.de> <20210325131046.13383-2-lars@metafoo.de>
In-Reply-To: <20210325131046.13383-2-lars@metafoo.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 15:39:13 +0100
Message-ID: <CACRpkdYbdWsDUtLD2=R1-CPC0zUE7=roKWwEm-8+CfbpnnWByg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: inv_mpu6050: Make interrupt optional
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 25, 2021 at 2:11 PM Lars-Peter Clausen <lars@metafoo.de> wrote:

> The inv_mpu6050 driver requires an interrupt for buffered capture. But non
> buffered reading for measurements works just fine without an interrupt
> connected.
>
> Make the interrupt optional to support this case.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> -       result = inv_mpu6050_probe_trigger(indio_dev, irq_type);
> -       if (result) {
> -               dev_err(dev, "trigger probe fail %d\n", result);
> -               return result;
(...)
> +               /*
> +                * The driver currently only supports buffered capture with its
> +                * own trigger. So no IRQ, no trigger, no buffer
> +                */

I bet it can be made to work with e.g. a hrtimer trigger quite easily since we
support raw reading?

Yours,
Linus Walleij
