Return-Path: <linux-iio+bounces-4042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35F189823F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 09:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC5028A7D1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497C5C617;
	Thu,  4 Apr 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLoRveDt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2A59B67
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215893; cv=none; b=hxnrzqT59wd0mZSaDQCPUF8HMqLEQ+SS2cdOjTVkBu0VcJZbzhlq2ZV/KHmJb3ljB4RIgAVEzYgVRMlwBlyBlYLgWBThtM6DV1vL76OYlZnZ98+zFL33/9rYLVGpaE1ucMYl0W11y1jTw2NGL2t9kwlakCrfvO4lLMfoyAQ+lsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215893; c=relaxed/simple;
	bh=x17VF50RIaiujAGFEkbgo9dxnFwks9NYWjbB5c3Tc2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GBwST/hmzmQmUy7/hGvFc7W5pogN6zqwyuToLvDH5s8sjhME8A3zyMUGsQ2mZ9xTUU2XEtmndALAizYAtUEA6BJ9Hys+Q0aqp9fGJPxdG55VvfNZ3dwvsrhPAcyHbvnvE8Yoq3k24o6iGOfcMwGEI1sRM+7SfebnR3QwSr5g+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cLoRveDt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4702457ccbso82492766b.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 00:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712215889; x=1712820689; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nagW+znroc/OfL52MgAnoYd2vnMcSa+YACeZquseEA=;
        b=cLoRveDt6Xcs2//vNNsJJDz/Ksyf/P2XtIIgn5OvkMzPR6vw9roM9tLgrqyUIZs18o
         hETv1VxH85Z/HEPs1SeaRIckQa1shdmlbKjW/HB0PQja/YBwTK+fhDVQSsE67n8/o2Xj
         piAA/ntpNBW0jqmxlC++fWjM1pUjTq08MK/ECdnb+cG3Nr9JUTpErJe+Y91dpFhFLice
         x7h0xmunzTnc7XvLVF77jwMpR6/qjYUCM8XbYLMV5pS6IbLtYza+rriGmQXmlNdAbY2B
         dYHhabkPJPUAcrdTjDz4+KJh64Gq+VB6OdpXqFOa4QSdwliNs8dJn1I9yW60GNjnJ9GH
         GJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215889; x=1712820689;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nagW+znroc/OfL52MgAnoYd2vnMcSa+YACeZquseEA=;
        b=aqly39z9GUBgNtZuah8079ztvo1P/0I5cYVLg/01HkZoBrtPXwoesX7R/1IdX+8ZDQ
         RpZQZw7Wfr8hFlLLSHmdL0C0jc1/BWs1hoSEe9b0eaYtM2WZdZeXKdBJzJnM1s9XGYqs
         sHLNNzvE8sXxefCD6zO0WCpkG36sfm2DiSOwfhZtg/LsRjBy+nlqqUzlts6hLYBSWka+
         GZjoWg3E9dtEUp71fapcpW9PiUeVbnm1tkMlv0FRmPGmrEzFKAnOcgOyK8zuJ8Q6z1gD
         6SDyaklQ80A2sXlvU2Kmp3tbgrDEPfKKsc0VRWFBJxuy1T0HgeV6IRGNsHzvKJOS9cVW
         /0yg==
X-Forwarded-Encrypted: i=1; AJvYcCWd5zXzV/gqbnY5jGVfFSyoYD9Ars8hdDt3wg9kgqUVqsEowVM1WCkiLto221qLh9I4CeH/0Bcf0S3k37mJDU3yE/eQsWJB/gDR
X-Gm-Message-State: AOJu0Yzu9K+XDOVBYZhU5y2Wm6WU9hSiR9DXfPl48Cu8ZOhUFYQrTURF
	AjbkrdUtCmBPCsLHrDTS3OYvFQ4Dnoupn5bYykYUuGLbdUE00OxXt56zIg6KzQ0=
X-Google-Smtp-Source: AGHT+IGzBh2iG+Vmc95MoF3Ag2rfD+mNc7xgJWU6eA1zCJa2kyRkG0BtuPfxYYIpOzDodFxmVXIKQQ==
X-Received: by 2002:a17:906:d0cc:b0:a4c:de71:54f7 with SMTP id bq12-20020a170906d0cc00b00a4cde7154f7mr1003742ejb.27.1712215889298;
        Thu, 04 Apr 2024 00:31:29 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id i25-20020a17090639d900b00a4df5e48d11sm8710443eje.72.2024.04.04.00.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:31:29 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:31:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: light: apds9306: Fix off by one in
 apds9306_sampling_freq_get()
Message-ID: <69c5cb83-0209-40ff-a276-a0ae5e81c528@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The > comparison needs to be >= to prevent an out of bounds access.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/light/apds9306.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 4d8490602cd7..49fa6b7d5170 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -635,7 +635,7 @@ static int apds9306_sampling_freq_get(struct apds9306_data *data, int *val,
 	if (ret)
 		return ret;
 
-	if (repeat_rate_idx > ARRAY_SIZE(apds9306_repeat_rate_freq))
+	if (repeat_rate_idx >= ARRAY_SIZE(apds9306_repeat_rate_freq))
 		return -EINVAL;
 
 	*val = apds9306_repeat_rate_freq[repeat_rate_idx][0];
-- 
2.43.0


