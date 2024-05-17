Return-Path: <linux-iio+bounces-5080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045F48C81AF
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 09:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A671F21821
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903FC2BB0E;
	Fri, 17 May 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXTCEK1m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616B25778;
	Fri, 17 May 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932083; cv=none; b=serylWZvOlbHJKnMOm334G3HMe5nUWKmCuESzY+A8AgXzurthx5Hs6BFim73qucyXLZb6/WubHDNRoUdfWyukwgNFgK0Wx9CcS46ErfRXhRVo2xmrvaZ6tYNNg7jLDolM71EbqpKHxVCRKy3PNHoJVRCvbd6rSfZn+kl7d2tf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932083; c=relaxed/simple;
	bh=ZTTCD8M8R84jpBAsx4XNBxqCHS8a9HHR7R8VmytZ3to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FO5VxXVycgU2BwSb0sKJbc6YwAbzsM72INhtTEwbbdW3BFOXRAX8+zPdBeHVs3VaccEvomNavoAHUC/erw7FUGP+sT+AbSwU7uoDjLKK4dsyjcKZJVJMjhzGNAUgisrYrO/TrSVekHh63RgipRmISl71mumrI2xqAYNbnJQ7Fns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXTCEK1m; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so7571896f8f.3;
        Fri, 17 May 2024 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932080; x=1716536880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5wQI4nX6MfOWodw/xXO0mHWCjHUeVC+qZ8h/QLV1ho=;
        b=HXTCEK1mYjQ7HcwCdjCEM4CcA1QoAZpVWEVo1xtcRIaeL6MnNYoEqMc7337lTyDqqW
         MQ24pvlk7fjd9LkNkhk1mJ6C8E5c+omlndRWKXKBvmhEW4ROO8aBHzFZR6cNTij15Wz7
         +nXLNJpbdMj+8gTvYgS+2uUwBYT660iri2RYDiyzSlaremeJBZAC3/t4pl21Gh+XOSg9
         3fbRMAYUM/N0rZ/SnQTMBfi7lsY41/nmfElmno5G73dVcAAS7bRsXqNHfiFXz6e4Nzfm
         +8olbt1CWj/qUrdK2cdDT6XW2408WLyauSQ1qH5KC5xWcQq8Lhn2Zgo7swAg7yYNnO6G
         ktNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932080; x=1716536880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5wQI4nX6MfOWodw/xXO0mHWCjHUeVC+qZ8h/QLV1ho=;
        b=gL4EW99uoFu04OjTrTmWT1UZYYRsDw7xlTtje9YzNU187X2BGo/mnRj2g98cIPbbNx
         wF03NzTNlOLY7tKT0lvui619KSV65K6qr8r87ptfxrRB7dZ2crTbt9USR7iJrAC48sgX
         puzI3fg06OQBgg0pUGXwkA7PeyEyeP7b2VhGtO22hxDF3i/qDgY6dfqCWIaHmI5Yy4y4
         MO74NJ+Jk8AM66vQCe8nYrRPn9edtK506br4A+7XCeacdVkfhIX0LLpuwJlZr7NjBg/l
         nNFuSMd+9QNksAm1kbFl5s54n/5ZbU1pmkQMRp/fFHvpUEtAMlrZrlrBUZSQWYPucSyU
         a9Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWWrgKOkNB6C1Sz5m8mjwkUxl53kU/IuIsWBKt0PkXLbQ3b+fuyCfUfbNZ/steuSZflOwGCOFFczhRhe5kc2yzVIkwG024hDJvryqwLWX8sWtKu5MTrot5L+U9v3iGd+yCO9qVETQ==
X-Gm-Message-State: AOJu0YyH8dQMu78meSdsakMpV7qDtd11tRSpLtMfSNMFovg/5Dv7RkTh
	nsg110bldGfdfajN+St7K5GXC6tYzPHMPg7Gw1EX9/OrwmPObEgUczG3ODoRUtI=
X-Google-Smtp-Source: AGHT+IGTOPtlELg5ihVzMayT3ytll2YozuViHm2+16bACb//WQk2sC5V4Rl8PWBUvNOpXzfrfHgfPw==
X-Received: by 2002:adf:fd0b:0:b0:346:1443:27ea with SMTP id ffacd0b85a97d-3504aa6886dmr16881806f8f.68.1715932079921;
        Fri, 17 May 2024 00:47:59 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm21104207f8f.85.2024.05.17.00.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:47:59 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v3 5/9] iio: imu: adis16475: Create push single sample API
Date: Fri, 17 May 2024 10:47:46 +0300
Message-Id: <20240517074750.87376-6-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create push single sample API reposnsible for pushing a single
sample into the buffer.
This is a preparation patch for FIFO support where more than
one sample has to be pushed in the trigger handler.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v3
 drivers/iio/imu/adis16475.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index f9455ecb348c..ab955efdad92 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1249,9 +1249,8 @@ static void adis16475_burst32_check(struct adis16475 *st)
 	}
 }

-static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+static int adis16475_push_single_sample(struct iio_poll_func *pf)
 {
-	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
@@ -1340,6 +1339,15 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	 * array.
 	 */
 	adis16475_burst32_check(st);
+	return ret;
+}
+
+static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	adis16475_push_single_sample(pf);
 	iio_trigger_notify_done(indio_dev->trig);

 	return IRQ_HANDLED;
--
2.34.1


