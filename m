Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C00343412
	for <lists+linux-iio@lfdr.de>; Sun, 21 Mar 2021 19:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCUScN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Mar 2021 14:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhCUScB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Mar 2021 14:32:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D934B61947;
        Sun, 21 Mar 2021 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616351521;
        bh=/w3x26GpfDaIiZARqtt3xuodAmVd36KAjEJXDYQEaKs=;
        h=From:To:Cc:Subject:Date:From;
        b=iy/Z8bN886jW26t0gS+KpCAzGaHjM746lSLR5TEdKygxgBzNFsKR56FxXf93ynGjm
         ajCzng0/ONAmdxCD3f4Ti/ukYP5ceshPvYkTntiV6wvfv2tCsIFvQEHHFgYaESsqkV
         gtyxFx6lDBCcFKPXYEIJKADrAqdRPmtV17jDpy9/SE9Ev7ReNaoA64DReV589i/3/F
         MutIIscNU94YpP+Ff4EN+qbq506/Z1WoMgIboi5cQhptNUqys7ZNUg771mPLSoccV/
         PadVcds3T5CrNZb/JC01+PpUPklx/mw1tC5ZBnYLKu0buSH72k0ll/tQAeU6ZcsFHe
         3kp9M3OmHifaw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH] iio:accel:adis16201: Fix wrong axis assignment that prevents loading
Date:   Sun, 21 Mar 2021 18:29:56 +0000
Message-Id: <20210321182956.844652-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst running some basic tests as part of writing up the dt-bindings for
this driver (to follow), it became clear it doesn't actually load
currently.

iio iio:device1: tried to double register : in_incli_x_index
adis16201 spi0.0: Failed to create buffer sysfs interfaces
adis16201: probe of spi0.0 failed with error -16

Looks like a cut and paste / update bug.  Fixes tag obviously not accurate
but we don't want to bother carry thing back to before the driver moved
out of staging.

Fixes: 591298e54cea ("Staging: iio: accel: adis16201: Move adis16201 driver out of staging")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/accel/adis16201.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 3633a4e302c6..fe225990de24 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -215,7 +215,7 @@ static const struct iio_chan_spec adis16201_channels[] = {
 	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
+	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
-- 
2.31.0

