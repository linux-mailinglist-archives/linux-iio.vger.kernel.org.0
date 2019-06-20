Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DE4DD00
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 23:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFTVqy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 17:46:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39681 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfFTVqx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jun 2019 17:46:53 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so7472083iod.6
        for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2019 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD/sPbt5AG02OSpSDC1IGFx0HbwrZQWPg/7TsPaRSVQ=;
        b=ThEa4ZglSkds8WdcJKNus0VVSVjFEFqJbFHI/ujfqslJqLtrYv0SOA/AEj+QSw8s49
         HWZpvD4AKGmBe7vU5/r6Qyk6D56XFzM7kc1LmltZ14VhpbZpUG/BU8x7UHvO0rbxUCnF
         Pyso3ubEKg1h1u9dgN4wr9EkwX4s/HNPKRR3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD/sPbt5AG02OSpSDC1IGFx0HbwrZQWPg/7TsPaRSVQ=;
        b=PAGovywJkZRuVe8rKJXeebc4uHYn4Qzrx3HZ6iNrfFrdEe+zsjY+slCc5RJS5dRd6+
         rB0mE1xCZVckFAYMtgiTZluIFMxkMoEojDsFkYITKSLcua3SX+6Blilwhooxhe2LZKq+
         9oAVM6UXg7cjhcAN+JtzHqgiyfOKvlu7DGwgMTbzznNn8i8GEuFMsiTeBpVb6YjgqOG4
         zEwDMDVGtuBozrzPdTwIsSOorom9tJ0XEjWM1TqWkDBr7OIzxDVwlMiTxC63ZZTAvdl3
         56t9JRrtzAc6tnIzhoXcYKK/7mzoyQ3ItyC6wL0oJN/rn9aTodlB6dvG7M3N0f+2IROa
         DMgg==
X-Gm-Message-State: APjAAAUgoo11xNx579rViu+ctXp8hHXID3AynPELAAa1RLv5gcbHeF5l
        dIsyEXsh8ljRdm796uOUQHaXAbZSNYA=
X-Google-Smtp-Source: APXvYqxiKYhXaTrQ8wA7hNlP9oC7wHSSMU+0fqq6q3dwnXD3LuvRmzJBCx15D9VIwb+JuV/qDgtp3Q==
X-Received: by 2002:a6b:e309:: with SMTP id u9mr2584138ioc.262.1561067212748;
        Thu, 20 Jun 2019 14:46:52 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id t133sm1601060iof.21.2019.06.20.14.46.52
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:46:52 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id m24so1082842ioo.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2019 14:46:52 -0700 (PDT)
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr21337944jan.90.1561067211854;
 Thu, 20 Jun 2019 14:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190620185259.142133-1-gwendal@chromium.org> <20190620185259.142133-2-gwendal@chromium.org>
In-Reply-To: <20190620185259.142133-2-gwendal@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Jun 2019 14:46:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPK4fQeYGFh2wzxgwt5Wo7hK6JpQ9sN7QM9Q0_w7AALw@mail.gmail.com>
Message-ID: <CAD=FV=VPK4fQeYGFh2wzxgwt5Wo7hK6JpQ9sN7QM9Q0_w7AALw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Thu, Jun 20, 2019 at 11:53 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> To allow cros_ec iio core library to be used with legacy device, add a
> vector to rotate sensor data if necessary: legacy devices are not
> reporting data in HTML5/Android sensor referential.
>
> TEST=On veyron minnie, check chrome detect tablet mode and rotate
> screen in tablet mode.

TEST= doesn't belong in an upstream patch.


> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
>  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 719a0df5aeeb..1b2e7a8242ad 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -66,8 +66,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>                 }
>                 state->type = state->resp->info.type;
>                 state->loc = state->resp->info.location;
> -       }
>
> +               /* Set sign vector, only used for backward compatibility. */
> +               memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> +       }
>         return 0;

Normally there's a blank line before the "return".  There was before
your patch.  Why did you remove it?  It'll make your diff cleaner if
you keep it.

Also, should you be basing your patch atop +Fabien's series?  I notice
you got a conflict when you picked this into the Chrome OS tree, but
maybe you wouldn't have if you had based atop
<https://lore.kernel.org/patchwork/patch/1090463/> AKA
<https://lkml.kernel.org/r/ac3cdc104e59565d178dfa86f2727045224dc4da.1560848479.git.fabien.lahoudere@collabora.com>


-Doug
