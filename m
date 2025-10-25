Return-Path: <linux-iio+bounces-25442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE426C09BCF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 18:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9710504A02
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4107F305040;
	Sat, 25 Oct 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O269B9FX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76A30DED9;
	Sat, 25 Oct 2025 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409431; cv=none; b=JK/oldzRH47rYXmLW5r+bXegjh+wHg3FfuPAJNIOxHizqnoB2nmSV6RwvtELZae0MPHREh0dOMrkau42jxLGCUbJbuGAZ/mF0AmXrLgYOhyjA1scb568qOHFOQy4OopD6P0r3wiL6nL1Yv4p1mmbWnkK1lneMANfD4rcOzRbu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409431; c=relaxed/simple;
	bh=f23byLex5qTKZihLp04M8Yh+LvShv/tsONbpGSrr2SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCf6lF7beKwLIClkToBWAwG4rF8boqi6Ul7afh53WgrTwJUWGjRXjWVsRV3inUVIeCrW4FRo8olg58sA/cQti+WCMnspF3rGjIfKSn5MIdlK8jULcRPM+QX9QCpTD8yMDb1tx8ykEcqNBlgNaSeba3qEbl6Dj9HbVeMv5ZbcYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O269B9FX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E604AC113D0;
	Sat, 25 Oct 2025 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409430;
	bh=f23byLex5qTKZihLp04M8Yh+LvShv/tsONbpGSrr2SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O269B9FXR2WbLz/6pFn4kdeJ/zOoOpvqKTokJoVMYRdYXBy2KxV5lItf0ByQ1FQGa
	 qX995N9GJjvFpvNAsScetea0nvVeHCY+ady3M1g5DdT1MDy/XFoh73StvwrXM0FxAh
	 ay3GoziuwhiQNy51YJ5baF0AUQ2ESpk7h6hQbTiWGongbdqpsNmJAg/T2wmu8k0+BN
	 KuOxD8ExSK0Vk5Q0MfgW4xRInR4Q5kM07blhYaG16ahXMEFQ7HZ1xAqXpnjRmsbMJO
	 uBCj/ROIT1aESCfcoWJ5EgbPligJUNL5vBoh8myFuu6T1KZy1NbbwcsVai/SyfKwj9
	 M5AkdEfoLZkZg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Cryolitia PukNgae <cryolitia@uniontech.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] iio: imu: bmi270: Match PNP ID found on newer GPD firmware
Date: Sat, 25 Oct 2025 11:59:14 -0400
Message-ID: <20251025160905.3857885-323-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cryolitia PukNgae <cryolitia@uniontech.com>

[ Upstream commit dc757dc1572d579c2634c05d0a03c5676227c571 ]

GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID.
When they switched to BMI260 sensors in newer hardware, they reused
the existing Windows driver which accepts both "BMI0160" and "BMI0260"
IDs. Consequently, they kept "BMI0160" in DSDT tables for new BMI260
devices, causing driver mismatches in Linux.

1. GPD updated BIOS v0.40+[1] for newer devices to report "BMI0260" for
BMI260 sensors to avoid loading the bmi160 driver on Linux. While this
isn't Bosch's VID;
2. Bosch's official Windows driver uses "BMI0260" as a compatible ID
3. We're seeing real devices shipping with "BMI0260" in DSDT

The DSDT excerpt of GPD G1619-04 with BIOS v0.40:

Scope (_SB.I2CC)
{
    Device (BMA2)
    {
        Name (_ADR, Zero)  // _ADR: Address
        Name (_HID, "BMI0260")  // _HID: Hardware ID
        Name (_CID, "BMI0260")  // _CID: Compatible ID
        Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
        Name (_UID, One)  // _UID: Unique ID
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Name (RBUF, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.I2CC",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
        }
        # omit some noise
    }
}

Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip #1
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Alex Lanzano <lanzano.alex@gmail.com>
Link: https://patch.msgid.link/20250821-bmi270-gpd-acpi-v4-1-5279b471d749@uniontech.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## BACKPORT RECOMMENDATION: **YES**

### Executive Summary

This commit adds ACPI device ID "BMI0260" to the bmi270 IIO driver to
support BMI260 IMU sensors on newer GPD devices (BIOS v0.40+). The
change is minimal (2 lines), safe, and addresses a real hardware
compatibility issue affecting users in the field.

---

### Comprehensive Analysis

#### 1. **Problem Being Fixed**

**User-Visible Bug**: GPD gaming handheld devices with updated BIOS
firmware (v0.40+) declare "BMI0260" as the ACPI hardware ID for their
BMI260 IMU sensors. Without this patch, these sensors are completely
non-functional because no Linux driver claims the "BMI0260" ACPI ID.

**Background Context** (from commit f35f3c832eb58):
- GPD originally used BMI160 sensors with "BMI0160" ACPI ID
- They switched to BMI260 hardware but initially kept "BMI0160" in
  firmware tables (causing driver mismatches)
- GPD released BIOS v0.40+ that properly reports "BMI0260" for BMI260
  sensors
- Linux needs to be updated to recognize this new ACPI ID

**Affected Hardware**: GPD Win Max 2 2023, GPD G1619-04, and potentially
other GPD gaming handhelds with BIOS v0.40+

#### 2. **Code Changes Analysis**

The commit modifies `drivers/iio/imu/bmi270/bmi270_i2c.c`:

```c
static const struct acpi_device_id bmi270_acpi_match[] = {
    /* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
    { "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
+   /* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
+   { "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
    { }
};
```

**Change Characteristics**:
- **Size**: 2 lines added (1 comment, 1 ACPI ID entry)
- **Scope**: Single driver file, single match table
- **Type**: Device ID addition (no logic changes)
- **Complexity**: Trivial

**Minor Issue Noted**: Typo in comment: "sincice" should be "since"
- **Impact**: None - cosmetic only, doesn't affect functionality
- **Note**: In Linux kernel stable backports, typos in comments are
  acceptable if the code is correct

#### 3. **Safety & Risk Assessment**

**Regression Risk: ESSENTIALLY ZERO**

Evidence supporting zero regression risk:

1. **No Existing Functionality Modified**: The change only adds a new
   ACPI ID that currently matches NO driver
2. **Isolated Impact**: Only affects devices that declare "BMI0260" in
   their ACPI tables
3. **Hardware Validation Present**: The driver
   (bmi270_core.c:bmi270_validate_chip_id) reads the actual chip ID from
   hardware registers and validates it:
  ```c
  if (chip_id == BMI160_CHIP_ID_VAL)
  return -ENODEV;  // Reject BMI160 chips

  if (chip_id == bmi260_chip_info.chip_id)
  data->chip_info = &bmi260_chip_info;
  else if (chip_id == bmi270_chip_info.chip_id)
  data->chip_info = &bmi270_chip_info;
  ```
4. **Defense in Depth**: Even if ACPI tables are wrong, the driver
   detects mismatches via chip ID
5. **No Driver Conflicts**: The bmi160 driver does NOT claim "BMI0260"
   (I verified via grep - no files in bmi160 directory contain
   "BMI0260")

**Security Assessment**: LOW risk (from security audit agent)
- Chip ID validation prevents device confusion attacks
- No new attack surfaces introduced
- Firmware loading security is a pre-existing concern, not introduced by
  this change

#### 4. **Dependencies & Backport Target**

**Required Dependency**: BMI260 hardware support
- Commit: f35f3c832eb58 "iio: imu: bmi270: Add support for BMI260"
- Merged in: v6.13-rc1 (verified via `git describe --contains`)

**Backport Target**: Stable kernels v6.13 and later

**Reason**: Earlier kernels don't have BMI260 support, so adding the
ACPI ID would be meaningless

#### 5. **Stable Tree Criteria Evaluation**

| Criterion | Met? | Evidence |
|-----------|------|----------|
| Fixes important bug | ✅ YES | Hardware completely non-functional
without fix |
| Small and contained | ✅ YES | 2 lines, single file, single driver |
| Minimal regression risk | ✅ YES | Zero risk - only affects new device
IDs |
| Clear side effects? | ✅ NO | No side effects beyond fixing the issue |
| Architectural changes? | ✅ NO | None whatsoever |
| Critical subsystem? | ✅ NO | IIO driver for specific sensor |
| Well-reviewed | ✅ YES | Reviewed by Andy Shevchenko, Acked by Alex
Lanzano |
| Explicit stable tag | ⚠️ NO | Not present, but often added during
backport process |

**Score**: 7/8 criteria clearly met, 1 not required

#### 6. **Historical Context & Precedent**

**Similar Backported Commits**:
- commit ca2f16c315683: "Add 10EC5280 to bmi160_i2c ACPI IDs" - Similar
  ACPI ID addition for BMI160
- Many other IIO driver ACPI ID additions routinely get backported

**Established Pattern**: The kernel community regularly backports simple
device ID additions like this, as they:
- Enable hardware support for real devices
- Have zero regression risk
- Are trivial changes
- Don't modify existing functionality

#### 7. **ACPI Matching Mechanism Research**

From my kernel code researcher agent's findings:

**Key Insights**:
1. Multiple drivers CAN safely declare the same ACPI ID
2. The bmi160 and bmi270 drivers already share "BMI0160" successfully
3. When multiple drivers match, kernel tries each in order
4. Returning -ENODEV from probe allows fallback to next driver
5. The bmi270 driver explicitly checks chip ID and returns -ENODEV for
   BMI160 chips

**Safety Mechanism**: This design allows hardware-based driver selection
rather than relying solely on ACPI tables, which manufacturers sometimes
get wrong.

#### 8. **Real-World Impact**

**Without this patch**:
- Users with GPD devices on BIOS v0.40+ have non-functional IMU sensors
- Accelerometer and gyroscope features don't work
- Gaming handhelds rely on these sensors for screen rotation and game
  controls

**With this patch**:
- IMU sensors work correctly
- All sensor functionality enabled (accelerometer, gyroscope,
  temperature)
- Users can use screen rotation and sensor-based controls

**User Base**: Gaming handheld enthusiasts who keep their firmware
updated

#### 9. **Quality Indicators**

**Review Process**:
- Reviewed-by: Andy Shevchenko <andy@kernel.org> (experienced kernel
  developer)
- Acked-by: Alex Lanzano <lanzano.alex@gmail.com> (BMI270 driver
  maintainer)
- Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (IIO
  subsystem maintainer)

**Testing**: Presumably tested on actual GPD hardware with BIOS v0.40+

**Code Style**: Follows existing patterns in the driver exactly

#### 10. **Comparison to Other Backport Candidates**

This commit is more straightforward than many other backport candidates
because:
- It's purely additive (no modifications to existing code)
- The affected hardware is completely non-functional without it
- There's zero chance of breaking existing functionality
- It's been reviewed by multiple experienced maintainers

---

### Final Recommendation: **YES - SHOULD BE BACKPORTED**

**Backport to**: Stable kernels v6.13+

**Justification**:
1. ✅ **Fixes Real User Problem**: Hardware compatibility issue affecting
   real devices
2. ✅ **Zero Regression Risk**: Only adds new device ID, no existing
   functionality changed
3. ✅ **Trivial Change**: 2 lines, well-reviewed, follows established
   patterns
4. ✅ **Safety Mechanisms**: Driver has chip ID validation preventing
   mismatches
5. ✅ **Meets Stable Criteria**: Small, contained, important bugfix,
   minimal risk
6. ✅ **Precedent**: Similar changes routinely backported

**Note on Typo**: The "sincice" → "since" typo in the comment is
cosmetic and doesn't affect functionality. In Linux kernel stable
backports, such typos are acceptable when the code itself is correct.

**Dependencies**: Requires BMI260 support (commit f35f3c832eb58), which
is present in v6.13+

 drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index c77839b03a969..b909a421ad017 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -41,6 +41,8 @@ static const struct i2c_device_id bmi270_i2c_id[] = {
 static const struct acpi_device_id bmi270_acpi_match[] = {
 	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
 	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
+	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
+	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
 	{ }
 };
 
-- 
2.51.0


