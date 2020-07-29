Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123C1231AE8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 10:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgG2IMT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2IMS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 04:12:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD99C061794
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 01:12:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d188so6503325pfd.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S46xE3v5DrbbnFv9e5puvYo4jscSSSdvbX89O6S8DDQ=;
        b=PiK/1LIl8E/ZxiNOPlZOco9DGDkPa8InSq+tT3BBXy/JusYHitRQcDlma6dXh8ftfj
         AuJf5HzZMpsifHvouWzlUvFmSf9eV0+u32GHTv5nNoI3LT2PWK7u4L7XcnOjc5q55oMx
         VmKjk5ZpzVaIBk8VuoVF15/rlJFfgsjJCvFPh/HVrogN9lJ+7NOekYius/EzvM4b2nwi
         I9r/advsb8QODpGxlZJZNCw1ZfhwAU2z3vwVodmAdzL9UhBOmF0ebnmURz41vhYBzO+5
         mNTDS8uGUV4V6um2lOoPViqL93dqxUdQSn7SFCNivJ85WrEFy+J1kmDNg9AMMyXXOltL
         Lccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S46xE3v5DrbbnFv9e5puvYo4jscSSSdvbX89O6S8DDQ=;
        b=b2D8/3xGIhLjDed6vNj4LEe/sjzfdOlYhi26fWKxhY1KpZnmYshj50R5WlfIv/wyn6
         50Kw82YbXjwm9PTBmn9UBecdihgjZIsaleX+zuXz41zA8eqKM8ehrZQ+SRHClSTwwSEH
         0t8tcLwTGByDcpyDBjxf6XvCt62dVX/e69F8DeM/R5g36rJ2U90vtXdoSMNtOdCZ0BjI
         U8IQ2Nd+atDJFUDs4D3319V4nvvvhFTlXhIW5EpmtrQh6WT1MZ2TRz9AV5M7pqefJfTK
         h4sAWP0nodaM0VAIDe9A0ADx55auv+6BUZj0lNl+c/Wl8HB4xhZaxNrZEzPyHdTFhFxq
         H9SQ==
X-Gm-Message-State: AOAM533cmvBG57LpKsYNk6BKgccMZShyF3Nfu7/UJzZHKvfD0pVnvsNO
        t5mUVWuVS8ArB5EkxN4sGVtemw==
X-Google-Smtp-Source: ABdhPJyDQEJ/JkWYuadFiwHxJB1gNPr4kQTXQ5jj2him+TlG+sTNSnHWHZofs9Eb9EhwLTAzDULJow==
X-Received: by 2002:a62:5284:: with SMTP id g126mr2422012pfb.139.1596010338199;
        Wed, 29 Jul 2020 01:12:18 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id s6sm1377206pfd.20.2020.07.29.01.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 01:12:17 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Ankit Baluni <b18007@students.iitmandi.ac.in>
Subject: [PATCH -v2] Staging: iio: Fixed a punctuation and a spelling mistake.
Date:   Wed, 29 Jul 2020 13:41:55 +0530
Message-Id: <20200729081155.3228-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHp75VcmMf5dt7mu9N0C=6Rej-WzZ0EpzntHYCQkgNLVZkPbgg@mail.gmail.com>
References: <CAHp75VcmMf5dt7mu9N0C=6Rej-WzZ0EpzntHYCQkgNLVZkPbgg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Added a missing comma and changed 'it it useful' to 'it is useful'.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>
---
Changes in -v2:
	-Remove space before ':' in subject line.

 drivers/staging/iio/Documentation/overview.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
index ebdc64f451d7..00409d5dab4e 100644
--- a/drivers/staging/iio/Documentation/overview.txt
+++ b/drivers/staging/iio/Documentation/overview.txt
@@ -9,7 +9,7 @@ The aim is to fill the gap between the somewhat similar hwmon and
 input subsystems.  Hwmon is very much directed at low sample rate
 sensors used in applications such as fan speed control and temperature
 measurement.  Input is, as its name suggests focused on input
-devices. In some cases there is considerable overlap between these and
+devices. In some cases, there is considerable overlap between these and
 IIO.
 
 A typical device falling into this category would be connected via SPI
@@ -38,7 +38,7 @@ series and Analog Devices ADXL345 accelerometers.  Each buffer supports
 polling to establish when data is available.
 
 * Trigger and software buffer support. In many data analysis
-applications it it useful to be able to capture data based on some
+applications it is useful to be able to capture data based on some
 external signal (trigger).  These triggers might be a data ready
 signal, a gpio line connected to some external system or an on
 processor periodic interrupt.  A single trigger may initialize data
-- 
2.25.1

