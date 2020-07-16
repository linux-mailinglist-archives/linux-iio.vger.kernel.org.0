Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD0E22248A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgGPN7q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 09:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgGPN7p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BAEC08C5CE
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so10406638wmi.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Eaol5OJho4x5OhdGBezivs0c17Lo7ITBf48jP3v0yo=;
        b=RHQeFYL/OmK16RHx2LSLSKLrhLMmhA0CaejXG1HaWnEDt7K50YHifx5xJLClwMV/wS
         TCNPelO8eMk3T7G/lqrywMaTLydA1aYBQ+vT84ZILA8314FO5/NhEqsMBRUSwbRc7uFj
         Ri1hVY0VecyEy05MzOC6BKwOhgx6Wkpn3b07Ng7i9rz//IMICEXzlereQVymFXUSY5w+
         R4o+NlvdsFomvyGSH+LWwNa+MqcZ39O/aAsNef5bP1tW7AY5GTtEa0J42pRPUeGIiHdG
         8NlLf8q3Hzr1Mc11aUqeb6pWZ3qwmhMd4exbaW1nUR3jKIZJen/6eIasClPW9M3IHePW
         5EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Eaol5OJho4x5OhdGBezivs0c17Lo7ITBf48jP3v0yo=;
        b=X0BZ7nHYpEBcFq4M2vPofoFkxEQx9N/gIQ0eNYROErEYIAkiWlWcO9khHn2+3WKPoW
         9HVyZHG+Zt2d5uMwbCiABzvLpyZxrRXzY26H4BGgvGegI1wJgXR4gaqppPHjURcBbsAu
         RcEUNl6MNt/EP1MY2mSUXPJAmA15S9tx26C+WEr+keOsrCs/RW3HC3gcAJPYFgbpLnFh
         sQSvjKQhN+B9h8XBbPGBI5Z2oOMEK6kt7J3oRHARKDjWntO5/5jyjxUpyD+YbOgz2gmv
         Ooup91nNIIOeukPJZT8si5VoqXafT4n3KKzG3gBkklXVkjLoCYw9Oqo7RS9J5Jywg+Xw
         jZXw==
X-Gm-Message-State: AOAM530kFpk1+uYnoC3WkrP/8xkeuFwzIl930Rl+lE1EG4N1X0dWN89B
        bGs9nMr7I8yE4P+LT9ZfjTxRGA==
X-Google-Smtp-Source: ABdhPJwanyU3zpVxpnfrGhUaYF6MgwV6z6GKysPVU7d5bkqGLUbbniCS3mFBPRMuxoy4Z7WLfIZhfw==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr4400925wmc.52.1594907983670;
        Thu, 16 Jul 2020 06:59:43 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 09/30] iio: dummy: iio_simple_dummy: Demote unworthy kerneldocs and correct misspelling
Date:   Thu, 16 Jul 2020 14:59:07 +0100
Message-Id: <20200716135928.1456727-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

File header comments are not good candidates for kerneldoc.  Neither
are generic comment blocks.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dummy/iio_simple_dummy.c:26: warning: cannot understand function prototype: 'const struct config_item_type iio_dummy_type = '
 drivers/iio/dummy/iio_simple_dummy.c:564: warning: Function parameter or member 'name' not described in 'iio_dummy_probe'
 drivers/iio/dummy/iio_simple_dummy.c:564: warning: Excess function parameter 'index' description in 'iio_dummy_probe'
 drivers/iio/dummy/iio_simple_dummy.c:700: warning: cannot understand function prototype: 'const struct iio_sw_device_ops iio_dummy_device_ops = '

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dummy/iio_simple_dummy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 6cb02299a2152..be66b26373723 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (c) 2011 Jonathan Cameron
  *
  * A reference industrial I/O driver to illustrate the functionality available.
@@ -553,7 +553,7 @@ static int iio_dummy_init_device(struct iio_dev *indio_dev)
 
 /**
  * iio_dummy_probe() - device instance probe
- * @index: an id number for this instance.
+ * @name: name of this instance.
  *
  * Arguments are bus type specific.
  * I2C: iio_dummy_probe(struct i2c_client *client,
@@ -687,7 +687,7 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
 
 	return 0;
 }
-/**
+/*
  * module_iio_sw_device_driver() -  device driver registration
  *
  * Varies depending on bus type of the device. As there is no device
-- 
2.25.1

