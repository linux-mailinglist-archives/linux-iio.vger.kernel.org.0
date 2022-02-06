Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E85A4AB173
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiBFS5O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiBFS5N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2E4C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C6E26121C
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF6CC340E9;
        Sun,  6 Feb 2022 18:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173831;
        bh=D0y6TJW+0KRp5+BOZYnMEdbjGLzxUoWuSDy3YfyJJYU=;
        h=From:To:Cc:Subject:Date:From;
        b=t+PwBhszEbq1ABEWA+tMNo0cayheuHxzxlTHoCCkgobJp5B5I+r0BbnLB+KZnhGxV
         ys//XMPl1f4sYwYYA7CNJ22wMm/CIj+T5yzoS9JNBLjIZLoCtzWWrRQyfK9KIORSrR
         JVz+A0uzWs81wwY+B1qyFu/bEORVw4X0nLdpgKmogUDQSgpcQ5mAImy/WsCIZGfnnJ
         k2usC6YoX5blQu7UHt3n0aYXvENlEjQtPbR+oPkd7tqyGlN+qwX4aAuJ/7ECTP/Mrr
         hLMwetcDrWG3oCEmp3sFwsQOsKac+X6qHIDD5H4n4OvQs5TDlnoZMvxWr0VXrxtNSr
         7NGD0nfuzv6Mg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 00/20] iio:adc:ad7280a Cleanup and proposed staging graduation.
Date:   Sun,  6 Feb 2022 19:03:08 +0000
Message-Id: <20220206190328.333093-1-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changes since v2:
All in response to Marcelo Schmitt doing a really detailed review and
testing against the QEMU model.

- Moved elements of patch 2 to patch 5 to avoid missing defines.
- Patch 6: Amend ordering to avoid updated software cached values until the
  hardware write has succeeded.
- Patch 12 Fixed wrong callbacks in no_irq case
- Patch 14: Changed all numeric properties to u32 to avoid needing to
  specify bit depth in dts.
- Patch 14: Typo fix.
- Patch 15: New Patch to drop the handling of partial aux alert channels as
  it is buggy (and always was). Anyone wanting to bring this back will
  hopefully have hardware to test as it will be fiddly.
- Patch 15 (old number, now 16). Update dt bindings to drop the
  adi,temp-alert-last-chan given new patch 15 drops the support.
- New Patch 18: Change cb_mask software cache to not include the offset of 2
  and instead apply that only when writing the registers.
- New Patch 19: More conservative timings to allow 105 degree Centigrade
  operation.
- Patch 20 is moving the new code so obviously all the above apply to that
  as well!

Hi All,

This one proved an interesting diversion.

Work done against a somewhat hacked up QEMU emulation of 3 daisy chained
ad7280a devices (18 channels).  Note that the emulation isn't complete
but does do chaining, CRC, and readout of channels etc in a fashion that
worked with the original driver (up to the bug in patch 1) and continues
to work with the updated version. I've not intention to upstream the
emulation (as would need to make it more completed and flexible), but
happy to share it with anyone who is interested.

I briefly flirted with posting a patch to just drop the driver entirely,
but the part is still available and it looked like fun + isn't going
to greatly impact maintainability of the subsystem long term so is low
cost even if it becomes unavailable sometime soon.

There are lots of things we could do after this set to improved the driver
and make things more flexible, but it should basically 'just work'

Anyhow, as normal for staging graduations, last patch has rename detection
turned off so that people can easily see what I am proposing we move
out of staging.

All comments welcome and thanks to Marcelo for reviewing this beast!

Thanks,

Jonathan


Jonathan Cameron (20):
  staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
  staging:iio:adc:ad7280a: Register define cleanup.
  staging:iio:adc:ad7280a: rename _read() to _read_reg()
  staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
  staging:iio:adc:ad7280a: Use bitfield ops to managed fields in
    transfers.
  staging:iio:adc:ad7280a: Switch to standard event control
  staging:iio:adc:ad7280a: Standardize extended ABI naming
  staging:iio:adc:ad7280a: Drop unused timestamp channel.
  staging:iio:adc:ad7280a: Trivial comment formatting cleanup
  staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
  staging:iio:adc:ad7280a: Cleanup includes
  staging:iio:ad7280a: Reflect optionality of irq in ABI
  staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
  staging:iio:adc:ad7280a: Use device properties to replace platform
    data.
  staging:iio:adc:ad7280a: Drop buggy support for early termination of
    AUX alert.
  dt-bindings:iio:adc:ad7280a: Add binding
  iio:adc:ad7280a: Document ABI for cell balance switches
  staging:iio:adc:ad7280a: Remove shift from cb_mask state cache.
  staging:iio:adc:ad7280a: Use more conservative delays to allow 105C
    operation.
  iio:adc:ad7280a: Move out of staging

 .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   13 +
 .../bindings/iio/adc/adi,ad7280a.yaml         |   77 ++
 drivers/iio/adc/Kconfig                       |   11 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad7280a.c                     | 1111 +++++++++++++++++
 drivers/staging/iio/adc/Kconfig               |   11 -
 drivers/staging/iio/adc/Makefile              |    1 -
 drivers/staging/iio/adc/ad7280a.c             | 1044 ----------------
 drivers/staging/iio/adc/ad7280a.h             |   37 -
 9 files changed, 1213 insertions(+), 1093 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
 create mode 100644 drivers/iio/adc/ad7280a.c
 delete mode 100644 drivers/staging/iio/adc/ad7280a.c
 delete mode 100644 drivers/staging/iio/adc/ad7280a.h

-- 
2.35.1

