Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2392220BD
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 01:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEQXjD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 May 2019 19:39:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36462 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfEQXjD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 May 2019 19:39:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so4034379plr.3
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2019 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gZh6LcPIYENuLrq70OVrhE14Oi6QufFQBK4s4YRnTA=;
        b=EhXvzRJ2UNIKuLYIDrYvKv7KlCJ6hRvEdoKK4G+NX9Cy3ga1z8x2Nr1dLy4TCfWI1O
         qL0ke7KwVeOA+vRJ6MaIRQjOJNX2BIEvwwIdYyAi9G3mbKCsFsQA/hW+8kxDoeg3Suoa
         0FjzyYPtbOwgzRugPy26xg40vCKMm7clLdCfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gZh6LcPIYENuLrq70OVrhE14Oi6QufFQBK4s4YRnTA=;
        b=mMfYChhOCVuQ/B8k+4oYqc5GwyhxglZZdSyRCPr+Zt5BDlLqXFJ29a+/+GP8i4DEdw
         DBrpaSdPaw6lgqVCvZppGJJhCbGXF2VrgMGz7McK7QYLkR8o7vupGgGPf9DK18ln4WDE
         8Y1SYagVBIotdXTZwDDq/0IghsU1kgz3Ajqhxwk0Sq4mudI8bQ3/xNUjU0It4sWkFWnr
         3GxBqHz0Ns1oTUDf3B0mnecyP+lKBlvy5wKfF54dfBrnxoHwC1UgnpfniFQMYSzXrPMA
         b/svXNaHV+2tFuevhzIFrI1VaHV9DuIqU/OhYrIwCXneAWkxQZ/Mb2bg/0pVT7g38gm0
         rnww==
X-Gm-Message-State: APjAAAXqS+iuoBHQbOBliHO3Tz4SHSTcDNX0BQIryJLS5uWqGRjpV4wm
        g42C23OOf7x46IBmq/tm1JIvug==
X-Google-Smtp-Source: APXvYqwnCjmbdahiVCeyMEGBBy/0dbUgS20VbJ6HKGzQTQ7jzlmlJtcP33gai1+X0v2x8vrlINpAkg==
X-Received: by 2002:a17:902:56d:: with SMTP id 100mr59564890plf.246.1558136342873;
        Fri, 17 May 2019 16:39:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j184sm10081827pge.83.2019.05.17.16.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 16:39:02 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 0/2] iio: cros_ec: Add lid angle driver
Date:   Fri, 17 May 2019 16:38:54 -0700
Message-Id: <20190517233856.155793-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a IIO driver that reports the angle between the lid and the base for
ChromeOS convertible device.

Tested on eve with ToT EC firmware.
Check driver is loaded and lid angle is correct.

Changes in v7:
- Split the patch in two, as there are no build dependency between
  mfd and iio changes.

Gwendal Grignou (2):
  mfd: cros_ec: Register cros_ec_lid_angle driver when present
  iio: cros_ec: Add lid angle driver

 drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
 drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
 .../cros_ec_sensors/cros_ec_lid_angle.c       | 139 ++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                     |  13 +-
 4 files changed, 159 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c

-- 
2.21.0.1020.gf2820cf01a-goog

