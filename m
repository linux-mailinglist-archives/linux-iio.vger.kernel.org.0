Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308113E4159
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 10:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhHIIIB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 04:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhHIIIB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 04:08:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3217C0613CF;
        Mon,  9 Aug 2021 01:07:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u16so15534975ple.2;
        Mon, 09 Aug 2021 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPVtQyc0S9JN7w7aDPjTC8ka2uBwR6od2VPtLAoj9m0=;
        b=G//b/kd6+5tgbv3ZHMD7vSizH5hq+5xGuKx8Rj0ZKfu3FJP4r/9pv20JI/IBb5ilHq
         ill3i8OQ8cwV/FBLTqZwtAnRd8WADs8VkMCufyZ/h+xAWliAyV5qReTP4D7V+s1+gn5F
         shOnT4yaM8sY3FH4nfVetkjJtADLwsbtpZU/UoBRf3GE/1dYYuMpEWvgD9pZDPDHHhFU
         oZurTFBVNkhYJMCyE4b+wtFBVuTVDDFT2ao1jduZVQcs7h/wlINoh+GpDZ8DP4/qHhHS
         opBfMhEu/23hxP+4oAATwM7u5FctHeaCUJgWGUQBBVZEATnhMjjxk8qikHKPafGs/cFP
         C/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPVtQyc0S9JN7w7aDPjTC8ka2uBwR6od2VPtLAoj9m0=;
        b=THLngqPuF24YRVAIwaPWDDu/WkWs7G2tKGPnQf9Kx8OOFGrE+nt/51mR0TLqoHzSDg
         d+bmQQShHI1CNuYFmGsicrIScz+mZgCMSe04aPsnAd5h9weHiF5F79C93frNPdgi//t0
         8fBA3WZZ0+11MvFQu+8lgDfjOeVBqmYFbAd/VBYWeioc5DB/ghI0d4CCj8VY/RCj2FtB
         fSlK6TNGbz8N0KY7hoQNSofLji4aPI6pQVcYWn/H18aFa4JzBoQlEfjypFLlgGfxS9B+
         07801faPm+ouz5wnXtA4Gv3sDs0dSMbm5RN7bGVWu+BzwCYTXWlAbb2a+mzxOwGC9oQk
         lwEg==
X-Gm-Message-State: AOAM532OrXCzRUVvJs5tlXsm7E+QIco2eeEHMfwQXT2WwFVH7iaI3fOu
        tHOrkASLtKuI5aEnZpC0EGo=
X-Google-Smtp-Source: ABdhPJytkyJsH+XTKjoRfyRWfeOY+NtHbtU2+4WeP97r8AioRTk2yPDNBEH7UxKoZhQqzMEREW/Waw==
X-Received: by 2002:a17:902:d485:b029:12c:ad2c:bdb3 with SMTP id c5-20020a170902d485b029012cad2cbdb3mr4105132plg.28.1628496460336;
        Mon, 09 Aug 2021 01:07:40 -0700 (PDT)
Received: from localhost.localdomain ([27.255.251.44])
        by smtp.googlemail.com with ESMTPSA id n23sm20676796pgv.76.2021.08.09.01.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:07:39 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [RESEND PATCH v9 0/2] iio: accel: add support for ADXL355
Date:   Mon,  9 Aug 2021 13:37:27 +0530
Message-Id: <20210809080729.57029-1-puranjay12@gmail.com>
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
  dt-bindings: iio: accel: Add DT binding doc for ADXL355
  iio: accel: Add driver support for ADXL355

 .../bindings/iio/accel/adi,adxl355.yaml       |  88 +++
 MAINTAINERS                                   |  10 +
 drivers/iio/accel/Kconfig                     |  29 +
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl355.h                   |  19 +
 drivers/iio/accel/adxl355_core.c              | 578 ++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c               |  64 ++
 drivers/iio/accel/adxl355_spi.c               |  67 ++
 8 files changed, 858 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

-- 
2.30.1

