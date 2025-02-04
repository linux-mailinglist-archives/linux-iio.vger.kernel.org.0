Return-Path: <linux-iio+bounces-15009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1166A27C62
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61FB27A1EF8
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A82063DA;
	Tue,  4 Feb 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knYiWF/E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86D14B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699456; cv=none; b=ragxj79VoMJIVkVjLTHWAFQLfZO2rSpwJz9uuugYkXmra4d9teSLlIxcam5mui2u90dvYXCO4Qg4GcYgYTZ3zAKIVVOzE+efU4N9wvYkLeALi0AmFJXO3M9kjvm2CNeR3pfbKn+SHF9cCHY2EVjiWr5c5u/Ju0foEtmBgd/DDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699456; c=relaxed/simple;
	bh=k1sSmD8TAQxzuIv3y0ozlSdOLdqo/Whqicok0tKloIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1wAbXD9nDLdV30Qg6nIaYqRa2uoO+9Qdtnl5UemhPUEg3TZcoOuN7Zr8lURWn/gSzxMrUF9o2Dea55dHPyJNDZTOF/wR/K8fmP2xnd6FUVRuKUQCPJZ8MMeq5ntIFDvwq7bwtyf6iVUDqj/lSZhz3LXdb1WXTC32lGHPabvVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knYiWF/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF015C4CEDF;
	Tue,  4 Feb 2025 20:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699456;
	bh=k1sSmD8TAQxzuIv3y0ozlSdOLdqo/Whqicok0tKloIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knYiWF/EgaDdV8DgQJKzgD1QprB5LUh4VzDR/tR/KM+QhyfXFplnKnqEXeBLcr+mq
	 3Twsrnpz6ntWvsac+MumtkHQbhw7gIp14DW/9d+VupHObvn9FTL6AHI936b/R9xI0p
	 oyKZnPVo9yc8dvOxbaOx7Hb5b5V8pbL/IxGUjzR9XDljJVK+WbU6ORowj/mVtuQw3l
	 ec6rx+Dy3X1BdTAjg02vFE4oilA3Fqrr4VYo8+6BkW8m2QYhlw1WSnbRUqNPeMNYWD
	 0AzxVQDS6vF59OAvfvlsbJ/u5VGKNws0zFVNWtThwGsC6vFByXckpn69zt03LgLBuk
	 Sva60u29FC+Kg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/27] iio: adc: ad9467: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:37 +0000
Message-ID: <20250204200250.636721-16-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context. Also use guard() to simplify mutex
unlock paths.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f30119b42ba0..f7a9f46ea0dc 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -813,6 +813,18 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
+{
+	int ret;
+
+	ret = clk_set_rate(st->clk, r_clk);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	return ad9467_calibrate(st);
+}
+
 static int ad9467_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
@@ -842,14 +854,11 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 		if (sample_rate == r_clk)
 			return 0;
 
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = clk_set_rate(st->clk, r_clk);
-			if (ret)
-				return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
-			guard(mutex)(&st->lock);
-			ret = ad9467_calibrate(st);
-		}
+		ret = __ad9467_update_clock(st, r_clk);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.48.1


