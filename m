Return-Path: <linux-iio+bounces-4521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34B8B2489
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0C61F21F59
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D114AD35;
	Thu, 25 Apr 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TIpy5pPs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE114A61B
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057419; cv=none; b=jhCrC2Fbkhn9fZ9dWON4gNgCtaAuPAPjSXOgU4QAuXZ/VdEN6AtVOjhpU9D7ffjHVhh99pYGT3Kr+dgu2SspsOZpok86owoNDtxAxwISawUXsdzTMbFINqM8ukGplNAWtbgNW9ZSHTtAfu5Az1TGbbdqnKYwHHS1KzqwclfXCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057419; c=relaxed/simple;
	bh=InEifnlaJ03rA8QgNLlhw6s+Q05Y2oXvccfChwmxIgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Olmdw8aJM1qwwpgK8LGNWHzaSoMzMhoFrbVzF1sFvbCDpfNKh+81MW/uaZ24BpZlffVLF+ar1E9o7ZjMUmzNCrmUqouM27nipdQmW1q3vHDsd4QyQ4zD4og8hx3LyZiEwSgCYbyBFmp/S9lyjwzJ4lvxGQq98+ar6mpIoHvZbMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TIpy5pPs; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23a9d3c9153so549838fac.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714057417; x=1714662217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALDEBHn1/H2TDQekY233nOtWpDkhb+DBBbFG5htxIm8=;
        b=TIpy5pPseRhnmR9FLqscjBFlJRI02XbEEfKOTANAFpAwSn6p5pHfYOVnIiUP4/lVR0
         SCKs5RJgvLEh3rRb0B81op9pcu46ZfsUXwvYnuS/MC5NRTuIvi0+tQ6XV9UL/J1LXUyz
         aWgVBNUa7mk1f9YLIeCFlhmG9O7et2EdzgopMH5N6yIib3QkFUp+2cAWo5GrSVDJkfW9
         xEHr32rfuW2DbAQj9sh2djMryNRaUOhRwCptyrPdiVnzNK7xIdemr8RwDenECAQVIwp9
         AYMicp9POLOtRaLRBcTCcgxqMNXjL86AXoWRMsEe+5/QwdH8VBM5fBvfzA6BY7RHhl0f
         3bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714057417; x=1714662217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALDEBHn1/H2TDQekY233nOtWpDkhb+DBBbFG5htxIm8=;
        b=NLM2okxJDkdVyz2S3aW7z4anWI+5qTZjyVJWm4FemXMzowUTimrQe4dLB5MucQfEA3
         uO38s2zIv5nt6NNrnYE2b+7Fs9dG+IpOgAEZO4czPVCwWKqJFr7GoT+RtXyWhYiEbG6Y
         rBbGS2nHu+keyNHSOX3FHbjv97sP+vfL69uPQ03/AaJPFrClr9ssLuPYTm93nhVqmzl6
         bHnnt1oLyYGoMinYQrR1FSVxF+lw38VtBDi9brrKKAcncMaO8+y+NguaIBQGC6efSob8
         RQ6KrqKNUGAa3ewArJPRZgECIl5Mo1U8CvbRgrch1bSOXo+DVCa6am71h1L53b2gO6BC
         NxXw==
X-Forwarded-Encrypted: i=1; AJvYcCXYU76bhu559FP4yvv4385nd+NZU7gWsZ6uxOmfURs6Rmwey1OYbJmjuFOxP9fZC8DeMVZG55rJbJWF+gSepicgnP4fpyV3VK69
X-Gm-Message-State: AOJu0YzwTAzQv6YxpBToXFLGfm1sQy36F3GZqlouvjuoixsV4DqIdY99
	EoodltF1VRU6CPR3ic1wEOApx4h0tgYhj5HiU4T5ku39uGXjHsnZZBssh/Fm6hg=
X-Google-Smtp-Source: AGHT+IF+ytB1gMG5gdlzfQf5qI8kdu3jxsrVIZyaQCoI1mcDdWPMWQNB0NwCuMDh4O5EGMwTLzBV2A==
X-Received: by 2002:a05:6870:c394:b0:23b:8a59:f5b4 with SMTP id g20-20020a056870c39400b0023b8a59f5b4mr702248oao.2.1714057416777;
        Thu, 25 Apr 2024 08:03:36 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mp2-20020a056871328200b0023b6d4723edsm166739oac.14.2024.04.25.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:03:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] iio: buffer: initialize masklength accumulator to 0
Date: Thu, 25 Apr 2024 10:03:29 -0500
Message-ID: <20240425-b4-iio-masklength-cleanup-v1-3-d3d16318274d@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
References: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Since masklength is marked as [INTERN], no drivers should assign it and
the value will always be 0. Therefore, the local ml accumulator variable
in iio_buffers_alloc_sysfs_and_mask() will always start out as 0.

This changes the code to explicitly set ml to 0 to make it clear that
drivers should not be trying to override the masklength field.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 1d950a3e153b..cec58a604d73 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1744,7 +1744,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 
 	channels = indio_dev->channels;
 	if (channels) {
-		int ml = indio_dev->masklength;
+		int ml = 0;
 
 		for (i = 0; i < indio_dev->num_channels; i++)
 			ml = max(ml, channels[i].scan_index + 1);

-- 
2.43.2


