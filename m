Return-Path: <linux-iio+bounces-25121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A239BE1802
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 07:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243593A8602
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 05:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E322A1D4;
	Thu, 16 Oct 2025 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcEPfYCQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B825226541;
	Thu, 16 Oct 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592045; cv=none; b=NlCz4OhlqrIDmhCSOsN2OODT3zaH9Pc50WdfAMFCgISRZ9/qqvMHx/42E6LIef7o2gtm932/Q/5Q+bBJTXtQyb7YTjwR+5AFFdYgERbJb6YSnyUlKI0seXIy5di8Xai08wzb5Kw2/1e0xhJsjssUhE+3iEFqfPTte+nGm/oTf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592045; c=relaxed/simple;
	bh=uG5to/T0U1UD96nleEjz0+yJxBXGU0jPV7BnWgLdI1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UrjQLUkMxEgc/9BKOYpqsEp4b5tQb4kM9skhKhux+9QMv359dws26YOwNPC3kjFLErefL3FADKFuOxIYSPxiHWK3wBjMpjxFagIVsRPuwW1e1mkbvQeh3MYvW4e4kynUjZwfJSJbeItPQsKzJLQytjiSRPTs7YbXVIGz1TwHUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcEPfYCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1968C4CEF1;
	Thu, 16 Oct 2025 05:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760592044;
	bh=uG5to/T0U1UD96nleEjz0+yJxBXGU0jPV7BnWgLdI1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XcEPfYCQsP3zIGcfoIKLEDl1bPbXrJ7QHiirUrV89kfUilvPC3sTnyOxBsZQ0mWct
	 WCQlqjadEpoG6rBYGuDn8fT156+YXd8jWltKmYmVFjJ8m70H9Faquwjih8G/47tiV8
	 U7h7OJo/Sa9DdAAU8LbGPwoSpSINjumQtfNPU8yahjqTjl1chJJh9VkB5sW9BDIN8V
	 qCTrdXZXKOr/EDWt5VrS7b6ykFjSmBzSog2W2txsu+WljQAxVbKebmBFxb3kM2xaeF
	 e2Vvg/s3NymMFh8eYIVR9lK1YbMdot26e7B67Zy8JRVBGMEgw+iHiN4Ohhno1UiWha
	 lKB2blPYk4r1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0BFCCD183;
	Thu, 16 Oct 2025 05:20:44 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 16 Oct 2025 07:20:38 +0200
Subject: [PATCH v4 1/2] iio: humditiy: hdc3020: fix units for temperature
 and humidity measurement
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-hdc3020-units-fix-v4-1-2d9e9f33c7b1@liebherr.com>
References: <20251016-hdc3020-units-fix-v4-0-2d9e9f33c7b1@liebherr.com>
In-Reply-To: <20251016-hdc3020-units-fix-v4-0-2d9e9f33c7b1@liebherr.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Chris Lesiak <chris.lesiak@licorbio.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760592043; l=1338;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=1Poi65ufYWSrgXpM9TeB84HDWnd8hM9UVI5WIoXbC1w=;
 b=/NDAEYSPTNjccxbXM9CerHi6+IMRbOg6qgd010QRi76D56k3YI89lWuwidn4hWmaugRnufeq7
 K2+aq1wQVoQCO8BNyg3zFGxT7+q6W04gbsZ9b966LjzNtQuZobs5crS
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

According to the ABI the units after application of scale and offset are
milli degrees for temperature measurements and milli percent for relative
humidity measurements. Currently the resulting units are degree celsius for
temperature measurements and percent for relative humidity measurements.
Change scale factor to fix this issue.

Fixes: c9180b8e39be ("iio: humidity: Add driver for ti HDC302x humidity sensors")
Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
Suggested-by: Chris Lesiak <chris.lesiak@licorbio.com>
Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/iio/humidity/hdc3020.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ffb25596d3a8bad01d1f84a9a972561266f65d76..8aa567d9aded9cab461f1f905b6b5ada721ba2f0 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -301,9 +301,9 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val2 = 65536;
 		if (chan->type == IIO_TEMP)
-			*val = 175;
+			*val = 175 * MILLI;
 		else
-			*val = 100;
+			*val = 100 * MILLI;
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OFFSET:

-- 
2.39.5



