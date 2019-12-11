Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF84C11ADA8
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfLKOit (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:38:49 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:45847 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKOit (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:38:49 -0500
Received: by mail-pj1-f68.google.com with SMTP id r11so9002704pjp.12;
        Wed, 11 Dec 2019 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5BPDmN/kK4qF1FFBcFUC5NrEjFOAwbeaBcO9T8TsnoI=;
        b=TzSx4/i24RD3Dd71O89+B4fIq62OZ0UUbisqw9pRgyfOm6sUDMjMhyYszrxOBIjwT4
         37vUbBF8dWFFXKS+lRjeSxxMBNOcfYT4rQNinX79d19OHoarteMsTt/0CPgLWSe53zUY
         vMHpInIAOOfF8hLhjxAMAdtA2xrdHKzHZ9BTeukIb5Pv5vuC+Rgkj6L2H3joKWh7cXWK
         LzgxV73ohhGvP7di7NCaWQBtfYXXkI6EJ46I/fHfYIEw7BmTXtJtK0h04kOi1Ta0bWbh
         WXtoO+s9g2EzdiAOc3ODQ/0fgcf3A7+UzpFNYara7eRAe6vUcLv8LXM5ug3xjjL6cBTE
         18Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5BPDmN/kK4qF1FFBcFUC5NrEjFOAwbeaBcO9T8TsnoI=;
        b=E9m+JNYEvnXtGYU72WPd790H/nhJJ86/RCDgCwYmdHRloax1ArmZjr0Irma3PWkifO
         onGXQdKIRyeISu1dwIUHi9DHht8Ms41O9Oe7FGpErqFhMQyiKsO4ecJQ5m/0cipbsy3S
         VhE2cnFltSrAboLqhuGEsHAQU4vBMs6Q2FSdFCFKONb65HfCI2BivfKuPXloMm1N1AFT
         rzKQ1viQZ11tN/uOIJmUqiSc1xMqWBBwuGmi0wr9FeR4T2jl4eNkHmE38kmlCm1QEda8
         Fl2+fuiFOZpdibq+6myiKYCVPSlZtp6UvXLkrpTexUX4jH7fQNulxlQ/IhKe3dr8b9XE
         wVyQ==
X-Gm-Message-State: APjAAAVF6jnuX3ZoDKmcB26h4cU7u+ldQmGsbclV1DvW/GrfsGqTbuPY
        4isDvPkVucRkJk6m0WQikuL4Ink5VUU=
X-Google-Smtp-Source: APXvYqxuBwnuR3LZbqfQuvFGH0wM9ioq0vUjfYErg4Lo+js0qm5mN9zlNsQwib7u5AlkkyMPa7zmWQ==
X-Received: by 2002:a17:90a:94cc:: with SMTP id j12mr3766553pjw.3.1576075127838;
        Wed, 11 Dec 2019 06:38:47 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:38:46 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
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
Subject: [PATCH v3 00/12] add header file for kelvin to/from Celsius conversion helpers
Date:   Wed, 11 Dec 2019 23:38:07 +0900
Message-Id: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are several helper macros to convert kelvin to/from Celsius in
<linux/thermal.h> for thermal drivers.  These are useful for any other
drivers or subsystems, but it's odd to include <linux/thermal.h> just for
the helpers.

This adds a new <linux/units.h> that provides the equivalent inline
functions for any drivers or subsystems, and switches all the users of
conversion helpers in <linux/thermal.h> to use <linux/units.h>
helpers.

* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>
- add milli_kelvin_to_millicelsius() and millicelsius_to_milli_kelvin() and
  use them for implementing other helpers
- add MILLIDEGREE_PER_DEGREE and MILLIDEGREE_PER_DECIDEGREE and replace
  the hardcoded constants
- add kelvin_to_celsius() and celsius_to_kelvin() in <linux/units.h>
- add Reviewed-by tags
- switch iwlegacy driver to use <linux/units.h> helpers
- switch iwlwifi driver to use <linux/units.h> helpers
- remove unused TO_MCELSIUS macro in armada thermal driver
- switch qcom-vadc-common module to use <linux/units.h> helpers

* v2
- add deci_kelvin_to_millicelsius_with_offset() in linux/temperature.h
- stop including linux/temperature.h from linux/thermal.h
- include <linux/temperature.h> explicitly from thermal drivers
- fix s/temprature/temperature/ typo in commit log
- use deci_kelvin_to_millicelsius_with_offset() in ACPI thermal zone driver
- don't mix up another fix (format string for cellsius value)
- add Acked-by and Reviewed-by tags

Akinobu Mita (12):
  add helpers for kelvin to/from Celsius conversion
  ACPI: thermal: switch to use <linux/units.h> helpers
  platform/x86: asus-wmi: switch to use <linux/units.h> helpers
  platform/x86: intel_menlow: switch to use <linux/units.h> helpers
  thermal: int340x: switch to use <linux/units.h> helpers
  thermal: intel_pch: switch to use <linux/units.h> helpers
  nvme: hwmon: switch to use <linux/units.h> helpers
  thermal: remove kelvin to/from Celsius conversion helpers from
    <linux/thermal.h>
  wireless: iwlegacy: use <linux/units.h> helpers
  wireless: iwlwifi: use <linux/units.h> helpers
  thermal: armada: remove unused TO_MCELSIUS macro
  iio: adc: qcom-vadc-common: use <linux/units.h> helpers

 drivers/acpi/thermal.c                             | 36 +++++-----
 drivers/iio/adc/qcom-vadc-common.c                 |  6 +-
 drivers/iio/adc/qcom-vadc-common.h                 |  1 -
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |  3 +-
 drivers/net/wireless/intel/iwlegacy/4965.c         | 11 +--
 drivers/net/wireless/intel/iwlegacy/common.h       |  3 -
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |  5 --
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |  6 +-
 drivers/nvme/host/hwmon.c                          | 13 ++--
 drivers/platform/x86/asus-wmi.c                    |  7 +-
 drivers/platform/x86/intel_menlow.c                |  9 ++-
 drivers/thermal/armada_thermal.c                   |  2 -
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  7 +-
 drivers/thermal/intel/intel_pch_thermal.c          |  3 +-
 include/linux/thermal.h                            | 11 ---
 include/linux/units.h                              | 84 ++++++++++++++++++++++
 16 files changed, 139 insertions(+), 68 deletions(-)
 create mode 100644 include/linux/units.h

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
-- 
2.7.4

