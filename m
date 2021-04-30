Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF97D36FD83
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhD3PRF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 11:17:05 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:55726 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230126AbhD3PQz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Apr 2021 11:16:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 399F341490;
        Fri, 30 Apr 2021 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1619795765; x=1621610166; bh=EiJDFbi7rgHkUXnCqteaHRXKMiFzNTVs0C2
        mRVFQwjs=; b=NKAVueKy2BQyVhXnc/pwHOsDl1qkpFspHnzdFBqEthp23lWTb3X
        17MPuKfQyZNMwbm1wyr8/YLmGOjs5Sty9Zt5FuiNZvkcpAlSl8HBuiEHViIr3eIr
        EcNrThB1oMkG6SAzf9YvJB2wcsabMOS9pBjfU4zYExLt88wOiRl3ObdQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AKcO8JmtRDen; Fri, 30 Apr 2021 18:16:05 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 5009341499;
        Fri, 30 Apr 2021 18:16:04 +0300 (MSK)
Received: from localhost.yadro.com (10.199.0.97) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 30
 Apr 2021 18:16:04 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH 3/4] iio: proximity: vncl3020: remove mutex from vcnl3020_data
Date:   Fri, 30 Apr 2021 18:24:18 +0300
Message-ID: <20210430152419.261757-4-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430152419.261757-1-i.mikhaylov@yadro.com>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.97]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove the mutex from vcnl3020_data structure and change it on
iio_device_claim_direct_mode/iio_device_release_direct_mode.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/iio/proximity/vcnl3020.c | 40 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 0dfa6a0b5eec..bff59c7af966 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -71,13 +71,11 @@ static const int vcnl3020_prox_sampling_frequency[][2] = {
  * @regmap:	device register map.
  * @dev:	vcnl3020 device.
  * @rev:	revision id.
- * @lock:	lock for protecting access to device hardware registers.
  */
 struct vcnl3020_data {
 	struct regmap *regmap;
 	struct device *dev;
 	u8 rev;
-	struct mutex lock;
 };
 
 /**
@@ -149,7 +147,6 @@ static int vcnl3020_init(struct vcnl3020_data *data)
 	}
 
 	data->rev = reg;
-	mutex_init(&data->lock);
 
 	return vcnl3020_get_and_apply_property(data,
 					       vcnl3020_led_current_property);
@@ -161,11 +158,9 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
 	unsigned int reg;
 	__be16 res;
 
-	mutex_lock(&data->lock);
-
 	rc = regmap_write(data->regmap, VCNL_COMMAND, VCNL_PS_OD);
 	if (rc)
-		goto err_unlock;
+		return rc;
 
 	/* wait for data to become ready */
 	rc = regmap_read_poll_timeout(data->regmap, VCNL_COMMAND, reg,
@@ -174,20 +169,17 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
 	if (rc) {
 		dev_err(data->dev,
 			"Error (%d) reading vcnl3020 command register\n", rc);
-		goto err_unlock;
+		return rc;
 	}
 
 	/* high & low result bytes read */
 	rc = regmap_bulk_read(data->regmap, VCNL_PS_RESULT_HI, &res,
 			      sizeof(res));
 	if (rc)
-		goto err_unlock;
+		return rc;
 
 	*val = be16_to_cpu(res);
 
-err_unlock:
-	mutex_unlock(&data->lock);
-
 	return rc;
 }
 
@@ -450,25 +442,37 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
 	int rc;
 	struct vcnl3020_data *data = iio_priv(indio_dev);
 
+	rc = iio_device_claim_direct_mode(indio_dev);
+	if (rc)
+		return rc;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 
 		/* Protect against event capture. */
-		if (vcnl3020_is_in_periodic_mode(data))
-			return -EBUSY;
+		if (vcnl3020_is_in_periodic_mode(data)) {
+			rc = -EBUSY;
+			goto end;
+		}
 
 		rc = vcnl3020_measure_proximity(data, val);
 		if (rc)
-			return rc;
-		return IIO_VAL_INT;
+			goto end;
+		rc = IIO_VAL_INT;
+		goto end;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		rc = vcnl3020_read_proxy_samp_freq(data, val, val2);
 		if (rc < 0)
-			return rc;
-		return IIO_VAL_INT_PLUS_MICRO;
+			goto end;
+		rc = IIO_VAL_INT_PLUS_MICRO;
+		goto end;
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
 	}
+
+end:
+	iio_device_release_direct_mode(indio_dev);
+	return rc;
 }
 
 static int vcnl3020_write_raw(struct iio_dev *indio_dev,
-- 
2.26.3

