Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01D7BD64E
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2019 04:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633804AbfIYCKQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 24 Sep 2019 22:10:16 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17474 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633788AbfIYCKQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2019 22:10:16 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Sep 2019 22:10:16 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1569376509; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=gvvW2CGohjW4iFTym+DSCFNzTQnMz3K3RK+nE0aGs58Xr/DSv9b+bfL9cNmmR/b9TB5r1AK0aLSXCHXtkYTvyoQBoLH/PoWwvoE2r6ZqHKsFLS3OULvpecr6GO90YsJRc0hkfaDbQ/jvnarpxMntJyhsM6GeDSrv1oRU8V5dkzk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1569376509; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=FMDZK2uFPh5HYZDnaG0EIdhqKhSI/s1mSVh3QP+Aeqo=; 
        b=Prg/drQ9F0qyQTsnxTORApQ1TYpmb0OpH+06beDfaz2X4JC+XgNAt9MnZfQG8jd1HkvrmfzEeXJhBhpXuKMt1OIZuUedAW30jhZjnS/RoaDHltsqjSt1PMhaE7oKJyxyyXjtgoHVS3ZBaFFtKHVsmMjkuyzKJXSdY9CuUCtM6ag=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1569376508558374.59192220023306; Tue, 24 Sep 2019 18:55:08 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Dan Robertson <dan@dlrobertson.com>, linux-kernel@vger.kernel.org
Message-ID: <20190925013941.20431-1-dan@dlrobertson.com>
Subject: [PATCH 0/1] iio: add driver for Bosch BMA400 accelerometer
Date:   Wed, 25 Sep 2019 01:39:40 +0000
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a IIO driver for the Bosch BMA400 3-axes ultra low-power accelerometer.
The initial implementation of the driver adds read support for the
acceleration and temperature data registers. The driver also has support for
reading and writing to the output data rate, oversampling ratio, and scale
configuration registers.

Comments and feedback are very much welcomed :)

Cheers,

 - Dan

Dan Robertson (1):
  iio: (bma400) add driver for the BMA400

 drivers/iio/accel/Kconfig       |  19 +
 drivers/iio/accel/Makefile      |   2 +
 drivers/iio/accel/bma400.h      |  74 +++
 drivers/iio/accel/bma400_core.c | 862 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/bma400_i2c.c  |  54 ++
 5 files changed, 1011 insertions(+)
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c



