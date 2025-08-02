Return-Path: <linux-iio+bounces-22201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8EAB18F6E
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14F6189D446
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F05919882B;
	Sat,  2 Aug 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyN1Mp4f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B20256D
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153116; cv=none; b=bEH5yf0EGXuT/NQYwa/5Qy7I66yebr2mRws3OiwrmDUSMTz/i8KuIi0l5yWeN4WkfarDd23MD+0r2JpysTSLnWingH5leIOs+cgVtM6rCnf19q7vlJklCGMrSLvf1tnzB2Az5tV4UZkaQemN39CmRjQWUkewGsUIH62JxBHsu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153116; c=relaxed/simple;
	bh=4BLBrbMR5xvY/HNTVls7nYb4A0N49/xqgX/Yp/Ft2js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbyAdgC9FxplQ/lMO9o1b+OaK/Po05ih5heYUqTiCfqn1is9fcZyZDp5i6DvvI7VvC95YXWQI4i0KrHhZgLS9FdIFm4zOOg55XkNSvrABzn8XHumSYtTZ3Ef7/TaDklO33EfL84R0L7dY7QqdAXmuSWK8IoWzC2Xkja1W3x2oRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyN1Mp4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D26EC4CEEF;
	Sat,  2 Aug 2025 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153115;
	bh=4BLBrbMR5xvY/HNTVls7nYb4A0N49/xqgX/Yp/Ft2js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyN1Mp4fnw/RqxQuiMDJbcaWzX0dUsHb8zfz/94uFwBkXv6cYQAdHLS1GT0sCRbCn
	 chXscpbP3kLF1yMJ0PRCN0SMSDlPRqVhbYcBnO68jJq1XWdOYd9zb7//Ik7N3VMtis
	 Njy3wSt40o50UhSFb5b5azGsRYyF1xnuGb1Y95Qo1EjDJM5VfDugzEmI68oB1i5ifk
	 3VWLIK1wIZBzcwj/hqjzStyTyYjFXvVWqD8ZbrxtdYKE3kf48MxmOxg8qdSPD8oe9F
	 FntAmf1LNXgHWdY6VF3cJmn7VuXOhLnqASMk3lY57wefC3+uUKKuJYIYMDq0Lx5z7a
	 jhm1CZhY4lqNg==
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
Subject: [PATCH 03/16] iio: light: as73211: Use iio_push_to_buffers_with_ts() to allow source size runtime check
Date: Sat,  2 Aug 2025 17:44:23 +0100
Message-ID: <20250802164436.515988-4-jic23@kernel.org>
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

Given the helper routine requires additional aligned space for the
timestamp, it is easy to get bugs.  The new helper takes a size
parameter to sanity check against the space actually used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/as73211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 32719f584c47..c3cfca3653a4 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -698,7 +698,8 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 		}
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	mutex_unlock(&data->mutex);
-- 
2.50.1


