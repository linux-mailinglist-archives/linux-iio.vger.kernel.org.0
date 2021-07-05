Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A23BBC40
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 13:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhGELje (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhGELje (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 07:39:34 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA54C061574;
        Mon,  5 Jul 2021 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=78ZXfrydDmRta3yhdL4gDvHzHIg7e9V4iSL+/EKIh9I=; b=n3aif6y3jCmvy420SjtqvZ0XIF
        oag4sGmcrwAf1TbcIsEWzAOsiFoMF4X0U+RqbIefpbJPSx+EJPMSFif3oF8+hJWTcOpqRIpU2ucH0
        ziUuBh6C4rpoeoz9poJK4lInSFj7eohTSE6G7V+ScTHxckW42w84cjliFZ91pkRC/XAQ=;
Received: from p200300ccff0e44001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:4400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1m0MuD-0007Cd-Aw; Mon, 05 Jul 2021 13:36:53 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1m0MuD-0007X5-1g; Mon, 05 Jul 2021 13:36:53 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, sre@kernel.org,
        andreas@kemnade.info, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: [PATCH v2 0/2] mfd: rn5t618: Extend ADC support
Date:   Mon,  5 Jul 2021 13:36:35 +0200
Message-Id: <20210705113637.28908-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add iio map to make voltage_now related channels accessible to power
driver.

Changes in v2:
- use iio_map instead of devicetree to allow mapping which does not
  block future extension by devicetree.

Andreas Kemnade (2):
  iio: adc: rn5t618: Add iio map
  power: supply: rn5t618: Add voltage_now property

 drivers/iio/adc/rn5t618-adc.c        | 23 ++++++++++++++++
 drivers/power/supply/Kconfig         |  2 ++
 drivers/power/supply/rn5t618_power.c | 40 ++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

-- 
2.30.2

