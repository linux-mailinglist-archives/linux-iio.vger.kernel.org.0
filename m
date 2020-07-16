Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E982224A8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgGPOAo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgGPOAE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 10:00:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692A8C08C5DD
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so7226934wrs.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Zqjbhr41mFcuxqFYTmtQRdbWtEY5mhva2FxvIlylMM=;
        b=PUoZ+kjfsG82Ntq8kXFJfLh56Snfmmn8k1IU3BDK0t0ulTX7ghosaJx/XI+qK/ZdZt
         i+oqbw0ftNTxD88caU4Y+3QKALiJNbW2x1Sfcy6KcIhCF+p6X2bO2sPN5t39nYxeOOh6
         8x+ACpIeHkGsXmrJKIiOn1/noFzvRmQ4/ZeEUblFuiNFRF6HXK1aLMYZhmzv4hQQOht4
         MwzHi6g7tvyX0nlNad2s1zwPH3Ckv+HptxVoBjBABU8qKfLwEIBRuWZWaMJaGa8BBj/P
         8qWe635b+zu59V1K2w4uv2FpusVkJ1EjI/ZGfWz9Aq6ksWcosneBunT+r+xImyTSBThJ
         ylEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Zqjbhr41mFcuxqFYTmtQRdbWtEY5mhva2FxvIlylMM=;
        b=HT1TSqDv27FDMXs/y35NmkfV+iDHPrSofQCevCA+6P5GyC1jpEI4Qp1VcesImOmY32
         YMsMpvyZF6bzOLMN4DpM8PEO7Cv1MI/QgoxoqVKdKSWpzUF0PJcfPxnwI+05MWMJ0Xza
         oeMqRZQC5PMN7g/XuuynrSJsDx46jT8rnb8Nuyq4z/Gbn0fJhjp6+Y8lmJY/wkidmg6a
         kqUWo7C6ecKc4BTccb/xcc4u27ZWw7k8h7Jmfbg5h7pCmh2KlG44ubvWLZCUIaDL4hA2
         PZl8RTtJyLkOg09QtFp4YN9DVBqvWAGZb5w6tmClekKDXitTiL2BPz1iXPKpgZ0zZi6I
         DyRw==
X-Gm-Message-State: AOAM533JxmYpTcqgID+pr6rS6I0Osh85fpEVsHueP8R/oYC6K33RiQOz
        ah4koQm9dGjDHU3EN2B1N1k66Q==
X-Google-Smtp-Source: ABdhPJwvMNt0x0XmHey72Trxma7/tiCQqWEKjnfToFouTqsZD0Ln5yHNxJrVKA/QTX/ZMNVd0ANjDA==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr5088520wrp.315.1594908003134;
        Thu, 16 Jul 2020 07:00:03 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 25/30] iio: dac: ad5764: Fix misdocumenting and formatting error
Date:   Thu, 16 Jul 2020 14:59:23 +0100
Message-Id: <20200716135928.1456727-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Attribute descriptions must match the name exactly.

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5764.c:42: warning: Function parameter or member 'channels' not described in 'ad5764_chip_info'
 drivers/iio/dac/ad5764.c:67: warning: Function parameter or member 'lock' not described in 'ad5764_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5764.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index 5b0f0fe354f6b..1e16c464241c4 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -33,9 +33,8 @@
  * struct ad5764_chip_info - chip specific information
  * @int_vref:	Value of the internal reference voltage in uV - 0 if external
  *		reference voltage is used
- * @channel	channel specification
+ * @channels:	channel specification
 */
-
 struct ad5764_chip_info {
 	unsigned long int_vref;
 	const struct iio_chan_spec *channels;
@@ -46,7 +45,7 @@ struct ad5764_chip_info {
  * @spi:		spi_device
  * @chip_info:		chip info
  * @vref_reg:		vref supply regulators
- * @lock		lock to protect the data buffer during SPI ops
+ * @lock:		lock to protect the data buffer during SPI ops
  * @data:		spi transfer buffers
  */
 
-- 
2.25.1

