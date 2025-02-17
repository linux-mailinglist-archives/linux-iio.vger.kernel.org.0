Return-Path: <linux-iio+bounces-15691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D2A38627
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586CE176482
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38752225A26;
	Mon, 17 Feb 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaFmu+Dk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6588225A22
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801911; cv=none; b=GZL02DPTBit3bAFz5ChSqjbV4skOnl4/uflXyT0fzl67HAJMvGlhTELhT0R1Pzg3Kakj8ySgMZIbx2dcDnraQ7Mv4+9C1m5a9p4LgRBxOTFQucBI7oMsRBFOgSHVVJ6Sm3SqD6sOuxznK6VWbhTLE29FLeb1SkpgDi3XN/UzWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801911; c=relaxed/simple;
	bh=qVt7yFX4ikdgAPjJF71v/IKwAVCoRTk7Eusc1RojQtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHuE4noY8SaXsb9I56ciRwxKjW9HF+BwY//o28IqL1IZT3amVqO9FIxsyZtRqL4wwUX+P+z1ppJ0QVT1WXAnxTc1zK5ZmuEQzQJeiaxJiNliyJP9An19qbyrv+1vwuCOFL913lKoSo8JY/EkBJqTwcdG7BfHozxIN7MU7KZrSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaFmu+Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EEEC4CED1;
	Mon, 17 Feb 2025 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801910;
	bh=qVt7yFX4ikdgAPjJF71v/IKwAVCoRTk7Eusc1RojQtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GaFmu+DkwyN0p53hA9lVps3W96r2Bmbgaxkk+1zTF1TfX5EoGiJs/1OlM4H3+hJh8
	 2PniqYeJ32r12BK3ElEIXi7vADPwzWiGHfym8/5glD7HAVeV4wUgCXcLLro65nv2nl
	 MaKa7vWe7pPjUbxJeb5BePByVPN8bat2JJvgOBaZsZIXhvhjJ2gDpp1Qp0r8KcAxQb
	 MmCn38HROzZaaR60AKdv10sQ2b+mmzf8yWWejfk3MD8FI+NYwrpHl9s68EOaG0EUdt
	 5uwK0psuH/wUhQWz4w5xumsFSOcvnaQPR4P6vxdG+3RfN3yqSgeV30hi6pUvaqr0Gh
	 XuSE50gQ+Qvcw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 18/29] iio: adc: ad7793: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:18 +0000
Message-ID: <20250217141630.897334-19-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7793.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 861a3e44e5ad..ccf18ce48e34 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -517,13 +517,12 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = __ad7793_write_raw(indio_dev, chan, val, val2, mask);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
-- 
2.48.1


