Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D996122995
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 12:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfLQLMM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 06:12:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42575 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfLQLML (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 06:12:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so7354517pfz.9;
        Tue, 17 Dec 2019 03:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tDASqqq00AoUFhkrpIeD5i5da1G2sBy2LHsU0nWW8fI=;
        b=hCpwf90q/OrfsAHOaR73nV4fXGokdZnKxQAEvF5Z2Ia1JhFgNa3ykBd38tixTrgqF/
         fbniDkJNygUGXcMrwe5mocSrJjqOAtUA2V9a1I0Az3DUtimR7nKKBPiEub0wwkHHnQDo
         qO4JlpgqGzsZrqzEzYMg/i4Rkp8NiGv60eG9GWxQbukvKMJ74nEg7k3MJCuhSxL5ClzP
         ceVtf5k8bmDTqtcrG+r3RZWjjN03oQ0SMCs8TywOLNTQ8XkTYA8447eGMa5E89fXiDsB
         YNSYFXzH/Ls8f64ZksBiqhRno5qd+m/Xbl8T7HFwSOUXdopzWyR5FEli/AOTreVO+/V6
         lA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDASqqq00AoUFhkrpIeD5i5da1G2sBy2LHsU0nWW8fI=;
        b=EA5KsSXo/K1ctGD5f0cRJ+EbhDZG8q/EAGM1cM4vgmcMcppeOjn2Ons7eTi4yn62GV
         7IvOj7Z/wFbU29Mzzmq+IESZW16uqiqyUPsUDo/4WubBucVi3P+SgrlCX2xY9Wq//LW1
         m4L2jvoaGgOAbRCaYorTjMGVehJOFRhFhMQ3iqEv2/pCo6mK+JJsUlpViCDXmjrrlaVj
         3Fm856mZZIXxwW4SgrKwb8vUW4ICMlC2M01F5Pg2Ru/jw3YNu+PZo+2mEC7waJ8gabPu
         UL4tcvNoydcQcYlfv19WWS1wLqumLrR9dZCnNIg+cbQk28OLSk27NlqwkojtnVb8To08
         LgOA==
X-Gm-Message-State: APjAAAXGaiNjYZ1U/+9ciUAcobtWwpirAEkGH2g/Ny0hN+NsqeRdi9WV
        E0UTLMXJD9ly/7nkhps0940=
X-Google-Smtp-Source: APXvYqxiYGC+TrwRnhox51l4gq20/VDouU9UFpaUB/1tW0upYpQSwe88orItsMFSPZvwDXhrDUD0+w==
X-Received: by 2002:a65:4109:: with SMTP id w9mr24061803pgp.383.1576581130885;
        Tue, 17 Dec 2019 03:12:10 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id 81sm25855190pfx.73.2019.12.17.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:12:10 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: [PATCH v3 2/4] iio: adc: ad7923: Fix checkpatch warning
Date:   Tue, 17 Dec 2019 08:11:56 -0300
Message-Id: <20191217111158.30888-3-djunho@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217111158.30888-1-djunho@gmail.com>
References: <20191217111158.30888-1-djunho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix checkpatch warning:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+static int ad7923_scan_direct(struct ad7923_state *st, unsigned ch)

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
 drivers/iio/adc/ad7923.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 969c06b7d2b7..e535cec9fc02 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -184,7 +184,7 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ad7923_scan_direct(struct ad7923_state *st, unsigned ch)
+static int ad7923_scan_direct(struct ad7923_state *st, unsigned int ch)
 {
 	int ret, cmd;
 
-- 
2.24.1

