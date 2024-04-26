Return-Path: <linux-iio+bounces-4530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC838B383C
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1001C224A8
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0BF145B21;
	Fri, 26 Apr 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="t+JexH6j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544C146D5A
	for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137631; cv=none; b=FQc0e7TPvAVr145GWFwOf5t7GGIkYWFe43E7DjXoACZCLQR6Qk/9Ih1yW8PXVd1Q5Jnp+2noeTZb+BD7I14VQ6u5S1tLTX3D/RfCnWwVHVHVCVc4gcm6UkPWr6dNoGxO4ChQF7eP18NBD5YmBDzt+W4xHTHkMulYiJWIty/mWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137631; c=relaxed/simple;
	bh=bBfcyWcsBaOXMy0YVS4JtZ7veyB/SGYu/6tkPP2ZLM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IapbzkLlkfJaMFVbvvvxzHeI5rsSeAoLLL6bGmjf34fx7Dmk7EW7/AGQNmtlLZACIXjQiURlVudv5enz38R7L1pVDmAHVUFYKDby8MxUvlUQqRsgZQkFsV/JaSEfbfwZMpArWtc77owhEjxEbrjr/2XP35Wj3CGsNZOf3OIEbOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=t+JexH6j; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f103b541aeso1847439b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714137629; x=1714742429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jrttU6FuayCATh91yMHJuQYMA6i1jbzl2pFuArxbtY=;
        b=t+JexH6jf70hl46XaV4i5J1Vy8sViMQtvGhS4nd5+52c2c3LsgsJZKMfDgODrYJqXU
         b62yqaDFoTb8JmcEkri4hwl/79LcTmqcd65FIvos9bRGQaRMhykT8/pOewaIYMkuRmHC
         3TmN4dnjpD8aa+LnbOtKPFEmAKHLbaRnwQXtHICz60j5D71XnSJ4sKI5D4/CUABCN1TH
         FS5x7/5v6PMUNLnZquzwIW3f9vXzli4pQQHkcUgINh9dcmjoUcWGA2rdGeqniOgQESq4
         t8v25F49sXue8HpjIYbM8PyBkmJ4yl5/Rxn+8mA4Cnaj6JGQy4GhhVJTVisNDCzFIafF
         vexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714137629; x=1714742429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jrttU6FuayCATh91yMHJuQYMA6i1jbzl2pFuArxbtY=;
        b=fLBN+38/k22yyQUzA6GCAOkV3hekAGvkpIPDXWtGswda29mRsZa2JDwXefhV8D325M
         dam7i8KzOXmdc2W//nzUxGgsY9n/wSaiZ2dpXzcF+nx6HK9RKshGNqFuTg5bO+N5iCyY
         fprvXTtQD1Z81mbQvxWbmHH/le2GIgAFBRxhs1zMCpveX1xeOQrJgkzGf3SgY4Oj7fqU
         gTQNl4UXnOjbwdhOmK/+aqjjcVxQlCEZwV0ZqH3Ap6/qvj91MGZU+gIYaTUIaQkWstkJ
         GsX60xZcF4TBh054+/VI1G7D3xVyv3npuhjpRr7eBf1gdcaWc+fETDTwZhg/taDVtsQz
         2uZA==
X-Forwarded-Encrypted: i=1; AJvYcCVMQGZvpgKeJkXg4TjhcUY/l3xwQxrtJrSg9pEgigNih6Xe5ifOtIc4BjugHkIkFMkcm3qrC8AaL2pvtHLlZR6UAYalxf4YNY81
X-Gm-Message-State: AOJu0Yxz2+HfXIgbCRv2HrRPKUZsmXsq2jiCMyxBQgAINgJEehVdMeGx
	dPJeOIQv+NW9asuuOGv24yvSbV+6w3w2/4wW9QxJwV/0b1kFXMJ6exFE8uz8Iz8=
X-Google-Smtp-Source: AGHT+IHvrUwpkD3798kAHknqtqRx+fCEbeJIevLQhDueyxEQmVnGfX19BNsubtfDPDEXsx30W0q5eg==
X-Received: by 2002:a05:6a21:191:b0:1ab:b369:7bd3 with SMTP id le17-20020a056a21019100b001abb3697bd3mr3666066pzb.38.1714137628706;
        Fri, 26 Apr 2024 06:20:28 -0700 (PDT)
Received: from lincolnyuji-vaio.. ([201.83.91.252])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006ed38291aebsm15328529pfl.178.2024.04.26.06.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:20:28 -0700 (PDT)
From: Lincoln Yuji <lincolnyuji@usp.br>
To: jic23@kernel.org
Cc: Lincoln Yuji <lincolnyuji@hotmail.com>,
	Luiza Soezima <lbrsoezima@usp.br>,
	Sabrina Araujo <sabrinaaraujo@usp.br>,
	Lincoln Yuji <lincolnyuji@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads1015: use device_for_each_child_node_scoped()
Date: Fri, 26 Apr 2024 10:19:53 -0300
Message-Id: <20240426131953.14933-1-lincolnyuji@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lincoln Yuji <lincolnyuji@hotmail.com>

This loop definition removes the need for manual releasing of the fwnode_handle
in early exit paths (here an error path) allow simplification of the code
and reducing the chance of future modifications not releasing
fwnode_handle correctly.

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


