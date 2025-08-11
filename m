Return-Path: <linux-iio+bounces-22589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33935B211C5
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C636E18A3B0E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1A2E2EE5;
	Mon, 11 Aug 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMz+7IX4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0E12E2DF7
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928796; cv=none; b=XhRyF6HXM1AJGbI0H1jf/cgzklpauVMjml0s5g9fu24EWFbEEGSwUcBYel+axoGGWltPR5+fde4CmWSzXIvBa9Z+AYEKjSjEZN1+u+46rJZKPoREzuCEIed9PiyXKXLedJcb5ZbZoEujkclUgvY310jzHUN/A2UyoAD+VMPJEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928796; c=relaxed/simple;
	bh=+Df2drSKTyoMtBD6YgdfqCmjjvCQR4Z65dlcfnHHX78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d6Gra2RHlV3QRMYtQqIdrgbna3Yg4jehNT16Vlc/rP53piumWMY4vgeo8Yp8nJJh8jkz77qlOc4nTVr8EHMxuYmkFgY5Bp6O9mmG1BrhxEjj8kQDIaUfQ9yQZdlTKZz1WcSrLJUejx1wMIUiQT0nYasa7b3ibMLIveNaJ39i7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMz+7IX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C061C4CEF5;
	Mon, 11 Aug 2025 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754928795;
	bh=+Df2drSKTyoMtBD6YgdfqCmjjvCQR4Z65dlcfnHHX78=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lMz+7IX4xkb9Qf4jXGpashanmkcbh0D66+qCosvRFug0RpXAjx5RjT02HdLcJBh+c
	 WlWUcoU1zmECdM/ODsSzKj+0FQKy0O9tT4aEv3mzytTKfvAzHzhHvzjEl3zGYHUOxf
	 RUiD6tgUrTrD6TzctKD4Iqm9oJT12yghIHhfeaVyMdMFtrMAcXDNiZwxw9IemL2lS4
	 7MsficjpipxAVI4afCGWDiItMBuaAqtsVY9nvhrDyowMDvs6fYsatFJCAYpUmXRJJY
	 XJOfVYXHmW6G8+qXecEP+oPj3t53TNAN4AddEuZ5pNAjXV67/4CrOHBGBz9JOA3Kzb
	 guOALz7JnXfBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACD2CA0ED3;
	Mon, 11 Aug 2025 16:13:15 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 11 Aug 2025 17:13:33 +0100
Subject: [PATCH] iio: dac: ad5791: drop unused member of struct
 ad5791_state
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-ad5791-drop-unused-v1-1-3412fbf3ba36@analog.com>
X-B4-Tracking: v=1; b=H4sIAKwWmmgC/x3MQQqAIBBA0avIrBtQSayuEi1Mp5qNiWIE0d2Tl
 m/x/wOFMlOBSTyQ6eLCZ2xQnQB/uLgTcmgGLbWRg1LogrGjwpDPhDXWQgGt9/1gVzIkJbQwZdr
 4/qfz8r4f0pcWf2QAAAA=
X-Change-ID: 20250811-ad5791-drop-unused-7cc487be5e00
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754928813; l=1147;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=eEVAzCPM7yfEsfF5RWo92Lj/29oz7CO8jQ0lqSzGt/A=;
 b=h/WxbWTKo0SfKADn1E9AkucLND6zkmB1FG7AWrfXQ5ewRsj3no4KwyQdS0dn+b3Ns3+BDVDhC
 f48vZ4EZwNjAnE5D2yIHMq2glYMG1wGkG4zowjhPMcNhTrb3KwyYxO3
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The regulator pointers reg_vdd and reg_vss are no longer used. So drop
them.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5791.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 41582f2b90fb9d83ff82ccb27a0eea92d9d9b431..ae7297f083983bb606fa3763370c05da7c2fd6f3 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -80,8 +80,6 @@ struct ad5791_chip_info {
 /**
  * struct ad5791_state - driver instance specific data
  * @spi:			spi_device
- * @reg_vdd:		positive supply regulator
- * @reg_vss:		negative supply regulator
  * @gpio_reset:		reset gpio
  * @gpio_clear:		clear gpio
  * @gpio_ldac:		load dac gpio
@@ -100,8 +98,6 @@ struct ad5791_chip_info {
  */
 struct ad5791_state {
 	struct spi_device		*spi;
-	struct regulator		*reg_vdd;
-	struct regulator		*reg_vss;
 	struct gpio_desc		*gpio_reset;
 	struct gpio_desc		*gpio_clear;
 	struct gpio_desc		*gpio_ldac;

---
base-commit: 856d7be7f3c459a6d646b1f8432c6f616ade0d10
change-id: 20250811-ad5791-drop-unused-7cc487be5e00
--

Thanks!
- Nuno Sá



