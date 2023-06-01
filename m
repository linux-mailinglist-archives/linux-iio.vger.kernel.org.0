Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D1719D26
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jun 2023 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjFANRQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jun 2023 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjFANRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jun 2023 09:17:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D5BE7;
        Thu,  1 Jun 2023 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685625434; x=1717161434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7rTn8BHWOp7NtmIZTi6wbClky6r1q098Fh3m1tEa+1U=;
  b=H/2E92BdNHGZSGYJ4U8gfxiewWm+ktDYKHv4B/1d3kZm9kOn96uCIPw7
   CH1n+cWRV8DF6Deo7iBoFjfMlbUdN/UuSKs1Wdm/vnfDg4x6m/AROA1P0
   CDLcRJTX4uuJkm5ZWHLBbwQDdwx+9bxON08Ey8ZHuK7cHakuYw6Xu5rz7
   Jp8Nof0qSTx2iZhoVP/WO9fqrY/JVunHjtjlHudNklG62vswE5wTpXiIa
   /+YklNOBbpRAL7vbEPrJ/ROap3XFL/YQrf0kpvD7naTPEp7BFPAEia1yY
   oWZHESGhioYnQrbcQ+z2Fy1WOVrAYL1YryXFgSpsgJMTfvbt9jTmPbdpl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353050858"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="353050858"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:17:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="737104338"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="737104338"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:17:04 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, jic23@kernel.org, lars@metafoo.de,
        bleung@chromium.org, yu.c.chen@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, luzmaximilian@gmail.com,
        corentin.chary@gmail.com, jprvita@gmail.com,
        cascardo@holoscopio.com, don@syst.com.br, pali@kernel.org,
        jwoithe@just42.net, matan@svgalib.org, kenneth.t.chan@gmail.com,
        malattia@linux.it, jeremy@system76.com, productdev@system76.com,
        herton@canonical.com, coproscefalo@gmail.com, tytso@mit.edu,
        Jason@zx2c4.com, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v4 00/35] Remove .notify callback in acpi_device_ops
Date:   Thu,  1 Jun 2023 15:16:55 +0200
Message-Id: <20230601131655.300675-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently drivers support ACPI event handlers by defining .notify
callback in acpi_device_ops. This solution is suboptimal as event
handler installer installs intermediary function acpi_notify_device as a
handler in every driver. Also this approach requires extra variable
'flags' for specifying event types that the driver want to subscribe to.
Additionally this is a pre-work required to align acpi_driver with
platform_driver and eventually replace acpi_driver with platform_driver.

Remove .notify callback from the acpi_device_ops. Replace it with each
driver installing and removing it's event handlers.

v4:
 - added one commit for previously missed driver sony-laptop,
   refactored return statements, added NULL check for event installer
v3:
 - lkp still reported some failures for eeepc, fujitsu and
   toshiba_bluetooth, fix those
v2:
 - fix compilation errors for drivers

Michal Wilczynski (35):
  acpi: Adjust functions installing bus event handlers
  acpi/ac: Move handler installing logic to driver
  acpi/video: Move handler installing logic to driver
  acpi/battery: Move handler installing logic to driver
  acpi/button: Move handler installing logic to driver
  acpi/hed: Move handler installing logic to driver
  acpi/nfit: Move handler installing logic to driver
  acpi/thermal: Move handler installing logic to driver
  acpi/tiny-power-button: Move handler installing logic to driver
  hwmon/acpi_power_meter: Move handler installing logic to driver
  iio/acpi-als: Move handler installing logic to driver
  platform/chromeos_tbmc: Move handler installing logic to driver
  platform/wilco_ec: Move handler installing logic to driver
  platform/surface/button: Move handler installing logic to driver
  platform/x86/acer-wireless: Move handler installing logic to driver
  platform/x86/asus-laptop: Move handler installing logic to driver
  platform/x86/asus-wireless: Move handler installing logic to driver
  platform/x86/classmate-laptop: Move handler installing logic to driver
  platform/x86/dell/dell-rbtn: Move handler installing logic to driver
  platform/x86/eeepc-laptop: Move handler installing logic to driver
  platform/x86/fujitsu-laptop: Move handler installing logic to driver
  platform/x86/lg-laptop: Move handler installing logic to driver
  platform/x86/panasonic-laptop: Move handler installing logic to driver
  platform/x86/system76_acpi: Move handler installing logic to driver
  platform/x86/topstar-laptop: Move handler installing logic to driver
  platform/x86/toshiba_acpi: Move handler installing logic to driver
  platform/x86/toshiba_bluetooth: Move handler installing logic to
    driver
  platform/x86/toshiba_haps: Move handler installing logic to driver
  platform/x86/wireless-hotkey: Move handler installing logic to driver
  platform/x86/xo15-ebook: Move handler installing logic to driver
  platform/x86/sony-laptop: Move handler installing logic to driver
  virt/vmgenid: Move handler installing logic to driver
  acpi/bus: Remove installing/removing notify handlers from probe/remove
  acpi/bus: Remove redundant functions
  acpi/bus: Remove notify callback and flags

 drivers/acpi/ac.c                             |  14 +-
 drivers/acpi/acpi_video.c                     |  16 ++-
 drivers/acpi/battery.c                        |  16 ++-
 drivers/acpi/bus.c                            |  56 +++-----
 drivers/acpi/button.c                         |  16 ++-
 drivers/acpi/hed.c                            |   7 +-
 drivers/acpi/nfit/core.c                      |  25 ++--
 drivers/acpi/thermal.c                        |  20 ++-
 drivers/acpi/tiny-power-button.c              |  18 +--
 drivers/hwmon/acpi_power_meter.c              |  15 +-
 drivers/iio/light/acpi-als.c                  |  23 +++-
 drivers/platform/chrome/chromeos_tbmc.c       |  14 +-
 drivers/platform/chrome/wilco_ec/event.c      |  17 ++-
 drivers/platform/surface/surfacepro3_button.c |  17 ++-
 drivers/platform/x86/acer-wireless.c          |  22 ++-
 drivers/platform/x86/asus-laptop.c            |  14 +-
 drivers/platform/x86/asus-wireless.c          |  24 ++--
 drivers/platform/x86/classmate-laptop.c       |  53 +++++--
 drivers/platform/x86/dell/dell-rbtn.c         |  17 ++-
 drivers/platform/x86/eeepc-laptop.c           |  16 ++-
 drivers/platform/x86/fujitsu-laptop.c         |  86 +++++++-----
 drivers/platform/x86/lg-laptop.c              |  10 +-
 drivers/platform/x86/panasonic-laptop.c       |  18 ++-
 drivers/platform/x86/sony-laptop.c            |   9 +-
 drivers/platform/x86/system76_acpi.c          |  26 ++--
 drivers/platform/x86/topstar-laptop.c         |  14 +-
 drivers/platform/x86/toshiba_acpi.c           | 129 +++++++++---------
 drivers/platform/x86/toshiba_bluetooth.c      |  30 ++--
 drivers/platform/x86/toshiba_haps.c           |   9 +-
 drivers/platform/x86/wireless-hotkey.c        |  24 +++-
 drivers/platform/x86/xo15-ebook.c             |   9 +-
 drivers/virt/vmgenid.c                        |  30 ++--
 include/acpi/acpi_bus.h                       |  10 +-
 33 files changed, 530 insertions(+), 294 deletions(-)

-- 
2.40.1

