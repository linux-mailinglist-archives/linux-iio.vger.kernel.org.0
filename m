Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A271936FD80
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhD3PRE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 11:17:04 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:55714 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230104AbhD3PQz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Apr 2021 11:16:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 0113C4148E;
        Fri, 30 Apr 2021 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1619795764; x=1621610165; bh=xN26c+iDe10Fz8GFaWlgjIyKKxDcZvKGebP
        GdZ88n4k=; b=ACM+vfmw3TFb4/7JcK9Pg2i9nEAJDOa4Nk4+gcYPQEbnGHFiRyb
        pupLAhrwtPRCpmdLfY4CgzqHO2Wo/fP/PwgyL4FlGwOWmdHfsCOYrBjniVKgOF5W
        QqiK1yi1jnVBxTXgYC9r4zUclg49iQBFxMmqQiXdPGjvemQynp0TScbc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2GETdw06S2N2; Fri, 30 Apr 2021 18:16:04 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D7D1841490;
        Fri, 30 Apr 2021 18:16:03 +0300 (MSK)
Received: from localhost.yadro.com (10.199.0.97) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 30
 Apr 2021 18:16:03 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH 2/4] iio: proximity: vcnl3020: add threshold options
Date:   Fri, 30 Apr 2021 18:24:17 +0300
Message-ID: <20210430152419.261757-3-i.mikhaylov@yadro.com>
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

Add the low/high threshold options.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/iio/proximity/vcnl3020.c | 94 ++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 25c6bdba3ede..0dfa6a0b5eec 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -254,6 +254,90 @@ static bool vcnl3020_is_thr_enabled(struct vcnl3020_data *data)
 	return !!(icr & VCNL_ICR_THRES_EN);
 }
 
+static int vcnl3020_read_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	int rc;
+	struct vcnl3020_data *data = iio_priv(indio_dev);
+	__be16 res;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			rc = regmap_bulk_read(data->regmap, VCNL_PS_HI_THR_HI,
+					      &res, 2);
+			*val = be16_to_cpu(res);
+			if (rc < 0)
+				return rc;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			rc = regmap_bulk_read(data->regmap, VCNL_PS_LO_THR_HI,
+					      &res, 2);
+			*val = be16_to_cpu(res);
+			if (rc < 0)
+				return rc;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl3020_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	int rc;
+	__be16 buf;
+	struct vcnl3020_data *data = iio_priv(indio_dev);
+
+	rc = iio_device_claim_direct_mode(indio_dev);
+	if (rc)
+		return rc;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			/* 16 bit word/ low * high */
+			buf = cpu_to_be16(val);
+			rc = regmap_bulk_write(data->regmap, VCNL_PS_HI_THR_HI,
+					       &buf, 2);
+			if (rc < 0)
+				goto end;
+			rc = IIO_VAL_INT;
+			goto end;
+		case IIO_EV_DIR_FALLING:
+			buf = cpu_to_be16(val);
+			rc = regmap_bulk_write(data->regmap, VCNL_PS_LO_THR_HI,
+					       &buf, 2);
+			if (rc < 0)
+				goto end;
+			rc = IIO_VAL_INT;
+			goto end;
+		default:
+			rc = -EINVAL;
+			goto end;
+		}
+	default:
+		rc = -EINVAL;
+		goto end;
+	}
+end:
+	iio_device_release_direct_mode(indio_dev);
+	return rc;
+}
+
 static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool state)
 {
 	struct vcnl3020_data *data = iio_priv(indio_dev);
@@ -334,6 +418,14 @@ static int vcnl3020_read_event_config(struct iio_dev *indio_dev,
 
 static const struct iio_event_spec vcnl3020_event_spec[] = {
 	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
@@ -423,6 +515,8 @@ static const struct iio_info vcnl3020_info = {
 	.read_raw = vcnl3020_read_raw,
 	.write_raw = vcnl3020_write_raw,
 	.read_avail = vcnl3020_read_avail,
+	.read_event_value = vcnl3020_read_event,
+	.write_event_value = vcnl3020_write_event,
 	.read_event_config = vcnl3020_read_event_config,
 	.write_event_config = vcnl3020_write_event_config,
 };
-- 
2.26.3

