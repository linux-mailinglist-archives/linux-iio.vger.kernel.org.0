Return-Path: <linux-iio+bounces-9777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E2C986503
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 18:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7A7287FD4
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100FE13A86A;
	Wed, 25 Sep 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+2C8YK/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716ED1369AA;
	Wed, 25 Sep 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282461; cv=none; b=nY7RLdzf3z6IFc3wxvoVRm9y+B2j1DDYrc2wkfCwFZSZQzMhZeHOizpnczMyqrPZ/GpecLyLDUjR6gw9Ci4OtIC0CXvYD9ASupEmUcH2iKIYbp5nfpDKuYvt857mhrVls6dBgL/GH8y2t+Ac1sqyAOFHo929I+qCLIoULNibu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282461; c=relaxed/simple;
	bh=QwT382XJp5Tzqa6WmNu93tC/AnVS0dpTOdCs0F1jxuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrcYA23sJFjnCmpCbhaeX4TcfBPgTmGehf67q3LTN2EJq15zN4Dq9Ph9KwmDPKX9T3PRuro+OuaLgg2bbq4Oh3U0W5nvbxJY4d6Ac9wjAxxxCo/Br89JE7hxy20Y5padj6pCJ8NtK/oZiCzUQUufQ6QGSfnQcqYSNoCutk5dpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+2C8YK/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d883286bd2so11137a91.2;
        Wed, 25 Sep 2024 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727282460; x=1727887260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDigrLr6aoyngHks4RSZ4J49MFGrODyXNvpYR5mceLA=;
        b=V+2C8YK/Ebu2jgOC2gd9INSh1nCIkTzV/69X5sRcJPpWdsyRJkGtWc/C6HWcnulOsP
         yiZwST0/ntu9A9e1zflhFaXmGg7k5Ygri9YmEN3M8ZKA9LQ5NNno5SutvGAuGj/cuiGn
         HoGRK8iGiMUDtuJe+/N9iwtssjdqkAW0g9hPbqOnxAfBy7YX75EEkdK7LxAC4miI4Vfg
         t2mLI04gBJ8Li73BXLn4Zjd1DTuJJ8qEg87RcwYxZp+3zW9n6UYiPis3BKpClSI54ZaN
         eQbhLKWL8XDbUOUSqUhYVtcTdDtS97sZeYkpaTFTEm1w7089oyqD8nteaGs/CyLVGDbG
         u3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282460; x=1727887260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDigrLr6aoyngHks4RSZ4J49MFGrODyXNvpYR5mceLA=;
        b=cE7FvwqEWHadCdKlw45V50PDEozZxNGt2zmD0n3w8sdRMl7gk53e74fJhtu+y+95Hw
         52kBG7L/Ve+GcPM5pLOzCRa5f+TQ/PBdIm+mODaOm5RypFpD+D5lIcNGykDPCLCCk2hq
         cgUzOj0nkcWDmXue9JcxygBd2luGgSjWEV7v9p2gyklRELx3Xaf+WMqOXzvhpDOGNp2e
         ym0mqOJGsINq72/kBQsHGTV/LpngY4MQefoldjiqsjGDUwkK/2cHa8KbeDpkQNDDEHwG
         Y+X/cafSdcdOspSYFrUrXE2fzkerNEIP8dv5eaUwM3gK4tE6LBfqaZamPMl3p34869pc
         BtRA==
X-Forwarded-Encrypted: i=1; AJvYcCWF/OfzRs9qQ0RYcVNbmTK8S+sZ4roDwqjqgRojzFYkrSQ6YB5zaQgGE6d29yI6JzDtXJDPNbkk+DCt4G/U@vger.kernel.org, AJvYcCXhfOZlLcC7XaoAQ84UjcCDvQeGslZiyRoVuaEO9I6Uo1WTs3XL8qgYRGe1x7QIYbAJR5NTT/Hq/HSg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CM36L1dfkTyhYKaU8Mu8/IcskFX0FuzKmJ/FlcZizBXEB6de
	KgetqWSG+qCG/CXr0rHJJLDXbeRZoBixwp0ePAHkwOu9eZpl+w20
X-Google-Smtp-Source: AGHT+IEfoZmn9R2MhbCCmjrcm6Js2E2/bRhSh0jYr3xAVIBmSG8TxrqLg2vFGrskBTvf1CxEkYlQVg==
X-Received: by 2002:a17:90b:1281:b0:2e0:7e80:2018 with SMTP id 98e67ed59e1d1-2e09253dcdfmr160a91.0.1727282459781;
        Wed, 25 Sep 2024 09:40:59 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2bbecasm1726346a91.46.2024.09.25.09.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:40:59 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Thu, 26 Sep 2024 00:40:18 +0800
Subject: [PATCH v2 2/2] iio: proximity: hx9023s: Add performance tuning
 function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-add-performance-tuning-configuration-v2-2-fdbb654f5767@gmail.com>
References: <20240926-add-performance-tuning-configuration-v2-0-fdbb654f5767@gmail.com>
In-Reply-To: <20240926-add-performance-tuning-configuration-v2-0-fdbb654f5767@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=QwT382XJp5Tzqa6WmNu93tC/AnVS0dpTOdCs0F1jxuo=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDGlfbPnuivxJCd0itfB913fl6czb1r49Je/sFrr4oUXr4
 003951Q7ShlYRDkYJAVU2Q58/oNa77qwz3Bv10zYOawMoEMYeDiFICJGLkxMszx2ax6OOPrpLvP
 7FwzLjW7TQj6H6709W+lT/XXq3FRG8MZ/od+nLu6mn1hM+uvNiOTVM/IS4/slvrOdrR6dUPy+Jp
 pM/YBAA==
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

When hardware design introduces significant sensor data noise,
performance can be improved by adjusting register settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 8b9f84400e00..8f7995816545 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -582,6 +582,47 @@ static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
 	return regmap_write(data->regmap, HX9023S_CH_NUM_CFG, data->ch_en_stat);
 }
 
+static int hx9023s_performance_tuning(struct hx9023s_data *data)
+{
+	int ret;
+	u32 i, len;
+	u8 addr_val[512];
+	struct device *dev = regmap_get_device(data->regmap);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+
+	ret = fwnode_property_count_u8(fwnode, "tyhx,performance-tuning");
+	if (ret < 2 || ret > 512) {
+		if (ret < 0) {
+			dev_err(dev, "Failed to get length of property\n");
+			return ret;
+		}
+		dev_err(dev, "The property requires between 2 and 512 elements\n");
+		return -EINVAL;
+	}
+
+	len = ret;
+	if (len % 2 != 0) {
+		dev_err(dev, "The property must contain an even number of elements\n");
+		return -EINVAL;
+	}
+
+	ret = fwnode_property_read_u8_array(fwnode, "tyhx,performance-tuning", addr_val, len);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read property\n");
+		return ret;
+	}
+
+	for (i = 0; i < len; i += 2) {
+		ret = regmap_write(data->regmap, addr_val[i], addr_val[i + 1]);
+		if (ret) {
+			dev_err(dev, "Failed to write register\n");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static int hx9023s_property_get(struct hx9023s_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -1045,6 +1086,10 @@ static int hx9023s_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "channel config failed\n");
 
+	ret = hx9023s_performance_tuning(data);
+	if (ret)
+		dev_warn(dev, "performance tuning not configured\n");
+
 	ret = regcache_sync(data->regmap);
 	if (ret)
 		return dev_err_probe(dev, ret, "regcache sync failed\n");

-- 
2.43.0


