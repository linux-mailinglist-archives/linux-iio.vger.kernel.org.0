Return-Path: <linux-iio+bounces-2704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7285910D
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81016282348
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA46A7D3E1;
	Sat, 17 Feb 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLP6zvCy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519F1CD1F;
	Sat, 17 Feb 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188210; cv=none; b=UxJax9vSOzFW79nGbbXrZFsccHgtHMIzNEY9maaxTNEIqLEL1cvmYkDfTTCC8QG5tFvws5EZKh06f+N56Z280kx9j4wy9RbqNHzgVCpvMcS9mRDzmOC+bgHYRZ5R0iyCXWsG1As/669pz3pS3eLVpSxZteY9rN1w6c/DUdq329o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188210; c=relaxed/simple;
	bh=ftsl0GWv7l+uVhUJMImD4iqguDNAhLTZlsSgDMYqxPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaTOoOHraxFtaSTvfgavubYl35wm6K1j6I8HbPnxjRZEh6aLzGSmc0U9XiSL8IdXbSus0QcPDhfdEXRinSVbwMyxQu2C8ZrGj/Ncy4Cg9Y4YpJPfaQUWRv4tb/Rh09CDgdduw6tqPainrlo1FVYZzoAPdSEe+zu+MSSdb9NlCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLP6zvCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C2DC433C7;
	Sat, 17 Feb 2024 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708188210;
	bh=ftsl0GWv7l+uVhUJMImD4iqguDNAhLTZlsSgDMYqxPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLP6zvCytfjLOb5dLWYtLb/xpGpI7Bybyho0KzH2BGb3A3vFWphNxdIHDHlyU7/dl
	 AFx3Ld146rZmJgMa7Qod66QZmybwEhuUtA4rWo649KrwCE4v1Jih/hhyLlvzBpS+8G
	 YIEFRofHPrxwWWuPKr3bQ/MGfKVHshBnb8Zn+4xPMMXyeMjR+KERdysgm0SuF1dggB
	 PKtcsHVn9IH8yrVcWOxtINLLSHwkY3MjD9/dsAsEYq0b7loK1AkNXrHcTaIEDrqIR+
	 O7lvclSv9wYYoljm3SbIPJj4FOYfn/e276vnIZKCelJhKUJwm4YcSCZ3LJGXfDi5An
	 HIWJ6/ZQW69qg==
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
Subject: [PATCH v4 04/15] device property: Introduce device_for_each_child_node_scoped()
Date: Sat, 17 Feb 2024 16:42:38 +0000
Message-ID: <20240217164249.921878-5-jic23@kernel.org>
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

Similar to recently propose for_each_child_of_node_scoped() this
new version of the loop macro instantiates a new local
struct fwnode_handle * that uses the __free(fwnode_handle) auto
cleanup handling so that if a reference to a node is held on early
exit from the loop the reference will be released. If the loop
runs to completion, the child pointer will be NULL and no action will
be taken.

The reason this is useful is that it removes the need for
fwnode_handle_put() on early loop exits.  If there is a need
to retain the reference, then return_ptr(child) or no_free_ptr(child)
may be used to safely disable the auto cleanup.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v4: Include the alignement changes that were in patch 15 of v3 with
    a tweak as I missed the first line. Thanks Andy!

 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 9e67c3c4df6e..eefd662a2f9d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -182,6 +182,11 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))
 
+#define device_for_each_child_node_scoped(dev, child)			\
+	for (struct fwnode_handle *child __free(fwnode_handle) =	\
+		device_get_next_child_node(dev, NULL);			\
+	     child; child = device_get_next_child_node(dev, child))
+
 struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 						  const char *childname);
 struct fwnode_handle *device_get_named_child_node(const struct device *dev,
-- 
2.43.2


