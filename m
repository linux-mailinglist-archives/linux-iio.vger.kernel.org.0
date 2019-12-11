Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB411B17E
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 16:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfLKPay (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 10:30:54 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:46182 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387867AbfLKP3X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 10:29:23 -0500
Received: by mail-pj1-f67.google.com with SMTP id z21so9041500pjq.13;
        Wed, 11 Dec 2019 07:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfDhDYFuoXDrqHRE8i/08ZQEyfFGj50C9cMmD8Jy2MA=;
        b=j5C0uyFcwXKjxMT2bhJ14CbB+fZCEQxShkK6p3Cf93qQ6BpSTKh005B5VD2g3OiyqF
         /wNRFMf+eDpSe4TXNqE6yRjbz6RybfTWfb6JvF2sgW3j1ebFqzHfH+knhZW5LWMcLU9Q
         PPkMZlifZ3WANqTGfezf8poByuNPftyfj2T8ipV3B9YeSB8ICKW5MsA6kddHfyed3zGU
         vic5lX9Flai49PViVVxoFnEQJ1pk/ccakyFpoYFqPpU1m9xHZDAyiQ7nU9kNfJZthfG6
         7ElzzegodjoKVuaP+P5wut6UEuDXichyFzp4GyPgvDzsqKx4ZybnxVzEt/Nh+yrpsJgq
         kRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfDhDYFuoXDrqHRE8i/08ZQEyfFGj50C9cMmD8Jy2MA=;
        b=oAp9Da0cQAxIH33xtPRmHHU7hXcNi2uBWg1Og5bnOhBOKc+hnHLVtlcYxFnwXbX6zF
         GEAaDkOqYoCsnjDS7bBWqirQhwVzj3p5jhoz5pUi3vNFcmz6OmMvfPehP1gwtNkj/FpT
         3z3ypD6JonJ5HP91wt3V+mi5Gijz7NOU3juy/RKKTpDlY2pn7/Po+PHgd0kGvbEAGgXe
         mIA42Asn90P5z94ZdBFE/amZfAWQw9qJf/c+w5LheJuK4rW2BZ+nyJjdkdZV1XmA+VBP
         Wl6qpuDs65zuO7ZGQ45BENZByisPuxDaop07kTF9tryPX0BH4JedGPDxS5qhAqjTERnc
         FSBQ==
X-Gm-Message-State: APjAAAWG8fEtXNby/te4Lw1NUEZdGAC01iU/5E+FSAUQshH+DOm7Ksp/
        6G6y8LdeLPeY7Putejvd+94YB7/nGUFqXoZE64E=
X-Google-Smtp-Source: APXvYqwlR/tF5FA23iHp/eaMoUPuaCaCPBgDqm77FVGRFefN3YELGs3EmpG2NGeQvAJUc/yD31OEVyNePT/dpDkApsU=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr4272497pjq.132.1576078162498;
 Wed, 11 Dec 2019 07:29:22 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com> <1576075099-3441-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1576075099-3441-3-git-send-email-akinobu.mita@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Dec 2019 17:29:12 +0200
Message-ID: <CAHp75Vfq4KqNAGY4ivveR7D0Z1fA1EOFT+oL9+f+Ak2jikCTVg@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] ACPI: thermal: switch to use <linux/units.h> helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 11, 2019 at 4:39 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> This switches the ACPI thermal zone driver to use celsius_to_deci_kelvin(),
> deci_kelvin_to_celsius(), and deci_kelvin_to_millicelsius_with_offset() in
> <linux/units.h> instead of helpers in <linux/thermal.h>.
>
> This is preparation for centralizing the kelvin to/from Celsius conversion
> helpers in <linux/units.h>.

>  #include <linux/reboot.h>
>  #include <linux/device.h>
>  #include <linux/thermal.h>

> +#include <linux/units.h>

Can we try to keep *some* order, i.e. put this after acpi.h below?

>  #include <linux/acpi.h>
>  #include <linux/workqueue.h>
>  #include <linux/uaccess.h>

>                         } else if (crt > 0) {
> -                               unsigned long crt_k = CELSIUS_TO_DECI_KELVIN(crt);
> +                               unsigned long crt_k =
> +                                       celsius_to_deci_kelvin(crt);

It used to be one line, why do two?

>         pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
> -               acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->temperature));
> +               acpi_device_bid(device),
> +               deci_kelvin_to_celsius(tz->temperature));

Ditto.

-- 
With Best Regards,
Andy Shevchenko
