Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4550836DFAE
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 21:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhD1ThS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 15:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhD1ThR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Apr 2021 15:37:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7FA961352;
        Wed, 28 Apr 2021 19:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619638048;
        bh=o9WYEiLRZbv+8PuGhXqHX3WXlL0VGdlyi2gRJwuLoC4=;
        h=From:To:Cc:Subject:Date:From;
        b=pCbK6BZHvOjKNkjGI/sLQoV/CrFMO29jdT/qdjvoj1fSaZwb0E1m/Z8cq6zgcMjGj
         xQCweLTfxQKWmt32ELZwZAtyQnmzY+zuUw9pdzzSTZkjO0M5RTkS6zhgasMwQMn8r3
         KDY22fFl/AcGLLowiiWWDXliPSU0444WgqzDGdnf/Zt0qVtwC/ee14pE+ltZcVHLho
         xYe+hqHselgTq3ucfoR1EZTYz0Sb/m9jJS1zFAjSgmCIU5IwormYDml1u5rIgdWEV+
         rtiKi6DgVSua+yYqSul7Fyk2j8K2YLaZbUm/qOwYRCfUFwtlYUthkThH86PZYp9EXW
         OfWZwcXHcJ5pA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH] iio: adc: stm32-adc: Fix docs wrongly marked as kernel-doc
Date:   Wed, 28 Apr 2021 20:26:12 +0100
Message-Id: <20210428192612.147524-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

W=1 highlights these two cases that are obviously not in kernel-doc
format.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 922af2d75c1e..5088de835bb1 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -449,7 +449,7 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.smp_bits = stm32h7_smp_bits,
 };
 
-/**
+/*
  * STM32 ADC registers access routines
  * @adc: stm32 adc instance
  * @reg: reg offset in adc instance
@@ -851,7 +851,7 @@ static int stm32h7_adc_restore_selfcalib(struct iio_dev *indio_dev)
 	return 0;
 }
 
-/**
+/*
  * Fixed timeout value for ADC calibration.
  * worst cases:
  * - low clock frequency
-- 
2.31.1

