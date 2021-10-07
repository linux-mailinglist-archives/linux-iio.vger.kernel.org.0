Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DE42548C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 15:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbhJGNsl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 09:48:41 -0400
Received: from smtp1.axis.com ([195.60.68.17]:31231 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233315AbhJGNsk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 09:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633614407;
  x=1665150407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8lbGmN5aTYUWpTT7bwn68N3KpmMMI4aep5ZHTQ3lg5w=;
  b=bbuwjHZLRqbO6MQyGAtKTIG4GKNsQzVuy3DNyYtm/HOL08zSUPoO3Ifp
   S0MlIQ7ubnqFSPd610NPPierd4QUJdH6CWfsf/BsyPth1bZUCkdYmAqdG
   NCxdmH/KZ0PLbRLJrfDeidHbfklYLXKa8ZCckflbrpewQoyyzQSkd9Sla
   2FlVzahjmA1+eMzDrOzdrSKwBiKwCBR7fbLJtux2JZ12J7eZf+GU82qU3
   nbg1g7p88i2oRwg5Bt3qU6tRO4WX45GrPwiNPXUCK80/fUAHeSer6gJHG
   CMueXpopMhor0rxDdZl+9OVHuDQpB/Sm9ZP2vi0zsXTlqvebwrPEFCFz2
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <peda@axentia.se>, <jic23@kernel.org>, <devicetree@vger.kernel.org>
CC:     <kernel@axis.com>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 0/3] Add settle time support to iio-mux
Date:   Thu, 7 Oct 2021 15:46:38 +0200
Message-ID: <20211007134641.13417-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On one of our boards we use gpio-mux with iio-mux to read voltages using an ADC
from a few different channels, and on this board the input voltage needs some
time to stabilize after a switch of the mux.

This series add devicetree and driver support for this kind of hardware which
requries a settle time after muxing.

v1 -> v2:
- Move property support to iio-mux and delay handling to mux core as suggested
  by Peter.

v1: https://lore.kernel.org/all/20211004153640.20650-1-vincent.whitchurch@axis.com/

Vincent Whitchurch (3):
  mux: add support for delay after muxing
  dt-bindings: iio: io-channel-mux: Add property for settle time
  iio: multiplexer: iio-mux: Support settle-time-us property

 .../iio/multiplexer/io-channel-mux.yaml       |  5 +++
 drivers/iio/multiplexer/iio-mux.c             |  7 +++-
 drivers/mux/core.c                            | 36 ++++++++++++++++---
 include/linux/mux/consumer.h                  | 23 +++++++++---
 include/linux/mux/driver.h                    |  4 +++
 5 files changed, 65 insertions(+), 10 deletions(-)

-- 
2.28.0

