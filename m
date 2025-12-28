Return-Path: <linux-iio+bounces-27400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D22BCE49B2
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 08:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D558300E01B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A6927AC31;
	Sun, 28 Dec 2025 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="INQJJu2M"
X-Original-To: linux-iio@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74B2A1BF;
	Sun, 28 Dec 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766905840; cv=none; b=Lhw5Dr14ft85M1MQvSjhp84Sb1oPFHJFYoZwRRE8KFu2tjxZS3RlXjyBoV/4B45NRW+tiGzGlRlWdOWT+S1/LzwvH3VtiRKsc4tLTmlLvLmNQD9EhVe4wzh4753us/o1MW0KqVEAi1yTqU30YnYeZdf4M0LXSa82qhlHd0P1FYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766905840; c=relaxed/simple;
	bh=LjjsdxAOQeN646JH99rBjXlUX9X0dzKbNMk0ReW2qoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMJsQScrkQnzTQ8lFmZomuBOJ2hgrzDOMZYpC5JFi5WlmI1+9yUYg/FQbAo1iDZ+WyN+dVdnxLl878UXXQAXMKiLysme6kSJlMdaRAvVFI9P4QXUGiSbQyA/ylwm6o818ayvq5QpDcx0uGbEg5HKixDfmz5GBWNAffKiJKjsvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=INQJJu2M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Zd1iiNuxYz38HOkCWiChJurRbhKwWnkJ4eEktAcLPmc=; b=INQJJu2MD4KjophPhYNDyuBT/0
	fdho8LHi/zrPJ/4mNgI1xSRmfV4C0JX+mq5ZrXS7l2WQHa2rz30f+/dCn6hsL+4+8mUiJU2fEmvU8
	sEVWFOvO+/e1RMfn3MJAIVJtompfLaYkmTO8jBqXXFXiLm4H5w7zUrxdY7BZbcDvC/DMe5Ai5hN1H
	QGAkjVxgTcNIL03AflUVKrq6AokVpQKtvXPncyqsTD0ZEAlVi2v2bTwmh6EAMbiH6v7fHbR26GFdm
	Uq61PlduG6rALEAX7UujW8DIN5s+EcegKi7xekLWZi81jp8xbrqUIUi2nJQkh480wlOxg09AkJP5o
	CBLNS7Lw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZkv8-00000002ZHr-2Hqs;
	Sun, 28 Dec 2025 07:10:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: test: drop dangling symbol in gain-time-scale helpers
Date: Sat, 27 Dec 2025 23:10:29 -0800
Message-ID: <20251228071029.2246703-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code for this never went upstream. It was replaced by other code,
so this should be dropped.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216748
Fixes: cf996f039679 ("iio: test: test gain-time-scale helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org

 drivers/iio/test/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20251219.orig/drivers/iio/test/Kconfig
+++ linux-next-20251219/drivers/iio/test/Kconfig
@@ -8,7 +8,6 @@ config IIO_GTS_KUNIT_TEST
 	tristate "Test IIO gain-time-scale helpers" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	select IIO_GTS_HELPER
-	select TEST_KUNIT_DEVICE_HELPERS
 	default KUNIT_ALL_TESTS
 	help
 	  build unit tests for the IIO light sensor gain-time-scale helpers.

