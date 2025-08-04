Return-Path: <linux-iio+bounces-22240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D536BB19943
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 02:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF116FBC1
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 00:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5011EDA2B;
	Mon,  4 Aug 2025 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb2fREJq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590FC1EBA19;
	Mon,  4 Aug 2025 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268040; cv=none; b=Nj6DLXZ7DsaFiBD/CVMEEQy8xmEDRo3kq3RrOq+qaQxv+icOIySUnElQG46/8JiJWfKdXq5KBNl7sHC8Tkw7nazXZsIWvEEKiR6t3eTWdV5S3qUxgsqmtMZUQl4kiYyKlBhKSwtKH3CbC/0YglURHuZLcq/jBLdsh1fj/mH45SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268040; c=relaxed/simple;
	bh=3jMBFX5PGV09QaHVB1+rfIGI12NJtBhLppl5XSwKCnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jc+WJiO86+6JBfxkaWyGILic+i9H1R11foJ7n9824CZo98KsPprdMXqc4QGlTd4E+JMGCT00FvqIm5u/z5ZD/8r83jlrPGqGW8cZ4EvsxPRswr/J0kC29/8xIv/IzGdiUo7zXBvXQfaVWfG8ZVKdPIKVLNXCtKVT2+R+w8ENbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb2fREJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DEEC4CEFA;
	Mon,  4 Aug 2025 00:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268036;
	bh=3jMBFX5PGV09QaHVB1+rfIGI12NJtBhLppl5XSwKCnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lb2fREJqI81hBWEW6DvOl5NOc+VM37jvQcyEBDexJR1ummdW6nNryWc4u/O/EdaiT
	 8IcB+2aezHyupaNfSfHEYNSUVwDZMq5C0FDA5bpdG9s6fMhwJjSKXLiIuzbNXvQte4
	 2mv10LCrldzk09T9IucG23k1hmlVBD/aYuPTHMXLuanJ6wZOWtpRkZ+itg5nBUnhRV
	 H0ZM0WwhNRdtceyC6vI1Hzp/Ww5uV7iVQAUXnWxCu+deszw4JEfV5OfEIInGlVWbNZ
	 HCxZ8hMfYRtp4F+1EajKBrY7VoN45grk05P4rv2MLTAxF6nN5GOx67rEcpMD1QqHEI
	 imvXn8d93Abww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jonathan Santos <Jonathan.Santos@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 43/44] iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement
Date: Sun,  3 Aug 2025 20:38:48 -0400
Message-Id: <20250804003849.3627024-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003849.3627024-1-sashal@kernel.org>
References: <20250804003849.3627024-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
Content-Transfer-Encoding: 8bit

From: Jonathan Santos <Jonathan.Santos@analog.com>

[ Upstream commit 7e54d932873d91a55d1b89b7389876d78aeeab32 ]

The SYNC_IN pulse width must be at least 1.5 x Tmclk, corresponding to
~2.5 µs at the lowest supported MCLK frequency. Add a 3 µs delay to
ensure reliable synchronization timing even for the worst-case scenario.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/d3ee92a533cd1207cf5c5cc4d7bdbb5c6c267f68.1749063024.git.Jonathan.Santos@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

**1. Bug Fix Nature:**
The commit fixes a timing violation bug where the SYNC_IN pulse width
was not meeting the hardware's minimum timing requirement. According to
the datasheet (as noted in the commit), the SYNC_IN pulse must be at
least 1.5 × Tmclk (MCLK period). Without the proper delay, the
synchronization pulse may be too short, especially at lower MCLK
frequencies, causing unreliable synchronization.

**2. Specific Code Analysis:**

The original code had a critical timing issue:
```c
gpiod_set_value(st->gpio_sync_in, 1);
gpiod_set_value(st->gpio_sync_in, 0);
```

This creates a pulse with essentially zero width (just the GPIO toggle
time), which violates the hardware specification. The fix adds:
- A new dedicated function `ad7768_send_sync_pulse()` that ensures
  proper timing
- Uses `gpiod_set_value_cansleep()` instead of `gpiod_set_value()` for
  better reliability
- Adds a 3 µs delay using `fsleep(3)` to guarantee the minimum pulse
  width

**3. Impact Analysis:**
- **User Impact**: Without this fix, users may experience unreliable ADC
  synchronization, particularly when changing filter decimation rates or
  when operating at lower MCLK frequencies (0.6 MHz)
- **Worst Case**: At 0.6 MHz, Tmclk = 1.67 µs, requiring a minimum pulse
  width of 2.5 µs. The original code provides essentially 0 µs
- **Data Integrity**: Improper synchronization can lead to incorrect ADC
  readings or timing issues in multi-device setups

**4. Risk Assessment:**
- **Low Risk**: The change is minimal and contained - it only adds a 3
  µs delay and switches to the cansleep GPIO variant
- **No API Changes**: The fix is internal to the driver with no external
  interface changes
- **Conservative Fix**: The 3 µs delay provides margin above the 2.5 µs
  worst-case requirement

**5. Stable Kernel Criteria:**
✓ Fixes a real bug that affects users (timing violation)
✓ Small, contained change (adds one function, modifies one call site)
✓ No new features or architectural changes
✓ Minimal risk of regression
✓ Clear hardware specification violation being fixed

**6. Supporting Evidence:**
- The driver has had multiple previous fixes backported (as seen in git
  log with "Fixes:" tags)
- Similar timing-related fixes are commonly backported for hardware
  drivers
- The AD7768-1 is an active production part used in data acquisition
  systems where reliability is critical

The commit meets all stable kernel criteria for backporting - it's a
clear bug fix for a hardware timing violation that could cause
unreliable operation, implemented with minimal changes and low
regression risk.

 drivers/iio/adc/ad7768-1.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index e240fac8b6b3..c518aeb35c70 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -203,6 +203,24 @@ static int ad7768_spi_reg_write(struct ad7768_state *st,
 	return spi_write(st->spi, st->data.d8, 2);
 }
 
+static int ad7768_send_sync_pulse(struct ad7768_state *st)
+{
+	/*
+	 * The datasheet specifies a minimum SYNC_IN pulse width of 1.5 × Tmclk,
+	 * where Tmclk is the MCLK period. The supported MCLK frequencies range
+	 * from 0.6 MHz to 17 MHz, which corresponds to a minimum SYNC_IN pulse
+	 * width of approximately 2.5 µs in the worst-case scenario (0.6 MHz).
+	 *
+	 * Add a delay to ensure the pulse width is always sufficient to
+	 * trigger synchronization.
+	 */
+	gpiod_set_value_cansleep(st->gpio_sync_in, 1);
+	fsleep(3);
+	gpiod_set_value_cansleep(st->gpio_sync_in, 0);
+
+	return 0;
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -288,10 +306,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 		return ret;
 
 	/* A sync-in pulse is required every time the filter dec rate changes */
-	gpiod_set_value(st->gpio_sync_in, 1);
-	gpiod_set_value(st->gpio_sync_in, 0);
-
-	return 0;
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_set_freq(struct ad7768_state *st,
-- 
2.39.5


