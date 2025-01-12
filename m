Return-Path: <linux-iio+bounces-14188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93993A0A913
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05921632E9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86171B21A6;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRjfI51w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF972A1B2;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736684780; cv=none; b=VjYst2/5n8L3Re0KzyVa39v2DAMwY9mEdHrZJ0kx29WoW/xnJYfNnMXO6mEumqUdgbW+nGSBgE3aD77RaIx1zRrz1hROYtAZ5fdFBAdoRaS++IZo8ivV2qmwWElhOGof3A1+nhhomZDVTpsbtEuUQBxyBawllqVQf1brCSrVR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736684780; c=relaxed/simple;
	bh=e0ydEge+kSwWNQjHzk+12rYyMrffoSe8Ys0yrFFY5Yc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DgiTh6G8LDnii26nGJ9a4hlxOxiixBwi32hZ6iwq60j8BB51GgWRnIYPrOhLs5hVuMktoQZlmA5AAcW5Edsqdphb77K4We+CO1WFIWIyRkS9yG1YytdNCTmWtZHFV/JsJiRzJjyrR8IjJk0TsPuuQ4Nvf4+Fx6NQfwoD7FID3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRjfI51w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24292C4CEDF;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736684780;
	bh=e0ydEge+kSwWNQjHzk+12rYyMrffoSe8Ys0yrFFY5Yc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NRjfI51wn2c4xdOSt/XX/bUpjts67k4+vELrPMfBp1BV6xy7qWZ/9iFtmAo34Pldp
	 tlsCjfr8mIEIsN1Bv3/RyKMv84qJoHrYNHKdRDrWsg5Gkq/u5jlC0WzL02tHgzITWR
	 slUOQnyvyyjraXAiNVgw4J24HFEhAz03LmFL/DCcHQKTjSNZZ00AYl0y7MZ8u7xIiK
	 kxInpsrnHNiw8JAKOMZCR/5cghQqTb9J/BEVF+BQlaJMa9jO2bdA6Ex/0I3fqII3Ea
	 6OBVEQJV5CWcW+wONpNMyl3q5MikEYeNz7fMuwbo7dwx/evA2Iqcba0LSNFqOBNPlA
	 4aJ+/V80Nd/1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17494E77188;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Subject: [PATCH v3 0/5] iio: accel: mc3230: add mount matrix, of match and
 mc3510c support
Date: Sun, 12 Jan 2025 15:25:34 +0300
Message-Id: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL60g2cC/32NQQ6DIBBFr2Jm3WlApZqueo/GBcKAkygaaEgb4
 91LPUCX7+f/93dIFJkS3KsdImVOvIYCzaUCM+ngCdkWhlrUSkgpcdEcZg4cPC6mUVIYVLe2E7U
 bddt3UIZbJMfvU/ocCk+cXmv8nB9Z/tK/uixRoOpGUqLR1rr+4Utrvpp1geE4ji8i/3o+tAAAA
 A==
X-Change-ID: 20250111-mainlining-mc3510c-564702fba487
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=e0ydEge+kSwWNQjHzk+12rYyMrffoSe8Ys0yrFFY5Yc=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbt7xyabhccEjz2dU1S5LOHJX17J1/vfFE6J3O/vm3V
 isnXv38uqOUhUGMi0FWTJHFZqPHbLH8cMlJ054qwMxhZQIZwsDFKQATWbOLkWGOdt+SaetnO/67
 9ZRxk3jf2y+xtoLL44Vvcc3i3jeJ4epmRoZ3H3c/3xd0cc8sue1r3m7X4rvytFbFIqFitlVqosL
 G0NlsAA==
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

Changes includes:
- Add mount matrix handling
- Add match table to work with DT
- Add MC3510C support

MC3510C use same registors as MC3230, but different value scale.

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
Changes in v2:
- Ordered commits
- Fixed comment style
- Ordered struct members
- Fixed device table
- MC5310C commit splitted
- Link to v1: https://lore.kernel.org/r/20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com

Changes in v3:
- Fixed patch (poped stash)
- Link to v2: https://lore.kernel.org/all/20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com

---
Vasiliy Doylov (5):
      dt-bindings: iio: accel: mc3230: document mc3510c
      iio: accel: mc3230: add mount matrix support
      iio: accel: mc3230: add OF match table
      iio: accel: mc3230: add multiple devices support
      iio: accel: mc3230: add mc3510c support

 .../devicetree/bindings/trivial-devices.yaml       |  2 +
 drivers/iio/accel/mc3230.c                         | 93 ++++++++++++++++++----
 2 files changed, 79 insertions(+), 16 deletions(-)
---
base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
change-id: 20250111-mainlining-mc3510c-564702fba487

Best regards,
-- 
Vasiliy Doylov <nekodevelopper@gmail.com>



