Return-Path: <linux-iio+bounces-2737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B39285982D
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36782281639
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E2B6EB78;
	Sun, 18 Feb 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN1eOvQz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A71E898
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277617; cv=none; b=pn0c6PwUDyUvA6Ohe7tuvIe3Rm3jugnPAae0TRfCJ8Pm+cx5g24rbOtNOMrWsUzB5xuy/Uu2shwj1TEz22xR20XNGDtpv7pXx7/DSNFJbJi7DLCrk9bQ75C3LcSWLHtdcRpi+vYAypUj7yBGmwW51mQFZBKW5bgOJWc9lfN47xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277617; c=relaxed/simple;
	bh=sMLAsyXWukJqyRW1lBuaK9+AwiOtY5vQok5paPmykwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unEfeXRhr69iZ/IRsHKvxEsLGzgK7fFfn7UvHMyuPWWwdMHbo6eQ9PvGaW+wHfOCloV1cwfJQOvwp1cu7JCnUB9qJEjEXE32iYi6VvxjMjiQsjRCcwkdTEWet0/qH2ANieh0M1cuOiFw9NshQphJ05QNir7xEJ9of8ro4iedGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN1eOvQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5BEC433C7;
	Sun, 18 Feb 2024 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277617;
	bh=sMLAsyXWukJqyRW1lBuaK9+AwiOtY5vQok5paPmykwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vN1eOvQzoW08uPeSOp5cHR0MwRhU6F+qqrPMQZekxIL7+UeuKSAjsf9fMA8DYXXIi
	 LRzs9U418TMPusIAJiv7uO1lYVCPhvbhCRvvqC5tvwrF5gHzgOrwm9HLOMhWB/81b/
	 7GTBJB01mAfPyYADYWTlyZ48NbEqgqDV7eGUHQ/Dt3ImrfDwHVIz2VQxBKsPeiHIRP
	 qvptUomRKiiablu4B8qmhTjiOUbYpuOi5Krm7b5Mv3kjjO2FmuGGaXtH0G4LPgJ/Mu
	 IxAkD1My6ULbbw/PvlWE7bCqNi21jE2tvMgWy0XfheDDvM0QbJauL27FCVIShv9SFH
	 kFwBTzpwb5Jww==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/8] iio: light: vl6180: Drop unused linux/of.h include
Date: Sun, 18 Feb 2024 17:33:16 +0000
Message-ID: <20240218173323.1023703-2-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218173323.1023703-1-jic23@kernel.org>
References: <20240218173323.1023703-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Nothing from linux/of.h is used in this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/vl6180.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index d4948dfc31ff..dcadf6428a87 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -20,7 +20,6 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
-#include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/util_macros.h>
 
-- 
2.43.2


