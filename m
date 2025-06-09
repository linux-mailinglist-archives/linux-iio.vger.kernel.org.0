Return-Path: <linux-iio+bounces-20331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10386AD1F4B
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01C57A6993
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D9E25A328;
	Mon,  9 Jun 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvBeYeS+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB4259C93;
	Mon,  9 Jun 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476687; cv=none; b=ZfzLXIIyp1QR0/1mXtezliP9E1Gyr2QhaH3FOXjpZ8IkQ6tkr8wszSYDNxI/TANAORSkHILYLHCQPfAy28jHibl8NZnjg8HyraBlcwnjv/cyJF2wsrlwnXVOOPjXIQZnGsMCbdfmEimZUJwm7hZIigCukPn2quMDB1bbbT+OFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476687; c=relaxed/simple;
	bh=pJCzUmR773gYxvZ5iMaladAJs5P8lpHkrLmEWci9EF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNxgG++fkfV6Zr8Xk4sqrFy6SaNoYU7Du/XWRvmjQ0MI/Wws3Zc0AeIhv4fL75Oo2qSuu9iXSXsbd1i+2jkJFG4Uswqp6y5eEu0bEzmx+8B9F0qVn5S2CUc7UIMtGe8ecyK4K1sL+GzPea89AGGOHXbEL/Yw4c3fqcV1tibMX4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvBeYeS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F660C4CEEB;
	Mon,  9 Jun 2025 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476687;
	bh=pJCzUmR773gYxvZ5iMaladAJs5P8lpHkrLmEWci9EF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvBeYeS+yHpODDWkk/uwd7wTBWPi5mqISZ0nI4dc2+oleM/Gak0EYbLBeHAXLOW2X
	 K+OBwqZG8fvgssWVUYpVI2AbbKVI1Y0O+8uMIGSGrCuUC62xzKC+PtOUe6qjDUP+6q
	 ZKzzhcgGzb54sV7zhtDNtnpfj+5kIsRREDteasPTTvBVBAIAMyiMhdVozVZgMvZNeL
	 EOyZhqf2+LELcgg2/A6GATfC3HBO6L+WnuzoeNdsZ14Y/1AQlBcj6LSI6XXp6Jarbi
	 ib7DvZ2nvwRamEnXpUJMikDRTLf9/I3YbWuJLirvng5GiIqQ07J3Y1UULgjBk6PnXd
	 XvfoCeLpBztaA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	jic23@kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 24/35] iio: hid-sensor-prox: Add support for 16-bit report size
Date: Mon,  9 Jun 2025 09:43:40 -0400
Message-Id: <20250609134355.1341953-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134355.1341953-1-sashal@kernel.org>
References: <20250609134355.1341953-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.1
Content-Transfer-Encoding: 8bit

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit ad02ca57e44e9936fca5095840fad9d4b47c5559 ]

On Intel platforms, the HID_USAGE_SENSOR_HUMAN_PROXIMITY report size is 16
bits. This patch adds support for handling 16-bit report sizes for the
HID_USAGE_SENSOR_HUMAN_PROXIMITY usage in the HID sensor proximity driver.

Previously, the driver only supported 8-bit and 32-bit report sizes. With
this change, the driver can now correctly process 16-bit proximity data,
ensuring accurate human presence detection on platforms where this report
size is used.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20250317013634.4117399-1-lixu.zhang@intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the context provided, I'll now
provide my recommendation:

**YES**

## Extensive Analysis

### Code Change Analysis

The commit adds support for 16-bit report sizes in the HID sensor
proximity driver by adding a simple `case 2:` clause to the existing
switch statement in the `prox_capture_sample()` function:

```c
switch (raw_len) {
case 1:
    prox_state->human_presence[chan] = *(u8 *)raw_data * multiplier;
    return 0;
+case 2:
+    prox_state->human_presence[chan] = *(u16 *)raw_data * multiplier;
+    return 0;
case 4:
    prox_state->human_presence[chan] = *(u32 *)raw_data * multiplier;
    return 0;
}
```

### Why This Should Be Backported

1. **Important Bug Fix**: The commit message clearly states this is
   needed for Intel platforms where `HID_USAGE_SENSOR_HUMAN_PROXIMITY`
   uses 16-bit reports. Without this change, these platforms cannot
   correctly process proximity data, making the sensor completely non-
   functional for 16-bit report sizes.

2. **Minimal Risk and Scope**: The change is extremely small (3 lines
   added) and follows the exact same pattern as existing 8-bit and
   32-bit cases. It's confined to a single function and only affects the
   data parsing path for proximity sensors.

3. **Pattern Consistency**: Looking at the grep results from other IIO
   drivers, handling multiple data sizes (including 16-bit) in switch
   statements is a common pattern throughout the IIO subsystem. This
   change follows established conventions.

4. **Hardware Compatibility**: The commit enables proper functionality
   on Intel platforms that use 16-bit proximity reports. This is a
   hardware compatibility fix rather than a new feature.

5. **No Architectural Changes**: The change doesn't modify any APIs,
   data structures, or architectural components - it simply extends the
   existing data size handling logic.

6. **Similar Successful Backports**: Looking at the reference commits,
   we see that Similar Commit #3 and #4 were both backported (Status:
   YES), and both were fixes for scale/data handling issues in HID
   sensor drivers. This commit follows the same pattern of fixing data
   handling bugs.

7. **Clear Failure Mode**: Without this fix, Intel platforms with 16-bit
   proximity reports would fail to capture proximity data, returning
   `-EINVAL` and making the proximity sensor completely unusable.

8. **Industry-Standard Fix**: The commit comes from Intel (Zhang Lixu)
   with acknowledgment from the HID sensor maintainer (Srinivas
   Pandruvada), indicating this addresses a real hardware compatibility
   issue.

### Risk Assessment

The risk is extremely low because:
- The change only affects the specific case where `raw_len == 2`
- Existing 8-bit and 32-bit handling remains unchanged
- The code follows the exact same pattern as existing cases
- No memory management or complex logic is involved
- Failure would be immediate and obvious (wrong data values)

This commit clearly meets the stable tree criteria: it fixes an
important hardware compatibility bug with minimal risk and no
architectural changes.

 drivers/iio/light/hid-sensor-prox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 4c65b32d34ce4..46f788b0bc3e2 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -215,6 +215,9 @@ static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
 	case 1:
 		prox_state->human_presence[chan] = *(u8 *)raw_data * multiplier;
 		return 0;
+	case 2:
+		prox_state->human_presence[chan] = *(u16 *)raw_data * multiplier;
+		return 0;
 	case 4:
 		prox_state->human_presence[chan] = *(u32 *)raw_data * multiplier;
 		return 0;
-- 
2.39.5


