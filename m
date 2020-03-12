Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33914182B43
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 09:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgCLIfX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 04:35:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44648 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgCLIfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 04:35:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id l18so6214645wru.11;
        Thu, 12 Mar 2020 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sc+ZcHvv4+8Y0JehjCkVMYBTnshyW1dRffEc1sDr2kY=;
        b=cBt/nf07cfPvPHFHC9IdWDrxvDOJRqwBlGQE5eFmFXv/bzoBVSChf3BLbYu/Zp5ygf
         uesy7OOJKb23uz7xctfhdY7Dk1pE05o+lOrWczNdnXV5XvWlqxCcBnP7oU4Iz+qoIICg
         F6oAQtqxivabsR+F2f5kwesho0Jty1nUDcjL6+keOlj1CN8NEHRC6yiXHlycJI0ZEcoU
         EQlvrEbDMxXhiCRfB+nZyaQugTK9KS0escIJgVJBDOUw7T74VdakviLO3aZ82VTUHyZq
         +5cDY5z84hJWAN+WEIaZ8OFm7qKiyn79561sJ53m4JCzroe+DtCoFdYsyXC5ktBLmOgz
         5uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sc+ZcHvv4+8Y0JehjCkVMYBTnshyW1dRffEc1sDr2kY=;
        b=WkcWgh1F9OZByCPXauZrcA7BnBJTQeV46brp1rA/awjArsQZj0cT5BRmXHl+r/FZbu
         R3cLkJn2HTzRdlQ0Xs2H2WpWTsZE58oh8yiSni/vg0FnvwqWv+515ROybgBRHNry03zB
         GJvCsNRLVGMQTHOMI8SYG4fr/klXtVWw0om9+UiXO8xZviY2Lf3TTLfl8Qe0cljDESyy
         wyAYzbIOJCn7+zf+ablUTvzBFmF3UGYht8dHgL+sNQJZFZMTiJaEWw7I0mspWF2Orlgq
         zqFxiks9mCRYsKczUeaYICGMOxIh4/Imt0YXhZIRc0RK0+xGMCABDqDSZW/qsr4KaBoo
         jytw==
X-Gm-Message-State: ANhLgQ3teMRnH+zshypxQbObTd/7T7kMCOmbQKLJArK8ixbARBtKgdw+
        I7FKLds7Rtp5J75zGp57Jc3wMcc7pU0=
X-Google-Smtp-Source: ADFU+vsE7CKw0z7E9j255GcPqiZnSdEVpBlkVnUDYIzlFyBHlAwhZIDYsfICUgS9rb+0R59WlO0poA==
X-Received: by 2002:adf:b317:: with SMTP id j23mr9713915wrd.413.1584002120044;
        Thu, 12 Mar 2020 01:35:20 -0700 (PDT)
Received: from localhost.localdomain ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id 9sm11543334wmo.38.2020.03.12.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:35:19 -0700 (PDT)
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
Subject: [PATCH v9 1/8] include: fpga: adi-axi-common.h: fixup whitespace tab -> space
Date:   Thu, 12 Mar 2020 10:35:04 +0200
Message-Id: <20200312083511.28832-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312083511.28832-1-alexandru.ardelean@analog.com>
References: <20200312083511.28832-1-alexandru.ardelean@analog.com>
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

