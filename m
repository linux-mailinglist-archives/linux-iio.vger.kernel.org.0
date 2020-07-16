Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAD0222492
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgGPN77 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 09:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgGPN74 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB62C08C5C0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so7203354wrn.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GqxOwYWYCKbxRiFIfO8mQJ17c9E08hm9vRAt2tUzVrE=;
        b=BZXkuoMjqIRTS0/6QPnet0VkxaR+ZYIEPXHFKOFQCy3pYZVAsy32j3Drec+Le6Hkco
         8tc+9B8okcwu97u594OZnlUdlxm4otXS2uR8C726JZp7H4RoaQI9EYdpp1VWJWyynggL
         IBthvy4QEsA6VEnviiixeZxU2qiEyr8lwutFFtMmUR8ValadGnwQynlH+ACf9OZwx6d8
         3JTCFEI4quzR5QCrEyz/BrA+HTgjGdKGEergDADidFrMB1Ijpx65zyxJQsYnMcPo6gG4
         lK9Urh6g5WoxHoqZ5AJ93s15VWvqo1seLUdp+x5zW8uxoT205CgLvV13yM9QiC8cwl0h
         NlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GqxOwYWYCKbxRiFIfO8mQJ17c9E08hm9vRAt2tUzVrE=;
        b=Zsk+H+ybHi+zpV1QfI5Zw0/S+mpiN7ePkTFzaZuGe07wK2lbTN0b2fd5XLsi2dKdJm
         gZx+Msuyf02UYkICIN7BEG1QL6oKvsdkR1dea1Z6rJgYdzYT3a/gEnGH6YfJ0EUxdmYd
         ZpjXFLiGIhWN/5E2UknvH+MFHd4jYwfo3cDX8Uh5fASnPBVS2gS5VBL32bZFfEca+dDe
         ULFF3h1lkMpV5tmC78GVJ66vK2C5lvooYCug2CwZo3+aDS01JESXunJz/lB2t6yuY047
         jiwwfbvTqzMz2eU1DzUJhzUrt/sZFIib2KXnQL9NUnHWlZF23BaSBJyBqRaC1aU325BE
         CufQ==
X-Gm-Message-State: AOAM533Trdo0Atm8TMvZLQ6Yori+T+NFNB1xzSMeyEMHuitR1r22R/6Y
        U372P8dtKKMK9Af7NAy4agO3Vw==
X-Google-Smtp-Source: ABdhPJxYVAtXV1LzuFoU5IKqF3NfGCSxjIjAn6JnmZMWcEXVylAgyiNuD6x/dKuh428/yUB0CybypA==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr5163414wrw.244.1594907993734;
        Thu, 16 Jul 2020 06:59:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 18/30] iio: dummy: iio_simple_dummy_buffer: Demote file header and correct misspelling
Date:   Thu, 16 Jul 2020 14:59:16 +0100
Message-Id: <20200716135928.1456727-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

File headers are not good candidates for kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dummy/iio_simple_dummy_buffer.c:27: warning: cannot understand function prototype: 'const s16 fakedata[] = '
 drivers/iio/dummy/iio_simple_dummy_buffer.c:185: warning: Function parameter or member 'indio_dev' not described in 'iio_simple_dummy_unconfigure_buffer'
 drivers/iio/dummy/iio_simple_dummy_buffer.c:185: warning: Excess function parameter 'indo_dev' description in 'iio_simple_dummy_unconfigure_buffer'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 17606eca42b43..40d30c0a60ce5 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (c) 2011 Jonathan Cameron
  *
  * Buffer handling elements of industrial I/O reference driver.
@@ -179,7 +179,7 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 
 /**
  * iio_simple_dummy_unconfigure_buffer() - release buffer resources
- * @indo_dev: device instance state
+ * @indio_dev: device instance state
  */
 void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
 {
-- 
2.25.1

