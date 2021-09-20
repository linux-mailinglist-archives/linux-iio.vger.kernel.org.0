Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47FD411192
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhITJH3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 05:07:29 -0400
Received: from www.zeus03.de ([194.117.254.33]:54326 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236151AbhITJHT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Sep 2021 05:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=+UKNkOTxYKV56+
        cBXEkABbYKt7nc/fV5beJYjVps6qw=; b=Ld5dzk/OkWa511RNMIDMFphcKNNjnJ
        3uiezv7zR+e3S6Y89D8q7vzPPZmcpAwVMiwkrw3eRkVhDWxR3EkVCGqoqbS1oiS5
        hXNET3nOU+yfRqfSaz6sk7Pi0zIYGm6hGUhIozdQkH7afvedzljMmIJUp86FxrnH
        38UB198D6zxHA=
Received: (qmail 2412719 invoked from network); 20 Sep 2021 11:05:26 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2021 11:05:26 +0200
X-UD-Smtp-Session: l3s3148p1@C4/0lGnMEosgAwDPXwlxANIWpbLKE1Uh
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 6/9] iio: common: cros_ec_sensors: simplify getting .driver_data
Date:   Mon, 20 Sep 2021 11:05:18 +0200
Message-Id: <20210920090522.23784-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
References: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 28bde13003b7..b2725c6adc7f 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -831,8 +831,7 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
 
 static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-- 
2.30.2

