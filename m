Return-Path: <linux-iio+bounces-17677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DDAA7CE9B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E056E188B328
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A021773D;
	Sun,  6 Apr 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPFNutO+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CDD5C603
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743953490; cv=none; b=BbVVRmh+TiuhZ4/cjGwj4r9VO1OR8FjY60bKG6h24DlWL7xA/OCGNQAnaBMCc+xLjdfCVaTKZJwjeTTyPWowKwT4nwPwgiM3IOxmp379nxLxPp1oTXIt09yXHWM4RuX8GHTjMT693xxrtks5aBw9gaiTJHiqVuuudHTgFLdiB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743953490; c=relaxed/simple;
	bh=N9GcaUo9y874zTlivHH0bNJzB06TNKNemUrPw7VCaKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NKdtP8PYvdeRuEEYldQ9okbmBes2bYhF4PdA7Ld9RP1Ae0st8gc17O0HZjNDg9wkamyM9yOKrdlfISmUrGbuBG6BOrVapBjYgfdZiMc2g1WyoUMllEply6KqWv7hkgW4rNQwzMeTAZ6IBAx6/0ptorXKM75byq78szBC1tywSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPFNutO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C448FC4CEE3;
	Sun,  6 Apr 2025 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743953489;
	bh=N9GcaUo9y874zTlivHH0bNJzB06TNKNemUrPw7VCaKc=;
	h=From:To:Cc:Subject:Date:From;
	b=WPFNutO+RisjoLxWFnIg/XDn8dgCxBRHcZS0xJn2f3Sv9SXgjLXeeiFs3zOKze6PT
	 Spix7SP+UpEcENLzaJnpx8F5x0F3RJcOOJlz5snnkPPn+Fd+btJ0EOdo9yz3IZ6Ruc
	 RbpnGp77ddk5VvHmck6+f/xY1LBMlvtLt5za7tfXU3BbLKHL/6VoH33VdiK+nomTuC
	 nmcOX/jlmX0f5ETcS2zKgs7o4FnO0uBztufABik1pyPrvxfxwUybABtgGFXWpQdyXf
	 r9U8LGhrXm+WUtGJzq3INf5bKSMIW0IaHGS7LY8vgI3qWLnJxVs+PA8Gd87NjLmXXu
	 aSRDZtQ2CATVw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] MAINTAINERS: IIO: Update reviewers for the subsystem
Date: Sun,  6 Apr 2025 16:31:19 +0100
Message-ID: <20250406153120.2129133-1-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Lars-Peter has not been active in IIO reviewing for some time. Without
David, Nuno and Andy, along with many others who review IIO patches, I
would not be able to keep up with the rate of change and would have
become a bottleneck to development.

Hence update the MAINTAINERS entry to more accurately reflect reality.
This is not intended to give the 3 of them any more work or to oblige
them to review any particular series, so if there are any series waiting
a long time continue to poke me via the list.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 559620786634..0762170e9740 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11518,7 +11518,9 @@ F:	drivers/iio/common/scmi_sensors/scmi_iio.c
 
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
-R:	Lars-Peter Clausen <lars@metafoo.de>
+R:	David Lechner <dlechner@baylibre.com>
+R:	Nuno Sá <nuno.sa@analog.com>
+R:	Andy Shevchenko <andy@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
-- 
2.49.0


