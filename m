Return-Path: <linux-iio+bounces-4997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D38C387A
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3941F21F48
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9319D5915C;
	Sun, 12 May 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIe+0v7Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096558AC1;
	Sun, 12 May 2024 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547922; cv=none; b=k1s9g+7/H2Vv6ZmSEy/Pr8ZxwfGLUuG1xPsRZKb8ihe6TEkX7SEtENlmJ5wtouydOG/Ne5KeA2cmNhid6FP3vJazBgMplni2mpBQKaLmny01+ZNy2gx2m3LCr1znJ/yRStIBr2JnXWotOQyxAnujbD2n+fIF8lcOX+9yE1zeBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547922; c=relaxed/simple;
	bh=SH9oRQMjdWisKJzgNmlM9HRFY+ONAsdZowm1gdmvCvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9CuiHb0kkcqKPxCMrfyYllp9h2e7adPlwtaJBoJxJfgcwKBgv18mtVLG+1WsB4oH+PB04tO9LVEHDzpJw4nrJHsIfCjDpsOJl8kqU8KIsc+9BH8vkgdBSDJkyGe6r8x0s46fkpTGZZjVYd8RWcTnDsEFdVAKrgudpGjc61PqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIe+0v7Z; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f472d550cbso2994943b3a.1;
        Sun, 12 May 2024 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715547920; x=1716152720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZxVl6V73Zt3zGRSEIH0bHVxMtSUe0uIzUK9Y3RzWb8=;
        b=RIe+0v7Z/MH9HFxrLmXZGIbWF9MEqJ7j491itqXjtcv+zXYzTd+7AFrJw/+S8mbSD3
         qqgIXcVjwI/SqDDQ4RBH6XaTfstfabS1rbEVc8rBHjKctIMiTMqC6HxAfVWgzxDK2DpA
         a+1x7HDqqZ0SKO9YAw4kueonwKORvdxusbVcn/FjtSZR/6ZLdmXMOwgqjG9Tpj3eqDzj
         7sZ3BclovB9DDHmcfN+VcZ4az3/MmXpTP1/X2YlvJxUX4R4/VspOV1A2Br5CPFZwhMms
         oKbbWCAaFcJe6/YHdgzhb6QM8DefrfEUQs+ZxeZwFytvByP8p7zo3pHpD4FKlizZ0xaS
         4tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715547920; x=1716152720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZxVl6V73Zt3zGRSEIH0bHVxMtSUe0uIzUK9Y3RzWb8=;
        b=BS6f7MEEL4cy9pbjmraMXcqNXdXj3Pn/WWPfs7h5HucYyvzmkKGGb5oH2Oi2kEIRVr
         DGaiHoorBEjC6I/Yep74Uqcc+4yIU8VNcW9Y26wC/UsOrXeLephFTvggs/DuVy/662gb
         /UZT7cit1PjGrAg9i7JwpkAuQ0YJXAVpaQt6moegHyZBxBX/G5IHoHnT5M+W96UN+T7w
         9iLxiWbxDbAR3f9ejpel5Uv2w9AL4yTjju+58rWj8QqN6g1ffWyODAYiTkyMWLONtcy7
         woEWJQjf85j0AY9nWloFyB55IK0d5wjbijj5BvxUxmv65dubWobeuprIMLVy6tRKgyrZ
         zfFA==
X-Forwarded-Encrypted: i=1; AJvYcCVsDxPpopYqADzTFwezkEtlgAfRsotQcsAIJF4ko27Ir9JGDizlDrutyeyrzmzyt8JmYI6EglnGAsaZavReKJmsjNJ6uK+pAQQBM+npaYMYqlLwYsQ7ecWBw0LZeA/mngrHGguxQ0G575UrN9ohpqaWyT5vteae2Xhzf4/Ju4lwKRxkHA==
X-Gm-Message-State: AOJu0Yyq+w8YO63W3R49JPgoKCvGO7EqMF3wzxcHcYBTzy9TyuZPH7kQ
	3PGn3q3k6efingtnSbgHZv1zxhakZOFrfkB2+VNKrDj2cJdl0qfk
X-Google-Smtp-Source: AGHT+IG5MvnYwIO6+AJazfOTBsF6M/uKIYOGmvv6fP7kAHEoITheedJ4UpwH2DZJX0Ai4cfEmr5S6Q==
X-Received: by 2002:a05:6300:8085:b0:1af:cfe9:9221 with SMTP id adf61e73a8af0-1afde1c580fmr10890522637.54.1715547920408;
        Sun, 12 May 2024 14:05:20 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a447391sm6534865a12.3.2024.05.12.14.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 14:05:20 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] MAINTAINERS: Add ScioSense ENS160
Date: Sun, 12 May 2024 18:04:42 -0300
Message-ID: <20240512210444.30824-7-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512210444.30824-1-gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for ScioSense ENS160 multi-gas sensor driver.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 304429f9b..92a130c8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19660,6 +19660,14 @@ F:	include/linux/wait.h
 F:	include/uapi/linux/sched.h
 F:	kernel/sched/
 
+SCIOSENSE ENS160 MULTI-GAS SENSOR DRIVER
+M:	Gustavo Silva <gustavograzs@gmail.com>
+S:	Maintained
+F:	drivers/iio/chemical/ens160_core.c
+F:	drivers/iio/chemical/ens160_i2c.c
+F:	drivers/iio/chemical/ens160_spi.c
+F:	drivers/iio/chemical/ens160.h
+
 SCSI LIBSAS SUBSYSTEM
 R:	John Garry <john.g.garry@oracle.com>
 R:	Jason Yan <yanaijie@huawei.com>
-- 
2.45.0


