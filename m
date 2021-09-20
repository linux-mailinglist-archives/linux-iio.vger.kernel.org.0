Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196E1411F6C
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245491AbhITRlN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 13:41:13 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49976
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352346AbhITRjN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 13:39:13 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7FA1440267
        for <linux-iio@vger.kernel.org>; Mon, 20 Sep 2021 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632159465;
        bh=CQtfdbe1O3s9BEshGw98z5OXNdM0i7hCrZwLtn3F8cg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=gPUwfg4ujek7uKG0VrK4g0L6mpoVRWRWk0peffAoz+SXNDg/Aa0MmBIp1knwjE+Wf
         0LHShfOJnXqKdbgrQuQ9+EysMTUdTbIkZkcrNu1DyJhRC7Zi3XFXpX24y4NFgbGGBj
         ZPSFdwIbDUMlxxAt0bOSTDw6lGynxEUOL4XLMCtiuMh30YPB+egBePfhXsywW2veBq
         7wR95avR4oNbIaCRZMFYtbqvk5xlThe4/7nk6NgrUF0GkgATJ/GNOmonE23+qtJcpg
         hd4qWDqqMNhYpM+aG7ah3wDvnCS7gEjWf9rxDynijNgcu4n2yNHJgLC6tqFBBkHaY3
         EkVY39hl/mA1w==
Received: by mail-pj1-f70.google.com with SMTP id m9-20020a17090a34c900b0019c8d5075beso368709pjf.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Sep 2021 10:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQtfdbe1O3s9BEshGw98z5OXNdM0i7hCrZwLtn3F8cg=;
        b=m1hb7S6bmTQsGg4GaDKE9Ir3ieZCX5e00tuxFJPLJkls5MbRTb6uu3UgnKBdhvH72F
         YrAJSKRirRCPEuwyTLWuYY2t9MFmPyPI8XOI36WkFD5kAsPZddBjHoQYFoUHrC39lIxH
         JukWHqGw9sSZcwGLBMMdp3mwjUrRhfTI9vP5yqGUCZlu4zehU2NjFsQECEiaQO2FJ5rY
         SD6bODs+6HB6Galtgp4GfEJU4gIDQLcEtamW++mj8IJjLS2VUS3BJTXBfAXTLN7zAx3p
         eAbU3gk1r7K3M/UKu2CyyGt4zXD6kLUUJkqucpG+eSceEYY2HuO14z79Lv8hNbMBLaK1
         6p9A==
X-Gm-Message-State: AOAM531CsJqs5BUqhhzwaPmMeDcPZI7AQpBnqdLNh8VwEbOwbjdpZkBv
        0QkhudVZF1zmzaL2lIdFzTNaP45iiR0e70KLOQhnAmstJJCyCuPhjZbGDjfsTXR6FsJ00m4n47l
        mSgzgfNrpX4P3xiZf+5qZC58+ZDZxQ0nWZi0Aiw==
X-Received: by 2002:a65:5845:: with SMTP id s5mr24080731pgr.227.1632159461678;
        Mon, 20 Sep 2021 10:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCnJ9SLA7DSqx8gP32eeM3/WHlWuJYoH5BlFMtXi3QlDixSt/zezxCCbHLKKlROcKaXGFBKQ==
X-Received: by 2002:a65:5845:: with SMTP id s5mr24080711pgr.227.1632159461484;
        Mon, 20 Sep 2021 10:37:41 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id o12sm9763848pgn.33.2021.09.20.10.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:37:41 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-iio@vger.kernel.org
Cc:     tim.gardner@canonical.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2][next] counter: Add default statement to switch() in quad8_function_read()
Date:   Mon, 20 Sep 2021 11:37:37 -0600
Message-Id: <20210920173737.21445-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v2: Add the correct Cc's

Coverity complains of a possible use of an uninitialized variable
in quad8_action_read().

CID 119643 (#1 of 1): Uninitialized scalar variable (UNINIT)
4. uninit_use: Using uninitialized value function.
346        switch (function) {

The call to quad8_function_read() could theoretically return without
assigning a value to '*function', thus causing the use of an
ininitialized variable 'function' in quad8_action_read().

Fix this by adding a default statement to the switch in
quad8_function_read() and returning an error.

Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/counter/104-quad-8.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index c587f295d720..3a69d35b82ea 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -215,6 +215,8 @@ static int quad8_function_read(struct counter_device *counter,
 		case 2:
 			*function = COUNTER_FUNCTION_QUADRATURE_X4;
 			break;
+		default:
+			return -1;
 		}
 	else
 		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
-- 
2.33.0

