Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF92A2CE4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 15:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgKBO0S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 09:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKBOWg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 09:22:36 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA03C0617A6
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 06:22:34 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k10so13478554wrw.13
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jw3oq9QTE7nFTaO8GB8D/I4qCpQ+Kq8IawJXBfxGxQ8=;
        b=htAF5Ujg6yCl9eqYEVMVTYCl4kGp3ZTnkUV9UbXU9g8dU+97BuZIfMHctZHTz0z0iw
         3eeHUCRmY8CY6eXn1cDdvLdt+IN29epMqgLCrzN+vh79zTaxv2xPgxDqSO0vH5XTJUcT
         uUZiGkBOEP+VgLPnP9/BvaBT0yvVKQWomOnkUC7OZJUyWRpMj8ozdkZdC++M0csjtDhg
         G+hSVlYLvT3l0jnZaioFiFNdMmwIUzI/gRoZgrDigurfpQRk25DlBetOiCQtEgLwlH1I
         EBRWmy2aF7gaNgRBK0IcpKqT8Seoyx0RZc5wln1sAOFpvOfIYtdWwsU+GUDBNT8syjpt
         S6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jw3oq9QTE7nFTaO8GB8D/I4qCpQ+Kq8IawJXBfxGxQ8=;
        b=GOmmLzHOdsm4jWfgs+0p6orNrwxvMX2DG1tdH3Z373bHwSKWH1ioUqQk78OLKEbY0q
         bDLpiYR0dGpE8p29JBKW/pjBLdm5RRCGRgkYQT82jXV1V04CBCMPFqDgQ403fmfQ2F0l
         iRI/Ub4ORLyKFd0AdqoFYL+JukD36p0O6m3BqAeQpRYfXfmgbGB/mPzGf6h032IICgye
         tyqwwI0hROh2k1aBibhlpkrFdZAbmlA9Uxe1+azLSB0JiIykn5Ey/ZYSuC+LKORFh7WV
         ouDSsDPO0K44jGGspb0Hv6u1rttvrBBvy0CO+lAns7qC1BtBlgTKVKvPGncItewXQZ7+
         T1VA==
X-Gm-Message-State: AOAM532bfv6c0SaSKLszz+xRUVRX5N6sr52RGdC/5m2RdfEMaCclG42Z
        8q5NbESNWA5savBGti3RgxQp6Q==
X-Google-Smtp-Source: ABdhPJzSQGvgcpKNMN8/+kAWDq0KWVIo0vIEPBTqaI3e1RKL5IFUmYi3Hy6oECVzYa5AsZyknYP3ww==
X-Received: by 2002:a05:6000:142:: with SMTP id r2mr14427807wrx.155.1604326953520;
        Mon, 02 Nov 2020 06:22:33 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 3sm16182987wmd.19.2020.11.02.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:22:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/4] device: provide devm_krealloc_array()
Date:   Mon,  2 Nov 2020 15:22:25 +0100
Message-Id: <20201102142228.14949-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102142228.14949-1-brgl@bgdev.pl>
References: <20201102142228.14949-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When allocating an array of elements, users should check for
multiplication overflow or preferably use one of the provided helpers
like: devm_kmalloc_array().

This provides devm_krealloc_array() for users who want to reallocate
managed arrays.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/device.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 5ed101be7b2e..e77203faea55 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -226,6 +226,17 @@ static inline void *devm_kmalloc_array(struct device *dev,
 
 	return devm_kmalloc(dev, bytes, flags);
 }
+static inline void *
+devm_krealloc_array(struct device *dev, void *ptr, size_t new_n,
+		    size_t new_size, gfp_t gfp)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+		return NULL;
+
+	return devm_krealloc(dev, ptr, bytes, gfp);
+}
 static inline void *devm_kcalloc(struct device *dev,
 				 size_t n, size_t size, gfp_t flags)
 {
-- 
2.29.1

