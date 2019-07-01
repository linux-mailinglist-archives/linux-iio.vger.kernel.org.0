Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449525B685
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2019 10:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfGAIOe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Jul 2019 04:14:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46742 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfGAIOe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jul 2019 04:14:34 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0BB43284F73;
        Mon,  1 Jul 2019 09:14:32 +0100 (BST)
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
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] iio: common: cros_ec_sensors: Add protocol v3 support
Date:   Mon,  1 Jul 2019 10:14:17 +0200
Message-Id: <cover.1561968653.git.fabien.lahoudere@collabora.com>
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

Changes since v2:
- Use patch 1 from v1 after discussion on ML

Changes since v1:
- Drop second patch
- return ENODEV if version is 0

Fabien Lahoudere (1):
  iio: common: cros_ec_sensors: determine protocol version

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

-- 
2.19.2

