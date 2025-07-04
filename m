Return-Path: <linux-iio+bounces-21324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE9BAF8A74
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B3E1CA277C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F52D6625;
	Fri,  4 Jul 2025 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQHbbXQV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393362D542C;
	Fri,  4 Jul 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615667; cv=none; b=ICk+FijGw/sdhBWNgrzMZQNaLtBb4XHwIPZirSyT/wEJquyPFNrjqGVtA7Ek4bXDcMOUap2zD/p79qY4dW4QXcyGKG8i240hpWM/CdaFFOffkrIWFuidDFANwXZlAD6FghJNoNZc5RSJB93ExPbnE1b7JpbtExHXdMxjIjzwz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615667; c=relaxed/simple;
	bh=EsSRBPHL51gb+N+5iscaLJIMNNVWp/ZmaF2YUnpikUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBxvQPYbme9U0slMyKfwCMfR0OS7+9wa6cAYuTbm+yL3zX+9FGXqe+/NlY/qwL7X55I6EErHUtDb7ZFz94/LFt7+UDEKt46sagEv8R5zrP20l/5U1sIk3fsZLP7HWXw92FfmtDQGV00QS4QuimV2dcbrpdnEA9NDRpB3S0v5t8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQHbbXQV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615666; x=1783151666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EsSRBPHL51gb+N+5iscaLJIMNNVWp/ZmaF2YUnpikUU=;
  b=hQHbbXQVoS7KlqWhGqUPzqm0gZhKH5DbmVjnMXBtsp+WKaB89qQskePN
   AwL/NcdifJQsHrGKA2lLX3r15XwKYQb/V6MwIj6a4RxwssK+rKwSU/lzM
   MMvhDawrndoExWqouvqD4MgebV/KwlK06sNcSTh5Lg4+CZBBJAy1YPmCQ
   9jFsEJCAazlCb/CllacYrMC64CjZfIy47IWbRG6n/LO/b2oWphaWcSRMD
   LudJcA3GSdOzMP1J8JDUko58HNVQjA0cmW9a8OIbZLsA3ieUZFcylpE+v
   bKvpSg59e8kBmiKhsqMQ29TdPowbvFHQxk2YNb47rMco3a2O37Lp2gcEj
   w==;
X-CSE-ConnectionGUID: wB3T8GAkQi+uYAF/rtbfrw==
X-CSE-MsgGUID: 7tZPsp/vRH2tMW8Y8cBj/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494614"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494614"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:25 -0700
X-CSE-ConnectionGUID: qtuDCPjqR1OZ4WgHSakl5Q==
X-CSE-MsgGUID: zqALsrCnTiGhdANOempUEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924263"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:22 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id CA85844910;
	Fri,  4 Jul 2025 10:54:20 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 29/80] iio: chemical: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:20 +0300
Message-Id: <20250704075420.3219166-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
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

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/iio/chemical/atlas-sensor.c | 2 --
 drivers/iio/chemical/bme680_core.c  | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 1daaa36f87a9..8bbba85af699 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -425,7 +425,6 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	pm_runtime_mark_last_busy(&data->client->dev);
 	ret = pm_runtime_put_autosuspend(&data->client->dev);
 	if (ret)
 		return ret;
@@ -491,7 +490,6 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
 
 	ret = regmap_bulk_read(data->regmap, reg, val, sizeof(*val));
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 61d446fd456c..70f81c4a96ba 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -950,7 +950,6 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 		return ret;
 
 	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -1021,7 +1020,6 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 		return ret;
 
 	ret = __bme680_write_raw(indio_dev, chan, val, val2, mask);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -1140,7 +1138,6 @@ static int bme680_buffer_postdisable(struct iio_dev *indio_dev)
 	struct bme680_data *data = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(data->regmap);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return 0;
 }
-- 
2.39.5


