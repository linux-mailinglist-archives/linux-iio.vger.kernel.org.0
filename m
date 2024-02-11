Return-Path: <linux-iio+bounces-2425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42748850B1F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16E028428E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455EE5D8E5;
	Sun, 11 Feb 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ9ZBq3t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBC5D75A;
	Sun, 11 Feb 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679606; cv=none; b=ZpckvCRzD45nGy/12Pj4sTDyWstodrCWeG2cfsGEtz4ryvfEt9ZjA+ZbeNOhoZBbX57y16R+Qt2cZNZMVeWDxaeBTPOPns5PU0/u1Dhdn1m9t7mQ+I1P9A35wlmvl9lpqIQeECNiOS+SiEW5gwBQYCUuuZD63LMQXAn4nuqVBR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679606; c=relaxed/simple;
	bh=wXOs3T8wmJwJW6VPW95ZQtHc243uZ8WdCx9gNnNNTfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLXUbQ1NlgRbmejWS26WWk/2QEDWeqkuy2bITfrN0zcK3j/GSNetE66yTPns1ZsmHFFPdOqj02Un9vBSaxzJ+fE8ivnYRcmbvLIcjHo0q1zliRkp0+NjqGb0kHQgn5lgsxFYRH+xMCiEVtqcS6tp4HC0pbOp2mGGHamjKqNqv7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ9ZBq3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52291C433F1;
	Sun, 11 Feb 2024 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707679605;
	bh=wXOs3T8wmJwJW6VPW95ZQtHc243uZ8WdCx9gNnNNTfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQ9ZBq3twnJDyINamrLJDC3gL+Btz+tRWr5WTd/QpkdX5d0WDuwCj7H1aAfkVtm29
	 UFwsvYa0bJzZiBtlQZ70PxW7id76knQfLZbwWKkl+43Ww+KKDJTm21GJwicdDmz6JF
	 YCTIO3+FW/jrOdxEysD0fzMsBn/SG/GtoLQc5eGgdBV7UC7jsSFKegNCQ4EBMLMrfO
	 5NfCQ0U6f9YTkGrztCMRB6SpUF3k244JqEY6mOimdzQ9ZSOcekR9ftTnw5vk+7S2rG
	 KPmUKsQStuWfrHYpPdCNGMsTdEI2aiUrMr2FeunWQTGS8m1+DSTYmR3btduSODENMm
	 NRcysse9g78Pw==
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
Subject: [PATCH v2 03/14] device property: Introduce device_for_each_child_node_scoped()
Date: Sun, 11 Feb 2024 19:25:29 +0000
Message-ID: <20240211192540.340682-4-jic23@kernel.org>
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
 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index bcda028f1a33..e76b8c6646bd 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -182,6 +182,11 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))
 
+#define device_for_each_child_node_scoped(dev, child)\
+	for (struct fwnode_handle *child __free(fwnode_handle) = \
+	     device_get_next_child_node(dev, NULL); child; \
+	     child = device_get_next_child_node(dev, child))
+
 struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 						  const char *childname);
 struct fwnode_handle *device_get_named_child_node(const struct device *dev,
-- 
2.43.1


