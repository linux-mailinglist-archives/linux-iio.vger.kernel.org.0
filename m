Return-Path: <linux-iio+bounces-23262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10467B34CD6
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 22:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB897189BE9D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 20:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7C1298CDC;
	Mon, 25 Aug 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P49mH/My"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01428688E;
	Mon, 25 Aug 2025 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155209; cv=none; b=BQ5Ni/ckgWrwf6n9yeqbm5gZsRurdBvu3kGdTDeogcaDulFjgk2PO+ZtXbFf3SjAHc1ux29/syQTap4NIothDoLhPlXk9yC0/ZwgJONH1Fu8ifwHE6DCjBKGv0YknIyTYwgaHD4uMHJxw0haZCB8g1HPxkHYR922qLddjHs7dUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155209; c=relaxed/simple;
	bh=s3tmR7nxofceGS0RADamNfNDc9paoHZFEDJVu8jYTu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdWsa1eK/vx91q2p6zOzUmzLfPOmqf3KTHzM8egbJJA0veR2GtxrWze0ck7qQhfqeDBzBTGunrqvG8S+RaZlpMxxdLHTb9zBUcNoFC/Z7d85gyF+X8CsPgtOAL/qVRYB+DPvrgg8IeYBP/2LW4FjCF1OkVLJMASGh0jLduaHoPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P49mH/My; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756155209; x=1787691209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s3tmR7nxofceGS0RADamNfNDc9paoHZFEDJVu8jYTu8=;
  b=P49mH/MyecKbEK3JICS+vRL+ppUb8iHHnZcb+m7txh9YTm3LgXRlJPyC
   dvS5HMcH+sYwMJ0aMDBlWccUtV2ON5jbj9sTg23bGQ63dT8yATBb1hHN0
   S7D6vP8bGRizHh3RbIjHLKzdUx+d4b+RYASWUlAhcotoIKNBrAes+132L
   l18HnCcx1cV7liid0Zvr29u43YBlrx5L3ZsBMqzvZ7wFTq+54QDNS0myD
   +YCMAoeEXPHSKbmNHYgfuV7Q1CKYyOrXUyg5m/KFQZ5miiKVEvbcsFXmA
   JUY7Ey0Jp7wmsi2a4lhpNGsnpbWzAaxTSK65339rSkacsgpigzDGfpljf
   w==;
X-CSE-ConnectionGUID: o+9OSFHvRK2zlk53zvYocQ==
X-CSE-MsgGUID: iXvPoQivSEq+4M/DQYhtKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62205754"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62205754"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:52:43 -0700
X-CSE-ConnectionGUID: F+7z9UEqTpCLzRepANTSzQ==
X-CSE-MsgGUID: hMmmi/nIT2mlfySCXjSzQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200286930"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:52:39 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 33C1C11FB0F;
	Mon, 25 Aug 2025 23:52:36 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uqeBA-00000007PWX-0Pyt;
	Mon, 25 Aug 2025 23:52:36 +0300
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
Subject: [PATCH v4 1/1] iio: dac: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 25 Aug 2025 23:52:35 +0300
Message-ID: <20250825205235.1766401-1-sakari.ailus@linux.intel.com>
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
since v3:

- Fix condition for calling pm_runtime_put_autosuspend().

 drivers/iio/dac/stm32-dac.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 344388338d9b..874e6dcc0d61 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -82,9 +82,9 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 
 	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
 	mutex_unlock(&dac->lock);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&indio_dev->dev, "%s failed\n", str_enable_disable(en));
-		goto err_put_pm;
+		goto err_pm_put;
 	}
 
 	/*
@@ -95,18 +95,9 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 	if (en && dac->common->hfsel)
 		udelay(1);
 
-	if (!enable) {
-		pm_runtime_mark_last_busy(dev);
-		pm_runtime_put_autosuspend(dev);
-	}
-
-	return 0;
-
-err_put_pm:
-	if (enable) {
-		pm_runtime_mark_last_busy(dev);
+err_pm_put:
+	if (!enable || (enable && ret))
 		pm_runtime_put_autosuspend(dev);
-	}
 
 	return ret;
 }
@@ -349,7 +340,6 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_put;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-- 
2.47.2


