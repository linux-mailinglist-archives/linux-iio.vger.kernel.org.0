Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48426E0641
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 16:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfJVOTb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 10:19:31 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40222 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJVOTb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2019 10:19:31 -0400
Received: by mail-il1-f195.google.com with SMTP id d83so7098204ilk.7;
        Tue, 22 Oct 2019 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+f3+Xe6vGoRY1MkZlLrpomXTPs0/tCl2G1ZKWZtIxAo=;
        b=YAwJ3bV/qfhkrwx/pD8NNAOcp8lyAcKZAf0rVGAEA3R+ynDUDgag6Su0pYLScEACaF
         VdbEM+ccOLQhxi9UHidkOrvDJPqXKGP62aEowqoJ8AWPBqdNFCJmKMzEqZXhpq5Z9P0s
         h8grN0Ol4cUzSo0r9ZMic6r13EiSk96l/8poQAFEotOMkSrOxXwIbz3nalNS0aN2U7CO
         zQhZNTYOGlJm1PzXy/JXyk+2P+pSs4WwYMsvx0S2hwQfhNz3xxQjC+UNb9EURlBtsQix
         6nlfNdHiulpRhMRli6vXbQY/Fmp/xdFt7dANhI9eImDClqjNY+EZmYEkwBuz4WZI7OtN
         L1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+f3+Xe6vGoRY1MkZlLrpomXTPs0/tCl2G1ZKWZtIxAo=;
        b=OgQoDv0WwkukYUjcisPhthKZz43ppQbv3rfulGPW4g/Bazo2eozBSicGSxURF7IBFQ
         pyO3Nq0ghve0KhlfCYQrbf8sXs9hf0QTJkfEZvzGOkvH/U/E3nxXK24AtLr2vhBpXSic
         OMW311+uZkTPyjpD/8+j+H2qzyUiIUumY+hfhrSro2afKiLCDAtC3lPRYjGLEfberAQZ
         kkPXkY8OnKTyIrHwoJnh7Mog/aE+0GDNhIuOiMf21x6KgdS83MPkGRgqF8hr6K4esuos
         MIyU1dbDW+863DRP3LvDnYYV2//7BrlNz1mTlpvLCQLHuJREcoBJ7CazNDT4MnusK37d
         bN0g==
X-Gm-Message-State: APjAAAUfpNBlfcbap9iYUnf7I3zy7wrPD5LRavN1+na/Ui7x7mZbBqsK
        VOV4K6BlrxvLQykxn+OEWf4JHLbOtfgH9hfI1M0=
X-Google-Smtp-Source: APXvYqzYgoObKadQNqP9/pOBBZSO8nRSPoX0xvkFOCE5TKS5+426FdTSaMvdKNMXLC9KHJtsRM3Xeaiu0SFDiXeY/qA=
X-Received: by 2002:a92:1d51:: with SMTP id d78mr10157573ild.166.1571753970497;
 Tue, 22 Oct 2019 07:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <1571749887-9054-1-git-send-email-gupt21@gmail.com>
In-Reply-To: <1571749887-9054-1-git-send-email-gupt21@gmail.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Tue, 22 Oct 2019 19:49:19 +0530
Message-ID: <CALUj-gtADUhcUPmtOyjxwJCKhBcUOJaSdQd0H0J+JuSZ-yZEDQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: documentation: light: Add veml6030 sysfs documentation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Forget to capture in change log:
removed PSM sysfs completely.

On Tue, Oct 22, 2019 at 6:41 PM Rishi Gupta <gupt21@gmail.com> wrote:
>
> The driver for veml6030 light sensor provides sysfs
> entries like configuring cutoff for interrupt. This
> commit document them.
>
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
> Changes in v5:
> * Use ABI/testing/sysfs-bus-iio to document sysfs files for veml6030
>
> Changes in v4:
> * None
>
> Changes in v3:
> * Updated Date from September to October
> * Updated KernelVersion from 5.3.1 to 5.4
> * in_illuminance_period_available is now in events directory
>
> Changes in v2:
> * None
>
>  Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6804516..a26d532 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -753,6 +753,8 @@ What:               /sys/.../events/in_illuminance0_thresh_falling_value
>  what:          /sys/.../events/in_illuminance0_thresh_rising_value
>  what:          /sys/.../events/in_proximity0_thresh_falling_value
>  what:          /sys/.../events/in_proximity0_thresh_rising_value
> +What:          /sys/.../events/in_illuminance_thresh_rising_value
> +What:          /sys/.../events/in_illuminance_thresh_falling_value
>  KernelVersion: 2.6.37
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> @@ -972,6 +974,7 @@ What:               /sys/.../events/in_activity_jogging_thresh_rising_period
>  What:          /sys/.../events/in_activity_jogging_thresh_falling_period
>  What:          /sys/.../events/in_activity_running_thresh_rising_period
>  What:          /sys/.../events/in_activity_running_thresh_falling_period
> +What:          /sys/.../events/in_illuminance_thresh_either_period
>  KernelVersion: 2.6.37
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> @@ -1715,3 +1718,12 @@ Description:
>                 Mass concentration reading of particulate matter in ug / m3.
>                 pmX consists of particles with aerodynamic diameter less or
>                 equal to X micrometers.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/events/in_illuminance_period_available
> +Date:          October 2019
> +KernelVersion: 5.4
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               List of valid values available in multiples of integration time
> +               for which the light intensity must be above the threshold level
> +               before interrupt is asserted. This refers to persistence values.
> --
> 2.7.4
>
