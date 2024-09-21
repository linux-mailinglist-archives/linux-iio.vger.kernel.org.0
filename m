Return-Path: <linux-iio+bounces-9688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70A97DE30
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 20:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD63281938
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD83BBC9;
	Sat, 21 Sep 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b87OQNtV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491AB22094;
	Sat, 21 Sep 2024 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726942786; cv=none; b=at+lDvP9LBt9bu/RgKFK6abn3VFkqJsrI3k3l7s00M3G0Xxq2OT9VzqeVFfVQV414G2bB356iI13cuzrOhzV+5DrItPatYhQ/i2TPLoRNlcqrO5Ffb+0r7UxASVIN+NCpDtbG7ZKMAReI0f9pKKOJ92hEkkwhnyGiwQvhp4T7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726942786; c=relaxed/simple;
	bh=n27z0DnHIFfJycMWyxN6FAn3FGH1Na0hB7rbknKyaoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iDRNUP/bNax+CTvD6CDYZH9drJfPrfakKitVp0JeMjgUdoCv7W3JHWcFscjye/5IKuf8x12+vxAQmu05sUD3Zz8HsTo9Q7HmGdNABqebtKgFZ58/E0YsysdadHJQi2su68j3PsSwruJiKKHm6tXVd5CZGWDhYVFu3VHuNaxCKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b87OQNtV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374ba78f192so2175260f8f.3;
        Sat, 21 Sep 2024 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726942783; x=1727547583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JojyhQ3fYOdqSpKMhCmdlD5PTsSHxTGAINvavedYBTs=;
        b=b87OQNtVr+sPWiMu3MYj6E3WNpcvxkqad8dDnclPKaUQ2cVE1TPTXAFNszWJ70Jxe+
         zdEGKxXDhDgBiUB5zP722Lz0equqkBVs9gaFLjcB4yqcL0iVCKKpx6rhi/oC/E+ObSSn
         vXW05JDLPUNocHOLtEI96GGSiKNOBra9973G/Z/Z3QCA3BtzFO8nQwA12WzVgzIcekEg
         89LbJMCFrDrlg1BjwiPbQ2GMEEnLcFxJvHq1Jvj2q6BuFUMsaMR4ISS5zi1xg8jmf6j5
         U1oz0MeBx8Nm9oVZSYWchmBGDzgJdElnH4tDrrfEbiAsehxBlflCF7pp3UjILwYSTE4d
         7CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726942783; x=1727547583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JojyhQ3fYOdqSpKMhCmdlD5PTsSHxTGAINvavedYBTs=;
        b=URxLyjrMzuarBoWgYJAIBBGlgN+rhq7+x3MvyupydyQWWx2M166ZuhoMUDjGO0qX6F
         Rt8Wwpmyfd4YqfY/iUn2LtU+eQXstyRx4Q7ZaWUMGTgghY/LFmgnnRIo8Hdil/jYB0fA
         5xKfVL890hDLgo1y/079kNW1fvdAq10uqx8wmvuzR7PjGRhWzYk9r7jqs6s8/4UYnjnb
         HU4rCChEboqYOVeYbauwalofwOxWe/E3Ab73/t1dEKePb9gVwGedzvjyTuJB/WVMzeKD
         E+LoENdTvd0ZSzjt8utAMi+x0a5RM7z3X1TG92ykWQtWnHQmDnutw3215S51zKIcZrh8
         Zx7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9p9ZPCOgy34P3MXEV4gu91LeZ5FrMeB166Tmom1tiX1MhMe66bNHDEYZpX8SxnEOM+b28KyLnw4tFeN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqdSNskSyOnfvIHcg4bhM3QxScPlHwDup4MlGyo2DbhXD2DMe
	PypaA5JEQ5lJNkS56ZWDqIek5TVlHe1jychmtWGbQbIvjBf5wLVA/982gw==
X-Google-Smtp-Source: AGHT+IE7xcIOqj9n6vZzv6Rj6uWbpRCttQv2LmHQkyZdEjhBmIyJYZlioSd7bPHny8IN9SlIC6WvaQ==
X-Received: by 2002:adf:ea46:0:b0:377:205f:c494 with SMTP id ffacd0b85a97d-37a4312b321mr3619871f8f.11.1726942783291;
        Sat, 21 Sep 2024 11:19:43 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a498:414b:b435:bfeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afa9c93sm55494315e9.18.2024.09.21.11.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:19:42 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	mazziesaccount@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 0/2] iio: core: remove iio_validate_own_trigger() function
Date: Sat, 21 Sep 2024 20:19:37 +0200
Message-Id: <20240921181939.392517-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iio_validate_own_trigger() function was added in this commit [1] but it is
the same with the below function called iio_trigger_validate_own_device(). The
bodies of the functions can be found in [2], [3].

[1]: https://lore.kernel.org/all/51cd3e3e74a6addf8d333f4a109fb9c5a11086ee.1683541225.git.mazziesaccount@gmail.com/
[2]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L732
[3]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L752

Vasileios Amoiridis (2):
  iio: Drop usage of iio_validate_own_trigger
  iio: remove iio_validate_own_trigger completely

 drivers/iio/accel/kionix-kx022a.c  |  2 +-
 drivers/iio/industrialio-trigger.c | 22 +---------------------
 drivers/iio/light/rohm-bu27008.c   |  2 +-
 include/linux/iio/trigger.h        |  1 -
 4 files changed, 3 insertions(+), 24 deletions(-)


base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
-- 
2.25.1


