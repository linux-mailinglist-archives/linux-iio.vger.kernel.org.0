Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89B241BBD
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHKNtf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Aug 2020 09:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgHKNtX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2020 09:49:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5714AC061787
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2020 06:49:18 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s15so6739305pgc.8
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2020 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtoZgdCxmlb8CkD2/7ZKUfQQli1IVkgVJTucB0Lj3OY=;
        b=mbuUGGQVMoqjyiIDBbrwbzJQ0/nEZ8BejR53GtRTpC0JCwVaRG+gSTM2fr7Y4uPkjW
         XEw6n1cMekpu4wNr3ETyX83iIXB4YmCrhxG6LtiVX/0mQqRAxypvLlKAW3tYiP/hUIJg
         h8WxFszd4//e8wvQ0otEPelYm/erUyiVIIICQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtoZgdCxmlb8CkD2/7ZKUfQQli1IVkgVJTucB0Lj3OY=;
        b=Gv9DZvPzl906ZnCbUphPFqUzo0LXmB5t9nkhpcF5va0loj67nIYHO2o8AL+fCLlxyj
         X7AmVNyMpkS58a9TPnr7Uqxi4IRJP/8Sfxa/iDcoIQWtAeREzGb/B5TZkkOuurL7aSCm
         m24s6GTOWYIqKFqWCpAeO4bjBZqc1okonxFQAJNAC8bQaqO0uA8H9j/2OwhKr3BoqhJ/
         FvP61lDFk2klglRo0jZEFkZbycWd44BIqMyaYhdWEX3jvrr0LjBxTr9FBhMAZlnAJEjC
         J2rihQiJELN0PZ+oL7pZOkfIVtzBBD5bYwRMkFe+8zoxnOueDhEsemFDqS80uFcG0ZHQ
         T44w==
X-Gm-Message-State: AOAM532FVvLsplHITi0oU1x+0rkvVdm9c6z52uX5MZU2J3e/3Cyi2VPj
        93fR5O1q6ZlCje4gx/pTzen3wE6WsLk=
X-Google-Smtp-Source: ABdhPJzgqQeusTOFAH2uy9urFP8iyGVkE/fybPeLv7md190V6CoEjoOk9AF9+0oPOPOwA4PlG/2qjg==
X-Received: by 2002:a65:610f:: with SMTP id z15mr896514pgu.123.1597153755308;
        Tue, 11 Aug 2020 06:49:15 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id w23sm20884447pgj.5.2020.08.11.06.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 06:49:14 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-iio@vger.kernel.org
Cc:     daniel@0x0f.com
Subject: [RFC PATCH 1/2] dt-bindings: vendor-prefixes: Add vendor prefix for Silan
Date:   Tue, 11 Aug 2020 22:48:45 +0900
Message-Id: <20200811134846.3981475-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200811134846.3981475-1-daniel@0x0f.com>
References: <20200811134846.3981475-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a prefix for Hangzhou Silan Microelectronics Co., Ltd.

Website: http://www.silan.com.cn/
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f3d847832fdc..5d18c0607b05 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -934,6 +934,8 @@ patternProperties:
     description: Shiratech Solutions
   "^si-en,.*":
     description: Si-En Technology Ltd.
+  "^silan,.*":
+    description: Hangzhou Silan Microelectronics Co., Ltd.
   "^si-linux,.*":
     description: Silicon Linux Corporation
   "^sifive,.*":
-- 
2.27.0

