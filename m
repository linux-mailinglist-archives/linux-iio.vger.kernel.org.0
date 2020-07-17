Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11622411E
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgGQQ4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGQQ4G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D4C0619D4
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so11887781wru.6
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nb/tQ5HxMJdwcZU2zmj2JX73dDo4qPaNgdilk8WGn+Q=;
        b=PKIGtM3D2mbpyKmn3TKhhnoylY/9SJkUrY4ltLFIvfTnvtK22ZcRqj+nCxV7ManVNH
         PM6fCgKXbO3du9XZekl35+F/HNFxILIuNr89nGvO8ZykWn3ZxeCXbyz16VaOu4wO2s0A
         Q9DcmJ2djcG9N6cZJyM9u6x9govSwTDegiSXdbmxvOQIY1Z878AgbNMG0RuKNv+rnemV
         EzgMJbROJp64FD8fLqBQ5/x6fMR5DUBqrLlF4wjYn+UEH7VnSn6FdaexPbS8sXcwCEOv
         E0U3cqvHiAiXh07wKOKILeRvzBXnnw1GarLo4j//BBH50lLMEkNNCJKmnH4XQX149h+t
         Qyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nb/tQ5HxMJdwcZU2zmj2JX73dDo4qPaNgdilk8WGn+Q=;
        b=XPu/UuzqXc0prXm3buY9jhIbJ3re2EtyMC6izJKo4dKQG1awqtiCKPChH4bGIYKAl/
         A8FNgjcaIhiZTEuqGr+jopzWia0LIdNzi5xsK/8jwwNhMJEfsCSlhN9drQ+P7pDgVMcr
         tYLKPLVkvl6OQ3Xzy5AJmaZ8ad0yLTxJwj0M5BrcB0Hwgg/yjbY3A/+OUD+lOWy2F4lW
         ST5lrMPB1S3uojGE4l3ZmRiVFhB43e8+4ZGo3ofIvabFzq18MEygDuiQ81O7pnOqiGvr
         OuaDb4DMEekCTPXK9MVsRoqF6q8iV8Do801gtKR/IkZbGQM+j/jteMxmtE9Dh9/0tyZd
         Pqzw==
X-Gm-Message-State: AOAM531DXQhpmFIeOTsaiD1T6SZLRMVS7iGp0keP3mwlQ0EEgiqE03jj
        /uEa4VQfLKCjTPF966uj1mZSVg==
X-Google-Smtp-Source: ABdhPJztkgQ/mGf0gxIVfj/VajfXJbHIhm8tYxqIPUW3TqJw+AzgcxbVjtmnL0yYGvZxxCqshqRMsg==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr11020033wrw.284.1595004965111;
        Fri, 17 Jul 2020 09:56:05 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Silvan Murer <silvan.murer@gmail.com>,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Subject: [PATCH 06/30] iio: dac: ltc2632: Fix formatting in kerneldoc struct header
Date:   Fri, 17 Jul 2020 17:55:14 +0100
Message-Id: <20200717165538.3275050-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ltc2632.c:50: warning: Function parameter or member 'powerdown_cache_mask' not described in 'ltc2632_state'
 drivers/iio/dac/ltc2632.c:50: warning: Function parameter or member 'vref_mv' not described in 'ltc2632_state'
 drivers/iio/dac/ltc2632.c:50: warning: Function parameter or member 'vref_reg' not described in 'ltc2632_state'

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Silvan Murer <silvan.murer@gmail.com>
Cc: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ltc2632.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index f891311f05cfe..733f13d3e5df4 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -38,9 +38,9 @@ struct ltc2632_chip_info {
 /**
  * struct ltc2632_state - driver instance specific data
  * @spi_dev:			pointer to the spi_device struct
- * @powerdown_cache_mask	used to show current channel powerdown state
- * @vref_mv			used reference voltage (internal or external)
- * @vref_reg		regulator for the reference voltage
+ * @powerdown_cache_mask:	used to show current channel powerdown state
+ * @vref_mv:			used reference voltage (internal or external)
+ * @vref_reg:		regulator for the reference voltage
  */
 struct ltc2632_state {
 	struct spi_device *spi_dev;
-- 
2.25.1

