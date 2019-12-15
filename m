Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16AF111F5CF
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfLOFQn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:16:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46924 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfLOFQn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:16:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so2998607pll.13;
        Sat, 14 Dec 2019 21:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NG3H+s+fBBFZ6iq8D5+2rLQ1nI3ABlA+Ut9Zp7bqJfw=;
        b=fFllsnGvsEGyNBVt6BCMjcLIs9kK0YQmUxliyDazXC+jL/P/+h+E031C6MADa+BhaZ
         cPem5VxZc6Xui6mUJ2J+heoRkSdY1Tfr4MTSmtCZRK7GATNQ0SnZEGtE2dQAh3bA4em0
         6FjpBSRHNHHvvdNJCh9P7mhoscWbr4ZnvdhXZiCIBrUz+5bROc5rWPW9jbji03z6+1ks
         viwiAT2A0DY9a2/6FuRKgBll3PiZPA5uJtFLf90tssSpQVc1s44SgFV29BuOuz4zVmqH
         jtOCBkhp0T3zV3WUWq53EDbiDfNfQIqx3f4LqSjJN9Hl19b+cLzQxq/47p/UJDq6jxKM
         h5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NG3H+s+fBBFZ6iq8D5+2rLQ1nI3ABlA+Ut9Zp7bqJfw=;
        b=oxmrvZgoVArVicxBmMW+CC8EWikzuYJPgRDxubjXxESJT1lQW639QWhXCr8aNPn6Ol
         DTYLrEi1w24nZlo7PowUsb/g9Xg68k7SVidCv63oFqIGGLE0gPPMLvr3kJ/ZcSVMdNFP
         sJ0D2bih3ppDAoCsDkreQeZiAry4mcxGdgD+/cvyCPg/SrxW80YaOM4h1ky+6BeSW1Yz
         qwtgnK6nLk4cB6X3J3B5VbjUlX954CSeYaEWsNcsEclOTSHKWxFkICQOChrg8wEHdSnh
         9C4YkZ2nvO8O86n20G4YM7jZfdcGAaTjrE8ZUrurgjPu/MIYyaEoW4KBOX1jD3WkZfxk
         BCEQ==
X-Gm-Message-State: APjAAAXMc3hx7J7PWp3vsGTqVnBJ3Za74pm8bxKxt1mpf5iH49H/zVjw
        5ADcsUQkowMQB/IWqbtyGm8=
X-Google-Smtp-Source: APXvYqxgtJdFVOCE8Ms0U4eceOkCGxZyfix7v1NLBAjvEFeByQtDfmu1KxfD+5ueGYi8ZtB7bBjehg==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr9010139pll.219.1576387002224;
        Sat, 14 Dec 2019 21:16:42 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:16:41 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
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
Subject: [PATCH v4 00/12] add header file for kelvin to/from Celsius conversion helpers
Date:   Sun, 15 Dec 2019 14:16:03 +0900
Message-Id: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
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

* v4
- add Reviewed-by and Acked-by tags
- change include order
- keep the line over 80 characters because this change doesn't make it longer
- remove "wireless: " in the title

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
  iwlegacy: use <linux/units.h> helpers
  iwlwifi: use <linux/units.h> helpers
  thermal: armada: remove unused TO_MCELSIUS macro
  iio: adc: qcom-vadc-common: use <linux/units.h> helpers

 drivers/acpi/thermal.c                             | 34 ++++-----
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
 16 files changed, 137 insertions(+), 68 deletions(-)
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

