Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A4B1C0107
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgD3P6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727848AbgD3P63 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 11:58:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38326C035494;
        Thu, 30 Apr 2020 08:58:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 188so2466955wmc.2;
        Thu, 30 Apr 2020 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1xmMluktHzlM1NHImtN6fu8B+63KJSJdW/amOIZcZQ=;
        b=mqunM0en9MHrE5Fn5EQ8DAJbaxy8bGNnoAJeqTe3r7GB0dpuFwJU7QwHLuGEY15FD5
         jyrUCrKZnldkRNK0opeCewvZ4Z9nAuUupuNyIDigAeVKtTcrg+It1lp2NQPYBPZ28lHD
         XoWvUGmt+OS5fnxe+He1s1OtFKvp1U4D8Xxyf4yk6ZQmQaNwzhWlTUafRwHHZnPi/pcw
         ql7+jQAXprjiqcxCZ6sGfN6ZH2N9xymQFixdpkuZwPXewSiA/WPnpHD37eKJXIFxkpgK
         WKjmHm0GC9rA9VQ2RLaNNPSp1QOWKZzZmedm/LFSjryswBoC1ZqSXhSOEot1BTXzOL7M
         X1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U1xmMluktHzlM1NHImtN6fu8B+63KJSJdW/amOIZcZQ=;
        b=rS9mFh8TgiWFlnnUxSyqwB5a6zyzXQCT5AjdICQz1QfWqnCqHOkcQ/IuCxWSJhfOel
         ByLb6hOFAaKKTm/LlVoJJclwZKDfqlD2pTSKEzvtyokvJYPnZT0mBf8ayWsWMaHXjAr0
         /HWtu3c/SLyD6ugRuyB8sQGYwSt4cc+t7UiJ6CdC7peoLevMVLBDk0NlyJGybD0/Sqaa
         IswKawPLmiZYv3VTLFZqOrYBbWrRHysFmTiz/Ld4Kp3tnyLdfT0hKv2gfch1MfnCktBZ
         BCUMujmO5a4Jn8RA0QE2zm5JCTTo8I/3ZkD7dnGioRwD3sbjqMlTudOeIWFK9T3LCyv+
         +83Q==
X-Gm-Message-State: AGi0PuazZXol2IPF9kn/RgjCPU0YHpJcWBs7KoD0ACpLVwTQyA95wZzX
        PK2GSkC3MhfXRfGaq1qtSOw=
X-Google-Smtp-Source: APiQypJgZg10GC4dYTiwZuQl3Z/1V5jRj3sphaRITBO3qDTzvrV81lUYCfQAUNszVYEANro93NxNzg==
X-Received: by 2002:a1c:dc55:: with SMTP id t82mr3942366wmg.12.1588262308000;
        Thu, 30 Apr 2020 08:58:28 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6E9D.dip0.t-ipconnect.de. [91.63.110.157])
        by smtp.gmail.com with ESMTPSA id w8sm265410wrs.25.2020.04.30.08.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:58:27 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v11 6/6] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Thu, 30 Apr 2020 17:58:10 +0200
Message-Id: <20200430155810.21383-7-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430155810.21383-1-sravanhome@gmail.com>
References: <20200430155810.21383-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add MAINTAINERS entry for Monolithic Power Systems mp2629 Charger driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32a95d162f06..0f82d5a7a614 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11358,10 +11358,15 @@ F:	drivers/tty/mxser.*
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 F:	Documentation/devicetree/bindings/regulator/mps,mp*.yaml
+F:	drivers/iio/adc/mp2629_adc.c
+F:	drivers/mfd/mp2629.c
+F:	drivers/power/supply/mp2629_charger.c
 F:	drivers/regulator/mp5416.c
 F:	drivers/regulator/mpq7920.c
 F:	drivers/regulator/mpq7920.h
+F:	include/linux/mfd/mp2629.h
 
 MR800 AVERMEDIA USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
-- 
2.17.1

