Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA433A6F8
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhCNQtT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234669AbhCNQtI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:49:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AE2C64E10;
        Sun, 14 Mar 2021 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740547;
        bh=4B+ABSjljOrdIo3oMOqkbV0OgAMmgNXDcvWTdNYjV10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESll6WyCyMrdnmEmQTg0Isj5x5hBiFeDyhOD9ck2j152HoY4GXdv9yazVKWzL7eUP
         i3Uvi6Jk6644VhQseuz3A7IStnpemrlRy0FAPdWgX/0aHTgrSOwIhYO/6pSsFktPom
         LyTyJP2aySz76C1c++MGguAwU6wQjbUyXkZ+krpsIvctTb6IGACN1Se8OYUFWW7iPN
         6apDkG08mbxGQTDVigzXRZC1C3yvKiDH3oDQ4uJH2h66CyJ/fnED5Con10NUtcsDlX
         UvjzyivOLvLNbyinHRzbVjxxgToNWtGPmwZVSs+1I3PZjrIOnb2LFPsJPkKJ+g//wz
         LiOGBjGgdsSbA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>
Subject: [PATCH 2/8] iio: adc: ti-adc084s021: kernel-doc fixes, missing function names
Date:   Sun, 14 Mar 2021 16:46:49 +0000
Message-Id: <20210314164655.408461-3-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164655.408461-1-jic23@kernel.org>
References: <20210314164655.408461-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The documentation in this driver was nearly kernel-doc and was marked
as such. Unfortunately the format was wrong and function names were
missing. This patch puts them in with minor edits to keep the resulting
line short.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Mårten Lindahl <martenli@axis.com>
---
 drivers/iio/adc/ti-adc084s021.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index d6e1bf3de755..33aea961d850 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -65,7 +65,7 @@ static const struct iio_chan_spec adc084s021_channels[] = {
 };
 
 /**
- * Read an ADC channel and return its value.
+ * adc084s021_adc_conversion() - Read an ADC channel and return its value.
  *
  * @adc: The ADC SPI data.
  * @data: Buffer for converted data.
@@ -136,7 +136,7 @@ static int adc084s021_read_raw(struct iio_dev *indio_dev,
 }
 
 /**
- * Read enabled ADC channels and push data to the buffer.
+ * adc084s021_buffer_trigger_handler() - Read ADC channels and push to buffer.
  *
  * @irq: The interrupt number (not used).
  * @pollfunc: Pointer to the poll func.
-- 
2.30.2

