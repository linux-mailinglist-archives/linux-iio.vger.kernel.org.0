Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0E37765A
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhEILiD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhEILiC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E4E96140B;
        Sun,  9 May 2021 11:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560219;
        bh=mFBTbu4veWJ9vAdRhDSlxS48yXps33WUKtff0aPHXbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErJb2kAr2D/NLDp74GgLXpSNlTZWEckg8NBixBVhZQw5m8UzsBVnUyYq3Q+5wyydo
         +QN31xUl6QKD+CXSEZK5SCdyufrqAinf9/rzRUBmb+a9yIiYqNt/9qg7c7xkPU/jdu
         l6M8uD+aN8S74Al4oVMbO1nkHjxB987X4abjcP8SDpYdXMun1mUTxtu3EvVlAFXkCH
         Wzgf9N+c1PHp3PSJ3Wwlhw8/uzuBv3cq4gv7Dvdo08LeuG+mhIIF32i1wEBU+dsA1w
         jHgIzay8xgN5MdzQLB2vhrs7DwJAVDoJJRwJZ7MblDkKlLeTr/O+Vo6PwJcb/GgJAJ
         nh6W8zimSFF0g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 04/28] iio: accel: bmc150-accel: Balanced runtime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:30 +0100
Message-Id: <20210509113354.660190-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A call to pm_runtime_put_noidle() doesn't match any call that would
result in a get().  It is safe because runtime pm core protects against
the reference counter going 0, but it makes it harder to understand the
code.

Whilst here use pm_runtime_resume_and_get() to tidy things up.
The Coccinelle script didn't get this one due to more complex code
structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 62a164a7b852..43cfadf8f6b7 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -389,7 +389,7 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 	int ret;
 
 	if (on) {
-		ret = pm_runtime_get_sync(dev);
+		ret = pm_runtime_resume_and_get(dev);
 	} else {
 		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
@@ -398,9 +398,6 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 	if (ret < 0) {
 		dev_err(dev,
 			"Failed: %s for %d\n", __func__, on);
-		if (on)
-			pm_runtime_put_noidle(dev);
-
 		return ret;
 	}
 
@@ -1836,7 +1833,6 @@ int bmc150_accel_core_remove(struct device *dev)
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_put_noidle(dev);
 
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
 
-- 
2.31.1

