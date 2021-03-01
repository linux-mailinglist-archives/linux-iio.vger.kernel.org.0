Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC6D32808B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 15:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhCAOTb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 09:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhCAOTa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 09:19:30 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FA6C061788;
        Mon,  1 Mar 2021 06:18:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t9so11283782pjl.5;
        Mon, 01 Mar 2021 06:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jUIzc8lLj6XtpqYO1T593FEkkF9TDkHoYUvicZfI4x8=;
        b=ZW3F+maDDVfnxE40uemxanV3G4QX+qksbtBzGTQJEVG3UPr7E5xrwXrtde4YoWFKWj
         5mSAfP87zS+UdeY3I9Kqhcti567vr5W98/03VppM+TvPaKLvochQgz+5/WP8WgH44slf
         t7gMYjiuhbhhZfdQJSvhdADL0c1GpXIlUaCgQ7QOK9scdrc4m6H0x4GRi+f3EooqnHhg
         2mMACY6ngLwXvuaqBwNNIgDbN1ciKidtII4fDWQ99PYy071mafcJQAtaHNgoCYAarkML
         Aj+tBUfc8YFloBHpcQ68H7g2qf+8Nhpg3pqh1VFNd9MxRvx5ID1savNXzJe1/i6woEPV
         ogAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jUIzc8lLj6XtpqYO1T593FEkkF9TDkHoYUvicZfI4x8=;
        b=Y8TLFBwV04RvKY+YgNFAoKcMh7KK2h9uoE0AM/XWj8U8vAzVWzi5IqX4wGK6VvnsWR
         2lesJIqT4xMjFPM6M8uJFwk/OyfFiqAw2RS4aIj5MVRotEhmN63hztz/KLdweJZj9dNE
         W/sBdxcx1mV8tLqIrMFjkW+mZbBF4nmb7DnKReysN71oqDwfPjgPwr3AwWF2HJniw/7H
         PjdAzGcBOlpc/YgXc7EOj+ogaInkXJ2vUIGGjY7Ozwg9Ozc7LsvkXAkYUdSrU7Iwmb1G
         80W7VSEjqK41IR4SOfbUHXgl3pxAGs85Q8I+lYbuNBpdStpSj1uXEx5NuQFGnNY8JcRb
         HcIQ==
X-Gm-Message-State: AOAM530pH6Ep2vbbw1SFmMc2q7Y4HNt25XPRQH6GDkMBytnpPBS2mtTl
        jFwfW3xC3BuHvPmkmEYRP2greAaDuWDMdCE3atA=
X-Google-Smtp-Source: ABdhPJxOYJQGoQstIsoxRKgXUfDaM33A9TLXKTAz2EIlvhTNMh2lQmh4ng0OLtoC+ZjOfe6rmEnBiAvSWn+y2xOD5L4=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr18431790pjx.181.1614608329327;
 Mon, 01 Mar 2021 06:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20210228012643.69944-1-ronald@innovation.ch> <20210228012643.69944-4-ronald@innovation.ch>
In-Reply-To: <20210228012643.69944-4-ronald@innovation.ch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Mar 2021 16:18:32 +0200
Message-ID: <CAHp75Vfd6wZwg9HWJoEwvzAAZR=8K2zDWbz4FZfbbrJBvZS4yQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] HID: core: Export some report item parsing functions.
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
> These are useful to drivers that need to scan or parse reports
> themselves.

...

> -       while ((start =3D fetch_item(start, end, &item)) !=3D NULL)
> +       while ((start =3D hid_fetch_item(start, end, &item)) !=3D NULL)
>                 dispatch_type[item.type](parser, &item);

> -       while ((next =3D fetch_item(start, end, &item)) !=3D NULL) {
> +       while ((next =3D hid_fetch_item(start, end, &item)) !=3D NULL) {
>                 start =3D next;

I don't see the full picture, but perhaps you may also introduce
for_each_hid_item() or so.

--=20
With Best Regards,
Andy Shevchenko
