Return-Path: <linux-iio+bounces-21452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A59FAFDB9F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A2C3B5CE0
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBC23506E;
	Tue,  8 Jul 2025 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deG4JDaE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4C2327A3;
	Tue,  8 Jul 2025 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016319; cv=none; b=fKhw8TBMbajzrB+fvfFJ9bAQHCVSJpZMb2cB3wY2NyE2mLCvTq5E6VIinpUynAOyf/u4uv+Tap7yT5nuhuSPyR21k4u/7Zt21jisy7wUdovB780Dm+ANBLTimdDQt2/T6Y7GKA/zypJAkEvgv9J4a9wYwCMgCQvYQfug1micGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016319; c=relaxed/simple;
	bh=WFszKILMRwmG2vvNOz2JSoQXJi4ALGv+761qRqw8N7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OPMQm126uY9TInNgPSZrxS7KbkLvSCIkYDQB6ZgAJ6adp/YwvUncvCVw3BTkXh330HanimKB9h4NZx4Gk2dH0lWP5QpLXGWv0Joeh+sq3V//aMi3LlJ9SKV9FDS9InP5z+pxG7eIHSKf2LMjX4ACstq82WVAiRYv9359q6/1VEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deG4JDaE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016317; x=1783552317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFszKILMRwmG2vvNOz2JSoQXJi4ALGv+761qRqw8N7Q=;
  b=deG4JDaEaA1XWtf2+mlvW/kRXJjMM+hn1FRk2Mv1cPrKLLPDGu4czey8
   O7b8rrlPurdR0Jrz27j+aYuJHCspENgv9IqpeftxjBiXoZmTEROq3a/2O
   tlO+YIyaF+9fpdJlF/2D+CSgmNYKNtISV3gSOCAozBw8FU2AuDlOUk8fu
   D41zgsOI2QkyoZVv5l0d+87AlxJrwmdiEF12uiy910xlDyT7F0Bfls2mw
   6j+fuWVmZu/PjkM+27zB6szC+1oCDWJGgjcIsqJojzY/yxqVJ0xHY9E1h
   Vy8nx+paKH20Zq+SuQuQqrDs2h43r/gn6vVUlVaV0KHOyrYC8L3UyLS4d
   w==;
X-CSE-ConnectionGUID: LPZm1l4cR5ivqM7P580Zjw==
X-CSE-MsgGUID: jNGRKTmPRiqQRIPQ35Tydw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53986860"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53986860"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:57 -0700
X-CSE-ConnectionGUID: iNe/1ro7QGOTCdNYGHKyXg==
X-CSE-MsgGUID: fAc3dL1TQ26z3BUMVFdwjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622610"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:55 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 70052120FD6;
	Wed,  9 Jul 2025 02:11:52 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTc-0044ih-1P;
	Wed, 09 Jul 2025 02:11:52 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] iio: chemical: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:52 +0300
Message-Id: <20250708231152.971446-1-sakari.ailus@linux.intel.com>
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
---
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


