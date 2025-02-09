Return-Path: <linux-iio+bounces-15202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8638A2DFC6
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F5F3A60A2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BEA1E1A25;
	Sun,  9 Feb 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIPvzdhV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3F1E1A2B
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124469; cv=none; b=If3JaCZw1INIr3X6BzH6GTJtsOMl36x6K7iWVzYtTFae/9f/CAzAG8fzRjFON58v58zYLoWgWnb1SEWdXeflanwzZMsQK4kXw/KWAD4sxnMw2ZRm4pqa+C3mM4xNVUDZWtWapMrIfej/6Pb8MAyYc32hR0ZGIMl4Wy2f0sBD3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124469; c=relaxed/simple;
	bh=DLpIYt/ksN5P4PN4RcM/NnL8kBMSpcEAcUbw/tgDVSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGtaDubK6kC5hc5J9dRbqZlbLDZHhgU0RrTf1tb6CPbgmQH54XKg/eLDzXWNVwwUkd88JgzfCO9Eg+NbU+3N8iXLHTyD+GlvY5WnfIhHsZAe10alS8CQmNH7221uWiejuAtYM/daoM/tGBqYr1ZaWizFnr/VI5JJ/Np5HXx2i8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIPvzdhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CF6C4CEDF;
	Sun,  9 Feb 2025 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124468;
	bh=DLpIYt/ksN5P4PN4RcM/NnL8kBMSpcEAcUbw/tgDVSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIPvzdhVANgg6/rH5oMfrRyN4NspD9tYURnDEFWa6Jcl902EYNRodAohH3Ff/Eqyr
	 JV8qcQqeMWVc4GZMDi29wI/H/566Ook9pSO02hvj5/Cp0HU6QZkmW6NfbOjmKPhe09
	 eP0vOL30wvf0pIfe3/gSgIcxTjFKxTsxAx1dW6fLvAUq+EkZadsQ8Vo7gh7Lp0STIG
	 G6l4bxwUNi8GVcESPCVnkHfsl7iRPplsyauvnMjC151XKEbrSVsFHIPPKASA0hA6Dz
	 HrSYcUhjcrnJygjn8hbmjNDsNYDKOA2ND54aXCTdHGv/PeSD6hhAWXUXJqC7FM8vKF
	 XdRUF7Fpptrxw==
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
Subject: [PATCH v2 09/27] iio: adc: ad4000: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:06 +0000
Message-ID: <20250209180624.701140-10-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
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
to check for unbalanced context.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Tested-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad4000.c | 60 +++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 1d556a842a68..4fe8dee48da9 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -535,12 +535,16 @@ static int ad4000_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long info)
 {
 	struct ad4000_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return ad4000_single_conversion(indio_dev, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ad4000_single_conversion(indio_dev, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->scale_tbl[st->span_comp][0];
 		*val2 = st->scale_tbl[st->span_comp][1];
@@ -585,36 +589,46 @@ static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
-static int ad4000_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan, int val, int val2,
-			    long mask)
+static int __ad4000_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val2)
 {
 	struct ad4000_state *st = iio_priv(indio_dev);
 	unsigned int reg_val;
 	bool span_comp_en;
 	int ret;
 
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			guard(mutex)(&st->lock);
+	guard(mutex)(&st->lock);
+
+	ret = ad4000_read_reg(st, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	span_comp_en = val2 == st->scale_tbl[1][1];
+	reg_val &= ~AD4000_CFG_SPAN_COMP;
+	reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
 
-			ret = ad4000_read_reg(st, &reg_val);
-			if (ret < 0)
-				return ret;
+	ret = ad4000_write_reg(st, reg_val);
+	if (ret < 0)
+		return ret;
 
-			span_comp_en = val2 == st->scale_tbl[1][1];
-			reg_val &= ~AD4000_CFG_SPAN_COMP;
-			reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
+	st->span_comp = span_comp_en;
+	return 0;
+}
 
-			ret = ad4000_write_reg(st, reg_val);
-			if (ret < 0)
-				return ret;
+static int ad4000_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int ret;
 
-			st->span_comp = span_comp_en;
-			return 0;
-		}
-		unreachable();
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = __ad4000_write_raw(indio_dev, chan, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.48.1


