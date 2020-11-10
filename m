Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9122AD7C8
	for <lists+linux-iio@lfdr.de>; Tue, 10 Nov 2020 14:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgKJNio (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Nov 2020 08:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730368AbgKJNio (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Nov 2020 08:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605015523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aMx7wjuNg2kAEzPgrkNd4CH/K8UHL+coRGUNV3J6B2g=;
        b=IJyAzwimBcPT3ISlsfqdyZfRENwb+8+Sf+ymS2CZ88Miw36dx38KWgltw87glHfeupiUzD
        DGVsXyVX1uventS8m2l0uuYv2GHcSZWMMqDTFol/yRD26W31DKOQyQB/8pQJMAKdbp0y2f
        pFhD380soMowFdte5ulWnhpSzQtH9x4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-c4zLv6f5O2qZVBxvaN6mOw-1; Tue, 10 Nov 2020 08:38:39 -0500
X-MC-Unique: c4zLv6f5O2qZVBxvaN6mOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37C656D582;
        Tue, 10 Nov 2020 13:38:38 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-196.ams2.redhat.com [10.36.113.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9224C4149;
        Tue, 10 Nov 2020 13:38:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org
Subject: [PATCH bugfix for 5.10 0/2] iio: accel: kxcjk1013: Fix kbd/touchpad not working on some 2-in-1s
Date:   Tue, 10 Nov 2020 14:38:33 +0100
Message-Id: <20201110133835.129080-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

This series fixes a somewhat special bug where sometimes the
kbd/touchpad do not work on certain 2-in-1s with 360 degree
(yoga) hinges, which use 2 accelerometers to allow figuring out the
angle between the display and the base.

The display accelerometer ACPI device / fwnode has a special ACPI
method which allows suppressing kbd + touchpads events when folded
into tablet-mode and sometimes the event suppression gets enabled
by default, this series calls the ACPI method at probe time to
disable the suppression, fixing the kbd/touchpad not working.

A web-search shows various reports about this issue in forums and such,
so it would be good if we can get these 2 patches added to a 5.10-rc#
as a bugfix, as I indicated in the Subject prefix.

Regards,

Hans

