Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA712E2C8C
	for <lists+linux-iio@lfdr.de>; Sat, 26 Dec 2020 00:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgLYXCn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Dec 2020 18:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgLYXCn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Dec 2020 18:02:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A001C0613C1
        for <linux-iio@vger.kernel.org>; Fri, 25 Dec 2020 15:02:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h22so11978505lfu.2
        for <linux-iio@vger.kernel.org>; Fri, 25 Dec 2020 15:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7kgYUPj5wyVPSjt7NtTM40G6jAIhR4GN3Ie87rla5k=;
        b=vaUTs5BujakkEV4Lxkldz/infgxH0RkRWSeL+vctTx9AvRHZdJJUBNb0FJntwIRlb1
         K9zjqHFLyJe8Hj3WwhDi8tli7mUx6agsQVqrXAfKK4PZGF1i751snasvzJXrjRtP3N+j
         +VGRnIGEQo8dx2DgKml6s6YsYld79dV+er/jUncSAJ/OXjNFBUZnLoFcoFHWEAamI3TG
         +/Vk7Nb9Llk1ki//kL0PrtmURbhJqkxrGMPiuDgs7mAttgRXzkV8mGN/ZnLw+SiswG+l
         xuH2/1tJteQ22fqt03TG6F87p01HEYuKMUiutCDu6yeFBHC0/gpTMvWifjTGiIWpGaij
         RrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7kgYUPj5wyVPSjt7NtTM40G6jAIhR4GN3Ie87rla5k=;
        b=ErMtJjmQ2C8oWUAhLdPk4c50OC3FChQ0P7cwxvySLy3Hxxu0Wo+31wXyZrDxtVUKTb
         oBZfz0lArccwSCRJgACdt50h0zBhekAnL4gnX/F0O8ZawsEWz+BdZQUHHRM9ySjrLLVX
         HZ+scpR3mbqovYlxe3OsHMKw2VmVKVk+FgJB4SmZYGieJNLmt+o/L6qefGIvgvkfttO6
         TeYqORb6FCYMeQ6sC6uVpSMkSIFn2LJEwuYxVU4H6LRrO+P/YHI/7IpZPPWzytKJpPvH
         FIYqmKOzvCoANYMvdwupA6R6RWaUm8TTrZ4jlAd5ebpqPWZ/ZK+h5pBi+4sLi3l1TW/v
         hwQA==
X-Gm-Message-State: AOAM531/itVdVNKJl2LhVWglOwMDJAdRxQbmQ88GKtl5jL+M+nugNKRf
        DBif1uExi8ejo82kX8Tx4d6mxQJGgKp/ZbDqQ06nzQ==
X-Google-Smtp-Source: ABdhPJwoHbDlFdgOO0TTuX060NKMOOgybjhfodifrEyR6nOxde9rkAKHRfgO3UMuJ0OvY3hKSbtY+qNvffZImBepJb4=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr17406796ljo.368.1608937320775;
 Fri, 25 Dec 2020 15:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20201224011607.1059534-1-linus.walleij@linaro.org>
 <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <SN6PR08MB55657ED2F83CE43C97C9C1749ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB55657ED2F83CE43C97C9C1749ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Dec 2020 00:01:49 +0100
Message-ID: <CACRpkdbEcxkjLb-zJDui6bq2=OQA=v5-OG_6P0svX48AUMLyEA@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
To:     Chris Lesiak <chris.lesiak@licor.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 24, 2020 at 4:15 AM Chris Lesiak <chris.lesiak@licor.com> wrote:

> A closer reading of the "iio: inkern: pass through raw values if no scaling"
> commit leads me to believe that even when the sensor provides no scale,
> the returned value is expected to be in the correct units.
>
> If that is true, there was a bug in the commit.
> It failed to apply the caller supplied scale that ntc_thermistor.c relies on
> to convert from milliVolts to microVolts.
>
> Linus, would this change address your original problem?
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index fe30bcb6a57b..79787474d511 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -587,7 +587,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>                  * Just pass raw values as processed if no scaling is
>                  * available.
>                  */
> -               *processed = raw;
> +               *processed = raw * scale;
>                 return 0;
>         }

I do not think the raw values have any obligation to be in
e.g. millivolts. They may be, by chance.

In my case, it is just an unscaled byte [0..255].

So it unfortunately does not solve my problem, because in my driver,
that does not support scaling, the result will be the raw value
* 1000 which is not going to be microvolts at all, because the
raw values are not millivolts, rather a value 0..255.

However if I used the processed values, the value will be
adjusted non-linearly to millivolts.

Yours,
Linus Walleij
