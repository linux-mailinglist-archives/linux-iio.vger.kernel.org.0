Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E9842016D
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhJCMPb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 08:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhJCMPb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 08:15:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6B06611C0;
        Sun,  3 Oct 2021 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633263224;
        bh=35nnMRDj5kylJXFuz8iYzx66KGRy+jcLf/tsXrF8eD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqyOU9ma/3sL6JMNHf3Kssn3IcSJxTXEB5PPlJdm/oa5y4K+G7dzDSA7seeeS0eEp
         JrlIwJSvEgLtljT7f4WJc3B+1ZntlsvaoXI++xxtmGHwBjC35g4SN7Uq7j73MkW4In
         lvvhqoS6MPIi4DkFzTGSr7vGi+lNW9SzTJ/OMhKHZInT/VfZCVAC3+ScJfiwI77KVV
         iqXq+6Hv8s5/JQq1s2Jaekl//WwkM9M5oLymmPsmq5IGUaa5hiwcAWK8b9N4S2rdEz
         S9q64NtwMAc7yIyKFUnDGaN6NUfq8UMH5Tw9yvzirm3BOY2YI9qRn4zsQMenL7u2z9
         aTwFiC3+aQpoA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/7] platform/chrome: cros_ec_sensorhub_ring - avoid including iio.h
Date:   Sun,  3 Oct 2021 13:17:05 +0100
Message-Id: <20211003121711.279736-2-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003121711.279736-1-jic23@kernel.org>
References: <20211003121711.279736-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

struct iio_dev is only used in the platform code as an opaque pointer
type so let us add a forwards definition instead of including the main
IIO header.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 98e37080f760..26ab852e1e1f 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -7,7 +7,6 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/iio/iio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
@@ -19,6 +18,8 @@
 
 #include "cros_ec_trace.h"
 
+struct iio_dev;
+
 /* Precision of fixed point for the m values from the filter */
 #define M_PRECISION BIT(23)
 
-- 
2.33.0

