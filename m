Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0C2B6A9E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgKQQrd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbgKQQrc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Nov 2020 11:47:32 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 527EA221FC;
        Tue, 17 Nov 2020 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605631652;
        bh=iSFVMPFFDbCqwlK7/y7MmScS6yjFm4ZACR5pkgQ8nzM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZA3qwb84OtKbO3GmZMyd1gqqKjkNpHj/2sFKZ0Lcqb2bWIRZu+EWJwT96VeggLD4o
         r0dSovyNl09KImxTKksz5Pw9tjqZVVvpThVI0TsJc9t/vR3o+DZvUgOkAeSxIbY8UY
         qnSUda08jDFnXBI9JjLinpCQLFkJfFJcHJorjpbQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] st_lsm6dsx: add vdd-vddio power regulator
Date:   Tue, 17 Nov 2020 17:47:24 +0100
Message-Id: <cover.1605631305.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce support to control VDD and VDDIO power lines available on
st_lsm6dsx devices

Changes since v1:
- rebase patch 2/2 ontop of st_lsm6dsx dt yaml conversion

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add vdd-vddio voltage regulator
  dt-bindings: iio: imu: st_lsm6dsx: introduce vdd-vddio regulators
    bindings

 .../bindings/iio/imu/st,lsm6dsx.yaml          |  6 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 42 +++++++++++++++++++
 3 files changed, 51 insertions(+)

-- 
2.26.2

