Return-Path: <linux-iio+bounces-8062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F34940E1E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB5F1F24520
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0392195805;
	Tue, 30 Jul 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSwSII30"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265118EFE0;
	Tue, 30 Jul 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332636; cv=none; b=ZJkEU6CPuJ2dHGZtnfikfgbinigpl8nHNo6zYOCupbBSRaFRgO5LeHFzZZwk1u5aVQsRkYTEYlkeJg0zmYF8r0A3EH6t2f/8BauMnH6eXpX0hAivETzG7/2mJMrhiFt4xBoaHX8chEvaR+dTGoE9So8Tnc+BNfcXy+XzSkBhXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332636; c=relaxed/simple;
	bh=A80x/1Ink67gXVDYHGhR3sHS5VmUIEr38y+FolF9DsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yi0qj00SQJHxMqkwvyjnWpeb01D31qVdAMyrVXa9wvHEA936BT5gk2m51Anwx+fTQnj5z5IqEORMHQhlkvB1BaKh63E3pzmwA5sZsX6rcq/YzQps4WWvH3+V96fhbdTSpmlBrzHD/It79m6QSaFtoNieuRV5Y680bhViOkx51no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSwSII30; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42803bbf842so32122895e9.1;
        Tue, 30 Jul 2024 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722332633; x=1722937433; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rif0ScxfI9sioiI9vQsnAaTOQ7QRRDfLNRlXIX8/URA=;
        b=MSwSII30ATwK8xRLpcS/d/CHRBays6ajEhdiCJ09zC/l7VWGZNfCq3a7V4asf/c7ZW
         qceOiOs2pBFe9Du9juet3iP3pKCtbBREoEbRAKIb+tdR9ToGoVL7duVHMeVBRDPxaQY9
         cnv2jQI6U+awZeMuC2m/bjgtWXAJEj3JJbc65MSG9FI5fFcIqlfO9cBTGEiiYitHiZpH
         g+dAYacgIlmexizk1aSWHNoUHTLKw1csVffxY2Ze9xOSqZhNavqPpbBJdQFgxLdeTcbp
         AVYjDwvxWnItyJhD/YIjOStNb+5jkpJF45tfN89B9T3assm24KZcFkHFa4h4gIBh+HTX
         weuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332633; x=1722937433;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rif0ScxfI9sioiI9vQsnAaTOQ7QRRDfLNRlXIX8/URA=;
        b=NoCDv7rX5FCiu53zH8PxjnVUPqfcHcgBLPOT9evWHgWYUTnfuihgkiTUS+J+AJ+IXq
         nsPNffLqCW2cbH1x1Z3OpeluJFLavwexXb9PuGTEVuL+QKtVMdeV8kvrQH/1Bx6to9fd
         RvYzPr9L8nDy3TlSG2do9mOkYJE1JkYK3E3a01ncB2s7T8y85b+Gr1yjHqArBIEvkxIu
         vtTzUGAVbhDuoNfSUd4Ph22WnXjVPTKNEhm5EdQ0qE6soLMkLMPxFMBWufvjRBrjb9Gc
         sSSZhNB7WL66crHDD2tFOxkHpAp+kahrcnEDNz37HinXiR+thaWFHKAVfAekLL099jW4
         jvtw==
X-Forwarded-Encrypted: i=1; AJvYcCWWJTuG5AmXTls41eUyzTcSYJT83eZUJIJzsmcb8SN+ToGmt3z1MkOggm+fmrGseIEmjdW/VhhNIMqkzfzL1eCwarZYAE2TTy55q1mJ
X-Gm-Message-State: AOJu0Yw0Ord5iiYmw1Keax3ioRf8HWp2r5BM4MjzhopwjC6YjQ2dC1Ws
	jzjO0vQ4EtQycv8JecS2A9RHn7JnUDZk5ZCLQs6ZaqwoTEE+OkqC4SvJBszu
X-Google-Smtp-Source: AGHT+IGOIgO15lMgF8zOuvqsyofiyO2xLW7TS7Y645+UHjFfUedcjXtR8fPTjl6qNS8G/P79ptqWuw==
X-Received: by 2002:a05:600c:3c9d:b0:426:6ee7:d594 with SMTP id 5b1f17b1804b1-42811d77889mr82727835e9.7.1722332632929;
        Tue, 30 Jul 2024 02:43:52 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282113ddbcsm35992715e9.19.2024.07.30.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:43:52 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Tue, 30 Jul 2024 11:43:49 +0200
Subject: [PATCH] iio: remove unneeded assignment in __iio_format_value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-iio-clean-fmt-value-v1-1-3e1c3deafc33@gmail.com>
X-B4-Tracking: v=1; b=H4sIANS1qGYC/x3MQQqAIBBA0avErBswM6KuEi0GG2ugLLQkiO6et
 HyL/x+IHIQj9MUDgZNE2X1GVRZgF/Izo0zZoJU2qq0ViuxoVyaPbjsx0XoxdrYhoyfjSBvI5RH
 Yyf1fh/F9Pwg7PvhlAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.0

Trivial cleanup in __iio_format_value() for the IIO_VAL_FRACTIONAL case
where tmp1 = vals[1] assignment is unneeded and irrelevant since tmp1 is
immediately overwritten by the subsequent div_s64_rem() call.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/industrialio-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0f6cda7ffe45..9e364f9879ef 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -667,7 +667,6 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 					     vals[1]);
 	case IIO_VAL_FRACTIONAL:
 		tmp2 = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
-		tmp1 = vals[1];
 		tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
 		if ((tmp2 < 0) && (tmp0 == 0))
 			return sysfs_emit_at(buf, offset, "-0.%09u", abs(tmp1));

---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240730-iio-clean-fmt-value-9c5a42d4fa24

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


