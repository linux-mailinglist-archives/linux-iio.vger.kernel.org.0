Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E56DC916
	for <lists+linux-iio@lfdr.de>; Mon, 10 Apr 2023 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDJQJo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Apr 2023 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDJQJm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2023 12:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085219B4
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 09:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E20CD60FF9
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 16:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F3CC4339B;
        Mon, 10 Apr 2023 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681142980;
        bh=fq6wE/ahErjrBGfvHVEJrRh1bCHqLTQuztZxAYTmI8c=;
        h=Date:From:To:Subject:From;
        b=NNBTFjWJ+HMbqW0cN7vAsTzYbiqeyCv3UT+xsYxgy0hlKHuByXlX0iqrgiq11es4m
         bKOXSBY+praPNRACPbAblFjJDRlrWKHEhcixdYtL2Gp10lti70XNDRPJC/GYH8JBtS
         xIfvIoXzyA24IGzLe0tGQ97uJ7fihVKYFXvZQFwLVX1HkSwz5i3Y2rohhghdfJhi0t
         0FEgtPiKkokYMqdaLADApOo6gp3NHF1Tei6tFFhnInAaQfomsufe06axK7K4wgUnkZ
         E4MDJkLkFh9SIz2Y5Gn8r7kxZicT82muFlozbKw+CDrpvhLV6N1rnUu4VUcrFAbFhI
         Es6cimgvyoLfA==
Date:   Mon, 10 Apr 2023 17:25:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO fixes for 6.3 set 2
Message-ID: <20230410172500.04c124e2@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 4bffd2c7a3fc165fc70bc69211b8e6436f41a5c3:

  Merge tag 'iio-fixes-for-6.3a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2023-03-28 13:30:55 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.3b

for you to fetch changes up to b1cb00d51e361cf5af93649917d9790e1623647e:

  iio: light: tsl2772: fix reading proximity-diodes from device tree (2023-04-08 10:44:34 +0100)

----------------------------------------------------------------
2nd set of IIO fixes for the 6.3 cycle.

adi,ad5755
  - Fix missing fwnode_handle_put() in error path.
atmel,at91-sam5d2
  - Fix error code when trigger allocation fails that would have looked
    like success.
taos,tsl2772
  - Store the proximity-diodes value read from the device tree so it
    is actually used rather than ignored.

----------------------------------------------------------------
Brian Masney (1):
      iio: light: tsl2772: fix reading proximity-diodes from device tree

Dan Carpenter (1):
      iio: adc: at91-sama5d2_adc: fix an error code in at91_adc_allocate_trigger()

Liang He (1):
      iio: dac: ad5755: Add missing fwnode_handle_put()

 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 drivers/iio/dac/ad5755.c           | 1 +
 drivers/iio/light/tsl2772.c        | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)
