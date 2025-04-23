Return-Path: <linux-iio+bounces-18576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D516A9982C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 20:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725744A0AF2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70776285414;
	Wed, 23 Apr 2025 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD8VgI83"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC628EA70
	for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434340; cv=none; b=iDyUlKX4RbyA6EWBrFpha4jiTLB7Z5a8kCeOTiSMYqdXB8OLu/AdWWD2gUrN4ohamnLO4iO59rQHbzVxVKpTH4sD5ayz4B9qWTjabjBRi+fptPWAG0JQ//52SpUHwz4Z+mRbW9gteVGr/8TZ9uKhL/MxlgRstx18qbMRoLKm6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434340; c=relaxed/simple;
	bh=KPb1C0FYRfh8w2ZmC2ZdiDCygj2QuqTN0lRPF/UOVSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUYa2uXDCU0lVUdBd/Lt23C43yUJsEHtEDPr9fvVkBkmSVQ8cbu+xph+CKvUjEpu+c/frktws0uEp4K+rupQuLyl7HCRbqzSE81UfVxvvoXzl/awR68CGdRJwieXJKw1M5GdVIKnbCsWZ+bLcM2Qk9bQUW4eQRXCgIwfPYXWakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD8VgI83; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73b71a9a991so20626b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745434337; x=1746039137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch/1MRLfQriOdDYlAkarxaG2Gtc3g7Oqje2TrfBUeu8=;
        b=VD8VgI83iOml+/FS/+1IvhVUGbHi2t6Dr6vQdC9nCjDIPiXZCjk3DLbsgHhEzC0v4j
         j5yfpiTL3bXecPJ8enHCstD8WxXo1YB627b4zgdltsPYRLhml9Klwb/TbrsTRZZ04BDN
         eMOEYNj3mNAYI/h620g+ZgDwdT7lvJYoPTuCe0k34WJHOV3Rji2dp+q6IOP40AeE82+C
         63FsAE4cX7SG43CYmJ3+oL0+s/A9rgW3sV8AO5hCvBEtk7JCTCZA0YOx/NGZuWzp4yY4
         tiWeuuimjlfTQgczN1Ol4OZMKty3aLvIbMa/QL6peghv2VvuoEbeggYuFZwRActDjJD+
         R4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745434337; x=1746039137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch/1MRLfQriOdDYlAkarxaG2Gtc3g7Oqje2TrfBUeu8=;
        b=iBBJCmuCeEhPVWacrKLpN6r3c0o8uuoeGgLHeqY7rHCfmTwEHdUHgYcBcnhNV5MHju
         AWof3MGN16oupccVDD2apHl0oPQB/HDFr9xPPABHT46AXRKy/Y6pSaceClb+ZPduFPZ5
         CSCfLtNe9xMW4bWveHJ0ITXg9ZSXoK9dNj4REXlgDXGv7eX3/Pg/CGw/HgPFwOYZeoT5
         1Y4UT+116oPwO55DUYtz5zCK88SnUe50wtie2OUR7fPaQMWjlSNJldi24paAC+n6QO2a
         9rSd/kI4ED0zSSK8TCSzR4GEABI/og5Hl7WPJyMHPsacNqMZ1NvfDOdY0152GxpFoIaQ
         yRHg==
X-Gm-Message-State: AOJu0YzLepIeGaU8m4XJPEKZEnu8CRQFSXyqb0Aac70Xc9zquFHSnq5L
	Vgr1V0EH8FFcQvI24MEYCncfgkLrFw2F7tOY/uRf3H5tmcYrAzDV4rTF/BmwwAc=
X-Gm-Gg: ASbGnctWaAvLy0galBAnQgL9M15q/8La/0WViUwPAo0iRIVZegpUeE6Q2+XWx9Jqhs9
	1ULstvCee4FUwijExUJT3SKtWYTKVF9sqg/bsA7JkWDZBzSKud2523nWXpxkpgOm/jrycVfOBrf
	+qoh2CE5MV42gQKfD/Znfo3w7T5n//weSG1jpaNZK1VVIqS14/muMn21b7iYltQLB20gZ4yMZWd
	MxAMHIh6VdGHbIPFZW1bMey1B2a1eeNyFlfE3dCoRFGAAn+Gs/3XwXmFUBLCo9lm4A8KrpfoKsf
	bExiqRIy2zX140hhK+Su2PnMnT9g3sorjYws+i2SEHQ4H/1Ckdsk9t8zfcc=
X-Google-Smtp-Source: AGHT+IFtOIjbYfoNWNcHXZS+V/3g0MmJyh6h76lhkFb1WKs4d1w7VtiKpwFpEzRJPVSCGct+9Kf9Og==
X-Received: by 2002:a05:6a00:843:b0:730:915c:b70 with SMTP id d2e1a72fcca58-73e1153dd0amr1873293b3a.0.1745434336944;
        Wed, 23 Apr 2025 11:52:16 -0700 (PDT)
Received: from arthur.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa588d4sm11343294b3a.96.2025.04.23.11.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:52:16 -0700 (PDT)
From: Arthur-Prince <r2.arthur.prince@gmail.com>
To: linux-iio@vger.kernel.org,
	arthur.prince@ime.usp.br
Cc: =?UTF-8?q?Mariana=20Val=C3=A9rio?= <mariana.valerio2@hotmail.com>
Subject: [PATCH 1/2] iio: adc: ti-ads1298: Add safe usage guarantee for device communication
Date: Wed, 23 Apr 2025 15:46:25 -0300
Message-ID: <20250423185208.752080-2-r2.arthur.prince@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250423185208.752080-1-r2.arthur.prince@gmail.com>
References: <20250423185208.752080-1-r2.arthur.prince@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add safe usage guarantee for device communication in 
ads1298_reg_access/ ads1298_write_raw (ti-ads1298) that 
prevent simultaneous read/write operations.

Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
Co-developed-by: Mariana Valério <mariana.valerio2@hotmail.com>
Signed-off-by: Mariana Valério <mariana.valerio2@hotmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 03f762415fa5..438bcc3c74da 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -355,9 +355,19 @@ static int ads1298_write_raw(struct iio_dev *indio_dev,
 {
 	struct ads1298_private *priv = iio_priv(indio_dev);
 
+	int ret;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return ads1298_set_samp_freq(priv, val);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ads1298_set_samp_freq(priv, val);
+
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -417,10 +427,17 @@ static int ads1298_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 {
 	struct ads1298_private *priv = iio_priv(indio_dev);
 
+	int ret;
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 	if (readval)
-		return regmap_read(priv->regmap, reg, readval);
-
-	return regmap_write(priv->regmap, reg, writeval);
+		ret = regmap_read(priv->regmap, reg, readval);
+	else
+		ret = regmap_write(priv->regmap, reg, writeval);
+	
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
 }
 
 static void ads1298_rdata_unmark_busy(struct ads1298_private *priv)
-- 
2.45.2


