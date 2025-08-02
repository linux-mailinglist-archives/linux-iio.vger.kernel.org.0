Return-Path: <linux-iio+bounces-22212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F84B18F79
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55243AA1B76
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E72524DCFD;
	Sat,  2 Aug 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJhIzVeV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72D248F5C
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153185; cv=none; b=pBzrSStfsRL1WZWztLatgJuMuiQvhGVQFTn5Y0U9Nrm3G9ZT/TgrJG+nJkq2yzvNaS7/O7o8iv2Qg0urXkQOugRF++YO2sOfhF2n7extL6S8URJIqmOhEdVh89eCmvduscUcovJfWLVraWhFMW7EzSg8jQk0GK3YqWv5puOKwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153185; c=relaxed/simple;
	bh=kBkF3Z0oASR14hcL5v/V/cluL6Zb2HtMBsGtW458MCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVMR481qb4H0RDZmPDLO6TiPxIxzFr7LK9m4wu1HM6efj6qQznSQG+6Oa3cIXw/T0DviXAQ+xodW5ualjvfJSc+Hr1IvoYFNKuO7B0PdG3nGX70Pinig7Fi5ENJ0OciGECFm4H1AEnNmG1WRZQMfzffbZ0l9/2SrvfsvNkWZ5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJhIzVeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EED1C4CEEF;
	Sat,  2 Aug 2025 16:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153184;
	bh=kBkF3Z0oASR14hcL5v/V/cluL6Zb2HtMBsGtW458MCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJhIzVeVvWZS8iWWoxzF3RTVfK9c+nVvkf/Z6hQeOM2Y5+NPA/8tJe1DqsBmoVuSL
	 Udc6OsOx6ZGnyqjl+wRBpf/XtIvx4M8/AhNpRMUJ+DAhWHEKCEyFkuzMde/Spl5m2M
	 FZ6kG9y7FAH4rqgSuiUzAuCLC42R9ImsNfHP8LsSe8GOWshcPkjec8eg9HLL8G8WfG
	 v8AyGbh5s56PFCoOAjh8pF1tEPtC7Ks5onceY8sHX3jJUVvZgH01YMsystcIPpBDTQ
	 HW3dYo6li/Mn3nzVO+pFjfRW2Pia6xP15v1DILkwkr+2/eiCsSWxE53Qh5TSi2MYk/
	 nTT5Uc1dqhPHA==
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
Subject: [PATCH 14/16] iio: light: vcnl4000: Use a structure to make buffer arrangement explicit.
Date: Sat,  2 Aug 2025 17:44:34 +0100
Message-ID: <20250802164436.515988-15-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Removes the need for comments to describe the buffer passed to
iio_push_to_buffers_with_timestamp().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Astrid Rost <astrid.rost@axis.com>
Cc: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 90e7d4421abf..eccf690eae8c 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1662,7 +1662,10 @@ static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
-	u16 buffer[8] __aligned(8) = {0}; /* 1x16-bit + naturally aligned ts */
+	struct {
+		u16 chan;
+		aligned_s64 ts;
+	} scan = { };
 	bool data_read = false;
 	unsigned long isr;
 	int val = 0;
@@ -1682,7 +1685,7 @@ static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
 			if (ret < 0)
 				goto end;
 
-			buffer[0] = val;
+			scan.chan = val;
 			data_read = true;
 		}
 	}
@@ -1695,7 +1698,7 @@ static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
 	if (!data_read)
 		goto end;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 
 end:
-- 
2.50.1


