Return-Path: <linux-iio+bounces-27104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C0CCBF7D0
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 20:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 099D53033D51
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA373254B9;
	Mon, 15 Dec 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlAWs7fo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C33246F1
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825708; cv=none; b=RpCSXF/ueUeqKSoERL0cJGg2g8dM2Uo7NKR0ZAxsdFwvcMvRGjZxBwoy8ltZLUpyC4qmBt3tRj/ofe/Xg9Ye9oJ32DA3WbCW9BVHgLNXUXlAi7PeLh5tpJKpkx6EGQk6BHs5GqMQKH+56C3ydlEPbedWCcnh2rFduuhCcnhkOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825708; c=relaxed/simple;
	bh=uU7OENtzXKECTKQSkAzvF0eLB9qTkElZq5tAR8cyNRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4g1mxiGQZ9f3UbXDk7N/dF9lATwm1J9t3kNSI2lO5W07tYpTKfkbTKC5bdckLG8YPIPfStWk/Gl3r4zRmOCi12uSaS1PMkV9fgW/KYJYJ/rMCG5Gh31E0q7dFTb0AhBP73iBhss0YG9TR0hUHWECZ/sqH/RYFwe8dzrVXADRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlAWs7fo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c718c5481so1392100a91.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765825705; x=1766430505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZf1cPmp+HYv/PsDFv+aHzx5S8bO5A1kue00pJ63iq0=;
        b=HlAWs7fofnXHY6Mtm+okbjAgYk9uYDbyrLS8polOuRAYKzhWlHCbMrfJ8PNPq3waTY
         XwtRyQmFYGDlkHm1UjOQFlrxBFLaf5nHVoS/ISI4Nn6HIApBghuMM9xzpt4DRFUl2mD3
         mJw0/xfiLrv6u1HiV6jbWzPMV9k+SAC0I4zhKO7fcaUSnmhc5B9l/nTZlkEvHk+gDrEe
         aaKzQe5YTvnnbCsrxH8AitmI4+H9CFXKo5afR1u6STiOtr+Bn1oS1GRJfAE7qfT3ojcu
         tb/oomtV7LmavWylEUz8dPgD37YV7qp5j8ZRIEcZSe/RRaj58jnrgaI+Xge9pjl1mU4D
         q+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765825705; x=1766430505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZf1cPmp+HYv/PsDFv+aHzx5S8bO5A1kue00pJ63iq0=;
        b=MBSTJlTACG2u6CY0vQs14P0ogGb5E8VjyTs2Hgwxeij0KlrXg5c5SugCFrUhAtMmDl
         ASYjkXBso3Yv2uB9R+FvXkczkRED+6XfW4w5ueXR/WKLDaqdn5ap1KruR7uYixICifxl
         MhZw89aJ4LWDvpN6pob2WOjMWQ29doQXK+ZGScbukmDZlVgaEbUn6la1EfUKzWkTQESl
         BGcFH+CvFZW/Xl3/yCGq1vCwwR7Jx81YlUuLK8/j0O/I3JjQ0A4jbL6z5FQAfiQew42z
         HDTo2Q16A9oM3fI+qQUI6E4mVDs/cMURLwTK+KU8Xnp3vGH4BpI2d2MO4s8gAAB28CSX
         O5RA==
X-Forwarded-Encrypted: i=1; AJvYcCUUthzSmfxxneaz+bilRiQPvwSUKR0Khf3kTjHxCf3JZ9ApLQm2cX9F6AX/2OqTswr0cKmSQpzTKYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ADXxQolOFGvtD5wZ7YK3Nt1IGAkPn7bpjjYdQ9m1p7dJZ8kS
	8Ybu5WobCcvmKtHWLY6Af7nGZxymCKpJYLFIAq3n6jg7rW+3NXKixg6S
X-Gm-Gg: AY/fxX5Vr2dEcefEy92NfghnVMGnY9LtdmT/rY3kfyhEKPNsdhtwHvuBMaIqbv8U3FS
	9eHlnNMA9qNqipX53C2s5XMEay6ZNMm1EAS9GsJykzznsn7yZIHRq2NU75m9PlnZtIQ3ui+l/YR
	TrxbwtsS2KuI9cg4hRPNSx0iLHHFmb2kFdci4lMtHpcCw+bo9uCoe1u+YklTGlKeK3fdPQEkM02
	Adw1S37sT1aygAIGWB9fnER4M9gkDsPSeajPKUqMMYkAP5NRT6icOHe4wxeG0xiRc6qeXSlphpb
	O4CqqZx/MsUOUMyQ6RzrSQu93P5OxL6T+P9/bzqactlZrh3Rh6Ci4tj3X8qMclzYxq1shREI23o
	8hAzIE6JYIwVb2qaLOI5r/J/DJC4ii5Otd92z/J756KpygUwVm4htF9Sg1b6P3rgPmgDON2F4K9
	+eATKNauhfDDpIB/FwO5B7HkJdbQ8sxKe6EvrBZC15MRo5T7LnKK0SJFCQzIBnwvwn8as0QgZiq
	QumzawFzN1ILwmBcN3hO78kD8CLR4SgbE2X302v3yAAP0qnN3dkrrAw7UfRhygbBMNTn+GF
X-Google-Smtp-Source: AGHT+IE1WHBGKS5Crjv50TkhZLgC5nwsvUgWqEC2DP/ihf+BGAvru2jl2wS75dfjHzuo+OIWArU9NA==
X-Received: by 2002:a17:90b:5292:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-34abd77ecd1mr9894199a91.26.1765825700591;
        Mon, 15 Dec 2025 11:08:20 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2948d1sm9958875a91.9.2025.12.15.11.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 11:08:20 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH 1/5] staging: iio: ad9832: clean up whitespace
Date: Mon, 15 Dec 2025 16:08:02 -0300
Message-ID: <20251215190806.11003-2-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215190806.11003-1-tomasborquez13@gmail.com>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary blank lines between comment sections to improve
readability.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index e2ad3e5a7a..00813dab7c 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -26,7 +26,6 @@
 #include "dds.h"
 
 /* Registers */
-
 #define AD9832_FREQ0LL		0x0
 #define AD9832_FREQ0HL		0x1
 #define AD9832_FREQ0LM		0x2
@@ -50,7 +49,6 @@
 #define AD9832_OUTPUT_EN	0x13
 
 /* Command Control Bits */
-
 #define AD9832_CMD_PHA8BITSW	0x1
 #define AD9832_CMD_PHA16BITSW	0x0
 #define AD9832_CMD_FRE8BITSW	0x3
@@ -90,7 +88,6 @@
  * @phase_data:		tuning word spi transmit buffer
  * @freq_data:		tuning word spi transmit buffer
  */
-
 struct ad9832_state {
 	struct spi_device		*spi;
 	struct clk			*mclk;
@@ -327,7 +324,6 @@ static int ad9832_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default messages */
-
 	st->xfer.tx_buf = &st->data;
 	st->xfer.len = 2;
 
-- 
2.43.0


