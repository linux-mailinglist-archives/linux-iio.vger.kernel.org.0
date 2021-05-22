Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CC838D6D7
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhEVSLC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhEVSLC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 14:11:02 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D12BC06174A
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:09:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y15so6016200pfn.13
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qn3/PcKn8NXdi3aHEFVBAqeCO7oFTPdMzEZYpKKC4i8=;
        b=QT4CiTAZ+Y/dFzAyKLxTinNBUxlTgdTPib5bcad1V32wjKjSQNRlRSR2QVDkX/Vzyw
         3/mIV3SsvaB19zqzbBX/7tgLNLKgtNcfPiHth8X9jQt9U7MD+f3G+K2lsMNK4Kmy1PwJ
         veuhtO/WP7X5rYOnbvGVzS0MuUL4MluzKUTeImQV+vQwIkgY6gj2tk9BCk4eSJT22d1M
         wWy42xAuyIiH10kUINyIiMcfN7NdwoE0R+Vg5tP8PHHpvFLnXco1n+jKatd3uk/FBK35
         3VvcHDnoBTbfjdHdppgGzGD/LjIU/lCDnflzSrFGg1f/i0UZDpuVfwaFjl2kSZn48F7W
         UKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qn3/PcKn8NXdi3aHEFVBAqeCO7oFTPdMzEZYpKKC4i8=;
        b=qi8fm6WNL3c4L9olbvR8wVOwJucaNNmLXhl/TkKDAKevJg1/ACd/Y2Hy4q0sdzaVZj
         NIUf+ut+OlNgqQ/V0ZdpOQ07jOxTHj+FL6zTm/DwQJY/4QoHcxCo45AivgSr6KXG7/Fg
         TIEHAJcEOk0NQbE2o+5qVYkA6MKkQjnQfnr3EalPEV32jw+GhLDXEMAzb5KHMFkuiKXi
         pRHgUAh3hoUHtFHNbIi36ES30+iEPTaJoIY7gUUlKz0GoK+dUQZy5qA8DDFZdxNSDYIO
         hVo2VftgDfDNjdJeLlQhMdHR5pCpGxU1Fj66aLTl25gM+7qCo0HzKN5EWJ+WwiTRYmQF
         XFkQ==
X-Gm-Message-State: AOAM532ZVGFwjfjluQNeHRiMYwayBdoRV5HJ3abgQdiJMDFSn1vZOYUG
        AM0NTas5m3ODNcM9dAu4xhcVmCgT0GiGWbOxWs4=
X-Google-Smtp-Source: ABdhPJwmQ3Nnq6VwzozIoJ3lWw1SEcVOjgOghqVqYgc1/h9Zf9GVciy0E3aRI+cSQh4nQqyKMFoUaUu1tyuE9RR1rco=
X-Received: by 2002:a05:6a00:1591:b029:2d9:369a:b846 with SMTP id
 u17-20020a056a001591b02902d9369ab846mr16410984pfk.40.1621706975983; Sat, 22
 May 2021 11:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210521171418.393871-1-hdegoede@redhat.com> <20210521171418.393871-4-hdegoede@redhat.com>
In-Reply-To: <20210521171418.393871-4-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 21:09:19 +0300
Message-ID: <CAHp75VfL0U90qcG4D1eOEP0f8sOMiNsrHwXVe4YjR1ypQFBLwQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: accel: bmc150: Move check for second ACPI device
 into a separate function
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 21, 2021 at 11:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Move the check for a second ACPI device for BOSC0200 ACPI fwnodes into
> a new bmc150_acpi_dual_accel_probe() helper function.
>
> This is a preparation patch for adding support for a new "DUAL250E" ACPI
> Hardware-ID (HID) used on some devices.

...

> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
> +       {"BOSC0200"},

> +       { },

I guess it is a good chance to drop a comma.

> +};

...

> +       if (!IS_ERR(second_dev))
> +               bmc150_set_second_device(client, second_dev);

I would comment on the pattern here, but I have noticed that this code
is changed in the further patches anyway.

-- 
With Best Regards,
Andy Shevchenko
