Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76A82FF8AC
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 00:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAUXWj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 18:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbhAUXWf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 18:22:35 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94629C061756
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 15:21:55 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y10so1985431pll.20
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 15:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=VVJ18jo9wChTO7xYiVHUOH7AGcTMx8WNIb4MUAmrhNU=;
        b=kUAG9VEXYC1S/8FUYLcyZ1ErjhZkE37BNTiJed1mjrlxgtfSSkObexCkpOM1YHzvPf
         R6H7GgBnPMZYs4/NP3vHjGcaBWlgLRSlXlOP4ZJbJJlEGES1+GOgPie0vcZx/cWa2rtT
         kzLZI/ffEtv2Cq4HYpChR3hf6q8QSMM2fpXKOKFxAaQ99AssRtXNcVtY7T7B9OJszKIX
         8rEdaHRsfTPqAMo4bFxHRa+x1I3vQIA8VjTL1xbtHuRdq0ZFAZczwEMwB0yGoreIxUZi
         M5uurYfv084P1Az0TOUhlJ3kkMRAP+XpPN3RKQsxTW6vt/MLFmPgZcSceIE/TBKmy55S
         nwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=VVJ18jo9wChTO7xYiVHUOH7AGcTMx8WNIb4MUAmrhNU=;
        b=PESFqpyFU3rYuBgO3RkMVvD7DtBvL9/ot8fFGr326CYiUEiRgBCjYE8CU6AR3LY3Ym
         KS50hqF5ocEPQExdAl5/uKz2kcXDSiuejrFt35L7PRivKl+xK8FKBN+7mLCh+oaPj19Y
         FALf6Pz1Kyn9zXHZafGA1VSAX72d4pv75pWBtHGPZn2m9aVuA6i3NqwdNOpuYqekZ3JS
         PYBPiBEHJ7YSxRXxpSeKg/nNpWxjjD3qtaA7hZ09lRDrBxo4HMs1lTf1We5tSKroR2co
         s5sE72XQEH02gG/NxJp7B/gvWXBk6AqQogEtBPgoH4ztNFc43kIwOTl4NZ2nh1HE+l2y
         F2+g==
X-Gm-Message-State: AOAM533uYGcD1JwDXlQjqXGuc3vg+HeatU4XNRZY1gn+r0OzhVH6FZMP
        ihxbUjkWIsX+ubGzEbj8GzjF/1cCzQTw9Q==
X-Google-Smtp-Source: ABdhPJxfyLQMocQPaTk75qAl6HUcaSSq+RJ6eWSQntz8aLR5szNU7Vqcs6APVSzcYDBIv6ZvUcGOaj1r3VWdOg==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a63:f405:: with SMTP id
 g5mr1746475pgi.276.1611271315059; Thu, 21 Jan 2021 15:21:55 -0800 (PST)
Date:   Thu, 21 Jan 2021 23:21:46 +0000
Message-Id: <20210121232147.1849509-1-jbhayana@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [RFC PATCH v3 0/1] Adding support for IIO SCMI based sensors
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
This driver provides support for Accelerometer and Gyroscope sensor
using new SCMI Sensor Protocol defined by the upcoming SCMIv3.0 ARM
specification, which is available at 

https://developer.arm.com/documentation/den0056/c/

This version of the patch series has been tested using 
version 5.4.21 branch of Android common kernel.

Any feedback welcome,

Thanks,

Jyoti Bhayana

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
 drivers/iio/common/Kconfig                 |   1 +
 drivers/iio/common/Makefile                |   1 +
 drivers/iio/common/scmi_sensors/Kconfig    |  18 +
 drivers/iio/common/scmi_sensors/Makefile   |   5 +
 drivers/iio/common/scmi_sensors/scmi_iio.c | 736 +++++++++++++++++++++
 6 files changed, 767 insertions(+)
 create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
 create mode 100644 drivers/iio/common/scmi_sensors/Makefile
 create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c

-- 
2.30.0.280.ga3ce27912f-goog

