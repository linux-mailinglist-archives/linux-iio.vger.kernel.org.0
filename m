Return-Path: <linux-iio+bounces-12657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D19D8DCA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B11287BB0
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2FB1CDFB9;
	Mon, 25 Nov 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjEOWQvh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1561B87DE;
	Mon, 25 Nov 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569391; cv=none; b=floTp0Hji4EUIcpCcwr0G90XJuj+5m8o+i81k/HTenLOjQA+58V/hLL77mYOAljRZ1GHhrkjj0bb6MAT76Xi2/tSzGZguw/qadI4HaWQnSriV/PTf0rpdVIsEK/5epvqrm/FZO1eang7PCnaiGZJMSXtrvAfAimhbPC+vl8BltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569391; c=relaxed/simple;
	bh=mky5t6OVnnN5KSTL+/knjrhqywJ9YZ/nDMA6VraN55o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1TqcJ56wx7na5Pp/l7NsoiivtAoJWKX7Mx6ONNjjanyi7Z5bUI7PiAJ9ETrNHmySUQhvnjIpgUy4NAb0dl6A/uE2i6J0ktSmxWJcBV5qaqQHrdeHhO0iZR6g1Nk0ZcvncLqTUqRXOCCMx93FJd+Xc253yV3Zyu2pXGuDk3SQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjEOWQvh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so10002655e9.0;
        Mon, 25 Nov 2024 13:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569387; x=1733174187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPJKlEpy09f5A3MUO4c7FtHTuEX/b1bW7cXIwya/EYY=;
        b=HjEOWQvhXXVtA5GzNQEsOFN+dX8TTAjyTB9Xd64fl7K3QGqBc8OAMpu6Qf4nwOqqY1
         xbN4p1qJzWlHbvkA4bkbNybviuoQb/crpMff20YPSflfVt0jHkFbrNIIZDNtJ/0D2DQm
         GSRJtH0maV3awsvZa2cWNrq8NIsIXZs29WWpObEuVR2IfhiJdfqXAfVwMb8dE1dtwoWn
         65W/4uBY7cR4CqFzAc31x8wrAGB5x95SEtO4VgIl/k/hB1MvQsbojF26qLzanW4gxMGP
         DYklqVH6pIxyAsbMFEcmQJJE+pkq1ouLrd/nCcJQUR61/6XuCTZspW6O1ft2lQNw4zu7
         oKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569387; x=1733174187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPJKlEpy09f5A3MUO4c7FtHTuEX/b1bW7cXIwya/EYY=;
        b=YLd91wKkiBbeLzwum9IDlVrAwdjw+Y49NZNVFeRpVk22hE3c83HAMcuGXPKI+SciIY
         z9h/4hR0NbfSByp33qSffQV9fCfWhMBC077WrfAJhevfm6Qb4AWVN6ZyRIY1vWmwL9Qe
         l+AfClmNsok8bOmgEhQAIgOC6Hm8F6SqrPttQgDkuKxGcp3IM4PppDdg79PGjb6fs+h7
         nYJqo5CxtlQQTow8uYMnPVl8LByA3D7Tr1SYPOs75uyTT2OAfTcTv4rY0PlFcI+WFpl5
         WYodwR3rt0L7Xk8k6pG2WEiLTVUD/B8zdw/7SzrI5x/eHCZbfEhIZJ6jgpOq/1fozeIo
         ewig==
X-Forwarded-Encrypted: i=1; AJvYcCWWOmkD/851TJHJNQB3HSbyKr+KAaevgVPIwWvGqjw0jV3LLtspBE2VMFJAVzgpZ4sVC2CjpGaUzJSTwblO@vger.kernel.org, AJvYcCXXiwlNujLyI2iVCnZ8bXe3v0PacykfKEOPk/h7d4GcROhUj4PqYgGdh6rEbKUd8Lq3ZjxTR3Yq@vger.kernel.org, AJvYcCXXwdAtEUalh3t2K6gcqN0xXVZZkAg/Q0N5Z98dlfQniLA5/qYjKfHWSlgo0shBhREnrJcxf57c+oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0cTB98SSp1Kdn/gB6+ko7otCiDW9Winm0wSkmJpdBzzgy1w1d
	bY6DZ81sop379OmMQDn1ztT2rhmoBvmJi3G/53UtTX2w7bfxVPQ7Sgg1fQ==
X-Gm-Gg: ASbGnct/+iEpaeB+lPgx9YTquPUCvpR8XL6MAQAAtlCwanLpAoj8zIon4g7m9uSQwFA
	ZWPXHlY/NkLi57GCU1vod3bClU2qYWCxiReCgAf/XaVtHE0KeoGYBhWwHjbeBotQth2TNhFIKRi
	j1END27KbDhD0Q6VkgSWsTZ/w3X/yvnwWB7cmcVv+eDAfXbqRFCk+KcPFgmck2Dix46o7HPGHDA
	6qi2z6phLrid8Y0/QHdQHalgf9dj2UYr/H4visfoMU4G+ddbtc9NTHKZW6R6mOXrMB42KZwDRYg
	xm5OqG9UiVms6Xt79Ymzply+JpuabmyiNnrOGHQOwvn9PV8D1O7keUDZ3aTnqghbau45TYvh
X-Google-Smtp-Source: AGHT+IGXvo6/HesWOJo8z8xBQeH4nF3NPR3rw/5EfVOfeXRbHMQBm0koGCBH4J6+3xyx01TCHHWWKw==
X-Received: by 2002:a05:600c:5102:b0:434:a1e7:27b2 with SMTP id 5b1f17b1804b1-434a1e72a53mr24819125e9.7.1732569387109;
        Mon, 25 Nov 2024 13:16:27 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:25 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:12 +0100
Subject: [PATCH 04/11] iio: adc: rockchip_saradc: fix information leak in
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-4-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1023;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=mky5t6OVnnN5KSTL+/knjrhqywJ9YZ/nDMA6VraN55o=;
 b=6PKyUN/+3xEMCqT2IYN8asZlTio7xMSNP8ixqekU/MLeVDxNEUjrR8zco16lBsIaKdv2lVf1J
 NaFiPm62e5HCPbjbd2jOpYcfkA7lgpdbBBoIE/Aw33DoJ1ald9m3CGM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'data' local struct is used to push data to user space from a
triggered buffer, but it does not set values for inactive channels, as
it only uses iio_for_each_active_channel() to assign new values.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/rockchip_saradc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 240cfa391674..dfd47a6e1f4a 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -368,6 +368,8 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 	int ret;
 	int i, j = 0;
 
+	memset(&data, 0, sizeof(data));
+
 	mutex_lock(&info->lock);
 
 	iio_for_each_active_channel(i_dev, i) {

-- 
2.43.0


