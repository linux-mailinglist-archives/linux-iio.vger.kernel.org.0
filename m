Return-Path: <linux-iio+bounces-6245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D8907745
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28B928E3E9
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE75158A11;
	Thu, 13 Jun 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Hxl9q5jU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CE157481
	for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293224; cv=none; b=P8WWZYB9M9M+WuEgwZczUP/Kq7j5Fi08e+e/slVytDMcIU7anU2YRzd/0bxk688XDuSIZHXlCK+YFsBh/VIUfEF0lbrH/BoXdGjV0e5X2OSYIebeWi9BS3RA7xQ7cRTwQiKpgQ9DPibaZ4jCtVqDJwEQ/kZVRfkQUxcSBPLKOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293224; c=relaxed/simple;
	bh=luTdfy6sKpLBoXjaLPwr0uG5veHniFZLbNHB+TAySsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpEVS6OYsMjoKW05zB9YivfkJqAmSkOi3meI/0gofbCQ261vcF9aJsB0hMVqc2+NdFUxrxlhGI39ZqzHiFHZV5w3bj0siA8jdOkyBYPhW1+w7TwMfBX0KqeiX40PiuwlnJ/zuBCM+SXwE22P/xtRX9qgmjSkTt/pbmfYOGhs5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Hxl9q5jU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f7274a453bso11048645ad.2
        for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1718293221; x=1718898021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QnxyApbFpsfeddwm7SZRHJYhBcPxd4u6Vyq+8HPgcs=;
        b=Hxl9q5jUnTZ88Btv3enxD4p9Q9zIcloHJOPGjK1S+8kABgLWpT/trON2eTva/XTGgh
         QYNEOjEjrMdWaUi8UyAPo7W/IAQfKEhe/xI5AA0RB0KFQaMiCq98CBXnBm4oG0//bGT/
         lFY0YkjdTQumHArgsWgGbwEvMqp9gkMJdlVM9wABagjA55E1CT0DOQ1V/l4PP7WexUgQ
         KPKJllkm3R/EtfqbAnAn1DRKDlfM+ZAA90ag2r3u8UM0yOisd+EH/OxjwW0NiBcUY8fc
         w+gAYcXA7ZJjfMsyQhvJ4m0wWWBsQ1OfoKRo9kVYj3Ku3hKLiS7qQYMHx+aw11Gq2wN3
         +dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293221; x=1718898021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QnxyApbFpsfeddwm7SZRHJYhBcPxd4u6Vyq+8HPgcs=;
        b=dQXwslS4ncjrLJVEhp51Ez+e3c0ETItQmehl7ALpQJ55Th4vXqyAKcyXBNuF9p7Yaz
         VbmR95DOK5+SJSHRJpHLyR+KVcV71jzsdJvZoC7pq3AcbchkQ8ld4b6b5LUsFdtKysC0
         M7pjIswO8GaBujHgx6SszyKJY3MmkxKmzcHuVrbkkt/naOnbXFIWcEnKaQkMWVnu39ro
         MwiDCxpYwpNulYgL7HrdY4/+IGS/szaEFqTOGxmMwcRTBgtX9MduXWAAbaY1ZI1/+dk1
         tV3ieuBCuo28q58r3aD8LHdC0sx7HngFgKIzRTmofx3ChaZ7ARBhdkdcIgk0CEo92zJz
         enoA==
X-Gm-Message-State: AOJu0YwLrJCAWzM8HeyXWltVxwC9zMQUi0G57TrS3tfPUCUkQhtpvzp4
	L0ir3F6U3s7VIVGtEtYj7NQKvclw2D98+eOp+hY2fmjK7b0txnnoux27bDYR2HNUD2k5tOP0GpK
	f08DpCg==
X-Google-Smtp-Source: AGHT+IFr8ScroXppMtVTmGOaP6xmMJ+P7AsudyUCgjWvGLn9KnczJTqyHGmsMiv5Ct71f+ag83pAow==
X-Received: by 2002:a17:903:41c7:b0:1f7:2849:184c with SMTP id d9443c01a7336-1f8625c64d4mr548535ad.6.1718293220954;
        Thu, 13 Jun 2024 08:40:20 -0700 (PDT)
Received: from hagisf.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55d7dsm15372295ad.14.2024.06.13.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:40:20 -0700 (PDT)
From: Fernando Yang <hagisf@usp.br>
To: linux-iio@vger.kernel.org
Cc: Fernando Yang <hagisf@usp.br>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Eduardo Figueredo <eduardofp@usp.br>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 3/3] iio: adc: ad7266: Fix codestyle error
Date: Thu, 13 Jun 2024 12:39:20 -0300
Message-Id: <20240613153920.14647-4-hagisf@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613153920.14647-1-hagisf@usp.br>
References: <20240613153920.14647-1-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some codestyle errors indicated by checkpatch.pl

Signed-off-by: Fernando Yang <hagisf@usp.br>
---
 drivers/iio/adc/ad7266.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 356c2fe07..5a2f1bb27 100644
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
 
@@ -153,7 +155,7 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
 			ret = ad7266_read_single(st, val, chan->address);
-			
+
 			if (ret < 0)
 				return ret;
 			*val = (*val >> 2) & 0xfff;
-- 
2.34.1


