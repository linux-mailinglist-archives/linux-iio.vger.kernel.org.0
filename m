Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8169D3547B2
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 22:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhDEUmk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 16:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235457AbhDEUmh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Apr 2021 16:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617655351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=K687xT8/zNajecjgzVpfiR+MAIT+b/S212XjZgRm2YM=;
        b=Ayy7oCFopqpVuADT6SM4bx7fvvdmBtxzyNXKrOXFLQ3Mv81EDFpSOKtU+Y1JkrbQNHDvSa
        l94z98Vqe2oFx8PfoML3YiXqwWX/1ZFm9FDf4WhowO9JCDWCxLKTTyP+ZVLElRik/tsCG9
        cYLZzJYG/VBgqfrRP5rWylULT9KaqZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-Eh04KV0lMHCQPBdzvkcJug-1; Mon, 05 Apr 2021 16:42:29 -0400
X-MC-Unique: Eh04KV0lMHCQPBdzvkcJug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 111FD1084D68;
        Mon,  5 Apr 2021 20:42:28 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28D065D9D0;
        Mon,  5 Apr 2021 20:42:24 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 resend 0/2] iio: documentation: Document proximity/accel sensor label use
Date:   Mon,  5 Apr 2021 22:42:22 +0200
Message-Id: <20210405204224.18715-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

AFAICT the v2 of this series is ready for merging, but I'm not seeing it here:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing

Hence this resend.

Regards,

Hans



Hans de Goede (2):
  iio: documentation: Document proximity sensor label use
  iio: documentation: Document accelerometer label use

 Documentation/ABI/testing/sysfs-bus-iio | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

-- 
2.30.2

