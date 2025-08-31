Return-Path: <linux-iio+bounces-23520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC53B3D235
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750431794EB
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8152253F2A;
	Sun, 31 Aug 2025 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0hLJW0c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E81E502
	for <linux-iio@vger.kernel.org>; Sun, 31 Aug 2025 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637313; cv=none; b=eHJvaY6Fdv0Q7ejmfI5rsEmSn+S874GeI74rLs1fn18TPU4vFtcBMuPbv2rgMePdE3YnQ76f4TzKQSt5x/3K25U0Xf1rORU38DOX+7NuNc27H0RGsXMaYaxmfw8pfFHhwrBVfBHQfCe/uW7VRi3R2lbGdEc4tUhQU5BaocCE9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637313; c=relaxed/simple;
	bh=OQIf2HTIalzCS+UiS9XeTh1/9P9CKAMWAop9ear7E9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGoRs7c3jj7elfN72sD+iCk6omjZ0JdEBMzaAyLnYW48IyZMQjqj7iYMLZhYxQSvOkZtZ78sdNO2h6z0Bi5p2Q9rwZ+afST4StqARFa+vgNwoRHiG0qye2U+oLHWTZvp3wlgtuIxcgAq40NDRAED0S/KTVYMRmKC4D/+6Te6jDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0hLJW0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E83C4CEF5;
	Sun, 31 Aug 2025 10:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756637313;
	bh=OQIf2HTIalzCS+UiS9XeTh1/9P9CKAMWAop9ear7E9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0hLJW0cez6TQ7QrmpwKiORktwtNOzvpzENffPfjbsHrkhtMlgbganqeRlv7hCNvy
	 xy9hIZkVeodXPdNlLVNiLnHo7SHBf1l6MqbU1p+P0wYA80RKG+dcs4xqEtzYvFTteS
	 vO4oUjzi/f8bQRqVoNeKHvtmMONXmpciSZTcCqoJkF185DoLK03GVUG7Lx5sGN4d3p
	 f1FR7adgelc++A7349Qtxz+aL8/fKYZcwIKgW4SJ8hIXHEtslz8xjP3Wh+Dk2YrYLf
	 z7xweBbqCzjunlDZUFSI7BSjMHDhQmXGowCWiOAWlYDlH7iOybxIaYGINUTdz7fLJg
	 sx0kbgRif1uXA==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 2/6] iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
Date: Sun, 31 Aug 2025 12:48:21 +0200
Message-ID: <20250831104825.15097-3-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831104825.15097-1-hansg@kernel.org>
References: <20250831104825.15097-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix iio_convert_raw_to_processed() offset handling for channels without
a scale attribute.

The offset has been applied to the raw64 value not to the original raw
value. Use the raw64 value so that the offset is taken into account.

Fixes: 14b457fdde38 ("iio: inkern: apply consumer scale when no channel scale is available")
Cc: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v4:
- New patch in v4 of this patch-set
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index d36a80a7b8a9..642beb4b3360 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -640,7 +640,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		 * If no channel scaling is available apply consumer scale to
 		 * raw value and return.
 		 */
-		*processed = raw * scale;
+		*processed = raw64 * scale;
 		return 0;
 	}
 
-- 
2.51.0


