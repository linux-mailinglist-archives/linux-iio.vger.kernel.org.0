Return-Path: <linux-iio+bounces-19022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73FCAA8209
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 20:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CE53B4ADD
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA47C27B50B;
	Sat,  3 May 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfs+lyok"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3F17F7;
	Sat,  3 May 2025 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746298618; cv=none; b=E2hVP4Z5D7cUAYwaLapvI+BM6C6T+loX/jUC60tvjr565CYpRRDHNmM30MAyY1+HXrLROzbzEKSBLUSnjiufRvJqBsnOIQjK6tDxr6XHr6+aNoZvVWaT5VyVWLGM4irfsN8vXKb1d8jS25cw0WxDKYK+IMgyV7mgQWR468jTa/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746298618; c=relaxed/simple;
	bh=BqK2wv5HVSOx5UA+bhRciqnrg8ikH23ROkN/77YQhfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5TyFzfKTburXUGiQ4/Ksi0Vkw6yUFfx9jswustMepflPQSVnt3z82KHeORp7rY+7t6XCnHwpXp3AQobVuwudQvE3YdrsG8xuIoIIpdXBqfmggTjXpT6zY/WMl31juZUjvOIHyVeln2b4jlJX/i5+ndNbx34EJJWoZEC6jHDL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfs+lyok; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3015001f862so2420654a91.3;
        Sat, 03 May 2025 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746298616; x=1746903416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXahc/5xMmkuQkztG4NaO3Y8N604OPKgBKd6HMHm+lM=;
        b=dfs+lyokV8Z94czbtU8tWKQbG8pW7Du7tl0OTxsfX/jS+YuVw+XnTqS1fH+MnCKzym
         XzGhiES+yNm1Fu2nM3YhSlhlH+Sr1/Jyyqez4/WaSlkc7sb2cQE+zyfu33KRGys9zuN8
         R+2IdcopCV27vu1xc1DO526dp1snxm5fWP0Dq3k0/X34scf7sLCcGP/1/W5H53hIg1dM
         lXt2nbQGHp8vjAgSkvtm4b/RpG9H7CRj8aKt7UsdsCnkKVvq7or3tRnFxUCjuZDk5h0a
         2sxUp+6D1U26/QEm4iKC5bY3MFgk6hoyI2xxd7Px0YIvTHzoVdGaIf8u2RbjQDse1wm4
         6IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746298616; x=1746903416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXahc/5xMmkuQkztG4NaO3Y8N604OPKgBKd6HMHm+lM=;
        b=cR2NZJfTbmbq0ZxVp6KsHVSsdbRDFihWMGEQzwRdkr9WMi7EaCpV8nWqHdrZ4D6ZfZ
         MG9Rg/ZSakEZdAos1SXpN7AslWn81lP8pV0wufkC9taAuRFXbSbCPfRlKcVynwZnCSKi
         +1c4m4q1bFcRRI+g3xv4RxQ1nN0blECz3NNosbyW27R0idExkAyDfSfJh+dQyMUvkMOS
         poxGCyzQB9faQZyJVZkIBA/n9VkRPTop/egZNi/Hy0zLh8i7Ll4LMBHwedxkU4i9gFxV
         NBxISLzBW4cz8b7g38sK/FGaNYe+T8mJLlNHoA2hcpT+3ZZtcPu2d4Xvdv4/qpcuGqEm
         m26g==
X-Forwarded-Encrypted: i=1; AJvYcCVTX7ko+nLNXK29O3zKtFNmNmWbLdwTztg3Dy9tIoXECRkv8mecgVIB4CinF8bsFChmcKPQqO0GHWQAPdw1@vger.kernel.org, AJvYcCXKtvd8/ZY/KXaUJ/g5cjnYZHsYjzSib3teu1cozz1onvCidH5zVL9i6gTxsM09XuLdF5wh3PV0VDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZZlUc3FK7NOdj7fsM4iVjS5fiVF/eqfUXHVEE1an7VX46Tpk
	dcFWxqJfCrk/tuLsmwBKA00miKGyYr9vyvW68QoYZItHGtT0gH22pZPQEg==
X-Gm-Gg: ASbGncuBOeojdOmJiR/YT2AQsJea62ZuIzkGzUJoSwzox6XSoGX520BWPywBvJ45aRa
	yj9KW7GC/ggltow4m5tFPG+SF1LbXSQKwyeH4NH0uCu87H3THEXevZjlplxeBKCDrFbtUceLUGC
	8vzWDOi8gddf/o7UqfI+Q2Q2p8HLH0vza6oIiJrBFqgEuHLt2+3aFo8oMBlGOoHDQL6IY4i6hf3
	ypZEIUBFFy1YhhkFQWOK4EriuTRNADEvR3aUsVCAElETXbx291f215CXvRD/6x4odapdmeu2aF/
	/dhjNdQtmEZPuoucUMw4E4MhZWIu1QlqQa9mQ6wHiN9Fs9Q=
X-Google-Smtp-Source: AGHT+IEr0vMaFWXMolMrv3pWsDhfeIblKe2JHhRk6EQ7Yt5R5ZdAsASH4aVVlxRXlurqCbo8NVyLSA==
X-Received: by 2002:a17:90b:548b:b0:2ff:5a9d:937f with SMTP id 98e67ed59e1d1-30a5aec1bdemr6594193a91.24.1746298616442;
        Sat, 03 May 2025 11:56:56 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480f0aasm9028516a91.35.2025.05.03.11.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 11:56:56 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: trigger: Remove redundant conditionals
Date: Sun,  4 May 2025 03:56:50 +0900
Message-ID: <20250503185651.29445-1-gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checks for null initially and return early.
So there is no need to check for null later.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..6abf2a450202 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -453,36 +453,32 @@ static ssize_t current_trigger_store(struct device *dev,
 	}
 
 	trig = iio_trigger_acquire_by_name(buf);
-	if (oldtrig == trig) {
+	if (!trig || trig == oldtrig) {
 		ret = len;
 		goto out_trigger_put;
 	}
-
-	if (trig && indio_dev->info->validate_trigger) {
+	if (indio_dev->info->validate_trigger) {
 		ret = indio_dev->info->validate_trigger(indio_dev, trig);
 		if (ret)
 			goto out_trigger_put;
 	}
-
-	if (trig && trig->ops && trig->ops->validate_device) {
+	if (trig->ops && trig->ops->validate_device) {
 		ret = trig->ops->validate_device(trig, indio_dev);
 		if (ret)
 			goto out_trigger_put;
 	}
 
-	indio_dev->trig = trig;
-
 	if (oldtrig) {
 		if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
 			iio_trigger_detach_poll_func(oldtrig,
 						     indio_dev->pollfunc_event);
 		iio_trigger_put(oldtrig);
 	}
-	if (indio_dev->trig) {
-		if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
-			iio_trigger_attach_poll_func(indio_dev->trig,
-						     indio_dev->pollfunc_event);
-	}
+	if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
+		iio_trigger_attach_poll_func(trig,
+						indio_dev->pollfunc_event);
+
+	indio_dev->trig = trig;
 
 	return len;
 
-- 
2.43.0


