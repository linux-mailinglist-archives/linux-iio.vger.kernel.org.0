Return-Path: <linux-iio+bounces-21459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC7AFDBAE
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339D916B8AB
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38062676C5;
	Tue,  8 Jul 2025 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUGDuHzo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E978023ED69;
	Tue,  8 Jul 2025 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016325; cv=none; b=Bvs+aYLwVK8oVJfIRRbBeaGb+9rO1yLtoq0JVNXHxUJLdOMb+G9cSzeIgp/W6lEkIl7h0/nvZxvbcqbhBVOe/styZSgcqC+Exuvxl6153Yy+zTdEiLaXnfOc0A7OmN3LHaJ13pf9gNDHUXbuuvGY9D5rgEIWVXZ6meCA7Nug49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016325; c=relaxed/simple;
	bh=+5338cMqQU2rGHFu48LNn/r1oQ0QhuBVd3BcfZXppsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3eUSeJGBWjnRlAM/bNLBw+rFQeU78CBZ1MYlm6qir/V6qqqwLeWF1qugrufD8hKv9ccwwAq6mgaO8yGTNsZx9ECFcCMfYnowcM0SmYN5d4QZNzeb8absF3JaSrO1pCdtWLMG5N020mzrrWTmvZt9vyAaWM47ccM+nLqL+G1oFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUGDuHzo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016324; x=1783552324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5338cMqQU2rGHFu48LNn/r1oQ0QhuBVd3BcfZXppsc=;
  b=nUGDuHzoFzikpvprJaD0qM63MgVc4BzK55Q5eYY+Qtvh8UEXVvxS/JPm
   REctFr19FOPnelWVhg3F1Tjmw1gA1kCUdJa0ymC/xD8iq6Zzh1/+fJsPs
   W8lAmUXfsVLyfAI3kO3nk9cd5nIIQnW5djJZd3LaleBWhurDWpmZLgu1z
   xEamma5/zyJO4mclhZjBXjLeBV0oGOkK/TyTlG2nXEztLzgbMoBUVYeBO
   ZggqLMSXxOl/y3ekkgE/PaQfe58ShOkILka8sp36AUuF8cqqw6KUlub8n
   QnrZpI3IWHFP+F0qOQQA68p+PkVEYBcSjcu+DCspVp7E0eCj6URPUi3Hj
   g==;
X-CSE-ConnectionGUID: 2YF/dtSNRnasT+K8Gadwhg==
X-CSE-MsgGUID: SKkHkrQOSVyqbiCZARd9GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53986974"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53986974"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:03 -0700
X-CSE-ConnectionGUID: 4W+WSgAtSjmJGSXyw7zPTA==
X-CSE-MsgGUID: LzHpjpi4QLuTcRMK8BIKfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622638"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:01 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 81A89121576;
	Wed,  9 Jul 2025 02:11:53 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTd-0044qm-1d;
	Wed, 09 Jul 2025 02:11:53 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] iio: temperature: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:53 +0300
Message-Id: <20250708231153.971947-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
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
Acked-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90614.c | 1 -
 drivers/iio/temperature/mlx90632.c | 1 -
 drivers/iio/temperature/mlx90635.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 740018d4b3df..8a44a00bfd5e 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -225,7 +225,6 @@ static void mlx90614_power_put(struct mlx90614_data *data)
 	if (!data->wakeup_gpio)
 		return;
 
-	pm_runtime_mark_last_busy(&data->client->dev);
 	pm_runtime_put_autosuspend(&data->client->dev);
 }
 #else
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index ae4ea587e7f9..bf689f6143f3 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -1043,7 +1043,6 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
 	}
 
 mlx90632_read_raw_pm:
-	pm_runtime_mark_last_busy(&data->client->dev);
 	pm_runtime_put_autosuspend(&data->client->dev);
 	return ret;
 }
diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index f7f88498ba0e..80d0eb7d2294 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -749,7 +749,6 @@ static int mlx90635_read_raw(struct iio_dev *indio_dev,
 	}
 
 mlx90635_read_raw_pm:
-	pm_runtime_mark_last_busy(&data->client->dev);
 	pm_runtime_put_autosuspend(&data->client->dev);
 	return ret;
 }
-- 
2.39.5


