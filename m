Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC6525A021
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 22:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgIAUlQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 16:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUlP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Sep 2020 16:41:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35179C061244
        for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2020 13:41:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so2398665wmi.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2020 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xK52mftsCRVzWiwVPZmYvoBCZt0T9LOCHnsiUo7NXFE=;
        b=lBp4aK8yD5XvQyrhlbY0RcYFZSwxn16omu3hNU3FGeh0MbV+Nco5cmAzBfXSb2pzC+
         RDnWL9C0h4kRDlMIns7zYeNpnuKjGKIEXo9cA1vKEVztW/eMXjspFkgiIxRMxIILhVcK
         yoFfzZw7MGMdUrhoxJxyd7zwP0ivbpYKlp/RGDYT0dHOicmE57cbor2FzKrAHsFacoiQ
         Fxp82zYXOvr3UT4LRUKT32LtVplSMuKNn7yhJzqbiyyUSka5qg6FbDqiI9NAKFwmRSuE
         TJsU/9avE07cvokoKrAwIvwWDXrfNx4FjsnPKWUwNLgU3B2nRaw05n7W816BPgwSWFO7
         kJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xK52mftsCRVzWiwVPZmYvoBCZt0T9LOCHnsiUo7NXFE=;
        b=Tod2SoBAH1aOlUq1iVjVuXpHEkL7ng3Q9EdFykImfh4dihk0ouz95vB14pfypquVHD
         f21NdPiWnNd7yAdRhfwT8+sIad+XMecHxBegp5Bus5qDP5qvZva97EnJ3afOtRQNHCIm
         HD3CyNOcfT0MI2uPkoR3rfYW3yZz2auyHNYwYldGchY2RqP9AIDIUNzCZFYequL12Ytc
         dIhAsbxSJIo/PMU7zfXWWeqQOO59gJHUVWKPzNEppRJNEFdoVriv7RBs4jvuQn9tVirF
         n5VMREZeZWJXa5veXRPfiG4MsuZq20evJxe8SaAnnfJMZVgR5p4ZDd0RTOYPQ/Ltf6ob
         ulsg==
X-Gm-Message-State: AOAM5301MyEh3Hznu2CHS+461SiEeBDelsvrPUH3tfeKwpgzw/QKKffd
        ii1L5MHv9f2ZeEdqzOONhXM=
X-Google-Smtp-Source: ABdhPJygO++wMoJ6r++cSDhPqp432t368KSZEg8XrpoDDEISyohdTx9E/L0adSakOu3CwdmPyLCJoQ==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr3606992wmc.182.1598992872743;
        Tue, 01 Sep 2020 13:41:12 -0700 (PDT)
Received: from localhost.localdomain ([170.253.38.159])
        by smtp.gmail.com with ESMTPSA id o124sm3218145wmb.2.2020.09.01.13.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:41:11 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        linux-iio@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Vicente Bergas <vicencb@gmail.com>
Subject: [PATCH] IIO: rockchip: add missing dependencies for saradc
Date:   Tue,  1 Sep 2020 22:40:54 +0200
Message-Id: <20200901204054.5334-1-vicencb@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver uses the triggered buffer functionality
but was not requiring it.

Signed-off-by: Vicente Bergas <vicencb@gmail.com>
---
 drivers/iio/adc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 66d9cc073157..cd90f60cdfd9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -865,6 +865,9 @@ config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
 	depends on RESET_CONTROLLER
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the SARADC found in SoCs from
 	  Rockchip.
-- 
2.28.0

