Return-Path: <linux-iio+bounces-2497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6885227C
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 00:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CADA1C22518
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 23:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EDE5103F;
	Mon, 12 Feb 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zHC3UF1u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A45024D
	for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780480; cv=none; b=TNrCB8I2XZN3qAcXSKd2Jx+qw8slh/5a9HGHjRRusbFXvRyKbcwpzWkT/waxf7VB5WJmukmFyePbhURu14NVJEhgnFdaW3WK8G4PrlBwFw9sBR/Dxncu736HrnzCw+exM+afVrRH2ZIhgzvOiKCcsa5fqQ0iwXVukLLHPoV2Dug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780480; c=relaxed/simple;
	bh=pBodro6qaNPwfsk7dgSwBHvtNf3EfyqOH3QDD8d7KSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKrI1AkDZ6AFtumRCwr10VdR9E/6gg/LvpZAA35f5HOBARSPY8vJfQvDfA/2km9V/25ZV5u1zLK4z3e6zgWP5YagkZVDNBXCpG8wHKiFakCugPpPr3hoiJqNrH10jQWtQ/r72oHvx54WPTVW0o+BA8xZrogL/r0P0YUAdVkL07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zHC3UF1u; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-214ca209184so2564482fac.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 15:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707780477; x=1708385277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CDnTfe6nvQ55r7IK52xXS4oQavI5ZjAWN4vgbC1X28=;
        b=zHC3UF1utFRvV2eeuI5NDvbRyHfqNRzSFM2J5NeqV1z2TtEnv3xSfnoC7fAHWNmgTk
         j3viZjPMUYq85mIRDvQtSTXgbP7ov0P8BnO8rkJ6fZpAjbEq4a1jyCxrsXdwcRbwR9Pr
         4D942dCs3wiTR5eqZCRqaftgXkZPylUYG2qqjOSD3cdmosQZoOPuO1eg5UX03pIqCce4
         lD51Cq5aPHOk2efC+1DjBk8qwpug2P6x+uWw3tw9ZzH3ThhGwEmqlxaOD+5zMrKLzfQj
         Cv4UUXxv5UaKWycyDls4HheEHGOS9+92o9Ssd+ZybX0sNkMxurOUoUPRMPqVZHk7e0Uo
         Q08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780477; x=1708385277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CDnTfe6nvQ55r7IK52xXS4oQavI5ZjAWN4vgbC1X28=;
        b=hdSFBaIaCm105C3jV/ixPFePqUG2XHH2uWPrkmv5zsUO8NlizvHgVHXdAzeeK8IEr2
         tQjYzj4vMyr2VjeF6+eFt46XImr8LKmrgoJ79VzeXOaGhoVXUEkfZ6Kg4yRTIoljDk2e
         XJ4U9E5TB22sTN/gW2Q421mL0dI+b2pBV49Wdd6Nyv2155CzxcZgOPWP/sOFUVZeYrnU
         NmnLVCbSxv6YEj884aGPFIJ+jaEY7OS9b8AhJKo5jiFssFNNUDKbDW5eTbbPRTn3Gvjg
         14s3zKyFtSW/xiylXNEj729tlUZuWYXUMwGS2fAHyHQMYVcvDBmSAOD7KIZkklOi5c+3
         64ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVg/+NDvzXCP/7xgRKq/M4fC3YKHidS3f8WJ4TaftYTTw4PmRfW2XHiBE5ilvlG46ZF4FnDz1K+TyTSNn6JqvWtKZ9y/O8WA2a
X-Gm-Message-State: AOJu0Yy71hXiof5ilEVzZq4YTzDI07dXWZlGlG4m6cGBa0GFPuZpyDxN
	+JJkpZuFNeJMyqtiwn55DhRioP2z+A1fo070CzikQfZ54DmV19tI/iNWVqNSDUk=
X-Google-Smtp-Source: AGHT+IFB5BMY94ESp7KJjpv5JdpAU/tpvbuYuXHw2+mNPbkI1Ukm6LHnu4zxTlzwR9ndeIJuVaW/DQ==
X-Received: by 2002:a05:6870:c98e:b0:21a:47fc:4bcf with SMTP id hi14-20020a056870c98e00b0021a47fc4bcfmr8244258oab.29.1707780477681;
        Mon, 12 Feb 2024 15:27:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmAThv/8juXzf9mfLJyIKEgmDljh/Todw+KLIUx9gxl6haVS4PiqGhAXBBBtWjETVMr9PyQP32dLRyjAN/ELx2NsQX+J2CVBwF7rElKMmqRAGrSWTy0bpITdFHUKav9sX2g1m8B0PokQONqbek1aATCqIPG/6OFwYqjxh54DYpJRslItxMr0xXT4k+OBtPQbk2PgR2SVYRDiI51YKp6Jpnm5q2He9K2KJq+ige12IGcyYJeq+AwC2gZ+pPlZijbO9dCkgHWU2QaDWASE5mDCJgc7/+NAkeTE2Sg+nxaXR8yMtF3KBGjGwDYOPJNPzy3s6rFm79s5zxIUH/Hv/qqxwC4pPjC8ta645ynQAqa3XhikPFza9zF6ALx05/XuhBaHG34Nwq3bz2U88bl5uAqU5N00yJRy4KNq3i07oDEtSGUHhtHsSZngncZ99/PaGJxD/5JnvbkC19EZftclOQobnbO8MfFWmK1ghtKjQ7vnSJQ3jQvFbx/KMC+PNXlrmxOucutnfCsfbOmFY7bhwXgoZckU2oVao=
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pk17-20020a0568704c1100b0021a7a45e0b1sm330141oab.35.2024.02.12.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:27:57 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 4/5] spi: axi-spi-engine: move message compile to optimize_message
Date: Mon, 12 Feb 2024 17:26:44 -0600
Message-ID: <20240212-mainline-spi-precook-message-v1-4-a2373cd72d36@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

In the AXI SPI Engine driver, compiling the message is an expensive
operation. Previously, it was done per message transfer in the
prepare_message hook. This patch moves the message compile to the
optimize_message hook so that it is only done once per message in
cases where the peripheral driver calls spi_optimize_message().

This can be a significant performance improvement for some peripherals.
For example, the ad7380 driver saw a 13% improvement in throughput
when using the AXI SPI Engine driver with this patch.

Since we now need two message states, one for the optimization stage
that doesn't change for the lifetime of the message and one that is
reset on each transfer for managing the current transfer state, the old
msg->state is split into msg->opt_state and spi_engine->msg_state. The
latter is included in the driver struct now since there is only one
current message at a time that can ever use it and it is in a hot path
so avoiding allocating a new one on each message transfer saves a few
cpu cycles and lets us get rid of the prepare_message callback.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index ca66d202f0e2..6177c1a8d56e 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -109,6 +109,7 @@ struct spi_engine {
 	spinlock_t lock;
 
 	void __iomem *base;
+	struct spi_engine_message_state msg_state;
 	struct completion msg_complete;
 	unsigned int int_enable;
 };
@@ -499,17 +500,11 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int spi_engine_prepare_message(struct spi_controller *host,
-				      struct spi_message *msg)
+static int spi_engine_optimize_message(struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
-	struct spi_engine_message_state *st;
 	size_t size;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (!st)
-		return -ENOMEM;
-
 	spi_engine_precompile_message(msg);
 
 	p_dry.length = 0;
@@ -517,31 +512,22 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 
 	size = sizeof(*p->instructions) * (p_dry.length + 1);
 	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
-	if (!p) {
-		kfree(st);
+	if (!p)
 		return -ENOMEM;
-	}
 
 	spi_engine_compile_message(msg, false, p);
 
 	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
 						AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
 
-	st->p = p;
-	st->cmd_buf = p->instructions;
-	st->cmd_length = p->length;
-	msg->state = st;
+	msg->opt_state = p;
 
 	return 0;
 }
 
-static int spi_engine_unprepare_message(struct spi_controller *host,
-					struct spi_message *msg)
+static int spi_engine_unoptimize_message(struct spi_message *msg)
 {
-	struct spi_engine_message_state *st = msg->state;
-
-	kfree(st->p);
-	kfree(st);
+	kfree(msg->opt_state);
 
 	return 0;
 }
@@ -550,10 +536,18 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	struct spi_message *msg)
 {
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
-	struct spi_engine_message_state *st = msg->state;
+	struct spi_engine_message_state *st = &spi_engine->msg_state;
+	struct spi_engine_program *p = msg->opt_state;
 	unsigned int int_enable = 0;
 	unsigned long flags;
 
+	/* reinitialize message state for this transfer */
+	memset(st, 0, sizeof(*st));
+	st->p = p;
+	st->cmd_buf = p->instructions;
+	st->cmd_length = p->length;
+	msg->state = st;
+
 	reinit_completion(&spi_engine->msg_complete);
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
@@ -658,8 +652,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
 	host->transfer_one_message = spi_engine_transfer_one_message;
-	host->prepare_message = spi_engine_prepare_message;
-	host->unprepare_message = spi_engine_unprepare_message;
+	host->optimize_message = spi_engine_optimize_message;
+	host->unoptimize_message = spi_engine_unoptimize_message;
 	host->num_chipselect = 8;
 
 	if (host->max_speed_hz == 0)

-- 
2.43.0


