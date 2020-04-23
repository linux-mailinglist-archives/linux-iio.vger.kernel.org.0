Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673E31B5115
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 02:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDWACh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 20:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDWACg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 20:02:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEDC03C1AB
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2020 17:02:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d17so1960302pgo.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2020 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PitJZLSh8FX/H+hNsELa/boJvIBRP85pYm/veh8bMug=;
        b=Jlf8Pn1X7oG+tjm11lLjt/iVrUiz/YSvXh9WXKKkBZVleXsWU1xqHhzjY8mNsFDrEM
         a4NqwZvTew7aXbMa5RUkr9rLY+OhXYHiqjOYpOpplPsn1LMZJfTCD3rs56Yy0jguZjF4
         G2mBReItWnaYCZHKunleEE7Shb3YHyR2/Q6fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PitJZLSh8FX/H+hNsELa/boJvIBRP85pYm/veh8bMug=;
        b=QIBr+LW3MfgL/NZj6QdxZHAzKcuLkZTuiAoKAmjDMQYB0n0HqFphwxcCsqdp1jZTdH
         GVnnF9CF771pruu/foBuCB5RIMtliTEiN9HE20zgEdjhllCpgs/235GS879XDfWAUT6Z
         9tWQtjEeTi5rUgYSyfFyYu3bylcdUpenOEZpt4INutanwKYgkLQ70RWcyiRv77HMmadA
         RBmjHueC+ZGbFzkCAJq9k3CUIqOwXEdbjpq1z4LbUzzaTz3gcHEZBKsQZbJxjeKSReL3
         ToiWkx5paDyx+3s8yG2UFVtYjLMTX1W19u1JjjWq0ukXKrR+haP6b/fMJfaC2x7FJMvx
         ND5Q==
X-Gm-Message-State: AGi0PuaqJs9qPEUPqc2OuxiAYSJr5tOTcxBlpxO8oeAG+K/eXyZB1Y7o
        SmqrElXSPX8w5d8mbxuZVvVyUA==
X-Google-Smtp-Source: APiQypL2YbCjuii692n7GM9WnGt6oTqOQcuBhUzTEba3QCu5V18FkquL+nWFNRRUwucWYPWMVmCl+w==
X-Received: by 2002:aa7:94b5:: with SMTP id a21mr1063589pfl.290.1587600154067;
        Wed, 22 Apr 2020 17:02:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id d74sm656351pfd.70.2020.04.22.17.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:02:33 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, jic23@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] iio: cros_ec: Add support for RGB light sensor
Date:   Wed, 22 Apr 2020 17:02:28 -0700
Message-Id: <20200423000230.82750-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for color light sensor presented by the Chromebook Embedded
Controller (EC).
Instead of just presenting lux measurement (clear channel), a color light
sensor is able to report color temperature measurement.

The EC, using factory settings, can transform the raw measurement into
the CIE 1931 XYZ color space (XYZ) and take adavantage of color sensor
autocalibration to provide the most accurate measurements.

Gwendal Grignou (2):
  iio: cros_ec: Allow enabling/disabling calibration mode
  iio: cros_ec_light: Add support for RGB sensor

 .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
 drivers/iio/light/cros_ec_light_prox.c        | 470 +++++++++++++++---
 drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 -
 .../linux/platform_data/cros_ec_commands.h    |  14 +-
 5 files changed, 415 insertions(+), 76 deletions(-)

-- 
2.26.1.301.g55bc3eb7cb9-goog

