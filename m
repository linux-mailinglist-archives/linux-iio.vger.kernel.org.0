Return-Path: <linux-iio+bounces-25747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F07FC25059
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C3634F4CC7
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DE83491C5;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSOANCeu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788833031D
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913862; cv=none; b=Gy+1YqMY4txCT0jPrRjtD+HJ8uHuOr3ydcn6FX5B3dPaWiRYdrzKZYiy9+Npkg2tFPOsUMOzfYWQ1hE0Mow9oKhwEUWvUWKPFacs7P69yWlI4eWJwYrFgS/cc3yCuRgQg2ENHO+nf4Ykq+qly0QSvSrvq64OX1ZZFawO+X5pzEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913862; c=relaxed/simple;
	bh=z2lRDLdFlsmgOkIc4nH0Z6iUuX88oc8E0HDC8HY20bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryIlw3C7CFvd3+VuUdsvTZdbk/N0rD3P+TAoniLtpSfnU1BXH7iAtXvXrXuPBWgVKEpTiM+VRPMGUmWwF7uUxEu3vklmUDu670OdeD+kfIMxHDRsD5GrlAkjYyaFqSQmwzMtgyQro27qS42N3LsjJUR401gieC8Yil2n8Rnbf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSOANCeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49A98C19423;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913862;
	bh=z2lRDLdFlsmgOkIc4nH0Z6iUuX88oc8E0HDC8HY20bg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dSOANCeuU7RkqXHv6Q6A/3jhTr19FiK23qw0qyDttz5RllDGzqL5n3RcJjV/Q+tHF
	 LMtSDaGklYPLScuatRsOYqLyM8/qi8NtenhWwWbiwlzyFWqZYt5mILH1xO4q8EzK+8
	 TSzS9/+SALQAuy/NyaEWKV8LFSHfudPQoc7wJ5HUjYghbKTQMmBfV/24bMGXsgFghu
	 DqoMIuGQYfBgbX5uwJWUW5NY+5axixSZoQxbuzKln/lhB/avq5cdPb7lx0bHKqWMKn
	 +WgP5MaY/0GBsqhjZi0xG6hWaoXV9UUpbElCcU/zJqvG9P6aoati64lvQamItk0ryF
	 mGoAZeOOh/y/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42695CCF9FE;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 Oct 2025 12:31:31 +0000
Subject: [PATCH v3 10/10] iio: dac: ad5446: Add AD5542 to the spi id table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-dev-add-ad5542-v3-10-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
In-Reply-To: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=1707;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/OfQFB0/UcOV1OFJoyHe7o8DYKnhhHQOcnOWnnCI1R4=;
 b=dDgW35FgKe1VnCQUTlWgGLcTZtPpheOgVbI1ADIVZGFMM+TMZ50k02iAT+UkF2JOjPOAMf5cl
 XJlnVSlE/p1BgGgWXj8YvKk76s8fHlPdz5Qgpra2o4WRNugpozaOLd+
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Michael Hennerich <michael.hennerich@analog.com>

This adds support for the AD5542 single channel Current Source and
Voltage Output DACs.

It is similar to the AD5542A model so just use the same id.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Co-developed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446-spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/ad5446-spi.c b/drivers/iio/dac/ad5446-spi.c
index 7419b17a455f..34d4a737156d 100644
--- a/drivers/iio/dac/ad5446-spi.c
+++ b/drivers/iio/dac/ad5446-spi.c
@@ -177,6 +177,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 	{"ad5453", (kernel_ulong_t)&ad5446_chip_info}, /* ad5453 is compatible to the ad5446 */
 	{"ad5512a", (kernel_ulong_t)&ad5512a_chip_info},
 	{"ad5541a", (kernel_ulong_t)&ad5541a_chip_info},
+	{"ad5542", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5542 are compatible */
 	{"ad5542a", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5542a are compatible */
 	{"ad5543", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5543 are compatible */
 	{"ad5553", (kernel_ulong_t)&ad5553_chip_info},
@@ -213,6 +214,7 @@ static const struct of_device_id ad5446_of_ids[] = {
 	{ .compatible = "adi,ad5453", .data = &ad5446_chip_info },
 	{ .compatible = "adi,ad5512a", .data = &ad5512a_chip_info },
 	{ .compatible = "adi,ad5541a", .data = &ad5541a_chip_info },
+	{ .compatible = "adi,ad5542", .data = &ad5541a_chip_info },
 	{ .compatible = "adi,ad5542a", .data = &ad5541a_chip_info },
 	{ .compatible = "adi,ad5543", .data = &ad5541a_chip_info },
 	{ .compatible = "adi,ad5553", .data = &ad5553_chip_info },

-- 
2.51.0



