Return-Path: <linux-iio+bounces-13515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB859F2552
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8A0163C8E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0B01B6D0E;
	Sun, 15 Dec 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebA3B3Gu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7E13C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287397; cv=none; b=dsSanyNBVMgv6y0XzeOAy1XQ/qIx9gQHsSm5/fIHbkRtMfFJLq4Ut1U2C1B2gSbCahXgLZGC8getJ/6Ua9ddzLt8kXhanYBX2Bndvx/m2dGzQqcEEfhwE5wkmOJpd6QxBi3q4kox0HFBbEh5KdSPz4rEG4Zy1cG4s0Z3Z9sOuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287397; c=relaxed/simple;
	bh=vZ7RtmPjO+69JDsB3tMd56qNwKSELBqWtBa7mASr2BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImG8bvm+zNKMZOjhBc2BwuhluqsNHh8yt2tBOJ/eLd83P7Tv8V53yulNpDBYZmjkkD+iDyLzPCH+y8vvoSbyN8L6/vMC7kbv3Ew0I4qhL4xavG1NOEVVDNbi5WMi+qmV+TzbjTntMXve4jlzp2qVW59k/qQpZNiWV6vjeZMMTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebA3B3Gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C55C4CED3;
	Sun, 15 Dec 2024 18:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287396;
	bh=vZ7RtmPjO+69JDsB3tMd56qNwKSELBqWtBa7mASr2BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebA3B3Gutd9XqPnZVWtnTqiLkxxoViMrq2iBRSh3Ps8L2oyKqTLOwMVPe75NfAwHe
	 dNqh8B1B0i3WgHZw74OOie1Ovri49cdlMWKCjG4om+kxga8HSgZPgDfKUNPGT5BHfp
	 p/Lt/1vOFfngjzMgK069dZoW10oR6eOVTPxD/iuDfKMXINCHixSvSJbwqEL2CIyXns
	 d2xfd7y4v6lEFMrvdEKT//WfFdtAUOTR5WbaZI8XjDVsbg2lQi2MB+V+++kfiivdys
	 3w0BqVTHPbYSyIsNGq/PsR0n3YEDFYiD6x4tzqx8doee0MsQboe1yoJuXMWSw0AekM
	 P5XCW3nTfQcig==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/20] iio: humidity: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:29:01 +0000
Message-ID: <20241215182912.481706-11-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use this new type to both slightly simplify the code and avoid
confusing static analysis tools. Mostly this series is about consistency
to avoid this code pattern getting copied into more drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/humidity/am2315.c  | 2 +-
 drivers/iio/humidity/hdc100x.c | 2 +-
 drivers/iio/humidity/hts221.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 6b0aa3a3f025..2323974b805c 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -35,7 +35,7 @@ struct am2315_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		s16 chans[2];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 9b355380c9bf..a303f704b7ed 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -44,7 +44,7 @@ struct hdc100x_data {
 	/* Ensure natural alignment of timestamp */
 	struct {
 		__be16 channels[2];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index 721359e226cb..0215f11fc35e 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -40,7 +40,7 @@ struct hts221_hw {
 	/* Ensure natural alignment of timestamp */
 	struct {
 		__le16 channels[2];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
-- 
2.47.1


