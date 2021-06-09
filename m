Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D361A3A093B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhFIBfY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:24 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:44993 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhFIBfW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:22 -0400
Received: by mail-pj1-f43.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so412061pjq.3;
        Tue, 08 Jun 2021 18:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=53F3JLy2efE/MBSv+u+hdtt2UsFBNaGfSp4/xOndCJw=;
        b=m8NgwwBQVj+jiOSgp/qosMdniUSNKbEihuaHW84YK4n9ISHj3p6eAH3wIijol8CUmh
         k3wtBdLYgwJCdaFrYTPzeEsfQEkRAAIloFRJ0Sx/vYTGIY+B/zxkUMh19sS9ieeAqE2n
         sj0F+OZvJC5hhI2EM6bvsroDIrY3Auoz3JZyWzpzuc+HciWeuIcXFSe7YGclcC3ESDNk
         pnzjomO6GPuXSgUii5ZNOBSo1wDYmz06NRFK7KEI40Lv51VGF4mhD1t624cUaenHvZrw
         0GH3TSRk2/IW6oYUsVIxopQoUUKkXYvBGnNVSgFQ75Bd58+NsUu8byQp3tFnbnwYsGMz
         O20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=53F3JLy2efE/MBSv+u+hdtt2UsFBNaGfSp4/xOndCJw=;
        b=h0visBmJTpFo+P4fxw5Ta1bW6Fidv5x1Ddt6OXj19Kq2pKmuCxBGvambJU7YZpZskH
         IFXhzEkBmIHPgfiM/x3tR6KqGwcvZXWd/ZEqcqNh608nt1cKgdXk9+sjwvV5c/BrjnYA
         wRekqmg6pHUAjbPMidlVPch2BbN5o0MIjEbYC888AnNNe88zrgPOYnaeklAS7uIP3/I1
         xRfoDUj4OIjqY9CNRBStpkvNKlZrfrirUWs6vJW0aKJbcbuPDZbtARaCADixfTqpqMZT
         aG4fQWvruT6zV/K6W9Bv2DncaPnfBsM+gflzfe94WGt7gakjtpMhfw25PVVw72f6Wa9y
         1KRw==
X-Gm-Message-State: AOAM531qa0T1vbD6fEo50nLzF3c486LdaSe72BgmY35+UtZCe/MdJgI9
        La+lylJv/k8Nn5dXxDywI2Y=
X-Google-Smtp-Source: ABdhPJxlALKo8z10rInZn6MEjc+0Tt+aSv/JtpP5OOw76asrvljiGTcoZp64CRIKQeDsuyxCbelwOA==
X-Received: by 2002:a17:90b:1888:: with SMTP id mn8mr8046509pjb.179.1623202334944;
        Tue, 08 Jun 2021 18:32:14 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:14 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 05/33] counter: 104-quad-8: Annotate hardware config module parameter
Date:   Wed,  9 Jun 2021 10:31:08 +0900
Message-Id: <97ce79878a26809f0b15b2eac9a86ca39e0ecd74.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
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

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 233a3acc1377..0fd61cc82d30 100644
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
2.32.0

