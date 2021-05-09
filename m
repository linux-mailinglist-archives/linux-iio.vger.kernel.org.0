Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB1377670
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhEILip (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhEILip (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F8EF613E5;
        Sun,  9 May 2021 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560262;
        bh=WR/hHX1upp02qFBvL+bQp1Y9uVClwFLSn4QFgAnXTvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msG9AqdZKP9uIbbYIVVFrArinH2x4pETlxR9GezSuBMAAs5WYCdH9ME4Yu9ViGW9g
         Y0BATI/7wcJoqt8/TvyBh9wxpnhv4Ac/MaHdoj3MlOnuifYhvLOBXlLHo0g8h8InvZ
         fqflQ3+ZOyaOu1uZzaMkTdd/YU9JKWlffR7BDENR14vc10T7rTcKI8rmGJGfhSsc8r
         mDWewS0pZRvSlEG0+wunLnEswIGqkOK5T7Xk3fwEAYaD0qP5a6ZDBOlJjly8H77vmA
         UVOW/84/45uT+Rpw/blPmtgU8YRlldcPGSTP+uN5gdXD5yejaHKO5HEYOnSChP1m4W
         iTtoVYdnZsFdA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 23/28] iio: pressure: zpa2326: fix potential extra call of runtime suspend.
Date:   Sun,  9 May 2021 12:33:49 +0100
Message-Id: <20210509113354.660190-24-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This case illustrates why the new pm_runtime_sync_and_get() is good
in that it makes clear the correct way to handle errors.

Calling pm_runtime_put() on failure of the _get() in pm_runtime_get_sync()
will potentially result in powering down an already powered down device
(as we never successfully powered it up.  Unlikely to cause any problems
in reality.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/zpa2326.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 89295c90f801..97ac3ba399f7 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -664,11 +664,9 @@ static int zpa2326_resume(const struct iio_dev *indio_dev)
 {
 	int err;
 
-	err = pm_runtime_get_sync(indio_dev->dev.parent);
-	if (err < 0) {
-		pm_runtime_put(indio_dev->dev.parent);
+	err = pm_runtime_resume_and_get(indio_dev->dev.parent);
+	if (err < 0)
 		return err;
-	}
 
 	if (err > 0) {
 		/*
-- 
2.31.1

