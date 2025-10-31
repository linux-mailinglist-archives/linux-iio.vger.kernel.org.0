Return-Path: <linux-iio+bounces-25777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3963C26E23
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 21:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0721A66B93
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA93328616;
	Fri, 31 Oct 2025 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrRWhDoe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B20328600
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941975; cv=none; b=ZugseDF0fOEbxz8QzbQWK8qDgxxoVnx0QxXMKw/yTkWn2hUbCV6CrAFaw17fBXGln6NpRlcpNcwBKKMiHHmTcDsSuE7TpoiQwYWBsE4OsjI89T1BTMvm5CGGBSlCjJQH+fiWK3UqDjndxPe+Dz2VilsAmfKGVDLTZyb0FPSbJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941975; c=relaxed/simple;
	bh=uhtPyUARMh6iqTL6T+FkCm4KL2BKQJC1wSSAlBNThFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqwwYgu6pa58PgT2SI4piGwnojrNFuxGN+k7tv+PbyXQVIlx/0Yd0eFy9dORrSTiiUPI7wNyee2Mx7PGTgrLh8lj7NAhk32ofAkIAsvOt9vBVsx0UDtLuWpQYKhyaUD7z1Hm08cHFC+RKpJ2vOaFWpwg1xMAETQaOIkpi2yr5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrRWhDoe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-427007b1fe5so2012421f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761941971; x=1762546771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTXisoAd0Dg/UVvUO2lIGrX9MKyF/plfDMYlzBba5Os=;
        b=WrRWhDoeyhDHnRIXVxz9G8+vheiHkGEmibp4n0PBAPRmb+49ZrL6WsRiRZD0T8hEpe
         e+Dk21UghZjwc0M5reDZ+iF2cTDutncCepE0zrVm/A2YLvi/YU4h20LhNeuvYZa3bK9z
         wF98ehcGxaaSWhvrqJdfl1Db+fOGPw5H9W/Ko9xWjcwUoDTTib2YSzdcTcXl6U3eLx8v
         xJWG8HtJWhESQjgfjFFxTbiWawx8E38rQ47Zv3jB+YATafv70ps4aorlWQhWhl/d3iIB
         2h9AfQkaEbCaiimNO0s5Nme2rLv6AFuoN2urJnQEMpM4BVYpEdjnTq70iGqnAMvloqpy
         xV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761941971; x=1762546771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTXisoAd0Dg/UVvUO2lIGrX9MKyF/plfDMYlzBba5Os=;
        b=qWGZjmaDOjVjAy41n8E3nylegv0EHs9QSvhgrJM0wxMoJmh+r7bbHCIQn3+BWQ1R55
         dqub8RxuD+22Kab3JVTYveSTkNrZdIKJLHyVkte6/hZwanKav5XLFq36dyUuwFMjtWgm
         bf13WNmHCRwfhE8tZCVxVPmqQ+deXaI/wHJssqZZoM06Gp5lYHgi1b+TwQ6cVth9zgQI
         A8BdCSj/k4TTsVnGH95FlXZlBBZkaW7aa4SMszDK0khJi0wPDzkRfRFO5Il3MMcSYHwn
         XRL48GdN2BO7QSBK3xJmahXuBAaZbYzUHmuHiqBwFKSMNc28rkph5v/0RfrVJbBCIC98
         w2eA==
X-Gm-Message-State: AOJu0YytkCe168qA0sAt6KfpiPQl33rY/VfePXy+o+Hm5ALKZn9dZrQB
	JBSXUAuWSPzpyYYb9IW5fjHXWcWwBRkqoTkTmtz07uEaq83FP1mrm3zY
X-Gm-Gg: ASbGncs3eqpd92dSh7swRTFlr7vUmRsUx9EAVHutlo/EQ+AQ5emJ2/hzIaGiZJ8RAr9
	uWwNxTx8aKLfG5XNuJwOv+OjwO8MHcg9KJ/LYpyWftYmPeQyUeQmrihfj4ShbsLmFVhIgxZzqnI
	E1ZFybR4798+aZSk+l+JpdbMeiV9AetOLifszmWaXb+ujnkN5zB/FGf6z+mD4iMceOc+jIquwyN
	Llodr1F5prN2hvMdWebOUQ5M/ZZo51q8f+LHYIn7TPnTiO8sEvbOluk5Zggaf+k/mief/mxgE7W
	4FMjtas34VzG4963F8j8pCjL0XXyaauLoyAGyOVKvjmm7H6He9kc307CqOq/uaL7QvUvWMvxePz
	iDQs4X6fgHan/tVK9h2YaUZuhf7K36uk2OkUMaXPZev0VVxS++YNLSI1d6nEAsBNxnA66uq69Sx
	qxKg1TqIm+/gZj1eSbHyNuWSwg9Q==
X-Google-Smtp-Source: AGHT+IHjclgRnjfrDGQzSRybsOxGI4fC6nX630RldNdxkLC4PcHK1n/8rSaA7MFSbLuneEDWUGjtcA==
X-Received: by 2002:a05:6000:40ca:b0:405:3028:1be2 with SMTP id ffacd0b85a97d-429bd67c38bmr4338005f8f.11.1761941971429;
        Fri, 31 Oct 2025 13:19:31 -0700 (PDT)
Received: from localhost.localdomain ([78.212.20.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c54efcbasm1800360f8f.8.2025.10.31.13.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:19:31 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 2/2] iio: ABI: document pressure event attributes
Date: Fri, 31 Oct 2025 21:18:23 +0100
Message-Id: <20251031201821.88374-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031201821.88374-1-apokusinski01@gmail.com>
References: <20251031201821.88374-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs pressure event attributes exposed by the mpl3115 driver. These
allow controlling the threshold value and the enable state.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 352ab7b8476c..5f87dcee78f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_value
 What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
+What:		/sys/.../events/in_pressure_thresh_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.25.1


