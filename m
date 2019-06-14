Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A045CC4
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 14:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfFNM0T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 08:26:19 -0400
Received: from first.geanix.com ([116.203.34.67]:45570 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfFNM0T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Jun 2019 08:26:19 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 914F613B9;
        Fri, 14 Jun 2019 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560515022; bh=g/GNF9P65OqCoxx4GE2U59v9eolxtonX3R59txErsuo=;
        h=From:To:Cc:Subject:Date;
        b=ZUpxPIR+Q2BL3rCEYlEPPui7ScdbDKrGCdajRcu6JLnbBQZxSh3iW3iaZmNOqDRDM
         1/ffrSCY0Z6KFLyTnzrm47JJS+I61m8pfC8r6RM61FCYmQpz7SVKfu0q+ypAvpHxO4
         6oLTc/IXe6xvH+3pZTGD9dgUrb3TSupS2eap8gdlRPNJAmP2N1gpFvG6CC2NWTRGWS
         cG22FTamuTotHwuw2qKRFeryY8czHVHurhG1o2UWlPBzEw/O+neJyUREbnMdx4a0Jf
         eBC5zg9Wk6LS5Ews1kbkhHj0jT+isKnXE8230vK7OLiAUh+K5fW77kGF2O/38GwEMs
         ozwE2k0mHEZSQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, martin@geanix.com
Subject: [RFC PATCH 0/3] io: imu: st_lsm6dsx: wake on acc event
Date:   Fri, 14 Jun 2019 14:26:01 +0200
Message-Id: <20190614122604.52935-1-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 796779db2bec
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

The first patch enables the wake event creation in the suspend function,
it hardcodes the accelerometer to low power mode and the gyro is powered down.

The second and third patch is where I have some questions.
Is it okay to create an sysfs entry that can enable and disable the wake
events from the accelerometer?

The third patch is enabling us to set the threshold value.
Obviously this will need to be changed to represent a real value instead
of the raw register value.
Maybe I need to add a threshold avaliable sysfs entry?
Do I set it to a raw value calculated from the scale value or is some have
a better idea?

Finally is this the right approach to enable wake on accelerometer
events?
Please provide some idea's to how we could do it in the best and most
generic way.

/Sean

Sean Nyekjaer (3):
  iio: imu: st_lsm6dsx: add wake on accelerometer threshold
  iio: imu: st_lsm6dsx: add wake on accelerometer enable hook in sysfs
  iio: imu: st_lsm6dsx: add wake on accelerometer threshold hook in
    sysfs

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 135 +++++++++++++++++++
 2 files changed, 137 insertions(+)

-- 
2.22.0

