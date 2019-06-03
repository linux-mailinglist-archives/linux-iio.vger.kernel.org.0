Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD23337EA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFCSeI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:34:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37254 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCSeH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id 20so8776215pgr.4
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMm3tcPOrrK8tIoq8oT9gk0/r727fXOc1tebJgYu2Sw=;
        b=ZEy6TWExPeP5gABfGQNd1Z7UgaOyMyRV5h3+HhRUFWa9YK4pIKlzz9hm8yasAXu1Z7
         uSI/5H14hoCeAy70BDaQN11YQsoDp5nlp6K5FRHWVqJiCjhnBnuxrLAVjhVL2MEEMucO
         ArMLSNFye5QXV42DdZrv7mC3u86TzX7IJwSMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMm3tcPOrrK8tIoq8oT9gk0/r727fXOc1tebJgYu2Sw=;
        b=exLWczslwRhwPw1LeJtTM4qg/SMfVFWb04jpWJN2pW8Mw3yfvKuJg9s0raEl5jtvsy
         JdEcnKj3Jmj0VGVA34XV/cOJMUup0K/W///J2fDp9muwo1Yin6f0vZePt7HoQIh0d7KB
         xTHU5uqgLFeeQXY9v8ecQhDfoUIJfoLY20QjjIq8i+INADE6mz3d3hz7fEXRzTE3Ao9L
         eKhJmZIqDkZ6R6C0osvBbQucFoTFeKJOe3qPAF0cpv3Doj7BJXoyR5x8YolrkbQJNCUS
         XsX68uM0+UpWi2pZEO4zivbaZjyWyF2pHz7qlTfgAzw2u5me2Hq/eltTmDOO9X0Ai1Dr
         1Utg==
X-Gm-Message-State: APjAAAVR496owxYZnfvboEAPoH6E7DlNDIbEqUEv1mQ8Vrj4s3XZywAu
        Kl6gceAni3NYR7lXV/z0hrNdAg==
X-Google-Smtp-Source: APXvYqwBmiL5k+2ddQT3SaivO2LUTpE1S9J9MlaHPCVbvu7tNhvMpErqzNivenjCl/SMFrlSdiCNDw==
X-Received: by 2002:a63:6c87:: with SMTP id h129mr30982099pgc.427.1559586846808;
        Mon, 03 Jun 2019 11:34:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y24sm1611759pfn.63.2019.06.03.11.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:06 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 00/30] Update cros_ec_commands.h
Date:   Mon,  3 Jun 2019 11:33:31 -0700
Message-Id: <20190603183401.151408-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The interface between CrosEC embedded controller and the host,
described by cros_ec_commands.h, as diverged from what the embedded
controller really support.

The source of thruth is at
https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h

That include file is converted to remove ACPI and Embedded only code.

From now on, cros_ec_commands.h will be automatically generated from
the file above, do not modify directly.

Fell free to squash the commits below.

v3 resent: Add Fabien's ack.

Changes in v3:
- Rebase after commit 81888d8ab1532 ("mfd: cros_ec: Update the EC feature codes")
- Add Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>

Changes in v2:
- Move I2S changes at the end of the patchset, squashed with change in
  sound/soc/codecs/cros_ec_codec.c to match new interface.
- Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Gwendal Grignou (30):
  mfd: cros_ec: Update license term
  mfd: cros_ec: Zero BUILD_ macro
  mfd: cros_ec: set comments properly
  mfd: cros_ec: add ec_align macros
  mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
  mfd: cros_ec: use BIT macro
  mfd: cros_ec: Update ACPI interface definition
  mfd: cros_ec: move HDMI CEC API definition
  mfd: cros_ec: Remove zero-size structs
  mfd: cros_ec: Add Flash V2 commands API
  mfd: cros_ec: Add PWM_SET_DUTY API
  mfd: cros_ec: Add lightbar v2 API
  mfd: cros_ec: Expand hash API
  mfd: cros_ec: Add EC transport protocol v4
  mfd: cros_ec: Complete MEMS sensor API
  mfd: cros_ec: Fix event processing API
  mfd: cros_ec: Add fingerprint API
  mfd: cros_ec: Fix temperature API
  mfd: cros_ec: Complete Power and USB PD API
  mfd: cros_ec: Add API for keyboard testing
  mfd: cros_ec: Add Hibernate API
  mfd: cros_ec: Add Smart Battery Firmware update API
  mfd: cros_ec: Add I2C passthru protection API
  mfd: cros_ec: Add API for EC-EC communication
  mfd: cros_ec: Add API for Touchpad support
  mfd: cros_ec: Add API for Fingerprint support
  mfd: cros_ec: Add API for rwsig
  mfd: cros_ec: Add SKU ID and Secure storage API
  mfd: cros_ec: Add Management API entry points
  mfd: cros_ec: Update I2S API

 include/linux/mfd/cros_ec_commands.h | 3658 ++++++++++++++++++++------
 sound/soc/codecs/cros_ec_codec.c     |    8 +-
 2 files changed, 2915 insertions(+), 751 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

