Return-Path: <linux-iio+bounces-10893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE269A903D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6DD1F2364B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702401DD55B;
	Mon, 21 Oct 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A761phUr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822D1C9B82;
	Mon, 21 Oct 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540406; cv=none; b=InHHbZnAlFdHjFQFqZ0U1lq5ep5rLJpqe45ItwVBpPn/mA+aE6motaaD4fzmP6o83BSEWXLtNsqldpERET6jHy8Kw4JWQmE8L4gDtc2jo0NyAESsDO/n9HCqbVgGSafAGVinX8R/x5bmEFKrfKDFDCLDkS0gjQbOLSE8hBWYi4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540406; c=relaxed/simple;
	bh=OMe0uxbezRu1rkrj9/nozDm5exgPB0MM40eLMyJkIvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDrWpIR2p7aUPbQVZh7DTF6uac3+raCIFNHyL81+m9TRcHP3CnKPYUY2EhqijI5ZmbCLqqwyxkLdVryqv0nxcqEMjzuZdY3xCX9i+zS0dpuHKM1RyHwHSeSLRxCYHHgdfK71htPVNwHbjCWeLwz+Uio7YASHzCf20nwedqi+Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A761phUr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cb6b2b7127so790268a12.1;
        Mon, 21 Oct 2024 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540403; x=1730145203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqSw0K+aoijDk0c0l1QoWEgxZcS7eEIIOUUlgHO3FXY=;
        b=A761phUrXHe4ng4P2OB5et6VKFYr/QZqzXQ4Y59foEUR1jxhqZ7zyHKGuxq2u4O52W
         I4LcyANNjDyiVXaSIh2BLXKUtJppYHup5ucb5XTCr8pM9VEgiTbm/Wf6q2hh1M3aAJ3D
         KoaEkLPOpuAiw1xEFf3GZVTgFjr/mqFJy7CrcbIbxeTbW2ABZtF0kyUPq6BDxN39dLXP
         ++10bH6eNgyH+n16g6ElPGwkWOEbzlfS+P142q/Dye0lS/T/qL5CgmyWWisBIZ0aL7Xp
         EJ3TH4W/Qr+ujQvw1Zqxbz3W8bTG2l1/MuCPtlyVQUGLOyeC+YK4dXi6H9kVCwQxTKqI
         LOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540403; x=1730145203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqSw0K+aoijDk0c0l1QoWEgxZcS7eEIIOUUlgHO3FXY=;
        b=mWiwgCfepSvrYz46R/CvOz9Kn2qSbKjmO1dFd6j/CohVMXkW42dn8UBEAOHn7C0OCF
         IKnjSIYgI3gjzmLZ2a9e+8LF6T4pSgvtby7UV0GyeVMg98b1a758EDYVPng7hgx9RpuV
         24ZiXcgEavkYZsGNiOgpHdVQuytXmnFZAkntVYpUhTtFNgBIRtsSdNxMVkz6iuYzAsEQ
         u+/rKkzrvItB6/RjM+E1RFGSI/k72HlBFKomA3qvXpscRRwmiCJB8U6Kwla3xpxJXZxa
         XqjajHJyWQ8SOLGO70G5ZieT8XioAJvSqnC3DQKNPloLRe4K4E38E28I5ywZESDUNl1a
         WiYw==
X-Forwarded-Encrypted: i=1; AJvYcCUIH5aIR32VaTJQ+zbOQ9RqhZkQPWdKo5lt0LRxBszVxkhpFBl5WZ03FS9T4JtRve0wU8e0HV3PpLVXKrWI@vger.kernel.org, AJvYcCWNYQ8kdMyTPOj1ejyBqqlrszPJFJPxtzAEGg2edro+mvUoZbJqf5hg4oVYEWJrV9ZQDn/6w3i0D0f1Nw==@vger.kernel.org, AJvYcCWkitsREpd8t/gIqkY1iD/opKa618+1YvPN/WMfft/w4fenG+kds+yKrUmq3jw/1rs7/2y480c=@vger.kernel.org, AJvYcCX2WKApUt54jpzzNm9Wtog2R9a8nxcL+EIKehjSd/vv4C7a2onV+qIdtxwl0qtyKHvSq4GM7o1QWRfl@vger.kernel.org
X-Gm-Message-State: AOJu0YzCj9pCJhjMXDZszP1fz7uWiKz0VKxsYZlaGZwU0XnigteJG0lw
	9GFKJFvwMo9f1a5FtaC/D9viG1BHrOsPFuPs+E81Kzk7yeo6CMgX
X-Google-Smtp-Source: AGHT+IFgcWx94Xo+Q3Rp5+o5bL9QLtp2dZ5d6eSDxJplcImLeKFl5UwlGtvs/Alg+94qBduQW3SUVQ==
X-Received: by 2002:a05:6402:2551:b0:5c9:5a96:2869 with SMTP id 4fb4d7f45d1cf-5cb7fcdbfaamr91063a12.10.1729540402876;
        Mon, 21 Oct 2024 12:53:22 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:22 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stable@vger.kernel.org
Subject: [PATCH v2 01/13] iio: chemical: bme680: Fix missing header
Date: Mon, 21 Oct 2024 21:53:04 +0200
Message-ID: <20241021195316.58911-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the linux/regmap.h header since the struct regmap_config is used
in this file.

Cc: <Stable@vger.kernel.org>
Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index b2c547ac8d34..dc9ff477da34 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -2,6 +2,8 @@
 #ifndef BME680_H_
 #define BME680_H_
 
+#include <linux/regmap.h>
+
 #define BME680_REG_CHIP_ID			0xD0
 #define   BME680_CHIP_ID_VAL			0x61
 #define BME680_REG_SOFT_RESET			0xE0
-- 
2.43.0


