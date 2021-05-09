Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF54377672
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhEILiy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhEILiy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FEA9613E5;
        Sun,  9 May 2021 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560271;
        bh=7v361hqgBE1lMuKYO6LrJ64ROS0EptwwvqD6k3sa+SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFmz36ZtVKpWge7aPwcyXX2zxS4l2kOYeoFSx4/rYyXrdR3cC1V8bfDJv84cxtqmo
         ipqaRfxX0vnSeLDU0xdl4+DC0Ubc1Kf3jsKL2kYuk/MIq8zMIfK22k0BfxMLyGj9UP
         286QHMLh9F/NZrRdmo6aH6WEcFHWoiRuP2+DnODLCRi32145inCvvuEaVsgPMb8mCh
         dn3myC33jO8VnAWOF6vOqwGSUYzG0A3JxdUhEPPA2C3udsDNsVQAd7VQIj6BLrpQcu
         wxBYbykobJrv+HlZk6ah6z7aebvWYGthN4LEmt/oDCMviSqdKQTw4ff6p8nGT2p9JO
         +68vVM4QspNEw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 27/28] iio: pressure: icp10100: Use pm_runtime_resume_and_get() + handle errors
Date:   Sun,  9 May 2021 12:33:53 +0100
Message-Id: <20210509113354.660190-28-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using this new call makes it easy to handle failures in resume as it
doesn't hold a reference count if it exits with an error.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/pressure/icp10100.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index 48759fc4bf18..80cd66688731 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -250,7 +250,9 @@ static int icp10100_get_measures(struct icp10100_state *st,
 	__be16 measures[3];
 	int ret;
 
-	pm_runtime_get_sync(&st->client->dev);
+	ret = pm_runtime_resume_and_get(&st->client->dev);
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&st->lock);
 	cmd = &icp10100_cmd_measure[st->mode];
-- 
2.31.1

