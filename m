Return-Path: <linux-iio+bounces-25881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA83C31E0C
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D115F4F658C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701532D0EA;
	Tue,  4 Nov 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmVKr4tC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD02320A0B;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=QbevHQbcUErjxoC/rk58Kt+faXG4adVywUbNnKDIikMC+0kB8mtvQb5MMat2n7e9x58nwwvjUYa8MTeq4llXWmFKZeJTINcwqpoA2EFJXefuQ8PXi2yyBy8T9Ha4kCWEM19160WsgG7OuaVKzJuXwEM72hi9n15nE8y8S8O0Vhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=4t2qiqVO/ebBMcd2b1+NGvX8wwMj8L79dfzXZ/fjTRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evD8jWVe77yf/4wvf29SEU8kItWM0kG+bR+FRFm2WmV2B6hGX7nm838qwKJjwCvgOS6FrbL5ItBifMX7Qi7tvoGK0WJnye0gKaikpyN2Nrmgc3SltWAzdj6ah+uTtHQ8s2wG/QtyQTds+YD/r1+RefRgZhAiWXGalCY32A8Cg/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmVKr4tC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D7B4C2BC9E;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=4t2qiqVO/ebBMcd2b1+NGvX8wwMj8L79dfzXZ/fjTRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dmVKr4tChJQIMNoKRcnnjkbsfvWYJAXNeEcBzRXyzh/cGUSmwmgTX/tRHQeKfAs7v
	 5QneViwj4Kw9L5GNhqM82qz2FjNEMRdFtiChuyu5UmOw3jC/HWP/HIY+HLbYQTod5L
	 l/ohtepYMznTSHktKMGEefbRpNPwb2ca/RHLaria+nbOeR2P89oFERCOXbZxF2LbX1
	 jYV8i9gRn/Y8b0A97i+rMM5hn6H7UFM3a9VFTYlpgc/GhxEsWcvlzbzzqJYpoDK5tU
	 Lz8onv/cCfzM+gOHvuR8M1VHs0lwMTguKvBE2j3R1GUlDjsPAda6KEAG1vdyNoceHK
	 t8YYXyLOLMQwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B7CCF9E3;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:16 +0000
Subject: [PATCH v4 11/12] iio: dac: ad5446: Fix coding style issues
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-11-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=2276;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=wp+ds6Uvm1OufbfcraCAfstJKrBi0o/vRLt8tzG3osc=;
 b=Ra8MnTbB19a9ryIbzdigMOXBDH64qNT1ZIlMTbB2Kyk759J3dEEV2BFnv0CTPXE2Nm/RBuWsT
 VtfnqS7NwfzBY9q2OdOB8T40jzBwCWDbCaNtVQYTaVQbXe6AFop4eIM
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Fix style issues as reported by checkpatch.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 0556ce78c2f6..46a2eadb1d9b 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -28,7 +28,8 @@ static const char * const ad5446_powerdown_modes[] = {
 };
 
 static int ad5446_set_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int mode)
+				     const struct iio_chan_spec *chan,
+				     unsigned int mode)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 
@@ -38,7 +39,7 @@ static int ad5446_set_powerdown_mode(struct iio_dev *indio_dev,
 }
 
 static int ad5446_get_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
+				     const struct iio_chan_spec *chan)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 
@@ -53,9 +54,9 @@ static const struct iio_enum ad5446_powerdown_mode_enum = {
 };
 
 static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
-					   uintptr_t private,
-					   const struct iio_chan_spec *chan,
-					   char *buf)
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 char *buf)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 
@@ -63,9 +64,9 @@ static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
-					    uintptr_t private,
-					    const struct iio_chan_spec *chan,
-					    const char *buf, size_t len)
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  const char *buf, size_t len)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 	unsigned int shift;
@@ -147,10 +148,8 @@ static int ad5446_write_dac_raw(struct iio_dev *indio_dev,
 }
 
 static int ad5446_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long mask)
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:

-- 
2.51.0



