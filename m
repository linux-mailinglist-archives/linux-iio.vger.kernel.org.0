Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393BD9DC24
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 05:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfH0DxX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 23:53:23 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:43841 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfH0DxW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Aug 2019 23:53:22 -0400
Received: (qmail 16244 invoked by uid 5089); 27 Aug 2019 03:53:20 -0000
Received: by simscan 1.2.0 ppid: 16185, pid: 16186, t: 0.0317s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
X-RBL:  $rbltext
Received: from unknown (HELO preid-c7.electromag.com.au) (preid@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 27 Aug 2019 03:53:19 -0000
Received: by preid-c7.electromag.com.au (Postfix, from userid 1000)
        id C888C2021C4C5; Tue, 27 Aug 2019 11:35:28 +0800 (AWST)
From:   Phil Reid <preid@electromag.com.au>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, michal.simek@xilinx.com
Subject: [PATCH 0/2] iio: core: Add optional symbolic label to device attributes
Date:   Tue, 27 Aug 2019 11:35:22 +0800
Message-Id: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
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

Phil Reid (2):
  dt-binding: iio: Add optional label property
  iio: core: Add optional symbolic label to device attributes

 Documentation/devicetree/bindings/iio/iio-bindings.txt |  5 +++++
 drivers/iio/industrialio-core.c                        | 17 +++++++++++++++++
 include/linux/iio/iio.h                                |  1 +
 3 files changed, 23 insertions(+)

-- 
1.8.3.1

