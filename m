Return-Path: <linux-iio+bounces-27504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B612ACFAF4B
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 21:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8639030DD8AD
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F9346A0A;
	Tue,  6 Jan 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uh2PMGCc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388B346786
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728193; cv=none; b=ticGiP94j9flIHKWD/huwxd74RoR7l2z+lppyobiiuXgQEyO46XbmNDXts490z+bTiA9n5hgaV4fYx9uo0qqtT4btmdTuSRFgNqGqc9v9M+CqvSPap+2mmH/AoM3QypVucjAAmsfMVbTHp5w7XRG197WUMN19ImsEA0E74teMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728193; c=relaxed/simple;
	bh=zG1q1v7IQN9l4S7nJiZB81g2uvy2p2fCMgyQXRbuukw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nijpDJAen2PCeuIQy597mbHPzLRBsoarbp7r/2ZjKipe0tbeEEJ2LMwKApRq69ICdRjwU2+nW4IVfpRRQicuv24xPNd1Th6/fJszfWOiti/7r2NXtkwdzaCdrGwNyFRDQZJvtM/+myG3YzB6Kc5KA7LKSXdOGfEky/cie64fIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uh2PMGCc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64baaa754c6so1781099a12.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767728189; x=1768332989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFyVzL7C6M6CDHXuEKasBffJkzf3DPHBWHoIdtXmcFI=;
        b=Uh2PMGCc3Qis84h/EPExgZFhmemoYIGMLIJPo1TUkOIx6TozWQcWkoNAu6qm0uMPNA
         VuC9/GsGdvg0KOvOwgSVYiA7Lgx6l2xJ+/lHN0X9bVViEdI4SbXlVSVCoG0LJKs6WzT5
         z3DalKtVjv3+FLQ/bDvFXoiIU1T0p92DkmS9dDORnehdgmOeTs21QH3vcWWyI8grDyxj
         2ISUOOyAOizymbDeFfkkarsXvExkW31BhxsDGuG64byQkmnSVZXFgWZQUlvlvonXnziN
         945plXo1DcKOhxatfIrz6vLpiMPDeYLJ+LcSz422ygPzyddzcyKmLzNILaLG/GTU4K42
         2tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728189; x=1768332989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFyVzL7C6M6CDHXuEKasBffJkzf3DPHBWHoIdtXmcFI=;
        b=avXG3AUtT9fX25FRI3w82wCGWDizden0gdP2siAWzXPXr8d3kFFyc9leXAinIAORKo
         kLpNOV3d91H4Q4USIE/GzIq4uY9+gwBcHKZEtb+9BGUpD/74hb0QwIziCJmdHKb03/6X
         Me5DMwCSUHu3I2C04B0WuksAPdFMAXdjD1oKlVZ4VFL/2uQcGFy6TpEYKLIbPNnTDI/c
         MILZ30vMkhwRnSrGwP1VcbpYk+3jWJsJvZPsrY6S/I8RxRFMq1VEYjX/JfxeOHLfKc/U
         3KrOeVkRGaVCK2bnBjXpw6b/e5saypF1OcvbNUwlXTIF0T92ONwsIE9qUTGNIBPnKpFk
         ZSag==
X-Forwarded-Encrypted: i=1; AJvYcCWvBF/R5ZEDUWeErL+95gSlsW0wz4Lh3OgS0OkqQH7QxXExXNQPmv3adGOF1zuzCnmZGN7EblEes7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWcR32uccoRBjx7LXWGwcDyweDrXjlzbIJkIKWh3zt6a5gy0Q
	YJGvUfR/cte+5DMt3PoZ922wDHQY2lOYsy8qwCHeDBPnu91sQ6zPSTLZ2Ohr46Z9iPI=
X-Gm-Gg: AY/fxX427Nh4gxdD3JJvFxyrsvGtZwEofe/vhDWu70f4VI3iy9uQ1SfZ4ofmwJoIeJO
	W43nJbUUoUOpYEcNbIvNdWvEFZHIYtQz7FeGNnq3rGZ8gYD0Bx93D227yc+bvrzr+Q5WxsXFEfv
	/P/z0uhe8HgabBTTyt50+jwuy7mpdcY4U/SSDiCjwRPS/ncLonY71N/1uuRL1w5ylG6YyY5PZuS
	GS4hgHA8NIJ03O9EruAJhrbqVZd5/+YfdM+xcvAKJOkF1U1XrALSXYYsSvngF3pN5c20vRpkG7s
	iqEqHuJmBhhXRdIZoOpY6nEsV2p9Nm8pz4pId5dicYFFYZI1tMoDQyMb1TkUoXGy/hLIZOcZQjN
	T2lRQZKTRAPwSHU34QlM9qkVj20XuzY7KHFVbSWlpJ879M75No2OV1cj9wUfBCJCJwuRgj1dwff
	Q4KFUubxcV+59wOQFqCeWJCAA6Nzcmzwn2WcKbQVXA7w==
X-Google-Smtp-Source: AGHT+IEQwXkC4rY9AODpwuc6LwbEXaiZvIFxNYWi2PF2HMmffG4XB8GWu3QxJdRKABaCjjqSwGmuIg==
X-Received: by 2002:a17:907:6e93:b0:b83:c7ff:a47c with SMTP id a640c23a62f3a-b844523333emr22972466b.17.1767728189166;
        Tue, 06 Jan 2026 11:36:29 -0800 (PST)
Received: from localhost (mob-176-245-131-134.net.vodafone.it. [176.245.131.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe60sm295756466b.45.2026.01.06.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:36:28 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] accel: adxl380: improve data reading from FIFO
Date: Tue,  6 Jan 2026 20:36:25 +0100
Message-Id: <20260106193627.3989930-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=514; i=flavra@baylibre.com; h=from:subject; bh=zG1q1v7IQN9l4S7nJiZB81g2uvy2p2fCMgyQXRbuukw=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpXWPOJjw0pAPkoTXnksj+HM3TzyX4EC40t70NW hasOoNtHR2JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaV1jzgAKCRDt8TtzzpQ2 XxVKDACKkaTatBirFEpRlc+bUaBc4FllfjTZZxPTWgYXOeCcxHZMwi5hTD23eDo9Wu6+Ri5jS2n IH/JYkWIKaMQD4Z8EB4/ZP3RE2vFoSyJtuyfu9nQgtkKQ1KndQv4UhkYoFvPhaRzIjOLHFwRMSP ho0AfmH/mC2dbNAhbs2Va5ffk3HJNInRddtcqGwlwPNRyoZ5h6ugYjBJMbwEvvxQvXpqbbYzez+ GVu10tQKs5yz6r/041awkl10KpynBx4/pupDisvABhGGsVr6QyGeQOwYMajv0dj3pf6l+SGqJvX LCkJo6kzBblYH+QKNZN9Klu7Fc6AiDAThAcKz/5Coug3GLwmN+hqUVlkal0aC4nzfOjy7CeY2nj IHSWK4aMBNcMIrCyqjwGhlhS1BBevSjzqDKxdTYjuOxgKPfIJZPwQ33/FY0/xMohyoFRqHQvxjd 5JEnPLtsbpeLLJYhu7PxhcWgfCUzZ42HUSky5t01fCWh0TtS5Hdk/06ybnvIgBdX74wlQ=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

Patch 1 fixes a bug that might cause the adxl380 interrupt handler
to read from the sensor FIFO more entries than actually present.
Patch 2 optimizes transfer of FIFO data by minimizing transport protocol
overhead.

Francesco Lavra (2):
  iio: accel: adxl380: Avoid reading more entries than present in FIFO
  iio: accel: adxl380: Optimize reading of FIFO entries in interrupt
    handler

 drivers/iio/accel/adxl380.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.39.5


