Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA8264610
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgIJMbN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 08:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgIJM1X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 08:27:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8966C061756;
        Thu, 10 Sep 2020 05:27:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so4513301pfp.11;
        Thu, 10 Sep 2020 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NG7rD1syICfupcmPdJmvgHTE4y0/rSK73sDdgxajwU=;
        b=B5+ESoK8bYrXvgx3dHxcsnIUuKwHmo7iP0GnnhuWXhHO+oGi7QOG6Gzvc/S1lyGmeL
         DOELZMXCR8VyF+mIOASF5yT/C/sCzgKGkt4s2fVLDKIZ0TG2ee2zFmT/p7dMwrsBY5F7
         vj0prJpvaH5LR3kJlajXeb8FIDVQ2ZB9eA1wqGvvDvL8upL9jxw0ltlsWOPUminvEwmP
         wmQYNyQRXc9N7xzwmx8Epz7x5A5ME+bJkUYmd7lQtHdKYtqDpR41mTsKEDA3IqwZ8kGG
         9qRLGPHwf3SpswbaoFfK2s/aMCnOn+6FtVvsC8Y2bTLADg8FRQiszk8tgxF1SGIwA1HW
         eCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NG7rD1syICfupcmPdJmvgHTE4y0/rSK73sDdgxajwU=;
        b=EsOscAEfvU9sYI8EmapsTWwxRhMuO+HV2GdlLt/3wpxY23cF9tqEhh5VFw9LmJjoE+
         mTkJdxd9OQBIMxfq9GQZ7vF7Ujn5kMFnvDsxwO6hwreINiIToKSiM19upkwiZhMDKQy7
         0Y67pFBuCCPlnBK2VVFn6yU8io7TA1NZ82O7EUodprnBrTXV/4ZmMWemQyW2DIxQ4pLc
         OOXgFJIS6w/dOMPSFRzVhWNuMoCTX1rYafWu/NGiHyFA94qmDXUfEQ4NH3ZDE8EtzTTL
         8S14WHiyXBezUCj0fOcZXa3oPWE4NLf31686UPmejEefQRXWhWK+uQr1GZUic6bP2LHU
         TwYg==
X-Gm-Message-State: AOAM531dE5D1ycYEMgn+NiiGYyOCZ3RVWlUKpCR5nbCBWi/CO1nWLI/K
        0w9w9fiGBwsJAl8CYWYQn4qRSc3QviU=
X-Google-Smtp-Source: ABdhPJzQycYAfd7DwXTyyhYFiu3ZXgujt6tDccJKfSYJJyQ3N1CQ2BEtP9Fn7pJYAc49eqXwgB3DWw==
X-Received: by 2002:a63:5ec5:: with SMTP id s188mr4339691pgb.218.1599740843198;
        Thu, 10 Sep 2020 05:27:23 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6218:54d7:9928:e984:12bb:783d])
        by smtp.gmail.com with ESMTPSA id b18sm5181687pgk.36.2020.09.10.05.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:27:22 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH] iio: gyro: adxrs290: use hook for devm resource unwinding
Date:   Thu, 10 Sep 2020 17:57:11 +0530
Message-Id: <20200910122711.16670-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of devm_add_action_or_reset() hook to switch device into STANDBY
mode during standard resource unwinding. The patch includes a helper
function, in the form of adxrs290_set_mode(), to realise driving the
device into STANDBY mode.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---
 drivers/iio/gyro/adxrs290.c | 61 +++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index ff989536d2fb..2864eb443957 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -192,15 +192,70 @@ static int adxrs290_set_filter_freq(struct iio_dev *indio_dev,
 	return adxrs290_spi_write_reg(st->spi, ADXRS290_REG_FILTER, val);
 }
 
+static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	if (st->mode == mode)
+		return 0;
+
+	mutex_lock(&st->lock);
+
+	ret = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
+	if (ret < 0)
+		goto out_unlock;
+
+	val = ret;
+
+	switch (mode) {
+	case ADXRS290_MODE_STANDBY:
+		val &= ~ADXRS290_MEASUREMENT;
+		break;
+	case ADXRS290_MODE_MEASUREMENT:
+		val |= ADXRS290_MEASUREMENT;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_POWER_CTL, val);
+	if (ret < 0) {
+		dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
+		goto out_unlock;
+	}
+
+	/* update cached mode */
+	st->mode = mode;
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static void adxrs290_chip_off_action(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	adxrs290_set_mode(indio_dev, ADXRS290_MODE_STANDBY);
+}
+
 static int adxrs290_initial_setup(struct iio_dev *indio_dev)
 {
 	struct adxrs290_state *st = iio_priv(indio_dev);
+	struct spi_device *spi = st->spi;
+	int ret;
+
+	ret = adxrs290_spi_write_reg(spi, ADXRS290_REG_POWER_CTL,
+				     ADXRS290_MEASUREMENT | ADXRS290_TSM);
+	if (ret < 0)
+		return ret;
 
 	st->mode = ADXRS290_MODE_MEASUREMENT;
 
-	return adxrs290_spi_write_reg(st->spi,
-				      ADXRS290_REG_POWER_CTL,
-				      ADXRS290_MEASUREMENT | ADXRS290_TSM);
+	return devm_add_action_or_reset(&spi->dev, adxrs290_chip_off_action,
+					indio_dev);
 }
 
 static int adxrs290_read_raw(struct iio_dev *indio_dev,
-- 
2.20.1

