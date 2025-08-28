Return-Path: <linux-iio+bounces-23335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4408B3A155
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 16:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994003AB68A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67121311C01;
	Thu, 28 Aug 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfQIf4iI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324418FC92;
	Thu, 28 Aug 2025 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389985; cv=none; b=nufmR8ChHgg0YWTnc6WTfIEZXE7rDGxD4ltri9UiDV0q5maAcLHXwMXYq50eTBu+Nh2WEwbEhzv93lwn687ZFy5Ni2+UfUb7pQFO+PZIltbdi5E7G5OHYEdELaiPFQQLrqghv8331Uq0LYozlFGHEwTQi8jzu1xhJEb8K4tmdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389985; c=relaxed/simple;
	bh=B/siCNsmCwDQeXpu3CoMuywLNybWqg95GF25BmBeqh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3ZuuKxatwC71F50397yuA7paNAHKkdCVzgz4TtTHhj4YCp84/C6lPPAMERx0D4Xz0Ky7amEC7e1Sb0/8PaS3723dCVIi/ninO6em0IXZMMNAK/J5KLerrDCIX2yg6wvfcghFohEuc6mzq1daeVH6oP5MHy3BMOdY6zF7sGabX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfQIf4iI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756389983; x=1787925983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B/siCNsmCwDQeXpu3CoMuywLNybWqg95GF25BmBeqh8=;
  b=gfQIf4iI+J4Cg2aDAKA2nIvA2txDZzeo+YdDPsdZ6/acCLgMJAt2gheU
   p5LMYstxL2uluxg1vZ3ILi3iUsUWEUATjMWJDsfyHB9NaanlgqCEqzlB3
   8NBPFE/iI5Y6jsRLuouA/rKsrqY/vTIS043iDiF1QcYU2sTC7mLXqu3S5
   JlmCm0gKRhTJOHH+CLxgfOKCAOGj6vtONK5FApTU0R39prDDJqTm3RKSh
   mirBe8xFUehOCj23jCzfjGz5qLYE4qUWygaHB3NmgNa2MHMlUhvXOWE4o
   aDTY1GWzP+xewK89F/WCzyjooG8p6PRR7hULXGPlx1u+9Oxf/yjwIttLn
   A==;
X-CSE-ConnectionGUID: 5VCgn782Qiqq9TAZssmKwQ==
X-CSE-MsgGUID: hwYoIk2+TFW3/GAIJljClA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58761027"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58761027"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 07:06:22 -0700
X-CSE-ConnectionGUID: t6gOAOP+TACRhUM6B+ICGA==
X-CSE-MsgGUID: 8xq7RtMETomLkqQZxpW0+A==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.135])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 07:06:19 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E44B411F9D4;
	Thu, 28 Aug 2025 17:06:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1urdGb-0000000DOiq-3Rlx;
	Thu, 28 Aug 2025 17:06:17 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [PATCH v5 1/1] iio: dac: Remove redundant pm_runtime_mark_last_busy() calls
Date: Thu, 28 Aug 2025 17:06:17 +0300
Message-ID: <20250828140617.3193288-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Also clean up error handling in stm32_dac_set_enable_state().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
since v4:

- Rework error handling.

 drivers/iio/dac/stm32-dac.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 344388338d9b..b860e18d52a1 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -82,9 +82,11 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 
 	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
 	mutex_unlock(&dac->lock);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&indio_dev->dev, "%s failed\n", str_enable_disable(en));
-		goto err_put_pm;
+		if (enable)
+			pm_runtime_put_autosuspend(dev);
+		return ret;
 	}
 
 	/*
@@ -95,20 +97,10 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 	if (en && dac->common->hfsel)
 		udelay(1);
 
-	if (!enable) {
-		pm_runtime_mark_last_busy(dev);
+	if (!enable)
 		pm_runtime_put_autosuspend(dev);
-	}
 
 	return 0;
-
-err_put_pm:
-	if (enable) {
-		pm_runtime_mark_last_busy(dev);
-		pm_runtime_put_autosuspend(dev);
-	}
-
-	return ret;
 }
 
 static int stm32_dac_get_value(struct stm32_dac *dac, int channel, int *val)
@@ -349,7 +341,6 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_put;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-- 
2.47.2


