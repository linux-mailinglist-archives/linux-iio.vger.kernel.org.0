Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39BC4A4237
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jan 2022 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359312AbiAaLLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Jan 2022 06:11:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57144 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376798AbiAaLJH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Jan 2022 06:09:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B3A1B82A6E
        for <linux-iio@vger.kernel.org>; Mon, 31 Jan 2022 11:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DAEC340EF;
        Mon, 31 Jan 2022 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643627345;
        bh=W7x9HinFb82teZoeIRE/GNMIU4Gq7YA31vQbdmQqGW0=;
        h=From:To:Cc:Subject:Date:From;
        b=HTsaKsVNs9ZhniohywN5p8HujlHcjOYyB2ZUz73kD/c66bA7rrHi/a0tm0ikkr3Yq
         tbTMMGTAJhX248guH39Jxi1AXUxNYUuwAwJsnFTa5GeuXkbzTEtVDBAAYlx4znTcET
         JSMSHdxifcYOCplIvXThwAEGMMXk2++36orZ/E6OUAMc52QH8rYAPGwEJvGH6zsNnY
         qh+XQiMUdvw1P56EgGr5B2LNHZVzzhfxtvzRmpma947lwZBZvhEBS+WX5PflwxVuYr
         r7Xby4A08kkdQW6vd5pp1SZLp7mHM3vs3tyFAiPb4w9X/OjqvK/dNy1fb7bM8pVMok
         yebvvgFNaTF9g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: wait for settling time in st_lsm6dsx_read_oneshot
Date:   Mon, 31 Jan 2022 12:08:54 +0100
Message-Id: <6c10e1de14a42eca2d283a9df242b426e371543e.1643627150.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to wait for sensor settling time (~ 3/ODR) before reading data
in st_lsm6dsx_read_oneshot routine in order to avoid corrupted samples.

Reported-by: Mario Tesi <mario.tesi@st.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 727b4b6ac696..93f0c6bce502 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1374,8 +1374,12 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
+	/*
+	 * we need to wait for sensor settling time before
+	 * reading data in order to avoid corrupted samples
+	 */
 	delay = 1000000000 / sensor->odr;
-	usleep_range(delay, 2 * delay);
+	usleep_range(3 * delay, 4 * delay);
 
 	err = st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
 	if (err < 0)
-- 
2.34.1

