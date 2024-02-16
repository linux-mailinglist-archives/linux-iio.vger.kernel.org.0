Return-Path: <linux-iio+bounces-2669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1FD85849F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B84A1F231FF
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C61E133401;
	Fri, 16 Feb 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saT03Gkt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165C3132C0F;
	Fri, 16 Feb 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106032; cv=none; b=bmDfebM8jAhQvvElPVmnN5str9Xnl2Hz97R7W+vzt3XYseEDKpaEA3hr+3GCrzgFJEgAhwcsvacrLjJZGXt+pVmiNnakXmVkpAgqeM4zCJ/lABzrqu0DKH/cCyyWp7Tz4EvoxZhqYZkQiPPc9EZK6S4OvpWM32Z5MhX8r2IyTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106032; c=relaxed/simple;
	bh=ifyuF7O6U49FsljCYijSHs8mI+SpSplxdf47Gah2dqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKNyMvmDmVO+dPYozl2YHgLFJAJ+tuS9zWHUCvptp3ytNRLCO6Pk5sWRmtpy/00kTf3kvEzIL7SdN6X+K7KxGdgxZfmeGVL8VH+0VntTODQhiYI7gzlqwNxZv4/x4Go8j4BgHXFWxw+wdv6tRDP1bwMQ28L4UezqOtBdonQKwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saT03Gkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB4FC43394;
	Fri, 16 Feb 2024 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106031;
	bh=ifyuF7O6U49FsljCYijSHs8mI+SpSplxdf47Gah2dqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=saT03Gkt2X9XfajdcPKa9TMr1M+Zunpgq9ljpGZ30O6G0zuGeCEHT1ZEnMviJ3EI3
	 6uaEwKv7VcbUb1T+Eisj18ME3ByBBPWSYZ3Rp9AfIe0L0y3PFTfgb7bvEkyz/TZaP+
	 CMxvtEziGjW51I0w4ctE3YJwf7jfjM72ezA/w9Iv0IQZ6RRM2ZZgviMKGc3+HTbSwn
	 f2XiZu9F4YBgeCTzeZoznyXzGp+DrXdv0yY+1aZorxHiM1hFW1QQbaqQMBi17BQdre
	 X6VBnSysE5xw8Uut8B4ldbJ3XjjXIZ3spNjFr+EtLN90jcb4/vJ3klMAzMXxdSiYON
	 8SaN8gOF03A1A==
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
Subject: [PATCH v3 12/15] iio: addac: ad74413r: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:18 +0000
Message-ID: <20240216175221.900565-13-jic23@kernel.org>
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

Switching to the _scoped() version removes the need for manual
calling of fwnode_handle_put() in the paths where the code
exits the loop early. In this case that's all in error paths.

The use of fwnode_for_each_available_child_node() here is assumed
to have been down to a false assumption that device_for_each_child_node()
doesn't check avaialble - so this transition to the scoped
device_for_each_child_node_scoped() is equivalent.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/addac/ad74413r.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 7af3e4b8fe3b..cd26a16dc0ff 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1255,21 +1255,15 @@ static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
 static int ad74413r_parse_channel_configs(struct iio_dev *indio_dev)
 {
 	struct ad74413r_state *st = iio_priv(indio_dev);
-	struct fwnode_handle *channel_node = NULL;
 	int ret;
 
-	fwnode_for_each_available_child_node(dev_fwnode(st->dev), channel_node) {
+	device_for_each_child_node_scoped(st->dev, channel_node) {
 		ret = ad74413r_parse_channel_config(indio_dev, channel_node);
 		if (ret)
-			goto put_channel_node;
+			return ret;
 	}
 
 	return 0;
-
-put_channel_node:
-	fwnode_handle_put(channel_node);
-
-	return ret;
 }
 
 static int ad74413r_setup_channels(struct iio_dev *indio_dev)
-- 
2.43.2


