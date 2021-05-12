Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B585637D36D
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbhELSWE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350558AbhELRvT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:51:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C239C061344
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m12so36286477eja.2
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwgFY4dtpVnvZvR2NIXhU4/dNeZKtIuNiLjrbd0tG/g=;
        b=CfjtKtYnl6pLp9mE+U9cHQVW3tY+tJs7W1r4YQRDsDC/ZFQuoJ2l7PFDP0J34vlyGM
         mG45ua7MxBM6MQSx0C0C7mCPiq6QyGgrOTPiyNanSenMaENLSFNgOK0qZGUf50SgjWWh
         FsTfkaVfgwOf+vAAXmBwsIyjiJpAew2ZVSx4iiE8iQZ7poi2LPDP91Vtt0Dy2mAQRQhd
         RNcfZefx3tT9uwb/TucUu3ZWKHdG8+cfDVLAx6CwtFcuvWkGQKCJeNfkQd5gIjO6RU/L
         n+j1NqxU+FIiR1qWhzjuyvP3icspsfJ3F2rZws70XjqL25SGKaUnHf2fy1p39izGfj+t
         MfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwgFY4dtpVnvZvR2NIXhU4/dNeZKtIuNiLjrbd0tG/g=;
        b=LeC5zzOuwA5c33pzpa1i74ksRkc+Gv03jMALTsTxo/NP3egS2+XBETJ1bsaxnfh8BZ
         GTKFYtG7pIpf+ELbrIu/nBFAN5n9Nlc5JCu0o0RPk+TXoFY/v28eDxrbw9C11FLVHibX
         t7Z5EEpxU7uVDlNrdqvbza5LyXoGA1hx0kHx9RL+QCfmW3wzMRPqzEar0Xt0xia51dTO
         sLSdMLJ6zpP8vnWlJEY2tVa3aUsHwVCPWYztpj7qMykP55SIGbLiNE8VfOWl7NaS0gIp
         rzCWgTlYMsAOkBNnDeDP4SxQAXOEdo9LBehy3oUn9Ek0AhP/5fBDk8uOwEv/lkbWGs59
         UK2Q==
X-Gm-Message-State: AOAM531qJDv0Qzh37nyVmfQigGLOXIQOe41InSlnEXeaEkKkhtOJXQ4W
        f5LgATWsOQZXwivp0gyAl+g949jssa0How==
X-Google-Smtp-Source: ABdhPJw3LIhAhbs8K7dfFg2wviOdvE0mWStLp1zDjmP4Lex7PH9Q9OCjg/37Op3sB653ZSk0Wb8WjA==
X-Received: by 2002:a17:907:3e28:: with SMTP id hp40mr16146685ejc.523.1620841800033;
        Wed, 12 May 2021 10:50:00 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:49:59 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 04/12] iio: adc: ad7192: handle zero Avdd regulator value
Date:   Wed, 12 May 2021 20:49:06 +0300
Message-Id: <20210512174914.10549-5-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change fixes a corner-case, where for a zero regulator value, the
driver would exit early, initializing the driver only partially.
The driver would be in an unknown state.

If the regulator value is zero, then the internal reference will be zero
(though that value will be zero for anything less than 1 millivolt).

Fixes: ab0afa65bbc7 ("staging: iio: adc: ad7192: fail probe on get_voltage")
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d3be67aa0522..9da394ad3868 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -951,7 +951,7 @@ static int ad7192_probe(struct spi_device *spi)
 
 	voltage_uv = regulator_get_voltage(st->avdd);
 
-	if (voltage_uv > 0) {
+	if (voltage_uv >= 0) {
 		st->int_vref_mv = voltage_uv / 1000;
 	} else {
 		ret = voltage_uv;
-- 
2.31.1

