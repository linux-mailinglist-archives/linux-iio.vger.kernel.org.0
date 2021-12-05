Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB8468BB8
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 16:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhLEPTq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 10:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbhLEPTp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 10:19:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C73C061751
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 07:16:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so32153137edb.8
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 07:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biZhnp3XdL68I6yaGq05ZVDNV9ONpZFBClEymdRxUTI=;
        b=dY7BD+09ubgR/RSJm2Q5msO4ce5G5du0CgRZcDLQKGcJIXaJGnn+rfDKN2FAY1sh7Z
         NV3DsafVLa2lUAN0Ex2eQ/FJi5yjwu4vEm1yfQLlVzWdTIHBeE8zV9ZebVjTldpSwYdt
         eVZmulwe0hbx8Iq+dTAvpVEhcQSCqdRZVO2WBz4RPEk5NIwy6z9f2nHYyTITnG3MbzQk
         EM4WcfQvgYP4i3hp+Dtk4Q0CGEZPzjPY3YyNeQdV6hk992zip5b1Gmnkzf4koxuZt22E
         qw6rWRmrT+bG/dQqQRdEmU6wLPSYm7hgW6frZe+cLsHyJTtApc5Y5xOhbqCVIuqXND81
         PWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biZhnp3XdL68I6yaGq05ZVDNV9ONpZFBClEymdRxUTI=;
        b=zNzr9oWNmPcOqEpmBNuxL+v5poy86IhFmpIlSbya3myR2ZJFs4A5XhjWcCTZEc7Dhm
         ohwVIHegcvl1Ov99o3mvANy0OOhW+iU/ZqxT8Q0P4xstfAh/I8xWLjSbGfz9tV8d+L+w
         EeC9Am7B1HMtj/ZQW0bByEfaR/213CPrcsH0Jk4smNBIwtQbqqQ3hwFAXYoad/ma4NYZ
         xWpajfOgPazmVYqJfkctdPCg7sarTfrdiAoDvKDz8gJxAcgS9OrclYk5fnA8vjUY3dSX
         T28QBf8gHBVe7FUkDLatbj8JYBkZyPtrpFg4TmwN0QWrVDjA5ltR2hK3sbH+xDbQh29r
         63XQ==
X-Gm-Message-State: AOAM53025gg7AR5vOSHZMTCG2cVHs5R1hy6UbrIPnJ66hhcB2BpNjLz7
        fh/rUSSekdyuuCSqpr42u84ZtCbqAipSGg6A8hCuQBnR+MuaoA==
X-Google-Smtp-Source: ABdhPJwUoz3vj0QIdOsGdz1TwQEishsLsFZQ1ZfDBLoxPwwW6MBeycIt2++DG7NlpC5N6K9CFT7xDSVfvw1IEO0MuDA=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr37992102ejq.567.1638717377187;
 Sun, 05 Dec 2021 07:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20211204171237.2769210-1-jic23@kernel.org> <20211204171237.2769210-13-jic23@kernel.org>
In-Reply-To: <20211204171237.2769210-13-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 17:15:41 +0200
Message-ID: <CAHp75Ve6TM2+-3eAx-QOBg0CjQ7A7VcHApPPpA8mkEZjbSAnRg@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] iio:adc/dac:Kconfig: Update to drop OF dependencies.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 4, 2021 at 7:08 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> We could probably drop a lot more of these, but for now this removes
> unnecessary restrictions on stand alone ADC devices.

Ah, I was expecting to see this on per driver conversion change.
Is this simply dependencies which are not covered anyhow by the
previous 11 patches in the series?

-- 
With Best Regards,
Andy Shevchenko
