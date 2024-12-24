Return-Path: <linux-iio+bounces-13778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7509FBCD2
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 12:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBAA1881B8D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5421B87D5;
	Tue, 24 Dec 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mio64nP1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD81B4F02;
	Tue, 24 Dec 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735038000; cv=none; b=MuWRnbNY+70U1s9syj5mP3jYSXLXJBz2FCsvNXxZnn3reJrgSMdA/GH9kz6T95iB3wRsfDiT2ZOP9p7HiS+M00Dokqyy2ZgqGRDmidLIo2JsMxcnSNIVYQndge8qSkLjhIzisn+kZF8qXVzUqtUez7+hfP42Frl1hlk7uapED6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735038000; c=relaxed/simple;
	bh=2Xw81VnH7Pi3oW32cYAtoCHyGZacAncEkYKwYPX+v9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxIUaQGum/Z0Gzv9+9Oe8AuW84eHbhA2jJRWl26OlmcKb7FoIEz3u3xjO5Jw6SJGjNSRlPCU4iM62E3JF++3I8D8wGOX+OVf/ZjJHWkUguAiLNmlfCSjwIuf/U8kyJemJ9qmSUV13VEv3zdz+4kkNmH0ctJNxgqH6Hi/SjjsN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mio64nP1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4363ae65100so53478275e9.0;
        Tue, 24 Dec 2024 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735037997; x=1735642797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMV9SEazsPxA7ks5Ucr2JrZZrfBykigFdMLCjyvHqjQ=;
        b=Mio64nP1E0vbAq71beUqxrgnk6C8qeOfiZ23RZSA9k+xbnb34VFAXT2GoDM0sh9MKz
         IBspv8c2uPaB1XKsB0fBCpArg1kvONhqcUKcixnulz01H/HlOLFflmc9PcgeQFHXAFDq
         3WnBtFpa/tRYQX6CO5R8FIowbS5yJNypR/uPfnhtKTym50jI9aORdLJGMaVRJvRYgRLj
         ivxZR5yArIkJWGQTfjkius0e/s4BpNA8KscivAXCWKsPgOTxdvlkrWLcFfBP8Oif37Vo
         IQ4rj5PnqQScoAQ2JnEQBU9bAXz9xmC7UJiujfpXVnQvLIut3gzVE/kWb3kn5+K96t4J
         n/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037997; x=1735642797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMV9SEazsPxA7ks5Ucr2JrZZrfBykigFdMLCjyvHqjQ=;
        b=jSjx9VtAvPAi94W+8EXOzw+I++CVMZdqd7g88cwqE6+C2grthUX6uizcMzfDUEFO4A
         xyXQZnpvgHaiRS8kPUCaMFTluAsVccbSm4hgMDlE3s0+602bWjens5pBrINgV/zPE8Lq
         xS1zDhfgIftuInF7nJtwN1rVnJCFof/oPuz4bSQWC6c/51O227TdFH0NIGHsfpXdFdWK
         hkWxbD5Mm6O6A96y9l9qr1csA8coL8qO0NasLDYj3YLDaIFSJGzOE941PAfJA83+ut12
         gEavri6YfuQ1FwoC4Sk5ublQx5HngnYM8ACDcWIZpPmIczziTNBGab4h/8QsANMagPAV
         vxqw==
X-Forwarded-Encrypted: i=1; AJvYcCXW9/ii/iV/WinPwKJOUihq5ZsFavS9X5IAM1HvamapTNIOFLAhSKYp/Sdlehq8QFe15viyJUbzeXTBwj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqnwogF2JTKPYxEvaDzCllssQkt6G9MbzVLWjUo7RhPKhOtP/
	YBc28tKAZwlD84RumT3nI8ZFARSfgteEW1qJqnm/pJSOa8etKsSg1/Pf3Q==
X-Gm-Gg: ASbGnctzYxC6j5q3xQtmcTTckqjfPhiSl+Z229BJwfjtN6KM5P37Jnst1+HpCB2MGES
	5OmOokQsJykambWNuDT6Meop6koISBdG/xCKKGPD1tQJzq4Fo7whhvubQiu3hdh//wwDnYxx4Qw
	lM4BTGgh2ZXJCL5z/gWFKyi0J6bYGAUvI02TZAUOloN41GYjRvt8uUL8dA7FRjjRENQWkM634T+
	AVATRsjxxmvt2Melr2o2Rl4660z6Q7dc9CU+d7XR+Vto2oWv179zOGkkr8y2TyNEl94URHktPai
	zgcD1LbSOI6xI7jYTDu+d7Ry/oxJDfZN9xXn2y+Suv+5QHI6fiZypuQgyh60n+t3J76HKzbc85W
	dRg==
X-Google-Smtp-Source: AGHT+IExOQ+qcuxs9yGFpM5l4EtC0wK1SDOUgQMVGzUP4kqM+QAfqqQmTjaoV43pPUIhKx9xa/WfSg==
X-Received: by 2002:a05:6000:186b:b0:385:e877:c037 with SMTP id ffacd0b85a97d-38a223f82f4mr13609587f8f.42.1735037997443;
        Tue, 24 Dec 2024 02:59:57 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1a49-0b63-5213-952a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1a49:b63:5213:952a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb85sm13699427f8f.103.2024.12.24.02.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:59:56 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 24 Dec 2024 11:59:01 +0100
Subject: [PATCH v2 2/4] iio: light: veml3235: fix code style
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-veml3235_scale-v2-2-2e1286846c77@gmail.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
In-Reply-To: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735037993; l=1057;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=2Xw81VnH7Pi3oW32cYAtoCHyGZacAncEkYKwYPX+v9s=;
 b=y8BE6ROBvnqeHuQmptIxRBatLmyQou5rZNeDYKHoo9RrcoJfzC4N/+Poive6O7JX3RqxGiziM
 vmMq+OTBI8PDo4WTTkWQBpA5nW5ZdVddG1FkPftE4Yrv3g4SUHArZrg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Trivial fixes to drop double spacings.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml3235.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
index 66361c3012a3d9f30a79630d51f329dacfb141bc..fa5c7e7dfbfaec1b96428612b1dcba91ea51603f 100644
--- a/drivers/iio/light/veml3235.c
+++ b/drivers/iio/light/veml3235.c
@@ -321,7 +321,7 @@ static void veml3235_read_id(struct veml3235_data *data)
 {
 	int ret, reg;
 
-	ret = regmap_field_read(data->rf.id,  &reg);
+	ret = regmap_field_read(data->rf.id, &reg);
 	if (ret) {
 		dev_info(data->dev, "failed to read ID\n");
 		return;
@@ -389,8 +389,8 @@ static int veml3235_hw_init(struct iio_dev *indio_dev)
 }
 
 static const struct iio_info veml3235_info = {
-	.read_raw  = veml3235_read_raw,
-	.read_avail  = veml3235_read_avail,
+	.read_raw = veml3235_read_raw,
+	.read_avail = veml3235_read_avail,
 	.write_raw = veml3235_write_raw,
 };
 

-- 
2.43.0


