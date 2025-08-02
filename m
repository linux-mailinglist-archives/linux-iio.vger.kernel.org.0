Return-Path: <linux-iio+bounces-22202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236F0B18F6F
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82FEAA1B8A
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE9242D9C;
	Sat,  2 Aug 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmwfvItg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25815ADB4
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153122; cv=none; b=Cv9TNnH3R5lxY/HSNjknd6Z17IsusX7QrwykxavQG+sdU8+kC2tKnVqOZ1teT/9+S8aH0QD57FD7YmJH3ILaopSlZTbCUB+yjt7pRaGTZC/MfYKutigsYzjre4PXos7OXW+7CiKqhhrPRrQKkCMJy3zIcrYQdNu0nPOvLnQ5Un8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153122; c=relaxed/simple;
	bh=EXG7tm78JHe5vJ4+6H2faS0UQA5uruDXPnLmTyoDA7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8vTuhVNJSgsSkGn8EnXnswRknh54bhUJbhchpW+aCFtiTzBY4Oamk1KNBAvZDaEc6Nu3A0szV1452ZUQk/hsVnW7nbEnJbHExmjhkxtUIhNLITPl0czhIs8pTWZNUaHEIxxiBVbSYv39dfLf2H3cxfLQ8Ruyn8lXbwpW+uRwXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmwfvItg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D738C4CEF8;
	Sat,  2 Aug 2025 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153121;
	bh=EXG7tm78JHe5vJ4+6H2faS0UQA5uruDXPnLmTyoDA7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmwfvItgerlEhAq/c3K4Y3OSFxiZ8HeD5OWhDsW2mzdJ6BjdhpgauSSlzBbphRdGB
	 bRYCP1KEHKY4QZ+74LberGX0GYkKYkSJ2tB76mRqzgAKXtp9blasOuatfz6uMc798+
	 x+3pvqYlZMHipZyri0YdouYadeEw23pUuHM9CO/iFwLgFaSssGm2/zDGpH5DKLF8ij
	 rALlCbi8aBwFdZxyz7evISD2aU0IoVT9IGzqEdIwNN/NpGcxnkxQTv3SeDkkVqfmdU
	 eHCnCeoK19mooxq4kvukQTx8wqS4pyES0vEOLeBf11LVPTSKLCrmCI0FXlq908uPf4
	 4mILxz2rRWmFA==
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
Subject: [PATCH 04/16] iio: light: vcnl4035: Use a structure to make buffer arrangement explicit.
Date: Sat,  2 Aug 2025 17:44:24 +0100
Message-ID: <20250802164436.515988-5-jic23@kernel.org>
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

Using a structure to arrange the data to be passed to
iio_push_to_buffers_with_timestamp() makes the placement and padding
explicit, removing the need for comments to explain what is going on.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/vcnl4035.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 79ec41b60530..dca229e74725 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -103,7 +103,10 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4035_data *data = iio_priv(indio_dev);
 	/* Ensure naturally aligned timestamp */
-	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
+	struct {
+		u16 chan;
+		aligned_s64 ts;
+	} scan;
 	int val;
 	int ret;
 
@@ -113,8 +116,8 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 			"Trigger consumer can't read from sensor.\n");
 		goto fail_read;
 	}
-	*((u16 *)buffer) = val;
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+	scan.chan = val;
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					iio_get_time_ns(indio_dev));
 
 fail_read:
-- 
2.50.1


