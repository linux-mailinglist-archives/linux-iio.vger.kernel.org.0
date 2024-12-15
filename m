Return-Path: <linux-iio+bounces-13525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A06F9F255C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374E7163D1F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3351B6D17;
	Sun, 15 Dec 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsVdsk/C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF341B5ECB
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287425; cv=none; b=NcFMLXtplk6vq+T1OhIOcUS8H5xjO4GZcg4GmJ+dVrIu95ZKzp3J4am+mK3w2sp1zmZTMyPMYQXrsFtZJhWClX8wFwAr4qUG0+CjHln5heRYoMPyRmKeQfx9f+/7J1NfWqfyxvcRbAmJ96c72HzixAyk16PxIdjWL7+fQjfYWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287425; c=relaxed/simple;
	bh=38DvPJLomyAxR+iVOPRrtijLzkDRXrORgoSUQNZfkiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb0pNtMhyxPetu9uHw/K82L/3d/paIPCiNDEi8b6f49FT25zNiPFN7CY0sQZU4RqllV2rYL0XyCZT1ksVhZgL+8hKrqmseuS6LW9yVJTDk/i/4YzQEjxT/+eVfaLVRXGhA+I0xlqntKY8qT+i9m996ahV5uj+6AqXOZ67miaCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsVdsk/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DD5C4CECE;
	Sun, 15 Dec 2024 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287424;
	bh=38DvPJLomyAxR+iVOPRrtijLzkDRXrORgoSUQNZfkiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsVdsk/C8De2oGoSehAEs7Q0QMuESsD3Mhlt+k3QwLv/p1BjSZGYOR31m+NmuEYSL
	 79KfoODpRPQDYH/pzM4LzsmR2GUzNyRWnkXYUoUhlVrchyCVTzqAaAsEvnc+uZHMdb
	 +5J/n4RBTkQh32uOUth70fB0mJ2m0pX7qlvZO9qxnEVEsDOdmOfNsGf5UuIPAzDA/c
	 Oy71jXR/7hzZK+L8q3B6UQUgHwl5LOXg+K7kFE+mOsRRi1BkBpco3461SOskNrvBOB
	 8qLWDYkjrwzOvP6vwXVeLMx9qmkKyJfQy7m4wJhH8A05htU46HyvZlzwyDC5tAIcqo
	 4hev2Im5uWmCA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 20/20] iio: adc: rockchip: correct alignment of timestamp
Date: Sun, 15 Dec 2024 18:29:11 +0000
Message-ID: <20241215182912.481706-21-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I assume this device is only used on architectures where a 8 byte
integer type is always 8 byte aligned.  However, I would prefer IIO
drivers to never make that assumption as the code gets copied into
new drivers which are not so tightly couple to one driver and those
can run on architectures that align these types to only 4 bytes in which
case this structure may be 4 byte to small leading to a buffer overrun.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rockchip_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 240cfa391674..bf4340094031 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -363,7 +363,7 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 	 */
 	struct {
 		u16 values[SARADC_MAX_CHANNELS];
-		int64_t timestamp;
+		aligned_s64 timestamp;
 	} data;
 	int ret;
 	int i, j = 0;
-- 
2.47.1


