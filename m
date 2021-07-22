Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EBC3D26BB
	for <lists+linux-iio@lfdr.de>; Thu, 22 Jul 2021 17:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhGVOyK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Jul 2021 10:54:10 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51608 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232702AbhGVOyI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Jul 2021 10:54:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 55AE449E60;
        Thu, 22 Jul 2021 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1626968081; x=1628782482; bh=L5nd/8rhafdGKRZUdWJQZk7JFquxlLTs0Ub
        dn3fx5CA=; b=ULnx/J0uUL0NXE3QOaUoO/XPKh6b3K9cQXrfEg3IAwMrlErr5bz
        ZPAkMUzTUdNMojPoMfbH1kXpAspszieGhMgskz+qlJk+8RmjQjvkt0eVhHjqlKqC
        IVnIvykBc/6uwG+JwV70mefNJf/jc8LF+BOmAxwTVQ1m7oLyFZjQ4nls=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IY2XXrZfXoRz; Thu, 22 Jul 2021 18:34:41 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2092949E69;
        Thu, 22 Jul 2021 18:34:39 +0300 (MSK)
Received: from fedora.bbmc.yadro.com (10.199.0.147) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 22 Jul 2021 18:34:36 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v5 3/3] iio: proximity: vcnl3020: remove iio_claim/release_direct
Date:   Thu, 22 Jul 2021 18:44:20 +0300
Message-ID: <20210722154420.915082-4-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722154420.915082-1-i.mikhaylov@yadro.com>
References: <20210722154420.915082-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.147]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove iio_claim/release and change it on mutex accordingly in
vcnl3020_write_proxy_samp_freq.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/iio/proximity/vcnl3020.c | 33 ++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 6d724657677a..6a3b59e1a6f6 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -236,10 +236,15 @@ static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
 {
 	unsigned int i;
 	int index = -1;
+	int rc;
+
+	mutex_lock(&data->lock);
 
 	/* Protect against event capture. */
-	if (vcnl3020_is_in_periodic_mode(data))
-		return -EBUSY;
+	if (vcnl3020_is_in_periodic_mode(data)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(vcnl3020_prox_sampling_frequency); i++) {
 		if (val == vcnl3020_prox_sampling_frequency[i][0] &&
@@ -249,10 +254,20 @@ static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
 		}
 	}
 
-	if (index < 0)
-		return -EINVAL;
+	if (index < 0) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
 
-	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
+	rc = regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
+	if (rc)
+		dev_err(data->dev,
+			"Error (%d) writing proximity rate register\n", rc);
+
+err_unlock:
+	mutex_unlock(&data->lock);
+
+	return rc;
 }
 
 static bool vcnl3020_is_thr_enabled(struct vcnl3020_data *data)
@@ -513,17 +528,11 @@ static int vcnl3020_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
 {
-	int rc;
 	struct vcnl3020_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		rc = iio_device_claim_direct_mode(indio_dev);
-		if (rc)
-			return rc;
-		rc = vcnl3020_write_proxy_samp_freq(data, val, val2);
-		iio_device_release_direct_mode(indio_dev);
-		return rc;
+		return vcnl3020_write_proxy_samp_freq(data, val, val2);
 	default:
 		return -EINVAL;
 	}
-- 
2.31.1

