Return-Path: <linux-iio+bounces-2456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B26850F46
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 10:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA412829E5
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4EBFBF2;
	Mon, 12 Feb 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWqCGsyY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38B101C1
	for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728829; cv=none; b=iznVSr3EZcoSX44Z5xpueuuFsDW2GV5aCP4fCt0sPo3iiaO/HBjsqxtMrFKIJLnygkczhVosE9ULYK2vgKyJWPsgnn5eFjC2mOh8kx2L539E1cY7r8LotnXo5TZbLkgYiT11YVKOISZuIcQVHu3LS6OVO3U1Q5WUYI2bLywBnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728829; c=relaxed/simple;
	bh=1fUS3PZBn94/xoyMIsmko9QLHHumwUIhKx/OSVrhcOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aX8FZULTPfaIigje/ou/OU6S+l4YtU8vmz0/88L0rX68sD9+tNeDcKjapcAislw4W7YpDBKhBWBEz24Sq1kcA8OSTnbq9hcdwetRNRQrp8gtWITOm4Asz6pb17rBZrGKMEJ/iGiTg8Q8IEg0zuIJxHe3h0UbAaVbXFjeBVkuMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWqCGsyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB773C433F1;
	Mon, 12 Feb 2024 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707728828;
	bh=1fUS3PZBn94/xoyMIsmko9QLHHumwUIhKx/OSVrhcOg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LWqCGsyYEyOhlG/LkIIuioacLEwAdxVxNFRYCntsSB9x4y8hYJuPQwyraPVSDKRxa
	 3l7DPwDoApNUA6OhABginqX/v5nPddlVsoQDCCCSX6TyqltkfEMR8FX04YrXN4CS5X
	 JucCsHpD8a4fuvwf4KGzWE9tsAkWzwDGjgsps+8ocNMSvn+TyzxnOE41HMFTM6G2J9
	 BNIt3s8M555NWkRap0Fh+t4Je4Pa88Tn79XoCjvVeNA1073xoHWPq9pZ54YnO5inJC
	 3l8NzxhqqiuJEl/BBmiqSgEQezOL4BNANlsK9g8odx5RPsnr0D2YAL9u48DhYbgq2p
	 6ndCE9b3uDFtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890D8C4829B;
	Mon, 12 Feb 2024 09:07:08 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 Feb 2024 10:07:05 +0100
Subject: [PATCH] iio: core: make use of DIV_ROUND_CLOSEST_ULL()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240212-iio-improve-define-dont-build-v1-1-875883bb9565@analog.com>
X-B4-Tracking: v=1; b=H4sIALjfyWUC/x2MwQqDMBAFf0X23IU1qLT9ldJDazbtgzaRRIMg/
 ruLp2FgmI2KZmihe7NR1oqCFE3aS0Pj9xU/yvDm5MR14lrHQGL8p5yqsteAaEhx5veCn+dRws0
 HkSFce7LHlC1Zz//jue8Hr4+lwG8AAAA=
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707728827; l=2450;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=X35iqJ6K0K5h9XuwhHfccmLQcWPxcL0Z/bKnPGFfk3Q=;
 b=Lao/omFK+SboBcAVxAka5TRnnXTewPknOU8xDcscluVsKtB+67cxFE+204IZEJ6rMu/A/bLNo
 xOgp9q9Fb36C4XGpoVKprrJUKvC2HUIG4GSBbYRzXkYUhK9BV/B/kKD
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Instead of open code DIV_ROUND_CLOSEST_ULL(), let's use it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
1) For some reason IIO_G_TO_M_S_2() does do not a closest division. Not
   sure if there's a reason for it or just something that was forgotten.
   Anyways, I left it as it was before.

2) This conversion could actually be required. In some experiments with
   it (in a series I'm working on), I actually realized with
   IIO_RAD_TO_DEGREE() that  we could have a 64bit division in 32bits
   archs. I'm still not treating it as a fix as no one ever complained.
   Jonathan, let me know if you want me to send a follow up email (or v2)
   with a proper tag.
---
 include/linux/iio/iio.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e370a7bb3300..3ebf9fe97f0e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/cleanup.h>
+#include <linux/math.h>
 #include <linux/slab.h>
 #include <linux/iio/types.h>
 /* IIO TODO LIST */
@@ -799,8 +800,8 @@ int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
  *
  * Returns the given value converted from degree to rad
  */
-#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) / 18000000ULL)
-
+#define IIO_DEGREE_TO_RAD(deg) \
+	DIV_ROUND_CLOSEST_ULL((deg) * 314159ULL, 18000000)
 /**
  * IIO_RAD_TO_DEGREE() - Convert rad to degree
  * @rad: A value in rad
@@ -808,7 +809,7 @@ int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
  * Returns the given value converted from rad to degree
  */
 #define IIO_RAD_TO_DEGREE(rad) \
-	(((rad) * 18000000ULL + 314159ULL / 2) / 314159ULL)
+	DIV_ROUND_CLOSEST_ULL((rad) * 18000000ULL + 314159)
 
 /**
  * IIO_G_TO_M_S_2() - Convert g to meter / second**2
@@ -824,6 +825,6 @@ int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
  *
  * Returns the given value converted from meter / second**2 to g
  */
-#define IIO_M_S_2_TO_G(ms2) (((ms2) * 100000ULL + 980665ULL / 2) / 980665ULL)
+#define IIO_M_S_2_TO_G(ms2) DIV_ROUND_CLOSEST_ULL((ms2) * 100000ULL, 980665)
 
 #endif /* _INDUSTRIAL_IO_H_ */

---
base-commit: bd2f1ed8873d4bbb2798151bbe28c86565251cfb
change-id: 20240212-iio-improve-define-dont-build-c0f9df006f85
--

Thanks!
- Nuno Sá


