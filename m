Return-Path: <linux-iio+bounces-19754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A59ABE790
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63458188B990
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A6262FF4;
	Tue, 20 May 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvNCyWVJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F5256C79;
	Tue, 20 May 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781447; cv=none; b=DEXeQKdoK40yJokT6Kj9F0GllWR2l9GBXVqn+T87mjsA61OVueyYc0OX5XroA+Z03+gxDDaZso31rY4EVFx2mL2TnG1guAEg716IWaQ+nktTjvBx2J4AGxVZcudlxEe7wqi49nPjw5sBWXwwHq+sau7AtYgkJeenHnKVc4mL4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781447; c=relaxed/simple;
	bh=GK00tmZ0RLTEZDNa3+vkOQ4lBezv7Q32YdYUdj4Sdes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGLihmkDsbvkm5pP+afzil6ceqm5/5NPLVyIXTTW0lpzIVCN7KVmsz97z6R/62J0TRpH1SxECzZRVqwmQQr5J9cg/63bAjqeNWgxHhh8bvoAgsq1D5z/gvNfNvqWLKjjApVK31KAe9u9hARcD0QeSdnE2/IpDM0WMGTV0S+lbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvNCyWVJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a36561d25cso529867f8f.1;
        Tue, 20 May 2025 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781442; x=1748386242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+MANsiHnSHiVQerhCOMECUBIXdf0JQ30WJqLPQ657c=;
        b=OvNCyWVJjUHcwWGv8rCVW3vHlkpeAycVjkIRZ+RymoaHP5KIY6nPdHjkgZpSoQmjXV
         QQjvPhmBq14MT4Ug0zf+XnH5/Wm4MrBHN9sL9NY24eVQ0wq8IxqcheHH0N7nKkEOU+V9
         lMkVw0agE+4SazaAZJM8zH+z6m7y215it4bZThnInh1tjxx0biUCR85KMUc0Ii0/6dQN
         v8y/U/d+hJk3GoKI/82dsrua6MXHD3rEvBjkszgf9Cd/pwwbnSMRhPTSdSkzCVxBASnB
         gcEvxGLqKXDjON92UPFp+4YKZD/rW/U4ApxdoVwcijGhiTxD8LibF283h2S+TiDEAg+t
         mIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781442; x=1748386242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+MANsiHnSHiVQerhCOMECUBIXdf0JQ30WJqLPQ657c=;
        b=M6PJUK7iZdpsFL9ipzwK8QVPZZCzofK8OEomLJPJ22DNxYuBUcMctfbcGRJCMb+2Uh
         bU8OIAAodDJGQTBdq0XCo4/2RXqeAyYhh+ZBDaVrxZ0Cyb2rtbm1ckVREzjYx4VVuYQt
         er6W7RFnt6V+p1QlF+Mta5kTis77PkmprzP84tGTttEvLXUeRVIRMLY4Qw/5jP3m+UVX
         +B9skaDwW4zU0tsjt62/L3hoir0020Wij46WEXsH6z/yasrxznauglOAfKPRzJQvK91h
         h6HL8i07QooKz+NrSvuHdGoCWVBsWH1A0nodfVYBJ0ixSpsylnaPGF9inQqrFLIaMaye
         LLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeB/pO3ViaY8O2oNESzgSKfnQiG8dutDheJuIIRfBfXdZFFTvDf8m9h0ZYAYCISNk7GkB/iV0NrEU+uQcw@vger.kernel.org, AJvYcCWhiAUD6ID8M2eND9+gelabczEQeG4LUbjPkzRJ0emJktnWYVKgyvjXVFtSZ0UIHosO66IxgEAisxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL5bCYBKn4ke7hUnX+3kg64e4Wq+JEfSTQCpO2DEuw26FZK0Ie
	K3q6zvBd6LAgM8OETJbNFrwSeAWivBHS+y/qNAbiEkPMyBp96ZPtcyqK
X-Gm-Gg: ASbGnctytcHYrFB+5VED07+Y6BUQQTxK8UflkHSDTpGPU7VQAxMLuhTXAhroaE7lqa6
	VfqTUb6Xu+tYB538SvPnLBWk8pYvIe48CXyBfUBgfxt7V2eOA5/elCrgbLiNb1z8IwNWaVDNAC1
	9LJviQbIM+2SG2dke8hnu8F7k+0rtCUcxADUPliFVGtCreUydq+qxENyoQzdQBYl4dDLu/RSaCe
	6C5gKj5CJEsqkWXkV5GmFZopGx66xiRyVh8djP+sOHhTTT2ScZLDYkVyBccLD4NYNuGjUX5eUjo
	XyHm/f/gJdkVshUFBClon0munVC4w1tis9vGa4yNsR8XjxQ63Jl1ZcGCgWWp3nUfopHDb/41lQr
	A7W60y07QK/n9zyOAHAQwrQ==
X-Google-Smtp-Source: AGHT+IFW7DtPe29YBBVQxJSDUvqF4uYWA0wMSPBZtw9KuoWXhr490x1c2CRsUrX4bweVuE+BgdCa0w==
X-Received: by 2002:a05:600c:198d:b0:439:9a40:aa27 with SMTP id 5b1f17b1804b1-442fd66dea4mr69123095e9.5.1747781442257;
        Tue, 20 May 2025 15:50:42 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:41 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] iio: accel: adxl313: add function to enable measurement
Date: Tue, 20 May 2025 22:50:00 +0000
Message-Id: <20250520225007.10990-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to enable measurement. The data-sheet recomments turning of
measurement while modifying certain config registers. This is a preparatory
step.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 ++-
 drivers/iio/accel/adxl313_core.c | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index fc937bdf83b6..ba5b5d53a0ea 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -36,8 +36,9 @@
 #define ADXL313_RATE_MSK		GENMASK(3, 0)
 #define ADXL313_RATE_BASE		6
 
-#define ADXL313_POWER_CTL_MSK		GENMASK(3, 2)
+#define ADXL313_POWER_CTL_MSK		BIT(3)
 #define ADXL313_MEASUREMENT_MODE	BIT(3)
+#define ADXL313_MEASUREMENT_STANDBY	0x00
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
 #define ADXL313_RANGE_MAX		3
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 0c893c286017..6c9d99650fc2 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -63,6 +63,14 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
 
+static int adxl313_set_measure_en(struct adxl313_data *data, bool en)
+{
+	unsigned int val = en ? ADXL313_MEASUREMENT_MODE : ADXL313_MEASUREMENT_STANDBY;
+
+	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_MSK, val);
+}
+
 static int adxl312_check_id(struct device *dev,
 			    struct adxl313_data *data)
 {
@@ -410,9 +418,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 	}
 
 	/* Enables measurement mode */
-	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
-				  ADXL313_POWER_CTL_MSK,
-				  ADXL313_MEASUREMENT_MODE);
+	return adxl313_set_measure_en(data, true);
 }
 
 /**
-- 
2.39.5


