Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BBC2D404B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 11:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgLIKsS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 05:48:18 -0500
Received: from www381.your-server.de ([78.46.137.84]:44848 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgLIKsS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 05:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=POhaeBjFZYYRMbt13ALm3U5H/6p3EB8FL1+AcIyqjsI=; b=j2Hd4GqSWGJqr19TLTu5G/Xoqb
        E9vN8ZzQQdBxAw3reOedon6HV8Rwj//RwqVIwNVg4sGhlAK8DgYwbiVi9ilul+X5TJUDcUhvgF+BQ
        O9SSYnY5TQb6a8A7c1aC2GEJDbmj2LgBtzfJ72X84NbuIRQWG3q6ETzV86xUtZ+no5HxesYRHfva1
        4+L42L05HFFW/tBQQcOiuMpbFjKJnnG4NQQQIYYFtTZ18oUIjNvaDzF11TRa0QU9uZWYfjNrzU0cV
        1rfpOcWFsZA/0YCKHq1nMcdb1DJ2kp6Pvyn0DIyAu4v9BMxe0tUpXUb1Ai5DgR53HwHilOq5gjTFT
        jJ6NuQYQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kmx0Q-00061H-T8; Wed, 09 Dec 2020 11:47:34 +0100
Received: from [62.216.202.54] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kmx0Q-000TJU-PA; Wed, 09 Dec 2020 11:47:34 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: ad5504: Fix setting power-down state
Date:   Wed,  9 Dec 2020 11:46:49 +0100
Message-Id: <20201209104649.5794-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26012/Tue Dec  8 15:38:50 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The power-down mask of the ad5504 is actually a power-up mask. Meaning if
a bit is set the corresponding channel is powered up and if it is not set
the channel is powered down.

The driver currently has this the wrong way around, resulting in the
channel being powered up when requested to be powered down and vice versa.

Fixes: 3bbbf150ffde ("staging:iio:dac:ad5504: Use strtobool for boolean values")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Stumbled upon this while looking at something else. It is untested, but I
think it should be right. Alex can you double check?
---
 drivers/iio/dac/ad5504.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 28921b62e642..e9297c25d4ef 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -187,9 +187,9 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
 		return ret;
 
 	if (pwr_down)
-		st->pwr_down_mask |= (1 << chan->channel);
-	else
 		st->pwr_down_mask &= ~(1 << chan->channel);
+	else
+		st->pwr_down_mask |= (1 << chan->channel);
 
 	ret = ad5504_spi_write(st, AD5504_ADDR_CTRL,
 				AD5504_DAC_PWRDWN_MODE(st->pwr_down_mode) |
-- 
2.20.1

