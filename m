Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF5A2240E7
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgGQQ4O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgGQQ4N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BDEC0619D2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so11863546wrl.8
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zlqMOdNrENttDVuszECzN7q6TWwHlOYVdLftB/3VJQ=;
        b=jk/vAi339AA/fMk2szczMEaYiyDqaysIObBKL143epOkzEsbrOy/ajjwOTrA0vwMUT
         /bWyfvCp6TXGEVnhaZ4ZaDcBRVN4RJDnXqpooBRlEUvPaDsdpVYgIjGTlXCdj5o6EtuO
         0YDQw0X5WWkOKtkQqMOtP7vbDRe4gXA/NdbR9y9+ZmdNhTcjdUNtuu6thLbID5H3K01G
         QJah2TZW7poRboocoqLyZDaNAvzNKd9wX0hUN2OkQQidQ+xOlloDfaeznOKSx5cAto9v
         BHqHGIPCLmoThO3pkhPdzzGNZOyT/tVCuucvteQ2aoojXztz82MJxYD8YnYpebsdtTEp
         Geow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zlqMOdNrENttDVuszECzN7q6TWwHlOYVdLftB/3VJQ=;
        b=oJXtjN8fH3UX3WhuNkW7TRAUnUtAXteBkxgix5cp548AwRYiV8zMar9UTo9wccj8Dg
         ca6wMhq58YN53sZ9dagGArEFFEMQfN6dytqfcLCKbLNQ/WjQE1xGpv365f9Dqsrv83/9
         W7ZPvgwicdt8Kl0nRIQeKxALghSnz363Ij/ivnzMtmvL1Dn3EbZtJgoMh2HTKLVS2z05
         qZkHP47CGc1TW1mFqG8Rezbi1DoWWqBM2KUrmZUVVc4i7hKpmRitPxrmm64n0xSdciHk
         +X87DnuO+8mJRnLGUCXUyZn008+CwlG2/UrLkzQOJlny6B04MRCiBVQXXghg1WCPr5ix
         yzVg==
X-Gm-Message-State: AOAM532Zfildc4LRgWxAnbtdUNqwF2IBIuqqOo9QKXNzLW2VyrYHhvRl
        1EKBbxlT4IdQIkGEDcdS3J2bNA==
X-Google-Smtp-Source: ABdhPJz43TiHR92LcHgmi7oLqVKfizS8glyxX3f/hvC7+wHREvkx8o08FuWHzRz6eQITQ90++yqHPQ==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr12497884wrs.60.1595004972103;
        Fri, 17 Jul 2020 09:56:12 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 12/30] iio: dac: ad5504: Fix formatting errors and demote non-compliant kerneldoc
Date:   Fri, 17 Jul 2020 17:55:20 +0100
Message-Id: <20200717165538.3275050-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5504.c:58: warning: Function parameter or member 'pwr_down_mask' not described in 'ad5504_state'
 drivers/iio/dac/ad5504.c:58: warning: Function parameter or member 'pwr_down_mode' not described in 'ad5504_state'
 drivers/iio/dac/ad5504.c:64: warning: cannot understand function prototype: 'enum ad5504_supported_device_ids '

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5504.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index c64e6898ff20a..7e4e422ddfefc 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -43,8 +43,8 @@
  * @spi:			spi_device
  * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
- * @pwr_down_mask	power down mask
- * @pwr_down_mode	current power down mode
+ * @pwr_down_mask:	power down mask
+ * @pwr_down_mode:	current power down mode
  * @data:		transfer buffer
  */
 struct ad5504_state {
@@ -57,10 +57,9 @@ struct ad5504_state {
 	__be16				data[2] ____cacheline_aligned;
 };
 
-/**
+/*
  * ad5504_supported_device_ids:
  */
-
 enum ad5504_supported_device_ids {
 	ID_AD5504,
 	ID_AD5501,
-- 
2.25.1

