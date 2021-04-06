Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3774355B57
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 20:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhDFS3Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhDFS3N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 14:29:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AACC06174A;
        Tue,  6 Apr 2021 11:29:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id ay2so7989854plb.3;
        Tue, 06 Apr 2021 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GpvMY+lxokF6EPS0g4j7H+yAV3dww7h5fzpkJxPPkw=;
        b=jANOBMan2mimMPVte7DSQh2fQPoZKDhGr5u5uCPdRpOdAbDgXecSuyoJaAWbg3yhSN
         /4j0uL0BOPn17T5k6f7kJdQfviv93m+GslqVUgJuSQ/5eSeofjcU9uyHnAey9wDD9hkl
         lHoZz1a3hZEPmKPVC77iTH2VxcD4SxY2aW9vPflEIfpu/EIOQhGHMVrMEFf/P1gCatgk
         K+76BPb5EglFttM2Ybyjlp2LBOpiuLOq+jHsv+sCFsMPF+Z8n9rO+3bZvtFNZv4UA+XU
         o2q78FbU6UUE9Xk6IYnflHKgnDhVyioVwNaI7PuDh49OrBd3GSWsfK1eZOUabUKC6/Dy
         jqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GpvMY+lxokF6EPS0g4j7H+yAV3dww7h5fzpkJxPPkw=;
        b=AOknTVBktzS1eQYwGUKlfwE1mEfc3CIGnp0WAiCdfdEfKQgSyupuoIJ2fHtZy+6NRN
         Br27UGJNkn7GT3Tt7suBzluqM4yuKr8kpzG7CnPmdHuFD8K4YUoGHECRICer0odsclLV
         OdEyZE3vcUlGZMNThNrgKeE7t+Me4GDb5hIMv/7uAlpc1FKjqHEHKLva32E8cJ2TVyVi
         U7/TpxCCBShNHtMNoR6RMF41CTJaJdkk5gVbOPYriAyU7qqUc8z5GqCPiPizt613XgGy
         w6iSKDjDvDabo5/4LyMS0TFGEbjfzR7sZaZI033T1MpOv/4OaFSpayYExmNTGS1PMaa7
         PF4A==
X-Gm-Message-State: AOAM5331rEH2JfKygEEpadGHIkTHCoJRH+r/s6mFBIde88FK/wZpQe8+
        vlLa5SfcZElOrhx70UJk9rrn2zRAoVuxyG0r
X-Google-Smtp-Source: ABdhPJyT+fEv/VdBl0CjEN+J+rznkxypMBIzvrCRp8on01vrqbC5KcEhAwrco951B0n4bxiIq59i2g==
X-Received: by 2002:a17:902:e843:b029:e7:3c04:8d70 with SMTP id t3-20020a170902e843b02900e73c048d70mr30128224plg.48.1617733744825;
        Tue, 06 Apr 2021 11:29:04 -0700 (PDT)
Received: from localhost.localdomain ([124.253.94.185])
        by smtp.googlemail.com with ESMTPSA id x25sm19652383pfn.81.2021.04.06.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:29:04 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v3 0/2] iio: temperature: add support for tmp117
Date:   Tue,  6 Apr 2021 23:58:50 +0530
Message-Id: <20210406182852.263605-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for tmp117 sensor.

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
 drivers/iio/temperature/tmp117.c              | 182 ++++++++++++++++++
 5 files changed, 241 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
 create mode 100644 drivers/iio/temperature/tmp117.c

-- 
2.30.1

