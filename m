Return-Path: <linux-iio+bounces-17550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC63CA795B3
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1A87A2F77
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36481EA7D5;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC4e/79q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785411E5B8B;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621305; cv=none; b=nBqwtQzjtQ6fOr5+N1ZRe09C0As586lz+3f0O2B9SaitKp73W/FxDnUy3JGH2F5NX5MQe6SjMfbZyR14a5l3b+eEQEZbacj89oEKE8cxmJPYbQgQ21MrlRH74hSeipAR1evXduJ3lEaKm/Dvh7KmvlZZlfPkTHxoDs6sZ0xcW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621305; c=relaxed/simple;
	bh=Cfri1NLIzlUgZilRlHcF6Uc8bZB/2/S835fUpiVCEG8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CNkRR4LhpXhCOVwqWBsr7B7QHij2MYlDnftOBkeRDmGIeyYDgD+YmSijiA9LUdLAHgtzaIQhlNvyHjnKZhz1DOAIUVrsE07ey8C2JEjn2Hivxb/aXrgh8ya3eqxAWRUEzuR87OfGHtqvrSXNwUHHOkRpllD8Fs6wnF7RUuIJGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC4e/79q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E602EC4CEDD;
	Wed,  2 Apr 2025 19:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743621305;
	bh=Cfri1NLIzlUgZilRlHcF6Uc8bZB/2/S835fUpiVCEG8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cC4e/79qpde9MOTLi/aW07upCIKiF0VAxJRvkt9qlS73es0zfaxeJ2DaRW6hzSjlK
	 9+FXMSTSWDmOGAEcJNFUuGZkrlp+B1inA78Zh6zZydXeuupC55E9yG3fwO8RFTIvjv
	 Mq3byWjlYwLBIAnbAmpIpKSe3qTVNGJbczaqh613Sksr1T5WQSFTTcayhTvzaLbuY5
	 DfrpC/JYAfoC5N6khGf+S+HS5p9D5f3BaHKFun2WTThOCVBDzZIgnK0rzyrtH13321
	 cX3leNX3g1xmt/hMYcqcnN9+CizWkYz4Y9OmKsRTCXLmSXCM9O7Wv5nUQ5MRyXRQat
	 gu7JOF0dvXnVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF3CC36017;
	Wed,  2 Apr 2025 19:15:04 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 0/5] iio: light: Modernize al3010 and al3320a codebase
Date: Wed, 02 Apr 2025 21:14:12 +0200
Message-Id: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAISM7WcC/32NQQ6CMBBFr0K6tmbasVJceQ/josIAkyiQljQo4
 e4WViyMy/eT9/4sAnmmIC7ZLDxFDtx3CfCQibJ1XUOSq8RCgzaAYKV7IiiQzL301LzcIAFtSQ6
 L2ppKJG/wVPO0NW/3xC2Hsffv7SKqdf1Xi0qCfJxzbdCQ1QqvPPF4LD9ibUW981Xxy9fJV6gg1
 0UF5rTzl2X5Arjh/xHwAAAA
X-Change-ID: 20250308-al3010-iio-regmap-038cea39f85d
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Cfri1NLIzlUgZilRlHcF6Uc8bZB/2/S835fUpiVCEG8=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7Yy2OJq9mTFL96N/Fw3kTF1F7S/tllq1bbteS
 1f06jEzeaCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2MtgAKCRBgAj/E00kg
 cqp4D/9rC1CkpeBs9N5PZlrTlGgeR1Caex2oJyaDmfKIYtJknSCVfJJE9eXHrkd4Lq33sPTwR1Q
 oyn0Tm2Ej1Ca5DxgBTeMbDG00KZOBFECTv+H0QgwB3zLJRmVi4Ua1F92syzWAhjFM6N2zoYRB0h
 wz5Cnuf8MhcUMfZcY4ZK5mVt+sRD/z8PbB2I1fjXrJzC7j7FOkFOmEQgEBIeEwkKI1K6yDN95Bu
 6MtSzfEPH7HTu+V1o8omsMJPrB/x2ptthgnztBDLKBHZqj4Xsi6kMRGCiGu+7J1eq9P2gUBnZ/S
 6wfIFinlzWvC/rF32x2SQZr0JE+s7GpiHSFndbSTu7Rr6g24OsgBrocSgqhqRAeW/zc7A6DxjZg
 2qemO+7z+3EOiIOmJskJW/Po1PZOZekyeRZEtQmL8QjvK34hqYn5A3CGavAbqkSbbh15N7WXu0D
 IvS0u5E6jaczlcS9aBDtPncp7kIV3cAjA+iq779rq9kwum0lP3sIMrjr80j0Wn2ZE6aAYARFXOg
 YN16VnaLzVHUtVcC+1/iP+KvJizQxB1aeYTwLfOhbSdJe6Ji5a1K4L/jjBjgif3slYixUEiDpe6
 +2XSk2/vOZffHExSjgk4PEpmCzI6+yIPpQ/o57xES9IlfH/Qy31pFWiRlUYuHF/I3vRNGiC3aZG
 RhjSMrAH4zPmdKA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

This series aims to improve code readability and modernize it to align
with the recently upstreamed AL3000a.

Apart from slightly improved error reporting, and error handling
there should be no functional changes.

Module  before after
al3010  72 kB  58 kB
al3320a 72 kB  58 kB

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Stripped patches merged from second version of patchset.
- Dropped iio: light: al3010: Move devm_add_action_or_reset back to _probe
  in favor of opposite approach moving devm_add.. to _init for al3xx0a:
  - iio: light: al3000a: Fix an error handling path in al3000a_probe()
  - iio: light: al3320a: Fix an error handling path in al3320a_probe()
- Link to v2: https://lore.kernel.org/r/20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz

Changes in v2:
- Dropped Daniel's email update.
- Dropped DRV_NAME introduction for al3000a
- Added DRV_NAME define removal for al3010 and al3320a.
- Splitted unsigned int conversion into separate patches.
- Replaced generic value with specific raw and gain variable.
- Use dev_err_probe() for error handling.
- Separated devm_add_action_or_reset move from _init back to _probe.
- Dropped copyright update.
- Link to v1: https://lore.kernel.org/r/20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz

---
David Heidelberg (5):
      iio: light: al3010: Improve al3010_init error handling with dev_err_probe()
      iio: light: al3000a: Fix an error handling path in al3000a_probe()
      iio: light: al3320a: Fix an error handling path in al3320a_probe()
      iio: light: al3010: Implement regmap support
      iio: light: al3320a: Implement regmap support

 drivers/iio/light/al3000a.c |  8 ++--
 drivers/iio/light/al3010.c  | 80 +++++++++++++++++++++-------------------
 drivers/iio/light/al3320a.c | 90 +++++++++++++++++++++++++--------------------
 3 files changed, 98 insertions(+), 80 deletions(-)
---
base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
change-id: 20250308-al3010-iio-regmap-038cea39f85d

Best regards,
-- 
David Heidelberg <david@ixit.cz>



