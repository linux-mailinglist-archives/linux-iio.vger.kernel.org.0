Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628A2C3B4C
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 09:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKYIqM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 03:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgKYIqM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 03:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606293971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bv9rBFIt5HsTgYMkN/EXpNa+bTg+aLTH4t9YJEBp+ts=;
        b=jHpAa2WSlaGJCIQ03ymh3isxUWdPxJ93ITeQQkLNXzc+Glf02xMyoc6MhfmLOg0cQ/RUF7
        LUg5y5Q0XWAEAKhP9+Vu7RJpyOJmLWmiEC/g0niCcvuYzAsuIGOU/6pf02Nck1ZSPuvReD
        gCsv9CfbtFvIZ4k0Ujnsp7MO9/+7sZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-BHAVTiJPNCSJYgzKGUV54Q-1; Wed, 25 Nov 2020 03:46:09 -0500
X-MC-Unique: BHAVTiJPNCSJYgzKGUV54Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55A84185E48D;
        Wed, 25 Nov 2020 08:46:08 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-185.ams2.redhat.com [10.36.114.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B48C5D9C0;
        Wed, 25 Nov 2020 08:46:06 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH 0/1] iio: core: Copy iio_info.attrs->is_visible into iio_dev_opaque.chan_attr_group.is_visible
Date:   Wed, 25 Nov 2020 09:46:05 +0100
Message-Id: <20201125084606.11404-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

I wrote this because I was planning on using is_visible in a driver's
attribute group myself (1). But in the end it looks like I'm going to
do things differently.

This is still useful to have though, both for possible future use of
is_visible in driver's attribute groups as well as to make the current
usage of is_visible in adi-axi-adc.c actually work.

Regards,

Hans

1) I was planning to add an (optional) in_accel_location attribute which
would contain "lid" or "base" on 360 degree hinges (yoga) style 2-in-1s
with 2 accelerometers and where the kernel knows the location. But given
the recent discussion to use label-s for this for proximity sensors,
I believe that using label-s here makes more sense too. I will write
a patch-set for this when I can find / make some time for this.

