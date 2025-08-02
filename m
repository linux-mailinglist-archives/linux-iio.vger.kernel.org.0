Return-Path: <linux-iio+bounces-22199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A8EB18F6C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FFD17EEA9
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058D25178F;
	Sat,  2 Aug 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D42EJEMd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DE24DCF6
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153105; cv=none; b=kLFIkobzwbiFAxbc2YCe8Lbgv4f3QhpaNd4e2yz9Xte/ByXHSViUg+Mk0+r/QrjmlDgaePzO+4srk4BQ2SSMvM18wQ5Uk/1L08zIl5wYlbgavTjiQ0w+Fc4T3MrsThZ9bdvF8aSmUudjbonrdtOJK/d4ATPflDHNdbst6hgPf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153105; c=relaxed/simple;
	bh=zqRaiokTXvBcggMngjWhCBSwYdLh6clUFlmFjAiidnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRKQb9aw/KObl0wRB3OeFu8O8E2/jggJzDyMXBPE2+VNndZ5rcK1B+WgeUZjTKG9EjWwN9pHTnZqNH5w9JSInvffYwPKxrnb8KZ9nrLclRM/zscKLjlDwNR/LKaP2C1jJLm/kICjDPxOWKpwpwggzkplMiNaIc9R23e1EWO3f/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D42EJEMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA77C4CEEF;
	Sat,  2 Aug 2025 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153104;
	bh=zqRaiokTXvBcggMngjWhCBSwYdLh6clUFlmFjAiidnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D42EJEMdu23uRjnn1nosUIzHsminTWWF5HLWnd7ZVS8J7BmoFLU5Y/2lxzSxVuCOI
	 MonYbE+1zfZUVlkmeuj1ZoU9P9K0/MXC+NfcQA4aupb1U4BjRJCPTF3D32u4fs6ITq
	 CKlvXxHZVbhXBhnLALelupapXlvb5h4e9DBqBpQ8mZvSH5aJwHKQgZezcdzHlPX4sc
	 Qc1IizMUOeKdljwI2aamj938AgTbrXdnkDPYjEOgfx4Eno/I0j3zTSpzR87Zc03hmw
	 7ESJPCOsIqh/NeW+9lSpDsIxPz2PGf95jv/dfPFOHJ4LokN3GbfiVLPL/z8J43NcuL
	 khvG5Ew3D66uQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Christian Eggers <ChristianEggersceggers@arri.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/16] iio: light: as73211: Ensure buffer holes are zeroed
Date: Sat,  2 Aug 2025 17:44:21 +0100
Message-ID: <20250802164436.515988-2-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given that the buffer is copied to a kfifo that ultimately user space
can read, ensure we zero it.

Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Christian Eggers <Christian Eggers <ceggers@arri.de>
---
 drivers/iio/light/as73211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 68f60dc3c79d..32719f584c47 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -639,7 +639,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct {
 		__le16 chan[4];
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);
-- 
2.50.1


