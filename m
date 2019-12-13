Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5111ED05
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 22:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMVie (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 16:38:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38614 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLMVie (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 16:38:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so239707ljh.5;
        Fri, 13 Dec 2019 13:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y86PGUOJFu4Nbt3m0kvi64VQcwic1XP4LIpShdnKRtA=;
        b=qzjGSX2gDRNFEmHjyKUx0FBTw7Nlc6Jj4RkpZbtrFxIHBtu3W7mfPFq/INRRnIWXpv
         q3EnclXxtLeA8pO9476tQWfZj93/zd68mYkhyCDhoA4XLhZO9p6rs4NYwJZDAwAeQiq7
         IkpAOnPIbZbb2byW17mIQf7bJ5senF4ADPzQvVF5D68Szz2WyTORzlHIjoRr2nNkuORW
         blKz1G/yAXNE+8Jy5vxlpFY+DfhqDZ8VtgSjKCjKG3PysAIqhXEnFSsWrGsiqaZSJmwV
         z7p/JKYVD674dJM5aFEa8zUtqTPFoUwedsYr3Ol3lTh/OVi/zEkQhO8W1RKdNuStaVJJ
         xjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y86PGUOJFu4Nbt3m0kvi64VQcwic1XP4LIpShdnKRtA=;
        b=b1oznj31ic8yNi8cTDKX3QfhHeBZKjoUYLECGvM0baJo2Hf5888239RrxVSqO+TBKn
         pwNAiKWpVOsBUTHfn865Uvg+vcexPoIeUctWZi+Ho4N9/ARqUwgVo2Axl5mQ9jHW6i2W
         B34UElxwHCAy9uUm/5wJU2xC7rrC1r7X4l8hmKN1lwpzZiXnPHh5/YiecW376LzLLkoI
         M3OWvLmIof3rBHRMHnZdwLumDsZBRh3WwfWzXyQmRW866Ta3bWxc5SV7NN47pzriEpEk
         EDM9Q15UkzjTidqRNeJJvgZImpv9nKF9fnZrfQRappzEw6cwDYpCTrONHZXSVda+0iq5
         hQEQ==
X-Gm-Message-State: APjAAAUfIzLvvh1xpKbIEUIWtPsCXH5Lf0LapaLEwQl0Hgudu7Fjq1yC
        n43hZpsWlIJ5pumuo3LRSexkwwaf7JA=
X-Google-Smtp-Source: APXvYqyg0LXC+lbi3R2tD+KKOVp2PLEVaLMHO/W8vq+h3dKb0hdn37FOa5sHSBXS44uD2XmboYswxQ==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr11234363lji.103.1576273111651;
        Fri, 13 Dec 2019 13:38:31 -0800 (PST)
Received: from arch.lan (89-70-31-203.dynamic.chello.pl. [89.70.31.203])
        by smtp.gmail.com with ESMTPSA id q10sm5474436ljj.60.2019.12.13.13.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 13:38:31 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH] iio: chemical: pms7003: fix unmet triggered buffer dependency
Date:   Fri, 13 Dec 2019 22:38:08 +0100
Message-Id: <20191213213808.124603-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO triggered buffer depends on IIO buffer which is missing from Kconfig
file. This should go unnoticed most of the time because there's a
chance something else has already enabled buffers. In some rare cases
though one might experience kbuild warnings about unmet direct
dependencies and build failures due to missing symbols.

Fix this by selecting IIO_BUFFER explicitly.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/chemical/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index fa4586037bb8..0b91de4df8f4 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -65,6 +65,7 @@ config IAQCORE
 config PMS7003
 	tristate "Plantower PMS7003 particulate matter sensor"
 	depends on SERIAL_DEV_BUS
+	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here to build support for the Plantower PMS7003 particulate
-- 
2.24.1

