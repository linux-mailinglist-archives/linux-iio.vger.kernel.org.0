Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BCC55B2FC
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 18:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiFZQpt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 12:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiFZQpt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 12:45:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7DD11A
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 09:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3698AB80D32
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 16:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C72C34114;
        Sun, 26 Jun 2022 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656261945;
        bh=a18Sxfwzln9fD8DvRmRTzjoLVe5ejibPo5+MwBQ+dqQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jwfr/0JDjsRkm2KT1HZsnCLnpxUNqMoxztIHBX1x9C71/7q9hFrT+SvJP1AR0LWCs
         42EaOHTeWvtqt00WsvusfANt53GHK7WCMgQ8B4X/vV51sk89woT3R1r9wloBhKDvik
         q6IkMP5EA+q9zX9MCOphx1QMGQ6ZTN0DXyy/outerGPt/06+D0/cpHFI4STpXidMZB
         Zz4rYpwlW3AYz3C+xFxIO/wQJAJoJdqo2M7gSIn8FB2HL6i2+LGXIJoG4+oDIRNofH
         +58GYfZlYwmn6pJqE2GQOjKxlF+2P75ivqEn8j5oxjh0fRtjAqg2LYYOSo0DYrCkTc
         i0NYqrReXla4w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/4] IIO: Some documentation error and warning fixes.
Date:   Sun, 26 Jun 2022 17:55:07 +0100
Message-Id: <20220626165511.602202-1-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
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

Mauro Carvalho Chehab highlighted some outstanding IIO documentation
issues in a thread on generally reducing the warning splat that is
a documentation build.

The fixes aren't exactly ideal, but they are necessary to get these
last few cases in IIO to not generate warnings.

https://lore.kernel.org/all/20220626085524.42ee92c0@sal.lan/

Jonathan Cameron (4):
  iio: ABI: temperature: Unify documentation for thermocouple fault
    detection.
  iio: ABI: max31865: Drop in_filter_notch_centre_frequency as in main
    docs.
  iio: ABI: stm32-timer-trigger: Fuse unusual ABI into main doc.
  iio: ABI: sx9324: Squash some formatting to keep scripting happy.

 Documentation/ABI/testing/sysfs-bus-iio       |  3 ++
 .../ABI/testing/sysfs-bus-iio-sx9324          |  2 +-
 .../sysfs-bus-iio-temperature-max31856        | 31 -------------------
 .../sysfs-bus-iio-temperature-max31865        | 20 ------------
 .../ABI/testing/sysfs-bus-iio-thermocouple    | 18 +++++++++++
 .../ABI/testing/sysfs-bus-iio-timer-stm32     |  8 -----
 6 files changed, 22 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-thermocouple

-- 
2.36.1

