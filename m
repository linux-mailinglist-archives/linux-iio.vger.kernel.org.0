Return-Path: <linux-iio+bounces-2738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D3E85982E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4488B2816AC
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324E6EB7D;
	Sun, 18 Feb 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJWVd1jy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D76EB7A
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277619; cv=none; b=fxjS/R1R+YXmLPq9V5c9g6uQvu4xHi1vNUG0dZCYRGST6UeCTe4NrXRGJuXaG+dyfZL8eTEh3nk/mgBYBUeSkYlCKqONLkUg/urWq5M4rIn7rMcFLosTo6FNUpmmB5T8mOyEBMxTj75MfL0nTNkziU8zyF6RCNVndJMEd38mMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277619; c=relaxed/simple;
	bh=S/LRjstRYR3EG0oDLg6p5M21IBCoa1V1Mt6tcFjbNsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4KnLJ0AfVKfrGLPfBrQ0fjtEhnYws2Zz0DM/mietyBC0FjWcepEyT+6yKeiQ91p4CTcHZiHcSYNB8ITIAVvxMJvcdTKNvbteawANkzkWIUhGFn3iomN9M8OW+JQRtS7MDmhdmEakwapkckv/6Vxzy4a2JmJSREHblF+oLLR1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJWVd1jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055FCC433F1;
	Sun, 18 Feb 2024 17:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277618;
	bh=S/LRjstRYR3EG0oDLg6p5M21IBCoa1V1Mt6tcFjbNsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJWVd1jyBkPb5rZfAhNO3g9sPsVx0xDm2QIOqYAMrJWfgO81si8++nwY+PPskW8uJ
	 /ywz1FDpRj5gxltjRkZgmbvZi8ljxfrW9KuBunx5PxZeiR8Ea6QrfJlh7hBECbQL7v
	 XQV/3nKZMmXQMKPRIDXNx7hUxInlWVy5bLTnlNZXqrN2YNkze1Isj6yoYHkI63qX/0
	 VeK12BKNux8+mOq3O4Hj3Z5/VcbuMSgCycgBHPOZML7AhyhaGc34dTTzaon6yqsISv
	 lauwVUU6fuvESjduu8OMU604DKFiMM45uqcyi+DWKQyGJR/Pj6ODJ2WO0WBt+jm+C3
	 Cq58IUKhCHUug==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/8] iio: light: al3320a: Drop unused linux/of.h include
Date: Sun, 18 Feb 2024 17:33:17 +0000
Message-ID: <20240218173323.1023703-3-jic23@kernel.org>
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

Nothing from linux/of.h used in this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/al3320a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index d5957d85c278..105f379b9b41 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -15,7 +15,6 @@
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
-- 
2.43.2


