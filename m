Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1AC23499D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgGaQt6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733045AbgGaQtB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:49:01 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1DAC061574
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z6so32339040iow.6
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYfRtRWNJl9Yn2hyI+uBsjOjqoFWT79cyClOPwpH2dg=;
        b=GdIxWKBq8Nx+RFYfACUl5CdLRHgJ6yNDGaMOR99XLu1RRGcn+vTrIQHXoXHfT+jB4M
         LKMiZicp1+wFftkxIX7jZ7mmdXgJS/u0/P9hH4kdlLf3bPzyjSdttsBlwv5U1gphcgEm
         ydtGzFYm7eWucSJ12u01u+mFTDkKbrkwA+cL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYfRtRWNJl9Yn2hyI+uBsjOjqoFWT79cyClOPwpH2dg=;
        b=aQorRcKBC8KacmNhFY/oXMjUe1F9wssJXUqKrnqtrlEveifHuXplTV87ecpf6wYUih
         738RysNXi+7IP4eT1KVf8xM7QuoUv3nEpxzHCgbwuB/SbvcoANH0HA56IUM7A+XQsK+h
         +LJP9Lgc1IQOi4XJj07Nw9mmdr4R9ttSXTxo//Ep/8gr1onoI0KLaExp/RNSpW4FRMxa
         5x5GmZf4w6HED+EWw8GJjYUbWMtnsJ2iN2z54ahlKSn1NHymE1rHgNl10SEZBwtTFAGQ
         j74yDJoJA+xmH72j9BozsBWR4NdZsXucl8CMYCdg3fZOQD7Eb4HIbFhZV4+bKqQaPdH6
         na4w==
X-Gm-Message-State: AOAM532Td9WTx49xwoqL2Gobk/iATYriwIy4WIMCFtNm7zOLqH/vts5X
        QQrp2E85rpIUNzWEtF1fuRkqaQ==
X-Google-Smtp-Source: ABdhPJzwwlzQZYE4CzsXOSXHfiJmZOY3GnLWv89mBk6yUE97mxpy9XhELrZ/P6leUhKFdeIKJCsR3w==
X-Received: by 2002:a6b:f911:: with SMTP id j17mr4297683iog.96.1596214140314;
        Fri, 31 Jul 2020 09:49:00 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:48:59 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v3 03/15] iio: sx9310: Fix irq handling
Date:   Fri, 31 Jul 2020 10:48:40 -0600
Message-Id: <20200731104555.v3.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes enable/disable irq handling at various points. The driver needs to
only enable/disable irqs if there is an actual irq handler installed.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

Changes in v3:
 - Moved irq presence check down to lower methods

Changes in v2:
 - Reordered error handling on sx9310_resume()

 drivers/iio/proximity/sx9310.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 07895d4b935d12..c7a27c21c20cd1 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -323,12 +323,18 @@ static int sx9310_put_event_channel(struct sx9310_data *data, int channel)
 
 static int sx9310_enable_irq(struct sx9310_data *data, unsigned int irq)
 {
-	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, irq);
+	if (data->client->irq)
+		return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq,
+					  irq);
+	return 0;
 }
 
 static int sx9310_disable_irq(struct sx9310_data *data, unsigned int irq)
 {
-	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, 0);
+	if (data->client->irq)
+		return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq,
+					  0);
+	return 0;
 }
 
 static int sx9310_read_prox_data(struct sx9310_data *data,
@@ -382,7 +388,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 
 	mutex_unlock(&data->mutex);
 
-	if (data->client->irq > 0) {
+	if (data->client->irq) {
 		ret = wait_for_completion_interruptible(&data->completion);
 		reinit_completion(&data->completion);
 	} else {
@@ -1011,10 +1017,11 @@ static int __maybe_unused sx9310_resume(struct device *dev)
 
 out:
 	mutex_unlock(&data->mutex);
+	if (ret)
+		return ret;
 
 	enable_irq(data->client->irq);
-
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops sx9310_pm_ops = {
-- 
2.28.0.163.g6104cc2f0b6-goog

