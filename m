Return-Path: <linux-iio+bounces-23937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63CB518F7
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C911893C08
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D20322531;
	Wed, 10 Sep 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPx0EOVz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E8326D60;
	Wed, 10 Sep 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513240; cv=none; b=j+foU0jGj4GnyrQXRPuR99FKobuvJPcKbmoNW3qaAx5lMUAv9qg2t3+MpB5Hbf3KtJrWdXkFslKpkufZOo9HqkriUfkKWYp1ED788nC0a7P5+sxRXztPZeb5uPqxDCam3RBxF+Lxc4rhWdckU9uXUKbjbcc6Q3kfPTdyMLui9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513240; c=relaxed/simple;
	bh=ROrvoDuVDqbgFWhavgvfYlrq0NkOS051qjiusBT8Ua8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/mwh4P6aEUg7zEl6W4cij8na8PAY2kXXzIfA5VcpzyyIr1K2d0LbCtRcDZXFF7RITLLf5s8SEQ+tg6L8ZBb5a3sV4z1p5JBLLMJoEZgURD0oYJvIRC18ZmvZbVKyULprPsrHyT5Rh9d430ewLlrDHBQY6hRcgktlHbybdJF46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPx0EOVz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32d3e17d95dso3534640a91.3;
        Wed, 10 Sep 2025 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513238; x=1758118038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXxoV54+FjMxXPbk6s6rmJoLKsFn4oY68NqK38GSsng=;
        b=nPx0EOVzh57exIUNDZMEGhqrt9Py6YpYpdvys4jGBfO+y5H8t8W7nZiINvZoanoygp
         8UFdGqCX6O7f5DRZSO/EPalFNsa68pTNpfK7Cvw2FPIh8nyDIJBpgS4DrIMj+P0rUwYc
         400RjD3akKsIU2yhBfaCS5KwTFIFTwO9hKBM6GEp3pohZ89IDs+LnoYjF6BqRhiExvfP
         Wtj3n5tQfDnLmcz+5ZU29tqlSYZYWLgbzM/FfaX8eitgUsG378rVE2VNdD77AbWE/One
         j4oW0fatyBI13X2eezlty/WhCUs4xgQadgh7Mlmy8wNqp9E9dgWoR2p3/gaqa7VzX/kW
         lGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513238; x=1758118038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXxoV54+FjMxXPbk6s6rmJoLKsFn4oY68NqK38GSsng=;
        b=Ik9et1qDlGyoObE0TIbklP69J7cfqnxEjMqMwtnvKKPGlVq9fjzFuYJF9cIDsJLld9
         2SFP6Pu+skLQMVjEflQk/StB5Tco56A4bjcWqYvbz2wQb693h2yizgYyGHN5M5FLtvsD
         y0UT9pKln4sEi/KutKvN96bvaE9LnAGo0pJ7mdNCjPury0C/jLgTwECRKWVPjgEVnEhX
         b1GPnKK5CVfxW/1FEW7QZ0whuMjHGhVmVhJWddx8MmDsZbhq3XUFnVz4D8FXYQLSoggy
         e15jCsIdU2ps8ZDeUh610uR8yZx4oJx+CbX22pJZ2us8jr+3xxJCYQAHJg2UUapEfqY8
         I/XA==
X-Forwarded-Encrypted: i=1; AJvYcCVgjwBvhfLCO2lGxu169wE/1D3CR8Gj6JTwyTjuaqB/P3WoYCxRm5YIB6U1msDAeY8M1hV4J/kY693cCsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxth0n1nF+kLyxeDqZOaKPOsKlSLa/8ZXOGlmKVs+8MqJ4b0Oq4
	d0Molu3aB/VG0XNVMU0mvFOpimZXyDsS9s8cMJSl3pmQBpezwEjrP06u
X-Gm-Gg: ASbGncvhgcEJxQQbZUl/ulka3zowsXd400pki8Rp+pMTnE7Ywz6P7u7xonIlMHsqfoC
	ea3esZU6p7NG/gXy0wm/SyVlNfxAJY4/zYV51A7Z52SBZrNX+Y4zml499KTnqVh+/Wr/b7Y7AsS
	tZ5kRFNyvS+2VlWCgoQSOxiW+SsOOxoa9tQX7YakxtNfAMsCSyI6xK4b6xXhxUhtLizo9T/6q+5
	nyd5AuaTBt+szdmFP1dYybrLwVWwEFS3hdZAeewShiWQUq/77nq5YtmxRp5/azB9h4X+iq28hl3
	cAqdJqwC7XKlAy5VKtAGiupSIJT+ILb0RV/O9k8ssOdsXH4j+UUyx3fFUHnp0N5qcfjGPlim4J8
	lHqyhEaGaX2mcBoFuieULhMv4/r9tH3I7q+1zpys=
X-Google-Smtp-Source: AGHT+IGQeSP1uEIwB71Hv9FoOlsKj0OYLqwv3DuIX8jyhjWu2fwd+nhEAulKnGHLkre4mso7a66mpQ==
X-Received: by 2002:a17:90b:55cc:b0:32d:9e71:513e with SMTP id 98e67ed59e1d1-32d9e715fd7mr9517653a91.34.1757513238232;
        Wed, 10 Sep 2025 07:07:18 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:73ce:c1b3:ae9:98ce:970])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb2f54acsm2760204a91.2.2025.09.10.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:07:17 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Wed, 10 Sep 2025 19:36:50 +0530
Subject: [PATCH 2/2] iio: magnetometer: tmag5273: remove unused
 IIO_CHAN_INFO_PROCESSED handling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-iio_chan_617_rc5-v1-2-924091d374be@gmail.com>
References: <20250910-iio_chan_617_rc5-v1-0-924091d374be@gmail.com>
In-Reply-To: <20250910-iio_chan_617_rc5-v1-0-924091d374be@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Gerald Loacker <gerald.loacker@wolfvision.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757513227; l=838;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=ROrvoDuVDqbgFWhavgvfYlrq0NkOS051qjiusBT8Ua8=;
 b=3/kRP1bQIpmqFoMfs0UHx68qVJfszT/mVyygRmjc6rUtiwQH52tXyogwjlOLGKwptdO5FUW3Q
 JSPH3OxomihDhpgDKtNqcmZCR4pNrIvSpLJWEmPuHGffjUhKGkXXyGQ
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The tmag5273 driver does not advertise IIO_CHAN_INFO_PROCESSED in its
info_mask_* fields, so the corresponding case in read_raw()/write_raw()
is never used.
Drop the dead code to reduce unnecessary branches and improve clarity.

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/magnetometer/tmag5273.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index 2ca5c26f0091..ed023eae5e42 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -287,7 +287,6 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		ret = pm_runtime_resume_and_get(data->dev);
 		if (ret < 0)

-- 
2.43.0


