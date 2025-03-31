Return-Path: <linux-iio+bounces-17434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D46A76578
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6711887D57
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30A1E32A0;
	Mon, 31 Mar 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCoXOTL5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84C1D89FD
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423240; cv=none; b=FoCrpgfbfDDJil6A7hn1r3TLCqPehmvJHx9NjUt5Ke9afv8wgSo0CcrkFVwQlCJlUPuZdcW5FhQ4gGQjmyAqaQhq6sLggXHErUse/WS0XTgFGq3JpL8dwl28FT802T4gzxabEa/g9uug5QAgXpNqgcNnSplS0MuA+w9Nn6W3z4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423240; c=relaxed/simple;
	bh=S+UO7pDjMSe60bELtyH22FxPeOII+K59wEySKfowcMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onHWRLm9eCS5V2hz6V5vBb4NRpoEx+dN2DeDiO4pyvlJ0hYsaK4bnBNf++r9/cET8VU7fa2mdtbiAVETetWJJiw2hQhgkSwC3479dOv4F/zlflVWbQlwPPnBQfwaiMjJMrB7kATE2PQOaj3KgvGtlc+kBcRRNBXVHcsdtWmF/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCoXOTL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136CBC4CEE3;
	Mon, 31 Mar 2025 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423240;
	bh=S+UO7pDjMSe60bELtyH22FxPeOII+K59wEySKfowcMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCoXOTL5f3tqKESGwIARSAD5Q/XXAKECLg6NdfZKfivWZ1A9RjkJlTj0f0ZU/Soyh
	 itXPyl5mTRy7YgUCasuqcXlkM7t/tBRMF3r0Y1v6F0ckSmGOgBhDa7+klnJxWEey1+
	 OGH0ZSfEyjZORrALl33GOcn9sin0TvKhmuRDNweidmnO8szlIS/d4mGR+xJJB/rp9o
	 eB2tesgy+wIfPgVvLKc3OX8yR1jCUZzigZ85qQ8FXW7ZkuPpUcGY3wULCev9CYLThh
	 W1SmfQ9vpiUy8b0pwd+tN5zmvO3KgAtYSelUrvyQpzTTGo17YrsqLPxmidx86IZuXC
	 pEcbEinHtiOig==
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
Subject: [PATCH 04/37] iio: chemical: atlas-sensor: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:44 +0100
Message-ID: <20250331121317.1694135-5-jic23@kernel.org>
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
 drivers/iio/chemical/atlas-sensor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index baf93e5e3ca7..593b73ccbeb7 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -518,13 +518,12 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
 		case IIO_CONCENTRATION:
 		case IIO_ELECTRICALCONDUCTIVITY:
 		case IIO_VOLTAGE:
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
-				return ret;
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
 
 			ret = atlas_read_measurement(data, chan->address, &reg);
 
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			break;
 		default:
 			ret = -EINVAL;
-- 
2.48.1


