Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DAE3BA7D4
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGCIpQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhGCIpQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 04:45:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8002DC061764;
        Sat,  3 Jul 2021 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ygQ/dHoI16d9t9CiCap4vqQ0iOswu0jckuAtsh9qAn0=; b=Ogm1pWu5ATnJNwGnM//rPJXFwT
        jhvozEeKfD6Czi4uacoca1Njk9q4muTn3j5H422KVyNQxHtE1obu2qV1x/ID6JfOO7HqwuYHlJ8Gi
        9M3pVn0asYwCzKR6WFooGY9vx3JbiHEXmuDI5X76Faow3I3GeK4Kl8UmSLwB5rUznhbc=;
Received: from p200300ccff37da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbES-0006NR-OJ; Sat, 03 Jul 2021 10:42:36 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbES-0008Gw-7s; Sat, 03 Jul 2021 10:42:36 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        lars@metafoo.de, sre@kernel.org, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        leonard.crestez@nxp.com, letux-kernel@openphoenux.org
Subject: [PATCH 0/4] mfd: rn5t618: Extend ADC support
Date:   Sat,  3 Jul 2021 10:42:20 +0200
Message-Id: <20210703084224.31623-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree support so that consumers can reference the channels
via devicetree, especially the power subdevice can make use of that
to provide voltage_now properties.

Andreas Kemnade (4):
  dt-bindings: mfd: ricoh,rn5t618: ADC related nodes and properties
  mfd: rn5t618: Add of compatibles for ADC and power
  iio: rn5t618: Add devicetree support
  power: supply: rn5t618: Add voltage_now property

 .../bindings/mfd/ricoh,rn5t618.yaml           | 53 ++++++++++++++++++
 drivers/iio/adc/rn5t618-adc.c                 | 14 ++++-
 drivers/mfd/rn5t618.c                         |  6 +-
 drivers/power/supply/rn5t618_power.c          | 56 +++++++++++++++++++
 4 files changed, 126 insertions(+), 3 deletions(-)

-- 
2.30.2

