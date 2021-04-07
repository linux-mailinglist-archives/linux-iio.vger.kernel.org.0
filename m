Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948FB35741D
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 20:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhDGSWI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhDGSWI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 14:22:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE883C06175F;
        Wed,  7 Apr 2021 11:21:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q5so13494208pfh.10;
        Wed, 07 Apr 2021 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dlc1sRuDYIseXkbsVsNdVVFo1BlO1HPfZjHynec1AU=;
        b=cP+vu7ZuKufAACSPO2HPWNQ4+dhC1xKedlz2O98psVtNVnfI7T2JVrxrdFgwU99NpP
         MTvEs1w6wmkN+YF/yRrbSlR6+IsY36kGJcThgBwUI9h1FTTBXoTgv6bGZTUjOG/6o15u
         pUdkL/rVe1vBJ2zfxYOJKX6MnXIgCXb5Y0Yp87x4Xgr+ZrpLBHdIO/wh0RUarpuhdi7V
         Z2gI5wUIuaifFzEnd2V2ktFaGNG2qOgOgNIdzv26Rvj6VS8Oo6UrtgIDUiSk5LLC0mn3
         DqUTDT/EpFhAPwpnSrgJE0V8vuxOvC7n8rD8BMDnYj+wPWd0w123UBVXwo21Fl8bJK5X
         yjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dlc1sRuDYIseXkbsVsNdVVFo1BlO1HPfZjHynec1AU=;
        b=NcFnKn4glM0rDi/tiCw9BElohLaw6Qjol6JakqHwMFrRf0A8fJrfx/hI+GFnfzOqJ9
         zkTxqNIegHt3FB/FgzPPjBM7BUefgOO4so2x8xWsVMiPEzizp7TPDXsH1F9o/Lbd13Ue
         +dEqQFcr5SYdAwOzn6h/UjDJRfBHfJUHypyEaQX8AdjLJ0epCahGsMkN5lRvEypnbGNX
         sW5UtRHAjZVvmFKEpRg/TC88PsQhyYrSE5NiViNTpQfvQwbMi70Bt+yD1VET3O6uzrnY
         ay/xlVPt6AK3/h4OvC7XvS0sbdnFq9uMMH1zkGU4qisLmmpNHJ/lIJ44rgEq4XFZWgg1
         njHg==
X-Gm-Message-State: AOAM533r6D/iujgh8kDLyHr+0uygNivCKxk5AxSdpB3dBX+D2j41wviB
        XcNHeBsujJZR1YgKUs7DiJc=
X-Google-Smtp-Source: ABdhPJyHSiJS26XsRBKsMJ6vmZtzsXAb8kyURCc9SdP0cV9AksNZl9fw3e3VmqJyVKds1LLbt2rwhQ==
X-Received: by 2002:a63:d841:: with SMTP id k1mr4530431pgj.440.1617819718159;
        Wed, 07 Apr 2021 11:21:58 -0700 (PDT)
Received: from localhost.localdomain ([49.156.71.81])
        by smtp.googlemail.com with ESMTPSA id q22sm20563015pfk.2.2021.04.07.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 11:21:57 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v4 0/2] iio: temperature: add support for tmp117
Date:   Wed,  7 Apr 2021 23:51:45 +0530
Message-Id: <20210407182147.77221-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for tmp117 sensor.

Changes since v3:
1. Remove bug related to caching the calibbias.
2. Expand NV to Non-Volatile.
3. Include limits.h and use its macros in clamp().
Changes since v2:
1. Made Calibbias read and write in same units.
2. Add missing includes.
3. Clamp the values before writing to calibbias.
4. Add i2c description to dt-binding example.
5. Remove explicit casting at different places.
Changes since v1:
1. Remove unused headers
2. Add error checking in i2c read/write.
3. Correct DT bindings.
4. Correct implementation to return tmp in milli celcius.
5. Remove unused mutex lock.
6. Modify MAINTAINERS.
Changes since v0:
1. Correct Yaml syntax.
2. Change IIO_CHAN_INFO_OFFSET to IIO_CHAN_INFO_CALIBBIAS.
3. Implement IIO_CHAN_INFO_SCALE.
4. Use devm_iio_device_register().
5. Remove unused headers like delay.h

Puranjay Mohan (2):
  dt-bindings: iio: temperature: Add DT bindings for TMP117
  iio: temperature: add driver support for ti tmp117

 .../bindings/iio/temperature/ti,tmp117.yaml   |  41 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/tmp117.c              | 184 ++++++++++++++++++
 5 files changed, 243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
 create mode 100644 drivers/iio/temperature/tmp117.c

-- 
2.30.1

