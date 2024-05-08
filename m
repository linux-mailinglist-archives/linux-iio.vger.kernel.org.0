Return-Path: <linux-iio+bounces-4898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842228C024C
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6742B22E2C
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AAF10A11;
	Wed,  8 May 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+ewwnK4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACCEEADD;
	Wed,  8 May 2024 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187142; cv=none; b=uve6m34qTu8bl7y+E7OzxU4IBOyelTSQABUkJAW1NhCcf8ZbiNI7lGOjfwYTC42b0KF9NMpvfJB9xcY+nAY+1m/EVq+Sj1KX1k7bTNbGZWRBdJaJ4jt3mofkyELxmUUiZuW6dxvljrFHjpldBaS6rgy3qVVaHya4uDuOPUbQ5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187142; c=relaxed/simple;
	bh=doBaB0rNJP6gachGgrNAb5iWQ/1lP5X0sdIEkPUu1pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pg+xO0Rinmd2Y+YlftIQasMgX67nhPWw155NmtyfxgAcTVpnzAttmgAMIwZjD+ugqvvvPAwOI1yP4fLhCImzERl6Q10fAv35rh6XzBS3iUcjwTAExvwNpNVjXNmvTO/IuX/Si4B3vkAmqziJc78F7Em/IaWi54Vb89YmddglroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+ewwnK4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ffff16400so6742671e87.2;
        Wed, 08 May 2024 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715187139; x=1715791939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkV2bnGI2BWyPngxKTJfpLv7Ui/dNejnP7F0QLwVFr0=;
        b=B+ewwnK4pNUA6lRKIzkZJn4UOsTugGtcMVMRcNThyRqPJU7qjfUOvE05eUTEWaUC0g
         VSA+mR5gnuMqd8GuVS5vNOxq6Ukxw3cLhNk5YiBErmgmuN09SscnM+pXFpq9A29mLITn
         0NbuzyrlZvrb4Umb8aEsfoBCjUg96h0L46hTYqDWw+CebsXUJOv+Wp2hp2FA+JSvL8Kc
         6alGkCAKbGXcUGYhNOxd6ShTSICeOo8iFf0ByAvfU9whCPAifXqPpg1NXMYvUvMWbMDd
         LCsZlSUT7oyPCAYweLqqaLs+BR4O+2Qwe64UY4/2Nv6qh7G0HFt3zWaK0LcBr93iI0qN
         Mdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187139; x=1715791939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkV2bnGI2BWyPngxKTJfpLv7Ui/dNejnP7F0QLwVFr0=;
        b=ZX64vqEZQyRX28ZSj/JP0Q4hWGbE58+TesLq/BK0nybanpY/gmXZb2NWkg7THVZ32E
         fTXi8UUn0XVsg2WIERIF6VtA5ZAt4ETHmO9AcDhbfKyxMPpJRwJKQpuO+Q2mHNCdRw5S
         Ki5o8oWSnFSC5OuarS3WdK9Q6LMiC4aQVUC5OxY7Pd8KRu/ppBHaZbCevuMR01/Ofyvc
         uq8aCUsKGNNtpnxW5ThnowxTcidsV+WFbGaE9Mi1v1nKpqlGezcMrMPXzGeZuelasDqE
         oPcERujMHg9DEdZ2l0CPduEGzGDdWvEU+wEv2Mor5IUkwS76oVQScuvtBO6jJMMiuwgb
         FuKA==
X-Forwarded-Encrypted: i=1; AJvYcCWWb1IVZMHbx+SQdI8VPHvfIAfUUTkrlGNn35beuWNeuKElK7pBTrPB9v1byeHXMMHuhhfhZjT6q8luGDtybIKwIhjq9BS8tJ+B3FF3zLxvB6JulTJxoUU/NzTWQfR/Z+KZsnt5AY9X
X-Gm-Message-State: AOJu0Yw2lLe4PdHI3C91F+TWALzlIGrR9EM6+YuLEuJKFwC5cj1WUn7t
	OXaDt9AmRL9sDgZDrEiFE50SSBs/jZd6+yXUTmbSBU+JBYNQ4T7d
X-Google-Smtp-Source: AGHT+IGl/6NaXP3HMaVnJ6dOmi92AXO4XjRtC6iXgjMV3bU1y8+HVAYEaKDm/Vrj/HDk/Uvrwb4kZw==
X-Received: by 2002:ac2:5bc7:0:b0:51f:6ab6:9e5b with SMTP id 2adb3069b0e04-5217c7605e0mr2520510e87.36.1715187138658;
        Wed, 08 May 2024 09:52:18 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id kj24-20020a170907765800b00a59a8212c8esm5648010ejc.42.2024.05.08.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:52:18 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v6 1/9] iio: pressure: bmp280: Remove dead error checks
Date: Wed,  8 May 2024 18:51:59 +0200
Message-Id: <20240508165207.145554-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508165207.145554-1-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ret value is being checked already in all the previous
paths which exit in case of error, so this path can never
become true.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index ed49e0779d41..311a011604da 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1350,10 +1350,6 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		poll = 50;
 		timeout = 400;
 	}
-	if (ret) {
-		dev_err(data->dev, "failed to write command sequence\n");
-		return -EIO;
-	}
 
 	/* Wait until NVM is ready again */
 	ret = regmap_read_poll_timeout(data->regmap, BMP580_REG_STATUS, reg,

base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
prerequisite-patch-id: 97b99b1106cbfd65cef8d256e4dc1a3a9257511e
prerequisite-patch-id: c60e8ef6fae62417c3430b7598b1a3d2a551be79
prerequisite-patch-id: 6a49484a6d154ddcd1b45b71a6be2c3542ae0be6
prerequisite-patch-id: 5aae62fa92c719fb65a8701ec4e1c4284bef7fd9
prerequisite-patch-id: 6943297d5f70f74bfcf5d5b26198423e428773d9
-- 
2.25.1


