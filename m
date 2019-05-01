Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00B105B7
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2019 09:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfEAHQA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 May 2019 03:16:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44790 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAHQA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 May 2019 03:16:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so8250134pfm.11;
        Wed, 01 May 2019 00:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2lTg3UwRF188Hyu1qFGSZBHjhJOOcy42FRYJbO0gLLI=;
        b=nF1HMGNWHCZzcBQvlVSecKGX5SVnflrEGORafGvOJhRk8aDafzMkiICMCjy2LA98l9
         vi2aTHHFcIDpt9Oyxlm5aSFwRLhs+7M9vE8zheuYGQifEybyxKq5ZsQfiLrMDgK2ShVe
         qowh4o7+s2EL8+i14ReS/9RDMw68qsuKMrhD3Zjh+ZvCLMP/eghsZpctdHtEcUbJ95wR
         c8q26/qZQ7R584up4S1Zzlfo/QNRbhD1TPyRgtOLu7l8ozCtp/JMQibOtLtWYiGbtsul
         QZNh+e6F447FHxVEhSdmG3VPHKgWa3WZpRaZ1j6/jTZT3Yj8M92/1NTNCH4GqKOZWLIh
         gUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2lTg3UwRF188Hyu1qFGSZBHjhJOOcy42FRYJbO0gLLI=;
        b=s6/6GPL/BZi99nUuaOMBEdUPts2doFr6gn8pYvoWp+dHMdNKiXziGZURquLLdgGzO6
         fzjAo//c1CG+IgpEblt80OteKQc7ANAxieDQ9KOReSFS/pziN6r3no+qnUacxtns3Sar
         BUtCYAscpCAujgtHWPfQRzWqau/6yzgtcZT3dohK9mSdRsx0D18Bm099miEZFj3Xzbys
         jSLUPOlvihhr+D/85zfu3fmIxMEE4rJyXz14pCJK4Ggwy3mONI8d0BYJ36RrdsxeH/VP
         Fa8dhWkFzCTGZCQLLY8HQu4EabBxRgfpL2llzPpgNaIw18rBT09PJagTwHgKctUACgq4
         5Akg==
X-Gm-Message-State: APjAAAWAnqBgTVubWwbKgYBsVbSjuvkU4dZWEy1eUG6uqPy/EEV3c+uH
        67oKTcmSVoewgIhihHHploM=
X-Google-Smtp-Source: APXvYqzhto3zBWANIqlONgb3cXufZS2EXRLnqHv3Qa/bGxdtqrI7gv4AYsngpAiXNVifvC214Qcj9g==
X-Received: by 2002:a63:f707:: with SMTP id x7mr71571472pgh.343.1556694959735;
        Wed, 01 May 2019 00:15:59 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.94])
        by smtp.gmail.com with ESMTPSA id w65sm25894769pfb.59.2019.05.01.00.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 00:15:59 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr, Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH] staging: iio: adc: Add paragraph to describe Kconfig symbol
Date:   Wed,  1 May 2019 12:45:41 +0530
Message-Id: <20190501071541.4734-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch updates Kconfig with paragraph that describe config symbol
fully.Issue addressed by checkpatch.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/iio/adc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 23d9a655a520..31cd9a12f40f 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -12,6 +12,9 @@ config AD7816
 	  Say yes here to build support for Analog Devices AD7816/7/8
 	  temperature sensors and ADC.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7816.
+
 config AD7192
 	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
 	depends on SPI
-- 
2.17.1

