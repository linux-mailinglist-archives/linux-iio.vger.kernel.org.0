Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E664871B7
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jan 2022 05:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbiAGEOR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jan 2022 23:14:17 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:32808
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346021AbiAGEOQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jan 2022 23:14:16 -0500
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F1E553F225
        for <linux-iio@vger.kernel.org>; Fri,  7 Jan 2022 04:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641528855;
        bh=KN7zr37vFNHmq3As7p02jWEskyOVas7n+GBnbQV3xBM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fYK4teS+CJ4Yp0rLxtCVz7X4DrN0k2vyrJUY94JdKaq+mSdzdA7M94TTw6/gzJW4h
         POBDSvZj86xeFHBqK8bkBxS/X4u6XucZbWZGci+0jDNzZt5oDfH5bGTGSP1gLw7UBd
         GftyjmGhEqwDu1m+Qs+4B8fwBewdkCP7ymlfQrQr8njQKe/561euPOHWoVvrGmEKSD
         5st0hgf1mLwcz5I7baX8hFbN5SnVWNblJDw5vZDn40uklRD7d74dJ18DNvuih41HPB
         shpwBydcFc7+X26wJLxuccUwO9/aCQ1sGHFnRZR+HqBtQFAf7V/QZjZeP8kU3q9BxP
         WS8tgUpnnZ8tg==
Received: by mail-oo1-f69.google.com with SMTP id s14-20020a4aa54e000000b002db004adebdso2806654oom.4
        for <linux-iio@vger.kernel.org>; Thu, 06 Jan 2022 20:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KN7zr37vFNHmq3As7p02jWEskyOVas7n+GBnbQV3xBM=;
        b=UeKaYo036cInYeBCTyckzACN8VPsWaXFJiIiIRrGoql5S3PhxFc8S+gydcrzESFk1a
         Ube4AMqn7Zr1MOXMFan11SA+1tmMny3hNatbI6t5tgixpjRz+BVoKwzOQ53Y/j/Jrfbp
         jS6HrfQGpPdCOV3NCnG7vj4J3dExmwxKu3xWDkPrBulsyS9Qw/yHVoMsX3CT1RVDqWZD
         fOhfQMqE51rziiK8Xt4m3EbIBPYtMYFWjGj3V3g9DiHzl87QbtBBEainnH8cpZaIjm8F
         7hWmkL9n7/8D6F80Y6YkieWoJesZtXKr1b77xavwmvuY09X7YIkkyPbxf+bH7RLJIW4G
         RzEQ==
X-Gm-Message-State: AOAM532kR2GsMrXAY6cbhxBvtTvwx2jE4MqWGg/ZawNd19DOKMf6uvkB
        kmqFizoAA0uUPI8YD3tqvGKrEbYeB7s+ik676VBshD5b6xiTtfiQhRt3u7mnCdLrvxBP4/LD+sb
        cbpqKQC3M36sND7QR9FtIi3bB6YI0ZsO1+8VPr0zO0A0znAKPe5QyIQ==
X-Received: by 2002:a9d:6e8d:: with SMTP id a13mr3325107otr.269.1641528854877;
        Thu, 06 Jan 2022 20:14:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXyFaB7Xi1kpQZoP4YuMgov2PjKuP7iY/5uQwXAbieQMuxBCtvmJXJocnDAGSO2UZ5hq8oOuPWkcbUdahDf4o=
X-Received: by 2002:a9d:6e8d:: with SMTP id a13mr3325099otr.269.1641528854653;
 Thu, 06 Jan 2022 20:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20220106041257.927664-1-kai.heng.feng@canonical.com> <CAHp75VdxV+4_yxJv1H1MZPpu02e2gHUkP55dduUqN7QJ2j6aGg@mail.gmail.com>
In-Reply-To: <CAHp75VdxV+4_yxJv1H1MZPpu02e2gHUkP55dduUqN7QJ2j6aGg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 7 Jan 2022 12:14:03 +0800
Message-ID: <CAAd53p4nUDtuVmkFCqv2R1KEvGYQyLu+ibxJOsoUZs-SM6LuHw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: humidity: hdc100x: Add ACPI HID table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 6, 2022 at 10:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jan 6, 2022 at 6:13 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > x86 boards may use ACPI HID "TXN1010" to for hdc100x device.
>
> to for --> for the

Will correct it.

>
> > So add an ACPI match table for that accordingly.
>
> ...
>
> >  - Change the ID to follow ACPI Spec
>
> Is there any evidence Texas Instrument allocated this ID, or you just
> created it yourself?
> Please, add an excerpt from email from them to confirm this.

Sure, let me ask our customer to provide the excerpt.

>
> ...
>
> > +static const struct acpi_device_id __maybe_unused hdc100x_acpi_match[] = {
> > +       { "TXN1010" },
>
> > +       { },
>
> No comma is needed.

Got it.

>
> > +};
>
> > +
>
> No blank line is needed.

Will update.

>
> > +MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);
>
> ...
>
> > +               .acpi_match_table = ACPI_PTR(hdc100x_acpi_match),
>
> It's the wrong usage of ACPI_PTR().

Can you please explain a bit more?

ACPI_PTR() turns the value to NULL when ACPI is not enabled, seems to
be correct?
Not to mention most other drivers also use ACPI_PTR() for acpi_match_table.

>
> >         },
>
> All the comments are applicable to all your patches. Some of them I
> already commented on and even kbuild bot has sent you a complaint.

That one should be solved by adding __maybe_unused to acpi_device_id array.

Kai-Heng

>
> --
> With Best Regards,
> Andy Shevchenko
