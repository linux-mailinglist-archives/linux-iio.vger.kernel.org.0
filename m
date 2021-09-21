Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F759413465
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhIUNkE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 09:40:04 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44736
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232953AbhIUNkD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 09:40:03 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1B653F338
        for <linux-iio@vger.kernel.org>; Tue, 21 Sep 2021 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632231514;
        bh=qjV8xhkZjX89cHr8o702pqyeIg4T7wQY+u2MdwI/m28=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=uLn46G1LZkuAfthtsoP7adx8d0SUj8oEw2fAc5vLt7r99UVzQwtL0jnbo7+W1d7I1
         V53ctJXxIi1lzx/VUwOCdnuv6NQsYwo4mwNvLCbVzpYnVzBGWVAwup9GLBEAzPFVyi
         QhKLzj0IETyQPdgjwONbvNW0Zkr/LrTO4WVVXQXajAayWJJlr2pWIvmVqxHTaptAcp
         7RyeaY7i6GPiBLCSwsLvSTLAK+Og6JPT1VmOv9+qKR77Ayz5NFEQ+YOIAgpTwGxKNa
         PcOWqVsI7Jx6hKnJpGRN/vAp70PxYz55x4/zEFiJapgHq1rM2ywbkYiMkIeRc8YsdE
         3FfEaXvtjTz3Q==
Received: by mail-pf1-f199.google.com with SMTP id q8-20020aa79828000000b0043d5595dad4so15998863pfl.13
        for <linux-iio@vger.kernel.org>; Tue, 21 Sep 2021 06:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjV8xhkZjX89cHr8o702pqyeIg4T7wQY+u2MdwI/m28=;
        b=spf5XErSsZIJOIv5QIqC3LGIFfinyF6uvWx5s+/fXRhOndMOpLoBpLt7SsTNxvgV6K
         HXULYC74z7k12qLwBVXr2GP3Q29GnqzY40zmrNySYw3w42wibe/R8+T1tnolL8AzLXDF
         QyctAtVUpsa+mVs3QMP0Lr5+VNUloSxno7PIF4l02/7HYHVP91fO24ib0Q0YVQupszmY
         5N29ZBQKQdBC1uthR4YnCF9oa2QrmMo5R5IAv2BHqtm7XZcv+ywOJa0lU7EKJAa93zl/
         7IEbp6aPQGXLcV2z9anoIvXPPjPioKDAGbB/9RrNcVFgdiSfXzWAJowZ2ls84CPmxXME
         ImWg==
X-Gm-Message-State: AOAM533AAcfO5UbbFornTQUO5jv89Cr/ITaiVh3cjkexlavd43nHP1Cy
        bo4Fqf+4mtpJ+peOQbAITl55wzz5UoWCTWLVxnsDfK7I2hrPXRXzTmg2+jMc+ZbRSiSpDYUNOnc
        bmyr+kUJg7Ck/ZUopO8clOR2u7dp9GHJEwNx0UQ==
X-Received: by 2002:a05:6a00:1694:b0:440:3c9a:ea68 with SMTP id k20-20020a056a00169400b004403c9aea68mr31444877pfc.84.1632231512927;
        Tue, 21 Sep 2021 06:38:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcZEWQ3UWc885uWznJLamRyMTscM1Ee10GdlOObmfDeddIIH/9d36JlrVlXlmCqVHxvFM0Cg==
X-Received: by 2002:a05:6a00:1694:b0:440:3c9a:ea68 with SMTP id k20-20020a056a00169400b004403c9aea68mr31444850pfc.84.1632231512700;
        Tue, 21 Sep 2021 06:38:32 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id v25sm17087692pfm.202.2021.09.21.06.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:38:32 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-iio@vger.kernel.org
Cc:     tim.gardner@canonical.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3][next] counter: Add default statement to switch() in quad8_function_read()
Date:   Tue, 21 Sep 2021 07:37:49 -0600
Message-Id: <20210921133749.15461-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YUkpBU8mN4yrDfu5@shinobu>
References: <YUkpBU8mN4yrDfu5@shinobu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Coverity complains of a possible use of an uninitialized variable in
quad8_action_read().

CID 119643 (#1 of 1): Uninitialized scalar variable (UNINIT)
4. uninit_use: Using uninitialized value function.
346        switch (function) {

The call to quad8_function_read() could theoretically return without assigning
a value to '*function', thus causing the use of an ininitialized variable
'function' in quad8_action_read().

Fix this by adding a default statement to the switch in quad8_function_read()
and setting a return error code.

Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
v2 - Add the correct Cc's
v3 - Add comment to the default switch statement. Also noticed v2 would have
     returned with a lock held. Fix that by returning a variable return code.
---
 drivers/counter/104-quad-8.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index c587f295d720..7faca6b760e7 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -201,6 +201,7 @@ static int quad8_function_read(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 	const int id = count->id;
+	int ret = 0;
 
 	mutex_lock(&priv->lock);
 
@@ -215,13 +216,16 @@ static int quad8_function_read(struct counter_device *counter,
 		case 2:
 			*function = COUNTER_FUNCTION_QUADRATURE_X4;
 			break;
+		default:
+			/* should never reach this path */
+			ret = -EINVAL;
 		}
 	else
 		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
 
 	mutex_unlock(&priv->lock);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_function_write(struct counter_device *counter,
-- 
2.33.0

