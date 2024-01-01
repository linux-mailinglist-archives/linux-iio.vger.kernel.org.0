Return-Path: <linux-iio+bounces-1370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA64A8214A2
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 136FFB212F4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C66FB0;
	Mon,  1 Jan 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCtC1+8c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE48BE0;
	Mon,  1 Jan 2024 17:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C6AC433C8;
	Mon,  1 Jan 2024 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704129994;
	bh=BRaVc0TznsbmBTXUWQHMuKv0f+AicWQysz8AaK2k0wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCtC1+8cB8LW0WFsDQJXZUsSo12ZPPD138R80YVZ1abB+98mjBIuKs7MUKkFqrjPE
	 JljALIHKOUiAMO7eUmIgGrk4GnBf8t5Z2W71ZHAzPH7udeNEIylwC69xx0uw6B0wBn
	 CgYWGmnCtjubX1lNzVeO/VgeFFoIEk1JAOkn2ayB1T/yml9tAIXs96JPANjNs79sLk
	 dF+vGd+tkgL4NnnFoMZhH6m79NrwJ00hS5BBZHwDs1OjgUi/BjS5t7BuIGfeRa1CPD
	 VY3PUds8yhXU0fSVlL4xbOAzpvOkul6g3ov/e3zte5+x/gXH+l3wZDPXeMIFwN7Kpg
	 XJ+18cbU4EPoA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 01/13] device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
Date: Mon,  1 Jan 2024 17:25:59 +0000
Message-ID: <20240101172611.694830-2-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101172611.694830-1-jic23@kernel.org>
References: <20240101172611.694830-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This allows the following

struct fwnode_handle *child __free(kfree) = NULL;

device_for_each_child_node(dev, child) {
	if (false)
		return -EINVAL;
}

without the fwnode_handle_put() call which tends to complicate early
exits from such loops and lead to resource leak bugs.

Can also be used where the fwnode_handle was obtained from a call
such as fwnode_find_reference() as it will safely do nothing if
IS_ERR() is true.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/property.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 2b8f07fc68a9..135ac540f8fe 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -12,6 +12,7 @@
 
 #include <linux/args.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/fwnode.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -161,6 +162,7 @@ struct fwnode_handle *device_get_named_child_node(const struct device *dev,
 
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
+DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
-- 
2.43.0


