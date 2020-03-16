Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5D186F4C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 16:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbgCPPu5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 11:50:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42756 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731890AbgCPPu4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 11:50:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so21891710wrm.9;
        Mon, 16 Mar 2020 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xnbWFaqEy6PVLM8ZKG+N67R4SBBzTWWNlJtBlkSfr4=;
        b=sdMrPmsUMcuYYTgsmg+zH1y3mE73L1A2luLZgGCiMM/I3s736IfmJJ+BtcXcD0aqZS
         MdI3ROHcIlS3aWUaAvwKkSNm3XAQ641SUvsD7vE2L1hWKMf09pbmSM2IvpMl3Q27SKgH
         WymZWRnt2JNorRQcIiJOZXahYLVi7EpdH5jc++dIRfKQMYNa3AytasAfjK2CLmlOJt7l
         w2PpIhvb8pLu3y6hb+xTM8etvBgN6V+Ivn4Y7JVD0XWj9EUCalPEpL8LVRas+/WTyDZ7
         viK1GaXtpr7tU5dcv+zr5kfVRQfM1Ae0IM5ta2GO/zmkEjeGJGK1LduV+WnelN05aqzD
         xH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xnbWFaqEy6PVLM8ZKG+N67R4SBBzTWWNlJtBlkSfr4=;
        b=kleTmKhHxUB5jNyD13/3kaC5NKUm11gVvNxK/KPajW5usz5O+1Y7yCkSMKhQYJ6RGY
         8rgaF2EirvobgtNbLjexFnH725mO5Uff9h8/hdvWJu3D8uZjF9X9OzCR1CPFfA+5jkUC
         Sd1kJnnMlZ/PXpK8zb1DJCz6URsiHfpiwWKaz/DBLaKBLmS6cQVcROBnJy6mYXNxOYKp
         F0wbxj9rasiC5NfI8Cq2w9g+lnZxYcCpnnj1CrEcHHjY6DIqtHzOMhEikMOfs5Lr0OIc
         atLd7Xm8MljBN/Iig54PRjmjWu+AspSDFfw9IBqRmcxVl+AonmamgPvdmON0zGTFigGg
         d4TA==
X-Gm-Message-State: ANhLgQ3454zrKHuUHziojzGxfT2MHkf5Be8AawDsCCffpgNr3d8EFQxs
        k2oVNPCsI/yOQfvvak/0Fl6rCJIa
X-Google-Smtp-Source: ADFU+vull3v7slEnRUkbqO0h19tyS3WmuX1jJ4RdE0ety6S1F3oAqs3/fGOKTAlSiRU8p8LQAiGhJA==
X-Received: by 2002:adf:82b0:: with SMTP id 45mr36236wrc.120.1584373854302;
        Mon, 16 Mar 2020 08:50:54 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id n14sm153558wmi.19.2020.03.16.08.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:50:53 -0700 (PDT)
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
Subject: [PATCH v10 2/8] include: fpga: adi-axi-common.h: add version helper macros
Date:   Mon, 16 Mar 2020 17:50:29 +0200
Message-Id: <20200316155035.25500-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316155035.25500-1-alexandru.ardelean@analog.com>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The format for all ADI AXI IP cores is the same.
i.e. 'major.minor.patch'.

This patch adds the helper macros to be re-used in ADI AXI drivers.

Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/fpga/adi-axi-common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
index ebd4e07ae3d8..141ac3f251e6 100644
--- a/include/linux/fpga/adi-axi-common.h
+++ b/include/linux/fpga/adi-axi-common.h
@@ -16,4 +16,8 @@
 #define ADI_AXI_PCORE_VER(major, minor, patch)	\
 	(((major) << 16) | ((minor) << 8) | (patch))
 
+#define ADI_AXI_PCORE_VER_MAJOR(version)	(((version) >> 16) & 0xff)
+#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
+#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
+
 #endif /* ADI_AXI_COMMON_H_ */
-- 
2.20.1

