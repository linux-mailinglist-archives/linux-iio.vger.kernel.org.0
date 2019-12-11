Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D912211B246
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 16:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfLKPet (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 10:34:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37240 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbfLKPer (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 10:34:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so10944456pga.4;
        Wed, 11 Dec 2019 07:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVbcFREEaAqSDDWDOprFJiM+U7AawLPMDqSvqgEPZVM=;
        b=saTYAymWtQJVo2xDI5CVVPD7OFscZvr3OmDkn9R98p/K2QPfrErbyRBfLSWuDw82Je
         o5ei0YTQ5fgmkh7BZCrXIsR8OBZyO/sfNZyPb/2FHmifAkGNyAGukafSKofRjuTXMFXl
         WMQxGPuD9wxK4yLU1VhNzWYYmxihNPVzCRYgjRidEsjCXlEHWzI7tLoB4bV+Tg3p4Myq
         VXt9uBaV6jd+hJ6IiKy+pcyDX7aXRViVdLgvrrtrP2D7MFxBpcCNbOct/mx5x6fZqNzY
         wB9Y8YH11zoDDTXPnrVGiEROE/KKqb2trAGgVZw0dOKu3YAS5kWfyPCL9O/gC/FZ67Mj
         Od8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVbcFREEaAqSDDWDOprFJiM+U7AawLPMDqSvqgEPZVM=;
        b=bYAetMkQEIiFZIm3qnffBXcd6lIlL9J+d3IgIYIvwk3iFFmlv6oL6Xef1QRJ8h/xYX
         BS5uk3rmX+n6N4zUJ/WF4i36CNeNLI7fc+oPNjOYrO55/WiXoqGgPhojY8bcSIS8MwaY
         D0xT9omgE62Ud+OZ2s5zVaa2n8S1F67lp2doKCSb9Ejv5925cM93w6MZmhKyXNI0K+3C
         miyyY4u4sxrPSKqGcVKHH5s+WtaeXJRrWZJDKN9ggsLlmZ2iDnqMheTxnUM/vR3CteLt
         bNWz0wRPvIwaupjz/CBrDdRHag6wWQeYZqDDkHc9vO/6U8NHpal14A7ThErWqXfdcJ90
         yMCQ==
X-Gm-Message-State: APjAAAXONB2Wd6FQyap/8Kga4+tUPU3aML+AsSWGjPvAoXWT9epAtMWA
        u7F4U+Q3lhoLS/zSGYv6vAwREvrkN4min5dBMto=
X-Google-Smtp-Source: APXvYqzJ499NHPqVSLLyDUscDbmBddDHmzhr28AkkyOZGKxqfxHIirybt8amARCuiU4PKcyZgP8Qc63k0WPAFrMp7QU=
X-Received: by 2002:a62:1944:: with SMTP id 65mr4526218pfz.151.1576078486945;
 Wed, 11 Dec 2019 07:34:46 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Dec 2019 17:34:37 +0200
Message-ID: <CAHp75VcsfbkG7n6FHkpnPN0sG_PdKg_iKS7VGfATxuPVYU5jcQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] add header file for kelvin to/from Celsius
 conversion helpers
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
        Sagi Grimberg <sagi@grimberg.me>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 11, 2019 at 4:38 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> There are several helper macros to convert kelvin to/from Celsius in
> <linux/thermal.h> for thermal drivers.  These are useful for any other
> drivers or subsystems, but it's odd to include <linux/thermal.h> just for
> the helpers.
>
> This adds a new <linux/units.h> that provides the equivalent inline
> functions for any drivers or subsystems, and switches all the users of
> conversion helpers in <linux/thermal.h> to use <linux/units.h>
> helpers.
>

Thank you for an update.

For non-commented patches
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> * v3
> - rename new header name from <linux/temperature.h> to <linux/units.h>
> - add milli_kelvin_to_millicelsius() and millicelsius_to_milli_kelvin() and
>   use them for implementing other helpers
> - add MILLIDEGREE_PER_DEGREE and MILLIDEGREE_PER_DECIDEGREE and replace
>   the hardcoded constants
> - add kelvin_to_celsius() and celsius_to_kelvin() in <linux/units.h>
> - add Reviewed-by tags
> - switch iwlegacy driver to use <linux/units.h> helpers
> - switch iwlwifi driver to use <linux/units.h> helpers
> - remove unused TO_MCELSIUS macro in armada thermal driver
> - switch qcom-vadc-common module to use <linux/units.h> helpers
>
> * v2
> - add deci_kelvin_to_millicelsius_with_offset() in linux/temperature.h
> - stop including linux/temperature.h from linux/thermal.h
> - include <linux/temperature.h> explicitly from thermal drivers
> - fix s/temprature/temperature/ typo in commit log
> - use deci_kelvin_to_millicelsius_with_offset() in ACPI thermal zone driver
> - don't mix up another fix (format string for cellsius value)
> - add Acked-by and Reviewed-by tags
>
> Akinobu Mita (12):
>   add helpers for kelvin to/from Celsius conversion
>   ACPI: thermal: switch to use <linux/units.h> helpers
>   platform/x86: asus-wmi: switch to use <linux/units.h> helpers
>   platform/x86: intel_menlow: switch to use <linux/units.h> helpers
>   thermal: int340x: switch to use <linux/units.h> helpers
>   thermal: intel_pch: switch to use <linux/units.h> helpers
>   nvme: hwmon: switch to use <linux/units.h> helpers
>   thermal: remove kelvin to/from Celsius conversion helpers from
>     <linux/thermal.h>
>   wireless: iwlegacy: use <linux/units.h> helpers
>   wireless: iwlwifi: use <linux/units.h> helpers
>   thermal: armada: remove unused TO_MCELSIUS macro
>   iio: adc: qcom-vadc-common: use <linux/units.h> helpers
>
>  drivers/acpi/thermal.c                             | 36 +++++-----
>  drivers/iio/adc/qcom-vadc-common.c                 |  6 +-
>  drivers/iio/adc/qcom-vadc-common.h                 |  1 -
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c     |  3 +-
>  drivers/net/wireless/intel/iwlegacy/4965.c         | 11 +--
>  drivers/net/wireless/intel/iwlegacy/common.h       |  3 -
>  drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |  5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |  6 +-
>  drivers/nvme/host/hwmon.c                          | 13 ++--
>  drivers/platform/x86/asus-wmi.c                    |  7 +-
>  drivers/platform/x86/intel_menlow.c                |  9 ++-
>  drivers/thermal/armada_thermal.c                   |  2 -
>  .../intel/int340x_thermal/int340x_thermal_zone.c   |  7 +-
>  drivers/thermal/intel/intel_pch_thermal.c          |  3 +-
>  include/linux/thermal.h                            | 11 ---
>  include/linux/units.h                              | 84 ++++++++++++++++++++++
>  16 files changed, 139 insertions(+), 68 deletions(-)
>  create mode 100644 include/linux/units.h
>
> Cc: Sujith Thomas <sujith.thomas@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@verdurent.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Stanislaw Gruszka <sgruszka@redhat.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Cc: Intel Linux Wireless <linuxwifi@intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
