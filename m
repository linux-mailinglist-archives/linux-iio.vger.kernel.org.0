Return-Path: <linux-iio+bounces-23020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B181DB2D04F
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 01:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349C51C41E14
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 23:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E302749F2;
	Tue, 19 Aug 2025 23:45:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4E1946DA;
	Tue, 19 Aug 2025 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647111; cv=none; b=NYrDoJliCZeFpULTIYuVpxHT54uMn3iVctH8jfLbcbFBwyj3QBJe8iNkj4XBMJZPGDQ0SLZUpkZOV5TQEoe0ONvf0/kJ9OsnO2DjMrl7EBvElIvK47ythMIsa7sQNKMYL1ZU7kQdwqdQ9lOdRcdXu3RCAvkdIEnRJ7JJ3oW2OhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647111; c=relaxed/simple;
	bh=0zl+xmSP90bSJstTHuN3X/0ilSQX7J+FqJm/7KXxDTE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b0+XIzeD8QFwa+NGaFld8ciYNgMNrMmJIbktuXQ04N8Qe6mAGNw5xDxvCU2TNPGwICyCr+yFYZN8d1trqE61xnepaLzfVgkIKEfR1pOcKL5o2vb9sxXx/MVClci7f6aGQVWhDc2Ir3JesthnX0Mz6B5fAtt3E52Sl3WF6Hvox+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
Subject: [PATCH v7 0/5] iio: mcp9600: Features and improvements
Date: Tue, 19 Aug 2025 19:44:41 -0400
Message-Id: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGkMpWgC/yWNQQ6CQAxFr0K6tgmiyOBVCIsydKQJjqQFY0K4u
 40u3/t5+TsYq7DBvdhB+S0mr+zQnAqIE+UHo4zOUJVVXYZzi9tiqzI98T8bxtBSCrfmekkEng1
 kjINSjpOHeZtnl4tyks/vp+uP4wsjnUJydwAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Collins <bcollins@watter.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Migadu-Flow: FLOW_OUT

ChangeLog:
v6 -> v7:
  - Separate out the mcp9600 IIR series into its own series as there is
    a lot of conversation around implementation (removed related
    comments from this changelog).

v5 -> v6:
  - Fix accidental typo added in dt-bindings: IRQ_TYPE_EDGE_RISIN
  - Correct some constraints in dt-bindings
  - Reverse if/then for mcp9601 vs mcp9600 constraints in dt-bindings
  - Updates to changelog for patch 2/6 (dt-bindings mcp9600)
  - Cleanup tabs that were converted to spaces
  - Split thermocouple-type default to separate patch

v4 -> v5:
  - None

v3 -> v4:
  - Based on feedback from David Lechner <dlechner@baylibre.com>
    * Allow fallback compatible in dt-bindings for mcp9601.
  - Based on feedback from Jonathan Cameron <jic23@kernel.org>
    * Be explicit in patch description for fixed width changes.
    * Check chip_info for NULL to quiet warnings from kernel-test-robot
    * Remove "and similar" for long description of MCP9600.
  - Set default 3 for thermocouple in dt-binding
  - Rework open/short circuit in dt-bindings

v2 -> v3:
  - Improve changelogs in each patch
  - Based on feedback from Andy Shevchenko <andy.shevchenko@gmail.com>
    * Set register offsets to fixed width
    * Fix typos
    * Future-proof Kconfig changes
    * Convert to using chip_info paradigm
    * Verbiage: dt -> firmware description
    * Use proper specifiers and drop castings
    * Fix register offset to be fixed-width
    * u8 for cfg var
    * Fix % type for u32 to be %u
    * Make blank lines consistent between case statements

v1 -> v2:
  - Break into individual patches

v1:
  - Initial patch to enable IIR and thermocouple-type
  - Recognize mcp9601

Signed-off-by: Ben Collins <bcollins@watter.com>
---
Ben Collins (5):
      dt-bindings: iio: mcp9600: Set default 3 for thermocouple-type
      dt-bindings: iio: mcp9600: Add microchip,mcp9601 and add constraints
      iio: mcp9600: White space and fixed width cleanup
      iio: mcp9600: Recognize chip id for mcp9601
      iio: mcp9600: Add support for thermocouple-type

 .../iio/temperature/microchip,mcp9600.yaml         |  59 ++++++++-
 drivers/iio/temperature/Kconfig                    |   8 +-
 drivers/iio/temperature/mcp9600.c                  | 146 ++++++++++++++++++---
 3 files changed, 186 insertions(+), 27 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250819-upstream-changes-c89af86743fa

Best regards,
-- 
Ben Collins <bcollins@watter.com>


