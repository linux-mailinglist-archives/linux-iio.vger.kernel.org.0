Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD09551E91
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 00:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfFXWxV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 18:53:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46528 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfFXWxU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 18:53:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so8311820pfy.13
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2019 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8X4a2I3UEAgfVulSk9qJJZ9XdiWRbXBIr75xQcaE5hI=;
        b=AMhKC6x3EncwHOdUsPX6znX/UxTD43Z1udgsicNyhnNgZrqgCp4Tlzho0B1NyzEMKv
         mCgHH4O0YzT0SDYHSn8/gWK+hcY1q66l/UUNPNHcbLRg9/dACJGAXYkf244aSMpkOtcD
         4NptKtuYUBurwqHlqa0KI9JblX1A8RSSMZMak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8X4a2I3UEAgfVulSk9qJJZ9XdiWRbXBIr75xQcaE5hI=;
        b=jq9GffBWOhwCI8XAf05Nn2oWV1oFDUMATOcChM1HE9W22/xzRfRhec/HzZLBBYFej8
         OK7tPr9qdigvGCtd5B2b1rFUofZ8r9ntKoW5l4Lc9imFD0NSvZFrr9yxV7R7dAjBjTP5
         0+MG64rGpq3bEM2ZZtML9TzNOf5n0i3bVge1P1kmTn3MAJw9gpMnzDvVq0nSfTGVG6ts
         JtYZIHZN3pLeP+mA3HR6tmMCHFb5jzmS7WwcdAQOoRgOe+pvPN79iykIJsVVYZ9xrehZ
         muRCxqrl177m3vP7pi/S1noT02ERXRwdOyqRbb8wABZzpKnQCWhAAcAW7zFixF10jViV
         To4Q==
X-Gm-Message-State: APjAAAXMR9ifOaxLYVhUffNwygBz7B0LiV6vl9bJH1Gp/5ri6aqZPl79
        2duSAwRTljGI3DUPvhwbJ3kxDg==
X-Google-Smtp-Source: APXvYqwiQ/ya2iveU/sGnXXcnpD7Bx0CBHuWR/TAmPUUgoL2DmJqioivzjHHoe37CenjlNIdwYOiQQ==
X-Received: by 2002:a17:90a:62cb:: with SMTP id k11mr26468906pjs.26.1561416800005;
        Mon, 24 Jun 2019 15:53:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id n184sm12038681pfn.21.2019.06.24.15.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 15:53:19 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/2] Support accelerometers for veyron_minnie
Date:   Mon, 24 Jun 2019 15:53:10 -0700
Message-Id: <20190624225312.131745-1-gwendal@chromium.org>
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
  iio: cros_ec: Extend legacy support to ARM device

Changes in v3:
- Fix commit message, add reviewed-by for first patch.

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

