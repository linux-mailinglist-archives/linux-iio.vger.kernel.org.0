Return-Path: <linux-iio+bounces-20038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B1AC9185
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E423A3687
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D820AF98;
	Fri, 30 May 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V1bBNXR2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD5230BEE
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748615371; cv=none; b=qErOhxfoK9TG1fDzT6zUL42mxsmtXYPooyWkEgmigQZaH9O6Qkg5iiYUSJJIXHgsHOOGy8jN5hv9nHBGSXrXafBn8PCaRha0OU4V9pUAXZEgxiedAQqMpb7yu1iIsU0gCOj+BemfA2mXEL//k+c8mVfBS2siR07IL2psmmf8fOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748615371; c=relaxed/simple;
	bh=rIK3waljLR/fjrG3pLbMe1YHZ8NPs75JNeBxI+CrkHo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MvRdh4XlhU0fJSfaUkQpMKbCwEhJO7uNARqKLC2wYahCYczb550dEAcZKN+pXwbYKQOrbKxROBvOBdIDLnY47GHb0aStfLmxtmY0v9HClIpkTo21HssjQB0ewDz1FHihhLpLB4q9HpETAZbQE7wplCJOHQaB9cxQGNBze3zFUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V1bBNXR2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a36e090102so1187543f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748615367; x=1749220167; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fry8EoRGYXADxHvT9pFJrNSVR8dhwD8t+hXmtglUTHo=;
        b=V1bBNXR2XuOVKTXFQNzJRExkF5KAQ8nO5bhgMOY9Jo3aWfmNA1TQ9C8QW6+5QMRdxM
         PJOUWI6ogmP9vUEXSUWD1IC7bHvetnjZZW8BOV/ocWOubuhZPGShifOUC68BHEyN86rX
         4choYtWVpaJqsqDmePCCQgKkhR9VPtxqKhtXlNBS4WAtu/Yh176hYyK+g+KaO3wqgWsH
         4SdPcYczWgg19daKZXzPU2cCGLv2Tl03BQCFg5pxY7oplhQaQV06bxyFeMit+aI9qaTe
         LpG2Z37vQ0vGLZOOutk1sw3sROqZX1iCAlyKvkEmTmd8uamKylSM1zDRc0iAmsmI6Khg
         V74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748615367; x=1749220167;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fry8EoRGYXADxHvT9pFJrNSVR8dhwD8t+hXmtglUTHo=;
        b=Lc44twXlPkb8IayIiwSMWf6yJ8mSYQC1mixdFhRpvvUIkw1MgxfxC7AnxMPiOiIujn
         NKS0mr6MiYhXwBkQsD2NwF+JLOn68Ic6mB9gyfXC4tMmJiukhCyBDQ65zxqx0g0RFC7D
         hGh52xWLlVOKADvS1e5hXxvYXs4UUAn2ZbpMnwmOJOdEoS3zeRc0ztzig+TB/wof/Wkr
         aPctyTe7L8theqMcMJe52H6KCprbJVlrzfLKMGWBhtKyo4sWeHeCGqd2ToFpDIQK0L61
         FGyKSxlplu90JamY0QZCjJfdMNiHJnQ2jyVQ++3iLeolWzOZGVnS9Tg4CXQZHOeU4ssW
         ep7Q==
X-Gm-Message-State: AOJu0Yx2hMbsJUpjej0UwO8yOHAzrBlWNOMBOHHhdT9lts9FY7H5OuaN
	taFkiUfFJQ9sTZyXBE6b2Ey76Ww3WlqOac80hzqf/z7uIXxshIQEsQZGwc8POjLbkTs=
X-Gm-Gg: ASbGncuj+UAKD/WerAZDJO4XZ+7QDtgTd0ojj8is7ySxcrBLkeoWG0CB4CBGfXszHg2
	A2sa/btqq75Pu5NTS9ClXPHVcxEyx9JHXQzuujwXNqIBjcXYqWjtHAiXHzcUiXbjrlCxbjRhAPG
	+pMyLi5w2rBKza0ZWZEBTNyDLV4gEaCTNB3OkR6HofN46qoF2LhjK4uiRqq6amIlhgCcg6+JKq7
	xctyz70R3PgC4dcqATlDkQnSEh7xzzqML9kYBSwQ75+uXiv6yI/SpjtD24qDM20l10CMhFckUfn
	rDYEDlmDv5N9HpJAv9lIuqOCGi4kybMWnMpKRbHfU4NW2sJcFvr2ahhj8qn162nbQ52VMguAecW
	RagDiWqbrezOCMZDuoJmfKq9Aa/4wELE=
X-Google-Smtp-Source: AGHT+IFyD1vZ35wqGpI6Aklg8LYxAbef6kulzWJMlMm0iEgURUY6T4yiqBz7bO5ajBNrPSUXmDGzvA==
X-Received: by 2002:a05:6000:25ca:b0:3a4:df80:7284 with SMTP id ffacd0b85a97d-3a4f7a0234fmr2964955f8f.1.1748615367604;
        Fri, 30 May 2025 07:29:27 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a0421sm4979870f8f.97.2025.05.30.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 07:29:27 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v2 0/2] iio: adc: ad7606: enable Vdrive and Vrefin power
 supply voltages
Date: Fri, 30 May 2025 16:27:55 +0200
Message-Id: <20250530-wip-bl-ad7606-reference-voltages-v2-0-d5e1ad7e6f14@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGvAOWgC/5WNQQ6CMBBFr0K6dkw7kSquvIdh0ZYpTIKUtKRKC
 He3cgOX7+fnvU0kikxJ3KtNRMqcOEwF8FQJN5ipJ+CusECJtayxgTfPYEcw3VVLDZE8RZocQQ7
 jYnpKgNpfmhplp9CJopnLhz9H4tkWHjgtIa5HMavf+oc8K5DQ2JtXmrz0KB/WrCPbSGcXXqLd9
 /0LL0Cvj9MAAAA=
X-Change-ID: 20250529-wip-bl-ad7606-reference-voltages-26f49520d12c
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=806;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=rIK3waljLR/fjrG3pLbMe1YHZ8NPs75JNeBxI+CrkHo=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiwPJDvd0WwoMIzeuafY5k+D/P8ZR78ZzR+r7+zZFOoo
 ++Xr16zO0pZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAExkii8jw5JOziX9lc0Oyxx9
 Hy4uiD0XtdjD1qjT9cbdXLvarStnbGT4nysVlJ5nHll99HPZuTMLPoiH6j8LW31HaRKHk7KSSHo
 7IwA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Enable Vdrive and Vrefin power supply voltages. Related fdt properties
are already defined in ad7606 dt_schema.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- fix "ret < 0" as just "ret",
- set more appropriate error message.
- Link to v1: https://lore.kernel.org/r/20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com

---
Angelo Dureghello (2):
      iio: adc: ad7606: enable Vdrive power supply
      iio: adc: ad7606: add enabling of optional Vrefin voltage

 drivers/iio/adc/ad7606.c | 10 ++++++++++
 1 file changed, 10 insertions(+)
---
base-commit: aa1b3efb8425b572d67df2f5d47ee4ed25571428
change-id: 20250529-wip-bl-ad7606-reference-voltages-26f49520d12c

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


