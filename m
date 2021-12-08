Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C631946C97B
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 01:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhLHAqs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Dec 2021 19:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbhLHAqq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Dec 2021 19:46:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65965C061574
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 16:43:15 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z6so421900plk.6
        for <linux-iio@vger.kernel.org>; Tue, 07 Dec 2021 16:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpQ+FZHT+FJ4kjpOy7vmGr31PdW6YC+aT42hA68N5VE=;
        b=Vz1EOk4aBEDABjXuD7NDtWBQ4FS/qf/sKqf3GHWn0hJOAJElrfAMYwG7BWS+i3jX5p
         zTdeLG9TNcdGW4Jz/uHZ9vDJLGwUjulFJ9uwodkE4S35biDBbyWwYom0/wXazEWRyjLn
         4HWa0iHx7eD4yZOIw5WEcGqmxHffr91ayHhe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpQ+FZHT+FJ4kjpOy7vmGr31PdW6YC+aT42hA68N5VE=;
        b=dx6vOTqeOOCJBDvShogOn5X5/0MeGpB1grOekxVgvtIOXhiRDFznOPfE5DH8iE7Klh
         LIc8+7R573n+6wT+uVfqOVLwJ04X+O/duM5XdshQy1nvMTCsShpDSMSse+YPrUdUTINn
         GBCYY/u6Zs+Xu28WtUSOGzEv1iN3A+zamXPxbj3Cyms4+Fi1T9mDvAwIFuVVBAqh4683
         JsobQ6RTQ7mk+Oi8OFfUZGcaPsOANDhk/J9W2AlJfU6wnHZGPAyg8iRcBSwn2MFhyVZ/
         56fwnqepfHheoKwklTPp+2dObVScajmME8c/mOr7woKq201d3O9vyHMOOJHosmWxJcPW
         HnVg==
X-Gm-Message-State: AOAM531skfHFotPXI7fwjrN/hDLyOxyB5JluetKUlXCkbOo4yOM0sqlY
        PA4Llmx/Psr9wz2SmWmdUoxIVw==
X-Google-Smtp-Source: ABdhPJzFdRuIyygVdyaO3XZjn0WaCzr5y+tmS/U1EETez9hJBrqmwTfsVgIQQptBkzTBPZ3tTgn9gg==
X-Received: by 2002:a17:90b:17cd:: with SMTP id me13mr3200079pjb.79.1638924194983;
        Tue, 07 Dec 2021 16:43:14 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e4:362a:40f4:7f9f])
        by smtp.gmail.com with UTF8SMTPSA id z14sm984271pfh.60.2021.12.07.16.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 16:43:14 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 0/5] Expand Semtech SAR Sensors support
Date:   Tue,  7 Dec 2021 16:43:06 -0800
Message-Id: <20211208004311.3098571-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

Major changes in v5:
  Use iwyu to cleanup include files.
  Use dev_err_probe() in probe routine
  Add attribute to shift irq status register, not common among all
    sensors.
  Fix long line.

Major changes in v4:
  Use chip_info instead of info in common data.
  Returns an error when setting negative sysfs entries
  Fix cut and paste errors, credit.

Major changes in v3:
  Fix some error in binding descriptions and setting
  Fix invalid register constant name.

Major changes in v2:
  Better interface between common code and drivers
  Document SX9324 phase configuration

Gwendal Grignou (5):
  iio: sx9310: Add frequency in read_avail
  iio: sx9310: Extract common Semtech sensor logic
  iio: proximity: Add SX9324 support
  dt-bindings: iio: Add sx9324 binding
  iio: sx9324: Add dt_binding support

 .../ABI/testing/sysfs-bus-iio-sx9324          |   28 +
 .../iio/proximity/semtech,sx9324.yaml         |  161 +++
 drivers/iio/proximity/Kconfig                 |   18 +
 drivers/iio/proximity/Makefile                |    2 +
 drivers/iio/proximity/sx9310.c                |  714 ++---------
 drivers/iio/proximity/sx9324.c                | 1074 +++++++++++++++++
 drivers/iio/proximity/sx_common.c             |  576 +++++++++
 drivers/iio/proximity/sx_common.h             |  163 +++
 8 files changed, 2125 insertions(+), 611 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h

-- 
2.34.1.400.ga245620fadb-goog

