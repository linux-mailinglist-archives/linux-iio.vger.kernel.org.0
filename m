Return-Path: <linux-iio+bounces-14998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55ACA27C56
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B8418863CF
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FAC20013E;
	Tue,  4 Feb 2025 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKcFW5Fe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEFE14B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699402; cv=none; b=TO1hw9iUBKCDnBpx3zZKA4kCV16P2t8A59rMEQr89Cm23J6OvEW9rCQrDvTl4yNG90HlNLvcPWVZJbB6vBxLxFP3aBmJWWJU1f5af6z57J9E7HI5A7rFJKw7/Vh8UQ3TUFJGFfYxNBKeZkfCKtcMuKk5ShGTqT/Iee8xk4kN12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699402; c=relaxed/simple;
	bh=LFvC6+7XlIWvd3lag3thDqoCGYYvwluNlCYt7ei1jUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJMweDspZNy2PoQ/qBphM7n7yXtbqJqsu/uyisG8lhOMfdCmLH4sIFiKb7wGQt4E26wEUe0icdljCpcmNyoa1WgBcUgL6kAhO8PoDkkoMiv+qH6VyHsYEQfNuzh01poi/X5G+3lcBbnfVs+MmEXpw6NPA8vZNnJumC5grVYYuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKcFW5Fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F911C4CEDF;
	Tue,  4 Feb 2025 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699402;
	bh=LFvC6+7XlIWvd3lag3thDqoCGYYvwluNlCYt7ei1jUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKcFW5Fe7GxpqSGjrinpD9aGnzvkpsnYN85eBXC5BUPEoXjjSJyOpC8hwRecECX89
	 qNJqcaRXU4M2N6r3fZze82IRHMM16ex1p4fwrgVQanMQ1KoNTAivXnHMzzv1NxhKWM
	 alHEkQw4FH6k4S43owA35P5Fj1xf/bUihYQMHXkZQmdd54pKqX2wm8YLs28gKlWnZA
	 aaAsQgCrnbyh+5Dw+CNf8zFzqN//HgbiztG15LgCjy2FF0o07oAvz2SnfyIu5h8zqS
	 4OknkQQC5Jt+k54sMB7XMNmBH5M0IzlA8pIbeGTCqm3uVS/D7G8xBV/h1jol1pbh+t
	 IYFeb009D+KrA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/27] iio: temperature: tmp006: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:26 +0000
Message-ID: <20250204200250.636721-5-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/temperature/tmp006.c | 33 ++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 1998047a1f24..b5c94b7492f5 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -85,19 +85,25 @@ static int tmp006_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (channel->type == IIO_VOLTAGE) {
 			/* LSB is 156.25 nV */
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-				ret = tmp006_read_measurement(data, TMP006_VOBJECT);
-				if (ret < 0)
-					return ret;
-			}
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+
+			ret = tmp006_read_measurement(data, TMP006_VOBJECT);
+			iio_device_release_direct(indio_dev);
+			if (ret < 0)
+				return ret;
+
 			*val = sign_extend32(ret, 15);
 		} else if (channel->type == IIO_TEMP) {
 			/* LSB is 0.03125 degrees Celsius */
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-				ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
-				if (ret < 0)
-					return ret;
-			}
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+
+			ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
+			iio_device_release_direct(indio_dev);
+			if (ret < 0)
+				return ret;
+
 			*val = sign_extend32(ret, 15) >> TMP006_TAMBIENT_SHIFT;
 		} else {
 			break;
@@ -142,9 +148,8 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
 	for (i = 0; i < ARRAY_SIZE(tmp006_freqs); i++)
 		if ((val == tmp006_freqs[i][0]) &&
 		    (val2 == tmp006_freqs[i][1])) {
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
-				return ret;
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
 
 			data->config &= ~TMP006_CONFIG_CR_MASK;
 			data->config |= i << TMP006_CONFIG_CR_SHIFT;
@@ -153,7 +158,7 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
 							   TMP006_CONFIG,
 							   data->config);
 
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 	return -EINVAL;
-- 
2.48.1


