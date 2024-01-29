Return-Path: <linux-iio+bounces-2032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54FA8413F1
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 20:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2861C23896
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349227603C;
	Mon, 29 Jan 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NXfcgfDi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D776020
	for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558179; cv=none; b=BMRekRn5n0DeS6wNmFGo14GH/DBsCpFvY0OxHhXoWvkh9i8m7JJ865dEAGBMcaunICvFB/VKCBw1Ey+5FUbbSi1emWOAbcZ5gx1qeR/4uVa3uSIDx+s/AkYBac7U4lIJFutRxOyX+MPNZU/rJolkdKvqzOjTUqXsTBukSSH9LaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558179; c=relaxed/simple;
	bh=WKnf9MfuM5XBqCZF7IHpqB7IouVtcWbHOl6JCQfOI6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ir7AtGYmrfXvGnJf3sP5nROQMFp0f4OOVITBUAbEEQxWWmyy+V4Tg2Gy2kOFebqq4FdzjUavTSacgsBOdhLpf/P5UmEYFc5VNEiB8yEyWjVOs8NZkXVB6oCBR9s6qrWCTXWHOD2iCRKfJ+2TYz/Ocfboe9voINM55F+l4bJQyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NXfcgfDi; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-214410e969cso2218440fac.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706558175; x=1707162975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tm6MgMGMMZQzwZ0RmB4Y37DLBho3Fm2lfE4k1nbWfj8=;
        b=NXfcgfDiZmTjRSZXnDhE3F0D8Dh1EkkAQwsTvRvNCL5wWw98elbVklDL10mjE28RL7
         tL13npX1WDRYqMgfTwwrX3vewTMtmSQc5eK/9hFVE31alWtUT2cKTpTqciiRHWe419BG
         rHUkCjJ//sx3d5RyyM17DstpXww8brtydHqhhbDOUEEyuF1EJFqm1U5f2aYM1R0Ie99e
         8GUx/v/Gbt3n0GVeu8NPNpJ1iBYGS5/8TQ38rMsYGI30T5/dWsXfwXHwFMhT96GlkX05
         IiFcqp8P944Q0MnOePYotaK3LRPqKTxKsneSaVas7nraPtgxk0hJx5afATTlnAwXxSKh
         veag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558175; x=1707162975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm6MgMGMMZQzwZ0RmB4Y37DLBho3Fm2lfE4k1nbWfj8=;
        b=eoQcjd/hm+nGR4uEZpg0FSmJ61RkSvpMc8OdcSf46RTikeb/J5cb/DECJ+F9deCXK6
         XPx0KdI7CXBcRIasb53IhyxIvySYjJX7dOUtfCvm5OI5KUfZjTVJMDiUZF/EUA6TmmuE
         Oa0Bk/m64MRWWOrGCU2pzkymbcy9Ht7xu3h4qfxeJFdfqtjmeYxxwaqqb1F4Cv3U0/Hg
         YEcFaw4ONRBXhtjzvZEGWsUBmMGX+Aqj09v9q0413JGkJkg40wQwwdGFKXwJZLR2ByQ/
         0P2MDcr7DLoCik+DnquyT/HvbVc2elKUF8KehLvor+Zc/S2X+4WptznWXL2dDsvNQem1
         H3vg==
X-Gm-Message-State: AOJu0Ywev03e3ciqxzxtA/nxXyFfIZRsVuIP1N7qrWuQilhmhns7EGml
	NtNhCD5GKgAnbwaR1AhZK1GERIfXett67I76RFej3E3b94C8ZAUx33ItK9n3rww=
X-Google-Smtp-Source: AGHT+IF0qIjPSZ9RLIUuVCTXwstOjGJ8iZuVhLk2Tku7zAmemRe0HhJXEKR1MerpbsdS++z10NMGHA==
X-Received: by 2002:a05:6870:831f:b0:215:e6:8145 with SMTP id p31-20020a056870831f00b0021500e68145mr2235682oae.0.1706558174942;
        Mon, 29 Jan 2024 11:56:14 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id r11-20020a056830134b00b006e129d7b833sm641292otq.39.2024.01.29.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:56:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: ad7380: fix sparse warnings
Date: Mon, 29 Jan 2024 13:56:06 -0600
Message-ID: <20240129195611.701611-1-dlechner@baylibre.com>
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

v2 changes:
* fix typo in "iio: adc: ad7380: don't use bool in FIELD_PREP"

David Lechner (2):
  iio: adc: ad7380: make ad7380_regmap_config static
  iio: adc: ad7380: don't use bool in FIELD_PREP

 drivers/iio/adc/ad7380.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.43.0


