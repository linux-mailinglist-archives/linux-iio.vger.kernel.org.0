Return-Path: <linux-iio+bounces-2659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A6C85848A
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7536C1C21141
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED05132C1B;
	Fri, 16 Feb 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQMr2kNI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A812F38D;
	Fri, 16 Feb 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105970; cv=none; b=XvVeohppBkpgDBkK3akUskH8n12eHF6ZJ+HiKFGNLjrFlKB4HkFN4t2JpKKZuIfvhxq70STTPDzW9lGI2RWLddMBoQDP6vPmsTePRIXUTSNT8o77oiS/nJFX/jamOuq/iYsh7IsJm/teZiqXSnEmO68zEIomoyGL352lD/aJjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105970; c=relaxed/simple;
	bh=ooH3tVQ8RhEdYrJS+Vd+dsFlhzvCEObmeWM2dC5oN6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4OHXJlkVbQvzvWUJzmRWRi6XEhcFWEQckDzRo0T9JxO1onye6OJOLUuyQLfvdHdoJ7f6R+XAcNh4MfE+Xq6fhfGJA/vMiEjT8Ca8xs95eTKZF5S292uTF6fvFU3GutTyghEc+aQFZsWDsvJM/96y0vTf+QSe3aY37d1wxqsYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQMr2kNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04299C433F1;
	Fri, 16 Feb 2024 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708105970;
	bh=ooH3tVQ8RhEdYrJS+Vd+dsFlhzvCEObmeWM2dC5oN6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQMr2kNIKv9JO+vemAAOG8JYySOol6MLWIkaHRKyVby2H7S6SMaynLsGdo7yu+uVJ
	 899WJBVOTgy/a05jzF0BRU4WsC/ojl5DnyvBi9sBjY76ibULtb7W1RJuOS6thfcqyo
	 y3FivUtfZNmVnNC8a7iLuvneheBCicG9DQmaeLGv1Kh4+cQAfTIsPHtN3cPmL03Xpj
	 waRZn3KjkJf4fwbunwVdiCUUHr8tksy5aT2v2SAsioyi4b8klRjRigJ+nRnXYOcV3M
	 BQTp753NzLtYvLXyGQC76KhGFAKsLt8PYdU9X4e2OsEV5vsufj64jgwJ89wkdY00Du
	 NZWCgIMHxtE5Q==
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
Subject: [PATCH v3 02/15] device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
Date: Fri, 16 Feb 2024 17:52:08 +0000
Message-ID: <20240216175221.900565-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216175221.900565-1-jic23@kernel.org>
References: <20240216175221.900565-1-jic23@kernel.org>
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


