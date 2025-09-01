Return-Path: <linux-iio+bounces-23598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BA7B3ED86
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F09C7AC65C
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F159F320A04;
	Mon,  1 Sep 2025 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctRaIrGE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB842747B;
	Mon,  1 Sep 2025 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749136; cv=none; b=cWCMH1a3EzpbqRmdYhVEsmi9i+RLsOIAhqrRCCVQs5dNslqffkFOHwCPa575Q3kpFFVnqR/BB92ks2+5Rd7b6PWICr146DkllvowwyJyDFKG+mDdlGlCtXJZxJhhAmvecNMpV28DM5qF5OcKoQ8ZvfqWbS0BNb/5BxstZGE8yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749136; c=relaxed/simple;
	bh=b7XeZ+yEoGgw2FiGDgxL+MvBGZvfBENVNCCoMU6n2Y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T4bMzlC4LDM6nzJa8FDjg67Rv3M9idhmw1yfZC28wY7K6ey9947+DFoBRBaACkV1aRW4umdx65ngRcwk/zxQb5g0QTanXg1VlVQ2L5V3auoT8jNKuLXq8htG2y7svsT3kQA8bVoQqElcQyOi1jyRgMwEPrpsLAgUeA5Rgx1K7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctRaIrGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27DE0C4CEF0;
	Mon,  1 Sep 2025 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756749136;
	bh=b7XeZ+yEoGgw2FiGDgxL+MvBGZvfBENVNCCoMU6n2Y4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ctRaIrGE8NImJnPYBwV3TsTO6V0y1SXMQ67QKH+e6S2leJxlrJcZ1LYHe1HAfcmp0
	 42hHHpbwylNpEv+76jlBdlFvHqGhM8ar1SefnvmZU2sZuMlNQxVG+ovY9IzlYDZhTv
	 aterO8Xhz5T5CJR21XtnAF3GxSdBmS0+S9XfDgNDZ9c6OE/ZwzqvHOHZD3jh+wLwKd
	 iGeNyNJB1ts3G/UsNunFxFOhZpm888PUgKGwKKL1rnPV01SNfrrRg8gpgR1y4aP7uT
	 H3gSeKt7Xi5Pt6/UmRK9+BDyMa4RN5XJwpdn9vQnqNCUQz/9mIXLtqJKBqa/F/CBIs
	 QCb6n41Sou4LQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E1DCA1000;
	Mon,  1 Sep 2025 17:52:16 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v2 0/2] iio: humditiy: hdc3020: fix units
Date: Mon, 01 Sep 2025 19:51:57 +0200
Message-Id: <20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3dtWgC/22NwQrCMBBEf6Xs2cgmIVo9+R/SQ7NZzYK2ktSil
 Py7seDN0/AG5s0CmZNwhmOzQOJZsoxDBbNpgGI/XFlJqAwGjcPWoIqBLNZ8DjJldZGXOmgO3rd
 EAfdQd4/EtV6d565ylDyN6b1ezPrb/mz6j23WCtWu9+jJOkuOTzdhHzmlLY136EopH19pgTe1A
 AAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756749134; l=1003;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=b7XeZ+yEoGgw2FiGDgxL+MvBGZvfBENVNCCoMU6n2Y4=;
 b=on697vJOMkKbcrDcOkYR+jTCEAaR3wXJJy0eKOKDuUHi4IYHL0ItLVdBGojnBoDwaTOqiYzXO
 +VkMYRzL02+Ds9cYv/PhsvzvfoAKp2RiclKK7UUAwMelWxZL5APREQo
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
base-commit: 43c0f6456f801181a80b73d95def0e0fd134e1cc
change-id: 20250820-hdc3020-units-fix-91edbb8ccd07

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



