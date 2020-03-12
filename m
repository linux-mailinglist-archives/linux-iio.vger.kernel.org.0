Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72B6182B51
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 09:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCLIf0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 04:35:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36142 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCLIfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 04:35:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id s5so6277445wrg.3;
        Thu, 12 Mar 2020 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EamSerdq2TXLxRzkNo9FWyvvMXhbhnbO2LxNbA+Lk1w=;
        b=DS1OXIV6cgAb1A2CCEO0LCCSufk0ud7iJH/96UynvvpoOPvHjLKJtUxikW6CTIrCi5
         eTy/p3k4D4uWyikpWB/tmEoSWSaOYeF2d3n5pZvHOY3vYyabiE5KtaUhFDBVnCqUF1BP
         VFU6Y5A9bKOKf2H6IaB1MqrtR7Sv8+OaYdcBBy4oZFRBZlPtOmx7In+8W0hoNg3BvkUB
         PfmRpXjLPw7B/SK+cNz3SUAySwpYdj0uMiXGUEy9vl22gOp7GgggYLyP5JozMdxWQUU1
         QCjIID5TCXB+EnHrW7nsYBmnGApJmENhU2AvEnD185d94ke2Crz4bYRRGCqjC398l5u8
         gq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EamSerdq2TXLxRzkNo9FWyvvMXhbhnbO2LxNbA+Lk1w=;
        b=oEF/VYa6s0tN8VNbm3ad7g3yP2bJLw0wyq+WfFaBDSHRnmhDs2fj0Sxbq3YfYfo01R
         KCe01dkumkXLTXjUOyCh9fOPZBcC5G4wp0lvJyKqtp8MBbTmeXuKPL3VssaGiesGTiVI
         aWZmPBjItTjORkTDbtgpVZMweSmMpD8FSy2w7f3Gm9at+evL+rR/k9MZsycBP9OI1UjQ
         zvxCmCRO8z6qEUz4lvAvJqeNwSJa/U4RZlMOOgh1RocpJXXbJcIN3GeZ+yclwDx0bBVn
         eqwm2Mqdi3wt9/1nNlKHXQ1k5gLDefFCSZwvx8MGdm5gEBVIxW7Tb7Uojy93aYwp/yrE
         3aoA==
X-Gm-Message-State: ANhLgQ1ATPred1c1BXLgVhJ0Y4jts6ZHl2ZTw1yfZtWla+DGMe8YfazN
        BTkGhI5p7GXMyzLOeEyzwL4NAMS1Edg=
X-Google-Smtp-Source: ADFU+vst7Ls2k2cq4zj2JnadmlMwo8bWMYZDfNAAkdz4K08VvDtFFF8kJQv8Wagp+P3tkVuTlPsXWw==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr9636823wrx.14.1584002122929;
        Thu, 12 Mar 2020 01:35:22 -0700 (PDT)
Received: from localhost.localdomain ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id 9sm11543334wmo.38.2020.03.12.01.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:35:22 -0700 (PDT)
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
Subject: [PATCH v9 3/8] iio: buffer-dmaengine: use %zu specifier for sprintf(align)
Date:   Thu, 12 Mar 2020 10:35:06 +0200
Message-Id: <20200312083511.28832-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312083511.28832-1-alexandru.ardelean@analog.com>
References: <20200312083511.28832-1-alexandru.ardelean@analog.com>
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

