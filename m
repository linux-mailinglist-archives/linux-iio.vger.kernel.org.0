Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F73278DB
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 11:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfEWJI0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 05:08:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfEWJI0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 05:08:26 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B74EC280175;
        Thu, 23 May 2019 10:08:24 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] docs: iio: add precision about sampling_frequency_available
Date:   Thu, 23 May 2019 11:07:37 +0200
Message-Id: <c1c56310da539b6af66811084bd69806622e1903.1558601329.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1558601329.git.fabien.lahoudere@collabora.com>
References: <cover.1558601329.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The documentation give some exemple on what format can be expected
from sampling_frequency_available sysfs attribute

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6aef7dbbde44..680451695422 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -61,8 +61,11 @@ What:		/sys/bus/iio/devices/triggerX/sampling_frequency_available
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		When the internal sampling clock can only take a small
-		discrete set of values, this file lists those available.
+		When the internal sampling clock can only take a specific set of
+		frequencies, we can specify the available values with:
+		- a small discrete set of values like "0 2 4 6 8"
+		- a range with minimum, step and maximum frequencies like
+		  "[min step max]"
 
 What:		/sys/bus/iio/devices/iio:deviceX/oversampling_ratio
 KernelVersion:	2.6.38
-- 
2.20.1

