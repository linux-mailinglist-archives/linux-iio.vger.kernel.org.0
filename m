Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9332B447E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Nov 2020 14:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgKPNMD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Nov 2020 08:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgKPNMC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Nov 2020 08:12:02 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D8C0613D1;
        Mon, 16 Nov 2020 05:12:02 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so16658938qkf.0;
        Mon, 16 Nov 2020 05:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qRQr++amLox9FBhB8MmGXvsCYPFE7KYes9F6TU7bBU=;
        b=bPwyEIhewFJGWgctI3Rn7BboO6mTzqGUXTRJVkq+Fpper6MF5OorXtEPCgDicqLlfS
         5kKTwlGEMBdbp21Sv+fMai2DZeJRO4QG6m0OjXFIhcwhJMkjvaIh8oz60/psG8EpquPm
         LX7Cg8EtmpA6gAykeP0nIg3rBNgA/D5RtYxwrqKJ8Qwz2fPvUtnfOnmtHuR1csmr9ICZ
         AQhVThvfRZHdJIFKlQmboKfTLuGCOPX+SXcKOYKPaJXqWF5t1OHMxOsuIAqNcu3GmXQU
         dRJWXa70WfEjX/QaNAm0m8Yl5bA7Vo+hgbXxOn9ZDaVXPbr5+3TEWrsypYG8+77tfZhP
         K5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qRQr++amLox9FBhB8MmGXvsCYPFE7KYes9F6TU7bBU=;
        b=UP8oOhjaMAhxVHnZ3DUWzxGUWQloc3YsTam6cf09P8a+HAQlVKfM94fN+UmdPDAgtA
         WoiQvb1l59fZsiFUEBuFEN+xgJycOnoj+J/O83zsJLNWHS5JEvkBei/zxabpGTSrahpP
         ibZQswNHFMk8ABxqCAC0+Kq0gl43oRN6bVq4m5ZEwBhB4Ogyj7KTMBAVbkjZNx2CcS9w
         TBzPcksQj2UNckoPVBfou6alcUVxqdb7roMMF726B2S0o7ZeOSmua/kIHvy1ePCynIel
         GvnBupaLwMl2HHX6wUeUp80jUwgocp/anDC/EkexPA7vc00AP8MYwa060yZ1kSvvPZVJ
         UhYQ==
X-Gm-Message-State: AOAM533glU2Z48nOlfkx4kFwk8r+x/rXfrOkqTeuDK4Tq/dzDEsCqLB8
        7FQiq3eLhnvL3NjcYp3jf+s=
X-Google-Smtp-Source: ABdhPJyxBKZvv11/Drc8tPzs/KkvmVJ1l0obTFa6IkjPNL1Gv6dSgxenL8FYPb2lBfSIsTMJi/Z7Ig==
X-Received: by 2002:a37:4d11:: with SMTP id a17mr13770749qkb.448.1605532321688;
        Mon, 16 Nov 2020 05:12:01 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id a200sm12268225qkb.66.2020.11.16.05.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:12:01 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH] MAINTAINERS: Add Kamel Bouhara as TCB counter driver maintainer
Date:   Mon, 16 Nov 2020 08:11:41 -0500
Message-Id: <20201116131141.3985-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 913b5eb64e44..18d34536c4bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2095,6 +2095,12 @@ X:	drivers/net/wireless/atmel/
 N:	at91
 N:	atmel
 
+Microchip Timer Counter Block (TCB) Capture Driver
+M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/counter/microchip-tcb-capture.c
+
 ARM/Microchip Sparx5 SoC support
 M:	Lars Povlsen <lars.povlsen@microchip.com>
 M:	Steen Hegelund <Steen.Hegelund@microchip.com>
-- 
2.29.2

