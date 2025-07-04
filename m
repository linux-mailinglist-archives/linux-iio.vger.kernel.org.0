Return-Path: <linux-iio+bounces-21332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82803AF8A8A
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82FF17BB560
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357F2E0B55;
	Fri,  4 Jul 2025 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkF+MixR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A12DE213;
	Fri,  4 Jul 2025 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615677; cv=none; b=oPZwT00JNY/myyBKkGIyVH50oB/Bu/G7au/NzTrDZtn6bE+iaIonlHDagY+83UBYn06YSIcGOp1A7CtYrx3eRz0Fe94Bc6SZdE/1N2XjU2Qsl5Mvif3Yg+hG+AgbRoZhN8m2iHk9NhfP9GF/0bqd1QM+/Y2GGMDZlEosF8r/NHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615677; c=relaxed/simple;
	bh=U4cRFiXhV5fuNveZFy2qth9WbtB5GmycvcJ19tMoPUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDUYFx/fiLVeiViOC70F9P5lH2NjDnnDBgH/2JQR4VLKtTnQ21+VrjAGLp+HtQQR5UIhVKeuh6EQ/Q16+O93oUMn8XCEvkpFWVLmfH39MBS6x34mCN4H39Z41OybjYFKJb+HODas1Mul6SWgX4n0bbF5rfc7gQntlL/3YvkrjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkF+MixR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615674; x=1783151674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4cRFiXhV5fuNveZFy2qth9WbtB5GmycvcJ19tMoPUA=;
  b=dkF+MixRkAZeCq9C4/xBIomZkwGF6IRv+nOvpLqyomHd+7mlzOV9JwbV
   6AsQTN/oXNucaT9Tr0Q1U+SeeBes/79Rc3fjN5PgXIDt1Hx7lTkAHAKsx
   O0h+AVeKvIgRMarRwZ6EyUWfTwYi1rimf6NT9A2sEfbJkvKt7SDdKfoSk
   BV2V/xOE0wBV+bgbLMCAxWKdKS79v5aCC96SbUz8+aAzEHn9veZeZeSjG
   0dLdiKi8t5Iu3NZ91XCFUYwsLvqWjlrlBOHVCcka2GX/ONWgsBlXfx2zM
   i1/eiJ9i3KEw6zJd95yUTvc/nrMSM83CuMlNqfHupJLs3mFnvz4Bt+50W
   A==;
X-CSE-ConnectionGUID: qEUpBuGlR4aSh6dFwNV5+Q==
X-CSE-MsgGUID: jkIF7p0RSaqpVYkNOVw5dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494733"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494733"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:32 -0700
X-CSE-ConnectionGUID: VStemBfWTXuxdhYmeQqU6A==
X-CSE-MsgGUID: cM7qXbBkRyyVW1p24x1X0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924307"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:30 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 4B7A644394;
	Fri,  4 Jul 2025 10:54:28 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 38/80] iio: temperature: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:28 +0300
Message-Id: <20250704075428.3219924-1-sakari.ailus@linux.intel.com>
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


