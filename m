Return-Path: <linux-iio+bounces-27838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90615D274F0
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 19:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50CE630381B0
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6C3D5252;
	Thu, 15 Jan 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="01AC9CvS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EF3D5248
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499637; cv=none; b=BoqR1siW0uJdgy6NUxVG/JWdBpyN4SMepPWro+x1O3zST30zrJQyJz3/hYIAdQ8KgvpgO48LB7AZlIQ7FYqJIQNqZUn0Tr7XKZxI+T8W2IYkFBLcQQZG3EDj6/SZhfXr6OfGdfh7GaM27/SXyKLhEuqdeYAI2pQwdrm6VYoIx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499637; c=relaxed/simple;
	bh=lKcZ9f+7LUdVmHcsNELoLpk5qGIw5wEGiO3gHe6jXG0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XHut655jtSut2wPu56vvlqe3M6MmddcNhZ03jO50J1MkrL12n6CxBmTtvkD6tbD/nPtIJzAvng3kqaBt1oq4TylRM7KHaDDBtFidhuiBVrt5kSUZv7//Eyj14k0ueL3AHKSAq8zwLYWZmH0IhifXJ3+TwNRrpGQ1xSmw0Q8Pimk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=01AC9CvS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso2052876a12.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 09:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768499632; x=1769104432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=snb6yqzLQG/XG+PtUztHARHkr19gQzkhHPZYnwq7vvk=;
        b=01AC9CvSQHrssmEoO4shKe8mWdfhFrhULPMjlcdXLD6DIz+cSoKtOQvh6HRP7H5EEZ
         VnKVc1GqN6h/FhzZvDgFRBMzz5wsORbxL2C1q/YVnpBgl9uZyeKppu3DqV9q8ITB8kfd
         NEEn+VnUn2OyguWkm1QFP/sTAC/NjSMWc5+9F+Y519yzXvBP5CrL38RAaz+14fJhzEk1
         WCD6it+jod2bxXalxce3sNPnB/JyubiAr3ZtQBSgldniceeVLBOV+nNQqZ5RaFRo7lYn
         xG0foKn2jsOEoIk+rNsVVVOOSoeMb1tTq5jtFn+7D80YXdI1vsv0KZ5BneovF76Nz/HB
         /ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768499632; x=1769104432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snb6yqzLQG/XG+PtUztHARHkr19gQzkhHPZYnwq7vvk=;
        b=X3m4Lrj1qcj8K1NvSEjpDAMECaVQX8Zk5HqfTwS9xEpnLfj8u112JVbmgJHQBwfORR
         mD1XgP1GOap6AOaJRq9V5yHjF7/1c37pdF1zKHrX2LfLJE2Ifk7t+sLSJ6D3zVOjKBeS
         WvHB9rWsyxN8/9tFk/aBC6R/6osaHhZd19WGryH7pCI/IDwprcPk/20Dv2nV1z8XX3gW
         eVXqPUFGMOpDDU3GxiHF4Zqz4j/j0PGgIIEsrmzmgHGpmY29ICoHKEuA7rvaOzNA21Ww
         Ggu21NPq9qSiYL2k35r9FrfxQg/ppIyfbVZQT6fTs6kakzWlQSVlT13rYkABP6AHBO5G
         bxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgfJzWEG/1o1GhY1xDtm9M94ooez0W2rrAhcG/nTUBVJ44HX1Dn8xu0fRjl8155/k4wM1HCdJIsZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwudKMauAbHObwGkvKd131av40Rra6ou7KqlRZzvuPuarJIgwl+
	b1AUol5KDYf7uB1MKKKplZYAX2mfzzQaZ2TXwYZL2Jo8M3xzmmp4c0N2YZwzzwjeQiE=
X-Gm-Gg: AY/fxX41+uRWe9cROrLahV0XxIUfL8JsVHT9qBo+LAj+9GJuTTMuHD+hqwqH/dbT9Iw
	X8MeUBd4LwlqMMLjxrawSmZLvchsgxGii9idw00YCPFvH1fNxh1tdi5SJmc7DhBGuH73y9pGybR
	NWcAs5u2jq6BGxgZgv9lqSGu4x5ogyjQLkcTkeZ2Fk+puFEYPyUPAQckZdcHbLpdf1VEENhvYHF
	/Yf7p8E0LT+pcTMjO6P8ifXUe8v0F0JS+rIcFsWHJodzBqCCeugGLw5jF/lcMKgus/MAetHtkGb
	c4Cb3Cf2Gxe0ja9dYAzHSVkqsv+XA/ugI8GOmHF7fGWDmlmCzyJtP4FTwb1CZkH7rJVGfJQ5lRE
	YFfwTApQ1ZGD2I+8pkmaLULY5S5xUO5s9irkTjh9orhxGlOjMzvC8AzvH
X-Received: by 2002:a05:6402:2551:b0:64d:f49:52aa with SMTP id 4fb4d7f45d1cf-654524cf11amr302982a12.3.1768499632284;
        Thu, 15 Jan 2026 09:53:52 -0800 (PST)
Received: from localhost ([151.43.128.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452cda145sm197552a12.9.2026.01.15.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:53:51 -0800 (PST)
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
Subject: [PATCH v2 0/3] accel: adxl380: Add support for 1 kHz sampling frequency
Date: Thu, 15 Jan 2026 18:53:47 +0100
Message-Id: <20260115175350.1045887-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=flavra@baylibre.com; h=from:subject; bh=lKcZ9f+7LUdVmHcsNELoLpk5qGIw5wEGiO3gHe6jXG0=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpaSmcT+6VIfWOIfhqD4i7iM04+hgTG4wMgrMJI FNhTkwnqiyJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWkpnAAKCRDt8TtzzpQ2 XyMCDACSicYbXKBFHC+xIDUZIEJyWyLPb1R/qooJ5utBSDR4RKdX9uXp9UQ0qPeR6Q5TWy+UZXx lqAz6b2IaMeoU28woFaHybZYFA5dv5+S7fdA8rTOktJVtltuYFBdl9hfbVxFS0vzm9xTk17jQPI 4zCjLfTCiTScDOjKHgXQ4/OvbZ5OdyiAZ62BgJElkqur8MH14r4t9kZ+L8oDMhTDUIqdhdM75o9 bsQsoVgG404DlNgwuCJL+hW10oNYmBpVTPFh4mepx5LHM+axYQPqCc3OFjxsqdcmondgB9QilJd P/XhExgEme1hAL+l2Ak2mn5O1QwvDZZ53coLi1xGJWbCPTxJRHM20k8dWIl18LiP/OXyyfk/jjy 0KeoqrLvXVqqWIY66JN7EVIu012vLEEUrTHeHOlOjvImyyBI22vYLjbxAI77Cu7PyZdjnbtN2q6 y96+tDuL9asj//ZqQU4Jg0mTUFgk7yBDtA/pFJ3SzjNyWXXXAH00qHb10TtThhG8EeFUk=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for 1kHz sampling frequency for sensor variants
that implement low-power mode.
The first patch is a preparatory step to decouple sampling frequency values
from decimation filter settings, the second patch introduces a new helper
function to check whether activity/inactivity detection is enabled, and the
last patch adds support for the new sampling frequency value.
Tested on ADXL382.

Changes from v1 [1]:
- added Nuno's reviewed-by tag to patch 1
- modified reporting of available frequencies and setting of current
  frequency to reflect activity detection status (Jonathan)

[1] https://lore.kernel.org/linux-iio/20260107123518.4017292-1-flavra@baylibre.com/T/

Francesco Lavra (3):
  iio: accel: adxl380: Store sampling frequency index in odr struct
    member
  iio: accel: adxl380: Introduce helper function for activity detection
  iio: accel: adxl380: Add support for 1 kHz sampling frequency

 drivers/iio/accel/adxl380.c | 122 +++++++++++++++++++++++++-----------
 drivers/iio/accel/adxl380.h |  10 ++-
 2 files changed, 95 insertions(+), 37 deletions(-)

-- 
2.39.5


