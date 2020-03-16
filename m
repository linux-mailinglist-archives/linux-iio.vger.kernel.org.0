Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B96186F4E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 16:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgCPPu5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 11:50:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgCPPu4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 11:50:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so5444170wrv.13;
        Mon, 16 Mar 2020 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sc+ZcHvv4+8Y0JehjCkVMYBTnshyW1dRffEc1sDr2kY=;
        b=dTDLtXVydfEWfNwQPdHS/TVXS8K4X5b2dyAgi+PH83Yy1orjNvReI6XewzPcpM9F4Z
         leif+mmesRlNXmcGW1SQBHx9V55uFWBhV2dmkRyNi3BilFufwnCNcIqETbXLbrIBtwSe
         qk/IVL3F0z37sBFDrOFnBkWX29Ngwv7zrMtPjhH+HuC1XI04osdwaJfLWhzgd5YII1sX
         7S1DQZ7PvMKEVr1Dm11WNTNmwKPWIWclMU2OnlCaS5s/TPpdHH0lhxL6t1VcAUNPWBCf
         3Y5o02Masm+xUNZmVfLGKrmsVK9SX8JCX5tGH/D32m0/yra6slQO8La0oPj4WA3yegU1
         dVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sc+ZcHvv4+8Y0JehjCkVMYBTnshyW1dRffEc1sDr2kY=;
        b=Mb85z0+DDJNNxuOZ7Vjxww8sYfWjMga2NXwxw9jke2HNDm4b5PXBpqy0Fb5xLsEKI7
         4l6ckAMtILueSiFNpIt+SENa0rhi6tBuadjBEWsFEw1upMNJ02Fd7wooSDTyUvSDwca5
         WfzY3+s7ZSYyqOwP3dqxAK47ih1vG0h5GcUic/Vq2dXmgz8zvZzXEKjez/AGuk5VZ6pp
         7Q2ctrHa0Zu6acZRJrnF1GN2QacT5h5NFq6u3qeKXQoDN0D9PlI5pFiHWr30xWlUcxa2
         U8XS0BtSCBduOdavW5bVaniNw3a8ZZBenYHXwJdgBJkhXF5jIEpq5BHdbAiFx3ygQHdH
         u7lw==
X-Gm-Message-State: ANhLgQ3/8TRlhcVoer9IbJNS7DpYfWUfqt6LwXcN1uW9Bpipx+3DjFqJ
        8WRi4k0L0El0wntn3bIoJVDjoozX
X-Google-Smtp-Source: ADFU+vsUuW/mW+LXvQ6EtgDJhs7hvA0yq36iEyxmu9lHhYAL0Mh+a/fvtn5Xr3CYJEYL/zfrBz9Ofg==
X-Received: by 2002:adf:80af:: with SMTP id 44mr37122427wrl.241.1584373852848;
        Mon, 16 Mar 2020 08:50:52 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id n14sm153558wmi.19.2020.03.16.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:50:52 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com, Michael.Hennerich@analog.com,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v10 1/8] include: fpga: adi-axi-common.h: fixup whitespace tab -> space
Date:   Mon, 16 Mar 2020 17:50:28 +0200
Message-Id: <20200316155035.25500-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316155035.25500-1-alexandru.ardelean@analog.com>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The initial version use a tab between '#define' & 'ADI_AXI_REG_VERSION'.
This changes it to space. The change is purely cosmetic.

Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/fpga/adi-axi-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
index 7fc95d5c95bb..ebd4e07ae3d8 100644
--- a/include/linux/fpga/adi-axi-common.h
+++ b/include/linux/fpga/adi-axi-common.h
@@ -11,7 +11,7 @@
 #ifndef ADI_AXI_COMMON_H_
 #define ADI_AXI_COMMON_H_
 
-#define	ADI_AXI_REG_VERSION			0x0000
+#define ADI_AXI_REG_VERSION			0x0000
 
 #define ADI_AXI_PCORE_VER(major, minor, patch)	\
 	(((major) << 16) | ((minor) << 8) | (patch))
-- 
2.20.1

