Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE7372F1B
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 19:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhEDRqI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhEDRqG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 13:46:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3751EC061574;
        Tue,  4 May 2021 10:45:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m190so729539pga.2;
        Tue, 04 May 2021 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yo7iw/aOz/NRIIOLGrRcbviwePUzqQyKeSCxTrIBDSA=;
        b=s9kZKJQ0EX2XEBDiKCiHe/tx/6DdPMkLPgBpQ0v7zdYKSt5EkUTPbLtO4EdewOzSUi
         JPFYPmUM3tTbAPfUQwl8A69LUH+cA45K7111OG8NLvSeb25J3AXficDMu5HzhjszfQrN
         Z175wzysVHTZoyIaicrAFlRi64Y4V+NME/GxdPsG4BuZblBU9oJrCI23BnvNpRax204m
         s9dY36ARQCAcK4i7Y/CzygVTQVe7UsvNg81m7IgcpM5APGZXdF9Bt8rgNMucFOFPuw6E
         HGMxy8s0bYpA6YbGNt957JKn0ow8pjgHTZGO/LIk/Z7OLe2B/mSVtO7tiKcEeX/qSWq5
         q0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yo7iw/aOz/NRIIOLGrRcbviwePUzqQyKeSCxTrIBDSA=;
        b=pN3cLR/TX3e30ro5XZvc0GWgj7oEqKS2u6VGtZCuk/boOa0GWKvg7qtkcZt1vb4hSQ
         xG1ytC1RIUfrTE1JWicvxPSh1piqO1D3CvnIjq4tB7GzrWzSB6xJLEoe8OaY3oIx4sYP
         Gla0yTdR2qeNkqtZko5uuhkPwRPjMjTSCHkWCD6S1pU1tkyc8R5ItSkQzaX9C/bRhx5Z
         tB4SDFFca1zMe3P/sMD8YIwXkthmRwpNuiaHq0AJn779Wmcf9rPZUrdzsT04xBS7wfe+
         DNTFoTVOeg02oOQWoWFDBL+TO7koCQfIVKEqdYuoHwH3nOZV3IeeXYZ97iMd49mTpQYP
         AV2Q==
X-Gm-Message-State: AOAM532NAD/FzE+sbXRZFLiCZKkob3rgzF2fZkG1wkLTJgJsFHDMYQwO
        mwruRUKjTwa8PH67YJtheMr4W1Lo14qJAEfZlhSGOv/Gi6s=
X-Google-Smtp-Source: ABdhPJxRFqwJvhMUxW497JMgtWx24glCVWVYae5KEibChdvkqAAuRGZENQaEDjyOx2ICja5ai3Wyrn8/bs2EcnxrN3A=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr6769684pjr.181.1620150309791;
 Tue, 04 May 2021 10:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210504174019.2134652-1-linux@roeck-us.net>
In-Reply-To: <20210504174019.2134652-1-linux@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 20:44:53 +0300
Message-ID: <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on CONFIG_ACPI
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 4, 2021 at 8:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With CONFIG_ACPI=n and -Werror, 0-day reports:
>
> drivers/iio/chemical/bme680_i2c.c:46:36: error:
>         'bme680_acpi_match' defined but not used

> Given the other patch, question of course is if this ACPI ID
> is real. A Google search suggests that this might not be the case.
> Should we remove it as well ? STK8312 has the same problem.

For this one definitely removal. Looking into the code it suggests a
cargo cult taken that time by a few contributors to invent fake ACPI
IDs while submitting new drivers.
Feel free to add my tag or if you wish me I'll add it explicitly.

-- 
With Best Regards,
Andy Shevchenko
