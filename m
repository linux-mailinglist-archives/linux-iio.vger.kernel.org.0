Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51A5196CEB
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 13:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgC2LW0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 07:22:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46314 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgC2LW0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 07:22:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id k191so7217702pgc.13;
        Sun, 29 Mar 2020 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMN72kZ+dQBIE9BK5gK8is5DfX56QN4AerLjDwscHk0=;
        b=q/OHEu1huh69xufvD4/e6DgSXihaH27aM7Fi7rji/CBHrZB5nhe28g7vKTQSJ6Tuuq
         eNrTJSmg0Zttdzil6nDKEenb7+1r+HwkuSbmzytcybRkQsiFOxcS8FTS1EzZoss7YSw4
         9n6dLN7TMT2czm097pK6hQ0kJtyYc4LfYCPvbWGWg708YeBfg1Oq3T9rB1HjsODJzseb
         H1syhjFExGnlXsOyWBGBhZLjAL3DdUKTu3rUoeap1tJ5zkU9hUzbbwIM7+2NLhCXMvxr
         zUwMw1sqX3TGaUMO+YtQ41EOT/s4q3B6HUfcIsDJpgeSg93l3HtSxvxDxG7+WwajBc1j
         WCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMN72kZ+dQBIE9BK5gK8is5DfX56QN4AerLjDwscHk0=;
        b=aa7wPYsbCqJO8nHorslY6epClbb6wtM+h+zi+txTG2KNT+Q+s32HTGmhb3TEPdtGY0
         7KnIRaWt0gp0OuK2TXfEwW//GUdI0x9Tv8ieC05pUWLVYtmeIwzEcvrdcbjdt7KuCraI
         fIZjr8fMU24WPKc/IfjO+/vKEs88GtVQ3yYP3OKlL1qNeiRyV3LKWZIwj+d/FpcSnxBO
         tUgjMMrnP0Kfn+YjzuabY76Na4LmSus3JZ75FD8APVKAIPnQ/liyEgepffg3rqnQLUBL
         QEpunYAUhCJzf+6FLlQTc9vkSKdE+6P3buz5p6kks9MISJNNydmX3QedgopL8udMuFyA
         Q0Hg==
X-Gm-Message-State: ANhLgQ3/CUjQ99Qj/hE/G0B3B9gLLGFRaaJe/MxHPQo3eIMMXfdJfuR/
        KN9LSdu1ivbtXbUAy1H5sBjz9cMRZpGTSsy+QYc=
X-Google-Smtp-Source: ADFU+vvo6yPjelxmVNaAJIY9eDDVqjrsR5UqyUcKJbl7RJRaA4yprdi6TnUllj58+cV++aYcvwMR9aAi4ZXZr2F1cP0=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr8360593pfs.36.1585480943579;
 Sun, 29 Mar 2020 04:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200327223443.6006-1-gwendal@chromium.org> <20200327223443.6006-13-gwendal@chromium.org>
In-Reply-To: <20200327223443.6006-13-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Mar 2020 14:22:11 +0300
Message-ID: <CAHp75VeRZO9DnTRZWavfp2FPjg_kqmpNr0VZnXv1U3G4Pr0iFQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/12] iio: cros_ec: flush as hwfifo attribute
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 28, 2020 at 12:37 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Add buffer/hwfifo_flush. It is not part of the ABI, but it follows ST
> and HID lead: Tells the sensor hub to send to the host all pending
> sensor events.

I see where discussion is going, but nevertheless some comments below
that you will not make same mistakes in the future.

...

> +       int ret = 0;

Useless assignment.

> +       bool flush;
> +

> +       ret = strtobool(buf, &flush);

kstrtobool()

> +       if (ret < 0)

Positive error codes? I'm not sure it returns a such. So ' < 0' part
is redundant.

> +               return ret;

> +       if (!flush)
> +               return -EINVAL;

This I didn't get, you have accept only true as input? It's really strange.

> +       ret = cros_ec_motion_send_host_cmd(st, 0);

> +       if (ret != 0)

Similar to above ' != 0' part is redundant.

> +               dev_warn(&indio_dev->dev, "Unable to flush sensor\n");

...

> +static IIO_DEVICE_ATTR(hwfifo_flush, 0644, NULL,
> +                      cros_ec_sensors_flush, 0);

IIO_DEVICE_ATTR_RW() ?

-- 
With Best Regards,
Andy Shevchenko
