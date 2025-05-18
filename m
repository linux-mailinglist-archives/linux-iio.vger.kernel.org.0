Return-Path: <linux-iio+bounces-19618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEFBABAFBE
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2F83AA373
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B0721A453;
	Sun, 18 May 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2xTDFQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0B218EBD;
	Sun, 18 May 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566821; cv=none; b=aEUvZGlV355Gi/60KTVnEM5SIZpO4UJi+yj7pMdLePZJXNPSmtXdBlZNvOA443vm4+wMkgnrSXDDTkEf8aWslIJo/YG+ugENKqr7jVVrXggdHASyZDcIJNB9MRnCpsQX21axq4svwlvTdQzw1flQJ5vmDkmwkYcb+E+X/yWP7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566821; c=relaxed/simple;
	bh=XAQ4Qx/cNXKeTI+urNYJNwwejnrhpgOaw7jqkObVdLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tW5sWjfgYE1l352bymsbJ9yRRG4esL8i9+KTPfUcaTD5+5KzkbyeLvpCitBxEsQs7aYC0Zry8jPciuZwrO82E/Vh7hoGcjJa3Z+UfOkqpbVZzmXONFdNN4EqTQWG4K0ZMseuB1wSZcEbbzO5/r1F0W286LITKCDuPjrjtUxGqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2xTDFQc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a36561d25cso200624f8f.1;
        Sun, 18 May 2025 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566818; x=1748171618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUkIRCCD9m/sgmrQvaYbGBD2Crn3c2cs1UFnqgq9smc=;
        b=V2xTDFQczFuSSpRGnDiqv7A1o1QU449S4kC9A96RyfMb1ECDZX16g8qgPrNCgbRJuw
         u1HfmEDexCbXpjLwCordgvlYjq/Johd70w5wXHB/q/lAhIIHbBCj8w55jNify43hmk3S
         KIrAjAptd8iCY7h76lKynsq5ZS18B3iYg6slBDPTTgm3FtR3oJDGmvik8AtXcMQAVEpS
         7Zl5MEVj2LZwUJiotsYKBHZPyF6LdsIy7gWYRM9j8X4TzCxr2mi5KznH4TGSTVcYBoQ/
         GrIp5UdJtN/muoOLbTj7e3SFPhw5zKeWm2hNeeegp8py+FmBs2A9HYO604jHrksBHpaR
         tERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566818; x=1748171618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUkIRCCD9m/sgmrQvaYbGBD2Crn3c2cs1UFnqgq9smc=;
        b=Ff6m+rZnavDUe6kH+ICViR2pWeM4RuO6Qyvtp3UmxiP/EsV2BB5OkQ0ijfkYkEBsKk
         wZJxcImAYO6UUkRKsObQEvMVro3fmYmmvhaHTTPhsyXQW/yrrr0tWk5UOQ8AsI42zsTv
         EmgCUBnYaG5rStqvsBtTWVxjs6W0X/SvUH3LNCiI71IiQRZQiaJ15Kb1nRPOdKKTRfUE
         PGcnXIRs1Pvpjpug3KWGU2JhABBBmLBHvl6H5fQdVa8/c0CFQEbgz6tD6cSBWP9JgFTg
         At+pvveJXXqm9P7qpEYOUnq1UpSTwFZkLmsYwpzc4epLEbqeb+x5GTEOCrZN9/E0BpU2
         sVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmrVkZbzkD8AN3WSn5bo9ue+Y/Av+c22Xa6D+6cMCFb7yuks+rSDwDPYp6iGiWaTMnSx6vU0sNQAc=@vger.kernel.org, AJvYcCWpxy8FBCLB1/KdYng31n2Jbia//Eua6cy+GA4riquoQvUluTMxQgTAytBNE+mf5OXInfcQnHDQtozPhMjU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ztzPKwVTJ+tTGsGhqBdIir4jo1teLC9s+rZRnQS6Fkvkkzc+
	HQvwrkmg0+hwaLFNaONvyuIecCn3AdoweRvdACSTfeyPgvK3lWPjccLH
X-Gm-Gg: ASbGnctXKydG6/pLQyu+qeLHEtBh2a7XkpON4LbIJSDG+yQfAlE262qtWH9XFE8xrSa
	B1hWxV6AfVRvoYMA9LyF0TwIKSAGgcxZ4HORmsMXwP3jCEG1tVmdhgnDb3kTBCYC6T9nn/LR3NN
	CtvPgTpv1mGUo9pNbjetGRfk/S8entLW1M+wkjwPZ4O/aPZtoEi62TWo/ySZY6d7jpoVfTcd8Sn
	PjuIsyympqp9P+zQvgeuldUWXtUgTDFauTAz8+vP3UAO4TYxjlKQxwvCa6vHoeuzODkQC8dyU8N
	PFoNilv9c4t+ZbfP/ffzsP2BRb7kEQW656Bb2aN3W3i7nTcasox3jnGYgGwz1g34XcbQm2UOz8/
	T4Rhfh7gQY7EbnaC9mTjQLw==
X-Google-Smtp-Source: AGHT+IEfsIxneRwX5XOaIi/ITsFLgHH+ZVFxIYi1xZs6YvNFFA/igr2Ekqn8ZOixdHJzBoZIUb6q7g==
X-Received: by 2002:a05:6000:178c:b0:3a0:b807:7433 with SMTP id ffacd0b85a97d-3a35c83a0dbmr3220784f8f.4.1747566817975;
        Sun, 18 May 2025 04:13:37 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:37 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 03/12] iio: accel: adxl313: configure scan type for buffer
Date: Sun, 18 May 2025 11:13:12 +0000
Message-Id: <20250518111321.75226-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet the ADXL313 uses 13 bit in full resolution.
Also, add signedness, storage bits and endianness.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 000f59e2db87..ab889d50b4d4 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -184,7 +184,10 @@ static const int adxl313_odr_freqs[][2] = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 	.scan_type = {							\
+		.sign = 's',						\
 		.realbits = 13,						\
+		.storagebits = 16,					\
+		.endianness = IIO_BE,					\
 	},								\
 }
 
-- 
2.39.5


