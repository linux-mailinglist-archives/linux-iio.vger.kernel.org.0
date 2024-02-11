Return-Path: <linux-iio+bounces-2423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5B5850B1B
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35C3B2247A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D25D758;
	Sun, 11 Feb 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZapYHsWb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050C5D73A;
	Sun, 11 Feb 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679594; cv=none; b=kH9U2BukyNCx3eTs06eCEFf+QOYCr499oVHAZPyoORYBz76K7NEBKJbcwBJueiEgB/5u0OzzvI9C4bozOLmtS+w3d7/nfmZyTVBY8Hh7ec74j74F8yCAEgu4IntvqjcQMBlIqxZR0OKspC5a0aLTzqCrZksaLj8kR9zEqc9Bg/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679594; c=relaxed/simple;
	bh=5BKBVxpx4qstzc7Dy13OyBJbrkG74U7h3TrTUSitCsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8esYrSXMDzdOVRgvt93JDDCsULhN/WEuLdooH2ak8Krq3Bda76uP61pE03ma7iasZJBoEZDvLFZXb9M7omDVe3N1ARSEqPz7FvtNB5YPUZMEGDyT/0RvJ7ivwPPKpKp/L2Ed0wl7zJv8tOfGQm8vao/zT7eWoVzg8/lLPF/1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZapYHsWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3059C43390;
	Sun, 11 Feb 2024 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707679593;
	bh=5BKBVxpx4qstzc7Dy13OyBJbrkG74U7h3TrTUSitCsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZapYHsWbFynFnItbU4COXZOxEHrq8zsYUum2h58zqy/ijFZi3ZQjeR85BziLCxCga
	 ECFdotlGWVV3ndxAULB7exNmfwdWau2cQdKkE7Uh2jj1VIbI7voGU4tp8JArPbPTkP
	 7b0Rntnf+Lgb64nvDQ8G5LgSsjBTj+u3Do5pKNXNqN9Q+lQCFOy1CBQ3AZXoslcTby
	 y5P4B1UHwDXQh2n0R6Cu2P86ed6gEIxoS66197uLR+Hf3/zF9lkNo4Rg1qKCiZYxOd
	 irjKY8ZM9yR+TnnB2bQJdYeULuWSVQCwXiW86CHDxUGo9Mu4l4mUUznwGyAdo9wYC8
	 kAvt4/6o17DTA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 01/14] device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
Date: Sun, 11 Feb 2024 19:25:27 +0000
Message-ID: <20240211192540.340682-2-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211192540.340682-1-jic23@kernel.org>
References: <20240211192540.340682-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Useful where the fwnode_handle was obtained from a call such as
fwnode_find_reference() as it will safely do nothing if IS_ERR() is true
and will automatically release the reference on the variable leaving
scope.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/property.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index e6516d0b7d52..bcda028f1a33 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -12,6 +12,7 @@
 
 #include <linux/args.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/fwnode.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -188,6 +189,8 @@ struct fwnode_handle *device_get_named_child_node(const struct device *dev,
 
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
+DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
+	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
-- 
2.43.1


