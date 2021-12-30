Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46E481EAC
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhL3Rnu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:43:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48652 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbhL3Rnu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:43:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7451B61710
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF6C36AE7;
        Thu, 30 Dec 2021 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886228;
        bh=v74HAWo1vkm3fFxcpCq0xyuaYCd1WOAh5sSzlyCjWik=;
        h=From:To:Cc:Subject:Date:From;
        b=bpHwAIgmE/TYVeMjRNYjXnj4g+AjO9/t7MbUlMRO6gL9FDb90IuEtWXFVbSr9vIEM
         o+9khFF723D68Jfw5srRO4kGfDb9MlpC9zb6YjzFb8ibUIR9GUf1yjJDqr1kzij+Cw
         essEunDqAx/VEBtWo2vIj9yNQSnkfRglKyIu1KyPivlUCIo12yXSn5NH1umt4uo2c3
         oN5umUVrxDImmpM2CzflRvF+hRt3hE5OBN8kFAYWKGs2krwDW7QkG+9ZvxB/V1eIiV
         aQdVSPZ/MwSmWbujfo2G80ILc5rh2naNaVrnYBLuAvV8HNim9CAi7GVQQoI6qSo+GD
         FAMkv2aUXyQtQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Nikita Travkin <nikita@trvn.ru>,
        Maslov Dmitry <maslovdmitry@seeed.cc>,
        Andreas Klinger <ak@it-klinger.de>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Subject: [PATCH 00/16] IIO: Tidy up inconsistent spacing in ID tables.
Date:   Thu, 30 Dec 2021 17:48:55 +0000
Message-Id: <20211230174911.78291-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Andy's review of Gwendal's sx9324 patch included a comment on having
a space before the } in id tables. It is a more general comment, but
this series only addresses the id table cases where things are
inconsistent.  I said I would send a clean up set when I got bored. That
happened sooner than expected (I blame tax returns).

Found using:
  git grep -re "[0-9A-Za-z]}" drivers/iio/ | grep "{\ "

Note that the fact that we have a clump of these in proximity drivers
suggests that copy and paste is leading to this odd bit of formatting
getting copied into new drivers.

As ever, some of these don't have active driver maintainers so please
take a quick look at the whole series if you have time.

Thanks,

Jonathan

Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Parthiban Nallathambi <pn@denx.de>
Cc: Nikita Travkin <nikita@trvn.ru>
Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: Andreas Klinger <ak@it-klinger.de>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: Hui Liu <hui.liu@mediatek.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>

Jonathan Cameron (16):
  iio:chemical:atlas: Trivial white space cleanup to add space before }
  iio:light:pa12203001: Tidy up white space change to add spaces after {
    and before }
  iio:light:vcnl4035: Trivial whitespace cleanup to add space before }
  iio:light:us5182: White space cleanup of spacing around {} in id
    tables
  iio:light:ltr501: White space cleanup of spacing around {} in id
    tables
  iio:proximity:ping: White space cleanup of spacing around {} in id
    tables
  iio:proximity:rfd77402: White space cleanup of spacing around {} in id
    tables
  iio:proximity:srf04: White space cleanup of spacing around {} in id
    tables
  iio:proximity:srf08: White space cleanup of spacing around {} in id
    tables
  iio:frequency:admv1013: White space cleanup of spacing around {} in id
    tables
  iio:adc:mt6577_auxadc: Tidy up white space around {} in id tables
  iio:adc:hi8435: Tidy up white space around {} in id tables
  iio:adc:ti-adc084s021: Tidy up white space around {}
  iio:light:tsl2722: Fix inconsistent spacing before } in id table
  iio:proximity:vl53l0x: Tidy up white space around {} in id tables
  iio:accel:dmard09: Tidy up white space around {} in id table

 drivers/iio/accel/dmard09.c         |  2 +-
 drivers/iio/adc/hi8435.c            |  2 +-
 drivers/iio/adc/mt6577_auxadc.c     | 10 +++++-----
 drivers/iio/adc/ti-adc084s021.c     |  2 +-
 drivers/iio/chemical/atlas-sensor.c | 10 +++++-----
 drivers/iio/frequency/admv1013.c    |  2 +-
 drivers/iio/light/ltr501.c          | 14 +++++++-------
 drivers/iio/light/pa12203001.c      |  4 ++--
 drivers/iio/light/tsl2772.c         |  2 +-
 drivers/iio/light/us5182d.c         |  6 +++---
 drivers/iio/light/vcnl4035.c        |  2 +-
 drivers/iio/proximity/ping.c        |  4 ++--
 drivers/iio/proximity/rfd77402.c    |  2 +-
 drivers/iio/proximity/srf04.c       | 12 ++++++------
 drivers/iio/proximity/srf08.c       |  6 +++---
 drivers/iio/proximity/vl53l0x-i2c.c |  2 +-
 16 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.34.1

