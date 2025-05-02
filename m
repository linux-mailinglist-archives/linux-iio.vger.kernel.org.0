Return-Path: <linux-iio+bounces-18977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A626AA6E47
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A2A4A7A68
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E62222A7;
	Fri,  2 May 2025 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mvFXd2PU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8522FF33
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178659; cv=none; b=RvkYytnzCjBs17jimq42EIGVJNwKft4whEe8jm9IiKMTjliAZ7EXBH0ZKBumo7RYx6UhB70gGCKGrFW+PBGok2+MbUEyPhmEtuGDn9XeSJ7GRlGfKAmp+d3xUrVCFcYaJqBlPWM9TlEEyujT1xlkneLU0n8VT5cLSrncprlKxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178659; c=relaxed/simple;
	bh=RnvUeWPOArLWpl9zw08AIZIflPF7IKAVOL/3HWjfMSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b3fWGS9UbmLW6CgKT9BNkkdNFDaaJIjBRJZficJLvdvdXVDbH07XutvNs8K71dhVGmIQAqoZFhVC94bSEhQio1ia3jqALf2528XySqvuoQL/saNDiyaVZ1UzTFwrMfvYafpuNYe+UglFW7i8o0UTj1hbN8DUzqH0eQ+PsP5yk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mvFXd2PU; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746178652; x=1746437852;
	bh=YbsmpdpA4diK8KKbR9g2hcNSmpPY3qM16EXc9X+UR0s=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=mvFXd2PU34bOMv6y9+I0qpxVVFj8mx6XMfM3g0m9A1d+mfCfEqsjLaaN+UqE5fLdp
	 KHaHvHPu1yATA9ifmy27c8sTlTupdfjVZAFWOorBqPcpWx8yPyrJSI1dG0g2UFCQ6i
	 yhscKDcXLZXKE/3+mSPp557kDDu+Zi1Vj5s0bM1DyIL0ra/njgL0e68AFTq4aXuWWP
	 f+TJ2fkZ9KqLn3C5XvkYaqx3SIUOrFPLCTSXp1hGef44QxrJLX4X6ZF86xmAv8av5L
	 mScogeV/mPyed6H2qn9d2m53rWfaBWnZUkUBaAAgzQpXDtLVuBXEldX+JitfSEwDHk
	 zz4FbPnQg3Y8w==
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 02 May 2025 11:37:26 +0200
Subject: [PATCH] iio: imu: inv_icm42600: Fix temperature calculation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-imu-v1-1-129b8391a4e3@geanix.com>
X-B4-Tracking: v=1; b=H4sIAFWSFGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUwMj3czcUt3UlGSDtMREs5TEVEsloMqCotS0zAqwKdGxtbUAPygjg1U
 AAAA=
X-Change-ID: 20250502-imu-edc0faa6dae9
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

From the documentation:
"offset to be added to <type>[Y]_raw prior toscaling by <type>[Y]_scale"
Offset should be applied before multiplying scale, so divide offset by
scale to make this correct.

Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 213cce1c31110e669e7191c8b42c9524c0d3e5db..91f0f381082bda3dbb95dfe1a38adcdc4eaf5419 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -67,16 +67,18 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	/*
 	 * T°C = (temp / 132.48) + 25
-	 * Tm°C = 1000 * ((temp * 100 / 13248) + 25)
+	 * Tm°C = 1000 * ((temp / 132.48) + 25)
+	 * Tm°C = 7.548309 * temp + 25000
+	 * Tm°C = (temp + 3312) * 7.548309
 	 * scale: 100000 / 13248 ~= 7.548309
-	 * offset: 25000
+	 * offset: 3312
 	 */
 	case IIO_CHAN_INFO_SCALE:
 		*val = 7;
 		*val2 = 548309;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000;
+		*val = 3312;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;

---
base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
change-id: 20250502-imu-edc0faa6dae9

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


