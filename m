Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0354312594
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBGPuM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhBGPuJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5BAD64E53;
        Sun,  7 Feb 2021 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712938;
        bh=/MAkf+rmyWrWdd25iKKkrS07W14XZXRkgsf8cbh2gM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQX3dYiMFYUxCymAGC3vI6Yg6LqdBUtmQd72h3iTiuiFcvjBZG0j3pibYx56DWZkg
         eU9y7bf+gzZ65SRD8cqc0lV+nbVfzW9G7ZFNW8JNRH7DSnedso2CwguQzCRf+VNavN
         aaNPo/8JPtHgrE2kWnAjLA/5YBk6XE5dr5yDdPyLjwtL+D2HF5wWK+9q1+XnJJWDnx
         3B7oJoW9wdzud9ug3kAij8CeEE/t8Sj9pIdACkJrxp8WX0fSpwlQV02QbIokldHCBD
         RAObs8dmfTBHZS89CnJbNcsCZ/9mzADWWnzcRXA/WLcMJKPoJzdYH4YjCrrlAFpugv
         wRTbLQX21ndfA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/24] iio:event: Add timeout event info type
Date:   Sun,  7 Feb 2021 15:46:09 +0000
Message-Id: <20210207154623.433442-11-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

For adaptive threshold events, the current value is compared with a
(typically) low pass filtered version of the same signal that slowly
tracks large scale changes.  However, sometimes a step change can
result in a large lag before the low pass filtered version begins
to track the signal again.  Timeouts can be used to made an
instantaneous 'correction'.  Documentation of this attribute
is added in a later patch.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/linux/iio/types.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 7e532117ac55..ad01b4d84562 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -245,6 +245,7 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_PERIOD] = "period",
 	[IIO_EV_INFO_HIGH_PASS_FILTER_3DB] = "high_pass_filter_3db",
 	[IIO_EV_INFO_LOW_PASS_FILTER_3DB] = "low_pass_filter_3db",
+	[IIO_EV_INFO_TIMEOUT] = "timeout",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 1e3ed6f55bca..f2e7c96e6e81 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -16,6 +16,7 @@ enum iio_event_info {
 	IIO_EV_INFO_PERIOD,
 	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
 	IIO_EV_INFO_LOW_PASS_FILTER_3DB,
+	IIO_EV_INFO_TIMEOUT,
 };
 
 #define IIO_VAL_INT 1
-- 
2.30.0

