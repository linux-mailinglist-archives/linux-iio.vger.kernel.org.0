Return-Path: <linux-iio+bounces-17463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FE5A7659E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF3516A3CB
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A31E51F1;
	Mon, 31 Mar 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKO4ryLQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8013B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423423; cv=none; b=b9tvWQ+JcN+xiqUMMK20ww4DEUvzrJRb5TVCGSPAAXLaT+ny4dA3BlyySnTUC83kIZk9tObdv5TU1Qakblflm9JYjyLMX0LnaRWSWFFCFHQIrndT4lFhT1YkEJ3nw3/4sFdGCxSYzbfXHT+gBfNC4auhcMtGd2r7Qr3nBeTI/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423423; c=relaxed/simple;
	bh=Y42zDixZT89OhcJYjVbeP9CphLImDf1gNHjVV/eU0pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5btV1oXYXUPzJTQPqvADffGGSijpaYFeMNrBUu4jg4yb4JZnHW5dhRcNOFNigysFGAM2epeUMmOZSbaBc2j9DLdFJFMzfkQ74k0vjrf9YbIYmZ+cFGpmWlsEBb11g252H1dIEOXHhYxAIn8sWPIObdsbKPZMWwcwLC6aR5430s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKO4ryLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB42C4CEE5;
	Mon, 31 Mar 2025 12:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423423;
	bh=Y42zDixZT89OhcJYjVbeP9CphLImDf1gNHjVV/eU0pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKO4ryLQBlRRmETc1s1+4mkf3+aXIpYUYPgl/jivDj+iT4PYxDzoLB42ZP+eDnulB
	 TCVMp8fuXbuq3SFtKwL1BA5lJfLuLpqewn1ULJOModkr01rgzn7fiF7lKqUMivINMW
	 7YljFFoGni4TKF4I0PMhJ8WzpLSac0hK4Pobl6r7Yv1BHaHXLlvQcL4k4B0oPDmaIf
	 7Q11XIGnIPayVqEtrQlP/3yjnQ4Yotgbf+zVcRTQ3lOVb60Z3hWgzuTBeo6/+C6kO5
	 +bIQ8w/Bky6vxUTU2DH+6PeAQSRacITEPnf+LPB3aptt2EducpWKf1NsN4G7+mlRFY
	 BO+gXFnII1j7Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 33/37] iio: proximity: sx9500: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:13 +0100
Message-ID: <20250331121317.1694135-34-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
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
 drivers/iio/proximity/sx9500.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index c4e94d0fb163..b5e2855975ee 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -387,11 +387,10 @@ static int sx9500_read_raw(struct iio_dev *indio_dev,
 	case IIO_PROXIMITY:
 		switch (mask) {
 		case IIO_CHAN_INFO_RAW:
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
-				return ret;
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
 			ret = sx9500_read_proximity(data, chan, val);
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		case IIO_CHAN_INFO_SAMP_FREQ:
 			return sx9500_read_samp_freq(data, val, val2);
-- 
2.48.1


