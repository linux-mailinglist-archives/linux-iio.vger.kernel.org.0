Return-Path: <linux-iio+bounces-17554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30222A795E3
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4674D3B172C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D91E7C03;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe2YXHXR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A044D2AF19;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622412; cv=none; b=a2tEfYWzfCPKxhfEUiG8dKbmmL5wxiUdyRLCEcgqUFyaiQSdu8qoKeEq/h/uZoFsES42zg4QPCubYghfQ0jCsM0YxPHcOCQrl/p1bTUHZsBuyBbEH2usMC8wd69WKxzPbzcS3+lJbZ1Voj2r6x1fTVhm/Lyf6iDCmCfV/rf8niw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622412; c=relaxed/simple;
	bh=h8tuvLDl3dyrMAHTp36dgdIbL6QYBpALFuJOwvb3DtQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kt26NzAPNoCuoA+ueqEWFzKfBIIx9gGHVJfPFUp11/al3vakpJMB63e5GJyXY5cMckED+dBREvAYJ0A9bC4tZ3kp3jkQ0S0RB57RYKGiPQkIL7kY8REwVGQAGZKTGy02Rfz6gy3puUHnbJ1mpYwEz+YzyCe3+zMsZwwxznMHIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe2YXHXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14078C4CEDD;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743622412;
	bh=h8tuvLDl3dyrMAHTp36dgdIbL6QYBpALFuJOwvb3DtQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pe2YXHXRWIEYKHul3DyG0W/0KfP3tuve826otuEOZouchVcNQf+yfecA286W8vnSM
	 Vps1UlVTQYn/CU46JZf3kOvzK89KNspswinzY2rwOu6emeu3XfKXHOVa1bf990XKGl
	 wL5qpJEKqyR0CaNCL7Tk9VS/n69T7jjIBA/V3kOdxKJMQODK64/1ag/BqR9FE0emPl
	 EEKo5GEAAlGUCCHe4afn9Kss0uyg1k2dR0BO2W8Dpe6b2TNmMUTe9t8SckWTNHnbI7
	 3Vg7WfA88aoLdokC+W7gW7XeyhwviN/5PCL5MVRIfSPGehpcqPX+IvpR+XSRIE2HV/
	 gyE6T+mEzIedQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3340C36018;
	Wed,  2 Apr 2025 19:33:31 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v4 0/5] iio: light: Modernize al3010 and al3320a codebase
Date: Wed, 02 Apr 2025 21:33:23 +0200
Message-Id: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASR7WcC/33NQQ6CMBCF4auQrq2ZzlABV97DuCilwCQqpBCCE
 u5uYYMxxOU/yfdmEp3z7Dpxjibh3cAdN88Q8SEStjbPykkuQgsE1ECQSnMnUCCZG+ld9TCtBEq
 tM5SVqS5EcK13JY/r5vUWuuaub/xrfTGo5fpvbVASZH5KUJN2KSq68Mj90b7FsjXgl1fZnsfgF
 SlIMCtAxz+eNh8D7nkK3loqDCaU6xw3P8/zByLKH7IwAQAA
X-Change-ID: 20250308-al3010-iio-regmap-038cea39f85d
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2341; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=h8tuvLDl3dyrMAHTp36dgdIbL6QYBpALFuJOwvb3DtQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7ZEJdW8z5YiN6QhjsBgTBRscuK546wMo+6Olk
 VdZn8oC+LKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2RCQAKCRBgAj/E00kg
 cvqUEADIYmKqGehh/rtSMJdz0ro0TLyKN6/f7m/2eQ03EGb0w4CeBqTKAKJxK1a6PfGDttTkkmo
 eQ21rH2Du1l4baXDGm02JvjCzRVMUj+qb4TbRvaH4+tm0sLLaSGtdyydQV2o20pXoA2l9kmyo0U
 G3wYLWfSSeomYLNROOPIhF9BdDav4ja9GQlo+/oNM+X3GIs2RXR7reLZy9X4DO3VjIvT76itLiC
 IMcJiXVNg60XBY52hibee2tPxfo5x/O+cWipMA9+KwRDNmw4b5GBj92Dme3tJB1nb/53oiIr4cz
 UV1FJKg5kCTVVG/IX3TaruRRMsRRNUJbpTNudh4FBm4TPOW5HOkvf6KpeGHDsSl3veuh9m2cN3a
 s3t6ZC8VQyviMZOMHr8JaDNT3hX/wxXVLqVlGFQiTXVt8H21oxIfWta+wxR39wNjERkMB089O6u
 etXU7giCX7P5jWaewiA5W4iaowZQPn6d8E6wTfc/ELrCTVsuiTjqms+m1INnbQu0qzxgZ5nkXSB
 cSALXFy3567me+KvsCdfjrsGbopWhvaawoYKOnxOnGoOUjxUFbzBIOl1o3X4ETcb9DGyHD4zfer
 kFH7kT0VZi55SQ5NgUeWLdkCq0ia4xYpW/IZKFT4ytZMnZfZVuaEXo7HHVMME+P2S5HTaER978t
 jj4Ok3tGrnWJf1g==
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
Changes in v4:
- Fixed mixed-up rebase changes between commits and added
  regmap_get_device into _init functions to get the device.
- Link to v3: https://lore.kernel.org/r/20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz

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

 drivers/iio/light/al3000a.c |  9 +++--
 drivers/iio/light/al3010.c  | 85 +++++++++++++++++++++++--------------------
 drivers/iio/light/al3320a.c | 89 +++++++++++++++++++++++++--------------------
 3 files changed, 100 insertions(+), 83 deletions(-)
---
base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
change-id: 20250308-al3010-iio-regmap-038cea39f85d

Best regards,
-- 
David Heidelberg <david@ixit.cz>



