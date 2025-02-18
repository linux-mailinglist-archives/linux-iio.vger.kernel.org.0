Return-Path: <linux-iio+bounces-15726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55C4A39965
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 11:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100BF3BEA9D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 10:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884B238D25;
	Tue, 18 Feb 2025 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTnQfGkr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BD23496A
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874904; cv=none; b=QEKlxk7NytQxOeN5gMo3AHnortlW1qscBTmvlZw6Fenkpc33X/7Z7ZJdnL+6eHFTejvfL1iwibayv3jzOxK2Zkbte95MBT9bWnFYP+6F8T+qJkXJr4hBGL1gkx27tc54hc1qSU4MGAfi7GZixRsoxWh8pBsAuahmYPwHhIIkfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874904; c=relaxed/simple;
	bh=tnSQHo6voXZ3cLxolMf+gg+L4mY6TL5UrtT+9uOZb/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E8C8SpYonxQYTrUHXHYxsR/d7mFRNvchvkkTM5QGirfJP4QeJHyZ667edyU7fjEnniKhoP8zI/T5OAZ957D1HdJY4WS2eDHcBZzgLGq1VnN0owd5Zy12wh0sDueFuxITePY3c7P7gyMXvpIWEXNzw9B428OIfgrKuBOuYWCIRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTnQfGkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5473FC4CEE4;
	Tue, 18 Feb 2025 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739874904;
	bh=tnSQHo6voXZ3cLxolMf+gg+L4mY6TL5UrtT+9uOZb/M=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MTnQfGkr6UAv8PPjJfiDWMQt8sQDuASidousEgAgpTlu4AsMUgm+vfl1l5Kb2B7Ue
	 G/ah70IJDQBR9A0xKN1SZNPzR45CpHTrU03QRmYMjDc+UhyOHf3McS0gZuaisX/OPP
	 JNVlZpMTaQcyzLBXVhLZZU3jaQFtbHpiL+WuCW2GRQhJy7Z1F15yAcrHfOimDfkPpe
	 vBF7BoeHQg7vQMPclEOJv2m0xaazDtbsRzzP0upR1kPz4skffZtkUs1VOF5W0ZFXWo
	 Xzq0i32g+5RCrpUxARyAy7iRUz9CL0uhlsjaapdntf0dCpUgT3YIbjqeovQ08HZ1vp
	 rFX0rd1WCRexg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44235C02198;
	Tue, 18 Feb 2025 10:35:04 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 18 Feb 2025 10:34:57 +0000
Subject: [PATCH] iio: adc: adi-axi-adc: replace of.h with mod_devicetable.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-dev-axi-adc-fix-headers-v1-1-5ddc79221d8c@analog.com>
X-B4-Tracking: v=1; b=H4sIAFFitGcC/x2MwQqAIBAFf0X23EIKRfQr0UHbV+2lQiEE8d+Tj
 sMwUyghKhLNplDEq0nvq4HtDG2nvw6wSmNyvRt6ZycWvOyzspeNd818wgti4uBErASxASO1+ol
 o+j8va60fpJ9PmmkAAAA=
X-Change-ID: 20250218-dev-axi-adc-fix-headers-b2dd1dbd1be6
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739874907; l=903;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=G3VoJon8QjFBAHChuMI22zdjNcH5B5joBOnnLh6sUCU=;
 b=iFj28nRQjkaqZ/g9GRd+6bAwkbm1olOc/3LY6rPl77rdiY77uZ75X9KFDawGK4InHg7KsQdGZ
 gRyU/V7oL8kB1z3u3mvxRg2C6xGwI933wK6cc/Ua4UcpSGUIKf1eLlq
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Don't use of.h in order to include mod_devicetable.h. Use it directly as
there no direct dependency on OF.h

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 61ab7dce43be66868f09c41df18d09259db0cee3..068a1f61c6329967e39e8fcde70f0c903aaa6393 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>

---
base-commit: c0f115a8d97599623294c8e9ec28530e19c1e85b
change-id: 20250218-dev-axi-adc-fix-headers-b2dd1dbd1be6
--

Thanks!
- Nuno Sá



