Return-Path: <linux-iio+bounces-22332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E995DB1C2B3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A0A7B1B13
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207328A407;
	Wed,  6 Aug 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8tLZvNB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76994289367;
	Wed,  6 Aug 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470948; cv=none; b=jor0lgZwZUS0Wku+vQ0QluNC+E0dHr7+ju0g+xvKbVxU2mjNS0uoA5OX1WZQmelVrLchoIkrM2oR6Dp/aL3UxZYfMK6PjV46dKjGrjF4IegC7O4B/7mOCSHESoPEtHp62APa9QubGQvCsRGXxM85Vo1fz2G8ffh3wLUQlUtxXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470948; c=relaxed/simple;
	bh=Ti1HBlwmwAF/ato0E7ZuTCTGEIoTCuurdcPQu4asqWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgfezgZTsGqHe5641+poP2mL4WcCIERIWeoVNq9PflBQJ0wkxN4+fgr88ahX97+hsTrQL8BVUc88+F6xrh22mDc7S9jYRtvajsBWDurfnxocQlK5zrcZ2c7ozAiSAgRHq3XiE2dsAOWGwzaO8ZdshET1LxtNTFcaWlnTNGZLsEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8tLZvNB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459e210bd2dso2165975e9.1;
        Wed, 06 Aug 2025 02:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754470943; x=1755075743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvEDCWA8NiO6TZiT9vCBQ8PFW0GAZ62Xv+vkGxU00Gc=;
        b=b8tLZvNBEyy8UoyFV+H+0sZb1DNjqiAHo8CK+Swk52QqyxaH2K96oS6V+eZJteBdjH
         F8RGjcMyp90tjLiRU9jQyj53RBGRvOUtLPMKHfTAsR3kCdvSo+wkBvoL31kDLxr0zmC5
         r8ncQfaIBBxz/yIdeW0Pnm75qhNjpw6zbvR49UotVUgozXPeUfTzA2lhrkPZ0sIHGaYI
         aqkmtYPF8FWLnfeTQoUHXewyQ40z2wlCBBiT+uKL+oYHJslcrP46613iwrGTQ93npwJF
         N78sgqKtO653YnEh1OSOrixUfZNwB/jCqpNdLlyC9AfD9GDdRpvJhDXe9zzgLZm4vvUK
         SgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470943; x=1755075743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvEDCWA8NiO6TZiT9vCBQ8PFW0GAZ62Xv+vkGxU00Gc=;
        b=lNSGV/gIMETRwf/8XvDSam0eHJTavp9/7YUjpez/KNrJmMqfs6bUBP8NN8gcEeoirg
         Y1H1+CWByj+XqiVut2alfWz8FqUtn12da78QW6fSmFBVXH8MLaXM9UAy9h6spe/yCXb5
         iqCaKVBJeSBCz88IRSPTxBorOXJc7CdbBoZLgbcfmqcFOpr7KaImI5xjMW9EncPS1EuI
         Y/2X5sZbNMrKAxUI9XKBcS9nRpobvWRTj/ywDvm/i57MKwi5RPZqSHmRsVCdhKChbD91
         b7wCF/iuveHEGm+PR9TyTfPoRwqdQgSBMO06m/BpJXrhajbW+iqn9iNbLvydbAbHm2Od
         zVPw==
X-Forwarded-Encrypted: i=1; AJvYcCUPsWjoUYG+1vKQeti7aWnYXUEPcWya8auyDyptpr4wTO3N0Eyu1V7fIDZHgQbc+pKUH1zLNJV/u5RWxVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3tFiBHApoeoVoVpo+eKjBPJS7a4fhOe5j8hjmrDZHaTnokpqs
	5dY8HPx37NOTQAdmxPbyZvo1PZJgHEuCFxgRga7wGRwpbgeidKcqewp2
X-Gm-Gg: ASbGncvlwply4bmyJEgT75kwp0BultNrmXPWFqCMbr8HDBpqu4LMxqJGG4Z9NJ3Vjkn
	bd6mvod8Yqbp0TscqDDXWQ5VnqzCIPepORjGI/2qMcsYnBakqjM2+G2sR1R/SyMsRNguR1c0eBr
	DiLUXdbxk1lL71jug4mQ57Lw+XjvAgxC2UbQ+cwtzmMIR6HSrVCNT8NNLvykeQXjQ4y5nBJxqy3
	9i/DdQnht3Srh7kDSpuZsNScYGWVxyVRcplK7BZkWMVosxRI7qN1tVD/xxU/wZNuSXoF5N0azDW
	GVmc6+4H4Bn/+JD2u/Ex1XB9ps6SySq70xXTu/IG6alZbcORpjjY6ZDEc20PIp6s5tTpcIZK+CA
	wLgI8fYl2dQtaQWHah29+dD3xv5FlPQT57N596YA+8Yn3fMS5NAXawjHI
X-Google-Smtp-Source: AGHT+IHK+oyrOOvlbADfCzYg6XYKvW6WAMjoynZ1m8kX8Rq4xjFKurhYYnRc0JXpr0ubDQ36E9qJYw==
X-Received: by 2002:a05:600c:821a:b0:459:d577:bd24 with SMTP id 5b1f17b1804b1-459e70bdca8mr18129335e9.7.1754470942586;
        Wed, 06 Aug 2025 02:02:22 -0700 (PDT)
Received: from fedora.. (93-38-186-193.ip71.fastwebnet.it. [93.38.186.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm22309399f8f.39.2025.08.06.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:02:22 -0700 (PDT)
From: Stefano Manni <stefano.manni@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH 2/2] iio: adc: ad799x: add reference voltage to ad7994
Date: Wed,  6 Aug 2025 11:01:58 +0200
Message-ID: <20250806090158.117628-3-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806090158.117628-1-stefano.manni@gmail.com>
References: <20250806090158.117628-1-stefano.manni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/iio/adc/ad799x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 955d845407b9..21e03f0df889 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -694,7 +694,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7994] = {
 		.num_channels = 5,
-		.has_vref = false,
+		.has_vref = true,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 12),
-- 
2.48.1


