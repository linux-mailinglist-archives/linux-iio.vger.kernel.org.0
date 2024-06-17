Return-Path: <linux-iio+bounces-6443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7690BF76
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 01:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204201C2100F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4601991BD;
	Mon, 17 Jun 2024 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoYgKumU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4A176AB9;
	Mon, 17 Jun 2024 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665547; cv=none; b=EgqnuzOehV531H2ZcyL5alwXlYjz4ZlSCuv2Yd5JiVTst3SYJ3N8HW2W/Ks0+DOU04kU4UWjuQMt5hgwd4rNvvk/d3tdgwSDyOAyIU6zMaGfuomz9mSmIC1fNS8dcLii9DuUrn/yxo7B2sB+8/wSVfkVXQqWpIKjKsu1ZXmUnm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665547; c=relaxed/simple;
	bh=xr9bphrjRBQNQBjNEu2P0AVo+UMiKV8+4gxntctg6/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fxkTErTO/7PP48ZWNip+qWliCZDTNp1FlaSFRFSJN7tIhDSGhA7n6+fjZ0e0qu6K0uTUEnsbv/n6EXbWq3WAa+RE+IRjGVMqafaM1Dn1YoJv1NhGicwSCSL0jscGYCt75T5ILpW30iK5517FDAi/j7QzJeg64/sBV96gbB7RY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoYgKumU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso5305262a12.3;
        Mon, 17 Jun 2024 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718665544; x=1719270344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qRrC6q2heFjrOuza3aAej7wrZO5j1LkSp2sinjvA4XI=;
        b=OoYgKumU50dD61fRW5o9vBXuKkWyYestLkfUPIzCMX0SNhqM026bUNkN44WVV2Qqe6
         idYI5ajD3q7y5M5Ig6LUno3vGKutVVm+BZIvayXxPbK3SVHrLYX8QMO/po/zqnYwIqPK
         az2NjuvvUxLvVTblmcPs5OuxAhtGiQenqaBHFQahJTm8Csr4FZ9cFDuQxanOjEmZ1dz6
         bcpmFrK0fEQyQF4wFs3YgUg0yYKWF/aiiKVNEBM6TpM+wR+SOp4MG9qmE2DdXR/RWnC+
         oTieVv3P6BOU8GnSqasys1L+VhZNKGHTE2ul8pgAMzTRH5ypFHT9OTCYqWbYDQX3zEsd
         lttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665544; x=1719270344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRrC6q2heFjrOuza3aAej7wrZO5j1LkSp2sinjvA4XI=;
        b=DFYfmY4bCoI+6ou2wve+YTCxEuwiXnUbhHGL9wRoZ4ZP2j3I53cJUa/sqFP2wvEmlW
         EzYF1VhBUhgza+8R95G4QjMy6zmP381zjvPmcbFqL14FHgQLAZQFqGGKKIlIOCei5Pu3
         +wlNrH8U3HeXCfyG0NHcJgwGWAKW+5FEZUDuUcbQEJqYD/z4AuKQAxjaWJKRQDVcrCcR
         wPgZQRPb7SRIKmnR9VI0ZNZK8tJtJHjXVga+trrpqheeeTNUY9LiqqYPU4WpuooIIVLd
         QeJFRcwAcWA/PGOomZWy0sD/K2vXzROdI8GCm+fhO8aE3ww+b+1tpx8I0Bi0gQrF1DLx
         GaWw==
X-Forwarded-Encrypted: i=1; AJvYcCXI8+X6RVQaOsUr9gUm3lUxoCQhP04kwOgLkggVBPiazM2/PFNjDZbpZLETxA/RYiVDvWiA5tvl59ocuzxbqOdycKGwZfsA9L/eTu6d5EkfCuyklP75cMy/v6GTK05fDD3dbZgbtgCA
X-Gm-Message-State: AOJu0YzJhkEIaS9s9m05yf2ECxdQFxYNyXO7Mtr1uYtM7zpQK+Ws67N+
	5dWjgmUGx/H8b9htQpKhpFLokULvg55Sgu47TbF40H+BtClB30Wc
X-Google-Smtp-Source: AGHT+IGmYCrjDE9QES8SzXCzC+EIOcbCB2b4G2m4Vy9jTpJarAipHFRK19eip20eVBHdlFfEOhwyqg==
X-Received: by 2002:a50:d75a:0:b0:57c:6f1d:1926 with SMTP id 4fb4d7f45d1cf-57cbd68f814mr7634241a12.22.1718665544287;
        Mon, 17 Jun 2024 16:05:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b152:a6ad:d6c8:f0e8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdff1sm7085559a12.3.2024.06.17.16.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:05:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v8 0/3] Driver cleanup and triggered buffer support
Date: Tue, 18 Jun 2024 01:05:37 +0200
Message-Id: <20240617230540.32325-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on current testing branch.

Changes in v8:

Patch 1/3:
	- Changes in bmp580_read_temp() in order to incorporate the fix that was
	  introduced in [1].

Patch 3/3:
	- Splitted bmp280_trigger_handler to bm(p/e)_trigger_handler as it was
	  mentioned in v7 comment.
	- Added the sign_extend32() from the fix in [1] to the
	  bmp580_buffer_handler() as well.

These commits were dropped since there was a conflict with a fix for that
driver. Link to conversation [2].

Version 7: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0f0f6306617cb4b6231fc9d4ec68ab9a56dba7c0
[2]: https://lore.kernel.org/linux-iio/20240602201200.30418-1-ajarizzo@gmail.com/

Vasileios Amoiridis (3):
  iio: pressure: bmp280: Generalize read_*() functions
  iio: pressure: bmp280: Add SCALE, RAW values in channels and
    refactorize them
  iio: pressure: bmp280: Add triggered buffer support

 drivers/iio/pressure/Kconfig       |   2 +
 drivers/iio/pressure/bmp280-core.c | 627 ++++++++++++++++++++++++-----
 drivers/iio/pressure/bmp280-spi.c  |   8 +-
 drivers/iio/pressure/bmp280.h      |  34 +-
 4 files changed, 568 insertions(+), 103 deletions(-)


base-commit: 7db8a847f98caae68c70bdab9ba92d1af38e5656
-- 
2.25.1


