Return-Path: <linux-iio+bounces-22584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BEB21123
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481C16E0EB4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78EF296BA7;
	Mon, 11 Aug 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CylxVcDg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67950296BAA
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927706; cv=none; b=pOgE/HLPjW9akRC9INFQ4mP4ezcfGi6XhR2G5EGLAhadVUBICo20zwGzwSx4Zbh6DP38Oviw6GW5j+t4s+B8MTHWTn52pvZwTvSquUXA+o7MOnv5529qcBk8pdu/p3yFJQBRgInRIm2wTk+OmqYVKnmGxl3zoC+UFAecZHrahsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927706; c=relaxed/simple;
	bh=KORe4rGaq61/Um0pQE4eOockv3UUn9Q3oLSfp0kOM7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rleW+ZOtWlgbc2jfAaec10IwiR3fwZkYdYsl6Q/pZVCt92fO5O6OGtIjE1RbP2hHj11APNmx7BiwHpE6h2RLzf3joqRw3jZ7xleVLqYgwYW2tnPaeMk3nEPTYvc7rdjxR+XN42BZmX5/QFHxgv+FvRwBMPdWUkx+Dd+fN3qvSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CylxVcDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3C3C4CEED;
	Mon, 11 Aug 2025 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927706;
	bh=KORe4rGaq61/Um0pQE4eOockv3UUn9Q3oLSfp0kOM7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CylxVcDgV010qAufLyBnCyX3c1q+ELVR7pS0LqkJXJyjt/93RuQUS3y7amwR888Bh
	 6+T58ooZxKw5r/1qkrPxU1pNr3o26TeUBXqFtQmJ3CBw+acp3WtikxY3DzBnALCfUf
	 1+7E7sLuC++rLrxyVlTaen5P8xNs3smfvfxjrgOyopgQ6b2/1bHLazhSAw5pTY/aoM
	 /tTq4W+Q7ueR4Jl6q7bwiw/aiEsHC7txQJ8H9VkGWFPLvBdbHY822hdZs6ZZbPfSSE
	 EfqZb9rnyCgdbTgE1/dplRKkyEIqHWiy4DZ+Syl4xgXAiaWS9Qj2Af2FrSYUYazxdO
	 O7gvolrJVT9wA==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 2/6] iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
Date: Mon, 11 Aug 2025 17:54:49 +0200
Message-ID: <20250811155453.31525-3-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811155453.31525-1-hansg@kernel.org>
References: <20250811155453.31525-1-hansg@kernel.org>
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
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v4:
- New patch in v4 of this patch-set
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 508534f96962..a75f53d11937 100644
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
2.49.0


