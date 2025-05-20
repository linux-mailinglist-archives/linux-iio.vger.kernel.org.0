Return-Path: <linux-iio+bounces-19751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92166ABE788
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1C71B68048
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4909261398;
	Tue, 20 May 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A81UsbPW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68125F985;
	Tue, 20 May 2025 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781444; cv=none; b=SP6mOvMKF+jumD2Ty2XZ+TlYGGYvcS6xNIpCpg/u9Akbgpnvpy8E6ARKe9upRQvS9reZSyLrAsd/9e0VqZGTOcmmhooERMPKkPnDZX6Ng/IQKEPbbvKhlvnCSb91dU4RXt+G0oALSP/hn0hJ/e5pV4bMZg3ivTbR5nEvk67T2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781444; c=relaxed/simple;
	bh=R9SpEhuEyq4ehpvwcZNQlf9/1GWukf4Pqc+Kz3sbR5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKGc6u/jndorGvV6ZaRycSxPR4po7BfGv9EEZZPWvaZLtAIXZBiTg5KH2bu0D3rNL2Obp7E7SCcb4KOTDW4BNUDJY3eTB5pwS+3j2RblzmDvkgYo3PJOry+4xUm/S5/7mon1/metI5Wm1+UOx9Rmn2iP+h4Wg267RUllspXRhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A81UsbPW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a361c8a830so690385f8f.0;
        Tue, 20 May 2025 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781440; x=1748386240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDb8HOZ4Hp1UhkfaoOAEXCBy8LyAOlXzYwG5CU8w1+M=;
        b=A81UsbPWUjJ6yXvlX8rT5FcYo67hqfkpJPYMUydzmvhIW1EOpuNZActImW7p4LNvnl
         wkX2sly8zABHMpwUa70xo0ZXoaFzGBMO5e+gXvvjoNUW49s9/C2MQH+rl8zTyZZLVCz8
         XSG1XtbMLFNr+ZixwZ9It0inUX6JlJ/+Wg0HWETOYAWPlGdHaHjKmB5wBwILwhP7x/go
         5LmM/oL6Z1I+a3lep+IXL/GZwQalPJMthyhNnfnCcsCMOoHFyXEpB3uYtYvIYMfZ+S/L
         puzdOQb6gTbB+5HHQsH2ZM0hfF6kQ5ky37lKC4lJZY77LytC/948TEFHE/QzNdvbyNwH
         yIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781440; x=1748386240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDb8HOZ4Hp1UhkfaoOAEXCBy8LyAOlXzYwG5CU8w1+M=;
        b=LBOD8VPhcLnFufhCXqrOIvpBqs390M/f3cUZ1MMx7lTmj5aGlAdGvC4ynPDkh3Eg2F
         O7FwPMSek8pL5W+mhWSPh1FDbgsp7rJvg//9H/5sS3okd8/FzFBn+N9JRGznzgFn2+67
         /IqnpmjQdhfKs0Lc8hVO4Zys4DLZRTmbdne3Y3BxwKi96+QJnrgK4yeni0hk3kWWPCAN
         SssIkllkMzxv/CdZkmPrw+RiV1q/2wYyFZUjFG08cWMV6lyKauwKU5lmt/qjB9KcFGpT
         EG9rEsKcUi6d7YHUqitLccjFp0QuxZI8T+EOXRNUf1U8I3VoSD4xSVc7WiHehFXu993X
         q2gg==
X-Forwarded-Encrypted: i=1; AJvYcCUBOuB4rpCQHPNELX1lNlqYtV60F9iUVSgsQi8OnO4OFRS9KblZ4bTPe0lSq6snH8BvTg29MFl2Gy1ZTa4E@vger.kernel.org, AJvYcCVW7aXqcXIRt3MTMh4XahXqRb7OCjiMWg4iaff5yEBX5pCHx5++4a6SPExgkg/BTD5cQYALwa9Yl2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fy+C0qfMCB1VHDAmrzRS/yzlRx5aAxDAREPSlVMpewKWCa0s
	7/88A+EBVnR+cvLWIfuOEK5lZSFJqFs3g3FHNfvGjkH1/XxIsFaU7Xrg
X-Gm-Gg: ASbGncvCgD3IVFtX3rbBu90iv3ER4DlRqZqGO4/nHtKp4gZS7H58PFGl8okr4NjzRG1
	jTH5+DJX1K8Wk3I/GWVoWOXWPXP+7G2bJHMWcKd22gkbE4J84sL57YRAj/xg2r/RiNVp9xMlUfE
	/WufJ/R9/h6SEhN9DWmcaAGrxU85BPxZibhYAchYzfhIJX6PBLALvwUL8ns/trjofgnHgQwKJeP
	R8799+y5tDKNIs7anx8ISraVefnYUArwjieu2NKgz3o1mhqC3IPWmU/TO+9JdMK8t3EGHzKqBiz
	xMZjZNZgSJXYzQ6rwMcl82/61oh2QUTbO7rcgoTOSe/QSkt5ziqRs8Uu6pHJqAOKLAZTeuOCKQN
	FjBpMIz/pYVnUC8k8KzZvWw==
X-Google-Smtp-Source: AGHT+IHV4sm7LtB7vdkmiyhCJ33unQ+STkXBhqjxAxUwxdCeZsz//2+ZcF69VpUB1XIwk3uS0+4C3g==
X-Received: by 2002:a05:6000:3105:b0:3a3:64c2:2a7f with SMTP id ffacd0b85a97d-3a364c22bdemr4304370f8f.13.1747781440083;
        Tue, 20 May 2025 15:50:40 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:39 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] iio: accel: adxl313: configure scan type for buffer
Date: Tue, 20 May 2025 22:49:58 +0000
Message-Id: <20250520225007.10990-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet the ADXL313 uses 13 bit in full resolution.
Also, add signedness, storage bits and endianness.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 9c2f3af1d19f..06a771bb4726 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -184,7 +184,10 @@ static const int adxl313_odr_freqs[][2] = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 	.scan_type = {							\
+		.sign = 's',						\
 		.realbits = 13,						\
+		.storagebits = 16,					\
+		.endianness = IIO_BE,					\
 	},								\
 }
 
-- 
2.39.5


