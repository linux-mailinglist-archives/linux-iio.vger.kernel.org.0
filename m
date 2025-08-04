Return-Path: <linux-iio+bounces-22238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E142CB198DC
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 02:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D2A3A554D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 00:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABE1DD0C7;
	Mon,  4 Aug 2025 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmD6fIxr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301A18CBE1;
	Mon,  4 Aug 2025 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267799; cv=none; b=KabNN3wdb4Hv2U1rwL14RrDjOg59zERhnMjwShy+M1olsoIjKieLFGS5f38x1/tci9I8DVtIboHYIg+YzLocmbD9w7WzcfEHiWc7vFz6roaggMC62dslH4Gi6UnHaThVZpzY3XB1vhHTchOTrUtnCIzhNm0Nz3FZVhKBcykwBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267799; c=relaxed/simple;
	bh=fHAaocERp0YyMO0m6xZVOjH5fnGKNvGMKTFMKsUKMPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFbLlEjDq+N6GPtX5mv8fOha+pT/pLB01ByV6fS7cD+VFJ/qYy28RCBXz2Kbf5Exapuc/MM4oj2vWMlwvjKWyP/3pGwxOOvXDWEFiOwQWwlojfhKDmOB/uvvI6Zi98cfdGQ2ZK4Rot+bxEjRLN35PISJZwqp6CzK/NxZGemq7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmD6fIxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AACFC4CEF8;
	Mon,  4 Aug 2025 00:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267797;
	bh=fHAaocERp0YyMO0m6xZVOjH5fnGKNvGMKTFMKsUKMPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmD6fIxrVS43CFpHPvyvnxI33AsfJYvz+2jI7AY7LyGaIWwZwNcxF3LlR7hCBaTzZ
	 sfy6In+XNEjoLw3GMmCT+cUBElYUTt9DcC+hTeMrtSfNQ6Vrfp7BGMBfdPjUiWVmDE
	 cJiGT4oUDD3j6exDBVpd5BDhX++pckB9AGpXNWogULYzxMEQ2xsLFZBhBnkOxVPKQn
	 X/p0IXcWuhoYniZa2aH1M74cQ52f3kv/G9/YKkeCyLI0CnG6+NoCWw67ky1lLwUPf+
	 55of5o9cDE28v/GUAGt4hqLM53LIMxdWNKs3Ry/3EUk9pJyqhlP6mEOWa8UlJas0as
	 JVJxNYA8bn8Aw==
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
Subject: [PATCH AUTOSEL 6.6 57/59] iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement
Date: Sun,  3 Aug 2025 20:34:11 -0400
Message-Id: <20250804003413.3622950-57-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003413.3622950-1-sashal@kernel.org>
References: <20250804003413.3622950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
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
index 967f06cd3f94..e147eaf1a3b1 100644
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


