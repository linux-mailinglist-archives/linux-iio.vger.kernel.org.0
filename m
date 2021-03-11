Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F086336E5F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 09:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhCKI7X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 03:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhCKI7F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2021 03:59:05 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1617BC061574
        for <linux-iio@vger.kernel.org>; Thu, 11 Mar 2021 00:59:05 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id h18so18295616ils.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Mar 2021 00:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sxg3X/oYCGXtcasjRKf7wk0A6Sv64hB8sDPE2qKlin4=;
        b=DquXJOcnfNsBbYCop8Hsr0bCQhMQhsRRc3x8Weqoev4C6C0+2Ubtu65U7ysboRdm26
         xrXatJYKeXLfaFVTuv0LMIZbT1zHOXenqLSnWqJDWte+EJqIwNZz8zyZZmZt6UmD1gOp
         /2GBmpTBOXxs2lwvi8zOMfQTDouqBESNQm9rPkYbck3fWV3UVE+jUuPSaLSj7EZkaIXv
         JlJnZXGTTxDHJjOTgkxQ2sHGkao1F3m+tnVbRq/fUXPb1HeIUl+XJSiBZaoRkHcUA6ph
         cBSkmTb2DR+V1oumiBMEDxtPojPJ+xWlAZLfQ/fTP3UJAct0vv3jaS4CGNIVz4yBRrRT
         B+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxg3X/oYCGXtcasjRKf7wk0A6Sv64hB8sDPE2qKlin4=;
        b=haD7gbzSoi7QzXJ+MNsqkQrkSfXhOU4zdFVfD7nDlOZCGCOL1zJ2ZNyo2JQYom+G6C
         Y/5NKzyhnROHquzjgAHqSXzEeKZYKKAi+ZSxbpxuNzHy2XfZuLe3hbfLobGkDZRFD0B0
         QoHwmBhOaMbxsQvCDwd8nxWXRPHdDtv/sIBLPSKUIICmXKkUq1CY2o5TK+9wuhO+VZKE
         6cSKp1FqlGRtAymV3xJcRkxDcMfVtnZjjyGlWAgF5LAHQC6qHGht76OcurTR8yX2WVOd
         b/VErsfEOrVtddyudjNQJfababiGYSXCTZXyaODjMT/Lz1muV8OkQGl0uzuWqDzLB0hh
         N6ow==
X-Gm-Message-State: AOAM531MZwD75Faf4YRaTpRZrQxSnmStq+hwcMKLD1bCidkhJq6DbZWS
        DMEK4sMZLbbI2jzECnEGbu2ISWE3tsr5ZYdMW2g9CxKYUx3jzQ==
X-Google-Smtp-Source: ABdhPJz5W8vg6I+2MU3heWAqI3nocwJQtVtZjP068G0aZqCjcpRRoDPZCkI75GQJ2r8sZi0JLaUf3uiPEmy4sXURFIQ=
X-Received: by 2002:a92:3652:: with SMTP id d18mr6151572ilf.100.1615453144569;
 Thu, 11 Mar 2021 00:59:04 -0800 (PST)
MIME-Version: 1.0
References: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
In-Reply-To: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 11 Mar 2021 10:58:53 +0200
Message-ID: <CA+U=DsqAcmQq2qPMfxVcuwLWJefus_qyM1wG+ioGyG8bej88pw@mail.gmail.com>
Subject: Re: GSoC IIO project: Mugil
To:     Mugil Raj <dmugil2000@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 11, 2021 at 9:03 AM Mugil Raj <dmugil2000@gmail.com> wrote:
>
> Hi,
> This is Mugilraj, an undergrad at NIT Trichy, India. I'm applying to
> GSoC'21 for the project IIO driver. So, I need help from you guys with
> the application process and finding the device to develop a driver.
> I've done few exercises on patch submissions and completed a Linux
> Foundations course, "A beginners guide to Linux kernel development
> (LFD103)". I found this "https://kernelnewbies.org/IIO_tasks" task for
> beginners, and now I'm doing that also If anyone suggests some fixes
> to develop, that would be helpful for me.
>


hey,

i posted some ideas here:
https://lore.kernel.org/linux-iio/CA+U=Dsp98caW89g9FbsV-+KQ-NjyOqd+KSkO+aaFp4qBb-hpMg@mail.gmail.com/T/#md6c49f2e457d66d922d3d22f1f6fdb54971e6b8a

[a quick copy + paste from that email]

One thing I've always wanted to do, is to convert the entire IIO
subsystem to devm_ variants.
Essentially getting rid of the iio_device_unregister() function in
favor of using devm_iio_device_unregister() and similar.

There's about ~217 uses of this function.
The more complicated one is in the 'drivers/platform/x86/toshiba_acpi.c'
I think reworking the Toshiba ACPI driver would also be interesting,
but it is some work.

Now, converting everything to devm_ variants can be considered a bit
of an obsession [by some people].
But I sometimes find potential memory leaks by doing this conversion.
And chances are that we may never be able to fully convert the IIO API
to be devm_ variant-only.
But it is an interesting process [for me], just the cleanup itself.

Another one, that was interesting until 1-2 years ago, was the
conversion of OF drivers to be a bit more ACPI friendly [as well].
This is also a bit of work to convert drivers that use only
of_property_read_xxxx()  functions to   device_property_read_xxx()
functions.
This isn't always straightforward in all drivers, but I do find it
interesting to unify the OF & ACPI interfaces, so that all you have to
do, is just switch the system from OF to ACPI underneath, and if the
device-tree conversion to ACPI is done right, it just works.

Then, there's the matter of moving fields [marked as [INTERN] )  from
"struct iio_dev"  to "struct iio_dev_opaque".
The value of this conversion is to reduce the review pain of having to
tell people not-to-use [INTERN] fields [especially when older drivers
do].


> Is there any IRC channel for IIO?
>
> Thanks,
> Mugil
