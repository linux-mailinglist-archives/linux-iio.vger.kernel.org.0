Return-Path: <linux-iio+bounces-15693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B8AA38629
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292731768E6
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3965D224890;
	Mon, 17 Feb 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2vKJwec"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1822371E
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801922; cv=none; b=aIpKUwEWstjENN3FMRhpSPuw1mbTR5WX5MN0MIL6zPLPM4gIVS62SMp5mkTnO8e1RyE0sSUOWbhDN0+X79DmyFVbGCx0etWoBl2uQQytmCiFg6mPIKmpJYELTwtvX1/dXzyYOW93n3rOrYMGEAd8ls43QS+eBfDnDSygNE0jObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801922; c=relaxed/simple;
	bh=KOYPDKRYsrEDbpMkEzjB16ST2Jtl17WqIPkizlIUV58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCTioXJw2v90R47gkaxvMRJ6GtXSprNuU5ezJ4rqY7qz6xVgILyWkilr6inBdjgFSVbbZVm4vt/UhuyT880dTNRhrE7VtZ+PWEciUsb+tLG0Hjx2mcc2kSM5lW7xNKQf9G9SogOIyOQNMkrKTYhBTk2i395oOhXU+zGc9eYLUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2vKJwec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2674C4CED1;
	Mon, 17 Feb 2025 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801921;
	bh=KOYPDKRYsrEDbpMkEzjB16ST2Jtl17WqIPkizlIUV58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2vKJwec4HmfOXr/4tt5eGonVa7KhsgQTfnAq9g9AqnS8r6DqEEgDGiETmbXBwslk
	 m4k05eXeU5l9D4X5bOyQJW4/jThUSeTXJMA7Akx6pABNL2W78NAGWH1Of3AnxNYDij
	 L7HsoemCYhl3Ptywq4o61yE3luCMrXJTFARUJyNeVScC4QTdDvVsPYLE8i0YOAhwRP
	 i8MouNKWPTUcSmOBtaYhavZvt2iS6iK+aNeKLXzcnlUTyt5Pg8UBszPsskgdngsbzN
	 8gUrX/7kUcgQH44345gRfLF/N1JMSCbdrO1If4kOBLHZUiORTFQZnYqopNmtTxzhgE
	 RacTuA9oUL2+w==
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
Subject: [PATCH 20/29] iio: adc: ad_sigma_delta: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:20 +0000
Message-ID: <20250217141630.897334-21-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

This is a complex function with a lot more than the release of direct
mode to unwind on error. As such no attempt made to factor out
the inner code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 10e635fc4fa4..5907c35b98e5 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -386,9 +386,8 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	unsigned int data_reg;
 	int ret = 0;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ad_sigma_delta_set_channel(sigma_delta, chan->address);
 
@@ -431,7 +430,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	sigma_delta->keep_cs_asserted = false;
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	if (ret)
 		return ret;
-- 
2.48.1


