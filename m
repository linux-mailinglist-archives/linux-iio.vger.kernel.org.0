Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565F42DBAF4
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 07:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgLPGDS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 01:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLPGDR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 01:03:17 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D2C0613D6
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 22:02:37 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n10so8848939pgl.10
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 22:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWsJUhQJWub9r8EDuhJUaz2x/wlLmzf9kxcGCgwDcJE=;
        b=ItEwRJRuW8+hAVg4YwDhKrTbPPkowh9Hacx1jQgR43rBB+7t0ylWBatL5KQ0Dm21ip
         HihzUIsMdNXFdeK+FE2nozuulYn+0Y5fmwjjVBGt4ChXEw55r7oc7qzK9/vk1TpdLES4
         cnt3QlEn/aH4v7EE2ZIU+T09E1/g8Ugr+I/Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWsJUhQJWub9r8EDuhJUaz2x/wlLmzf9kxcGCgwDcJE=;
        b=cvxolBNtGyx33MuuD37Y0oK/+BykEMTNsDxWmt6CZ8QRYJOOKJa0Z766yFRajEUgRE
         SmYhZHMv+Uy+CDwpw2IWbMcNn8QITmpRyWa0XZeTDYxv5dTiCpEAFkaVMHa4qR6hUJu9
         DmefmfqEkPULTCSPziNumHuRG9wyV5QEnFFYG9uMDHBZRHd1x+U5YlN2wrjZthNm4RpS
         s5NLlw9ja9cxnPW1BXqk8wG8ue72Mcia1Sw/Gg2KSH91/fjl1Pk+QPFymAWz09n0S1pF
         JS98fKKgCwuMMBjcSY/1omuezkPzZzlf8r4o7xU9vNM6OT2Z6WIOnBTpbY4KTBzChSWH
         JIkA==
X-Gm-Message-State: AOAM531aBnGMZXOsBKpLMomQ7IZbyfjKURHP++xFuASCcZar+d7/WFmy
        aGEfCCXulKKP1sDGjoGPW5HSgg==
X-Google-Smtp-Source: ABdhPJylhrWHaFaGWIeMlcLmIRF4TaNWqXh4jGT1FYgzhVMiBc9zCYoXG9aBp851otTTJa/lhVQUUg==
X-Received: by 2002:a62:8683:0:b029:1a3:9879:c326 with SMTP id x125-20020a6286830000b02901a39879c326mr17037347pfd.72.1608098556854;
        Tue, 15 Dec 2020 22:02:36 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id h11sm696167pjg.46.2020.12.15.22.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 22:02:36 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 0/3] iio: acpi_als: Add sotfware trigger support
Date:   Tue, 15 Dec 2020 22:02:30 -0800
Message-Id: <20201216060233.597689-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices (chromebooks) present the ACPI ALS device but do not have
ability to notify when a new sample is present.
Add support for software trigger (hrtimer/sysfs-trigger) to allow
retrieving samples using iio buffers.

The first path fully adds timestamp channel, the second adds a local
variable in probe routine and the last one adds trigger support.

This patch assumes the patch "iio: set default trig->dev.parent" is
applied.


Gwendal Grignou (3):
  iio: acpi_als: Add timestamp channel
  iio: acpi_als: Add local variable dev in probe
  iio: acpi_als: Add trigger support

 drivers/iio/light/acpi-als.c | 104 +++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 30 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

