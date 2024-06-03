Return-Path: <linux-iio+bounces-5703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9A78D8871
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567D01F23EFF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3460137C29;
	Mon,  3 Jun 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="vlRyclgk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512D135A46
	for <linux-iio@vger.kernel.org>; Mon,  3 Jun 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438118; cv=none; b=qMKk4AFl0od3CLrcVKgp1+iOKlrL5avLbQDtrIPG1NvCawL0uWhTEv08HSwW5MzlSkq1mNoZT6lZsLVr/qnqk/phWtSdVIR4J03tWTcHw2fd6YlvH05faTviKPcwPuaP/ewUyMG0XIq8D+6pWmvGUS8Sj39RMn2rdRTovPLYJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438118; c=relaxed/simple;
	bh=IijKA3D+a6Ck6QFUmUSSDA4GuCjoOG6/L7B6oXI9/xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1y/G4cMI709mS0wvNDHNr62uN9IIY/GCpv0B/Mwj25+zIfLdNyWf0CPwV48ZPSaSQ+Z97zRvbzNWvhjLOYi7D7fL7TjhMKBk4RWVL7MjV9FXCFysDAzHSG1hEcgd3bVwlHV2uZwcLBowBuAw5RLbfqHdqsAxR2R1AOJItrVZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=vlRyclgk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6342c5faaso2002325ad.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2024 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1717438116; x=1718042916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3qrbNSpEHhzlXzlPZZe6eTX+nvvDfnBMz6EY1ye6j4=;
        b=vlRyclgke0ztbon2XMuQXXP610S2JMoil6l1RPIC5tp3GC3qDYa1s8BOevtMofF0/r
         UVrEWftuhgzrbKk+OiKVhuZAmiL89GGW6ePUK0ZVXPMJDUF/3y1fs7gclac+lJA4mr+R
         1FK0IgtUj4cklnJvEuVSvGYogE38zoWKXcpyW5zhPWElXED08UboxDz5bigoOESi+eyM
         5vYDcBnX/AgLehhy1w6g7fO4+K5eNKxTFUysRBcAufEaL6Ddc5P7IUsgOvr5PzZQTKBc
         8KXmqR8fL1gCMl4or15PlqXksj3Zv7Atlp4HzDnjo8XAXOqEjEI5mM8c739Y+wYUoPw5
         Y//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717438116; x=1718042916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3qrbNSpEHhzlXzlPZZe6eTX+nvvDfnBMz6EY1ye6j4=;
        b=VFWW2KS/jKDkL14VVcKaUmmcF0ZtFL1sJj09cE8ubJzPEt8nIn0sxGqlspuHWKHCD/
         uWtgopevBugaEn/ZG3BWxWnLT8gfhqucS0hQ2d4zddnp0Fl9GXKmT3t4IVcqfIr2c263
         jACOYKGygtz1uwwxHdisWT2J7ZHonhGEtr7oDXUZuOB/XCFofVUG9VVRhfRRREnAUmnn
         kxXjQ7BDiRAVs5e1aObySVuIdyJc7PdNbKnampjmUz2+3ypow6Ts1ooWPggf0FQWqdt2
         f9zewlZWhk+OlsFqDMeN42bSOmiXsyjkAjRJ3jyXTBSMJ2SSWjvOmpdfnZk6g/4DnyAE
         FCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn3vD4UPlqcL+Zg3adiVGc5q49NYyXg86OaIWJW/9aEXxcyNjRZb4WgNcp3fDxU3xzHTMQ3laJ4dHpIjeMVhyLv3BnE2wY6tjV
X-Gm-Message-State: AOJu0YzQIsl+5zibJO9uo5lpFeUcvmBlYH/iQDtPP4dAz9/enYSAU+Pd
	2OXVwQfM2n2YkM34/tgvLhby8JHeuMtkhmbR3OYuu7J0iTC2RsUqiYqGy2NnH1Q=
X-Google-Smtp-Source: AGHT+IGgAYXsWbgaPZbOrvxv8XVm3xyI/58C2q13i+r/7qQws1j2VW6tirCXU/rjL3hv/zvBwWLX+A==
X-Received: by 2002:a17:903:2448:b0:1f6:673c:ff2f with SMTP id d9443c01a7336-1f6673d026emr60379595ad.68.1717438115948;
        Mon, 03 Jun 2024 11:08:35 -0700 (PDT)
Received: from hagisf.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241c39dsm67348985ad.297.2024.06.03.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:08:35 -0700 (PDT)
From: Fernando Yang <hagisf@usp.br>
To: hagisf@usp.br,
	linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	lars@metafoo.de
Subject: [PATCH v2 2/3] iio: adc: ad7266: Use iio_device_claim_direct_scoped()
Date: Mon,  3 Jun 2024 15:07:56 -0300
Message-Id: <20240603180757.8560-2-hagisf@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603180757.8560-1-hagisf@usp.br>
References: <20240508155435.183850-1-hagisf@usp.br>
 <20240603180757.8560-1-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to the _scoped() version can make the error handling more
natural instead of delayed until direct mode was released.

Signed-off-by: Fernando Yang <hagisf@usp.br>
---
 drivers/iio/adc/ad7266.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 13ea8a107..356c2fe07 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -151,20 +151,19 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-		ret = ad7266_read_single(st, val, chan->address);
-		iio_device_release_direct_mode(indio_dev);
-
-		if (ret < 0)
-			return ret;
-		*val = (*val >> 2) & 0xfff;
-		if (chan->scan_type.sign == 's')
-			*val = sign_extend32(*val,
-					     chan->scan_type.realbits - 1);
-
-		return IIO_VAL_INT;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			ret = ad7266_read_single(st, val, chan->address);
+			
+			if (ret < 0)
+				return ret;
+			*val = (*val >> 2) & 0xfff;
+			if (chan->scan_type.sign == 's')
+				*val = sign_extend32(*val,
+							 chan->scan_type.realbits - 1);
+
+			return IIO_VAL_INT;
+		}
+		unreachable();
 	case IIO_CHAN_INFO_SCALE:
 		scale_mv = st->vref_mv;
 		if (st->mode == AD7266_MODE_DIFF)
-- 
2.34.1


