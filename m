Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65E91BDF02
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 15:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgD2NkK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 09:40:10 -0400
Received: from gproxy10-pub.mail.unifiedlayer.com ([69.89.20.226]:57073 "EHLO
        gproxy10-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728472AbgD2NkK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2020 09:40:10 -0400
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy10.mail.unifiedlayer.com (Postfix) with ESMTP id 29334140B2F
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2020 07:40:08 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id TmwXjOPnqrO3uTmwZj4Vk4; Wed, 29 Apr 2020 07:40:08 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=dbOuI0fe c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=cl8xLZFz6L8A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=iGRvdBzYb-_JTU_o6kgA:9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nWppLDkAaEMdPFqbD1TQDJt+62vsBP06spj0SrS+K2g=; b=P6eC2jtWIjtpYm7+yPVRA0Pse9
        SlwjZFlIVvyEE3x/yPClPcvwqChNQcXosW0rXw168oVD0GifTT3EpXsreN2Tg+yyrL1ls1wVm428T
        PH3dnG9kTZbP15wg8dXpimdzQZoKATYXVi30K/Oy2KFxoayKF4mZsbj3OECceLFIloUQWOj+nxwoq
        Frkh4b00BnzQ8Lmu5Zrr/dtVDwqKu3Fk3Kx8lbc6zCEKDJmZ3glwFdwDTjbQRoZCYHo5neXkNvgEU
        89e6aiod1tpzZjQ3/EDVUzOHLC3Z3jlTtabjMgct7idr4FUtWxZeC8qARR5WMVGf4EKpkr9Y5AUI4
        7dXoSp4A==;
Received: from p5b3f6bb1.dip0.t-ipconnect.de ([91.63.107.177]:33262 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <saravanan@linumiz.com>)
        id 1jTmwW-0009y4-0w; Wed, 29 Apr 2020 13:40:04 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, broonie@kernel.org,
        lgirdwood@gmail.com, saravanan@linumiz.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/4] Add driver for wsen-itds accelerometer sensor
Date:   Wed, 29 Apr 2020 15:39:39 +0200
Message-Id: <20200429133943.18298-1-saravanan@linumiz.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 91.63.107.177
X-Source-L: No
X-Exim-ID: 1jTmwW-0009y4-0w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p5b3f6bb1.dip0.t-ipconnect.de (localhost.localdomain) [91.63.107.177]:33262
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 2
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes in v2:
 - added ABI document
 - fixed review comments in v1
 - removed vendor entry changes (merged in v1)

The patch series add support for wurth elektronic wsen-itds 3-axis
accelerometer. Driver supports the acceleration, temperature data reading and
supports configuring of output data rate, operating mode and scale.

Thanks,
Saravanan

Saravanan Sekar (4):
  dt-bindings: iio: add document bindings for wsen-itds accel sensor
  iio: accel: Add driver for wsen-itds accelerometer sensor
  iio: accel: wsen-itds accel documentation
  MAINTAINERS: Add entry for wsen-itds accelerometer sensor

 .../ABI/testing/sysfs-bus-iio-wsen-itds       |  23 +
 .../bindings/iio/accel/we,wsen-itds.yaml      |  55 +
 MAINTAINERS                                   |   7 +
 drivers/iio/accel/Kconfig                     |  14 +
 drivers/iio/accel/Makefile                    |   1 +
 drivers/iio/accel/wsen-itds.c                 | 947 ++++++++++++++++++
 6 files changed, 1047 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
 create mode 100644 Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
 create mode 100644 drivers/iio/accel/wsen-itds.c

-- 
2.17.1

