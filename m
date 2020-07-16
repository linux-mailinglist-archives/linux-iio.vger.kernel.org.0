Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB72224B3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgGPOBH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgGPN7w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A678DC08C5C0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so7174323wru.6
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEDHcQixmRplGH8qNHcfA8UvDCGb3hBlRKYBVkzPSos=;
        b=YF6DGOzvWXwjmcXxIzZUFAmsdA5heVnu9aShEi8rkD0j/TNT8wZuLJMOvDRzajTvu3
         EZ9bTrqWqgDJBUX1agYozSK+ZJnf9PgQkShRJZHA7Ws9e7H4FGsZdVbfQIUlX5mjrKba
         fll3JV4KPJkSLq1yYyR9CiRBCcJw4bnyRIn/BXaWM5gYZ2SHxSseCfkr17CpZ1g93SiM
         L1qvDjd6jhvmp4erh3iWa7niWF1IxIU1P0qyMqzJ0YEdrTdkh4Ur46vuYJ77gEx4dbVJ
         y1CYx0aoTnQbiTTUrafBbYcDxQyZexTCVzZbN0Ggt120qIUmpTS1r5EWSKoV1tvSIFHj
         TRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEDHcQixmRplGH8qNHcfA8UvDCGb3hBlRKYBVkzPSos=;
        b=DpNQFU2fOG3jKd8pIV1BKAyoEVJ9FAu9Q3eHFEZdEasDWVAGQdgBW/LAnXUhr2Mt+a
         K25lS/ajQBe30kQE6+495/18P0YB4ZizG6k7eojCJY0E2Sl8//bJVjrd3AiTKhtXSwsn
         JxIdgemX9TpbdqA1mQcCxu3CheS0JK5dTsm6FZBt7sVKFuLqx4om7kZVkvpvUEa0umlX
         1l7Ma7tW0vsdDpE3jbcOjx64oRNMl73fbwViF0BiYvg3tfOCLXXQM2aFnZEtiIo3aPmd
         SFhfEeDb8T+Tqa8s+h7ODOcCISlyMwF3rEMXb+6OasaMHbkJ+lfuHDFPA9gC84ab+2hP
         wpiQ==
X-Gm-Message-State: AOAM532oggKnqSs93YheUSC/+5WwuqYIoXX4YBl6Jn9djII2NI/6jA/Y
        q9gjY92q23Tkk6xdHtFfqFW8Gw==
X-Google-Smtp-Source: ABdhPJxoUsWtSXEkwMRRz3h+uwsnqGWeXsnl39jFf61Fm9YhnvLTfGANxYoAUCDpYNm0FXBYzcBa9w==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr5124004wrj.273.1594907990336;
        Thu, 16 Jul 2020 06:59:50 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 15/30] iio: dummy: iio_dummy_evgen: Demote file header and supply description for 'irq_sim_domain'
Date:   Thu, 16 Jul 2020 14:59:13 +0100
Message-Id: <20200716135928.1456727-16-lee.jones@linaro.org>
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

 drivers/iio/dummy/iio_dummy_evgen.c:30: warning: Cannot understand  * @regs: irq regs we are faking
 on line 30 - I thought it was a doc line
 drivers/iio/dummy/iio_dummy_evgen.c:42: warning: Function parameter or member 'irq_sim_domain' not described in 'iio_dummy_eventgen'

Cc: Marc Zyngier <maz@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dummy/iio_dummy_evgen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index ee85d596e5284..1febbbff0ded6 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (c) 2011 Jonathan Cameron
  *
  * Companion module to the iio simple dummy example driver.
@@ -27,11 +27,13 @@
 #define IIO_EVENTGEN_NO 10
 
 /**
+ * struct iio_dummy_eventgen
  * @regs: irq regs we are faking
  * @lock: protect the evgen state
  * @inuse: mask of which irqs are connected
  * @irq_sim: interrupt simulator
  * @base: base of irq range
+ * @irq_sim_domain: irq domain
  */
 struct iio_dummy_eventgen {
 	struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
-- 
2.25.1

