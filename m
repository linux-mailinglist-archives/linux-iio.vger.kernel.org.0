Return-Path: <linux-iio+bounces-5495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD54E8D4B44
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 14:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FC32849A4
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24D51822D6;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etUfoNDH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E614AD3B;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070883; cv=none; b=IHmZl5hvqFEqPkgp6LqdnCOX2NC1HTG8f6o8XkK6v8oy1h1WstX1yap6KwSIfcJ4ZrI4/Mm83Bw7GECx/FDJtTB2i9lliq5TD4CMRFqAF1eqTHpAqPTSu+uUL2t2f4tNg9JAnMZtelkh7CnyWyVxDMP9VR7rmmjb+9NsWBLy/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070883; c=relaxed/simple;
	bh=a2Nv0nM1QFck0HLI7Wyar8ElOhaHIMfdrqsrvPCL3Y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PQdT3n7Cxioi7NAjMO7u11yVk/GR7T9MNE18wngcXcmzMXN350zBUsfxtuAY63sGYPuA7zBEOAI7RR6CkU9C2/CW8J1DDQIei8SpPi0bAqlW+mijQv4oOOEI4LH8pt89QlEfwhZUNrbyCi96mx3xNJG2x69LwbeJhB8niqJH2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etUfoNDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C09EC2BBFC;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717070883;
	bh=a2Nv0nM1QFck0HLI7Wyar8ElOhaHIMfdrqsrvPCL3Y4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=etUfoNDHppRWrBaKepB5wo7+ONA5VLzYRUxWP5y8uQYgmwi1ew6n420B5K5krNp9a
	 DLMR4fwSXnCOabvOfDXBO8fga8LDKYejM6KdR80+LLSq795bu+t8Ah/iu+3Enlb0jn
	 4mqWOBYoUChRyy7CZLsrG/3NDc+uQkiTESiuJamZt7k3nwumgGF+HM2iqJEEhURIny
	 clh3ggNTzso3iWYCD5miiC5YUxwpxvyQ63biktSAtgzLIScMKkYrQySScS5sekDO8g
	 8YNrZ3az6RyEFlPWiFsANF8uVRQ7H6ilWMbX4dh8763Uq7mRksUYApRzlFjVD3xJut
	 q2Jyg25OQLJeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AF6C25B74;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Subject: [PATCH v3 0/5] AD7173 fixes
Date: Thu, 30 May 2024 15:07:48 +0300
Message-Id: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRsWGYC/3XMQQ7CIBCF4as0rMUwQwvGlfcwLigMLYkWA4Zom
 t5d2pWauHwz+f6ZZUqBMjs2M0tUQg5xqkPuGmZHMw3Eg6ubocBWdAjcOA1ach+elHlLSJ0RCsg
 jq+SeaHtUcb7UPYb8iOm11Qus1z+hAlzwAyiwVntpHJzMZK5x2Nt4Y2up4KfWPxpX3QnolTKuB
 /+ll2V5A1WTe6rnAAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717070881; l=1703;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=a2Nv0nM1QFck0HLI7Wyar8ElOhaHIMfdrqsrvPCL3Y4=;
 b=NRguLoiKT+O+Qi5WkKw/aEGTWSXghee5MxGlf4svNKtOkkARVnLaBpARyZ4N8u3gSKIlCiMvL
 vn22Ao8yR7/Aay0QuUOSZHt7+JXkYKOPFJJoB7ILLUyLOkQNKWSJOJf
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

This patch series adds fixes for ad7173 driver that were originally
sent along AD411x series. To ensure that they are included in this
current rc cycle they are sent in a separate series with the Fixes tag.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
Changes in v3:
iio: adc: ad7173: Fix sampling frequency setting
-Remove IIO_CHAN_INFO_SAMP_FREQ from the shared mask
iio: adc: ad7173: Clear append status bit
iio: adc: ad7173: Remove index from temp channel
iio: adc: ad7173: Add ad7173_device_info names
iio: adc: ad7173: fix buffers enablement for ad7176-2
-No changes

- Link to v2: https://lore.kernel.org/r/20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com

Changes in v2:
iio: adc: ad7173: Fix sampling frequency setting
-Patch created
iio: adc: ad7173: Clear append status bit
-Patch created
iio: adc: ad7173: Remove index from temp channel
iio: adc: ad7173: Add ad7173_device_info names
iio: adc: ad7173: fix buffers enablement for ad7176-2
-No changes

- Link to v1: https://lore.kernel.org/r/20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com

---
Dumitru Ceclan (5):
      iio: adc: ad7173: fix buffers enablement for ad7176-2
      iio: adc: ad7173: Add ad7173_device_info names
      iio: adc: ad7173: Remove index from temp channel
      iio: adc: ad7173: Clear append status bit
      iio: adc: ad7173: Fix sampling frequency setting

 drivers/iio/adc/ad7173.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)
---
base-commit: 5ab61121a34759eb2418977f0b3589b7edc57776
change-id: 20240521-ad7173-fixes-4e2e5a061ef2

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>



