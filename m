Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00A184E07
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 18:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCMRzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 13:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMRzA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 13:55:00 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89CE20724;
        Fri, 13 Mar 2020 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584122099;
        bh=4SmcYF4MTPHxgP/T5buYX+3MHJbPkOQfZqUCRLmETp0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZljyCcGl62FeI+PgWdJx+E7dVB1XNuLT3FQLD9MFCWT/Hx6YQ9Meq2gU2ppLZ1l0T
         9DDoFZYxAVOA+Dv/VSqOaHRoxyFnkeFBtzAO9X2Gd1uumlW4uzuHE+E+jsVsvVtDAs
         QIx/TgpQCVnFoGlRMBX3iKrCi/p+qRDSFRv6e+Tk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, mario.tesi@st.com, denis.ciocca@st.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 0/2] fix read misalignment on LSM6DSM SensorHub
Date:   Fri, 13 Mar 2020 18:54:40 +0100
Message-Id: <cover.1584121851.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

fix read misalignment on untagged FIFO.
fix samples-in-pattern (sip) computation on LSM6DSM SensorHub

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: fix read misalignment on untagged FIFO
  iio: imu: st_lsm6dsx: specify slave odr in slv_odr

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 ++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 ++++++++++-----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 29 ++++++++++++++-----
 3 files changed, 41 insertions(+), 14 deletions(-)

-- 
2.24.1

