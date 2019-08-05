Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2349D816D2
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfHEKS4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 06:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfHEKSz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 06:18:55 -0400
Received: from localhost.localdomain.com (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF062087B;
        Mon,  5 Aug 2019 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565000334;
        bh=s7jw7X7b9uc7tq0QpQ5SFMltJH67vAUzNgvVnphgPeQ=;
        h=From:To:Cc:Subject:Date:From;
        b=XlLVCY/No5nptV+eAu3lDq3MGxouLOOF5YBwcz+OvY9yodskkqrIUvxZpNRqmfeTt
         Aqr5OS2J9UMBjbPooYekbE3bErvKmZCcSAWvEgtPT3RVVGItZnm2T1BWaeLv2oCC7b
         TFk84Y7RGsaR1jgiImgcAKNBHpIA9bB2cgzr4mM8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] add support to STM ISM330DHCX 6-axis Mems sensor
Date:   Mon,  5 Aug 2019 12:18:42 +0200
Message-Id: <cover.1564999807.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM ISM330DHCX 6-axis sensor
https://www.st.com/resource/en/datasheet/ism330dhcx.pdf

This series is based on '[v2,0/4] st_lsm6dsx: move {odr,fs}_table in'
https://patchwork.kernel.org/cover/11064381/

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to ISM330DHCX
  dt-bindings: iio: imu: st_lsm6dsx: add ism330dhcx device bindings

 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                       | 3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           | 7 ++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             | 5 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              | 5 +++++
 7 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.21.0

