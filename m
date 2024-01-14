Return-Path: <linux-iio+bounces-1652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9682D19D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097A91F21587
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA72569F;
	Sun, 14 Jan 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXziJ5om"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109E5CAF;
	Sun, 14 Jan 2024 17:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19FDC43390;
	Sun, 14 Jan 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705252838;
	bh=Ukabpf2CYiS7klSJyLWLhreXlpdkCnBkQQ35UjxJ0yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXziJ5ommQ1AJg3C53ZVKIG1QC6edP2v2Ll2POveAbrGn81ItuGN4rUZQk7kdWc3F
	 DbBB1aQ8/cK47PsEMtA7Vw3setAMCc3WZAMvju6fEB+H6eW6pl5uFCITOZL5uZIS1m
	 GyaaK4rwr9v8Js9OyYAISoXSBIeprvbHNj9kjFOB/5wayvtrN9K5ZUKED57ZS8Q+Tg
	 17OguujX5MZsf1d/ee+ZjATjEDbhL4XoPamWTUDxvKkZ8vMVfFXBdEsRUkLu8a9wD8
	 JkZ9kQvJ2NJgM9gMWtVwfBoZ4AxMF4bdlILLJpAEnUz7ihP57aE6k6NVs8mk2CgoiT
	 iOhVUywpHj6kw==
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
Subject: [PATCH 01/13] device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
Date: Sun, 14 Jan 2024 17:19:57 +0000
Message-ID: <20240114172009.179893-2-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114172009.179893-1-jic23@kernel.org>
References: <20240114172009.179893-1-jic23@kernel.org>
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
v1: Thanks to Andy for reviewing the RFC.
    Add check for if (!IS_ERR_OR_NULL(_T)) to allow the compiler to optimize
    cases where it knows the passed in parameter is NULL or an error pointer.
---
 include/linux/property.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 2b8f07fc68a9..9f3190d902ab 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -12,6 +12,7 @@
 
 #include <linux/args.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/fwnode.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -161,6 +162,8 @@ struct fwnode_handle *device_get_named_child_node(const struct device *dev,
 
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
+DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
+	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
-- 
2.43.0


