Return-Path: <linux-iio+bounces-22203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6573B18F70
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3BD189D43A
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3C242D9C;
	Sat,  2 Aug 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAO/ybQG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653615ADB4
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153128; cv=none; b=XiIuv2L7KL0GEuyjw8dC7x2lv6O3f/MRC/5UqtlNZsZ76n2CKkcIND5RjIQNTzFRFipNZ2bq0pymIru4sz0O6z+Ry/sqkqKGKrsER+Ppqd8uGQIee7FIWQLgTB0cMUzTBR+pS/1FgUkdI6hadhyeMRFatpDeF0tFHCJfJFxPJNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153128; c=relaxed/simple;
	bh=X5gzF0fa3Xzj9BdH3pXDR73TaDLFMB5++wu/MRg3pzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjpzBO5/yAi3C3k5UXfIzkcqUN9XzGJKmWcsX9RbmM4vSQlt1w1mLBgjGENEFLlw+/JxDPYVNgoNMLy5uGRVsGTJZLbcrwfSKTRUHanZBss01Vps4w95jesJGHc8WatR+KDBQVNgcZkY0BL2sOybkGMz9HPbJnGXtsFoHsAUbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAO/ybQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9188DC4CEEF;
	Sat,  2 Aug 2025 16:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153128;
	bh=X5gzF0fa3Xzj9BdH3pXDR73TaDLFMB5++wu/MRg3pzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SAO/ybQGNcigmpounHMCYnKi4u8/Cnrn5TtDRHLXerfUJoy73Lqzitp+dWt1fE9+j
	 Am8wLEmtJ58gq9J2eFu9DTxP7XQANt+DnDFwebcP2/uy/iZQR8M2V6K35z4BU9fIbD
	 Ao4bY0OjH/2bMPduoCEnQYAw79AVxf3ix/+ZBoxdNYP7vhtuBNN852sPjKlMH+VEyZ
	 82JyQ+R+qwIuL8275LhqTzyMnEhR+6YJ/5y+pVB1a0EHaGrx35cQxKnD2Z5+n30m/t
	 0OIpZqLiLKiUEqWCZCO4Q760DUR4vKPLoEzZFTRmoCAuPZ/1hlhVqX22LyVPCmU1n6
	 SR+DJXq9lyKwg==
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
Subject: [PATCH 05/16] iio: light: vcnl4035: Use iio_push_to_buffers_with_ts() to allow runtime source buffer size check.
Date: Sat,  2 Aug 2025 17:44:25 +0100
Message-ID: <20250802164436.515988-6-jic23@kernel.org>
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

As the sizing of the source data has to include space for an aligned
timestamp it is a common source of bugs.  Using this new function that
takes the size of the provided buffer enables runtime checks for
possible bugs.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/vcnl4035.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index dca229e74725..2ebc1e9496f3 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -117,8 +117,8 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 		goto fail_read;
 	}
 	scan.chan = val;
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 fail_read:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.50.1


