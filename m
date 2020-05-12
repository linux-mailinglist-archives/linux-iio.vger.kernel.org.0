Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6B1CF0E5
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 11:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgELJDn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 05:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729916AbgELJDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 05:03:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549B7C061A0C
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 02:03:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h4so12715675ljg.12
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odTSOiCuFW0TklzckYCQG6DvBZsnxyimLAqm7OGXvHY=;
        b=Ywl9SCvmKHiY3yhke36DIUNmXVxZ6RZr1xQLCdhcAt85loO8f5QwAB9C3nGM5nD4Qu
         f0R75AM9wTccysNCrLcqDuC5lR4c3X6AOy1hH9gHjmegqRErxUkJkm5OmYYHSO4TvrhB
         PH5idrhfg3BEv7YfjDO+igNoMGDfj2w2J31J7b9pU+c4YPcOITqFzGPcngUw1BfyvrBh
         lM+A+9Q2E444kyAS72sbp8wFRpD5qlv2L/tSZUcCViXCKmjrAq7iWh5h8/mLzBtQOuok
         YMY1uQHfvX5V0PQYVFda7s12RfxtqpZIoduOTEtDPVPNnnxoAO+ZLEcHtC9qf4rtGni3
         OlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odTSOiCuFW0TklzckYCQG6DvBZsnxyimLAqm7OGXvHY=;
        b=Gozw5vyBMvCurtkdKtiD1W972YjqlzG61fmrw9FSKP9nNK1xiUGK50cqLUPxYxBwZ8
         KmhUf3GSpfD5wNfrrOgoX6I9+N/wckXSdga2vpbdWlczn3CW7ijq7qoDlqsq27VNah0b
         1RqIAbAg44vJvs5XLxGJquSdI8Ms2ePBggsfkRSfXOd6RPEmwVafmRUa142QNrO26jXz
         6DrKYPOY7Zu+bLfkyFz6jF4bGLIxCDIoB+CxIW8t5oBqlBjV+euvwd6YqMAVJ8piI8di
         CaoKL87lXXckXP3ir1mTbYPiz7j8J9HUb0kKuVXUT0wf9yvkoRc3Ag/h6UnlKNqizRIY
         yZQg==
X-Gm-Message-State: AOAM532XEMljoA7Ez9D8NmFNR2XbhDnEyZyOhLhfY6BP6TwGycCyZW8M
        LFZwth3HpL05fJcBdpGdM4AsIIxZ/lu9aAyGza/Kjw==
X-Google-Smtp-Source: ABdhPJx6/P82+0XHIa1NIY1LjcUbB3jwhI5ZVx5pNhIaNBB7mCBqt3/s4nMi5LWlq/CfR62xLIDpTHxQXgTayF6LqSY=
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr12786190ljg.258.1589274213796;
 Tue, 12 May 2020 02:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR04MB0660DD24B7B4418DCC2806FBA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
 <BN6PR04MB066041D27D2A70B6B00C4751A3A00@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB066041D27D2A70B6B00C4751A3A00@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 11:03:22 +0200
Message-ID: <CACRpkdZ-uuzjbHz9oXwjkTBO5ss1KcBN2Vth6N6h32zmgYhAUA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: gp2ap002: Take runtime PM reference on
 light read
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 10, 2020 at 5:58 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The light sensor needs the regulators to be enabled which means
> the runtime PM needs to be on.  This only happened when the
> proximity part of the chip was enabled.
>
> As fallout from this change, only report changes to the prox
> state in the interrupt handler when it is explicitly enabled.
>
> Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for missing this!

Yours,
Linus Walleij
