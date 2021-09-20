Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331D841161B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhITNzJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 09:55:09 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51131 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhITNzJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 09:55:09 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8569F240010;
        Mon, 20 Sep 2021 13:53:40 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-iio@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v6 4/4] iio: ABI: Document in_concentration_co2_scale
Date:   Mon, 20 Sep 2021 15:54:13 +0200
Message-Id: <20210920135413.140310-5-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920135413.140310-1-jacopo+renesas@jmondi.org>
References: <20210920135413.140310-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jacopo Mondi <jacopo@jmondi.org>

Document the 'in_concentration_co2_scale' standard IIO attribute.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6ad47a67521c..f19ff76a3b54 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -429,6 +429,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_angl_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_x_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_y_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_z_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.32.0

