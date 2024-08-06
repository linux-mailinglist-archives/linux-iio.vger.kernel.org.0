Return-Path: <linux-iio+bounces-8266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF353948BAB
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 10:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71C5B25BE3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE911BDA87;
	Tue,  6 Aug 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgrBCm1p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90713A884;
	Tue,  6 Aug 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934301; cv=none; b=TzC8iq/JXad1+6wcvoKrGw7et1z5qi5z0kWkBgzftc962ZA8OhmnV640lDEPQpo5WBLeRB3Li19Yrc9yDEP+nXeH3eEd5P0fQ3z8Ysbsmfjg5TtDBOEPffht0pDAVm5+MdMp+v7Tb/gIh5tIuPuL+Ir5dhdw3wVnMpEhnnC9v/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934301; c=relaxed/simple;
	bh=2+Lxiko6ZligeGS4dc4/EzTkBkKDNlSRrqvZ8kgh4ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxnhtNS73NahPQk/XPXoKnNcz5QEXmmR9RsQm6qz5LPKnp+eOdFYHkT15qVRDryVFRmalRmTJlKBeyHQ3TUW/O5dzTnQoC7/mIUgyd2Xt+T6S5pRXfPu7n0LWVPyRHM/e1W0dsZskGrPQlaK1zuPix5BDYXM96Mz6X9OfReeTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgrBCm1p; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7b28442f9so3337876d6.3;
        Tue, 06 Aug 2024 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722934299; x=1723539099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gin8E/Gou+L852rKqaT8yJDJEOm3ljHZ257fFbqypfY=;
        b=kgrBCm1pJLjxUwabGl3SDs6hqccO1Gq3z+YXnmsdeig3//6Sb0toobO3di4xvrLot5
         qSWKY/UDPWWVeiNmkg2xmO5l87BDN82entAr9GnughWqi+Zsn1JTyK5oGat9mTalvTX0
         egou3qoy3LXD/UwIrcxevEyEjJ17gZheXJw+YvYgnGeIlIuqQSDl0kAnDyM2YT3SO3Lf
         ItRlov4JVqEdXDv8Ju1fbt1BRUAbA4rRwIfkQkzHDfA6Ao6glhFaC3kFBHMPv2Kz2DN2
         o5061sBx9rajhantqQqBOorCh4k5oiKDge6IejTb+J+MR8/mrxjB1B/VhgBF+qUs4vsh
         eNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722934299; x=1723539099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gin8E/Gou+L852rKqaT8yJDJEOm3ljHZ257fFbqypfY=;
        b=Fi0bmzwRAWKrpbnIsVxf6Umkcuip3AglsQFp/mtf4Mjt0D9/Iujecx/wRlgj7tDBql
         6MCLyUdyoQ7EK/byQXaU4MChQDfzZ+3upQ51I2xgI9RRzZ4BkHIwYhAThzUa4si6qcrF
         dXtZNOagMugh4lU3qJ6371YC895IeZpN5WaqitPtFxUQPtgggfpbBjUuewc3N4Ep6U6h
         BIQMLosUgmqms7Ik92GonNDiofTj7lT+SIgr7P+6I9jwFpXtuKUDn4NDjwyCLHM7PZ1p
         W9aQXkd0qRvYsID4HIQEM9tZ4uRakG9I658zCt+LIsPhp7oAbYynM3ICoU9JFWHwl/Pq
         rVfg==
X-Forwarded-Encrypted: i=1; AJvYcCVyXTOo68/Ke2ZwhuFmkV2boYa4/c0db8Y1qUAHGSjCkudLBN1lhjyhX+JRavk9WMlCT/tw3STQuIXoANEz4zb6I0BU58vLTHHeNeYvXd/XKdfDpPp00lW3JVTuzz5xk54ff5qfokCi
X-Gm-Message-State: AOJu0Yw49sYrY8iyI2w6FkhVPMXUMuq18XvzrebWspWsLd74HVNnz0qA
	67hefxW51bL3I4w/c/Y3HqJaM8MChNW6LkJX1pIHrWtKkoHvkbEbO1XmagnqvwA=
X-Google-Smtp-Source: AGHT+IG2FgUAZOuWAbufZ/kFsVkYH/mBhs0sj7SW9FI+wwS064TW6Jw82vIizd3/wZrb2sfNmcYI9w==
X-Received: by 2002:a05:6214:3b88:b0:6b7:aed3:408f with SMTP id 6a1803df08f44-6bb9838e594mr150803896d6.13.1722934299215;
        Tue, 06 Aug 2024 01:51:39 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7c2512sm43300816d6.74.2024.08.06.01.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:51:38 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
To: mitrutzceclan@gmail.com
Cc: lars@metafoo.de,
	jic23@kernel.org,
	alexandru.tachici@analog.com,
	Jonathan.Cameron@huawei.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: [PATCH] iio: adc: ad7124: fix DT configuration parsing
Date: Tue,  6 Aug 2024 11:51:33 +0300
Message-ID: <20240806085133.114547-1-dumitru.ceclan@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cfg pointer is set before reading the channel number that the
configuration should point to. This causes configurations to be shifted
by one channel.
For example setting bipolar to the first channel defined in the DT will
cause bipolar mode to be active on the second defined channel.

Fix by moving the cfg pointer setting after reading the channel number.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7124.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 3beed78496c5..672d41bac8ca 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -839,8 +839,6 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	st->channels = channels;
 
 	device_for_each_child_node_scoped(dev, child) {
-		cfg = &st->channels[channel].cfg;
-
 		ret = fwnode_property_read_u32(child, "reg", &channel);
 		if (ret)
 			return ret;
@@ -858,6 +856,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 
+		cfg = &st->channels[channel].cfg;
 		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
 
 		ret = fwnode_property_read_u32(child, "adi,reference-select", &tmp);
-- 
2.43.0


