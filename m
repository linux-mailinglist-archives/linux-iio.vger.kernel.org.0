Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE83E40F7
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 09:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhHIHpv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhHIHpo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 03:45:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D79C0613CF;
        Mon,  9 Aug 2021 00:45:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a8so26534268pjk.4;
        Mon, 09 Aug 2021 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imnZWCzF3D9L+x9RAD6NqVX3kmK3rddxgyz7SLNcdTc=;
        b=miMwDUmioMZZTOFkBAtbxZCf9/EWWU0p0ZgsXgXjjMS+sSz0q8p+uRDJYA3AJadNcN
         KnCS4Tgo6T3VaWc7C6MSv9mJnxzaTZv62/L9V/YoeqMIK2GZ1kVHcMPBkMzJ9p5prcmj
         0E0hU7oluJIbR6w+Dncs2AIpN3e93/EvIkgzXe1HGqDeUdTxHVpxuWjTGMEBe/hI8yIA
         gD0ij2cRY0ASnoVkGX6U7c8x/vnchq+ppc+EX2Kjm+T+oi/0KTKoaIuKmP/cg75rY+hc
         gl5owGkl7URta16P6ORBiQ5YFNWI5Hr4YbUNJu9SfwA1VXZE3FrHTC2T+vAhx8w/oEqX
         zKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imnZWCzF3D9L+x9RAD6NqVX3kmK3rddxgyz7SLNcdTc=;
        b=KYZkbe8Q/2NF8rQmhXBw08dw02ztNq7EXZuASZrOWD8q7rTWKTO+5Dd1XEj4eSMs69
         nW7ZQ7QXb/nKYcSNB1o7v5lJUvZ1GkXFvnvdZ/sT0TTlgIv46Pr5q6R5ooE6d+mz4bYe
         bA9Ndqhk69k3zYMOu1EnVctdjG7ygI6LHnSAgDmwt4bCpJBl8ht0aBPTkL/HM8OLkt13
         lynMAAp8SloOAy/3g41nZoMfQBdu9k9r15jFhdw4MaSNCCoq/dyprDitS2Mx1G8hTcW5
         X6fTIjzSVfslUgIjcN8YYGb6EHqpxNfUXDqLEvR+pfb064IAbwnarVyuCQ5Du589M0zV
         0hhQ==
X-Gm-Message-State: AOAM532nJZTWoLex4UTmJGp6tVCGSiSctCu8vFjJGbia6su353xs9/VZ
        2u3j8PTIgoWgzgG8jJ+35ts=
X-Google-Smtp-Source: ABdhPJyXIiV0/YGmYVbxs7vY48WmE3r+1bZgqDZ7yeGr3xduqNPiCesuDc2DZmuu6f78rrBejwt/Og==
X-Received: by 2002:a65:5342:: with SMTP id w2mr19135pgr.333.1628495122577;
        Mon, 09 Aug 2021 00:45:22 -0700 (PDT)
Received: from localhost.localdomain ([27.255.251.44])
        by smtp.googlemail.com with ESMTPSA id h16sm18602524pfn.215.2021.08.09.00.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 00:45:21 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v9 0/2] iio: accel: add support for ADXL355
Date:   Mon,  9 Aug 2021 13:15:10 +0530
Message-Id: <20210809074512.34757-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

Changes since v8:
1. Make scale and offset defines inline and remove them.
2. Change dt-binding doc to state interrupt polarity only for DRDY pin.
3. Remove triggered buffer support from this patch series.

Changes since v7:
1. Update MAINTAINERS to show all driver files.
2. Set CONFIGS for buffered support in Kconfig.

Changes since v6:
1. Use interrupt-names property in device tree document.
2. Add triggered buffer support.
3. Use a static table for offset and data registers.
4. Fix coding style issues.
5. move defines from header to c file.

Changes since v5:
1. Used get_unaligned_be24() and  get_unaligned_be16() to parse
acceleration and temperature data. This solves sparse errors and also
make the code more understandable.

Changes since v4:
1. Fix errors reported by sparse.

Changes since v3:
1. Fix errors in yaml DT doc.
2. Change SPDX-License-Identifier to GPL-2.0-only OR BSD-2-Clause

Changes since v2:
1. Add separate DT binding doc in yaml.
2. Use ____cacheline_aligned buffer for regmap_bulk_read/write calls.
3. Make code consistent by using same style in switch case.
4. Use FIELD_PREP in place of custom macros.
5. Make Kconfig description more informative.

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
  iio: accel: Add driver support for ADXL355
  iio: accel: adxl355: Add triggered buffer support

 MAINTAINERS                      |  10 +
 drivers/iio/accel/Kconfig        |  33 ++
 drivers/iio/accel/Makefile       |   3 +
 drivers/iio/accel/adxl355.h      |  19 +
 drivers/iio/accel/adxl355_core.c | 676 +++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c  |  65 +++
 drivers/iio/accel/adxl355_spi.c  |  67 +++
 7 files changed, 873 insertions(+)
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

