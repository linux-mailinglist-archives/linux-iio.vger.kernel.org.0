Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1699611B1A9
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfLKPcJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 10:32:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34443 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbfLKPcI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 10:32:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id l127so702151pfl.1;
        Wed, 11 Dec 2019 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+UAPggfsHMu2hFz0NBTkqa2kv+TjIeundnroZjYfRQ=;
        b=i+0FmpCViNvInrmecmJ8i6R+1Ufzx50kWEgF1ULO5Y/9CJ+rZxzfqUnXlEbwQYrNt4
         Iv1n5ncNxZRNNpLFmN+OnXFBWvDDh6pY73qn7GqDGnKrvOW17oqucM6KRgmQJW0acOK2
         w/lI2CW6sFO+5h3Ld6gry2Te9P2rIgAzvpaEp2oR2V8huertU0W6vFv6YD+GyDMwVlAt
         AxLlTZbQZ/0dHInrrgdZxBZ4MDvWqT2TLOK6QP5zGRoLd2OJtyurY/P05yt8J8V7R92E
         Y+MgiRVTIbCRqRj+eb9qac/Jbz+S4uvC2nEQWqMBTCNULh1OxrAEWsG31dvPRWum2dnH
         Qi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+UAPggfsHMu2hFz0NBTkqa2kv+TjIeundnroZjYfRQ=;
        b=HSsaSTwiOoxhyBGehbCi1KKfa6rhq0g6VSqreb4J4IAnHUKKDqWTNtWXftzeoYRFv6
         xzhDHgFNqRu7jUllaaGZwavd3xbkFuMuUj2/dZIoo1fJZ53wdA/PXRJt5Pp47IJwnNVS
         5XA2hEb3OHu3klH93bXw7ykick+RXHNHK7doli3SgL/9Yh7+idp3h/hINno3dkTzPvG5
         xMATOA1pkUaYIxCH9qJSUMZm9oXGzr5Ek3J4n3TXOg5+ciIhfL0XM2XEn/GUKa1sLrSg
         494asR2lZXdrMt1xBRw+WI0Jk7mq2Hc9exyKHCgu+qZJedbOcVepqJzTHJrOJXKsnMO3
         AhJQ==
X-Gm-Message-State: APjAAAXg0kADHFNyqfD+8GnU2yEl9k8rHvBmDcGlLvL3YgZ0VSW1zATc
        S7lr06BNHf6o8GJ5DEy7cp+aLvfx4IuL9ruOHV4=
X-Google-Smtp-Source: APXvYqyCFB+DRw4z7MaU08fIr+Pce9/ZvY0VsbXU7kdzcOrMS3l4Tfsjbogj2wZ4yk2WVuVWgmYDU0mq/Ion5fRBIZc=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr4417883pfa.64.1576078328144;
 Wed, 11 Dec 2019 07:32:08 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com> <1576075099-3441-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1576075099-3441-4-git-send-email-akinobu.mita@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Dec 2019 17:31:58 +0200
Message-ID: <CAHp75VfSUafrg82WcfUA4LhSFaNQSgZp39oVQGD=M124urC=xA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] platform/x86: asus-wmi: switch to use
 <linux/units.h> helpers
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
> The asus-wmi driver doesn't implement the thermal device functionality
> directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIUS()
> is a bit odd.
>
> This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() in
> <linux/units.h>.

> @@ -33,7 +33,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/platform_data/x86/asus-wmi.h>
>  #include <linux/platform_device.h>
> -#include <linux/thermal.h>
> +#include <linux/units.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>

Similar comment about ordering. Can we move it to the end after dmi.h?

> -       return sprintf(buf, "%d\n", value);

> +       return sprintf(buf, "%ld\n",

%d -> %ld must be explained in the commit message (e.g. "due to
function returned type).

> +                      deci_kelvin_to_millicelsius(value & 0xFFFF));

I prefer to have this in one line.

-- 
With Best Regards,
Andy Shevchenko
