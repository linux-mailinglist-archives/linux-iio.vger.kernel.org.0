Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B424E6216
	for <lists+linux-iio@lfdr.de>; Thu, 24 Mar 2022 12:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiCXLHe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Mar 2022 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbiCXLHd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2022 07:07:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145019A9BA
        for <linux-iio@vger.kernel.org>; Thu, 24 Mar 2022 04:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56053B820C9
        for <linux-iio@vger.kernel.org>; Thu, 24 Mar 2022 11:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A19CC340F2;
        Thu, 24 Mar 2022 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648119957;
        bh=WlyAg91YjBCylMIKldKe5/6DnEurg/tWKg3D5WTUwhI=;
        h=From:To:Cc:Subject:Date:From;
        b=RNSb+2lyjlISqA6UGtlFGVCxCQ5gGGrmG/XRdyt9R0/xg6dKaIkzR30cchCvXGn3P
         6T2yQKpxmGaekd+ISsJl+CG+zEaNDTKw701wuIiy6LeI045GYWwR6flbTgQQhi/jsF
         h6c5PF6zFTD58IgNQuXoSuUOF/jwMwF7PPQC6MBhQUIsGi1L8nKUDtBij4Y4l2c7ZG
         hZxDaynRzJYkdEzPLOehiy/9j4CmVxAGzzR4MGxc41ItiMsxhpAMvlBVXlUyIpHVN4
         ceY75vUwfXKqJZ+hrknU9kVykESCEAD2NfyvE0WlXGNN5hQ/hOBRDYIY1MtpaYh7co
         ivZun1F9nNseA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] MAINTAINERS: updated Lorenzo's email address
Date:   Thu, 24 Mar 2022 12:05:43 +0100
Message-Id: <c75f0e1c683b6ad0333d5504fb00c6f1b14dd1bf.1648114531.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Using my kernel.org email for iio devices.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1dfb3fab5f8..2c4fa8eb1e9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8915,7 +8915,7 @@ S:	Maintained
 F:	drivers/input/touchscreen/htcpen.c
 
 HTS221 TEMPERATURE-HUMIDITY IIO DRIVER
-M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	http://www.st.com/
@@ -18399,7 +18399,7 @@ S:	Maintained
 F:	arch/alpha/kernel/srm_env.c
 
 ST LSM6DSx IMU IIO DRIVER
-M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	http://www.st.com/
-- 
2.35.1

