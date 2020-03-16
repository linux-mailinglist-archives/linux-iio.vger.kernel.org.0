Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F22186F52
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbgCPPvn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 11:51:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44977 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbgCPPu6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 11:50:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id y2so6383108wrn.11;
        Mon, 16 Mar 2020 08:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EamSerdq2TXLxRzkNo9FWyvvMXhbhnbO2LxNbA+Lk1w=;
        b=EAnSN1ppcoAUoNdJ+GckJfrlO9Nd4NEbVu2xSUHU9lXRM2l84RabCktiduOVZUBMvj
         o9yOW92dQCiwRSEIjfzlDYi7Di1J8Vl8TSmleFmQj6UgMQ/pO0SNVujWoD0eoTzZ0Gmj
         UcB5fnpc5KCQEwblVyZNPOXaTBk2Y0FiXnlhsg2qjTLPnJmeERp7Ftj0TpEZL2hV6Fky
         GeMKjy5TFXZhhuw4MVblQV3zeW1O9aJ2YjpwqusF6QHN1UMsTv94ew1mDXGpxK8w2k54
         KsPF6PYVYqrgAKGvdd951PnEL14+fHJGSeTNS3SIA8I+gN2WHvJUWHCtaBYfDR7bEscI
         xEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EamSerdq2TXLxRzkNo9FWyvvMXhbhnbO2LxNbA+Lk1w=;
        b=WcT9PFFX8EORH2SNEU1IlFkVTn3p5Xa1XFBS1rKnwZrORuFu0y1vLcI93TqyX5C4pG
         /QhIjY2LzJsBUsL3Ow2kudEmoWTIGM52EvH0HWsnHFTDsnXx7vYra3Q+UyJnpG/Mvima
         53bq/g6eNy8GsJKefwRnZf6ZIXdqmCRC/YilmZ242hYD6cS8inPPqZXGD4xKSCT8Fbpr
         9dalbNLRTkI3FxnucMwgC5zEaasVPzCgRpFsZk1UJN7wLYYv3JXahKUWXPA4HKLBlwSb
         NDobasVmxWOr3cTA9xUL0ufCj2siYZjwRyNVgs1dvNgO7T7xpQAWuNE0WlDd+ndXRB8t
         GbMw==
X-Gm-Message-State: ANhLgQ3YQFaOwBxcHhnraUqsoRdj1bdWrjmRjAwBS3p8IpI0wfwuH5/v
        kE7Uo6bQnfWOFesQw9aTYCeCM9yD
X-Google-Smtp-Source: ADFU+vsbgzuCU0F18XEybyRLdh5GuD1U6cfg1ZB6R8IWvz6Gr+O6meStsG7KpkJwZ+tJxzrpFxPvNg==
X-Received: by 2002:adf:b650:: with SMTP id i16mr20253wre.316.1584373855778;
        Mon, 16 Mar 2020 08:50:55 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id n14sm153558wmi.19.2020.03.16.08.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:50:55 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com, Michael.Hennerich@analog.com,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v10 3/8] iio: buffer-dmaengine: use %zu specifier for sprintf(align)
Date:   Mon, 16 Mar 2020 17:50:30 +0200
Message-Id: <20200316155035.25500-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316155035.25500-1-alexandru.ardelean@analog.com>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 'size_t' type behaves differently on 64-bit architectures, and causes
compiler a warning of the sort "format '%u' expects argument of type
'unsigned int', but argument 3 has type 'size_t {aka long unsigned int}'".

This change adds the correct specifier for the 'align' field.

Fixes: 4538c18568099 ("iio: buffer-dmaengine: Report buffer length requirements")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b129693af0fd..94da3b1ca3a2 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -134,7 +134,7 @@ static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
 
-	return sprintf(buf, "%u\n", dmaengine_buffer->align);
+	return sprintf(buf, "%zu\n", dmaengine_buffer->align);
 }
 
 static IIO_DEVICE_ATTR(length_align_bytes, 0444,
-- 
2.20.1

