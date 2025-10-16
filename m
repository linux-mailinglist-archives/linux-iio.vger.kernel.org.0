Return-Path: <linux-iio+bounces-25159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 190C9BE4D46
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CEA44F9857
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C142E54DA;
	Thu, 16 Oct 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yjqItfth"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22FC3346A1
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635289; cv=none; b=qdmj7H/zxL1ZR+ep3X2BGdMOhTq6Zw9RHeOaQ5B7lfR3mfBu8XsEZBtFEWNEeTtDfWBsE+g1ruE1UY3jCoQQr91erkUUOupI32LyjKPoAxShAEaJYRjeToVGNvkMRFy8U3aWJxacpNtyr/ZuIBUk6lGN/d/6TXmA3IE6HsVlhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635289; c=relaxed/simple;
	bh=wBY2cs92+fygg+uCMwB58jzVy7qCTwKs8jhbQwv+zXM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dELL/3LZ4A9k2w6uRpn+xO0th7jLG35xg7/Uvqq7ACPbxGBUKhKQNeMgw6Q7/n8qlt378AF4o+oPZnVkYbmDSO45AOH+L+6kYzLweLz1uzjXh0SLQuvkwjQQWegL3K4cJqs2qTH/4eK/ojmHRRmIon4/+XPSfFriSnisf5dQhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yjqItfth; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so863034f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760635286; x=1761240086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPtpl05ucdsH554VPwBpisewoWIW4AQUlxIpVcCcSz8=;
        b=yjqItfthWvzSoNGCjnquVriEdZ/8pV59ElIPFcVtuzlVrSxxJHduT0Jr4ZXjWSpQ4R
         7JonvfJ1Mr8tFWVTheiHsu2H+jYe275z/Z+CyKztMrd3906p68KZ4qSeDFWsDqI00tIm
         NQSLCBWbcZoK0Ows2Av/+hAUu82kOVQCWk/RRr3q44Ur4sCngzdVaMbRTWYQ1Akr6XpL
         F1H4x/wK+ASqvpE5GaE4q/GhqIbVTFRyo2cYaHkzBiPTjZKCCkK6o7KmOq6VbJaL2g5U
         fN/xBjZmy/YK445P5yHpk8Iindw1+7kPgHOnM5Qjk3zWJMs4b09iHGuBBqyf5J48iA9M
         CceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635286; x=1761240086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPtpl05ucdsH554VPwBpisewoWIW4AQUlxIpVcCcSz8=;
        b=Ze9JvSMSYGCZycEZW8zOg1ZdOpoL/+JyXlTujDPVBO47bvnxXHVdk1B2XtS6rB84w8
         flHQSn669lm6RuRy7f1xUAb5ag01W9L1HELOf3vEqo69VZpIufXVx1+3GTtN7SN4G0g7
         3XlSvg0UEQv+pCHW0LjK/FdvikoAVmCAKt106Hj7No/7FJv8Teguvzf5xU2bPQYIR6Ld
         20f7Ke9bwfJaqxQxTmTBhRKbR55zII6gcqghtflw8hU3y1nc76f8x35Ak+sfsqdFvlIA
         qRF+U3BljKRZoQjPxvCXUVo58FWWl3OP0MNU+BVliEv1uO1/R+TX24o7bSArb6KKyR50
         kLvw==
X-Forwarded-Encrypted: i=1; AJvYcCVye3QtCkeHqoT7QqUFQSZlq2CkMIRXGqySJiT3oBORprd8UCldPd+JQyjnpA2Flk4i3qv7vOopR84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2FXzfOForBVNP6w66/zdzbNc6Rrit2R1PEEHVlPSwz9bfB+F
	yB4B0ub5Q7minALxQcSJoYn+7tc8IOwHBCovieRUj8db5/UX2fuVeZpFtq8+tyr957g=
X-Gm-Gg: ASbGnct9qJrBet9LM1uhJUU6H401KjSTM2XY5zHjp9qQq0KfU6WdDUko8kiTGjXIsPO
	OjUlUT8+PNNkgFBEyynb4wUYn7mqahHkmmWSOHTgloEOlYO7zN9KeYTuzozY7wi9LiCAxsRYAN+
	ZeO4lwgpo6JOwhPJy6mfmUzSxPKlEF1adRShzm42/pEsn2TflyDpg84qn+saAr9ChOkKXemx3BF
	gNWceid8RFreI3QiMsGjg5+xCtkTaQ34SPAgoBy61BG6dpQ9KmucUtS15bSpTyayBWYqNMRvU7A
	IUhGby19sNWE/scAX5DgME5QYtEVZUNg2CIL+yV/prBEKONS+//xNym0D5VUYIiNd18u2ah0Sh4
	094/zCmyzNmHZZ7A30c3IMgganmJMPqpq1ChzkGdHo6wCp16rbi+pimLBCribOM7hmU+dWZGMGZ
	dpJQ==
X-Google-Smtp-Source: AGHT+IEbAwOLpN+3gLcIXSlwje3hgYAK4GcMgt9FiO6xlV5Qw7qtPGE7OeuueIeTbngPsjCV45Lc7w==
X-Received: by 2002:a05:6000:4205:b0:401:70eb:eec7 with SMTP id ffacd0b85a97d-42704db8ccbmr625604f8f.43.1760635286027;
        Thu, 16 Oct 2025 10:21:26 -0700 (PDT)
Received: from localhost ([151.35.142.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711443e81asm40085805e9.10.2025.10.16.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:21:25 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
Date: Thu, 16 Oct 2025 19:21:21 +0200
Message-Id: <20251016172122.1220332-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251016172122.1220332-1-flavra@baylibre.com>
References: <20251016172122.1220332-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=flavra@baylibre.com; h=from:subject; bh=wBY2cs92+fygg+uCMwB58jzVy7qCTwKs8jhbQwv+zXM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8SlG/5SlI7hO8FM0OzFXZY/MDRumIt3Y6VWoA foWjMafTBWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPEpRgAKCRDt8TtzzpQ2 X0iuC/9y/vx/TgX0ojCFHNuz8sAIt4HxpRJS1SuidRyW4MvcgKpXVW4TlqdE+d9AJUyIcWuyVs0 wHzBYOzfJZ8pjtytYCjLf7TPuSRBF0AqviR5SFdAWZpHe4U3L/uS45fsWdoU1LY6+DoKX0/XCpD nFT7FJansxCiKxGE5IPhH2H4wlvXmf/X1X05wFSK32OM7cmDpgheSeNl8Ag4sl4nsd7ajGm8RYf APDSzudrK9uDYCzrEItJHKMV3XG2JGySTyumqYGkNnIAz3fOgjH2SN2kdPHP8Yvd6hiQ4E5t/yy +FkMsaEzfKlh/IId6vJJz1IQNWSFbAH7a6EweZR1AMY4+mSimCbKCviJqZd0Sb2aX6B1vgvla2I vlAUoHRQcd2H+BeAh+cK9CaqXVJONg6EjcWXSXgXXLY+pB7tNZYN3wNJsFpR9NWlJ41nbHFx/Qu KCl+HVL/oRNgQgJtnfhzVS+yI0hK7sW0Iim5lGADApjxkVMGiCCr3aTul1boMWIByTIiM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The `odr` field in struct st_lsm6dsx_sensor contains a data rate
value expressed in mHz, not in Hz.

Fixes: 290a6ce11d938 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..bd366c6e282a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -365,7 +365,7 @@ enum st_lsm6dsx_fifo_mode {
  * @id: Sensor identifier.
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
- * @odr: Output data rate of the sensor [Hz].
+ * @odr: Output data rate of the sensor [mHz].
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
-- 
2.39.5


