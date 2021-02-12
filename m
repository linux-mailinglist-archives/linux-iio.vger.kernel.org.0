Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0231A37E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhBLRXa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 12:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhBLRXV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 12:23:21 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E1C061756
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 09:22:41 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x63so7943951pfb.12
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 09:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=aroeJSyNxu0+JeuMKne8ORfmBNS+7h3YYPDPke6aLMA=;
        b=IX/1JTBdvMenAORdbmNvdhxNDH2c26vW8FC+ioe/JRtYG3Xeyp7graKc0aITIDuLZC
         Iy6F4QCtlwaCokB+rwIb2Xpas5WeRwhKqqkPhe7czQV1C4aOh46SiaxKGUOAFFSJ/VGD
         K+80oIU53BmM8j3gi8m2P/0TWxFYQECJsHaBBQABcIbhYplxDZL0ZoKufRrstoujgn5I
         DeP5LwRnOX6U1whiqROSfolcRAJDeGClSsXbHqzh2OEz3HJC3MCLyT770+iIxsUq1NZg
         bkIoJnXbBlvkDb1gh7FMm1AYu+L6TvK4XrJJ1M984KlNTRnsaiRqJ0BB12dKOR5sN5QV
         5IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=aroeJSyNxu0+JeuMKne8ORfmBNS+7h3YYPDPke6aLMA=;
        b=OX52DUXa9ZH1HZhcC2cfYBRRZexH+KuUiGDYSJsvrn/Q8c4Rj0ImlBa6UxHwmU9tmf
         LN/3sdN6Erw/pXAPkVP+S/E794OhF5LnxTmuLNuFCJXrEeRECXBlEWiFpKxB/zwBfiTH
         xjQRWF41kh/Yrpinu6HsGA9Q79yDtZzaF6GFG3IbzYCI/5SzN8rZXOo/HhJU5nSvl+wb
         yBtiuuD+npSFfaQ+59WNqkxHOe4S1+JyvU7xrZvnejx9lMXUpp896tT2iLcsjFo7DETs
         FyeEpKrWMpvN3HhDx6fLIxWPKGIfFmVZ7KGC2lhUt9sLk41fycWY/J6U4R6oZmHcEjQ7
         KSIg==
X-Gm-Message-State: AOAM531J0tfSYkNF1JNNAIRlsgvIjjg849r2Pexnq4GvQs713HiXCjwp
        8PMqagqyGtkSEz/0PynYh8nQbilyJwoAYQ==
X-Google-Smtp-Source: ABdhPJz1pTnwW2mMD7ReIQrtrCTrg0Pizya7TcK0H9VRnBMPNymjQr+9XiCsxYk0d+K7Pn10DqFc3k7ALEmOyA==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a17:902:b410:b029:e3:284e:4e0b with SMTP
 id x16-20020a170902b410b02900e3284e4e0bmr1943431plr.33.1613150560558; Fri, 12
 Feb 2021 09:22:40 -0800 (PST)
Date:   Fri, 12 Feb 2021 17:22:34 +0000
Message-Id: <20210212172235.507028-1-jbhayana@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v6 0/1] Adding support for IIO SCMI based sensors
From:   Jyoti Bhayana <jbhayana@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

This series adds support for ARM SCMI Protocol based IIO Device.

This driver provides support for Accelerometer and Gyroscope sensor using
SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM specification,
which is available at 

https://developer.arm.com/documentation/den0056/c/

This version of the patch series has been tested using 
version 5.4.21 branch of Android common kernel.

Any feedback welcome,

Thanks,

Jyoti Bhayana

v5 --> v6
- Fixed the warning by kernel test robot
- Incorporated the feedback comments from v5
- Fixed the bug found in scmi_iio_set_odr_val
  for calculating the multiplier

v4 --> v5
- Dropped the RFC tag
- Added channel ext_info for raw_available
- Incorporated the feedback comments from v4 review of the patch

v3 --> v4
- Incorporated the feedback comments from v3 review of the patch

v2 --> v3
- Incorporated the feedback comments from v2 review of the patch

v1 --> v2
- Incorporated the feedback comments from v1 review of the patch
- Regarding the new ABI for sensor_power,sensor_max_range,
and sensor_resolution, these are some of the sensor attributes
which Android passes to the apps. If there is any other way of getting
those values, please let us know

Jyoti Bhayana (1):
  iio/scmi: Adding support for IIO SCMI Based Sensors

 MAINTAINERS                                |   6 +
 drivers/firmware/arm_scmi/driver.c         |   2 +-
 drivers/iio/common/Kconfig                 |   1 +
 drivers/iio/common/Makefile                |   1 +
 drivers/iio/common/scmi_sensors/Kconfig    |  18 +
 drivers/iio/common/scmi_sensors/Makefile   |   5 +
 drivers/iio/common/scmi_sensors/scmi_iio.c | 678 +++++++++++++++++++++
 7 files changed, 710 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
 create mode 100644 drivers/iio/common/scmi_sensors/Makefile
 create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c

-- 
2.30.0.478.g8a0d178c01-goog

