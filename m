Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB4544C338
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 15:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhKJOpb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 09:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhKJOpb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Nov 2021 09:45:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0F376103D;
        Wed, 10 Nov 2021 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636555363;
        bh=XYdiLWchdJHKWuBjP3QQLDifU/rw0RDVF3t8aLiYi50=;
        h=From:To:Cc:Subject:Date:From;
        b=NHsGzBMCMSNdC05B6S/nWxh7cwu2Q/g8PeubLKxyegJzmnH3ZK5ttUX+CYXJhFQvo
         eoO/3O/U288+Ozx8P43rOcN1atMBCyqVnqZK9SfSAh4NAIKgzNh+Kr/MH9FYdWAvFU
         2JClCvotiAu1TB8btY6lC4a2OC0nlVPU2h2OOohPelqTE35FiEPtdG9ZNmdh45X6is
         39ZFwSrp73mvedlCZpgNAD5IsYOfp/FgIM2A8gIP6FsVV+gNNEHft+hWo1+dMmstwD
         k1yrpbNfohWlCXEm4wsUHoPa98Pd8mOrCQBemtMCbIv7givzy+CUnKhErwZa0wpA/y
         PoRGLfiHH9pmQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, devicetree@vger.kernel.org
Subject: [PATCH 0/2] add the capability to disable st_lsm6dsx sensor-hub
Date:   Wed, 10 Nov 2021 15:42:31 +0100
Message-Id: <cover.1636552075.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce the capability to disable sensorhub through a device-tree property
since since there are some configurations where users want to
explicitly disable sensor-hub auto-probing at bootstrap.
A typical configuration is when the sensorhub clock/data lines are connected
to a pull-up resistor since no slave sensors are connected to the i2c master.
If SDO/SA0 line is connected to the same pull-up resistor, when the driver
tries to probe slave devices connected on sensor-hub, it will force SDO/SA0
line to low, modifying the device i2c address.

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add dts property to disable sensor-hub
  Documentation: dt: iio: st_lsm6dsx: add disable-shub property

 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 4 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.31.1

