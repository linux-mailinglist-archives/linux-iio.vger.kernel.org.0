Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4A2224A6
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgGPOAh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgGPOAF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 10:00:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB96C061755
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so7095171wrj.13
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXEWebe+sS+XiqWoQoRxhD9v/xPZIfBCkXrtYalx/AE=;
        b=S/EfrnxZYjtTtkIkqrTiVNAO5OH8CmVkGRufQpyGIg77dlImgq1h6B0imzE+9ppb0M
         6HvNo8NcLmQOxsp6ag7w/kdzHmCBs96zl8c/zEgOU2ACSfiWCBalio12JP88lb93I95f
         RdSW/antLiyXbEPKnfErgset/xg3Xj1q/fGytgXXTvtC178ieanq6DkjBYmV54DukpI9
         BUX1jhcPwI/vEm1dMhoiQlMxxjG6NChp1HKmc+74KOYiZ4nRuPqIttGsWWOOlDUJIDGz
         aX2dLkiI5FHZCcXmc9wk99oVxwJB+cRRo0L5je04QWne9mO7X3yQxjTwIUj1E85VfVoT
         btjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXEWebe+sS+XiqWoQoRxhD9v/xPZIfBCkXrtYalx/AE=;
        b=pUO8QP+Y6dr/4aBJLwiF18TovvXUjV9QJ0pgOAJC+XZUAUQQ9BCDAixmXdRFmo7eZD
         QHRFO3brpD6nYg3GV3WRFR9ke4vx2KM7pIitpmkZ6ULIieH61R21Q1mm/WIL+pqFthMW
         E7sVoQageizYGPD7eadWnOE0atw74R1eMtGHTr7JHzdgYR1yCLuEqjM3njDnTbKfVt6r
         iAiqsjLqIqzu96AJi4RQY8szR7DfA0Dos6Raw0S9CTB5PyWor9Q6qXqWkXSfyqrT5eae
         ekikbk9ItdZ6mFdITNLkA+ZFn61shKOVfwzm+B84/YnY3w3oj2s6b8evrBCjqlGSM8aC
         ED1Q==
X-Gm-Message-State: AOAM530b5TaDePTpOgjCXwwB3dODVWlLcluRsXnPXFyi1apibaGR/xLP
        Z7FXnfvRTJYvOAB/0RJvWnZNPw==
X-Google-Smtp-Source: ABdhPJxhU91vXkoK1eVdGWHiSEri1q4qS0BOtilZAXAQsoMS3FeyQ/3NdGqlOwnMCMBnpqIzSK5oiQ==
X-Received: by 2002:adf:d084:: with SMTP id y4mr5079554wrh.161.1594908004260;
        Thu, 16 Jul 2020 07:00:04 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 26/30] iio: dac: ad5791: Complete 'struct ad5791_chip_info' documentation
Date:   Thu, 16 Jul 2020 14:59:24 +0100
Message-Id: <20200716135928.1456727-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

... and remove seemingly pointless comment.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5791.c:97: warning: Function parameter or member 'ctrl' not described in 'ad5791_state'
 drivers/iio/dac/ad5791.c:97: warning: Function parameter or member 'pwr_down_mode' not described in 'ad5791_state'
 drivers/iio/dac/ad5791.c:97: warning: Function parameter or member 'pwr_down' not described in 'ad5791_state'
 drivers/iio/dac/ad5791.c:97: warning: Function parameter or member 'data' not described in 'ad5791_state'
 drivers/iio/dac/ad5791.c:103: warning: cannot understand function prototype: 'enum ad5791_supported_device_ids '

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5791.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 1d11f39ed0474..d8485004b1010 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -76,9 +76,11 @@ struct ad5791_chip_info {
  * @chip_info:		chip model specific constants
  * @vref_mv:		actual reference voltage used
  * @vref_neg_mv:	voltage of the negative supply
- * @pwr_down_mode	current power down mode
+ * @ctrl:		control regster cache
+ * @pwr_down_mode:	current power down mode
+ * @pwr_down:		true if device is powered down
+ * @data:		spi transfer buffers
  */
-
 struct ad5791_state {
 	struct spi_device		*spi;
 	struct regulator		*reg_vdd;
@@ -96,10 +98,6 @@ struct ad5791_state {
 	} data[3] ____cacheline_aligned;
 };
 
-/**
- * ad5791_supported_device_ids:
- */
-
 enum ad5791_supported_device_ids {
 	ID_AD5760,
 	ID_AD5780,
-- 
2.25.1

