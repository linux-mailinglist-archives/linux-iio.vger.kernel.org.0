Return-Path: <linux-iio+bounces-2702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B5859109
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEDE1F21EA8
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E43E7CF31;
	Sat, 17 Feb 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSY94x0X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6121CD1F;
	Sat, 17 Feb 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188197; cv=none; b=DnfU9KFQvDU3+QM8tn7/NRWpiy5dAsUMoJdRWnsGSSiqzcYUwba0zbxj+D+WXKuqQznj4AiIr03wTgdKDRkivhD837bXE6NQsp6q6Ide1q1v6jZs/9nEPA4gCxerFL8++pt33SqsenSL2hJjDZyOblFxfy+QYuH/w816UTNd45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188197; c=relaxed/simple;
	bh=ooH3tVQ8RhEdYrJS+Vd+dsFlhzvCEObmeWM2dC5oN6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGBJfgNygHx8+NfaJ2NUW4+o+4qdXhGu31VVPs9lEHraLotVJm/sctiZpwz7P3BBtL9hOBseoynKZCuV+8fc469WGcIETtKpiXfNh1uvx/4V1zuSPIqeXqUKt36uRzGeM/LZ8RRSpmaJjW+oEoU2VM+KLPnKHtz/6IUZZukiR/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSY94x0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2AAC43390;
	Sat, 17 Feb 2024 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708188197;
	bh=ooH3tVQ8RhEdYrJS+Vd+dsFlhzvCEObmeWM2dC5oN6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSY94x0XaOQQtXNPAGaCbycdnINGUhe2kjmUcsffUkuLQXn6xGcGsVr5ba8jL3B8o
	 GVPTNMJGWQU/CE8y05qC+0whpQkNclHXH919zD1UdNf4D9IjrpyDAz4ej8g8ubdEXX
	 fbZmjXbxiTaUjLQdE4bKieW4mtvye6fez2iNCFI6SdokrC1oEBH9Y2J4TfIZmQze3D
	 cKpu/VMrafWDjjRWH8dOOVAcG/wgs+gCbAvitEaYZ11Ky0XXzRzVfdYJ9vPVWSp5GU
	 vm4vWTnG8RPacRiW3I0wN+ynz2SZ4e1SfnhTCEuahsg8+U7IyzPzaeoj6WoEJKMwyt
	 J7SSbayjypevA==
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
Subject: [PATCH v4 02/15] device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
Date: Sat, 17 Feb 2024 16:42:36 +0000
Message-ID: <20240217164249.921878-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217164249.921878-1-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
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
index 151bcab4f92a..9e67c3c4df6e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -12,6 +12,7 @@
 
 #include <linux/args.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/fwnode.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -201,6 +202,8 @@ static inline void fwnode_handle_put(struct fwnode_handle *fwnode)
 	fwnode_call_void_op(fwnode, put);
 }
 
+DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))
+
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
-- 
2.43.2


