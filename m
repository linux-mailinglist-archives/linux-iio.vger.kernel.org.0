Return-Path: <linux-iio+bounces-27826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59635D24762
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33C53032AFF
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC36F378D6E;
	Thu, 15 Jan 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sAsBEtxj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D48376BE4
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479878; cv=none; b=NW5FsHW6xYt5c80WuXZj8B+MfX838ZD/1Cpjj6ouLdQkjkhfkcKrBd734xeBFjjlwyfCYtLWeANtLIrkfXWB5eRwWvUjvg/P3OoYJuzSSWqQLICmNlGsD1Hto5cgNqq+qx6l2H6UJ2eTLvKN3RhXzefU0qZiekdnmPZOifr6BFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479878; c=relaxed/simple;
	bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H54/uzRfVqHudmw6ah2QcUvYsCYQtSAMLCHnMe+BmyzUDeDa5OX3VuYNf8hSoyGHB8rykk55E2nG2wku2d2DPj4L+99vG3hXQGmyFf42hbkh8uuTFPYchZt7LZuqwsm1qm2aMdZoHdFiNbNaqgsgaTrQGZ0cP9iGEV8fGriQBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sAsBEtxj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso1447254a12.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 04:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768479875; x=1769084675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=sAsBEtxjry09WtdDoDxsfmtDAFn6srXYSCIuOdt4eci7xEoiRLZ9GP4zch1VobcB0G
         9q7bVYfHT6um35uVosex/ppf1++4WakbHSqjE9kvwjQKWpBCPoCUumpf1425ZK65UFSy
         gQhK6l+YPYp2aNJ2ri+hqOchu9T8KfozfddFlR5qcDGcisvwHfYIHzmtKx8/gD0aDwX/
         EW9TeScHNy0yXbp7vrllSwikoKkGuJslDUQfXoWs1nX5ep0ze/cijoTV/q4yAWEiUdEm
         bMT6KUrJ0eXl5Ws+6TqkKcGql3ilCCRKJIzrBcO6MpHteBrkaFXVSNRYnRB4tS0dZ/1j
         MxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479875; x=1769084675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=ddmaOErvk67dGvk0um1IlXOvG0qTX76lvXXB75rk7mXCriYNoSfre2SWLi5VhzLFgM
         vGtjg+okoCm2UrrsZ1DtRzqo56B1cXZ6l36RJZUzFBADH63UhSwA/1WTNkqRa7tNLzOK
         ToYhd/vg9H0b2ojzWl5baqAXObUbhlEINYhjfWOBanFQnCNDyMciLscfyWC9IFOjEAOx
         OrJTAGM3EuwZn+IiHTGpbOnB3OmDFRi8FO3cyveeMtW/MAOwmNjsbfqxF48eKnCtytL9
         80rSO92z0Hf+tcr7rZQuW8JhzQXOSpUQWnYHjpSIi10mgalh6UKEv09R6//X/VkED8gs
         ljcg==
X-Forwarded-Encrypted: i=1; AJvYcCW+2s5kMRCjWiB6WEnst955kQPyYRDR6xRgjxn5G3FRTQdijItrH7RO+dqeR3JRFkiJ7W2D8/txCqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pjMvUjs8QityVgQKvKANk1j9A+AKHEU+h+gOayaVUAg8TC/5
	F/eucjSvMCWjx207oDCHzSMcan4J8t1xKn/FZB/03GOU0RGbFZsR2WGWyjNgCdG8z1I=
X-Gm-Gg: AY/fxX6U6nS7NecoO7uGxnsgeu5pelHbQM8y8RBOeOYJU6Y1nOB+3qONrAiKbJsPIYG
	kO+fiQPFwnXNIeliqUhxUScT3EE3LIMJKBZrUjDdEJaIhXtw4xLwBt9Wn8cKf5Yfvj6Y86uK3Ao
	5C+U5j7ud6QbYvWqQ6ZIrGgpDAuR1MU0mxJHJJRjo300G/EUIpOSIWawBePuS6OE3zosdOVjXe8
	vjuDMY7ZT9YCEnKG8EnHSMEnv1XwcYFDWl0OfCitNL9WfAUjQIqNFh29jJSOVWMljO+j1mHy7R3
	4A1T5TaKu/OD70fixD1rx7c0P9Vi1LenlojUed2OF8AjFqV3vJTc5gwv98bZojiyo5Ujncx/RJt
	Z9H+oUJby7DhgSKzZPaBaHpzQfdZt24CX0jttToKwUywgnHML7ezvGYyIPw==
X-Received: by 2002:a17:907:94c6:b0:b87:322d:a8d0 with SMTP id a640c23a62f3a-b87677a7effmr444832666b.41.1768479875341;
        Thu, 15 Jan 2026 04:24:35 -0800 (PST)
Received: from localhost ([151.47.157.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe60sm2769696066b.45.2026.01.15.04.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:35 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope only
Date: Thu, 15 Jan 2026 13:24:29 +0100
Message-Id: <20260115122431.1014630-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260115122431.1014630-1-flavra@baylibre.com>
References: <20260115122431.1014630-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=flavra@baylibre.com; h=from:subject; bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpaNxlKHlBS2+YWZdjOWGvX/xqPbpahixKnyHdW ADRDgnr6CSJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWjcZQAKCRDt8TtzzpQ2 XzHzC/9bPAfkua2tvZoY8F95CI+PUh8AHp8chR+la9DAB+xgwuEy1VBfyudpnOd4N2IG/R0cU1u 1dU3twNAuMt9bqfjCS0EYxlpp/PK5gqwmnoKZhpMgWi03YxSeD081GKWlhOoqvocqU2m0HtFxHk AOSEIUPwjRo9Zc38j24m+WSoXatJb9sW5yRP4YO56pS/t8Xy5iU5JnPKYaS+cKcZtEd5QWbFHeT MdtQdq1B0FscrBR5Fqoz4AS26+4H1NlfZXejsZtiInEGW9g7XdwAWYSPsaRtIAg+Gd59EinKpeS pp1n8ebh3+bOR73FMts7lsUoyRaRMzEK5/Y2Psa9Rg7CxbwH+V7vnkFb7N1s9G7uOKOO8m5Ae9H RcnSytiPYvVRyYZyz++f4iZzASIhYML9CSrO8tW/YYAhRgjQ7xJ3TNRjfVcCw03VsOnyyMLYK79 3SEQDdShEEyeX0mIRsNKpAFOqhw9i3o2jb8j0zuMf1sAlZ2gJZF44K7rgDfJoL//+ARMw=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
disabling the hardware FIFO, checks the contents of the hw->settings->batch
array at index sensor->id, and then sets the current ODR value in sensor
registers that depend on whether the register address is set in the above
array element. This logic is valid for internal sensors only, i.e. the
accelerometer and gyroscope; however, since commit c91c1c844ebd ("iio: imu:
st_lsm6dsx: add i2c embedded controller support"), this function is called
also when configuring the hardware FIFO for external sensors (i.e. sensors
accessed through the sensor hub functionality), which can result in
unrelated device registers being written.

Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
not touch any registers unless it is called for internal sensors.

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 55d877745575..1ee2fc5f5f1f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -225,6 +225,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 	const struct st_lsm6dsx_reg *batch_reg;
 	u8 data;
 
+	/* Only internal sensors have a FIFO ODR configuration register. */
+	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
+		return 0;
+
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
 		int val;
-- 
2.39.5


