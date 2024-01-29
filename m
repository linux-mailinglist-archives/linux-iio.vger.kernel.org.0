Return-Path: <linux-iio+bounces-2026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E503841110
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 18:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6692881F2
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553936F08D;
	Mon, 29 Jan 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KXAqSvKR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07B6F080
	for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550227; cv=none; b=GPMEU8minAQp7VSLFHk19YeV4Gt7UfOXdBjJrTJLxFeRxnnsi4CUiAtUXpLRVQ1aYF58/GDx66J7VgBJkC8iu+P94uHYSgoBnzzWAlTcdj/8bcDswrrYs47vca2/H4BmtGHpmjLJv3xKrzRLjHHH6hLOcmpGfVW1yxLZVdfihjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550227; c=relaxed/simple;
	bh=AaTVe4fPYxzhknQmWU6VukxDd0S4jZmIG3xhl/sR4DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2N2jBrL2QtNlKd0aQ8UCsUPBbQu/QIaDzSfjWzblqSyzIIgVJbRjeAsuZK+hHFNzlv8rmlBLcTcUJzzIIXCT84Sd8592CbO2UxkXtI49ERmndvhdeayZ1q5bLsSrP/yg+iNxpC6uUGkprPHC62xHOVjBQ30wnxHLug1Gf+df9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KXAqSvKR; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e1352dd653so395255a34.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706550223; x=1707155023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W5ulVfKbqBJAfmRxrNqOUHB1AQ0ZU6Sxi0KpMVZxhwE=;
        b=KXAqSvKR/Sr1HYBeArPvAspzPsgutzHcVSHRglH2vcAru7NLZBbZwFzR3EPlk/n4AM
         7tmWuKXZKHuTK2cKihmZzDZA+CP//WLS5ezDAmWWWXyE7ggF667vkqJ0u2/3RW/YE17G
         4ZXyxbUTf+zsSZ6ho0b5+CPQVNTvpWXN8r8h3VPc1HxUQSQqpqnvw+9JdChnDk+4ZVuu
         2Thk1PJv4Cqf2MDswYKJpRNYyUFESBbmd4W0tBnP2odUtk1eufdG02s1CQqOJ3KjusJz
         tlPy0+U2KmpZdpblMyXkAz8Hz4Wvq+mJUpC72RAfo4IHTjDnGXP+Wz+/crsZXektdGJd
         oC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550223; x=1707155023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5ulVfKbqBJAfmRxrNqOUHB1AQ0ZU6Sxi0KpMVZxhwE=;
        b=foE/7Gs+bmG94ZKNzJoUkeuJrG7VQZHNoqWRwpktF5V0p1CUqU26/bNLnwqNrPVsC4
         0xlPEbRIx1N/yu+uJZ9kj46pGsOZZtE7aM1zrRROElyor68jjHt2HSHzJboDHaJ31CFS
         OyrpmdXFhxJb5tqShuDdXNpAxTi/xiYkW6NpHWKB/V2yRgvb5pp9rYaZ/qSUW2rEQ7Uy
         Rl/Z7Aojr3rETc9S5eIDmBwBdpvXyeDJBCiM3jWH2UR4XBPjFpLZm/rPnTpnbT49kDlk
         FjPfpnbDopEhzeiZFncig33lTDDdhz+I/z4npHezahdRjFjOnTGcVxL0FV6mf/gP7KE5
         lwFQ==
X-Gm-Message-State: AOJu0Yw5Wcu3aC5e89lbwyad18zE5GxvRY9qKcH+ABsvXw5BpjOL4v/r
	aNdpXzJw0AiuKJ40G1KDizNNFUHo8pmGJmbXeSFEM05jyxonNO5ezGqvXvSuFZE=
X-Google-Smtp-Source: AGHT+IGd7td5McqP8pDdiV/7+x8HZlsSEOiTmLx+F37kcBYKvjMVsWnMmdpVi+HEutXWTTjDmANuFg==
X-Received: by 2002:a9d:7f85:0:b0:6e1:13c8:ca1 with SMTP id t5-20020a9d7f85000000b006e113c80ca1mr5005124otp.11.1706550223646;
        Mon, 29 Jan 2024 09:43:43 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id p16-20020a9d6950000000b006e126e4b05esm661334oto.2.2024.01.29.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:43:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ad7380: fix sparse warnings
Date: Mon, 29 Jan 2024 11:41:48 -0600
Message-ID: <20240129174150.655088-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the sparse warnings reported in [1].

[1] https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/

David Lechner (2):
  iio: adc: ad7380: make ad7380_regmap_config static
  iio: adc: ad7380: don't use bool in FIELD_PREP

 drivers/iio/adc/ad7380.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.43.0


