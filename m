Return-Path: <linux-iio+bounces-25120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD69BE17FF
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 07:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3683A7EB8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 05:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A02229B12;
	Thu, 16 Oct 2025 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1to4AVv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5642264CF;
	Thu, 16 Oct 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592045; cv=none; b=ANh2d2E9+tSbdUlYW0zWiRQL+dt97Ce368pn2Er6bfv6hUjwy5ump1M+7tPM041SpQ3CYuju9visQ2d97A3215M8W5Lprzix86jCQcEOVilzGwDxHqrv5dmkXnLH+2lum1H1sY32hFQcj8qbEiTZ6AC2l8/YVp7VlfYh1TIfTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592045; c=relaxed/simple;
	bh=ITUgx3N03EK9CFNyirfZfXh7cU+zPoME+aIpuLj0Acs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UsA5bNMxiONqEcn1xW1CmBYaPIIT2F0bJVKUBv7zkjh+fszEqc1xWm/ekOA64nk5ssGdZpJj1iqA1BCetjqvs2MuqhGV54Y4FjyWFo0ZYa4nKpgBEEbLv0SaXJBjgzOYVsMwx9NHskhM9+m8Pr409wjDrDrZ0YIwdok14fYLewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1to4AVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BCBDC4CEFB;
	Thu, 16 Oct 2025 05:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760592044;
	bh=ITUgx3N03EK9CFNyirfZfXh7cU+zPoME+aIpuLj0Acs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=p1to4AVvn5kgrCtwkt9LP5viD9K8enlwfzzTnbEdFgujpGENa+wlvhy9otW9zkvSj
	 cSmZU1fL+zuK9hDNimoAxEQzaDeAC1VNPEpdk/n6+Nmyf0ksHwQayg8FfUNZmdPTRG
	 W10EOFpj4glKRCq80hT4SD/jH/y/aCfmLt2/FBUJ1/4lbFpya5eEBqkeXKAfObi/tc
	 uNyXh5LbViYIJIdc8Q+LTMV8fRF9Ug7FpotdiuOPyGF/a/vv/kDbsJy0hmIF6gdU4H
	 d/UDGslPJ/EGMwUN6fbrhLqISb9txqEoTGHsPohw3lNFVqwl/sH/7FKBZl8zQSF9zp
	 kaWLd//xx/2ag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD7ACCD194;
	Thu, 16 Oct 2025 05:20:44 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v4 0/2] iio: humditiy: hdc3020: fix units
Date: Thu, 16 Oct 2025 07:20:37 +0200
Message-Id: <20251016-hdc3020-units-fix-v4-0-2d9e9f33c7b1@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKWA8GgC/23OwQrCMAwG4FcZPVtJWuc6T76HeFjbzBZ0k3YWZ
 ezd7QYqyE7h/yFfMrJIwVNkh2JkgZKPvu9y2G0KZlzTXYh7mzMTIEpQArizRkKej84Pkbf+yWs
 kq7UyxkLF8t49UK4X83TO2fk49OG1nEg4tx8NV7SEHPi+0aCNLKUp6Xj1pB2FsDX9jc1gEj+kh
 lVEZGR+V6oGyxqrFUR+EQSUa4jMiBbYNloKrZT4Q6ZpegNV9LjfPwEAAA==
X-Change-ID: 20250820-hdc3020-units-fix-91edbb8ccd07
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Chris Lesiak <chris.lesiak@licorbio.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760592043; l=1749;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=ITUgx3N03EK9CFNyirfZfXh7cU+zPoME+aIpuLj0Acs=;
 b=N09qwM+v+PNKWl7FPdJLocOTs2GKdT2AnWfWVq7ZXDUesAjWmHCUBD49XCLz9D0mbegssSRKw
 07ubwFeDLEwCcuMDwWTcJK109d0CQko9JBCPprFcexngdn4EXnnQN0L
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

Fix units to milli degree celsius and milli percent for temperature
respectively relative humidity measurements and thresholds.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v4:
- Add explicit formula into comments of hdc3020_thresh_get_temp and
  hdc3020_thresh_get_hum
- Add explicit division by 5 into calculations in hdc3020_thresh_get_temp
  and hdc3020_thresh_get_hum
- Link to v3: https://lore.kernel.org/r/20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com

Changes in v3:
- Fix verbose comment for define HDC3020_THRESH_FRACTION (Javier)
- Embed prescale into define HDC3020_THRESH_FRACTION to make the division
  by 5 calculation in threshold calculations explicit. (Andy)
- Add resulting units into comments again in hdc3020_thresh_get_temp and
  hdc3020_thresh_get_hum (Andy)
- Link to v2: https://lore.kernel.org/r/20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com

Changes in v2:
- Added explanation what is wrong at the moment into commit msg
- Added define HDC3020_THRESH_FRACTION and comment at the beginning of the
  code.
- Use MILLI for instead of hardcoded 1000.
- Link to v1: https://lore.kernel.org/r/20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com

---
Dimitri Fedrau (2):
      iio: humditiy: hdc3020: fix units for temperature and humidity measurement
      iio: humditiy: hdc3020: fix units for thresholds and hysteresis

 drivers/iio/humidity/hdc3020.c | 73 +++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 30 deletions(-)
---
base-commit: 875e7d357a7f2e77a7f3fc4759d0aa0872c33027
change-id: 20250820-hdc3020-units-fix-91edbb8ccd07

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



