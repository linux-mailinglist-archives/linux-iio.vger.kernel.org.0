Return-Path: <linux-iio+bounces-18051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B62A8718F
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F5A7A823A
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4695719E7D0;
	Sun, 13 Apr 2025 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJnUHSOe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082AA2AD3E
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540513; cv=none; b=DjOdFHeeroJhe6nlO5JJ2kS+XAMBJyK+lqgnmEMmY0zcvmRJm0VzaewnYiX48P46vm9IaAD8PdW+iVc0iQ/+u0G3o4RrXpvBEuTRwe4OWMQ4AeeSrYcAJ/GQB/B+IWAin6ZD955YrWq4HCNthcIrD3ljKwQMjsLi5Cl29v6wLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540513; c=relaxed/simple;
	bh=SgZyGUJuQEdf1UndClsPKF0Kjv02T+l2y0oSN6uEi4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxG5t1eROE776gUZDK5Cl2lM7eZxq5Le7HI2OaGVxbBtjB2O0aOTYIfssMZQcUXHJ3cuPtrFCLNOBti6XAAfQpSY8AWyVsvZDHBqdAvd+U1pX8VA+k6EXjsZ8Jnjl8HZTszTJCyhvGp74X458Vx0Lla5Vg14l8y0nIVZ9SlTerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJnUHSOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89A2C4CEEB;
	Sun, 13 Apr 2025 10:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540512;
	bh=SgZyGUJuQEdf1UndClsPKF0Kjv02T+l2y0oSN6uEi4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJnUHSOemdMSuHVyDjG0wROniuR9FfU6j0WZO4BKScwiJiwTGKRxSoy0drnMHRzAM
	 /rUaYQtjlpplty3iOFz+89DfbYfik00zLMo+S9pGDjaEIYfNMwbg1zIhj/fzxS5hlt
	 0Xpa1ztAOkTdNpB20D7zNUDSY5uCI6SMMj6M/inqoZ9zPZCeKCShykGkiqpXpZAKoG
	 zLGOJ847q4m0Rzi4iGnb5yW+kbT+VVPIyK0TIPB9aGO5fkEBwOCLwZoifynmzkEwey
	 /zHdEbbpj65rw8hrydoaBio0f0dk2wKDbeKbWJp+xJ0K2/5rJQkNUO9vi09xpK2AWJ
	 dAwbiHlooA3cA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 07/20] iio: dummy: Switch to iio_push_to_buffers_with_ts() and provide size of storage
Date: Sun, 13 Apr 2025 11:34:30 +0100
Message-ID: <20250413103443.2420727-8-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Provide the storage size so that the helper can sanity check that it
is large enough for the configured channels.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v3: Updates due to change in previous patch.
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index d0a7343e1b35..e35e0596cbfb 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -83,8 +83,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	iio_for_each_active_channel(indio_dev, j)
 		scan->data[i++] = fakedata[j];
 
-	iio_push_to_buffers_with_timestamp(indio_dev, scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(*scan),
+				    iio_get_time_ns(indio_dev));
 
 	kfree(scan);
 done:
-- 
2.49.0


