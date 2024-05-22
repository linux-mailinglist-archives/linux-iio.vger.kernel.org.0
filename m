Return-Path: <linux-iio+bounces-5193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E278CC95D
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 01:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DEE282C80
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 23:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2F5149DEC;
	Wed, 22 May 2024 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GouGs19n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C48120D;
	Wed, 22 May 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419111; cv=none; b=plpjpolIutfHHLU+kK6wr7reu/fV3vqFr0dQuQoBvLx0gB2o2mxHS+HPHqU1j/p9fKTk+e1t/wsk5Vx2i5e797xCHhMymZ77kuhuQrE3e4N7QJ69K34P2aeCbfTWxI/o/hZUwM6e9Oqj5Y/liF7KOPUNzWL00gjTAzlQ+Qdqz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419111; c=relaxed/simple;
	bh=zAG7UVjZSITU22NtWsDj11EC6yJ4bIphhJ/MuCFdO10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+PyFvrpZon/9ZlkakikSU6jf0y6bIdDLZ9qTWtRbYOUQMy1U2isBbA9KgQO00yc35l+hNtE4oRDRA87l4QGzekmkbwCtAtYO9T1vE6OfqBzMzSYOaj2+cohlHI0ofcZkq6FL+iGLvQwIrRBU3MvwACtkZJGuY7wUg0XyOrbriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GouGs19n; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=i33G2UVz5c3/3ftJDH9srccXV/AXkIRSYqxyOSQWIC8=; b=GouGs19nkCmYyk1R
	zFZnbNXkUQv0+lj0z61o3XPODLIH0VZR828C8ICNszJ3KA0XsFtBdQ6nwqu1EUMVj2D92NLmf83cI
	ZnUoibxkvr832CNjPxtW1DMliGD2IjQAXpquzZw1U97oSq6ymLWBbJl1hq2GqORekdS2bgjXZUIaj
	3sj3UBHyQLCYlfmKPAxcyXaGa80UhxwYLLPGGa64HwyNDkmqNtu4KKaPbUVi51dGm3lIQntLrWNc7
	anBRhXuGbEveB4tZAQxwhczCtUjYKipcH6+z7e/ux9nyntO+htwRsLYa0oQUn73PvDtM4jTalJ5kT
	5Kj0zFY994nn1+xiSA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s9v12-0027Vk-3B;
	Wed, 22 May 2024 23:05:01 +0000
From: linux@treblig.org
To: jic23@kernel.org,
	lars@metafoo.de,
	marius.cristea@microchip.com,
	mazziesaccount@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] iio: accel: bmi088: remove unused struct 'bmi088_scale_info'
Date: Thu, 23 May 2024 00:04:55 +0100
Message-ID: <20240522230457.478156-2-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522230457.478156-1-linux@treblig.org>
References: <20240522230457.478156-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'bmi088_scale_info' has been unused since the original
commit c19ae6be7555 ("iio: accel: Add support for the Bosch-Sensortec
BMI088").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/iio/accel/bmi088-accel-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 4d989708e6c3..469a1255d93c 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -114,11 +114,6 @@ enum bmi088_odr_modes {
 	BMI088_ACCEL_MODE_ODR_1600 = 0xc,
 };
 
-struct bmi088_scale_info {
-	int scale;
-	u8 reg_range;
-};
-
 struct bmi088_accel_chip_info {
 	const char *name;
 	u8 chip_id;
-- 
2.45.1


