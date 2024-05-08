Return-Path: <linux-iio+bounces-4886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF438C0183
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4841F27EE0
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A4C1A2C05;
	Wed,  8 May 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="GoSfd2Kc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971D1272B4
	for <linux-iio@vger.kernel.org>; Wed,  8 May 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183694; cv=none; b=D4nhdIKatpcmI/MyFsMY4cU+UjB/uUlsYVUV6nK7kLq4c07Ys8GFA12QAeKIk9J5quf56BQRiLdpL5lM6DheSiC4WNC4JMeWrhcjoXEO16gxvp2W+jzn7oAsPb/0xiwwv2OjysRzT5jXH2i4PFv4/a1IfFVhPgB3fXh1bnu4Z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183694; c=relaxed/simple;
	bh=67FLwdlJ3ZlCVVWJvSAKEdRVJLI+uE+69QodKFW5Jp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7YeRugHXdQcdAO3i9xgrPPr3nAW8pEAVNI6hBrN1tzkuayy2WCWeyYOW5PP72IG5bk6NGxTv2ZHqtxAK1fZ9pJE9hUWqc09N8lBlz+2U25KHLH5q9MDhS2Jas8iDMg7y/Jol8L/SBaF47pPtZ8oQn5uDdtUDYAoLPAR+UJH6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=GoSfd2Kc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec4b2400b6so39376125ad.3
        for <linux-iio@vger.kernel.org>; Wed, 08 May 2024 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1715183692; x=1715788492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71QkVWxefKtWOJvQh7xw6NSLvZ7cm1h/gVVo5ZLIUew=;
        b=GoSfd2KcKUCFpDAMX+HbE8scck/TtrTX9FH/7Lshf1YabDNmqP7N2uRmswjvquzEG5
         BXZP4MZqHkQFP5BgZx1mO9RMoCyUf6P+T6LN9DdpfgDsdnih2DnFlrm8Ta40w81r1a+5
         BPsA501Um3bfh30bSk4vYfpUEEj/aI/uT8XFajt3vz8awePBE4GnwBehZ/en0UgyxHLw
         nWbjxBYFC2jEyCvp9ZliZqqM+OWXJTh+qv+Y9PCXBaZ3QxZYNUA6cfXBu7LNxjQ7NoiQ
         YPvyeWT7aLCYnRD0x7quLAWpjwiCZchCbHMHP5nxVHQrYNfOQAq2NBOID7FXajG/yr90
         TVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183692; x=1715788492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71QkVWxefKtWOJvQh7xw6NSLvZ7cm1h/gVVo5ZLIUew=;
        b=a94rKWXu/0PfBKHRqFUhWB8gnnX+rWc/7uZ4ANNi3Mhmx5yIBFaET6W9S3YunzSawA
         mljY9DgJKVQM2Q6pMFDCu9yrbdhkuSdKkO9ysdayYw8WHzCd85OJ+HmWTLdHgW4IsvEo
         BY3jYahp78L4U9PbPTYwrgjxcqKXMVO/wiVk5MauZfNUBLe5MsHUFbOH6QfFFJ6n5snM
         Cfxxt/byHcH3XqYi1DclnQeWIQ88EAayAFeH4kLNNGbWoJbTrGISQwUcZFR1tAm/JfGg
         qYwBx94Aph3aJcxPXDYq0/gBXSwy6HECh9IQ2NCetXueimW0VcNk9MUW9OliqwzMmqeM
         QVHg==
X-Gm-Message-State: AOJu0YwoUQR6uOdWQp7nl9LDtpiTnlZRoYfrXvH3o9+isezyX18WFdD9
	DwpUWf4xSAOFu2GuDxSc0jVuUk1SeUH8nR17OAWlIxgiCetKNzefGqwHVLM718GHmabfyBCqgpR
	srz4=
X-Google-Smtp-Source: AGHT+IHDdjOB7s4M516Cs7xT8hHQhFGoJBwVwgzn5v7wMotbThn9OZyN0Ylc2/crXJt4ZDqZXayefw==
X-Received: by 2002:a17:902:eaca:b0:1e1:214:1b7d with SMTP id d9443c01a7336-1eeb0bad648mr29599845ad.61.1715183691872;
        Wed, 08 May 2024 08:54:51 -0700 (PDT)
Received: from hagisf.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e434923462sm12077238plg.50.2024.05.08.08.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:54:51 -0700 (PDT)
From: Fernando Yang <hagisf@usp.br>
To: linux-iio@vger.kernel.org
Cc: Fernando Yang <hagisf@usp.br>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Eduardo Figueredo <eduardofp@usp.br>
Subject: [PATCH] iio: adc: adc7266: Use iio_device_claim_direct_scoped()
Date: Wed,  8 May 2024 12:54:35 -0300
Message-Id: <20240508155435.183850-1-hagisf@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to the _scoped() version can make the error
handling more natural instead of delayed until direct
mode was released.

Co-developed-by: Eduardo Figueredo <eduardofp@usp.br>
Signed-off-by: Eduardo Figueredo <eduardofp@usp.br>
Signed-off-by: Fernando Yang <hagisf@usp.br>
---
 drivers/iio/adc/ad7266.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 8b03d4469..3fc34a3a8 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -63,12 +63,14 @@ static int ad7266_powerdown(struct ad7266_state *st)
 static int ad7266_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7266_state *st = iio_priv(indio_dev);
+
 	return ad7266_wakeup(st);
 }
 
 static int ad7266_postdisable(struct iio_dev *indio_dev)
 {
 	struct ad7266_state *st = iio_priv(indio_dev);
+
 	return ad7266_powerdown(st);
 }
 
@@ -151,15 +153,16 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
 			ret = ad7266_read_single(st, val, chan->address);
 
-		*val = (*val >> 2) & 0xfff;
-		if (chan->scan_type.sign == 's')
-			*val = sign_extend32(*val,
-						 chan->scan_type.realbits - 1);
+			*val = (*val >> 2) & 0xfff;
+			if (chan->scan_type.sign == 's')
+				*val = sign_extend32(*val,
+							 chan->scan_type.realbits - 1);
 
-		return IIO_VAL_INT;
+			return IIO_VAL_INT;
+		}
 		unreachable();
 	case IIO_CHAN_INFO_SCALE:
 		scale_mv = st->vref_mv;
-- 
2.34.1


