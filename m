Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4D4A149
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfFRM7y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 08:59:54 -0400
Received: from first.geanix.com ([116.203.34.67]:37306 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRM7y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 08:59:54 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id E30CDB0E;
        Tue, 18 Jun 2019 12:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560862786; bh=8IWt/p/yksJ+AzH167bNBHR96XlZdJ9BCx8ESwMzIew=;
        h=From:To:Cc:Subject:Date;
        b=TPS5jyyGKkYi/Sj8AKQtez2CiLwlTKsLqC+thfmoqg3UBMkKPXxrT3V0jlbDiB8eX
         bMvVliOa3ofY20JlUPF6tA4EnmG3dnf5sR4N+wFLnMZUODMyxqvxFNwi+lbmVLtQwV
         9+lijQBroxG7kre7yRKOz6Cc9LYTfNpAT6Vcuco1+UHxsgHq4Luy1T3srL8H4Okl9u
         XWnko80vm+kU+FNeR2aDk51+0j9ecu2TlEVJDEtffZVhqrTwzk1aBVjdtjwvbDg7xS
         hyYcYiYOwAXM7XHA9josmCGZurBV7qqJ+AKiLsl9BF3Q24Wgo+sW5IWKhN7BmOPWzt
         NccQkNa8Ij74g==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH 0/5] iio: imu: st_lsm6dsx: add event reporting and wakeup
Date:   Tue, 18 Jun 2019 14:59:34 +0200
Message-Id: <20190618125939.105903-1-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

This series is completely reworked from the RFC, I hope I included all comments.
I'm now using the iio event system to report events while running. :-)

Wakeup is controlled via the PM framework, wakeup is only activated if
the event system have been activated before suspending.

/Sean

Sean Nyekjaer (5):
  iio: imu: st_lsm6dsx: move interrupt thread to core
  iio: imu: st_lsm6dsx: add motion events
  iio: imu: st_lsm6dsx: add wakeup-source option
  iio: imu: st_lsm6dsx: always enter interrupt thread
  iio: imu: st_lsm6dsx: add motion report function and call from
    interrupt

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   3 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  80 +----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 302 +++++++++++++++++-
 3 files changed, 301 insertions(+), 84 deletions(-)

-- 
2.22.0

