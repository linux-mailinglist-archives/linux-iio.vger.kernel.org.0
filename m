Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A17441410
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 08:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhKAHVA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 03:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhKAHVA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 03:21:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE25C061714
        for <linux-iio@vger.kernel.org>; Mon,  1 Nov 2021 00:18:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m14so15526414pfc.9
        for <linux-iio@vger.kernel.org>; Mon, 01 Nov 2021 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4pCewSSNJEuxiUVt+gE7eMNdki1eyy+VCPDX8QW2nb8=;
        b=UIBvaanNE/B+CFTUb/PYnCR3VeHFaD7USCi8CaJVZbJrYNlePrrd33LNxzrosIcAz8
         Dz5tgaDo9zW7d+Mo4E/hUxgRYt4doM9w5TL2daxkAurHvu8SlJPW5cxyUbCVxReWTD/9
         kZdAQbvfke3Gf7h20LZX7B8r2JNnNFA+RUy/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4pCewSSNJEuxiUVt+gE7eMNdki1eyy+VCPDX8QW2nb8=;
        b=J/17R5HcPLjKz4yMEHYPYPY526hvpLX1PgXSCNz+Fv71aBrw4kcklf++yRR1fcX8+C
         U5sB1lv0JjxRS+rRL72h9Y6b+L4rwP9VtTYGP5UkEpOz4JUUxipvpUD9NT8YVzAe4vE5
         h6ePDZ/mZFitRVi5q6t9URcqMf/pr+q7CDU1SSuRhk5NJYnnlqObNIk9RpuL01XqXqDy
         vKhnUR5ns3Nk1Vs+SR0ZChCXhdsIQKjZ+xCux7VQG4syetSRICzRiaTrFVjkWgE6E9w8
         lbIbdMW4Y2Wm0QoJM2+NI71B1OndgGWOQMij3fXTcnBrNf2J5glKCT5kPqtfU91NmmNF
         SeDQ==
X-Gm-Message-State: AOAM531++eo4JI6jra1P3273bIq3WCd56gdFEN8woWtzgTDUGvhlm9kC
        K6LAFIJw6hbRA77fldchJJicNQ==
X-Google-Smtp-Source: ABdhPJxTzLxW7TP37vgPvLMqbnWOjh4SXB+tyEatfYTXIjLktU4pWAhn6jRYcAsWK0Oks7gzJMPx/A==
X-Received: by 2002:a62:1b86:0:b0:47b:d112:96d4 with SMTP id b128-20020a621b86000000b0047bd11296d4mr27145674pfb.52.1635751106377;
        Mon, 01 Nov 2021 00:18:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3f65:b35d:616a:31bd])
        by smtp.gmail.com with UTF8SMTPSA id f19sm8074431pfc.72.2021.11.01.00.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 00:18:26 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/4] iio: Use scan_type shift and realbits when processing raw data
Date:   Mon,  1 Nov 2021 00:18:18 -0700
Message-Id: <20211101071822.522178-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Using scan_type has source of truth, use shift and realbits instead of
constants when processing reading sensor registers to produce raw sysfs
entries.
The same shit and realbits are already used by the libiio user-space
library to present channel information from device buffer.

Fix only a handful of drivers, where channel scan_type was accessible
in the function handling the raw data request.

In mpl3115, use a 16 bit big endian buffer when reading temperature
channel to improve readability.

Gwendal Grignou (4):
  iio: Use scan_type shift and realbits when processing raw data
  iio: ti-ads1015: Remove shift variable ads1015_read_raw
  iio: xilinx-xadc-core: Use local variable in xadc_read_raw
  iio: mpl3115: Use scan_type.shift and realbit in mpl3115_read_raw

 drivers/iio/accel/bma220_spi.c     |  3 ++-
 drivers/iio/accel/kxcjk-1013.c     |  3 ++-
 drivers/iio/accel/mma7455_core.c   |  3 ++-
 drivers/iio/accel/sca3000.c        |  5 +++--
 drivers/iio/accel/stk8312.c        |  2 +-
 drivers/iio/accel/stk8ba50.c       |  3 ++-
 drivers/iio/adc/ad7266.c           |  3 ++-
 drivers/iio/adc/at91-sama5d2_adc.c |  3 ++-
 drivers/iio/adc/ti-adc12138.c      |  3 ++-
 drivers/iio/adc/ti-ads1015.c       |  8 +++-----
 drivers/iio/adc/xilinx-xadc-core.c |  2 +-
 drivers/iio/magnetometer/mag3110.c |  6 ++++--
 drivers/iio/pressure/mpl3115.c     | 16 +++++++++++-----
 13 files changed, 37 insertions(+), 23 deletions(-)

-- 
2.33.1.1089.g2158813163f-goog

