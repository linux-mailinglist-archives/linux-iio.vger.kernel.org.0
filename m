Return-Path: <linux-iio+bounces-18575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F097A9982B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 20:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA385A3F45
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF1A280CDC;
	Wed, 23 Apr 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV2gfydA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7351EDA36
	for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434338; cv=none; b=ORKfOy5aSuPm5vjZ85zEFMyLJJZcgQo8mk3kkcXzrYjl7wOg++6miHj0ggYBWYwsO6fxmthdMZmhViBiQYpb1oIbcUues4qfz/UDQZIq95V0Vv672oM1ZwD8CpYv9ZB86IyBb892yWdme9gezFyr4NNRP3XtD57OuMg5MoAAuMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434338; c=relaxed/simple;
	bh=3tXxnPXQGtoOZryZruppihp2/UL8l3MbnO6rIihfPSA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dAFxQb8buxOnLh6QpmTT9tv3Kk80s70f7GeAUPBvCfAwzhSFp6vM64uAVs+6aYM4Ijm5T3RabBqk3eAVLjhghMlR4qXC4KLTYcifLhs9ZEJ9CfoHo9zAsZwwholnPcdR4Iv3tNE5q68Dd9ud4PnmgRRyg3W3yEfR1tiYErVaNOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV2gfydA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7373aa99e2cso18097b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745434335; x=1746039135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZQ6vTZen9ayn9Yxy7erD9jm7aNIS8UJZG7WqauCLYg=;
        b=XV2gfydAG+GqA/dNx/GMA3RqZunWIrEkN2stEFmI9ZZ0uHOFJ6PMWKvWDSb95dOkGm
         55/KSpvl3VhNWVDbyQZIbqz+KgdMy1DpJ3h45lFBhZclm2Vm+jio07Nqm+lk1uFPDbKs
         1aR9JCogCm8TkXjeC4bJTMyHosA65g3X1dXkiMkdAjkC1kUay4RanMQbLnAfm9hf7WIb
         A/FlCAnZh6ArDcla6YwZJI76WXmh9Go32HwC107tDywrS0u16wYO4QHFv8YM9U2CF6II
         8T2TxXxgkB7sfMkCkG8CB4F2y8O/9sjCZiutS15yN2yiNt0c41yxwGjiXkeeYhkWPj9t
         cgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745434335; x=1746039135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZQ6vTZen9ayn9Yxy7erD9jm7aNIS8UJZG7WqauCLYg=;
        b=HasnZSEjk2Uc1LKw7CO/zTaZSw024vdWyAXTcKMkS1excsGR9MMX6ndCK2iepFMj2X
         dzYvGeulwypEigZqpUA73moHk8UIW1qh3tADJIBFDcVEKm9wiTYvML9M9o9bpZB2l/Pg
         99Fe3Mur0QWgnMH84KkExG/sbpF5XsklkzMyRpLiDbmJZkuiTo1TXodyeKu738+6UiDq
         uVCiYQ+M2k+bsGO+yiDo7To7yOq2dmvOtKZSYH4IeOmYX5c1pTz5Uhuh8J/4yCZ6jYGF
         0nItAVVS8PYQxdzJNP1CwroS9Jzq0CLoQ5KvfYfFC0GxTdnUtJPOGRYRCoC+OgPIW53J
         fiHA==
X-Gm-Message-State: AOJu0YyobYDQSzFZs5VxE8mSUgHSLK4z9fSkgz06kdsIIpLKEsMmyd//
	k/OreLntduQilTZdXQ1pbG2egu9/K+Amwr/acgLrWn3e4BRdtVIYT8i1PUCT
X-Gm-Gg: ASbGncviUP4TscGMGK9AH9KT2LZUXUT6y7Ax4J9fwFMT24+YmF51EOKWNJVxjYqJRFz
	CU/Ufa5o7DV8kYJcMQFiUg41y/kSJD0b31akgnzFObMnBsOAnJy0lqirFmZUjo+tvJcZnuOAxhU
	jJwVnLEe7nKLOUQF7lujVQhlLBUFs5sr8VoY/JeUg4XjYhrBMA2QvsvKI7mXf/1q6RZeIhjUMul
	mkUjswBTtvgVmYJK//z3R92wQqe/8lxrbTNKWcIP/IPn+iqT6j/od4IXeuM2UeKtlwh+vIs8pGb
	IPaFtRtcXfaopCkL5CkmPrsTPRW+80SNGv2HYwBayk3FB3HhfFgNrDrEuWk=
X-Google-Smtp-Source: AGHT+IEardD3d2Mg7KLC2VZEXKDrJKbX+G3ZeFc7Y/nj93f3gAqY+wXP4f3zDfzPnA5aT4+qHKXI8A==
X-Received: by 2002:a05:6a00:4ac6:b0:730:8526:5db2 with SMTP id d2e1a72fcca58-73e1175a8cfmr2068947b3a.5.1745434335030;
        Wed, 23 Apr 2025 11:52:15 -0700 (PDT)
Received: from arthur.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa588d4sm11343294b3a.96.2025.04.23.11.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:52:14 -0700 (PDT)
From: Arthur-Prince <r2.arthur.prince@gmail.com>
To: linux-iio@vger.kernel.org,
	arthur.prince@ime.usp.br
Subject: [PATCH 0/2] iio: adc: ti-ads1298 & Kconfig
Date: Wed, 23 Apr 2025 15:46:24 -0300
Message-ID: <20250423185208.752080-1-r2.arthur.prince@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These patches improve the ti-ads1298 driver in two ways:

1- Safe usage guarantee for device communication
  Wrap calls to ads1298_reg_access() and ads1298_write_raw()
  with iio_device_claim_direct() / iio_device_release_direct()
  so that configuration operations cannot interrupt an ongoing
  buffered capture.

2- Add kfifo dependency for module compilation 
  The driver now selects CONFIG_IIO_KFIFO_BUFFER in its Kconfig,
  just like other IIO ADC drivers, to ensure the kfifo buffer
  API is available when building ti-ads1298 as a module.

Arthur-Prince (2):
  iio: adc: ti-ads1298
  iio: adc: Kconfig

 drivers/iio/adc/Kconfig      |  1 +
 drivers/iio/adc/ti-ads1298.c | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.45.2


