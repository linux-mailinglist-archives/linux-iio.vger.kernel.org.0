Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C983F411F4A
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbhITRj7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 13:39:59 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49936
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346638AbhITRiN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 13:38:13 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F1B8140261
        for <linux-iio@vger.kernel.org>; Mon, 20 Sep 2021 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632159404;
        bh=b7Js5Ee3XI72yYKUVY3RauPYjVtVH99GNznbbDgJmAI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ZYW5tbkNIlXby2lBgu2CMHc3ZGVsQbDeKU0KObpqs/reHzq+YhD6BtL3/760x0WxE
         lG/nDrvzCMZIA8bV3Z8ZXkLuxOBrzx2F+TimeLZYJ6Mwq61Qb20q6Dk0LcXpGBo7eR
         Wqub9+QQmAFPKMYxZU4Lnj3Zp/1JewmVE49C3cPhOdqlw3X1uw6C4hzZkEOlqeaf/r
         qAJs6HVzRqDf70g/I/Nme3r9Gj1L/5MygosFI7p78hwqLcr2nzFZH85iNOSeU37Tra
         JC2ynFEG0kwZ5LB4RbkKCbbxERO/iqmseRV/SPbOObuDf9Rnqy7+3WbgQ6Vt9OVdYR
         lr/SADIBXJQOw==
Received: by mail-pj1-f70.google.com with SMTP id g21-20020a17090adb1500b001976416d36bso271699pjv.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Sep 2021 10:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7Js5Ee3XI72yYKUVY3RauPYjVtVH99GNznbbDgJmAI=;
        b=47+n1mCd4FBi45WZaskNPQx0gR06/9Nz2zb3wnQ/TUDlTdFwUQpVQhJiPYqMxMU2K8
         4gDVLN0U2daXmPZP5O5vZt1A6WhGOB6lfi78YGcUNToyZ5Ll3EzBQSGJFUsylZiVy+LW
         nJwDg5WmGz0Zir1saEBaw9JGWkOSC59bfH+8K2rRNRuq5zE+tWAjw3qnteA1/Xd+pjl8
         XfgqPbZh7X8sb5N+3iuXA6j+cnYNQh28jU9T5nMVu2OdHOnftXP9gS5GOJuDcldImsxO
         pn0Hx+Rdu3DfdV2Jtij2RBppsiGnsLOcodZ8IQlx3Btn3Sw8dqbAYZjk18dBP4sVR1Ac
         hHqg==
X-Gm-Message-State: AOAM5329GSbUJO1fhNC+Fy/uM46loGbi8uz8r2SuoR12txmFXOlzpNXY
        mB9pYWZMrkJ/4gZ+Zna67Z+G7ZHBROvTxOhisJz8BxRMPKw4sWt1cWvPGfBN79Ap1ym8wgkn+zw
        hL8YvadbcaqcAM8KL6ga6Bw8eLPJmpJeD6+J6eA==
X-Received: by 2002:a17:90b:a4a:: with SMTP id gw10mr182166pjb.101.1632159402103;
        Mon, 20 Sep 2021 10:36:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+g3n4gNq3jevHpE7wx0lCJKjH9CAwZyZj0lUreYC5XA50c4UdSMoi/4CRQlG14+gUjnx+5g==
X-Received: by 2002:a17:90b:a4a:: with SMTP id gw10mr182132pjb.101.1632159401693;
        Mon, 20 Sep 2021 10:36:41 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id x18sm14803078pfq.130.2021.09.20.10.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:36:41 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-iio@vger.kernel.org
Cc:     tim.gardner@canonical.com
Subject: [PATCH][next] counter: Add default statement to switch() in quad8_function_read()
Date:   Mon, 20 Sep 2021 11:36:24 -0600
Message-Id: <20210920173624.21406-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

William Breathitt Gray <vilhelm.gray@gmail.com>
Syed Nayyar Waris <syednwaris@gmail.com>
linux-iio@vger.kernel.org
linux-kernel@vger.kernel.org
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

