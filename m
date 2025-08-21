Return-Path: <linux-iio+bounces-23108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDDB2FE94
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 17:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98AE17CD68
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C392D0C73;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiBMmxR9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F62749F2;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789853; cv=none; b=mR4g0O1qGpFC8gVoDePp514/8R/TsANEcFO+6j8HNiM8ULQSMOxWglcZhAChIDQu/JNDCvFBnpO9xRqQYCFMuwz7mmpe5OneWJW3AfBQTjzpB9tnkbf6T4ldVedKbuMPNYqsEs5K8bhP0V2X7msHGDuQCbDEHN/viqcu0HBO1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789853; c=relaxed/simple;
	bh=N2KFQtsx08W9qg2uTDI4YOafXoyEQvNUpghLKg0oQk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LN12dzAcOdl6ndVM2Dgzf5AP2K4n/5rAAB0QCC/6Judod1eOVOIZhloDs8h2EVkceQJdmJHvTUYvpxA+MVmOEByctrcWp6fBFJJMNIfgmfScDTya7cTi2z0SOaFCTaDbZzTo7P0rmWgrS9FUmjiqiQUcw0e9aarbreX25dZe9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiBMmxR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 400E5C4CEF4;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789853;
	bh=N2KFQtsx08W9qg2uTDI4YOafXoyEQvNUpghLKg0oQk4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EiBMmxR9lyhTc+/g0E7mn84v3qutI02QjefodzN4Q3FbTGsYV8rCMtnMHyLqw+xdf
	 vKkROXEFGGITdtMEiBUu44bwef74gKjR0lBpwna+stPsHGAgLhDfzXVeCvfN1a3IFk
	 lQ8oxU6PEVi1lZ0+TNqLx/++v+Q6cIzWZP8o6D5pa69g8GHGykje2fpI7Gps++TxH/
	 IM43eH5SpOtRBu5Zv4SZFlptRVCHwuoIEOFGNDs55R6huzBv7/pUF0zwt9loAeTMnx
	 xre7O/cCMVXlMR72FJlukpjVyII+awCoQmAw2FQQBmu4o7SFvxw4ZEt72XLK67OOle
	 C+yqpcmsnLueg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F464CA0EEB;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 21 Aug 2025 17:23:54 +0200
Subject: [PATCH 1/2] iio: humditiy: hdc3020: fix units for temperature and
 humidity measurement
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-hdc3020-units-fix-v1-1-6ab0bc353c5e@liebherr.com>
References: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
In-Reply-To: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755789852; l=1137;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=zU2WM/KRR9c7JASH3tDcWcCYxHF3YHQV8t4/4aRD6xg=;
 b=KJnm/BEJrcTm3W/az73AK1GH314rol7V0XqRKiffB8MAmK0EvTCgIEuMire7WtDUCOAnJvEjy
 pd/ZFGMN5OCCabxWjqpNp9ZmZwZyENetC8ImEzOV6+VvGS3qofFSTuK
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

According to the ABI the units after application of scale and offset are
milli degrees for temperature measurements and milli percent for relative
humidity measurements. Change scale factor to fix this issue.

Fixes: c9180b8e39be ("iio: humidity: Add driver for ti HDC302x humidity sensors")
Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
Suggested-by: Chris Lesiak <chris.lesiak@licorbio.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/iio/humidity/hdc3020.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ffb25596d3a8bad01d1f84a9a972561266f65d76..9de52de628e04263a2b62a512a36203d6c02c5e0 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -301,9 +301,9 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val2 = 65536;
 		if (chan->type == IIO_TEMP)
-			*val = 175;
+			*val = 175000;
 		else
-			*val = 100;
+			*val = 100000;
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OFFSET:

-- 
2.39.5



