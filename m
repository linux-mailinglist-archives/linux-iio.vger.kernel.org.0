Return-Path: <linux-iio+bounces-27811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D7D23232
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 09:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3427301AA9B
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3893346A8;
	Thu, 15 Jan 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSCNu5VO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289A331A40;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465695; cv=none; b=RxW9ea2PCRA0T8WWCSwTjdmrrePPZD5H+sYtZZsLHLYy1pTiakFxoX6G4hmwi4p7W2gt1q/37VgxxyWpS+7X03be/BJ//jaaPZcVfCfshBwYSslMsSXbWV/8+qm/wgCYT4hqQYJ5efKrB3dtGzXXhT0PM54Dtnw7sYM4mcevO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465695; c=relaxed/simple;
	bh=pqesYkOyVAJlJuBSd/pYdq0RswcQK/wRmOsqk0CswSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2wJIqwxxLs9IETulSkIQkMWPnzs06RhnkuA0oMzxUYuPRcxxauPQ99Q2ey+y//XIVeaq3d8FToUm7M61genugKtllTD9P/mW9kmUT0dDgemKxmE+ogcY3b6AZ1d9eyErvHwWcXRUSEDkZiXWHjIXirL/vNVH+SPCr+CqtnAwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSCNu5VO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4616C19424;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768465694;
	bh=pqesYkOyVAJlJuBSd/pYdq0RswcQK/wRmOsqk0CswSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FSCNu5VOPHH+wx/fE+z892jHRBYBXr++YyaylE5SI1OR26u+ntixNuXLmJaYG5FK8
	 Gt5zj81n5VXJaRO7hDk+ferYSTk6k/FctzGJ28abSk1fLmcyk4mB0U3c5vM9BFU346
	 983/xp26xW584KZz8GYILRIR+kKiR7IwUaIJuVK8eWOUm5IpzVq0SqDVi4MQbF02DJ
	 y4HNjGEPWDy4HTXW84KFp8ECY5ZRlLTfOwVszhkROO1wIv+sWyCXaWBpONs0Enh8YD
	 HGuRTRdQJ9HlC8YtszdcDCHlEQL9M58PL6tm9mKqAfkvqM3WEsSSS8Cr9bNnBFRGzj
	 5ykiYyjScIlwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D59D31A0B;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Thu, 15 Jan 2026 13:57:37 +0530
Subject: [PATCH v5 1/5] iio: proximity: rfd77402: Reorder header includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-rfd77402_v5-v5-1-594eb57683e4@gmail.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
In-Reply-To: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465693; l=731;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=1WNye2DOeFW/tlwxc8iPRX7QNJxVc1IW/3mxJqW60zY=;
 b=rrm1rItG1GfzqGT1zVuMewMc/40jeE3cxt9zSturbshZGH8vhfcZjgkEyY+Ur02/SeyS/zKMQ
 LRboUZUrYK5CFtqtIkCIBCaUWTxDmo+ODTzkcnLZReroatkxH2Pjv9w
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Reorder header includes to follow kernel include
ordering conventions.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 3262af6f6882..4499939215e7 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -10,9 +10,9 @@
  * https://media.digikey.com/pdf/Data%20Sheets/RF%20Digital%20PDFs/RFD77402.pdf
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 

-- 
2.43.0



