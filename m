Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF63A55B2F0
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiFZQp5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiFZQp4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 12:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44DD11A
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 09:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BF24B80D38
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 16:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED48C385A9;
        Sun, 26 Jun 2022 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656261953;
        bh=ZY19fXt0aAtMpIahGd5nNw9Oz6qYoxqQ/fP98SnyAzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgnJFnr4ovWdk4xLxgAzZMvKN6AcFfESye7BRnEjeMarYjg+TnYAx2kLUsBAnUTLO
         aWfSs0chyBsyhVh2Nt0Zu6YmK7IOdXDYNMGOqGKKegeULbujSC5h8a1XKin//7wAR7
         3DByJSDOzb1TEDhjekWBZ3p4IRRxcAb4/FCjTdjZpKzeCRGk/WKyRst98vnVvMKLkr
         7OeqHK5BhTbCs+N1F2vPNx+AN0t+7HYUn0t2XtOo9Zx1SsD8BXbb1ACOsU3MMpEMK3
         TBzWNnu0cKCp8GvVIRRLcZyXm3BVaHSk88KEOpufL25ikDI47TPpnBH1MrToCEAMGY
         NRCmbtN9AoJ+A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 4/4] iio: ABI: sx9324: Squash some formatting to keep scripting happy.
Date:   Sun, 26 Jun 2022 17:55:11 +0100
Message-Id: <20220626165511.602202-5-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626165511.602202-1-jic23@kernel.org>
References: <20220626165511.602202-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The indenting added in here to give bullet points is nice to read
but unfortunately our docs building scripts trip up on it.

make htmldocs gives
../iio/Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: ERROR: Unexpected indentation.

So drop the pretty indenting to avoid that error message.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
---
 Documentation/ABI/testing/sysfs-bus-iio-sx9324 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sx9324 b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
index 632e3321f5a3..9c1e8884a738 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-sx9324
+++ b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
@@ -8,7 +8,7 @@ Description:
 		+ not connected (HZ),
 		+ grounded (GD),
 		+ connected to an antenna where it can act as a base
-		  (DS - data shield), or measured input (MI).
+		(DS - data shield), or measured input (MI).
 
 		The sensor rotates measurement across 4 phases
 		(PH0, PH1, PH2, PH3), where the inputs are configured
-- 
2.36.1

