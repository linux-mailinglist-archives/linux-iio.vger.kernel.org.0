Return-Path: <linux-iio+bounces-12658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365529D8DCD
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9C128AF9E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BFB1CEACD;
	Mon, 25 Nov 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNqWj3PH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7A1CDA2D;
	Mon, 25 Nov 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569392; cv=none; b=Ha/TMULZhhdY3Q2VuovRfnMY/O57/ElAqxSwkA+AqjM1M+XRYm95u4PV3aWT/DCF2yhkREBQYriMpTSZXe3upXBHt6D8ClevPd1KtgFPF+Eb2ypUdJHIp/4Qs/TEj3a8iCr/7odR+s8Pk4Tw6EZJqKwBqEDH09QM21eKSzF5K5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569392; c=relaxed/simple;
	bh=yUgCJvosTa4JOZODZtxR8uq+My9nqpZdZPNK1vA9kuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nFChq90Yasfr1BK+wMtcCqVH69d7Wiz4GOJ3Czi4nG61YfnhbBYeKgMXPpjOSUmvN2TKJ1kjbyX0VJoeX9Q/+OGh+5g9IoLlBPrDgV/dPmPvlvkoawHlXeHDpkKGM/fCPEGuoL6+MQozGqVF8yRHXW/XkwQ6u7yDdjG77J3QzSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNqWj3PH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382588b7a5cso3137878f8f.3;
        Mon, 25 Nov 2024 13:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569388; x=1733174188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPd0y2aeGCf0Rzl84ovn0S6mhX5mrN9n6+Wgz6aaJgY=;
        b=CNqWj3PHouelqB62Zp6qAyIS+mlXbnCx0E8ioqFQvT4WhfYEHS9jISYHeAE8ZciT7H
         AHZBx4cw9ysRbvkED/xj6j7rEgphxBXVR+ROqVCYMOCQ+Lj8rRwKW2JIenemxj2oUsxo
         Tl5s+E33lI4KLT3XwHFQuo8Hy0NUqUWt4eBGbnVlLH6OkL5gfEbmgZuyDvXJtK03wkC/
         4iBS+aRjcPURNWP3Bqdmy7egWsg2sW06AnNtFL2Yf6h8Q160zd1+eElo94gc0mRtNvN0
         pvO8FVvWLePoiocbo6qVYkRY0b4xxCrstOMCN95pTSC/wongAdWN190hZoO5wOalrpA8
         Q+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569388; x=1733174188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPd0y2aeGCf0Rzl84ovn0S6mhX5mrN9n6+Wgz6aaJgY=;
        b=dePqaS7VNgifeB50aoVcNwBqlbPDAs6AGNgnO8lDsu/aG5rgc3mQh0B45TJHpiWyMD
         /VxscGElN1ylsDfUywIrVeuvOdhHEhrvfv6jFtVj9n/7/9v5VbrxOKejbTwNZTph9eQM
         9b2TdgZfraXXNfO7yLPDffRaytI6BVcXC049tZOnS9a8BE3lLqfKxZKutZhRnBjMiiGh
         ou4wtZqr0MoOdnwJqo15YQIP7ecysINPpN7yzfrvC7ptyIa3rbAySOBsAc7hyOcIkacU
         hp4SPEBfxEjC8NPBhZqQy4Xsy/kk6kigCQZTjxfGj8gc60OOK/+aZ6AbXCbg5s+E8jx/
         rqeg==
X-Forwarded-Encrypted: i=1; AJvYcCUPiSbgnCbK+iOcrNm7Z/4kqFw5hT/WM3f2xEnkbG5g3sPpW2uUd82xJqBdHdzVF4rigyDejga/4TYEjCxj@vger.kernel.org, AJvYcCVdY7D/2lSWjcH8zwH19VE6HILSiYCxLGlbGj5eUamJIwlTaQ6EMqA4aIln6XnNX+c/7dPA3z9gXN4=@vger.kernel.org, AJvYcCXgShbAjDy6cNtvkPgfYyyXNsGtTffw7FyzfwOXqnlanP7yeFK0tLzM/8q71caLyQB41288SWRw@vger.kernel.org
X-Gm-Message-State: AOJu0YwczwjnXp7klwIedGG/HMTXfNHu3OZ7f3SJXLmqd7R0/DB/WCCe
	seXvOljIsntT29vZqM2fyUuO6wVXTCevxshZZai7cMkJLxNvAzDt3tHmdw==
X-Gm-Gg: ASbGncsKb8mcOgZi0h8pUIk4pzHO7XTHiEcUZQsKFaxUigenRTIWiBUrW9axXVlGGUl
	TRgV9LAhZ1xr6Dd0VRomsPEEfXC2LiSJnwjnw35fR7ZSGRQFfJj2Vvx5i/e8lbNws1/WOBxg1IR
	jXMtpclWD8Zt6mNsPTfcpMD6HDlWNZVeMgiqSvOdh2dnAZky9icKnuoewiD3SVPVOUCqOz3o7HU
	TnEGZKo3qF8jQEdTxdQWB4Tppm7epOeTIwUuu6zyZcAYAmIfWt5gpskccrh4gKEtkzWydhNi7rB
	FysikTG1/7yrd6w48tPsDjRV1+nrxkKRIVEOXelHWdLC51CEniR4m6dD1h+G4qwKw5K8JevW
X-Google-Smtp-Source: AGHT+IE7AAOUeugLuKHibseE5VBHdkxT20Pvqrgn0609G0rezlgLj5maHRmvPZ1bFxKWh5ZMO132Nw==
X-Received: by 2002:a5d:64ec:0:b0:382:5129:9f2a with SMTP id ffacd0b85a97d-38260b4d621mr11698251f8f.2.1732569388409;
        Mon, 25 Nov 2024 13:16:28 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:28 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:13 +0100
Subject: [PATCH 05/11] iio: imu: kmx61: fix information leak in triggered
 buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-5-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1044;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=yUgCJvosTa4JOZODZtxR8uq+My9nqpZdZPNK1vA9kuc=;
 b=d1F7D2lvMoSuwPfHrgAZ3qito5cDnDji6CWxSe1fRWwMxCZAW+DFFtvEh7O00SfYiOmPKhPvb
 /ZLTZAOMpXPCHI8BH4kARL11mAqhTB6FJWHILvK3wbvUa2IWK9VNrUU
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'buffer' local array is used to push data to user space from a
triggered buffer, but it does not set values for inactive channels, as
it only uses iio_for_each_active_channel() to assign new values.

Initialize the array to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: c3a23ecc0901 ("iio: imu: kmx61: Add support for data ready triggers")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/imu/kmx61.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 324c38764656..e19c5d3137c6 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1193,7 +1193,7 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int bit, ret, i = 0;
 	u8 base;
-	s16 buffer[8];
+	s16 buffer[8] = { };
 
 	if (indio_dev == data->acc_indio_dev)
 		base = KMX61_ACC_XOUT_L;

-- 
2.43.0


