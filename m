Return-Path: <linux-iio+bounces-11862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AC59BA4AF
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1437C1F21B9F
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0132015CD58;
	Sun,  3 Nov 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQzb73Vb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA0157A6B;
	Sun,  3 Nov 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730623416; cv=none; b=iKw0/P34xJKxA0rpKQIBaP7HNLb/L9pg/bn9a0cG2njmqfcD73sUKXTlR9PCNSnbNdF+7U0ODeSE8aycrw1fzDtvyUVl1O6UsKWCv86ItMTmV0VPznj9/MTgYJuxOn2LOhRjBXhnjZzKiAkcuWwjUiF8v5mX9/4I6M9WXeJIdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730623416; c=relaxed/simple;
	bh=a/cmqIv9J+CIlsXjQ/M3RlCzaHc6gd/T0Qs5c74O8WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nCouGrJmD52bId8b3HCO0zV50x2C7jM455FD6ToFSasv9JW8dgAEWSXM8k1/gADo+KhIukwx7lXJqDmnWh8IZf5ECYvEhp5524i7nYOURqx+p8jo0CXMmX4L1jLxMUohXU9uE5dAp3a0qsJ3XZX/OF/jDttny5rP6JkJkzsTAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQzb73Vb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e5a62031aso2633274b3a.1;
        Sun, 03 Nov 2024 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730623414; x=1731228214; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTtBF+9uenBZOaczAv7wGAXHHda9ViVLcZTuZqWNs70=;
        b=lQzb73VbRerX0niSCqVLZPfEhW8Pu1X7ZIpLMtjkceY7z1p/abG+MGIETEAA2+AVk4
         JAO3xpZmD1VAreJE4LKhRB6m23UnuvIwiiWgfns7tRWljfiXyqLy3LzyFyUiFVmgXNp3
         qq+JM2Wr7fjhVJh/gOtf1DGYuOUmOYs6APVRjrk57Z4CgyuBWoZhBCvj+KsNxXDKpj1D
         vNLIlSWLBVgxi+U1wLWuxVNGdrLYSPXjiq//lC2/RETmYVo+kfPb9G3DcnCOndpDxIlQ
         jL1iuj7QoIxdZnNHlWvU49P7NFD4zWNJviV3UJqNv9+3JQ1kbl0pB0nAE2POjndzBJEQ
         gLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730623414; x=1731228214;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTtBF+9uenBZOaczAv7wGAXHHda9ViVLcZTuZqWNs70=;
        b=h8Zhv9r3WpmKiYq3lVRDwJ+kCrv3GNkHt5LRo0wljO/WLVB/mI/YE9mikFMRsvQV53
         ZNP0/j9AXaqQtQPVyloB3t5dZKE51scyRBUBvqiXznEibIyJcauC/t3sy5r5lGugt39g
         UQdoGmkurKC9RNKyQQkkEG9lXYI6oILMPPn554REunNhgvQy1PwacrqRNry9L9xhzr0c
         ZTg04q+d83GevH9O2Ux1HINy8nl3YL0sxDvJFW9Oo3CnMUwsYeFxXuv/RB7itlPh4+mt
         2a4RMu0u94fwG4fIr3X+KFEltQ9C2Quyww9xaCct5pIr8fr/TB+N3GnfodNmbp974U7/
         8omw==
X-Forwarded-Encrypted: i=1; AJvYcCVUw4PnMVprR+xgG6ELGgwElXGYGsXkXrePGZUM4TCU7SOcywPdHVoVYOfAYg2UXSoZ8w5E3bioFnMeXXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gjd2MAaeEw8BkHDMUvRy4OqodRSxGZmEbnwWETmeluhMJuUB
	r4qX0GqNVjIto5JyIl4pQiT0NVjH7mN5/ALxSvUrCOM8c1ptt3PZ
X-Google-Smtp-Source: AGHT+IEyGCLFrdMwbpxOaqH066ljvRu/MIKcanqDBSRs2mVGPrwVa+UexAYZ6aBkzFGGuolwTnSt3w==
X-Received: by 2002:a05:6a20:cd0e:b0:1d9:4639:396b with SMTP id adf61e73a8af0-1dba5343744mr14684919637.11.1730623414435;
        Sun, 03 Nov 2024 01:43:34 -0700 (PDT)
Received: from Emma ([2401:4900:1c20:13d0:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f922dsm4968986a12.68.2024.11.03.01.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:43:33 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Sun, 03 Nov 2024 08:43:14 +0000
Subject: [PATCH] iio: invensense: fix integer overflow while multiplication
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241103-coverity1586045integeroverflow-v1-1-43ea37a3f3cd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKE3J2cC/x2N2wqFIBBFfyXmOUFN69SvRA9lYw0cNDS6EP171
 uPasPa6IGIgjNBkFwTcKJJ3CUSegZl7NyGjMTFILpUQXDLjt2Ssp9C/kitNbsUJwzvav9+ZGQZ
 b6EpVeqwhnSwBLR1foO3u+wE0IW41cAAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, Anup <anupnewsmail@gmail.com>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730623411; l=1223;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=a/cmqIv9J+CIlsXjQ/M3RlCzaHc6gd/T0Qs5c74O8WI=;
 b=4pbD0Bpo2rbd2IpAn9rFZPWQLxZLVVpeFGFzBjF67BeHrZk6TaQshxW4B2TVU1rJaACPIUeMu
 MOY8COXinRWDEN+dT4F4dP1QQUuKhTQz/bF8EciZQi4CZ6noQA9/zmd
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Typecast a variable to int64_t for 64-bit arithmetic multiplication

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index f44458c380d9..d1d11d0b2458 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -105,8 +105,8 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
 
 static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 {
-	const int64_t period_min = ts->min_period * ts->mult;
-	const int64_t period_max = ts->max_period * ts->mult;
+	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
+	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
 	int64_t add_max, sub_max;
 	int64_t delta, jitter;
 	int64_t adjust;

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241102-coverity1586045integeroverflow-cbbf357475d9

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


