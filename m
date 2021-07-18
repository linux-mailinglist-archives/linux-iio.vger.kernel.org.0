Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4433C3CCA2F
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 20:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGRSDP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 14:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhGRSDO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Jul 2021 14:03:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B1C061762;
        Sun, 18 Jul 2021 11:00:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 21so14157143pfp.3;
        Sun, 18 Jul 2021 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIxe0AiGtc25Lwwg/or5aTmC7KTOVtdM7XspjsT/CwE=;
        b=aZpi+2lmVwrXsidrf+pTTVBhlIQY16biksdlW0ufvbOJyOQp1GPA2YvBLfxVCavE0h
         CekpgP9Tmtkn2oYcUXEX1VrUIfdAMAbWuEba16IaxjcMQwn6I63PBVD2CLbanV2wzoqX
         fjcBrIx8A14NFZdaCrBMG8vHUaDTldze3D2HoQDOqbgnFOmqHiUojv55Nj14yz+pW7jR
         DlC2q5Xslq6hw9I8ri1fDgqPp1J+pn/vWENCnK+UhmsCRfjbM997asWzLQSyGtZD5KBX
         mBCB9DJmvTXzyrSw/63kFa0gdw+ZN7105ZRIA4v6UkCMjvehiE078APSTUSw17txHbwa
         kpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIxe0AiGtc25Lwwg/or5aTmC7KTOVtdM7XspjsT/CwE=;
        b=ofIvn7Jb6AtcmBkAxKwo7SuzZdAWd0jgAPbWq0pfIkL9a/rFC+jOCHcHgJk6ZAVXxf
         IxCZV7AFkaSzhoBpzg9xHnq1EHjObB9mXMKXg8KFObYTA9EDI1meKBBK0FlWVySRByok
         AzZI2FOlDZS4TMuJBzMfegsC1eG67YssCkdnJVxooGcS6nnn8L5rfm7TAyvuulOqpn5H
         Ohk5gmwmpC7Blh6V4PazTQSf8Iw/aL3rsGrj/X2L+AHO8bjlagXUHtg2g1zHTODzsNOb
         cabrPsOkCjClGbyouaKKQ58CeJ03JrJ4PZivEVLcxyJq6iSQYthci75DZ3qBKJgwx/wb
         WAKA==
X-Gm-Message-State: AOAM532hahZzLi49jP+ZdXS7Z4IIwS9iBZU0R/y4cZ+liKwfWHCttByU
        91FJwzbkH9DZ3FlWiMgo2zs=
X-Google-Smtp-Source: ABdhPJy3mCoJiCfBOAiJ3j0aVNg2GD4IApnxOOQNZur7TQn1nqK6xcMQXJb+/Q11QfLqE2DV824upw==
X-Received: by 2002:a63:110c:: with SMTP id g12mr21118026pgl.139.1626631214314;
        Sun, 18 Jul 2021 11:00:14 -0700 (PDT)
Received: from localhost.localdomain ([125.62.118.189])
        by smtp.googlemail.com with ESMTPSA id t6sm17106711pjo.4.2021.07.18.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 11:00:13 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 0/2] iio: temperature: add support for ADXL355
Date:   Sun, 18 Jul 2021 23:29:48 +0530
Message-Id: <20210718175950.34728-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

Puranjay Mohan (2):
  dt-bindings: iio: accel: Add ADXL355 in trivial-devices
  iio: accel: Add driver support for ADXL355

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/iio/accel/Kconfig                     |  29 +
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl355.h                   |  83 +++
 drivers/iio/accel/adxl355_core.c              | 544 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  63 ++
 drivers/iio/accel/adxl355_spi.c               |  66 +++
 8 files changed, 797 insertions(+)
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

