Return-Path: <linux-iio+bounces-2804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A49485AE8F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 23:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D0B1F2359E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 22:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A1D56B95;
	Mon, 19 Feb 2024 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fz19xTEJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEC5675B
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382102; cv=none; b=nMFG7Uc8aEM6Nhxz9JfxQ3YebpACRp6s/t6vNYtRb6m3PmBm34ldIopRviHsJiaeCcvsCA7vd6ywoFA1y1ktMAoecs9Xj2izGj5wIY7PUeZfvIspvt0nezG41blwVdi9cPZKl3PiAZ8Y1hnws/qCLr43/cKRje4cwdxdrxHqvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382102; c=relaxed/simple;
	bh=kNFrx8UJo78sQ8Q1iFWKP1SHsh62/7UZ71I45n2Sq1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtyHI+9jVngiSMP37nuo6BbBH+4LTJFIfTISdyRGGV5o3bqt+b2sZc1fcYfL1/M4M4v9AFhlgE/8MaTnU7ueaCgocsV3jSuJRxTPPdb4EPJHDl2Z1PSkxdhvOHaJm9zSaBq3JsFsEHT9hnV9m6sH5qE7ZqE1izwHSs1vDBNBqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fz19xTEJ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e432beab47so1755677a34.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708382100; x=1708986900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dm08qHNGM2q4SeLkv5aeyRrRYY/ISTOBJCodG60HdvI=;
        b=fz19xTEJjEPyxXMhuRnWPNX0N6BdtSeRoG3o7MjQb4S+cdF+bFyUdYzQw9pLbW1baW
         9aXdAVzIBIGuzG65DplGDXIa+9b5GgXEhfR21qu9IFnn0ctGl1BkDniL5oz4RAyFqfqk
         HDOXjkOZ/OLoD3L4KbbhQRMb4PppAI0BfGtTcj9lcGlFjTPscD0yGZvaxLA5C60509f6
         Bp4uVlvtjaa+TWTuur+2QjE/4OzcRaJLiYk3/QE7lQ5DnbKBjg+bnGG9xH1TDM7F+vmg
         wWW6GB5zwf7XbmkbZ5Q6x8p0Bzr8mLW2cSdgmIFErHWBZUUaxK+gyPpbeKgE6JCGbFkM
         O+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708382100; x=1708986900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm08qHNGM2q4SeLkv5aeyRrRYY/ISTOBJCodG60HdvI=;
        b=ABwiqnQ2UQkhr8YR+xhnVD1uSs09WofE6Hvls2hLrKnOaD1flfv9rgZY7vrjx/Ivog
         1mtsaLcaOmKCrG6JNZ86zjU8MLQQhjk04i8EX6ELxqq0c4ZnwIS4jumj06vBW0/RKu6k
         m8OYvlh0fo7+zgEPJiI3J1JzKKSFmTHgu4kBDPk2CpscrZffE8MCalcBcIcogafqGBJ+
         brEQ8lr7yOqxfNT0dtd39E9MUeFSvflyHTxf35p7S63P/Q4JgnnAv/L11eb+QuS5Ukbt
         xLvMQuUzLXeQ9lzgT8AJw/NarhAxh0ybSp6MM4CWrZ7oOjRAERLi/molqDLDN0vwj+Ee
         nZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSXxM5NZFVe0ksRZVPhCkfRzDmKg04imwl7rlIbokEiaSS+l6oxAAZtmo/gP+6WniGdmtu/+ixseRggw/FJgcB2onWlvvl2OjR
X-Gm-Message-State: AOJu0YypGqUi+r4lDIc1Rr62/EP+/r6zn43KzRAYZ01dS2H/iXEKSVmm
	r/NOit8+vZDmbihuEOE7L/LfVRv0v7bZTpUkKR1bGK7lH447+VsrlKvGMH+ciDU=
X-Google-Smtp-Source: AGHT+IG2NoaqjYoSMqFyQv2m8w5xifGGubCdc9CRgDcRHsj47qCzP+Zv0pGnImu1mhHHlHwc9JQGvQ==
X-Received: by 2002:a9d:7a93:0:b0:6e2:ec3d:f141 with SMTP id l19-20020a9d7a93000000b006e2ec3df141mr13211177otn.16.1708382100186;
        Mon, 19 Feb 2024 14:35:00 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id h25-20020a9d6419000000b006e45a5f0a70sm171776otl.49.2024.02.19.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:34:59 -0800 (PST)
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
	linux-iio@vger.kernel.org,
	Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 4/5] spi: axi-spi-engine: move message compile to optimize_message
Date: Mon, 19 Feb 2024 16:33:21 -0600
Message-ID: <20240219-mainline-spi-precook-message-v2-4-4a762c6701b9@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
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

v2 changes: none

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
2.43.2


