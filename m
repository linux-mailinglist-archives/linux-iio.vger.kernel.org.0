Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF902224A4
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgGPOAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgGPOAH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 10:00:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2EBC08C5E0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so10407731wmi.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9Q3bTJZX3NDvreJxnZXUAz4v4ayzBXDJ3tm0mtPNPY=;
        b=ziAfVv30fXS8ze8sJobKL6Wnl0wB5LcRq5zYNZN7QBBRgefFsBvPnonlKcGj9LW/0s
         Fz7UenrYVPmXFgcF6XEJI2lPgfmp7byFmPMaRc0P8v23DRrDMHjwL55+nx4BpIOMxvXe
         YGUFcKGaNCuAnjQ8nNUaRlHfwr9OP2T4hPh7mxIj/qkhOjp8hMbOmW1NLsQ1q5lMN3Z6
         d+3ibLeltB8dbDdNJOmHStX3p+QvjgvOBjlMOt4FLsqCFiRAy5MO7emnTiZ0c3cjo029
         G9mUyJCdjavWgZ4cG7vDvrQoTSzY4qyzr9qDXhy8IiPByiEMLJbsbqpXRv7baOPJQzjY
         NBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9Q3bTJZX3NDvreJxnZXUAz4v4ayzBXDJ3tm0mtPNPY=;
        b=s43DUbKjYwP+0DjaNK0z/DkMM7vpsIUE/9bUWgV8rYiJ3rYMVyspqxiycNfcTXMBaJ
         dNDEzi+eT2LDO/PEvPqajAJjM45Iz9wPl2ab4lNN1NGhPT9+EL2b4B251srUWL0Yhn39
         bBo23C3tCVrEU8aEzjKwGs0HF0o3PSEJLRcVHOpkqu7pYwUsSTRuk9o4OHtjzEIBhdOE
         4mYnga8sB5AuoJIT10VgWbd2AgEuAGblW+ktMp/IX+C5tZyU6y1ncfjGP/WdCfcXZ0nu
         yfxxsowGJiE0l1ZPfS/snv1bddAzRbemdj/aPX5YaLMHiFPqTcTD5txdLOgdUZlYQvqd
         5ByA==
X-Gm-Message-State: AOAM531ODlH4Ls5QzZxMaxp9UZ2LF47VMa0neB2xRZloMkcS3vW76ZqU
        9LXi9pKNLvjAaRKIYHXsPfAcpA==
X-Google-Smtp-Source: ABdhPJybrr9cAklwujn3fxx1mowY6xGoBHDpPn3WqQCQ9G7qVh+ValpUYqPhWju9zlFPKh56e05p8Q==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr4442466wme.50.1594908005504;
        Thu, 16 Jul 2020 07:00:05 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kevin Tsai <ktsai@capellamicro.com>
Subject: [PATCH 27/30] iio: light: cm32181: Fix formatting and docrot issues in cm32181_acpi_get_cpm()
Date:   Thu, 16 Jul 2020 14:59:25 +0100
Message-Id: <20200716135928.1456727-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'dev' not described in 'cm32181_acpi_get_cpm'
 drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'obj_name' not described in 'cm32181_acpi_get_cpm'
 drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'values' not described in 'cm32181_acpi_get_cpm'
 drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'count' not described in 'cm32181_acpi_get_cpm'

Cc: Kevin Tsai <ktsai@capellamicro.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/light/cm32181.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 160eb3f99795e..9764099faef9a 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -93,10 +93,10 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2);
 #ifdef CONFIG_ACPI
 /**
  * cm32181_acpi_get_cpm() - Get CPM object from ACPI
- * @client	pointer of struct i2c_client.
- * @obj_name	pointer of ACPI object name.
- * @count	maximum size of return array.
- * @vals	pointer of array for return elements.
+ * @dev:	pointer of struct device.
+ * @obj_name:	pointer of ACPI object name.
+ * @values:	pointer of array for return elements.
+ * @count:	maximum size of return array.
  *
  * Convert ACPI CPM table to array.
  *
-- 
2.25.1

