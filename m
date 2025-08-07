Return-Path: <linux-iio+bounces-22364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AADB1D026
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 03:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E1B625537
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E0195FE8;
	Thu,  7 Aug 2025 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcPARo1F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F210E9;
	Thu,  7 Aug 2025 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754530771; cv=none; b=unaGLFiARAw/pxIn4OKVRq6B0qZ1FrVes3m03ktIP9H2p7iqHv60V/CQnSCl3UWDIxrzuOIKjQhbVPWEK4l5TBuGSNvUomYQ+FQnHfD4dmw/Vy/iVUmGI0ckYvOMj7FHAVOnK8mlA1uuTHngXW5Krc1Vgik0xV+WzWpuY/BKLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754530771; c=relaxed/simple;
	bh=PDT9GuMb/u879R3g5593PFs7w0VAyXcCvu7d48Kp4k8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ba/hxKXq7naLcaCqmEXUzUUDyecocu1VP1Dst0EQly0pB82sOWpqCUkZx3Vo+5oB7Zu6yIQj0ljIUYyTzwi0CAOTe9eFZPgDkCNgFH6tTnmRvghrRSfdWEE5lGIMbc0kD5upF5p1OQzfw3HzgIqFzK+VgdNbD9NiR713F6RM87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcPARo1F; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7825e2775so344684f8f.2;
        Wed, 06 Aug 2025 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754530768; x=1755135568; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4xuTfsagYz2+8hLX5Pmbg+o1X+l2ulu4VJFs0h7n68=;
        b=jcPARo1FCC1SqUn4xujWNyMmvaA4qkcMASkNscT++derjo2x7ayY8q5+4Sif6Uv3rA
         SjsGXCeExUhrDrJM2HbuPWRnbaXWQldWR2br5U4MDxeFb8rdx18jLbM3hy/ZMKBKQU9H
         9t3ZQ+Is/rP8OGx7BLECHNY9T37lcptr0bNWl04Rx2lqqu2IkxuvxYsNCijg1nV2PPJ1
         Rh8kqpKlk0Bm//c0kP20lrquxM7OWd7F39fKMEkPj0WVCcpZYTK3YzYSSxWgc/OB+asa
         ulaq5ZvmHSE+zHGHx21P3FtxeC8W+pN4RwiLWrmCgEWijjB2UCt5/NCW/ZG5u+PizqzR
         hmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754530768; x=1755135568;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4xuTfsagYz2+8hLX5Pmbg+o1X+l2ulu4VJFs0h7n68=;
        b=lvmWKeMOloOLfr+XngT77syZiExn8gWYTg6oif0MTBdG4CCCUbv/+6e9R6QuOv81A7
         YCPHLzivdxERJ1hfMGwG/0rrgXY3pNk761ISlZEWEvSbyz1fL68mIMAMNVkGE2mXMlN7
         Sge2cDmfh0N1Ms7+1qMIBC+hhBSdZUb0pAwa7z5agiDFou4NxArtN/jHzVk9cDU6xFkN
         wExqKV8XXRPDaJ5ukypLJTobw5Stj1unxnwPSdh4lKMYXTS4wRKkzg7HC8qdi9Dl1MUO
         K7/0gzOGXj+vdoxBR9/hE3x5IkRkx1NYhgmuPixW96i1ep91RbFAJ+LrIi+QdZjSfGdI
         /+bw==
X-Forwarded-Encrypted: i=1; AJvYcCVQoVD/0y9QusBGTT62VdhVGFFXsmvaD474FqcEuciIPFRQFNSlX2VOm6HvBQcgIT+TRB8BS1PyYPhZbTdV@vger.kernel.org, AJvYcCWDYMDMTyrjQOp1iqhHsylLmmvDgWUc8bnpbrsYiZJHI3rUK2fPxsF9ilieP63scyCm1LSSh2zuxF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHHxKBdMcpkruvmP7CR2NnvQ9GLzR8qJ6ljLXflpHfnW4j//U
	NJ4ZFzlH7ME6LxdHXaNgZXiOZJzklTXbN5WDeUWZJqXYZ3vKsmPJpMSW
X-Gm-Gg: ASbGncstB8bW0dEPtsBKF/ueBBor47OGfGTt9lYjdjoEh3v5oQfcKYIcprXF9eJpjGB
	4x7Pze4KxlfJEsaZICBvf1GyoxpWwd5guIH6RZ803l0LjW2M6H7ap0wiHbvRp+UnuL1SobJn56H
	TobXALmdIgEOE3iq+7cw8At89r4M852Gr3QvTeHxXJf/+3pdtJi9yQTloI0WUaPxT/BEMg8ZYhe
	DjgsyMmIq8rWLksbtCtj1g3DAk0b6PK7J7sA+XWGOdsI7vPgBOKqOAzeZjQ+nQ/mvmDMkZXRLax
	RLgFBTCnVL63/ZUY1rgSOHgSz0pj5ID1rDjbHydmDktTVk5QHj/wutdDcm52GdtkZM5lt4mYXRh
	KpD/xD6b5Ddj09uAAnXR2NY/Q
X-Google-Smtp-Source: AGHT+IHqDnrVSLOXogXBLqS7HQd2Obxvb4ZStcdc39De8YJSVG9kMZykeFQ6BD3kmb5ap0/JvY9/sQ==
X-Received: by 2002:a05:6000:2308:b0:3b7:6828:5f71 with SMTP id ffacd0b85a97d-3b8f415995emr3701971f8f.9.1754530767769;
        Wed, 06 Aug 2025 18:39:27 -0700 (PDT)
Received: from pc ([196.235.182.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dd85f423sm130861015e9.18.2025.08.06.18.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:39:26 -0700 (PDT)
Date: Thu, 7 Aug 2025 02:39:23 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] iio: adc: ad9467: Replace PTR_ERR_OR_ZERO() in ad9467_reset()
Message-ID: <aJQDyzoxLsF8nKYW@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

PTR_ERR_OR_ZERO() returns 0 if the argument is NULL, which can hide real
issues when the caller expects an ERR_PTR on failure. Use a ternary
expression instead to return the appropriate error code.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/adc/ad9467.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc..70aee2666ff1 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -945,7 +945,7 @@ static int ad9467_reset(struct device *dev)
 
 	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR_OR_NULL(gpio))
-		return PTR_ERR_OR_ZERO(gpio);
+		return gpio ? PTR_ERR(gpio) : -ENODEV;
 
 	fsleep(1);
 	gpiod_set_value_cansleep(gpio, 0);
-- 
2.43.0


