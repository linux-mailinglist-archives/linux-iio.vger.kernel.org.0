Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8180069E9A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 00:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfGOWCJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 18:02:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42922 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbfGOWCI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 18:02:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so8043896pff.9
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCPSubpdy27KEdSd8ad+9DM8OHn8XbLInkRnh7+Ilo4=;
        b=XC6kQliXcSNPuOjv1iwH385k1fLl9wnfOMzH6Za5UvjvKTkAD/VRXaJnp2pe6jVlDs
         Mn7SB0vmctbaUVXriFuwxJxYjXGoRdZDrUImpkSGfLJaHjPwhf6sQBFtdSFdIhpn2Sqi
         CTCMl5hdYtqSlzM1RGaH4VB/8uVlM5rEzpv1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCPSubpdy27KEdSd8ad+9DM8OHn8XbLInkRnh7+Ilo4=;
        b=he3bowJOp9PGBvXR7T5LnBaIe81QcuqAldlZldjvV7CzcFhxtmaPz4RJiobsTzcNBz
         G8uLUj6/a1d0l81Fck5FVedDfMiSHo7yciesKFEYpODQSUKpwDzZcXlD9IrrbOdVmDKM
         i6Bh8akEf6cCAgW5V3+ZkyR1kXfRve/5NnCZli+w4oB5aHVHOoGi0XnRMr5rh0Xc19FO
         2sO2FT3vR7NooKP2fYfpxNoIvTG8B+4SR94FCpDVi1QuLVUTQAuogur5WrSK0Ux+1OID
         WVaBtHQlASHImsFX9FWZfcsi77+k7N8FLD1sfHIfQNbv1RKiBLd/PKptAAuCfArtJQgO
         YQcQ==
X-Gm-Message-State: APjAAAVdoJWxAogCB4XfSsLKH+bClv7SRZl/xElGjSu9FmD+HRH+eDdw
        L13nwvnbGLcOw5bR4o5JQ+jlLw==
X-Google-Smtp-Source: APXvYqwNv9Dsic3Y/R5VY5HNUxgmpndnNCfhT+byCEiJXHUMhm7OR4OrqXQbIAj33gktWtYFcq0QRQ==
X-Received: by 2002:a17:90b:d82:: with SMTP id bg2mr32147465pjb.87.1563228128042;
        Mon, 15 Jul 2019 15:02:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id f19sm24214919pfk.180.2019.07.15.15.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 15:02:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 0/4] Support accelerometers for veyron_minnie
Date:   Mon, 15 Jul 2019 15:01:48 -0700
Message-Id: <20190715220152.119531-1-gwendal@chromium.org>
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

Changes in v4:
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
 drivers/iio/accel/cros_ec_accel_legacy.c      | 352 ++++--------------
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 4 files changed, 85 insertions(+), 276 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

