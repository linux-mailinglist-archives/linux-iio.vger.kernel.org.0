Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5C8328072
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 15:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhCAOOO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 09:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbhCAON1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 09:13:27 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F383EC061756;
        Mon,  1 Mar 2021 06:12:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d11so9970036plo.8;
        Mon, 01 Mar 2021 06:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rvtbe24/4pCbrSbJGa1S0S5IZkxAu81Cy/hj2/HLLCg=;
        b=n+w0klHtPenxZA/Kz2OD2SFcBvuJj6780NswXPNENrWEz+6TPgTlnbLIOPp5LwyKHk
         jvY0z4L+pZxaP1U4HrHglO94EQ6Z47F+937fYA8sZfu/V8nIabKWTniZbW58LM03lyAZ
         EDDN1cH3IKrHd+w6n+igj3wyx/154ROXgESSjvpkBpaEBGfDdelCDRnopeMjMALUEsZF
         NQYD+HORTQgxdh3CXlvJTpZP0h5gdRi4tgsWkL63LuVCTa2fdXRvR5QrUHsMpOsPvdG8
         i2/k/Svn3FqlVw8udkVHBUbKg/bwP6CvxT0MgVgIHL8AYH8ldtVkR6ZRkvkqxJbk3feT
         eGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rvtbe24/4pCbrSbJGa1S0S5IZkxAu81Cy/hj2/HLLCg=;
        b=Txs/ttpU1wx12WWqzuMr8we7PEe5OtIho8gdXQRTmSrbUAGsyIf2aF3xl0s/CwV9wd
         7nOT6XSJWXVlp2F8GUFXUrZfuER66mBoMoKFO2ahDyhxgk7VOPduWOi/WEogw5ciLhcP
         G+MIDTtzhz4w89iGVIz4Kr1grUAU8pNutkPb02oeAcwnGLJxnpE8Mzv1+ss5WweN1b6H
         q3IaHaMl/ricCR7POHrOKaExhlDfMeJUxyM7PHJq4UWr/TfRoHZDXkJDkFjptrrvnX1c
         2e0IqdnfW8T0Z+sVac/lHW8JpDpKsx9KtVOma0+ZZMR8vAdSgHXsmXJi7wYaKOAuVWlH
         FbDg==
X-Gm-Message-State: AOAM533scRQNd4g9/4KLfEr2SIiYJ6WSNWk528hngh8HN7DOhhYQvdZt
        HJG5Ojm12WB77pzwcjM/L9sc6Knhj1rKDKOls5U0GEdsEe9o6g==
X-Google-Smtp-Source: ABdhPJxPnN7RkZpSE77Lsn1szHfpSaago2tCmsH7CaVM4PsXwMcCrSprAs76tT/RWTPRvWjOVD2u3O7xhn63pg2cSpU=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr18401612pjx.181.1614607966461;
 Mon, 01 Mar 2021 06:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20210228012643.69944-1-ronald@innovation.ch> <20210228012643.69944-5-ronald@innovation.ch>
In-Reply-To: <20210228012643.69944-5-ronald@innovation.ch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Mar 2021 16:12:30 +0200
Message-ID: <CAHp75Vd13nobdyiUbYoTbeoqG4rGP-Vfswcuuy3oYjXgTXzNSw@mail.gmail.com>
Subject: Re: [PATCH 4/5] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
To:     =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 28, 2021 at 3:30 AM Ronald Tschal=C3=A4r <ronald@innovation.ch>=
 wrote:
>
> The iBridge device provides access to several devices, including:
> - the Touch Bar
> - the iSight webcam
> - the light sensor
> - the fingerprint sensor
>
> This driver provides the core support for managing the iBridge device
> and the access to the underlying devices. In particular, the
> functionality for the touch bar and light sensor is exposed via USB HID
> interfaces, and on devices with the T1 chip one of the HID devices is
> used for both functions. So this driver creates virtual HID devices, one
> per top-level report collection on each HID device (for a total of 3
> virtual HID devices). The sub-drivers then bind to these virtual HID
> devices.
>
> This way the Touch Bar and ALS drivers can be kept in their own modules,
> while at the same time making them look very much like as if they were
> connected to the real HID devices. And those drivers then work (mostly)
> without further changes on MacBooks with the T2 chip that don't need
> this driver.

Thanks for the contribution.
Before I'll do a full review, two concerns:
 - don't do ACPI drivers, please, in the new code. Use platform driver
infrastructure for that
 - dependencies (see below)

...

> +config HID_APPLE_IBRIDGE
> +       tristate "Apple iBridge"

> +       depends on ACPI
> +       depends on USB_HID

> +       depends on X86 || COMPILE_TEST

I haven't found anything ACPI specific there, so this should be rather

depends on (X86 && ACPI) || COMPILE_TEST

> +       imply HID_SENSOR_HUB
> +       imply HID_SENSOR_ALS
> +       help
> +         This module provides the core support for the Apple T1 chip fou=
nd
> +         on 2016 and 2017 MacBookPro's, also known as the iBridge. The d=
rivers
> +         for the Touch Bar (apple-touchbar) and light sensor (hid-sensor=
-hub
> +         and hid-sensor-als) need to be enabled separately.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called apple-ibridge.

--=20
With Best Regards,
Andy Shevchenko
