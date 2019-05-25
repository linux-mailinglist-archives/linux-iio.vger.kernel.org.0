Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39092A247
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2019 03:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEYB1C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 21:27:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40269 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfEYB1C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 May 2019 21:27:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id q197so10106537qke.7;
        Fri, 24 May 2019 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzraHFE6wMYG71k7o5b4Wv/r7uKs8Bdv2wavFnwb5sY=;
        b=MXuSHxcr3kQqN04w7FF8uyXbTEVHLiCIpTF24nNdD1DkgKtq4oZEUKBLzMBYaAnOpM
         Nkvo0yWKSG7UIR+R2dqYJAOt9B5sRcVwgTE1jNBecCp/MrT5MP4nXgUjYTX5RZMAce1U
         3kSRtBR+86x293fBDv0c1OAppdvGKTE6TjbA0SSVmvod5tRFAiivgvoXSszotzPhNaD1
         z+f7NHDoR5zaAp0LSM3vpKHqz4dcLR01qbcJwSS0PMVW1JfllZiBXWbTXMbKtfTXB9V3
         51iMreCGM2wfy3kE0z/M882zlV5w2Cv+YS0ktUenT7dz4ndc/ukU2J//ESIw0H9/ZUqZ
         sGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzraHFE6wMYG71k7o5b4Wv/r7uKs8Bdv2wavFnwb5sY=;
        b=r0q8PkV9kObm8itdNlfpcwJ7jPS2QamGpePSHZ9ER1GZ6H2c8Jf3nGVFVDjdHMQ38U
         Zrm6e+0ojenBFLdCGiFyGCkMgxLhPIY/fxdTCQ6s0xihpmv1JvVK2UGGm6OsOJEt0ILF
         5cMDa0k70qqAREFCGT5Nv1DW3nEWxjphrA4KM4jNZi6ENS0w4bKf1Iwx6LTKMcFtqH0x
         5aKamCnLFgczIYPyZbqjsRGOe77SmxvzRBENpfzox3EaMqBug/2o+fkCwN/IQw1qPIR2
         dG/gnbWzRtsaubMSKiq2d9K2uCHbAMcBopDREyI9XQJbJfiRLUMd+7yVJxZq5Vyn+hZS
         Xgrg==
X-Gm-Message-State: APjAAAVTF5ZQWWnfIB2jLQFCM8RfH2dbHkdkG3Y/Ad8EKnxK3JFZ8avI
        ipNIAc2r+OEhaUeYMKVU70I=
X-Google-Smtp-Source: APXvYqxp0RKzd8fLOKxLWCeIvyLUlr6GJyUlqGQb8MD83JBEVlGRLQnd7AOyRANibvoyirIffixJew==
X-Received: by 2002:a0c:d023:: with SMTP id u32mr28733854qvg.23.1558747621134;
        Fri, 24 May 2019 18:27:01 -0700 (PDT)
Received: from renatolg ([186.220.0.156])
        by smtp.gmail.com with ESMTPSA id j14sm1461656qtp.40.2019.05.24.18.26.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 18:27:00 -0700 (PDT)
Date:   Fri, 24 May 2019 22:26:55 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] MAINTAINERS: add entry for ad7780 adc driver
Message-ID: <7ccb64ba4da8f24981009187e975d71372d62fbf.1558746978.git.renatogeh@gmail.com>
References: <cover.1558746978.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1558746978.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a MAINTAINERS entry for the AD7780 ADC driver.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 54c8e14fae98..d12685c5b09a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -880,6 +880,15 @@ S:	Supported
 F:	drivers/iio/adc/ad7768-1.c
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
 
+ANALOG DEVICES INC AD7780 DRIVER
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Renato Lui Geh <renatogeh@gmail.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/adc/ad7780.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
-- 
2.21.0

