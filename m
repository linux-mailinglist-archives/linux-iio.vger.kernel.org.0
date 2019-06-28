Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9659E0C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF1OlU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 10:41:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54918 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfF1OlU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 10:41:20 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e34:ee7d:73d0:5796:7015:7f6:aeeb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 16CCB27FB5B;
        Fri, 28 Jun 2019 15:41:17 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] iio: common: cros_ec_sensors: Add protocol v3 support
Date:   Fri, 28 Jun 2019 16:40:59 +0200
Message-Id: <cover.1561731659.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is part of a split of the following patch:
https://lkml.org/lkml/2019/6/18/268
To fix Enric comments from https://lkml.org/lkml/2019/6/25/949
I extract it from the other serie to speed up acceptance because
other patches need it to be upstreamed.

Changes since v1:
- Drop second patch
- return ENODEV if version is 0

Fabien Lahoudere (1):
  iio: common: cros_ec_sensors: determine protocol version

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

-- 
2.19.2

