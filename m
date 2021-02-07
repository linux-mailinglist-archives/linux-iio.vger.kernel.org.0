Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B77A3125DC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 17:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGQKd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 11:10:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhBGQKd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2021 11:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612714147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CeSb5CDpKlv0YpMJw4fe6Hce7DFAvp5Tyy1/1YVC6KM=;
        b=J6N+/h0LnOS3VYfK00uD81dulg0m5bc9RF+/OgezBLG1gnCXXcxZNhsZsPoNsoySoOrHFF
        803/z268FBUmNaInapgPaglPid8VQM39zxV//j5nT4YxWkRPG3BHI421vsWi5nc71+xoEq
        wJ3s/lPn4VfxsZFTUwU9/TnvRxGZCq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-lYsgk9lsNMG64V1mzulEhg-1; Sun, 07 Feb 2021 11:09:05 -0500
X-MC-Unique: lYsgk9lsNMG64V1mzulEhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E14E0427CC;
        Sun,  7 Feb 2021 16:09:03 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FDF06F7E6;
        Sun,  7 Feb 2021 16:09:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/3] iio: add labels with accel-location to bmc150 and kxcjk-1013 drivers
Date:   Sun,  7 Feb 2021 17:08:58 +0100
Message-Id: <20210207160901.110643-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Here is a patch-set implementing the standardized "accel-display"
and "accel-base" label sysfs-attributes defined in my earlier
"[PATCH 1/2] iio: documentation: Document proximity sensor label use"
"[PATCH 2/2] iio: documentation: Document accelerometer label use"
series.

This patch sets adds these labels to the bmc150 and kxcjk-1013 accel
drivers.

Regards,

Hans


Hans de Goede (3):
  iio: core: Allow drivers to specify a label without it coming from of
  iio: accel: bmc150: Set label based on accel-location on 2-accel
    yoga-style 2-in-1s
  iio: accel: kxcjk-1013: Set label based on accel-location on 2-accel
    yoga-style 2-in-1s

 drivers/iio/accel/bmc150-accel-core.c | 18 ++++++++++++------
 drivers/iio/accel/kxcjk-1013.c        | 14 ++++++++++----
 drivers/iio/industrialio-core.c       |  6 ++++--
 3 files changed, 26 insertions(+), 12 deletions(-)

-- 
2.30.0

