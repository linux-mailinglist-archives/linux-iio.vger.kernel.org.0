Return-Path: <linux-iio+bounces-10688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE59A2B5D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 19:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962191F2310B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383301D95BE;
	Thu, 17 Oct 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWgv0/6Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A71DE8AD
	for <linux-iio@vger.kernel.org>; Thu, 17 Oct 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187438; cv=none; b=BfMHG/LsyZgAG0tAtSLyXa2u26jLadD3lQVNRgLth+YTC5+1u0I1SqgtqMhKM+FDQSxhGkfOfGuRi70or588DSItb4NUIB2MS47FzHHPepDS4H8H9obg7j0V6pTOXUx0A8z2pVEZD2Jwz0xe7qrRZ//v1ReHDidJUQYSHXaQyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187438; c=relaxed/simple;
	bh=zZKy4DTMuFduAhqO9fv5BoZuadJIE4s3EDvHo4WrQM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsaNlkVCkBFkPCIQEL/H4RPA03K02dVzaKeEEM5fvhgSmf3kU9u3qaIzoBAlQiEGwnSKnvNhBJ/Q4oksRVneH7hryVjci9eB1Z86JuaDemvyOWlAZyJ00lAnTc5SnTjBJxtN41y6gviFL6QJxRCsmcrYYtkjKKj2xQ7V9VUSLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWgv0/6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E6FC4CECD;
	Thu, 17 Oct 2024 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729187437;
	bh=zZKy4DTMuFduAhqO9fv5BoZuadJIE4s3EDvHo4WrQM0=;
	h=From:To:Cc:Subject:Date:From;
	b=VWgv0/6Yf7MOtHYA4/fu/VIiVhoumIAVOCSVpeBBz68vWHIISuQH+0OwaTkrmoEad
	 ptbroQD5XtE0uXxj26CQ+L63Hen1Lh7JTZmXZnPl3K6LcqCdzKJr3mxiIoHlZ+tgpK
	 cqAKk14ZBYFQ5GTL7w9QWh7c9zr1O8JCqEb7ctiU7ltgVZu9oAL9vcEApGpwrXc+I5
	 VhBAbbKPr3/bwnE6HBef7jKH1RwXeuIJD10ddIvJ4PVnfL0dDbOma/r2gJmgzGyNPY
	 RHDkgvaet+W887l7x2CuweG45EqiF0ssIWi1KRfG6Eb3KPf/v+BCJfJsl0cx8b3+TG
	 OIb3rFbTmS/6w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: adc: ad7606: Drop spurious empty file.
Date: Thu, 17 Oct 2024 18:50:25 +0100
Message-ID: <20241017175025.303826-1-jic23@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Empty file unintentionally included in commit. Drop it.

Fixes: 94aab7a0f5c7 ("iio: adc: ad7606: rework available attributes for SW channels")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

I've already applied this, so the mail is pretty much an FYI.

drivers/iio/adc/ad7606_spi. | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/drivers/iio/adc/ad7606_spi. b/drivers/iio/adc/ad7606_spi.
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.46.2


