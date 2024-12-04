Return-Path: <linux-iio+bounces-13093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37609E434E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 19:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFED167986
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4521C3C15;
	Wed,  4 Dec 2024 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw1f6eFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3C1C3BE0;
	Wed,  4 Dec 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336710; cv=none; b=M7ohjAg7WxZCqhKOo+QXm8W7M1fkcEdl0Sx4WvQyn/Ne2erM7AhT/ycUon/SthZDcPVNuRNg0h7e0d6G89oAjWOPGc9i65cATY4B1ckAYiZX+YNGRYGtTLrZ1uicQtEZTqSb5Z7AN+2L60enu+iHVpYbAF5MK3qZnsAaqoRl+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336710; c=relaxed/simple;
	bh=tvlpR3ACIZjZ26sU6DfiM9q4+OrGk/guXwAtGKWdyjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVbjjO6dhaW5SS+wYD0qSjzIKPWWMIfbrlMVFpUTpXRKuArs8KXLKPFE9uqeq3gqn2uAJn2D3gdRL9b2kkl4cuJl+T5nKC7CjxcasvmgZUqmo69R988QVaXMVP4BTglSGXKd8+MZHNAOND96piQEPeXM6fsPNvGPb1q4fNni/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw1f6eFh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434941aac88so81925e9.3;
        Wed, 04 Dec 2024 10:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336707; x=1733941507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/9VPQ+Uf/rRtf7/eLBAF/0nGYfYrUrX91JqSy1ZhlA=;
        b=Rw1f6eFh46K9lGiwlUffSKCl6MFy8BsiKLhDE750jfzyTPoQJ7Fj7jcGy+0hqIqk+D
         iHtzGp5wv3xTURcqmPkmwmeHj1q+SnDru2I+iQaKP1QcjZ0MakNbs3GRkX1oXuuaVezk
         LfULqV6AnaVtyeCG2CDPuGSyu9BoDz6sYkpfE/c7ISAOw3AFmd90GPS8KEcXMyhDM2V3
         D6U3wqXeJ1ezw9BKIjH9sRDayuFxnUfoPwxtByoc2R9Ca6o8JqEf0RgTSc3kKymPeNIm
         3dgwSq1pNrpX+e0NF9IAk6NPaLwVQqsmZo3fhoSWF5xk2pfR/AuPdhoWY3NsczSEGiww
         UTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336707; x=1733941507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/9VPQ+Uf/rRtf7/eLBAF/0nGYfYrUrX91JqSy1ZhlA=;
        b=eM1m+STT3h+rganHectlvU2OTTyKFbKCsd/RzBUGTbbe16Z8eCxSZEsNrQFkXWXHEm
         AfTwghKsEDRtuppvK1qhvThcGzFiyrnpDYWJfWhfD0CcxsAhvCb8F+eutT5y6Tw1QMhN
         e9cGfI43gmcRUN2tUJ2+ZGZqJMkFzkSkcDCT7M73fWCc+K+twFMaNKpSdF5LA6Xy82ry
         DqozrObw8gmnez6xYGC/vHIaMIh6dVBl0Vf9gOJnELLceQoCZXXpXxvc/OCtuD0vkxeJ
         CdO+zZvwLJOdFgrmfNCJyw0Afw7Pn/PPR4wxr1GCYb84VW3nAeiu0VoGAfXi98zwV37y
         /dDg==
X-Forwarded-Encrypted: i=1; AJvYcCVIqmep5Xnb+thDiEXyG03OHFwKwwCP26VfnHmmL/IJ0zlowPrsho8EAZez35m7RgPVq0QZOD7ctpU=@vger.kernel.org, AJvYcCXuQQXZi4L05OncpKUPIWn4NgQ43gEnoN4e/eJSbou0mSj6diGR/ehMD6yiP8KHA4Tu2n2egP4LAGS5Ubta@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FZuPeDtu3xMBlQfhQYafCNCd0uPra6rx/nsMbn0KY86cYH8q
	WA0DoNId+an1BQT5zltVGAidM91R54ORQA30s3LM9BitVR/HfsCx
X-Gm-Gg: ASbGncsT6r1BGHmjbLCC1y/iPZt1lr7G/mAEmIpX0yVpMqavfGViZnorECghMb8l7AE
	iCyNhLnEtpo71AzJzlKUqXXHD7rODybnUCuq4mmCCKzOAI7h3P8abOc8FLBG/P7IBQijq34xyK8
	rlAP/LrOdT1ZFt41QPO5YWxW+7ExtoVQgbgz4qzVe2HXltV3R0qTLBXGSEgWSPLcRA/Wbcz9d8Z
	ew5DosNsf5VunIrUNZkclBKJ4qZ4XTB/JaTEfeCoNs96xKFMjuIPohWgQN4pKa/fW9rUKqp6RlT
	npIr1nM7Z2sBL44Q8BaHGt4L/QDr
X-Google-Smtp-Source: AGHT+IGBK16Wfkp6DmkPPYO6dYJRTTYXFNoNlGHE0svRXVvuPdhxFoZy1LtwU+riSKz+flyH3vgdnA==
X-Received: by 2002:a05:600c:450c:b0:431:5632:448d with SMTP id 5b1f17b1804b1-434d0a3568cmr27402295e9.9.1733336707131;
        Wed, 04 Dec 2024 10:25:07 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:06 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 03/10] iio: accel: adxl345: measure right-justified
Date: Wed,  4 Dec 2024 18:24:44 +0000
Message-Id: <20241204182451.144381-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204182451.144381-1-l.rubusch@gmail.com>
References: <20241204182451.144381-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make measurements right-justified, since it is the default for the
driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
the data becomes right-judstified. This was the original setting, there
is no reason to change it to left-justified, where right-justified
simplifies working on the registers.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 88df9547bd6..98ff37271f1 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -184,7 +184,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	struct iio_dev *indio_dev;
 	u32 regval;
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
-					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	int ret;
-- 
2.39.2


