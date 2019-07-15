Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7D869F5F
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 01:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfGOXPA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 19:15:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46646 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfGOXO7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 19:14:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so9037392plz.13
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 16:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FU8IMjJPzjG6kKRsyfcfIbyIZ6mHmsnfbPuAZ82K2Hg=;
        b=fTil10kgtaNkg9CYmDnlWNkcgIQA4uv+PbV22af1r36JLYHbZ5Vi8IDjnUFVmheOH+
         v/QTk1S38lyMQe1KdC9ukshk/5R+3/fbYys3xbjphyN2MqWYxl5J/TgOPxvu6eYawT2F
         odbwyTxQEMraYhd0Xn/wDFSAxcE5nN5XP0soM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FU8IMjJPzjG6kKRsyfcfIbyIZ6mHmsnfbPuAZ82K2Hg=;
        b=UnYG/qbhq4j+luvRsdoaVit2gnXfHSZxwkwDREN9k2Z0jxCWYDNuQr2hhwXlTYSvnt
         +Z6Rpk02fnXK/jxGf99FVDrmc9y3KurLpsjdO2Cqkbb6wBXoYzlT34kAepHq8yaVXpLu
         SD7f3Bh09inIO1NKMN+whZsscKoPIYGRQFyC0uMqDixF1v0YWbG7380I93YkttXI/Q/X
         x7gYoT8ziAwsBgUL4fj9xgG7RacpAtsRaEx6pliz36o4EcBRAG1yY1stLMyJJBck79fF
         b9Lcf3IG+xcO+KpxG5v3gTdHQHSb+feI9ECKHDyareyLQlug0AcV0AX3Ry57e3jGt7HR
         0czw==
X-Gm-Message-State: APjAAAULvsxNoidSN8EdfilJmGESEX1VQ8tc/Q2TFPrpCGlncZIHqqIx
        565XWNCjeHucoQBLZgxvHF37Vg==
X-Google-Smtp-Source: APXvYqzaFE7wI61EvT9ji/uduljupNw5mhDUENedOWsCFlmaNupV9td4MfU2vBVAZ4zHYCMcdbYdtA==
X-Received: by 2002:a17:902:724:: with SMTP id 33mr30530789pli.49.1563232499034;
        Mon, 15 Jul 2019 16:14:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id a3sm20225805pfo.49.2019.07.15.16.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 16:14:58 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 0/4] Support accelerometers for veyron_minnie
Date:   Mon, 15 Jul 2019 16:14:50 -0700
Message-Id: <20190715231454.189459-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

veyron_minnie - ASUS Chromebook Flip C100PA - embedded controller
controls two accelerometers, one in the lid, one in the base.
However, the EC firmware does not follow the new interface that
cros_ec_accel driver use.
Extend the legacy driver used on glimmer - Lenovo ThinkPad 11e
Chromebook - to veyron_minnie.
veyron_minnie being ARM based, issue command over the I2C bus to the EC
instead of relying on the shared registers over LPC.

Gwendal Grignou (4):
  iio: cros_ec: Add sign vector in core for backward compatibility
  iio: cros_ec_accel_legacy: Fix incorrect channel setting
  iio: cros_ec_accel_legacy: Use cros_ec_sensors_core
  iio: cros_ec_accel_legacy: Add support for veyron-minnie

Changes in v5:
- In "Use cros_ec_sensors_core", fix return without unlock on the error
  path properly.

Changes in v5:
- In "Use cros_ec_sensors_core", fix return without unlock on the error
  path.
- Add acked for the last 2 patches.

Changes in v4:
- No change in iio/common/cros_ec_sensors
- Split cros_ec_accel_legacy code in 3:
  - fix an error in channel setting.
  - remove duplicate code in cros_ec_accel, use cros_ec_sensors_core.
  - extend cros_ec_accel to ARM device.
- Define cros_ec_accel_legacy_read_cmd() as static.

Changes in v3:
- Fix commit message, add reviewed-by for first patch.

Changes in v2:
- Readd empty line to reduce amount of change in patch.
- Remove Keywords used by ChromeOS commit queue.


 drivers/iio/accel/Kconfig                     |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      | 353 ++++--------------
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 4 files changed, 86 insertions(+), 276 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

