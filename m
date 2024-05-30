Return-Path: <linux-iio+bounces-5479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9628D4650
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F93AB22C1C
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 07:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B37406D;
	Thu, 30 May 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHCk36Ms"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A32176ABC;
	Thu, 30 May 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055114; cv=none; b=lh8HiIADwbgg3hqgfp88Ysq0guJQjyb9CoPV5vMU/oMtIKX6D+LMwqlPcyUSRe5NvLMzHJAzfbB7PGBP+pUALWTgTko6yHGNaFfTx3eHCnCBx30qsaU5EFGxCXH5gQupdhko7+/yTXvqFz//UJmYwMB+I/1DZ9YEGlEtyZ96U+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055114; c=relaxed/simple;
	bh=FWoszlZ0BSMty3cvpzChmu4sK4x/JmRHfY9S9eDrwsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tOg/oZQ7Cqcp0HzmFJ89UvQ+VvdDHiEHH7YjUrbmMLfiOefHh2eW/cR/oDnjhvPp8P04sw8ku0FgyheF3OhjrBXjY2e517sLxFrKhfbIpqE9Jt/axOrOwrHoNqZ7EBTV4l9WB2nMnF5bbyLbbnv+a+Cls49tEKHbxaJrWYZ284A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHCk36Ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07482C2BBFC;
	Thu, 30 May 2024 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717055114;
	bh=FWoszlZ0BSMty3cvpzChmu4sK4x/JmRHfY9S9eDrwsk=;
	h=From:To:Cc:Subject:Date:From;
	b=SHCk36MstXr/KoRfeDIXw6HIjCIr9TJFktlnNcPRF/WypqsCA+C4e5hH3tilqk0m2
	 a5aZINGWT0KbSUPGywHfVd3YkPbNqAQt8+ed5uc5B6VJ6K3v/gZJ25Nthbx43zGQp+
	 BJFb9f0818gVRwkitc4TemvJCDYKi7yAu4af4fLi7RYhgCNbNNocD+4iJSbtupFN3V
	 0f6sFFyOCFQJPrSRQDg/zY5MDUhPtJpAzDHPfTqWs8RP7WHGAr3pacI5jR0iJUQ8L2
	 Mfu4DJtpObrn9jT3i5vwvOln4z89SC3B60CCkHCaWeAATIBr8ZEQTJIyx5GeoE7/lz
	 s19Jsa5A00vjw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sCaTJ-000000003Zn-0WRd;
	Thu, 30 May 2024 09:45:13 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH] iio: inkern: fix channel read regression
Date: Thu, 30 May 2024 09:44:16 +0200
Message-ID: <20240530074416.13697-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent "cleanup" broke IIO channel read outs and thereby thermal
mitigation on the Lenovo ThinkPad X13s by returning zero instead of the
expected IIO value type in iio_read_channel_processed_scale():

	thermal thermal_zone12: failed to read out thermal zone (-22)

Fixes: 3092bde731ca ("iio: inkern: move to the cleanup.h magic")
Cc: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Someone should re-review the offending commit so that there are no more
of these subtle regressions that are bound to happen when people use
cleanup.h to save a few lines of code at the cost of readability.

Johan



diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 52d773261828..485e6fc44a04 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -721,7 +721,7 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 			return ret;
 		*val *= scale;
 
-		return 0;
+		return ret;
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
-- 
2.44.1


