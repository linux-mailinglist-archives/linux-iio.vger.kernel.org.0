Return-Path: <linux-iio+bounces-4606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D78B4DAC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC931C20A99
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 19:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199074C09;
	Sun, 28 Apr 2024 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="hU/7ZS2T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D574BEF
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714333450; cv=none; b=SS7Z493rAzYnTtmNpZCCcKVKVDrlRWJQP4MZ/neb324+UqvGvQLaX2+qryi9DDCFbW3krl7GqWIwasTtI+uVEJF27eH6BkRByHHX6e/qEzz9CRjMSEvEHE+vtpB9zj7IzDbhe9AKT1keEOLgxX4tLAcU+u0yGaC9Zmb02mDH2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714333450; c=relaxed/simple;
	bh=DqWJXZc22bMbhLDJy3EvCTZBjymTMxLye39RhiRxrow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lb+7LQy19+txgLqqDNIqya6glXyR5GNve4EnSyVKkEuujB3eeIgaphHIqUKlMWwyCukzijHQAdj4BGj7mvlHJimb2kSegaFLgwn0T98RFZUEkJ3gPubUbMRCxLIMZlADDfhshsbLCD5qG3hL2ipUEw3fiJco5IC3XADqMyDIguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=hU/7ZS2T; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2595571a12.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714333447; x=1714938247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJIFdCuYT6rurkmLwGidbFknKPMgcfbkVZjdpfCNHrs=;
        b=hU/7ZS2T0fw80aP4kMShJXyAjBQPPCBSCN5lFKGEyWcenbvAYr73sTwiNehM9bAizl
         5mwLs3jl55rShSvNnHBnXR8g4p2OXMxR3T5nAmqleFg/igTYglFgg1jtIR9ELOvve2nN
         kv6ffb60Toa+Xa0xEiScgDtVAgTLVS+oAiAPCxCVBPzbLCKP0dybSxFLnIGnqgl2jbeD
         TuwDTLBxWTVUVqj60wHmDa+WbjYv1qr1PUFgYxOVc6tFj2bkWy0VpXPUGaVPOf6dt7bn
         8C+kww1wj/1+YGLLqZpPEgkSHcfqfNOuPotvmRAV3NKbDbrU6To1UdpT1ayS0ysxRXBU
         +slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714333447; x=1714938247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJIFdCuYT6rurkmLwGidbFknKPMgcfbkVZjdpfCNHrs=;
        b=F5IL0i/k8lLGhiK2hf10qViwiLcx2lbToPPqYjO/MnW5WpNKC6TGC9EYrIffjqGG+r
         dMy+3aUvyHYjhL2+uOg6RGQ+cU98PEAE+togedYPExV6X6kswoliYuZAnp403BizGCxS
         jrTKUaWFO067C7R8QrfGu8RvTSU4z0ks8Oi5iuYo0vAffm7rkoAY76hoGoyHofGTo8fl
         9brb6midJP0CbRkGe/rRTMPChlWyg00GJq1rKkiJy+qpW1hZ7rgPBdzTS02T/6QBlLiq
         L++d9b1Syhzvnl2xnXUOuIVObRY74U57HbjzNYrtNArYtI/57JKuRo447vY3GDu4i2hr
         BuHA==
X-Forwarded-Encrypted: i=1; AJvYcCVc6ju/M6Bv3/21ACHnY3ekhad11XoC0LfqMyXr8LFiGNHfXyrivRMdy/2mN/ULhse0qeXy/31BH9aRkrYn2CGo7kyez0B8Smnt
X-Gm-Message-State: AOJu0Yz0PEokSbWbcAXw9D6oaXNP+ujOGtbO/PEd2/GXxohyfkav/Jex
	VsW7lD2S7MRK2VtWdt7dGmjiqTixQNIKVAEEomMg9CTDJIInmPN0l0fa5dGNEhs=
X-Google-Smtp-Source: AGHT+IHR308ZaGEspAqgP81t4VcZnbrHzQuAvq2kTrqo5fl5Ooc3oS+Xs8YEpIAd9Z+hKeDIfW6QTQ==
X-Received: by 2002:a05:6a20:6a0d:b0:1a7:242a:cb69 with SMTP id p13-20020a056a206a0d00b001a7242acb69mr5648165pzk.40.1714333447066;
        Sun, 28 Apr 2024 12:44:07 -0700 (PDT)
Received: from ASUSLaptop-X513EAN.. ([2804:14c:81:903a:a3f3:f05c:11d1:1d76])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b001e45b3539dbsm18826374plh.41.2024.04.28.12.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 12:44:06 -0700 (PDT)
From: ogustavo@usp.br
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: Gustavo Rodrigues <ogustavo@usp.br>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bruna Lopes <brunaafl@usp.br>
Subject: [PATCH 1/3] iio: adc: ad799x: change 'unsigned' to 'unsigned int'  declaration
Date: Sun, 28 Apr 2024 16:43:24 -0300
Message-Id: <20240428194326.2836387-2-ogustavo@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428194326.2836387-1-ogustavo@usp.br>
References: <20240428194326.2836387-1-ogustavo@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Rodrigues <ogustavo@usp.br>

Prefer 'unsigned int' instead of bare use of 'unsigned' declarations to
to improve code readbility. This ceases one of the warning messages
pointed by checkpatch.

Co-developed-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Gustavo Rodrigues <ogustavo@usp.br>
---
 drivers/iio/adc/ad799x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index b757cc45c4de..3040575793a2 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -128,7 +128,7 @@ struct ad799x_state {
 	struct regulator		*vref;
 	/* lock to protect against multiple access to the device */
 	struct mutex			lock;
-	unsigned			id;
+	unsigned int			id;
 	u16				config;
 
 	u8				*rx_buf;
@@ -253,7 +253,7 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 	}
 }
 
-static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
+static int ad799x_scan_direct(struct ad799x_state *st, unsigned int ch)
 {
 	u8 cmd;
 
-- 
2.34.1


