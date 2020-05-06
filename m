Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80A1C70CF
	for <lists+linux-iio@lfdr.de>; Wed,  6 May 2020 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEFMvS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 08:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728131AbgEFMvS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 08:51:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F72C061A10
        for <linux-iio@vger.kernel.org>; Wed,  6 May 2020 05:51:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so2176033ljj.11
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2020 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COqQCzJ4auJxawCeL75BevJEbAnSN1myQOD2Q4QlS6o=;
        b=aUP/Sxk2re3PRk+ECqewTQ+F6wOEpuHPLfG7pOjR67sNQWZCZXm7Pfzn/ZAYrBQSbY
         HVhJOF8T1bwfgCt/z4GB6Ow72DCwp+iAHjSoprUUYF5vtKSY8Cy5Xl4kJdlz2Hn/zH5o
         4C3uG3jkQiChJm4nW6t0LQ5NEH4t3yE246s/ohqdudan45YcDTTSmK71uwDs+nHhvsvW
         Y5igS6gapbGHcIHtefdk9vrArC3GRfr+RqBbTaLOzZxsy1IWVjbepibeT/Lb4UK0thrP
         y5pz35U+/XWr9Bm+eiGtlMLF/XRlRGyQ/eEX64km/9WDAVpPOMdw+gSlGnegG2NrgeXY
         E2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COqQCzJ4auJxawCeL75BevJEbAnSN1myQOD2Q4QlS6o=;
        b=hMpMrTiH7HWRyfTc3g3dzBQJR5UMsY9hWRq1Ve0syHRegM3mNI5Lp2ARapRoBTKp1v
         zXWfHrO+NJvNZvRwBBT+zePJ0R1Y247xXOwUBNwfVGcAvPy6WLAZVGCLjgAmZepSQT93
         8KDok8SF9zSO1xo11+QB6xBUHSRVt9VtKsPZugsDyFsCiQYXPIOQ8UWjTrlAvagp90pT
         Di5v0OE/6yhAXNvuN3b0XNeRBHskZb/WphPeweCz/Td5RqiF41AEwddqsGm6C6nFyOwp
         eBhELGykzqC8TnalHYeOsfrelRf2GGAQidbh2afmxrrwBeQCibXEBttRtAFYTavm9xjY
         P2RQ==
X-Gm-Message-State: AGi0Pub5hwxQ7JWSHnRJKIbme+V4J+TiZ7ZbUKkYlLz75XnWhtfdso0S
        eZuaq/ZQvaDEv9bHkgVCiY2OAq1UAMPBDD8YEOxSGA==
X-Google-Smtp-Source: APiQypImbwPouCSTKAxAbrKj370TdmOTHAg/3XPenrNSIG2xSYlnZPNpgYrCuSMEoTyq02M+FrCmk94OR5vDtNs6eq8=
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr4764927ljg.258.1588769476101;
 Wed, 06 May 2020 05:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200503172206.13782-1-xc-racer2@live.ca> <BN6PR04MB0660C583D9538853C8296398A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB0660C583D9538853C8296398A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 May 2020 14:51:04 +0200
Message-ID: <CACRpkdasEU0ao0OZBoeQ9x5Efe8tFwtpkLMOU_=Xn639anJxbA@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: accel: bma180: Add support for bma023
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma023 chip is similar enough to the bma180 and bma25x that the
> same driver can support all of them.  The biggest differences are
> the lack of a temperature channel and no low power but still working
> mode.
>
> The bma150 is a close relative of the bma023, but it does have a
> temperature channel so support is not added for it.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
