Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA831418D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 22:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhBHVUR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 16:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbhBHVUE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 16:20:04 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD48C061788
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 13:19:22 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m5so336292pjg.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 13:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mj2tFALi24MejDUAyOIZC6XcOuZLAwzBMp1DQ6QF7c4=;
        b=R4kz3oxWh27Oa6yQGz5VU3uqmz22vN2b3nKeesahabCfAT7e9yqTnNciJeT2xfk5ou
         IWNsYRcd58dNHirK6ZQQezlr81Zhw6QZIoaGkGWyVgHTyo+4jkg1HdNt3KuGvgqbi/+3
         7uyVABrUZF0Knpi/7O/BdUmgOaToVrambu3GLsjcAEZoPPdP72xMaXyfDIOreA4YqhlA
         +nB8h7pPZ0m1nUaeoqAMTAO+gMtIw/GZe7Li6nltqNfsFeRmPCE95gv/61bASA61YrW9
         BIacRXmVAmPErl9C7oejKaSPaJF8edAKFWl979P6587nVdK2OrqlsgkpqksTH1Y2Y3wo
         7OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mj2tFALi24MejDUAyOIZC6XcOuZLAwzBMp1DQ6QF7c4=;
        b=ke8L50LZ6L1BYUzv+t+e9wdAWvOlLxTqogys3phQ4oZ8rbBXqfPpDzZJTY5V8ASaW/
         +nQMgoqP4E3aZD3QoQcXBWkVed5D/Mv2pLM4WzviLFrp1VFhijGx3zwwRHViltRmWmHc
         tur70e90cMGOFW/S07O+7If8zewjJiZBhWTB8xv1Uvt5qRMQ5fM81nDptAraAlLTm3KV
         2agXgy3/4eana+1JcgsaZggJMjIaOKxcZmG5RkrcYVAEt4HWwL1wvDsVE1LzSzNa1bK6
         eNwCPGzAKOSosGhOFpuS081H5ADfYWTL/fYHAhtqSyYv9RMBZ0YWCJHm/wYOOiIqC3cl
         NFBw==
X-Gm-Message-State: AOAM5324m8CQinAmrdPuYdt9fioynC2ioWr7RnB/i5hnsOzOBxp016Rb
        DkH1TYldx5V9ulLMgXjyiFMxKw7nTzOjAQ==
X-Google-Smtp-Source: ABdhPJyvWdjxDxa2oDucvOMapD4bizkkq8JMxC+/bmdPT4s/BwMGoHRPjIom3HD+ILKxl8qH9PapC3lGyhggoA==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a62:3503:0:b029:1aa:6f15:b9fe with SMTP
 id c3-20020a6235030000b02901aa6f15b9femr19274370pfa.65.1612819162178; Mon, 08
 Feb 2021 13:19:22 -0800 (PST)
Date:   Mon,  8 Feb 2021 21:19:17 +0000
Message-Id: <20210208211918.1280588-1-jbhayana@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 0/1] Adding support for IIO SCMI based sensors
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
 drivers/iio/common/scmi_sensors/scmi_iio.c | 673 +++++++++++++++++++++
 7 files changed, 705 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
 create mode 100644 drivers/iio/common/scmi_sensors/Makefile
 create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c

-- 
2.30.0.478.g8a0d178c01-goog

