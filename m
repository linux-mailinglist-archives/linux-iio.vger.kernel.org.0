Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C41D5680
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 18:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOQtw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEOQtv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 12:49:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98844C061A0C;
        Fri, 15 May 2020 09:49:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id AB6292A32FD
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 0/7] Support inhibiting input devices
Date:   Fri, 15 May 2020 18:49:43 +0200
Message-Id: <20200515164943.28480-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506002746.GB89269@dtor-ws>
References: <20200506002746.GB89269@dtor-ws>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Userspace might want to implement a policy to temporarily disregard input
from certain devices, including not treating them as wakeup sources.

An example use case is a laptop, whose keyboard can be folded under the
screen to create tablet-like experience. The user then must hold the laptop
in such a way that it is difficult to avoid pressing the keyboard keys. It
is therefore desirable to temporarily disregard input from the keyboard,
until it is folded back. This obviously is a policy which should be kept
out of the kernel, but the kernel must provide suitable means to implement
such a policy.

Due to interactions with suspend/resume, a helper has been added for drivers
to decide if the device is being used or not (PATCH 1/7) and it has been
applied to relevant drivers (PATCH 2-5/7). Patches 2-5 are only being sent
to relevant mailing lists and maintainers.

PATCH 6/7 adds support for inhibiting input devices, while PATCH 7/7
provides an example how to convert a driver to take advantage of this
new feature. Patch 7/7 is only being sent to input mailing list and
maintainer.

This work is inspired by:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/45c2d7bb398f74adfae0017e20b224152fde3822

and

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/4ce0e8a3697edb8fd071110b3af65014512061c7

v1..v2:
- added input_device_enabled() helper and used it in drivers (Dmitry)
- the fact of open() and close() being called in inhibit/uninhibit paths has
been emphasized in the commit message of PATCH 6/7 (Dmitry)

Andrzej Pietrasiewicz (5):
  Input: add input_device_enabled()
  Input: use input_device_enabled()
  ACPI: button: Use input_device_enabled() helper
  iio: adc: exynos: Use input_device_enabled()
  platform/x86: thinkpad_acpi: Use input_device_enabled()

Dmitry Torokhov (1):
  Input: elan_i2c: Support inhibiting

Patrik Fimml (1):
  Input: Add "inhibited" property

 drivers/acpi/button.c                       |   8 +-
 drivers/iio/adc/exynos_adc.c                |  11 +-
 drivers/input/input.c                       | 142 ++++++++++++++++++--
 drivers/input/joystick/xpad.c               |   4 +-
 drivers/input/keyboard/ep93xx_keypad.c      |   2 +-
 drivers/input/keyboard/gpio_keys.c          |   4 +-
 drivers/input/keyboard/imx_keypad.c         |   4 +-
 drivers/input/keyboard/ipaq-micro-keys.c    |   2 +-
 drivers/input/keyboard/lpc32xx-keys.c       |   4 +-
 drivers/input/keyboard/pmic8xxx-keypad.c    |   4 +-
 drivers/input/keyboard/pxa27x_keypad.c      |   2 +-
 drivers/input/keyboard/samsung-keypad.c     |   4 +-
 drivers/input/keyboard/spear-keyboard.c     |   8 +-
 drivers/input/keyboard/st-keyscan.c         |   4 +-
 drivers/input/keyboard/tegra-kbc.c          |   4 +-
 drivers/input/misc/drv260x.c                |   4 +-
 drivers/input/misc/drv2665.c                |   4 +-
 drivers/input/misc/drv2667.c                |   4 +-
 drivers/input/misc/gp2ap002a00f.c           |   4 +-
 drivers/input/misc/kxtj9.c                  |   4 +-
 drivers/input/misc/sirfsoc-onkey.c          |   2 +-
 drivers/input/mouse/elan_i2c_core.c         | 112 +++++++++++----
 drivers/input/mouse/navpoint.c              |   4 +-
 drivers/input/touchscreen/ad7879.c          |   6 +-
 drivers/input/touchscreen/atmel_mxt_ts.c    |   4 +-
 drivers/input/touchscreen/auo-pixcir-ts.c   |   8 +-
 drivers/input/touchscreen/bu21029_ts.c      |   4 +-
 drivers/input/touchscreen/chipone_icn8318.c |   4 +-
 drivers/input/touchscreen/cyttsp_core.c     |   4 +-
 drivers/input/touchscreen/eeti_ts.c         |   4 +-
 drivers/input/touchscreen/ektf2127.c        |   4 +-
 drivers/input/touchscreen/imx6ul_tsc.c      |   4 +-
 drivers/input/touchscreen/ipaq-micro-ts.c   |   2 +-
 drivers/input/touchscreen/iqs5xx.c          |   4 +-
 drivers/input/touchscreen/lpc32xx_ts.c      |   4 +-
 drivers/input/touchscreen/melfas_mip4.c     |   4 +-
 drivers/input/touchscreen/mms114.c          |   6 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c   |   8 +-
 drivers/input/touchscreen/ucb1400_ts.c      |   4 +-
 drivers/input/touchscreen/wm97xx-core.c     |  14 +-
 drivers/input/touchscreen/zforce_ts.c       |   8 +-
 drivers/platform/x86/thinkpad_acpi.c        |   4 +-
 include/linux/input.h                       |  10 ++
 43 files changed, 336 insertions(+), 119 deletions(-)


base-commit: 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8
-- 
2.17.1

