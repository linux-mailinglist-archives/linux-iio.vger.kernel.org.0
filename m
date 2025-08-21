Return-Path: <linux-iio+bounces-23109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B29B2FE8B
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2AE1CE7E9C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BBC2D063E;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbiVPoNK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5D275AE4;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789853; cv=none; b=tPNGopbs5RgaAWsW+jR3qz1goHDgFENR/xJ4OQMH8zdA0CrY9xJ5XG2mVuGkcOxPJlopZVWTJ3ducFWiBDvFo5k1UB6q1y5zJrb2mm9Jeh41MaGF+aqq45/LGm+T0mMcM8jw8RC6p3VhwP6JZSFpCBxD9mBTIu7AhpBC8gueyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789853; c=relaxed/simple;
	bh=j5HMtzj02bE7jOzvhivWK4JuewQ6uKDmB/pcYi4qcJA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F3JxAy0nWac77EnWHV1cOWV/xKm3/f5X0vvJXSxhZL9IbWjRnWdS9/VOgNle8nMBkXTC5VwYXs96GZnHZwjJQIxYS6yoFnYd3BN4+45ETyXYgF/873GJEAM14YRHyE00bZ7OswsU4DWTR/7M4qlCaFAvEBeiSrtZ2Ekp88NHOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbiVPoNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FE0CC4CEEB;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789853;
	bh=j5HMtzj02bE7jOzvhivWK4JuewQ6uKDmB/pcYi4qcJA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IbiVPoNK7y4ufGx9tMj5WkZKM1e8mErIoPfwXarSQll5foSBCFuTosfj/w8vc+zzG
	 w0b58qDZzcdBBuZgU/KS1QmcIii+FZxRQhvk4gGdwnd+RcgmUT2jDughVD9AjMK0Ge
	 EYHUSPuDAa2fC0wdr6Bm/LIq3F2OVIgDu1ItXCco/Vqn7HfXDdfaHTcN6aa43e38D0
	 Gr1xsLRi/ADaWom/C7bNN3ZKPnyA8GINlIMKtJSj78or2xuRKz3q2/ziMRyEE7G1D+
	 Y0fvYFwtkQ4c3i5pwHbtA2Y5OCKcpiPiqVFsnN31ZethmINSrsso6sVxRVsZyR1+b4
	 0c3GHTojxJYhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FC3CA0EFC;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH 0/2] iio: humditiy: hdc3020: fix units
Date: Thu, 21 Aug 2025 17:23:53 +0200
Message-Id: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAk6p2gC/x2MSwqAMAwFryJZW4gV8XMVcWGbqNlUaVWE4t0Nr
 oYZeC9D4iicYCgyRL4lyR5UqrIAv81hZSOkDhZtg51Fs5GvUXkFOZNZ5DF9xeRc5z1hC7o7Imv
 +P8fpfT/+WaSRYwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755789852; l=687;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=j5HMtzj02bE7jOzvhivWK4JuewQ6uKDmB/pcYi4qcJA=;
 b=4Rb/szGb6OxfFXpOylVFSLvZkCNBkkMeNtlU/nhO4B5VOB47d6xmHgFUAKQuKsTNEtCG+SGEK
 IERaq0i0Z1VDe1L7+XpbRuyp//h/PfbXN/lnxSipa6yKDXJ9vqPrnua
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
Dimitri Fedrau (2):
      iio: humditiy: hdc3020: fix units for temperature and humidity measurement
      iio: humditiy: hdc3020: fix units for thresholds and hysteresis

 drivers/iio/humidity/hdc3020.c | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)
---
base-commit: 43c0f6456f801181a80b73d95def0e0fd134e1cc
change-id: 20250820-hdc3020-units-fix-91edbb8ccd07

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



