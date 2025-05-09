Return-Path: <linux-iio+bounces-19399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF54AAB1B75
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 19:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AC93BFB6B
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211EB237707;
	Fri,  9 May 2025 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDGP4q2F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9F86337
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810940; cv=none; b=FrE127c0ZWCCbcfF9ITFpBzvNmBz+iBMvFanyFyd1t4tGSabORMVzGnmBAS73D+rWDp5krQdeS1Sa0n8CFV+KNzaDi2rbeSVapliOPdoMSYtSYFeNp3a8qlm+2WoHP/NlNKo6YzVk+GquAofXVkFid9ud2pAf+rwqmyDpQ4DZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810940; c=relaxed/simple;
	bh=7AXn09ohMmLlau4aM4O3X2M8I+p6wSj7Kn3ni/haRSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvYr0HPjBkmjcK8ZmAQ079gfSyXRWjNY1wDwdNWKB+h45MG+mKCEzLi5xJglBavNTOzO1QNVBfncnBGFGJMFKKFEDUe+UatCoD0vFMIgRHsN2YaT6haCKwJxfNde/BkSNZCFngSPxOUMnYqib09H3OAwiId/4dBLo77bs4WZQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDGP4q2F; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so16582035e9.2
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810937; x=1747415737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sb8qMdmKzW0Vs+3WIEfP2a2QpfhhnS15MuNPys/cEKk=;
        b=UDGP4q2F2L36iv0WLJHzkuc/myXVL2BwVvXp1QklWeI90egCnAswxck2xGNDzKSC0J
         zxCOxGpqlMvM2YDNbwLcuVgD8wWpiS8d59bCSrfHJvp+i1uvCiZ4LAe9L2YsJ0IKAPWa
         bgODl75GJed58JVjLMAsxcrJW4mmAdf4jPS7xwTfQSAb2u/Fdxa+EJ7iwHG/trmOnGdx
         WKPOk53WwodXgkDAXNAYr1+B2Hi5XPZ+eExTTaOX9ba28jnXn3lB+Muob9y6Tgk5Xjot
         C5ufAuTs+1Lux+38lnuRynbirN3vSoBtV7OYokAkWVPODSQcUIBY9SMEPT050yc/2IHL
         Mrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810937; x=1747415737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sb8qMdmKzW0Vs+3WIEfP2a2QpfhhnS15MuNPys/cEKk=;
        b=Nb0fjCxIs8Xst+SKUxTiDGOozSPct/nFgBxNgf28VQviCS/VWGDVBoHGTepP2u1YxE
         xrMuS3oOGsAkbDf6H5OPsniiydRJV/beDhXKDdS5m82RFgTHGrHlquNizAEu4q8h+rtu
         +jqh9rGIyqpXt9CuI3YJvCGkJ48Z1DGuTSmd65mLQYhepdx6g5YAbHdhchNmjawFLGWS
         nqLMPlCx2ZF76WY7w0hd3Vuf4nxWvU/AMAXkSEw68RVHEvmz4aXsAjVnB5zXcWJjpoNO
         nvtwjxqvOvVdHKJpa41ZeKP8eZZ78UHGCkE914RFTciF8ulqmx4CbCejHkXFQZfqiXOE
         JIeA==
X-Forwarded-Encrypted: i=1; AJvYcCXrT/0QY9Hb9t+cvBPtpI6ow7vCYKPEAp9l2Q55vA8iFB9SmfREca2SleHfX2suc1eLGB0jaWndwMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrVfq3VdcBCj+7X38yR65+/ji909NoadqvAw19e3PZsddzdTy
	F0BW+VmEA/mB4KyB2mTQKMdr8LtbruXXGFGODaTCOiC8p6d/ilsY
X-Gm-Gg: ASbGncsdmissZsI9pRI/Lbc+TX7moBtMQG2jHssLS5A6VnvhamZmwI69B34bmxc8IAs
	M79Y/6uzV6nKDNv5pqjeiMU//3v5py4epFyz5t/UQI+dFiNbUxyvfHgVShL89wfPQHuKe3dqAKi
	rtHFnEN7hVtxPpMiROw7n5n0aUcUT8ZxUU5d15aLi5ouTH9TDmhmYrIp9VMwLIRSOBGGygmujcH
	mezlMYMXcWrcQoM93FU9lHi9MuinPNqZs8poZvnnxbBbZjGHLA/aEuAuOafsYQ8pQvNEN8BqXd0
	wZVEH+0L7TgOZMfN5IVUzRIVr50AxltBoEwfSTJCy0ULD3Jwhk1rHqGHZap3
X-Google-Smtp-Source: AGHT+IF5oadYCoPgUlpjlbeUIVFBnd19ErB6oR/eBE5TS8Jjz1wBMSi5MsosWt9cUJ9C8YPQsLgtbA==
X-Received: by 2002:a05:600c:1e18:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-442dc95a564mr2609775e9.15.1746810937222;
        Fri, 09 May 2025 10:15:37 -0700 (PDT)
Received: from localhost.localdomain ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d77e4ec3sm21509835e9.1.2025.05.09.10.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:15:36 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH 0/2] iio: fix suspend and resume triggering for bmi160 and bmi270
Date: Fri,  9 May 2025 19:15:24 +0200
Message-ID: <20250509171526.7842-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two imu devices bmi160 and bmi270 are similar to bmi323, with the same bug and
a common usecase: fix the aforementioned bug about triggering not resuming
after sleep in the same way it was solved for the bmi323 device driver.

The bmi270 patch has been tested on a device where the device irq pin
is connected to the CPU ensuring it doesn't cause harm to devices that
do not use hrtimer or other external triggers.

Denis Benato (2):
  iio: bmi270: suspend and resume triggering on relevant pm operations
  iio: bmi160: suspend and resume triggering on relevant pm operations

 drivers/iio/imu/bmi160/bmi160.h      |  2 ++
 drivers/iio/imu/bmi160/bmi160_core.c | 20 ++++++++++++++++++++
 drivers/iio/imu/bmi160/bmi160_i2c.c  |  1 +
 drivers/iio/imu/bmi160/bmi160_spi.c  |  1 +
 drivers/iio/imu/bmi270/bmi270.h      |  2 ++
 drivers/iio/imu/bmi270/bmi270_core.c | 21 +++++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  1 +
 drivers/iio/imu/bmi270/bmi270_spi.c  |  1 +
 8 files changed, 49 insertions(+)

-- 
2.49.0


