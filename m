Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FEF4047F8
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhIIJqR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Sep 2021 05:46:17 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57119 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIIJqQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Sep 2021 05:46:16 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5E38A40015;
        Thu,  9 Sep 2021 09:45:05 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org
Subject: [PATCH v5 4/4] iio: ABI: Document in_concentration_co2_scale
Date:   Thu,  9 Sep 2021 11:45:37 +0200
Message-Id: <20210909094537.218064-5-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210909094537.218064-1-jacopo@jmondi.org>
References: <20210909094537.218064-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

