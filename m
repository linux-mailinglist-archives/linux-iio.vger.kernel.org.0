Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE3341AA1
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCSLBq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCSLBO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679BAC06174A;
        Fri, 19 Mar 2021 04:01:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ay2so2781733plb.3;
        Fri, 19 Mar 2021 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNHAzRgGiY7J7G+f8mmaWum3SKthte+B3myyLZXUAyY=;
        b=s02yFLPcTuICIO7+C+BcSoFLEftjPfweIg/sH113MKfHNgrEzsrKNyvl57Zx991Zns
         JffwM12TkhbgTzson9zRHyQKSGthzQpmLJz0PhC4zULJ97p280R246dAdVyjXaP1GQpH
         myWBIk8K5T5IokWp6IkefEMjawq3mX0O4OLv9V+JMno5CAcq4OMqyN2yUv4vlfl+nM+8
         gIhsxUtpY+0keiQMZfN9UbuZ3M4rxMxHRO7GAgdR0YmL9HY8gE9fXpS0pS8MvKmeq8D7
         rEAZT8Sw2YGQpUOcD63K+9pmeblQ7IIlwDkPM1URLEws02FJ+IW4lg73xbj9MWPrZ+Ag
         vnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNHAzRgGiY7J7G+f8mmaWum3SKthte+B3myyLZXUAyY=;
        b=P1yoKgDqmPBvyWa+R6dV+2RaGxiH95TfkRARllAjHKD2ZHkdYSJ8zt2uXyKSaaEklY
         wI8zzhl7g6S8UDuqkexUNO+uJPX1Mx/DR7tNGGmqUT4c64uqob7TJr0lm8yo/Mn4wO39
         O7MfID2gbeTeX2GUHHXFVVNyZxIp2QsDBZc3c+fvNwIyJNDVXqeiNP0RBmpvdUyD7ne9
         /4/zkADSSxavphneeikYbkBOexCBFPIvbzLXEM1qPBN/jlYyPbp/fiFj4rt9D4bvBmav
         /gxo/8LIOASDYJzUtlXZPHSg8MwkLA+44Xo3BEGQoZOXHg2s4GATJ4orqmeGGyjnHyQz
         BAfw==
X-Gm-Message-State: AOAM531CrwrF9WHCtHQjtGbAQ6S3Iu7JMHpeyEOfNrTgZmRCgjATPG5B
        DCNX8szZFde1BaehVjbrH2L8CzJcbuXGLA==
X-Google-Smtp-Source: ABdhPJwcq2BYLCh/FKajfLUwOFiyLFNcNr3jYX5SAAIA1CUfh2Eckv5FIvqSO9atPlmB9lma39Ql3Q==
X-Received: by 2002:a17:902:b78a:b029:e4:8ce6:fb64 with SMTP id e10-20020a170902b78ab02900e48ce6fb64mr14236203pls.77.1616151674053;
        Fri, 19 Mar 2021 04:01:14 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:13 -0700 (PDT)
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
Subject: [PATCH v10 02/33] docs: counter: Fix spelling
Date:   Fri, 19 Mar 2021 20:00:21 +0900
Message-Id: <a39062103d8e4ca5eb65c3c02b58571e62019de3.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"Miscellaneous" is the correct spelling.

Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index b02c52cd69d6..64fe7db080e5 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -307,7 +307,7 @@ Determining the type of extension to create is a matter of scope.
 
 * Device extensions are attributes that expose information/control
   non-specific to a particular Count or Signal. This is where you would
-  put your global features or other miscellanous functionality.
+  put your global features or other miscellaneous functionality.
 
   For example, if your device has an overtemp sensor, you can report the
   chip overheated via a device extension called "error_overtemp":
-- 
2.30.2

