Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CCA182B5B
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 09:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCLIft (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 04:35:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56226 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgCLIfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 04:35:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so5064364wmi.5;
        Thu, 12 Mar 2020 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xnbWFaqEy6PVLM8ZKG+N67R4SBBzTWWNlJtBlkSfr4=;
        b=hdL3sIWNGehfaGTVgPuBHGHLl3PlZfEX7+AqddpIlo3ANOIVwEZ/oKAYhtOeoBuraP
         HevwcaqxZOwXd7vbTvCDxn+FJ3dvQ6Df57sHYcqDFqSehC8I4denOatE11/7GT9u53Uo
         IPh2ArSScSbJ8EWsweryVxLsHSr6zD/8FnNwnXP1TuN79O6qn8ob0C5Qt20BRYPPObUD
         Sxdsy09T1G48mKYcssS49An8elLH0/bUV3x22C9E6/AsMG3ePkQnAfspKmdPO6opZm3q
         inICtHeYWVpLoI2PJ6OtkWXH+N1ZjAzrl8Lzj6OdI7wAKxl3a5eT4qR5SamWS5EwgZHi
         RSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xnbWFaqEy6PVLM8ZKG+N67R4SBBzTWWNlJtBlkSfr4=;
        b=Qfir6acvjzzSC/qMyBgsmt2YVoj6nKRR6FcNa4ooAcMmmIkvO8J2jTtYSNuOXzOzAi
         Cm++NZM4MGhuLa05QPHKSkbHMFukziYAl9+P4g1mVlpD3pdh56sihLkvwhEYyXpG7NQJ
         6o/423BVAK5Ttd8C8N3SpAv0+5ZPOU+NUgoxGu/08Z1w336hny9e0gAFbXw9jMkP8yDy
         Fz8mR7l2AaG+3S5Hmr/ZHjbG0fajNAfjkUoIif+Q1hgIHyrYuJZ/BOMjJg2soMLJyGYU
         1RbEKuIoUfk4DY/bhO0K3uzvbHlaoWN1tkAxS0DxTGrjAjxoqrrzwDyJNubAMmHXEw3G
         dMpw==
X-Gm-Message-State: ANhLgQ1ILQzwfTAivHEnthwRl0KIPpC+OBqplbcmFtK8ETqyAx3fVada
        h7MzwKwz5HODjg9NiKSwjR5uFXkQ96A=
X-Google-Smtp-Source: ADFU+vsjGoCDj6Iuuk7oGFiA4MePQLwrhjC2f6g9Xa0yJMjVHZGTOZkpPIOWbx2ra/tb9uW2THVaJQ==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr3577838wmh.36.1584002121454;
        Thu, 12 Mar 2020 01:35:21 -0700 (PDT)
Received: from localhost.localdomain ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id 9sm11543334wmo.38.2020.03.12.01.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:35:20 -0700 (PDT)
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
Subject: [PATCH v9 2/8] include: fpga: adi-axi-common.h: add version helper macros
Date:   Thu, 12 Mar 2020 10:35:05 +0200
Message-Id: <20200312083511.28832-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312083511.28832-1-alexandru.ardelean@analog.com>
References: <20200312083511.28832-1-alexandru.ardelean@analog.com>
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

