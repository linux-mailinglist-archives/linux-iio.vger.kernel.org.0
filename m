Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2BE45AE02
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhKWVK0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239728AbhKWVKS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDACF60FC1;
        Tue, 23 Nov 2021 21:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701630;
        bh=n8ZK+v3kjyN+iI9/lY9Rj7gjEyJKxUFaRfgmFFpG3Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzesbO9i6s87Aa1dnWhs6sTuX69viigTOGojpv0at8dTf6wEb1V6j4KEMtgRLaRYF
         5zvfVw28KkXdAMai6oV21R03KgkZn989W9lhdVb/+zYlJtJrDPfcjRZOrHqisaUypD
         5miGcdDOCIzu/7EOELC5LSCXusgAQmJarrAkoD0UAOTeQ5yeOyuLZW9qMW1KCO/MeS
         Mv5u1dkSJrz6tOImUruG59huYUCYs6GSQiH1JTGeTTrq5HudII6NhyOjcq8XD13IlJ
         XWuV33R+HZmslh3kDQTb+hUE8qm9n2u9k8T6hVDg/+aKBLpnMGEDZjIkl7e/vlOTUM
         l9+142Hdvoclw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 40/49] iio:pressure:mpl3115: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:10 +0000
Message-Id: <20211123211019.2271440-41-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/mpl3115.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index e95b9a5475b4..8148655537c9 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -301,14 +301,13 @@ static int mpl3115_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mpl3115_suspend(struct device *dev)
+static __maybe_unused int mpl3115_suspend(struct device *dev)
 {
 	return mpl3115_standby(iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev))));
 }
 
-static int mpl3115_resume(struct device *dev)
+static __maybe_unused int mpl3115_resume(struct device *dev)
 {
 	struct mpl3115_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -318,10 +317,6 @@ static int mpl3115_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(mpl3115_pm_ops, mpl3115_suspend, mpl3115_resume);
-#define MPL3115_PM_OPS (&mpl3115_pm_ops)
-#else
-#define MPL3115_PM_OPS NULL
-#endif
 
 static const struct i2c_device_id mpl3115_id[] = {
 	{ "mpl3115", 0 },
@@ -339,7 +334,7 @@ static struct i2c_driver mpl3115_driver = {
 	.driver = {
 		.name	= "mpl3115",
 		.of_match_table = mpl3115_of_match,
-		.pm	= MPL3115_PM_OPS,
+		.pm	= pm_ptr(&mpl3115_pm_ops),
 	},
 	.probe = mpl3115_probe,
 	.remove = mpl3115_remove,
-- 
2.34.0

