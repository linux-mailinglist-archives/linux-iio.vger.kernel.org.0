Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94713512
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfECWCn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:02:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42511 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfECWCm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:02:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so3336174pgh.9
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAkZh+pG3X7RhxhjtR/tZOT3SAC9uY31R80VLP/yIuQ=;
        b=JsedSoz7wKFSnaH6jn4rCeN58mmcMcynZw3khYX3cgPvEqus+JNQZwJcs7t6++F4ia
         WIdviprjMaJ9gvQh8lACs7qxQxaMCYdPdXH9C/Z1g5PQFqd1nrU/rDFcDZR9RNUJHgSP
         AwiXbqHkP3Tu96dinRppVrhvt9EcpANfA4VVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAkZh+pG3X7RhxhjtR/tZOT3SAC9uY31R80VLP/yIuQ=;
        b=aEl0mNI3VB7D+98ulzjEguPsf8WFc9/tQKZCcCvLFHS8O+KmhU95ojw9+jCEVfsi0b
         /T60vxo5HnCMzSj/4DMjWPPzNWDcj6JyMfFCGW4Ea/5dQn1URIjXyF2YRGE5EuNaoyPQ
         7soGou8nIQ3CDnkQLUZzkvODeAtu4LAUSt1wKLjOs1+qiWfaYuU1cCZBF0tjDqm/4iYb
         SOAMZOVAyUtCevStyBiuIz6WEXf1HVhWoHAvch2Gb4MXuFC0ZDaDxMoxFN8drC37jR8v
         3m9bXpPRzKchtcdR1J1KF3J1vZXbVLztQxBrW20LeAE8XUxCARSRL+YKOvK25sAuKLhW
         nh/g==
X-Gm-Message-State: APjAAAXsQu/sL3MelLna5UCt6fInuOZVj2tg6GupFUQhzvYwoR+flxiq
        bJ1Viur5ViDyJ2CRMLUAXJl8vA==
X-Google-Smtp-Source: APXvYqye04AAIXZnSLyIndCwXAXdHVgkKP1uVoNTcf32J5fI9MQPwyrqamzRblzQLzNnMyL3pMWsxQ==
X-Received: by 2002:a62:470e:: with SMTP id u14mr14522795pfa.31.1556920962181;
        Fri, 03 May 2019 15:02:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j14sm3967888pfa.57.2019.05.03.15.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:02:41 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 00/30] Update cros_ec_commands.h
Date:   Fri,  3 May 2019 15:02:03 -0700
Message-Id: <20190503220233.64546-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
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

 include/linux/mfd/cros_ec_commands.h | 3735 +++++++++++++++++++++-----
 sound/soc/codecs/cros_ec_codec.c     |    8 +-
 2 files changed, 2997 insertions(+), 746 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

