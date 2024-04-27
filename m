Return-Path: <linux-iio+bounces-4561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130418B4653
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 14:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CE91F2453B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA64A4D9F5;
	Sat, 27 Apr 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="iv5kZcDc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DF40858
	for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714219884; cv=none; b=MUnZuD4gwehmptbDDgTRiawCP2OOKj5NVINDJ7/+xbeDJFugLhzF4NU9w/uxGXHDNvCellb7YQ+PkksGNAwud9+rhq+6JR9G3CCySbiDtebFrTHS91k0G5DxhGH/26TLbLsDBiSBdqQuf5aw8WrBtDr3L+T3JF3aNmBog2h70Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714219884; c=relaxed/simple;
	bh=z8wSUqIt4j0YXDYe0YyHA8y6o2pwo2p4olscic+kpd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ee7OJCeXIZgG8le2Bry35Rr5yrt3l0ruo0GQ3pi7P2F6zy3ScBhExwAT+GC0XmokFOpYXueG6eCUWwYaHZX0TyiBeas7PUFMg6nYwTZMztz5gwMcEzBWxVFRUCzyfkps0HNrYdQLxTLJcAdiM5ks5qjybVZStJJZdPwli10ABH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=iv5kZcDc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed112c64beso2930361b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714219879; x=1714824679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEg/vZ651UmK8myJ1duJUtvUGHo3a+rTOk+o6xyb9DI=;
        b=iv5kZcDc+BH6AQpmV2l3TONY4wMRE+OnSnUj5hOqfwXMmrkEyy1H5MYHWv0HCYg4WP
         wrAKypbjt4kMgGJos0QPDpHhbI1uzoeA5uNPYiSDw16hL7p4J3bX7G6a/zEdRZkvgYIf
         UJwGMgzRQisKRH8NgfJyXIRLF6oQaEJXc1bnBSVcNlkt5J66oegmROOugkNz+DFItzd/
         BCuLafn1i+bcFfghMevT865R7U1HS2ZrXGwX4+Kp2qp5Ac2mN87K6v0zFBWP8aBxQ1K4
         TbGV/KvgDNsWzmWUvVNNxeewsx41/SvbXP4avEtHj9EI5ycwG+GK0vhZYjVKiAbig5F1
         hamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714219879; x=1714824679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEg/vZ651UmK8myJ1duJUtvUGHo3a+rTOk+o6xyb9DI=;
        b=aWWxg99FGgzxYAWfwB+hNeuaNNI2zyBB0hvnahGc1EDwkJ/T6vDuEkjczGO5Yp9zBR
         gwQ6cGbL4G9KhjHUcZfSLTJHKT7S1siezYooAl1N5zkBjozfpLORgNq9L4NjNAxluzpv
         W0u3R/JvzAc/GAUyNhH3+W9U93Nx8QpYuFDzyMRNke7en8r2vz04PPH6aXiozCQsKegR
         2IP1UyUhemq8KxbD/poUREDgfm4s8UZDUBMWddeXYVwQSYwHLDoQZdx0+e3wFb9JNapX
         tAhSRPY4rEgappPubMS60yw4PTsQMO5cwQkVtgZvmpWFbWdrB0WGKPVBCsaOI7uzmVjo
         r+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWtQZErVCZeGy4aAnh4xltQF1ZZB0uMLGpNvnpoTVDk+rbyBCqGmWbA43iojggemPYyA9Ls/k73lIJAlVprHx0ONwjuMROoprOB
X-Gm-Message-State: AOJu0YywrSDmKC36GjYYF7fyCYQ03I2paI1DslFufPtNMacZJyh2GqGS
	py9l2UR15cw5WmCLvfRP5ngxF4iHwHADPUuJnieOYsjH65fNop8KcUQHiXda/fs=
X-Google-Smtp-Source: AGHT+IHMXLlWnkifSntuavOoiurrf6kXF1w2B7kONKvyhyA15oKOqk04ZKO0UBM2lYlBK74Q+H7fJg==
X-Received: by 2002:a05:6a00:9283:b0:6ea:f392:bce9 with SMTP id jw3-20020a056a00928300b006eaf392bce9mr2524259pfb.15.1714219879669;
        Sat, 27 Apr 2024 05:11:19 -0700 (PDT)
Received: from lincolnyuji-vaio.. ([201.83.91.252])
        by smtp.gmail.com with ESMTPSA id c6-20020a633506000000b005f034b4d123sm14034856pga.24.2024.04.27.05.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 05:11:19 -0700 (PDT)
From: Lincoln Yuji <lincolnyuji@usp.br>
To: jic23@kernel.org
Cc: Luiza Soezima <lbrsoezima@usp.br>,
	Sabrina Araujo <sabrinaaraujo@usp.br>,
	Lincoln Yuji <lincolnyuji@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads1015: use device_for_each_child_node_scoped()
Date: Sat, 27 Apr 2024 09:10:55 -0300
Message-Id: <20240427121055.5639-1-lincolnyuji@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This loop definition removes the need for manual releasing of the
fwnode_handle in early exit paths (here an error path) allow
simplification of the code and reducing the chance of future
modifications not releasing fwnode_handle correctly.

Co-developed-by: Luiza Soezima <lbrsoezima@usp.br>
Signed-off-by: Luiza Soezima <lbrsoezima@usp.br>
Co-developed-by: Sabrina Araujo <sabrinaaraujo@usp.br>
Signed-off-by: Sabrina Araujo <sabrinaaraujo@usp.br>
Signed-off-by: Lincoln Yuji <lincolnyuji@usp.br>
---
 drivers/iio/adc/ti-ads1015.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 6ae967e4d..d3363d02f 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -902,10 +902,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
 	struct device *dev = &client->dev;
-	struct fwnode_handle *node;
 	int i = -1;
 
-	device_for_each_child_node(dev, node) {
+	device_for_each_child_node_scoped(dev, node) {
 		u32 pval;
 		unsigned int channel;
 		unsigned int pga = ADS1015_DEFAULT_PGA;
@@ -927,7 +926,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			pga = pval;
 			if (pga > 5) {
 				dev_err(dev, "invalid gain on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
@@ -936,7 +934,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			data_rate = pval;
 			if (data_rate > 7) {
 				dev_err(dev, "invalid data_rate on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
-- 
2.34.1


