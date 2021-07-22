Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB173D1E1D
	for <lists+linux-iio@lfdr.de>; Thu, 22 Jul 2021 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGVFlb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Jul 2021 01:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhGVFlb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Jul 2021 01:41:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA9C061575;
        Wed, 21 Jul 2021 23:22:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o8so3276132plg.11;
        Wed, 21 Jul 2021 23:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRvkkU6/oVz1tSJXGijjAm5FFJObI4hAIi7reVBP/ZM=;
        b=OdzEhxDsuAv+3rCcQ8CHv27aWsfrY4bp3e6wrBwhUxTwJI8aEDQOgWQ6ZlLxzit1gf
         upQkXsuXAPauDiD8EgR9YV/CHHmzy43e+X6HFyjeSf+U3I3a08ez3Tdyq5LFVaHh1qOk
         EPSAG5deURp69mLIrJrFcNf0XDqU0zjFHXUO3AqQYKIoV85Cq/XYia9KBKLUP0Y2HFHk
         bTbNJgOjETyTXbIGWAp4EGDH9ZYehgW9hfa4HMaCs+eo4WC75z18iF4IVDk8BzxmWDLX
         CnlDcrqk6ud3eO17oY5Kz0KnMIT1UCuli/zAfT81Muf17KsqhykTxmkTWoRUlHB8Z52i
         Kbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRvkkU6/oVz1tSJXGijjAm5FFJObI4hAIi7reVBP/ZM=;
        b=ncNl7MAqSwHmM4iH25VF9Oz1h5iYexWkD6/xn8NTkaGY/hko4cl//DLZ3ds1M7qlsB
         cRD4Q3edLnhxNpnwUlpASV5pel3F0icNmAuBdWMfWvyzp7pjDgKSmmpCfItHJUs7DmVv
         jkhNcNssuBY1Qh6bp7+hKySB9Ycb2q4X94MO/6QMZX8XjWmSizG2J3wTQ0c5dDAWL22R
         V45Ay0TU2zIiInxH5f13XRioxN1ljmfZXvQfI7CZK4DZCx2AepKQYB2keBDTVBixryp7
         LWrurgyuobLmuS+EO4j2YKC7ZaIWvD6OCdpq+ybNL6YWpAB34CBhLYlFdp0WKX1/jwvN
         ggbA==
X-Gm-Message-State: AOAM532QLZXBqc5TcxJwsJe0avs71fhQrBjNHDEo7ifJY4F1YDLRFfOh
        ivDB2ZwwHE/Ixm8eQUipK4g=
X-Google-Smtp-Source: ABdhPJxMuCT+BbM8F1YH9694WtHRj0qAi4jL3P5lg6f5wwXNDfENxh3UmHXuZIksTqO1qQZNIYIlpQ==
X-Received: by 2002:a63:ae48:: with SMTP id e8mr18964800pgp.0.1626934926050;
        Wed, 21 Jul 2021 23:22:06 -0700 (PDT)
Received: from localhost.localdomain ([2409:4055:289:a04e:a741:7cf2:c19d:a4])
        by smtp.googlemail.com with ESMTPSA id g123sm28239326pfb.187.2021.07.21.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 23:22:05 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 0/2] iio: accel: add support for ADXL355
Date:   Thu, 22 Jul 2021 11:51:52 +0530
Message-Id: <20210722062155.32998-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

Changes since v1:
1. Remove the declarations for static regmap structures from adxl355.h.
This was missed in the v1 and caused errors.
2. Make switch case statements consistent by directly returning from
each case rather than saving the return in a variable.
3. Some coding style changes.

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
 drivers/iio/accel/adxl355.h                   |  79 +++
 drivers/iio/accel/adxl355_core.c              | 536 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  63 ++
 drivers/iio/accel/adxl355_spi.c               |  66 +++
 8 files changed, 785 insertions(+)
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

