Return-Path: <linux-iio+bounces-6123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF59018AC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EE51F21067
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF516F30E;
	Sun,  9 Jun 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1LMtBrU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E386F2E4;
	Sun,  9 Jun 2024 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976319; cv=none; b=p/MoPAz1aslsOX1x/f641SnlKgIS8EbU5ugHm/xW+yBPT/adVOCZ7C5OGNdbYzmZDgQXZe/uV9aZFnXzVo9mgeRpyuLZyIAjiAeSM1jM/k/ipQfgNkaFSUX04vRKriQAMnABTdXzkdpCYO0Pxg3FMpCKlWtvvl7OK/BPNo5Tagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976319; c=relaxed/simple;
	bh=cnxU0cW6dA9oQSVUNgyXnbAhbuPZ6Vqr2TOidKbqI1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uFCsaVQGSof7H7ZOibQlcNL7k16O3QVXYZWbMF1VJoRrb+iybkI2QG46sS7E2ONMQISpfsfm5XfeQEh7GQKuhuOM9inUa4B06Bz9o51iMGmFP4XxK8VFriL1oCk+BZC5jb8vn676S1pz3XFzAqo6POubOZFYnf7c6ylQyyTn4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1LMtBrU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f0e153eddso134519166b.0;
        Sun, 09 Jun 2024 16:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976316; x=1718581116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQsAiNQAz1Nxjw9KXQ8hkttK+NyE4llnx54ninYy8Qo=;
        b=e1LMtBrUz6P5rV3fcWXBYgukJgwdu3dedgz+mA1w/4q+T7JINrUMy6rxyAUmViWIAv
         y+Me56X1zJ8FQcI17CdM7RYO4Oc8fZ84m1H9m9NrgTjXSLrXRKhxwAfA4RXd7x7zYW3B
         q4F7o5PZTSyKiinG/EdQQpWWIPpi0jtcV8XrZjB+wnz+yHxuo1OtiWDWK8T4+y3PHxAh
         18YVdrbe+xn+z1hgaicENyv5PXRWBIbc5QKOswy1cKgJyi0FeQ78EzVXUSZJ/0cWIZmo
         ZNrrJ8CIdqWbebklNHruC4xIrkzHYgPyPr0s2oCMwe92gYrNaw6/VrVmTb24L1EbXHGn
         fPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976316; x=1718581116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQsAiNQAz1Nxjw9KXQ8hkttK+NyE4llnx54ninYy8Qo=;
        b=KOb2fSoQUlxVYz+5i1lniP/a4HxmTSMjZz4+TG8GARNHZJW9WtzI6m2iNr3znwK50x
         tqXDBRtDrv5HLjrJXDAZCV2FvKIYR4vIx3uKTtI3doLMkvGyQUv0I3+bz+EKdiRSLz4o
         AAprRWFRSepfoBsQZUdlyjgEa3VhGv8XnUh1JjgQkZQibpFEMvwzgPOM89larirn+FNd
         g1Iz/BkGgglrCpn1E4uzq47Hl4uXhzHMgKXCu8FkbYVR2vLSeUrulaTxoI6p/4wghk+/
         REJ598t04PfSbYIVCfX35SBJGDFHH5OX3ataeQSbkM20j5fg8J/cFzr5fOU5Q0Na09ja
         TrOw==
X-Forwarded-Encrypted: i=1; AJvYcCV6KfDafBwoSuGJ2SgggiL74gQ6wOFW3ogIEExI/5DdQAoRtztPqw9VlujP4GUML53Rig8yXZBLXqoUK6I4DB6JNpMv5JEIRxzGGfckUvW4fys7NGVXJyK7DsaUvOwxV5CXc4y10WxE
X-Gm-Message-State: AOJu0YzjBP6M+70BFiLBZmDTBStBA9zDRzw8iNlxPperZCukRy3QHqhf
	1pW0iNODKHeTxdQWk5UnvkzkjNgdLLhyNmGG5wWCo9zSqp8uteYk
X-Google-Smtp-Source: AGHT+IH9+BrmSmP1hF31a7kEHkjR6ax2MqEm0uMeHifRntTEjHYX/z0ENVV/SA+E47tueImsfbfm0Q==
X-Received: by 2002:a17:906:a38f:b0:a6f:1e88:37c1 with SMTP id a640c23a62f3a-a6f1e883daemr83063966b.45.1717976316007;
        Sun, 09 Jun 2024 16:38:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:35 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 05/15] iio: chemical: bme680: Sort headers alphabetically
Date: Mon, 10 Jun 2024 01:38:16 +0200
Message-Id: <20240609233826.330516-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort headers in alphabetical order and split the iio specific functions
with a blank line

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 1d2d5920fb23..72bd5445b6c0 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -12,9 +12,10 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/module.h>
 #include <linux/log2.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-- 
2.25.1


