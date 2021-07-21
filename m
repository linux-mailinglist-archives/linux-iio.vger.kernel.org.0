Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF2F3D0CB7
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 13:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhGUJmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 05:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbhGUJMN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 05:12:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB03C061574;
        Wed, 21 Jul 2021 02:52:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id i16so1348625pgi.9;
        Wed, 21 Jul 2021 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5gsUR2mP3O9xT2/PcV4HGNhJL6LNwgEDQIptmERAuY=;
        b=mOgrtE9V0DrntKqst88F3+cIf+ojlrpv/wdXdfOHionBIbsDX51AgILMqfxHovuOmN
         T8YxfXqO8/03M+LNrExayili3a8Yb1fU4oPKK9GBZ4Ich25nj0J46khgdep7GMNhn9Rl
         jocniO9rJa2NCCLiZ6nJhS3CT9Vf/4Fd88oKYb5Q1ifLzIsckf9rYD2DBESuHnhOGJYZ
         nmzeA4fuPTkrL/7VXTj4VTN5liKYUjgEe9rXAeFC2I1dcNjHXs9OQEO1QlV9XQlyPdrP
         PqpXI8YvawFNXghhTBjvgvu3TIcG3QGj7NMfHM1nG5G5A0UdQulXrPoqFzhKHAYi9jMT
         O4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5gsUR2mP3O9xT2/PcV4HGNhJL6LNwgEDQIptmERAuY=;
        b=QtyHhxcWU6Kb00wt8Dt2bftYDVsbBRyzjL8Fqkc3POCzkbcUq/onUmrL9Mg2Tg4OeQ
         fMQMw4ycPOiLqhgYNTqmdeGdbV/KyHHCfh0os4xq7xh6bBhFCRBnydfqFfpIy7PaW2Bh
         LPqPe3920H5f28slWnH0CFjWanCSQLCdi+MHL05lKsZf3OlUtegHNbQHwDE+h2YCjgMI
         76ea5pDWE/AXCMRDpT9CYRXJJE1Wd3/5DDTrd6PibRHZiV81S5Ujg3NxjwshuSMl7szt
         IId3uXhdsj4XxoSZZgFji2AL0gjwV8MSE+d41+6gMBFYRrVVMvFaKzudiyHjB8Lawff6
         w8vA==
X-Gm-Message-State: AOAM5328znZ0Qf+vVGNmHngZOpl1sSu1TjBTYDGZ6HXPSSDQi3EiODFg
        zbn7seCVIuE4pi6yZphAHEyYaAJcOY9IpeaM
X-Google-Smtp-Source: ABdhPJy33MRhyxTudRjyCy9o+ONGqqbqQnM0/K0br9JEIv+5JmqTd7yj/OPNhqOBoi2S6KeT7eDp8A==
X-Received: by 2002:aa7:83d9:0:b029:2eb:b0ef:2a67 with SMTP id j25-20020aa783d90000b02902ebb0ef2a67mr35792830pfn.1.1626861168904;
        Wed, 21 Jul 2021 02:52:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:4055:289:a04e:668d:a877:6739:60c0])
        by smtp.googlemail.com with ESMTPSA id g18sm25752439pfi.199.2021.07.21.02.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 02:52:48 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v1 0/2] iio: accel: add support for ADXL355
Date:   Wed, 21 Jul 2021 15:22:33 +0530
Message-Id: <20210721095235.218519-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

Changes since v0:
1. Move adxl355_hpf_3db_table to adxl355_data structure. This is done to make
sure that each device gets its own table.
2. Make local regmap definitions private to adxl355_core.c.
3. Other minor coding style changes.

Puranjay Mohan (2):
  dt-bindings: iio: accel: Add ADXL355 in trivial-devices
  iio: accel: Add driver support for ADXL355

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/iio/accel/Kconfig                     |  29 +
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl355.h                   |  83 +++
 drivers/iio/accel/adxl355_core.c              | 541 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  63 ++
 drivers/iio/accel/adxl355_spi.c               |  66 +++
 8 files changed, 794 insertions(+)
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

