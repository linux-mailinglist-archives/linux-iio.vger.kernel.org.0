Return-Path: <linux-iio+bounces-22241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6225AB1997B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 02:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D0A177B2C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 00:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC921D86D6;
	Mon,  4 Aug 2025 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU6rtVYm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCB13E898;
	Mon,  4 Aug 2025 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268143; cv=none; b=S3YlfLjkS4/x9h63eSFOAPjjVakIhh9DD57J9bMwJC05BD0uMGNjtIXSexvgHSoG5Z//QlfHq8idLfWFocfD7Zp0zzy16R4vnW/U/n9eAEr76X97Jy3K2B20nnDpkHXxhq5jwayI7Uk73VJVU3crnG5yckyqUjPIS7/z6oQI4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268143; c=relaxed/simple;
	bh=FRN+ypN9VkurbjU55mYY7bPHV8Z+ejrLS96rmhEaUpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KB4yIGi+/SgTujtZQGO4v6uLRKlrI1Vvm1lkCa2Ro8/ERxOoImWkNAilj8xp+5l6+kUTEXmMeR2ubkyedDLcXp8cENcB2KbesfImrfny62jX/M7kvAPtO61aWjt1sX+SQHmC6GHENJXTPpiKJ0k+Bv6VRsrHpz6jcBdBCqnQFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU6rtVYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14117C4CEEB;
	Mon,  4 Aug 2025 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268143;
	bh=FRN+ypN9VkurbjU55mYY7bPHV8Z+ejrLS96rmhEaUpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LU6rtVYmCemPqyVrXPlRc2Ah1ia2nr0olX6X1OKR2VkK9nmwFny0h+5o4KwvWN02b
	 DG7I0TFltNDcyi3cDbE1wy8ZaDwWEWuI/OcOW2Yc7azlSp2LKmTof8HJZ40NTWfXFz
	 MIjQNOJ4ZVPACk2BoeJPFgcapL5+d91sSbEBimkIoJs9T3reZL1N1o/8vrMU+xHQMi
	 wRr8UjK9OBB20RlWfSXObAs6t/+BUgkHCbMr//tP6vBKI+gzw/21xHigRAwhJo+on6
	 uPajKbVU7ikB1+F23smsHZCPh39pjFJNH+XEmwMka0zlxtVu3q0XBIS+fjFRmUAKLn
	 7Dea1beLYpuwA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jonathan Santos <Jonathan.Santos@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 38/39] iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement
Date: Sun,  3 Aug 2025 20:40:40 -0400
Message-Id: <20250804004041.3628812-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004041.3628812-1-sashal@kernel.org>
References: <20250804004041.3628812-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
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
index 9580a7f7f73d..883399ad80e0 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -202,6 +202,24 @@ static int ad7768_spi_reg_write(struct ad7768_state *st,
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
@@ -287,10 +305,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
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


