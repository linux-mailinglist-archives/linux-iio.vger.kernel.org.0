Return-Path: <linux-iio+bounces-7868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F112493B9C8
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 02:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EEB1C212F2
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82467187F;
	Thu, 25 Jul 2024 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMCh7kER"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF397380;
	Thu, 25 Jul 2024 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867242; cv=none; b=Fntf9YyWRkK99AhsHDC15dUrmU6gQKIHXif9wJVeUSgwWYQoTwz9H8VFYtB6h9IeIrNUkCKDGWBCawPvyaulLOBLU6DoCQ9xgFTBskIIL3j6Jd7XQzDWYWN5GTYhxfuPsQ68XdC8hlIR0AIvy2/v5E9S2ObIOdkPK/XF4nuf+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867242; c=relaxed/simple;
	bh=X0FCPVZtCuFs4HYv/jjstlWhs9UzJeTvpu8p1eCSiuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8+BY3E5/xQVZFmCsv/s6siuYwVvmLIccwvH+bm34VXr/m/xOTfLQ5NgiUurj3Smj1Bj+c7sci0tZhm9eD8eM3ojtIuEKouBzhpZCjI9JUxfnzkjS0dEQUlopjvFXw9LncrCQ96vM0Vt9+JLks0fex1CoWoiZ9B2Kv0UOgcyF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMCh7kER; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3686b554cfcso129337f8f.1;
        Wed, 24 Jul 2024 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721867239; x=1722472039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHOOlqghC4jISaVlTlYiD3C9Z0SxPztgr6a6M+wMqbo=;
        b=SMCh7kERHo3s/S27BZid6wfHP6jcyriI/qtEUtHipAFscqlVSoICNGP7VJ4RrjO4zw
         R1tXCasZw1cFeCmSy0f1/zlgDlD+r08QUaiIEFZq/obiZlDd5t8MR0d/BF9QRsljcfD+
         r7fZYV2YQ54QaBW805agnIjP+lwugWx9NR93qWyobqQpnOln+ONKeG31GZQQA1Cqnkbw
         VVv83bOnIpn/BAzTiQVH+Zcx0vEt0jEc9ZhV2uor+3Gq1vLiGuI1QKusvGEyOrbBSJva
         5wBNamgvve/ZLHbPpzesAsWJ9f2ueChDBpcjLU0JsLoqpPhGlo8njIhhlwSQ6cuCcFtM
         dLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721867239; x=1722472039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHOOlqghC4jISaVlTlYiD3C9Z0SxPztgr6a6M+wMqbo=;
        b=XvLfGDhCxnS90i27Lt9rYGOUesqrPuwMAiOmyaPy1NsDhgHy+G+YsFUKvE7e0oopXN
         3dX0krJTLVfZTwsukXCrAXpOPpgtEUT5+kPFvU62gSg6AMc03Ynf8PSgEVTLaz9H42lq
         HMxJChwyqVtEWS4mg184UfvA73bAN7MVLGoxDXmswkHYUcb5skHFH9jwCOxOEXEn4uo/
         OFw00VCnqQ1A4SwqGx4auUAxQucHRq5h4iaXkg8OwKcOse+kXXTkquYYu9Ugu83Q0Bxx
         SPtf9U2lWwbebQhT0cCKe3AGpnUJMuC5RY8GYfybpEn2uTtnqBq67Xly8fUvc6Djlzt5
         FZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2NkgEX0FanVxC4sCaCRvxQbpLgjEmHYa3Q0de5rKzSLloN/dOAzlTSxSHpv+UdV44xh/oqCtbwe7VvojEaSkD/MTZraC0d47XT6GKF7avfPYbWZlGZDw48iTvvsWAzCZGIXdT2mUk
X-Gm-Message-State: AOJu0YzpUE6sVGuM8zrAh5tIZYdFKE6Isri69COhJJ0nheOqmUlbqlDw
	0y05yWhoWSsSiJxAU2AQtyGdUYOKlmvAbjUjaVC1Q5YqHSMUjvLM
X-Google-Smtp-Source: AGHT+IE/9WHCEwC25kBIwN6ZiQK6z1ZmEUfh25/F8CdLoY0KtA2guCBHHmr+XrVKcTv4xSBx6QfHKg==
X-Received: by 2002:adf:e30b:0:b0:368:87ca:3d85 with SMTP id ffacd0b85a97d-36b319f99d4mr752576f8f.29.1721867238844;
        Wed, 24 Jul 2024 17:27:18 -0700 (PDT)
Received: from localhost.localdomain ([151.49.92.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b0e8sm8233605e9.26.2024.07.24.17.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 17:27:18 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH 0/2] iio: fix bug with triggers not resuming after sleep
Date: Thu, 25 Jul 2024 02:26:39 +0200
Message-ID: <20240725002641.191509-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device enters an idle state (for example ASUS RC71L with s2idle)
and an iio driver has a trigger attached such as iio-trig-hrtimer,
after resuming the device the trigger is not triggering data acquisition.

This patch series solves the problem reliably and is well tested after
many cycles and many reboots.

Closes: https://lore.kernel.org/all/31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com/

Denis Benato (2):
  iio: trigger: allow devices to suspend/resume theirs associated
    trigger
  iio: bmi323: suspend and resume triggering on relevant pm operations

 drivers/iio/imu/bmi323/bmi323.h      |  1 +
 drivers/iio/imu/bmi323/bmi323_core.c | 32 ++++++++++++++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
 drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
 drivers/iio/industrialio-trigger.c   | 24 +++++++++++++++++++++
 include/linux/iio/iio.h              | 16 ++++++++++++++
 6 files changed, 75 insertions(+)

-- 
2.45.2


