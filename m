Return-Path: <linux-iio+bounces-13779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8A9FBCD4
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 12:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC08162CEA
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCA41BDAAF;
	Tue, 24 Dec 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4mb2UGj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EC1B87F5;
	Tue, 24 Dec 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735038002; cv=none; b=V+XHNqO2Yf4cIVQ0wraLjISYNOX62aOL9ysVe5QJ5+0iZ4qQN7rLJtwM/frfpA1MsAmFRraH1kqCqw0HipDCw+SJ5AmIdVXBKeMvP8WEoZ6PUnphB2mYjian+IgLCHlppglHSq+Vc1ObeKMvtDmDomrPxbqyc1WsfgiTSYBZdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735038002; c=relaxed/simple;
	bh=sPLOEksW/AM8olcpcDqn2YYtDWmfEDxZzIdwUjGngkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhrmkp80zkwutuxQQ/KGy20g+9MJbHJsR7dCccKq1PUvT4csP+Lb2eSntMTlkh9Axv68/6aGMPoWyhmdfrHUGXVVJ7cM6NHcIX1UwBQwJ8QsEMs5o0tEqb3nfCz6IL6bEP8pG2PxmAiK4xQSAaWyjnV/tubZ1HcWPohnVDkhe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4mb2UGj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436202dd730so36435735e9.2;
        Tue, 24 Dec 2024 03:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735037999; x=1735642799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SS4x6h64jxZLgUFCVk1KhAJGzDKZ2HMe1hx7S4Ppb0=;
        b=l4mb2UGjSSLxoZC5IAYtq5Ahl2fG6BjRCRlQlKQkASXK4sRzaIr/ubi66pp06fw5f2
         mphpcNSnoh1TbxE8xPYxLH7Iwvb4JVJ4PfrunIiO6EldxzlusOKKh715HvE+V/eMv7FO
         iBboRyhPeOzNk8fOf2o91dseImu6new37zs9AtHcIOe/SG2tSy5owtw0yX/2jL4Cc0jX
         Wn8fClXAh5P3A+pQxDzRJuIbEjvC9d9HMl/ZHw9yKS/u4H+QHfs4+yEV+7ESMhfYgnja
         bjMVAixaQ1JS+r5Z6t3j7A/MiqscFxtJ9e3mxYa1hkv7z7Z1GkVeoxrESFG6w327GQMC
         s62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037999; x=1735642799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SS4x6h64jxZLgUFCVk1KhAJGzDKZ2HMe1hx7S4Ppb0=;
        b=WbYOLGV7aq6t4X2Prmq1bAZCus2dxDpUQ2NEpIMIdItoZisPlAgSotbaTnXiJmUuzf
         SxRFN2KUwXxLELnt7EPGjBzx6RW4hdN5kKN0ZDcANw1GaAZLSCCOnHagnNNF4DebTlRj
         9gWS3EwiElyxr3irMzSDKoIB3upDACGzRQPKgjIm2zSav9PWlPAsCDdKBy72pWxp0NOY
         w1P6uDasfzayvuYs5Q96WxsKx4hqUHpZARwxaESzSZyvqrSGqPlqtJTeLVx+HfqVxAJb
         hkILUwfOakPFwZh3NlTnGFHJvONqoeqbQsHDHFTEtP4L1Ku2rAVJVYmROBac+s1x2VUH
         KTKA==
X-Forwarded-Encrypted: i=1; AJvYcCXEeTAdy5l6paZR0Xe5oD56tpszQ8YmyhCt5GoBOzW4XwZCgKwluPvnGUHZPd2/RuUvS6ySfxqj72RumZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyhPJDWMiTq/I63jV4/HTSxAvU2eLdxdjz23DVTpIrI3dwzvZ
	xfEbowj6pqtF5WZQ8n/vFp3vPXPNsTye2y63fKcwJ+oCc7PyfXKD
X-Gm-Gg: ASbGncuq6mzOn15RrS0YTLv3ZPLFiM1LfUQrKcg0DixhmIPj6KWsiUCiMHKPqVp9Dzn
	vsDUutKHcyB0izuphfCITEchHf/lIBfy6jfuXNCULwltTM/GHrDtqSwKjfNON2WIzOhd9oUE/U0
	iherPzS/YEMVMfcoBPeSc3TSRW0wwzu/671pgXGzoM5lpgGwZYZOL8z1HNE/7l0ShXbJ/04JXLm
	CItr+PdAS2M9L1Mp0I2eBHEAmx0ehsXC7nQLA3bNKuL/dF8POnE1sxxeYI38q2dCHFPNTJyT3tK
	iIEip3NOFs60jf2SxSDi7NqTxXE24eLtpptyi2gJ/ItjaneMTh739EDJ2WxN4dQO4Ao4tBSTUAs
	jCA==
X-Google-Smtp-Source: AGHT+IEOzvExCHJ7boMrOt1ykGMR+oFnx1PyauQX0twRNSmwegBWqiQXP8s9B6uXLExMxiY0bqb2RQ==
X-Received: by 2002:a05:600c:350c:b0:434:a91e:c709 with SMTP id 5b1f17b1804b1-43668b78c11mr108381225e9.28.1735037998986;
        Tue, 24 Dec 2024 02:59:58 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1a49-0b63-5213-952a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1a49:b63:5213:952a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb85sm13699427f8f.103.2024.12.24.02.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:59:58 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 24 Dec 2024 11:59:02 +0100
Subject: [PATCH v2 3/4] iio: light: veml3235: extend regmap to add cache
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
In-Reply-To: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735037993; l=2136;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=sPLOEksW/AM8olcpcDqn2YYtDWmfEDxZzIdwUjGngkA=;
 b=exK3Xy2BHvv8Bk682aOGsh4yGrCUrI6eV3/2A2FsaCgJf0znOmiw855uhoIUOA3wWKiZ9iveI
 3oeixOuNfg6AFSoBGKVyNQgLjAzkdR4S/qaljhN9VJCjc6Ul/SkdAeC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The configuration and ID registers are not volatile and are not affected
by read operations (i.e. not precious), making them suitable to be
cached in order to reduce the number of accesses to the device.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml3235.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
index fa5c7e7dfbfaec1b96428612b1dcba91ea51603f..f754980ea156a6e128ff159b816e09099197c5c7 100644
--- a/drivers/iio/light/veml3235.c
+++ b/drivers/iio/light/veml3235.c
@@ -101,12 +101,43 @@ static const struct iio_chan_spec veml3235_channels[] = {
 	},
 };
 
+static const struct regmap_range veml3235_readable_ranges[] = {
+	regmap_reg_range(VEML3235_REG_CONF, VEML3235_REG_ID),
+};
+
+static const struct regmap_access_table veml3235_readable_table = {
+	.yes_ranges = veml3235_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml3235_readable_ranges),
+};
+
+static const struct regmap_range veml3235_writable_ranges[] = {
+	regmap_reg_range(VEML3235_REG_CONF, VEML3235_REG_CONF),
+};
+
+static const struct regmap_access_table veml3235_writable_table = {
+	.yes_ranges = veml3235_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml3235_writable_ranges),
+};
+
+static const struct regmap_range veml3235_volatile_ranges[] = {
+	regmap_reg_range(VEML3235_REG_WH_DATA, VEML3235_REG_ALS_DATA),
+};
+
+static const struct regmap_access_table veml3235_volatile_table = {
+	.yes_ranges = veml3235_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml3235_volatile_ranges),
+};
+
 static const struct regmap_config veml3235_regmap_config = {
 	.name = "veml3235_regmap",
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = VEML3235_REG_ID,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.rd_table = &veml3235_readable_table,
+	.wr_table = &veml3235_writable_table,
+	.volatile_table = &veml3235_volatile_table,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int veml3235_get_it(struct veml3235_data *data, int *val, int *val2)

-- 
2.43.0


