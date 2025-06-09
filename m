Return-Path: <linux-iio+bounces-20323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7C9AD18D3
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 09:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FB6169B0A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DE0280A4C;
	Mon,  9 Jun 2025 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPidg6Hq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5811185
	for <linux-iio@vger.kernel.org>; Mon,  9 Jun 2025 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452790; cv=none; b=VfORRNHT9FfXc2IK/xU48W9rG/8ZlMgIuNLp/sJLYrEExnBCS3FKau3cYfgyTyAt45usNFYVstew4koFZHzpoMqyDATCxhRjRCv1iG+k08YpVBvqcsTXskOuztge6hHcJYCynaZFqCP97Wr+BD/J/2bxMDHtoOhYrgdhXrZnV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452790; c=relaxed/simple;
	bh=PXLWCip1Ovx5yq/n7sI+w+4J7KhwNOtHqVmJu9SNHPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL1Mkx/vcVyLaqhXx27SuDm7nLrE4e4wFW3VslfJE3rUfp8wqFLRN+CbUkY8QTgVW/l0TRwcxKkpux06NlXWAUCggXa3PjQoIDp0Xtk1tdU0sqX97wZ1PUdCdw05OcikQIqfeqK6QdEdoVtyPtdcjXtqfLrrgENQ3ThjFvAhAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPidg6Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5275BC4CEEB;
	Mon,  9 Jun 2025 07:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749452789;
	bh=PXLWCip1Ovx5yq/n7sI+w+4J7KhwNOtHqVmJu9SNHPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPidg6HqP0QIY+LUctV8xgJBog16f4Umen2nDj0FJwPqTmZzzNmV4bk3tmYffl96p
	 OyCV65rylS8MKDSZEHuviBPzC4XVUwf0WeDPIHZaMFWSmc58+uAM4TK1UczDINHfPr
	 E71+I0uoU6a6LBsdhC27pBgyEq41r9x1WSTFHqK9TzEcy95RSGvF3VAWksNJlbkrPV
	 cTcyO3ASVGA3pcFJq1SOCASEw9c2qSYKxeChLhEz3WdxouFY7r7QJ4jQkSJ/u6zTe7
	 TBFrSvv+pQ2SvPjDvO1cmgko+EzVNWDwCgSnI1uZ5Z9XnP7rjiJk8raRjBXU6dKbGI
	 8Sct9yKiwlaoQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio: potentiometer: Drop unused export.h includes
Date: Mon,  9 Jun 2025 08:06:15 +0100
Message-ID: <20250609070616.3923709-2-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609070616.3923709-1-jic23@kernel.org>
References: <20250609070616.3923709-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Resolves:
  warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/potentiometer/ds1803.c  | 1 -
 drivers/iio/potentiometer/mcp4131.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 5761f69c538a..8a64d93f7e7b 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/export.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
index 9082b559d029..ad082827aad5 100644
--- a/drivers/iio/potentiometer/mcp4131.c
+++ b/drivers/iio/potentiometer/mcp4131.c
@@ -33,7 +33,6 @@
 
 #include <linux/cache.h>
 #include <linux/err.h>
-#include <linux/export.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/module.h>
-- 
2.49.0


