Return-Path: <linux-iio+bounces-9801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B23498774A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CA81F292E8
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79AD15FA72;
	Thu, 26 Sep 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg96h4Br"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9615CD60;
	Thu, 26 Sep 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366931; cv=none; b=dlmtddafcLAFmF/lopHaSm7f0k5fEgLTpRf3YCJOGDPvbr3ZZ9Y190t2n3vbt/1JFNiUJvE9xYb+Vfy72r1JI1h4Lqk58IXtwqkzW94lZ4L5SjvoniEPo9ZAg1DzhbvMUsjqpFZwrkglm5wqMKygHxh+XfzkOhvFujKWzmK7aAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366931; c=relaxed/simple;
	bh=TlZo/sfYlYA7rfrWUOIFpqQSC+0+ci/zValTOgfTA5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JA3/0DN7kusrGy7GSoMp0eyf9XS7awPmfOIAzbM+XBJDLIma7Po+r/hxtTUJrppFQw9cuNe+5ccnjrMb1oS9n+d+yuhFJx7pvcoD3tJsaAVuxKh/20GC1izJCvxoqQtbzFIkkXkdkB+SaJ4YXr1WDlNTws6lGmh+C/qqEoT5HE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg96h4Br; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d24f98215so160952166b.1;
        Thu, 26 Sep 2024 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727366928; x=1727971728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5foGMs+KnPV1j1E6JrJyJnRmk35vw0P+oTGPUMwklc=;
        b=Xg96h4BrnX9WYXERIDSB53vO9sLKmt3TO9zL+vAtGksCEJfuIgHnU0lbPpl5f13iZy
         Hp1yCWgOpoIXKqIHjwC2CCF63r+qGixA6r7PO7dc4AWn9/kI24XkNd0PBjYI8oVG4MpM
         eh7ESHW162KPG9lrO2kNYnWX/6lD2hhRur4XfeKibrODJ+TNN7SK3alxrWCfmjr7tdoJ
         tzskqs2Z2PMXoNPpfZdSFGqpe0yPjPFuBUR22IqEyC/Yv34c6mdpS8FLui07heLXycDV
         keKd+wJ4n5X3Tr3HJVjMOCu5IrAVuROLScs5b8ljH53RS/lyMqhuvKLNVxKYwZ4SSZy9
         URqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366928; x=1727971728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5foGMs+KnPV1j1E6JrJyJnRmk35vw0P+oTGPUMwklc=;
        b=ibWD4VkVcOb6stU5pzluK7GIAlMTa/gbXQQOkA5QRmKsAo6TDZ9dYyohQBqI1geOX2
         NrNXtNdhJ9vwBegHmXpOLFPJMk5Qt+1K9heuUCXoxr1cmXJFCnZAPhvMiyrkc+p2fuSf
         LL/yvdlmctWdZ3bQHQCQyrAkP0tVzgvnv/J5f3PR4T6Da8C3XXNtcuXP/5CDNX5VMRRn
         mNBaQrdiRIyAb3BQCTJzAa5RQohYjeE/9zHLVwlZd10kbYyCsLXlEkmBs83qbsTtGM+8
         xn7qxdqZVlSNfN14LMYAIt3pNakr4nEXNw6gWwn5dyTPLNV6oXyz1c2vTaMLH/uIoQJk
         V9aA==
X-Forwarded-Encrypted: i=1; AJvYcCX2mI5zLhj9zxIJU9S72OypVcXZV5dLr/9qSOn+cZghFvKelUC4Oaxh27SzSyaEEtblDqxFX/Yx67l5+CCe@vger.kernel.org, AJvYcCXctRj9axRQZlqXuHre+KFNMr9uTuBsZAmt8gNzB4NBlwvIElAxIuTw9qo+l1yy1rMqIL/LRnl5010=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5hiCajuIMoSzEYMUViaUJJCM24XMX6Xb25FU7I0cdWMWdvpf
	OGxRw11IDtzG4zhNeTSogK6Rt34IGvV9ugEFupohGwE1s/NVuzrIC2QiZ4CA
X-Google-Smtp-Source: AGHT+IG8rSfCQ1OjrEgIGoq/mqJNnCJSIS953PFQJ/ktEiwAsnotpjZqlq72ENG7UQlOBtBc3cSxAQ==
X-Received: by 2002:a17:907:3fa6:b0:a8d:3085:a7b1 with SMTP id a640c23a62f3a-a93c492abdfmr1068966b.38.1727366927568;
        Thu, 26 Sep 2024 09:08:47 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6d88-4cd9-a9d4-f267.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6d88:4cd9:a9d4:f267])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70d3sm13947966b.78.2024.09.26.09.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:08:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 26 Sep 2024 18:08:39 +0200
Subject: [PATCH 3/4] iio: adc: sun20i-gpadc: use scoped
 device_for_each_child_node()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-iio_device_for_each_child_node_scoped-v1-3-64ca8a424578@gmail.com>
References: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
In-Reply-To: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727366918; l=1419;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=TlZo/sfYlYA7rfrWUOIFpqQSC+0+ci/zValTOgfTA5M=;
 b=osh0N4BGJ8X6iPBsv2lwnI+w/XSuQcRZonFjjaGdfwgJtIr0AXEz6v13uyuHef+dxe3n5rN+z
 f8Z7K/XNIOHCJeKtha/xtrGWD/+0tKPLs29XzedI9TTKVHHjK9RDI5r
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to device_for_each_child_node_scoped() to simplify the code by
removing the need for calls to fwnode_handle_put() in the error path.

This prevents possible memory leaks if new error paths are added without
the required call to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/sun20i-gpadc-iio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
index 6a893d484cf7..136b8d9c294f 100644
--- a/drivers/iio/adc/sun20i-gpadc-iio.c
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -155,7 +155,6 @@ static int sun20i_gpadc_alloc_channels(struct iio_dev *indio_dev,
 	unsigned int channel;
 	int num_channels, i, ret;
 	struct iio_chan_spec *channels;
-	struct fwnode_handle *node;
 
 	num_channels = device_get_child_node_count(dev);
 	if (num_channels == 0)
@@ -167,12 +166,10 @@ static int sun20i_gpadc_alloc_channels(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	i = 0;
-	device_for_each_child_node(dev, node) {
+	device_for_each_child_node_scoped(dev, node) {
 		ret = fwnode_property_read_u32(node, "reg", &channel);
-		if (ret) {
-			fwnode_handle_put(node);
+		if (ret)
 			return dev_err_probe(dev, ret, "invalid channel number\n");
-		}
 
 		channels[i].type = IIO_VOLTAGE;
 		channels[i].indexed = 1;

-- 
2.43.0


