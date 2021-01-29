Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DCD308FF7
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jan 2021 23:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhA2WTV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jan 2021 17:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhA2WTH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jan 2021 17:19:07 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF55C061573
        for <linux-iio@vger.kernel.org>; Fri, 29 Jan 2021 14:18:22 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id m64so8225838qke.12
        for <linux-iio@vger.kernel.org>; Fri, 29 Jan 2021 14:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tCMBTUen/v+QrJ81dRAg/XTnuRwylDlLGSBTA5n6VyE=;
        b=sfuimsQnMT4BHXnm7NYQgFiCXzDFurw8kYBckmM9Gx9M97gloIBXXAn4+xI6bfnCRP
         c8C1Vs6p5HJAvxMYa48v+32mtIQZb+MQRzrgg/hgpz5juEY+PQySF2x732ngBfoR6dE1
         SfGvZhcBgsBIWhcgBVw0xr9FPB/Dr03OF7o9dshTghPz8tpqCqEfl6TMQnKXecc7TbES
         Cp7dCtuz2oQ447gfrMc+b1TyzdMRK0ws8Xl/ql5aZideAp1gyDhS4dFKxIFwYOMbGS1E
         rlV4InZvYrwzhKIPqnTm5kUqxzxF1IIDl2WNN3TkppE8vobOPIlc3Mhi21iGIcaEQT8J
         pIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tCMBTUen/v+QrJ81dRAg/XTnuRwylDlLGSBTA5n6VyE=;
        b=lFjVLUEs1HHe4H9+8sjKcVUpIl7XK7LKrWgIc9ktHYYIp0fruiO1E1MxJPwlCdJnpT
         Iw8XfWp8vW7v+7pWqH+x8oL+f+P5zCNspiJwO8tKXJ6tKKCSdJE+7wYR0cQDBGlAuBvP
         UVWt3Wj5BVVoBMAXYvlOkXCrbwSHm3T0n52SXglNMDrhcuWE0avg2D1kTCoFKKq3Dr2c
         EnfeptyHAdEEHrtFQcaDZkZIJjyzKIFcDUTXgfGncmsPpK9q18fg+sPRWvmjY8cWTy5g
         47dUNJNJsrpBbdsM+vM+MYfPiiZo5WW220Bl1d3Vy1Rh/TVoPWAK1OIcmuXabFsl5vfL
         0T4g==
X-Gm-Message-State: AOAM531snPUHY4ul9MhMRymMWn77nXY3AQwQtS/XhUEOJ7JTOVSom233
        fCcygoYFwNWvZf+niOofFz4Hfd2HWMGVbw==
X-Google-Smtp-Source: ABdhPJzbC3adWzlnNHERD0NL4mVcv3Daxjb7kcPDTkkIezkV3XWPuefDw7IwSSWOCypc3JxaJeKK0/3MZ6fAtQ==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a05:6214:1110:: with SMTP id
 e16mr5935119qvs.62.1611958701302; Fri, 29 Jan 2021 14:18:21 -0800 (PST)
Date:   Fri, 29 Jan 2021 22:18:17 +0000
Message-Id: <20210129221818.3540620-1-jbhayana@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [RFC PATCH v4 0/1] Adding support for IIO SCMI based sensors
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
 drivers/iio/common/Kconfig                 |   1 +
 drivers/iio/common/Makefile                |   1 +
 drivers/iio/common/scmi_sensors/Kconfig    |  18 +
 drivers/iio/common/scmi_sensors/Makefile   |   5 +
 drivers/iio/common/scmi_sensors/scmi_iio.c | 743 +++++++++++++++++++++
 6 files changed, 774 insertions(+)
 create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
 create mode 100644 drivers/iio/common/scmi_sensors/Makefile
 create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c

-- 
2.30.0.365.g02bc693789-goog

