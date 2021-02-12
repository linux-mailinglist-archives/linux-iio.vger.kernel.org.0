Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275D9319E17
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhBLMPV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBLMPD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:15:03 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67708C061788;
        Fri, 12 Feb 2021 04:14:23 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id x14so8433358qkm.2;
        Fri, 12 Feb 2021 04:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xiffz/2juDPYZZmbqjFbaJKECdvS7YcRGaS6EInCRI=;
        b=mZwTrnYBpzn4XVHU4cjflgs4dw3om1p7+bsPTTIGiZD2NCewK4MDA6YLmPTaDa6DMu
         Ge04VhdsHPF4MRQu30KIcCqwXytSwbkASdr+K1rrR67Uv9HT8pQZivCSWDLOaNXHa+3M
         TGh9iaQ4NiaLDiIFFXI1FEPic/hMSPuaFhzexZOXuh9Mc6E5AxBlw1Mnt7EhujKKYvK3
         sWRt1tNWuoZz4jm/M7mZWE2JOvL1aQF6cEuA5eracV6uuSMk+BARM+N/EVLNw/fUJA4v
         7kebs8UyURXh0sS+M8bV0F8gP2jaAGrrDKi6gl38qEe+fn80R4JoTK3zJb+lSPfxZKxI
         +ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xiffz/2juDPYZZmbqjFbaJKECdvS7YcRGaS6EInCRI=;
        b=RB6FQmWldIW3f2m8PiK2egRPomH4QKyYRWgHuiev2LecFZd1rNXlT7jnrL5272T37n
         GQP5CK7zbxgm6n1fUTwt+5MqPaLQ71xYpvOtovuv58fObcVd5SrwYVKT94d6DCFfY0WX
         UPX9E1vtRUOzt8cyBCKCVEvuoO33KCwYeBlFAb4m9ERDvV2bsRLzhDHW8dKFbwyb1g10
         tJvOHGgqH30d9SVobrHW6VN4D7OqmJDOwYyNxsDSpXFYtLmcZJwOw39ODgFxhzgGbqWe
         hVONwempxI+noLLX43xOvsk4sAsJfv1SYkcf9RewQ06yQt7tqU2N+JXBUZ/MgatWx09x
         ebYw==
X-Gm-Message-State: AOAM531j3KAqAv0PfAFVqFFmvwBFj0bDuAvZTM1q88AFWt3LXb7EtLCZ
        hNY9UDLfSIBwu92ZM56A+rg=
X-Google-Smtp-Source: ABdhPJwoTxWbQejBvfQ1z5Et+JABQcqujW3McbDYqiMJyzm1dfG/tggH8StL/8Q1BhTbF/53po07Dw==
X-Received: by 2002:a37:6cc6:: with SMTP id h189mr1325495qkc.195.1613132062689;
        Fri, 12 Feb 2021 04:14:22 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:14:22 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 04/22] counter: 104-quad-8: Annotate hardware config module parameter
Date:   Fri, 12 Feb 2021 21:13:28 +0900
Message-Id: <b16b0f7e882a80924d785f022f8ff6b160f9d288.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates the 104-QUAD-8 driver.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index f0608b21196a..37551d3016de 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -21,7 +21,7 @@
 
 static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
 static unsigned int num_quad8;
-module_param_array(base, uint, &num_quad8, 0);
+module_param_hw_array(base, uint, ioport, &num_quad8, 0);
 MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 
 #define QUAD8_NUM_COUNTERS 8
-- 
2.30.0

