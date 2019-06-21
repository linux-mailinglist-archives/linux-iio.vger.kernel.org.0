Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28B64DF29
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2019 04:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfFUClV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 22:41:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34213 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfFUClU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jun 2019 22:41:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so2237210plt.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2019 19:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6UYnK9gp9yNfxMsM9VqGe2VrudvgBc5ep+Vc0J9WtE=;
        b=T5PljLkTRydUuza9jkLoqt4cm7UrQgMDePYpIBS6elrS00B7Z4HZt8PL1FyiUHSqv/
         D4koYA2I2/y+zQSJKZsEnCrbktetQfhnyZrRug0t3phq31c7snHPbrKBkFKx8wL/Ugmt
         r54F1Ne3/STy/ENLUSdwXoMExxnZ8OKiJ+aB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6UYnK9gp9yNfxMsM9VqGe2VrudvgBc5ep+Vc0J9WtE=;
        b=Tg1JPEIwQlZrtZdGxIS3HUPf039VhkFb0KmJfa+zawd3c84xIucxypkT07Ui3g53yy
         BpY8prtGt+duZzKMC/EAwGtRXk+Z/gZKctmkrVMpllsULYbAPXDktg3yzl8WF3WaHlk3
         5108lSkzEKQJxNfSmjTrJbiKjHMCvD37y7TQ0yW4sCqYcD7AUJQVR664kKXD864G+qqH
         OjySb5AqykLWZMPbKatAIZ98LA3IRasntztOyQW3EbW9n6l+ZRJQA4tvrS+cVJ0XZD8N
         wbSNlXtq77Nen7Lo2eFS03LfVCLLlaCbXETODtOpMmuctZsLey6g4tns8RU/IIIF933M
         URiQ==
X-Gm-Message-State: APjAAAUyzbkKs+UuSAye8YjqesV4/tw0O2a67IBUlcenEYtpezZCuRvO
        oqN+Hcw0EaiBvZo8HFl6/Kxq4w==
X-Google-Smtp-Source: APXvYqzsifsrEB1ggaGeA3mdGyJpbcnheW+0O9MlXbOP9yM/VM87uMESboSM87LnaZ1mcFcHFQiM5g==
X-Received: by 2002:a17:902:148:: with SMTP id 66mr120206912plb.143.1561084880070;
        Thu, 20 Jun 2019 19:41:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 133sm804642pfa.92.2019.06.20.19.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 19:41:19 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] Support accelerometers for veyron_minnie
Date:   Thu, 20 Jun 2019 19:41:04 -0700
Message-Id: <20190621024106.158589-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
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

Gwendal Grignou (2):
  iio: cros_ec: Add sign vector in core for backward compatibility
  iio: cros_ec : Extend legacy support to ARM device

Changes in v2:
- Readd empty line to reduce amount of change in patch.
- Remove Keywords used by ChromeOS commit queue.

 drivers/iio/accel/Kconfig                     |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      | 350 ++++--------------
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 4 files changed, 84 insertions(+), 275 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

