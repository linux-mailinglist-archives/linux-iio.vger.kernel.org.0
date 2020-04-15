Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260D21A9427
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 09:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635142AbgDOHVn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 03:21:43 -0400
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:53967 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2635135AbgDOHVk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 03:21:40 -0400
X-Greylist: delayed 1523 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 03:21:38 EDT
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 390A0176EDA
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2020 00:56:11 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id ObxwjqQ01N8ArObxyjrt7O; Wed, 15 Apr 2020 00:56:11 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=PpW9kTE3 c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=cl8xLZFz6L8A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=iGRvdBzYb-_JTU_o6kgA:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ALV3zzlDkukeDYnEo1NPcnPQetl1UF6t3xq2o+loRlk=; b=QURp4N+8jazK9kQG9PESkXsDQA
        b2enx04j9CT+C1fHKkwwUt4o9HLxj2BflmXiY83vnfk0vgcS0uAaKcLN1a26MNrfHR4NETXARaqi2
        ih84tBHgLD2lwD4W6EaQOz10dv8CfN/t3qfsJmpmUXQ37xk01FyuaAn1jsc4QjpCFnDz0c9Yfwdtu
        vMxFGZbpTYYCFBTJk6WAi9nfManbgxeLpUlq9sMxrvH5yx9Yt8ja5O5TyMy+tVAKwLRKchxjNK9BX
        MNhdSdHjJUVK9qnhhxieVrtI0rsiTxyFbvjv5NZeLnqzrIDhnY0B01gvrie+VOavCxHHBow8M/WEE
        EZykbnvA==;
Received: from p5b3f6ccc.dip0.t-ipconnect.de ([91.63.108.204]:49262 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <saravanan@linumiz.com>)
        id 1jObxv-0000eI-91; Wed, 15 Apr 2020 06:56:07 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, broonie@kernel.org,
        lgirdwood@gmail.com, saravanan@linumiz.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/4] Add driver for wsen-itds accelerometer sensor
Date:   Wed, 15 Apr 2020 08:55:31 +0200
Message-Id: <20200415065535.7753-1-saravanan@linumiz.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 91.63.108.204
X-Source-L: No
X-Exim-ID: 1jObxv-0000eI-91
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p5b3f6ccc.dip0.t-ipconnect.de (localhost.localdomain) [91.63.108.204]:49262
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 1
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch series add support for wurth elektronic wsen-itds 3-axis
accelerometer. Driver supports the acceleration, temperature data reading and
supports configuring of output data rate, operating mode and scale.

Thanks,
Saravanan

Saravanan Sekar (4):
  dt-bindings: Add an entry for Würth Elektronik, we
  dt-bindings: iio: add document bindings for wsen-itds accel sensor
  iio: accel: Add driver for wsen-itds accelerometer sensor
  MAINTAINERS: Add entry for wsen-itds accelerometer sensor

 .../bindings/iio/accel/we,wsen-itds.yaml      |  53 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/accel/Kconfig                     |  14 +
 drivers/iio/accel/Makefile                    |   1 +
 drivers/iio/accel/wsen-itds.c                 | 978 ++++++++++++++++++
 6 files changed, 1054 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
 create mode 100644 drivers/iio/accel/wsen-itds.c

-- 
2.17.1

