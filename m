Return-Path: <linux-iio+bounces-12344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A76379D0503
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BEC281847
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB51DB361;
	Sun, 17 Nov 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6e0xhb8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C5192D97;
	Sun, 17 Nov 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868097; cv=none; b=KvSUOTTlq36fPk06uoe/1YNyGfeY75LATv0iiT3y9Uhv0Y7FX5p5BaCP5EYlL3+HE+VBb2Gjr01Q3Mo9VpiHx5p32XeiUHG0U5Gc9bZeQk8nwAaD0YN3F+GjRmK80AbDXnSBEGbFoBgJoZD18rLG8FSdisXyhwRepuu+XQcZfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868097; c=relaxed/simple;
	bh=zC4utrncVmy2RjXFLmrGKa3KsfHnCdq9j5x5pTqoYks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwSqPyO7ct0T0/ZF2j1ejTVxSPGwtvfvVol/PmxvqVk1/oNB/X7n6DeaaQBGRnX0uuW16oFTwRBnrsyifEoD/cHn1z/s0ZU5JZIps1VNsTJz+cQuel4U5PksictBSBQpVnLzrN3yWpr9deYGDYR6IPyxwp1pI+W+C7mXshlQZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6e0xhb8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431506d4f3bso1869395e9.0;
        Sun, 17 Nov 2024 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868095; x=1732472895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWdIbNe2zK4K5n6rJj1IjwHyeU7rCXgoeLdzNBBqx9M=;
        b=i6e0xhb8WN8PvNYBfvYdbFMwhHfFNvO3MAqb7zBny6kO2NN+aQHsDUM062Nnkx5F9D
         00YSUeFjaarF39EDexnC+aEdVtph3N54xtb2Jm2FYNCAyPM0DiN/dqehEOYfKgojYVGG
         P4q4pegi8i9yqTX2KXovnlj4QRMlq6iDvcEvESAzXI97+QDggQPrnR/DxKO/pFA29fG/
         CBDF0LdKVNOixyi04dgEDwtbUHjUtOOhiqWvgD2Ek0PrZgZDFx5w2a+25efJ9QkwZ09/
         HMUX/n6mlG507OZeCa3lAu9mrg+z1gpRAU4ZZC6fBNnDyhQiAqUM4rDYTFDGajjAzF1x
         LmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868095; x=1732472895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWdIbNe2zK4K5n6rJj1IjwHyeU7rCXgoeLdzNBBqx9M=;
        b=aXEL/egzqwjpiHkFdpJnERqLik3FwKxgoyGNNHTAzhGciV0fv+XYKxG04CROba9ce/
         oE+kBU/xBtenjrs/Jm3Xp/XS9XVdVjQV6mUYF3Shw1DPs9dHrtBlSUjtCd+hbUpmTmp0
         GyAv3ZlAYsw7lpoNolDNcYHFt3q2RuMtzBgCNGEwB0jIuNsUD5YdmXRbAPwSSWPfXRt4
         0SSmEutPXfdFYWvoCmEaZ+7dSbafDDYe3u66wNf3xXbv42WeRAn+42/VmqzREQIlgyUe
         En2zikwYvQ/9YGRT+IMJ+ziNmupV0yIdppTXc9h27/5FvVcB7WFma2v07aNvb4YSu89P
         T6qw==
X-Forwarded-Encrypted: i=1; AJvYcCUFwp0lYRo4eoU6dKbiY9bNr5C9GiNs0VmZVkecLtiPWgDcOOL2hrsc8wvu3eNLNVsF7EG0xtDyIxG6pFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkQCW9ltOoXPlf3E40hYMyQHK5039+YrYtCnWQpBL00x7Jix6
	FlTEmazO4QSOULcc+0V7fxV0qFW1rkCDbnHgT3hv3wXvpmnJ3b5p
X-Google-Smtp-Source: AGHT+IFZSuPt4H7aJw432ypeU7GFKezwcXsxnc4bbaFuG0+EoY5pM+xNG77ehGwKDBv0nq1Ukm3qaw==
X-Received: by 2002:a5d:5f93:0:b0:37c:c815:a204 with SMTP id ffacd0b85a97d-382258ec38fmr2753762f8f.3.1731868094646;
        Sun, 17 Nov 2024 10:28:14 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:14 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 01/22] iio: accel: adxl345: fix comment on probe
Date: Sun, 17 Nov 2024 18:26:30 +0000
Message-Id: <20241117182651.115056-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix comment on the probe function. Add covered sensors and fix typo.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 006ce66c0a..d121caf839 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -170,7 +170,7 @@ static void adxl345_powerdown(void *regmap)
 
 /**
  * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
- *                        also covers the adlx375 accelerometer
+ *                        also covers the adxl375 and adxl346 accelerometer
  * @dev:	Driver model representation of the device
  * @regmap:	Regmap instance for the device
  * @setup:	Setup routine to be executed right before the standard device
-- 
2.39.5


