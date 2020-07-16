Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48BC2224C5
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgGPOBu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgGPN7h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C2CC08C5DD
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so7161899wrl.8
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZqUJm7bYgsZ8KeaAgk3CGTLQbMlyTjU1eHGwM4twhc=;
        b=u/3C4sQeGVtp5QvH0BG2uoM++8foxBBivmq7LztkEXFIjki8OKzHY/suLvH5GlFSJT
         aBPb8mYlBq8sk4rysEi+xShx9QDkOgpAXDgfzGOVBtNlra+4ezfqAkdcOUqyBgTIFRRO
         4oJX7VzO3ZAONnoykr7CgGQm/H03O6Dn1NGoipxSA/Flqg7j7jb22km6l+qipJml0bGf
         t/o65W9rL1PdHK/mW0WZlFIXY0YpWsWlU66jqnlFaGND/3nGEgDJQSiZLdvparA76LyR
         L3vFWevr+rMooQIx8K9I0Cv2RYAoyKseOHsFhMDGTuB0slHfj/4es1KnEod2lslLNoST
         xBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZqUJm7bYgsZ8KeaAgk3CGTLQbMlyTjU1eHGwM4twhc=;
        b=ITnEHpIVyjb2x+sxQDVbw8WfuOy7cybXv3Hmqmm1WvYBmKLP2EkN5LxEh0pmS7ZDNz
         +ytSn5FFgajC8dFrjUzyNZTF/UuLUnWDoxALtupmSEbjwqa7tDvX5GfdMg6aW9zwdEsD
         y8rpa3UHRjlD2Gg0IqXMYH3mn7ot039ZfDJKBvQdPPxgyY8gWRkDK/svreLztVCaklee
         NqB2l1Vj0TpekX8bYh4zjgIYtj/PEgVphIlDX016bzKuuO+2qRO4W7vIMd0+bCmiAdI+
         B38UbrBi9QUt8hnbvp0KFUugB05qmy5xQXHrvxFEceQ6/BwCQlHILZdcX55FAIAcNhhg
         SQQQ==
X-Gm-Message-State: AOAM532cVo0Ewta8LkCDgAx+pzgaPHGu1jvlmAOLBPpdH7fg18bB6Cjm
        V+ee+f3NAvMOqBarLqWlnYyuqQ==
X-Google-Smtp-Source: ABdhPJzoybcvPp58Q0rumnOu7a78XDNKPWdg9tdSi33Mheeo0/bn1IcCnvlOajQjQtmD8Y+8YcwWVA==
X-Received: by 2002:adf:8521:: with SMTP id 30mr5016609wrh.238.1594907975545;
        Thu, 16 Jul 2020 06:59:35 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        William Markezana <william.markezana@meas-spec.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Subject: [PATCH 03/30] iio: common: ms_sensors: ms_sensors_i2c: Fix misspelling of parameter 'client'
Date:   Thu, 16 Jul 2020 14:59:01 +0100
Message-Id: <20200716135928.1456727-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Probably due to docrot.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/common/ms_sensors/ms_sensors_i2c.c:186: warning: Function parameter or member 'client' not described in 'ms_sensors_read_serial'
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c:186: warning: Excess function parameter 'cli' description in 'ms_sensors_read_serial'

Cc: William Markezana <william.markezana@meas-spec.com>
Cc: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index b52cba1b3c831..b9e2038d05ef4 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -165,7 +165,7 @@ static bool ms_sensors_crc_valid(u32 value)
 
 /**
  * ms_sensors_read_serial() - Serial number read function
- * @cli:	pointer to i2c client
+ * @client:	pointer to i2c client
  * @sn:		pointer to 64-bits destination value
  *
  * Generic i2c serial number read function for Measurement Specialties devices.
-- 
2.25.1

