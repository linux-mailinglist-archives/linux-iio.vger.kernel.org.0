Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F33A0944
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhFIBff (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhFIBfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10395C06178B;
        Tue,  8 Jun 2021 18:33:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mp5-20020a17090b1905b029016dd057935fso423093pjb.5;
        Tue, 08 Jun 2021 18:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ahZ4wxqYj8/PnnRsg7CFwjhhCPg4bzL3Iu0oZpPEJNk=;
        b=FDGW5jjxYBl+kKCMS9YTEBDfvxM/0VEtfXATZc65wdNzQmz8UuqkfM92rH3MvullfZ
         eB5WKaO5LuVHMljirIylzAwLp9/nfS0xZWORRdMtt6pYXfQI8IivrXpxvuF0O0BUw3U2
         LvSH8ZAih2PPwFckAIrX+kB13eUfDC1T7vvIy6WJCQWp63cwhuvS7x0Asuwg376kMHVB
         rbrbN0W5Y5rlz/6ye1H1NVBfthjnzKENF5EPMvlUTUeRYIeZeWlX/rD1w/6ClzzKc/ot
         y37OGiw/oZeRMKi9TCaw4T/W/NtGZNjhZZ/kRZPKEZnbI2ZWAWyFPug/lajfXFt3kILP
         bxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahZ4wxqYj8/PnnRsg7CFwjhhCPg4bzL3Iu0oZpPEJNk=;
        b=CkK5dzhaYNNSTSROL6haYOSerRaczpnFKHgCLUBbTDrpESTg7HS6/eD7aYIYlqB59D
         0Peeb/sXxXkpjhpLMXCYrtUWjjIHxc488xvt3a0C5KZR1AWNKoysttfztiBfryGR2MuF
         V+3tgtgupE/hQ0vFqz+N9+ZggGc5CyrYLgWHVQGIhUcnmHYEnqqhlVmaBN+lfTxZii2z
         5DkKoXmQNN99uBmpS8GRBit1xCxEZZaEjbNrDuXIG6A5JxYy5wu8+vDcLr2xTkbgHOXu
         jFlO/vyDoiLCL3Gd6nah1WaMvJ6dATFySUPODEHOE9Mkbs3Nf2Fr+FdN68JC0uCE+dNV
         sbZg==
X-Gm-Message-State: AOAM530cNffjsDoM9ih4brq4+P0ZM4wF1Y1Cyz/iZXK5sqq+VEMHvKN/
        YFZhi37kPxGGe7hAtvtHUf0=
X-Google-Smtp-Source: ABdhPJxU1XV1SNYwMQaNecIVUytIlu6/3AGUsvUMd4zVgD9V/R+wygJf4LJ8zXkl5C6XA7pShIvWtg==
X-Received: by 2002:a17:902:d694:b029:103:ec01:12d5 with SMTP id v20-20020a170902d694b0290103ec0112d5mr2979637ply.19.1623202407675;
        Tue, 08 Jun 2021 18:33:27 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:27 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v11 19/33] counter: Standardize to ERANGE for limit exceeded errors
Date:   Wed,  9 Jun 2021 10:31:22 +0900
Message-Id: <c5dbcd525d1c04c474fc3988ded9b509eb12ac9e.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ERANGE is a semantically better error code to return when an argument
value falls outside the supported limit range of a device.

Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: David Lechner <david@lechnology.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c        | 6 +++---
 drivers/counter/intel-qep.c         | 2 +-
 drivers/counter/interrupt-cnt.c     | 3 +++
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index b7d6c1c43655..0409b1771fd9 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -154,7 +154,7 @@ static int quad8_count_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (val > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
@@ -669,7 +669,7 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (preset > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
@@ -714,7 +714,7 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (ceiling > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index ab10ba33f46a..7b4eb8ff8348 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -320,7 +320,7 @@ static ssize_t spike_filter_ns_write(struct counter_device *counter,
 	}
 
 	if (length > INTEL_QEPFLT_MAX_COUNT(length))
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&qep->lock);
 	if (qep->enabled) {
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 0e07607f2cd3..f27dea317965 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -107,6 +107,9 @@ static int interrupt_cnt_write(struct counter_device *counter,
 {
 	struct interrupt_cnt_priv *priv = counter->priv;
 
+	if (val != (typeof(priv->count.counter))val)
+		return -ERANGE;
+
 	atomic_set(&priv->count, val);
 
 	return 0;
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 78f383b77bd2..49aeb9e393f3 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -283,7 +283,7 @@ static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
 		return ret;
 
 	if (ceiling > STM32_LPTIM_MAX_ARR)
-		return -EINVAL;
+		return -ERANGE;
 
 	priv->ceiling = ceiling;
 
-- 
2.32.0

