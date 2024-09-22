Return-Path: <linux-iio+bounces-9710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24C097E3F4
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5691C20FAF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA682863;
	Sun, 22 Sep 2024 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp0h7b3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26957F7C3;
	Sun, 22 Sep 2024 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043482; cv=none; b=eyLx6icBJMTwE9gAiGMMTDk9+ZOP6q0B6Xei5itRTjzOAWUPlDeZRTbgnbvaJUs+U7YfAVjIh52n3+89vWn1FPCJH2gYZyOJyEQJsx0ahQgmtu4uejMkHIeyftbZSovTv4LqMYIMeC3WSAcACuLowtaPKVei8Z44YdsEOa2p3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043482; c=relaxed/simple;
	bh=EonYSneIWPYxbaJfXi8LlItpdf3jHc1fxjBzf1me3os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMrWtZr4TkHhLcUnGHQOqednoFtYWG/McWy2Fbp3KpOTctSLJ0VR2m2cwWY2edzMdIrQEprn5UFFo0wIdEp+JH/4zybnenwpIrppPisyCpePixbD4dZ5iDPLXI1Q7oadafuprHOtdWKTfp3KiicwnUR9Ewsp8rKLKnMV7pa7xU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp0h7b3C; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso511977166b.3;
        Sun, 22 Sep 2024 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043479; x=1727648279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bzmiNVbte7T3ewBmj3Pyyc1MaElC3cTEPj2xZYvjpA=;
        b=cp0h7b3CJLhawyfUrEpc8MQPr+Wj1kbYN37BCqbChZbNhY5T2Qhkr8MdmsN7HjYznA
         zbAjzxA5RF8zwlkiXSIfQKpzDmSz2fzP0uiYAOJn3mdsm9ynPi5gTMz/OpYwGXuXuSMn
         qXrAx3njwTBgm4/GEzBlDIXtPkm1NflFgZPHk9BnvqYCrTC6Fiv/RB38OeRbjGNFJsPj
         A2yIjY0TG54gn6Crvyj4iYyyOSRXmthLbl8/lrcCaZhHTlnJibClDbfBrrhoVB+Lb2Ki
         /SW/ZZCWWCeiw8itDspgzYiETPM34lR0VVXn6JTb/HgUB7ZSNOGLCkHDAabNrc5u78aS
         xqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043479; x=1727648279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bzmiNVbte7T3ewBmj3Pyyc1MaElC3cTEPj2xZYvjpA=;
        b=lKWNTd/5ygm8jDldhEwnAoAOR04qTYVLI6HLoZOo555HtybA+9hNthmYucQlu5nJmC
         hPtSK9lYVtGa0uvBrPApPrdYRiBNRMUxlRDlKhht8Td5tykAbiQyFLUmG8sndiMv2cqx
         joiMel/6kUbQynxB28G9igdT3KFc93V+aFANCwC9FdmVHqKJsEbQOQ/ayz2EIcn+YWgc
         NuQc0q4hJV2MKQRr2HIfdH89oUh05XhMFsFL0OIavIv+vAlZXWnpBLtJmLXhdU8gAmAT
         0wxXFw+LsisiM+P8noZEw79qR0eKE+zExSLTbPXMQ9U5lNzdxygEK2bv+OrQapy7bdtl
         SmPw==
X-Forwarded-Encrypted: i=1; AJvYcCVNDR6xr9kdglBNhmmhk7dHqb0FIQIIQ4ebrjvk1TrLUG7OuppZ3fAJSJ64AKRLGsMKfuvnN6pkt+uX@vger.kernel.org, AJvYcCXwBz2X4R3MX7w4WPgY8iZ3/FjHNmV6uGV5biyPCGpqVMbTfWS72YlENQcSPTMPSprd7B+5ALxA/YGSemLy@vger.kernel.org
X-Gm-Message-State: AOJu0YzNoMGUyEzsx0BkZUmd5WBMy7oIxYcqpw48ibVTBvK6qx+3UsvL
	6mlrPJgOU9/X14YllmodI0Zo91R+L3VV7W3K04fcs9zHdKEUN/gT
X-Google-Smtp-Source: AGHT+IGmYraxuWC6e8umlcTCOfPub93JrctJSQgI6I9Jogb4y5ULTgQ1LgKiIwYAi6LRk+0eB3JNoA==
X-Received: by 2002:a17:907:f74d:b0:a8a:8c92:1c76 with SMTP id a640c23a62f3a-a90d5033f31mr890134866b.36.1727043479072;
        Sun, 22 Sep 2024 15:17:59 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:17:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:50 +0200
Subject: [PATCH v2 02/10] iio: light: veml6030: add set up delay after any
 power on sequence
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-2-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=1580;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=EonYSneIWPYxbaJfXi8LlItpdf3jHc1fxjBzf1me3os=;
 b=65Njqi7aMcHqjfz4NBpJYZ+rMQ6+6unyAK0suU88bbRVfPdcntv5iJVA30EgbfzXg7aSJ7WYK
 Iuv0+riFjPCDGHrZ9d9sDzZxqL8NL9bRWo04UGOXFaNaQfMap06JMtB
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6030 requires a delay of 4 ms after activating the sensor. That
is done correctly during the hw initialization, but it's missing after
resuming.

Move the delay to the power on function to make sure that it is always
observerd. When at it, use fsleep() instead of usleep_range() as such a
narrow range is not required.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index a3dfe56b7eec..e412a22474e0 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -144,8 +144,17 @@ static const struct attribute_group veml6030_event_attr_group = {
 
 static int veml6030_als_pwr_on(struct veml6030_data *data)
 {
-	return regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
+	int ret;
+
+	ret =  regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
 				 VEML6030_ALS_SD);
+	if (ret)
+		return ret;
+
+	/* Wait 4 ms to let processor & oscillator start correctly */
+	fsleep(4000);
+
+	return 0;
 }
 
 static int veml6030_als_shut_down(struct veml6030_data *data)
@@ -767,9 +776,6 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	/* Wait 4 ms to let processor & oscillator start correctly */
-	usleep_range(4000, 4002);
-
 	/* Clear stale interrupt status bits if any during start */
 	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
 	if (ret < 0) {

-- 
2.43.0


