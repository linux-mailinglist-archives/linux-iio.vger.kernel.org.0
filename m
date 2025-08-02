Return-Path: <linux-iio+bounces-22209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE5CB18F76
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87ACBAA1BC7
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF924888A;
	Sat,  2 Aug 2025 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbQAuy7+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C1256D
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153166; cv=none; b=ajCfUkUMrN4BgPPmJ45CKV4jdXH3ExNKH4fKsSGrlzf7zReH96Mjq31e6vSk9oeCpBfgCThtlEkIMfug/lQeHZr9XUod8QEVzwfJoAIfQDjVYkdJTCHP723/n3W94sEVKw12YlGheZoxghLj0G7OPXjUMyFGOBlsaZ3iUOMnO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153166; c=relaxed/simple;
	bh=f2n0GY9LEkY6WErbYA0TwGIejuBo8mFkwXpS7tt+Pyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9HNkgQlgTJdMo6fE4YsMgDp6ExPR/gLFg1didHxYitklxF8jsHnzqDblyKqxbKxirtXb9mEMNQgQ6+k1N1DsZgjG6Kja3+lOdMS54YRtVxhIvvFUeNgepxUSQ32+ODbdqxPQj8eohpAVTTmH/DTZdrC61RlwoYiul9oHXnLaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbQAuy7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458B1C4CEEF;
	Sat,  2 Aug 2025 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153165;
	bh=f2n0GY9LEkY6WErbYA0TwGIejuBo8mFkwXpS7tt+Pyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbQAuy7+LgzYnUle0EX5vcp39RTqwusl/wQ6DJ8sNDtslBIJrO2SA9KomEfziIJYP
	 qMs+0lGlbBj5x/1GlnSlIpS3smOHDSKONyBhxiiGdbz2wpdh6EkNf0Vl2DFVz95ZSt
	 1MupoZTF9r40D3Kroc0CcVZrBlcV5sBS/j0I38fz+ImYE4jQHdb+L1pbyirGwkWrLo
	 IHfG8eYItIgX6jAMmsYmy0GfsOiJb6/ygFIPGiqKIEuEZ7mo+nIdHHXYWc4K2E24pg
	 YlVrhKTh9iR9Ia4amvsexcacCp/tEUlkW6r0vEkrO1ifXyH8oPJ4dHcxvcElgbpqrj
	 K0u7/UAPhwtVw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Christian Eggers <ChristianEggersceggers@arri.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/16] iio: light: st_uvis25: Use iio_push_to_buffers_with_ts() to allow source size runtime check
Date: Sat,  2 Aug 2025 17:44:31 +0100
Message-ID: <20250802164436.515988-12-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also move the structure used as the source to the stack as it is only 16
bytes and not the target of an DMA or similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/st_uvis25.h      |  5 -----
 drivers/iio/light/st_uvis25_core.c | 12 +++++++++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
index 1f93e3dc45c2..78bc56aad129 100644
--- a/drivers/iio/light/st_uvis25.h
+++ b/drivers/iio/light/st_uvis25.h
@@ -27,11 +27,6 @@ struct st_uvis25_hw {
 	struct iio_trigger *trig;
 	bool enabled;
 	int irq;
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		u8 chan;
-		aligned_s64 ts;
-	} scan;
 };
 
 extern const struct dev_pm_ops st_uvis25_pm_ops;
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 124a8f9204a9..bcd729a9924e 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -234,15 +234,21 @@ static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
 	struct st_uvis25_hw *hw = iio_priv(iio_dev);
 	unsigned int val;
 	int err;
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u8 chan;
+		aligned_s64 ts;
+	} scan = { };
+
 
 	err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR, &val);
 	if (err < 0)
 		goto out;
 
-	hw->scan.chan = val;
+	scan.chan = val;
 
-	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
-					   iio_get_time_ns(iio_dev));
+	iio_push_to_buffers_with_ts(iio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(iio_dev));
 
 out:
 	iio_trigger_notify_done(hw->trig);
-- 
2.50.1


