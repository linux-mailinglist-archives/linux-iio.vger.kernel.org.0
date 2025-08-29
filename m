Return-Path: <linux-iio+bounces-23365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D444DB3B9EA
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 13:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50ABA21E30
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33F313E0A;
	Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lndkYn6C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B430311587
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466721; cv=none; b=XEOWSP0rbAha0WR+GqZD2GsY1IEDQGZcj2oyuzhR2rHCQfTTWOX3pvEtRYU2bMjdXWj+kvPIA/LzrJKvQPDUb2P8e5HPtJUXMxfKHU0XrTVeWHnk9i2aK9BXswDwLJPPCEVMKn1m0a1R68oIQUOVo74a3ye0W6SMh71a7jJOvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466721; c=relaxed/simple;
	bh=8Vyww7EQjVxSrLC8Qxb5QsMUALlT3Pfmz8BWK671dh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBePhvSqTUzaCC18dlP6S2yhGfJJ87VFDM2HnEemTnb3gysdx6IubW/dSNeMJGJWv0mlX7wyVS1421EmRBVRNz65B9D8P7uaS6GFovi1c7EePCy+c/3Q+Soz0cq7L/6FSwjgocxvnYRhcXIXq2FjxeOS3bmv2vduUcVXbEa1Nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lndkYn6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E01EC4AF09;
	Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756466721;
	bh=8Vyww7EQjVxSrLC8Qxb5QsMUALlT3Pfmz8BWK671dh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lndkYn6CUa4GUR0EE5qgmXnJrpWKQBllPhJOtgkwBlQyz3cNKzuzrv93aWxwrl6j4
	 rfVhBn4tAtM+QErGsjNtrhOODLt6nAr1ElaTomN+8vO0D5bJRDty49g3vjEYnbUTO5
	 4+pNK1oo3WfDbVl6xmN4haQggWkd6zjh6/EoVnkFStyFcL3dQhhnEyxAddEj2W+RTj
	 JxVyQ8MZzgR2EQaZoERW8qTRcdEJEkTjiJX7sueFepesDkCcNd1DfQuXtk2jmx7YSc
	 m2nKuzxjm50l82KiAAq2nnENXj7rncb9NCFlDjWWa4HT1ntOWjXRYNDUmczc3uMCS1
	 8PewinriNC4Zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315DFCA1001;
	Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 29 Aug 2025 12:25:43 +0100
Subject: [PATCH v2 2/2] iio: frequency: adf4350: Fix
 ADF4350_REG3_12BIT_CLKDIV_MODE
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250829-adf4350-fix-v2-2-0bf543ba797d@analog.com>
References: <20250829-adf4350-fix-v2-0-0bf543ba797d@analog.com>
In-Reply-To: <20250829-adf4350-fix-v2-0-0bf543ba797d@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756466743; l=1107;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=SEribMCTyRhjHbFbiMgxBRvJs0kZrg1X8F3ZYiKK3jg=;
 b=T8rECER14OX50SHkKm5lPSB91hgx7zC3e2ygMX1Wq7S3b1/M9GSVSGIXY/CIWDNelslg9KQSl
 3jNkIqMH83wBbRVOZdaUcH7LZfJV7KykpNBET05KcJqCECPrkDJn8D+
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Michael Hennerich <michael.hennerich@analog.com>

The clk div bits (2 bits wide) do not start in bit 16 but in bit 15. Fix it
accordingly.

Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF4350/ADF4351 Wideband Synthesizers")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>

---
v2:
 * New patch.
---
 include/linux/iio/frequency/adf4350.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/frequency/adf4350.h b/include/linux/iio/frequency/adf4350.h
index de45cf2ee1e4f8278a02cb2efb1540662023d9fb..ce2086f97e3fcf609d77de0bc2c15d5d47f7baae 100644
--- a/include/linux/iio/frequency/adf4350.h
+++ b/include/linux/iio/frequency/adf4350.h
@@ -51,7 +51,7 @@
 
 /* REG3 Bit Definitions */
 #define ADF4350_REG3_12BIT_CLKDIV(x)		((x) << 3)
-#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)	((x) << 16)
+#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)	((x) << 15)
 #define ADF4350_REG3_12BIT_CSR_EN		(1 << 18)
 #define ADF4351_REG3_CHARGE_CANCELLATION_EN	(1 << 21)
 #define ADF4351_REG3_ANTI_BACKLASH_3ns_EN	(1 << 22)

-- 
2.51.0



