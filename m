Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9025AB7CFB
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbfISOgT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 10:36:19 -0400
Received: from anchovy1.45ru.net.au ([203.30.46.145]:52679 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732590AbfISOgT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 10:36:19 -0400
Received: (qmail 12600 invoked by uid 5089); 19 Sep 2019 14:36:16 -0000
Received: by simscan 1.2.0 ppid: 12571, pid: 12572, t: 0.0425s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
X-RBL:  $rbltext
Received: from unknown (HELO preid-c7.electromag.com.au) (preid@electromag.com.au@118.208.174.34)
  by anchovy1.45ru.net.au with ESMTPA; 19 Sep 2019 14:36:16 -0000
Received: by preid-c7.electromag.com.au (Postfix, from userid 1000)
        id D0C41201AF901; Thu, 19 Sep 2019 22:36:11 +0800 (AWST)
From:   Phil Reid <preid@electromag.com.au>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, michal.simek@xilinx.com
Subject: [PATCH v2 0/2] iio: core: Add optional symbolic label to device attributes
Date:   Thu, 19 Sep 2019 22:36:06 +0800
Message-Id: <1568903768-65998-1-git-send-email-preid@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined in the device tree for this device add that
to the device specific attributes. This is useful for userspace to
be able to identify an individual device when multiple identical
chips are present in the system.

Similar to leds, display labels etc.

Changes from V1:
- Update commit message for dt_bind commit
- Update example label for dt-binding

I haven't added Rob's reviewed-by from V1. Wasnt't
sure if the changes are minor enough to keep that.

Phil Reid (2):
  dt-binding: iio: Add optional label property
  iio: core: Add optional symbolic label to device attributes

 Documentation/devicetree/bindings/iio/iio-bindings.txt |  5 +++++
 drivers/iio/industrialio-core.c                        | 17 +++++++++++++++++
 include/linux/iio/iio.h                                |  1 +
 3 files changed, 23 insertions(+)

-- 
1.8.3.1

