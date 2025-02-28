Return-Path: <linux-iio+bounces-16173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82129A49457
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 10:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1363A5756
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 09:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B4254B12;
	Fri, 28 Feb 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+jq24IX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D31A4F1F;
	Fri, 28 Feb 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733388; cv=none; b=SC3aaqb0rES5onUauQaFwnEJ1a2LB+kdn6bynNaMJAHmjZz6Wj3zq5SqBarmFMcj/UtxSFIjwBCCJRAHnRPquXP0RqVKNA2ixhfTdZxrzlE5aCRsIdRyqSKBZQ+aP9G9o5UfrbJvrVw168rBew7fk7fxryaYwxffeQcx9Tdp2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733388; c=relaxed/simple;
	bh=+XGe0mu0SCo1mxTdfsf+zPYqAxLe/z501wqCSa1WhCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fBXFOQlXNZ65A1ojVWmaa/cb1rrfWp/X9ugVPR3bOM1DgXx8IoEAtLVKKJSHz1EZ18JFSBdy5cKGPX/fNyEbZQ/WJdhdZHNZ3zmbFsSSetMM4nNDs4BGLp+Z0nr8JlTf6diPkN4uJcEE6Uy1OcfM5Bj+l6brKpQcFH793Q03HaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+jq24IX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4398738217aso16486575e9.3;
        Fri, 28 Feb 2025 01:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740733385; x=1741338185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKm8+XA6ytvbZ7u+350CbkrEfd85KLjixp0jSDomf6Y=;
        b=h+jq24IXfwJtaZ/ss1+JjKYWiNvIHZ9HLcUmoPx87pGJgu5pCx2HnZ/EYaSjZ+R76F
         aZVhw/rOogrIjwFNWGNZByJ9NWxEuQw1VZB3K8g9yXJrzZoLPMzVwmH6UfbfMwyQvEUa
         4l2xzsB0uXJQ5c9PoldBH6L8YZHHBBZjr7ehYyS0/9fRIBd+9bFSSd82gqt3/nNUJE9Q
         VBnE2DSvrPMBZ3TUBWA9I378ZndCs71Z2txkVrly5NwauWiwV0ZJe8J862mLvKwrPWFl
         vEzsCLrbK50BKAGT0o83YJaHaUdss1ALFrQbKrxXbybAum6+EeFDTlpBwJ3somEWXuPY
         OGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733385; x=1741338185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKm8+XA6ytvbZ7u+350CbkrEfd85KLjixp0jSDomf6Y=;
        b=gCcOagc5ORX99dtKkylOykpmp0U341q/uvm4omg+4Pr2gLwfpFKJ+sifedyBMw46He
         BB+RmYmS1mMXSCiBs0k+qoh0UB6Bw58lgSmi0fIxOy0LLkYVp2i98azoipraAAAlIDXZ
         +37hjt7KS91mkwLEplTcEt9gYa/OcLcF/uKjik+iuJNjWZJEFdLILEHBsnrozol07gYe
         7wCdnRRVxrvv+KHJpuDwaHj7YwtpWhZWzf8gXaXTCuyTM59eXtEz8jY5W5sRZQrVmXXS
         vvca3FH3LAQPVvAz38zsL6tgs5bEwqO9e7LrL0hgJGgOVxjPZ7usedUxQ9Nzup0gI84Q
         Uwyg==
X-Forwarded-Encrypted: i=1; AJvYcCVGz32dmf+Pwm3GmchTwmjtFomGRfcSBk3Qxoer2S8gxKw+wCj+jN9fNmyouNoOruQREebsL2obqyM=@vger.kernel.org, AJvYcCWd4b6wILZkC1sdAq3bCmEclEDXvHq6qfA0dkQ20QnQywmch/yk1Ywljjx5be2bXAp+9UTzYY+8jnDixTD2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2U/z8DbN7s+wje6pFd+CvVaiOMJkNgx8diGfiRA6zduRIlSdg
	ydWB2J4mNa+Cpuj+ihBk9mMflqDzwkN2g0mwlo+9uE0HIAtYitg5ToMGQzgjF1k=
X-Gm-Gg: ASbGncvwrvs1QRIiSKmqshIXHCk8KR6OnyVvpFctBwE+N/VXhRvqLqQA7O+/U5NQNW6
	sg3l6c0b4om1ZNpGNiG+0b9TWlxR26jLNFWZCpH9kwCh5DSRwLlytELR5V0BZDnJsDUiE2Y4ThC
	roMP6ZOt9UO9h1wQapfp2WH83SpMfJsqDuQwvd+elnfjbSRNtATFxci3zX6ZtICybWL25uEBSii
	7QO+9pR/FOsPluWXU4DAXa3KJ4Z+aSaGrejqB2ms96KeykkXgBG0gxivXqARFJqkcikntV1HFK4
	ApfH1XzJZRhD8egYmKdldMof50c=
X-Google-Smtp-Source: AGHT+IGZNTyLmyojOEubcETsODxVRtD8NrJGYn+5jdOs3mlebik8+RmbfT6JasWkDn9iNLlOLztzhA==
X-Received: by 2002:a05:600c:1550:b0:439:6dba:adf2 with SMTP id 5b1f17b1804b1-43ba66e7550mr20923105e9.15.1740733385220;
        Fri, 28 Feb 2025 01:03:05 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba5870e7sm84188545e9.35.2025.02.28.01.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:03:03 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: light: Fix spelling mistake "regist" -> "register"
Date: Fri, 28 Feb 2025 09:02:28 +0000
Message-ID: <20250228090228.679535-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/light/cm32181.c | 2 +-
 drivers/iio/light/cm36651.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index aeae0566ec12..bb90f738312a 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -492,7 +492,7 @@ static int cm32181_probe(struct i2c_client *client)
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
-		dev_err(dev, "%s: regist device failed\n", __func__);
+		dev_err(dev, "%s: register device failed\n", __func__);
 		return ret;
 	}
 
diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index ae3fc3299eec..446dd54d5037 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -683,7 +683,7 @@ static int cm36651_probe(struct i2c_client *client)
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&client->dev, "%s: regist device failed\n", __func__);
+		dev_err(&client->dev, "%s: register device failed\n", __func__);
 		goto error_free_irq;
 	}
 
-- 
2.47.2


