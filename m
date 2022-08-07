Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EAE58BB7D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiHGPCJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiHGPCI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 11:02:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B136261
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 08:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 569B4B80CC7
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 15:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC406C433D6;
        Sun,  7 Aug 2022 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659884525;
        bh=a5C7KhpsYa8wuZJ1IUTZGb4oGeEWI44XgCunrBC7wNQ=;
        h=From:To:Cc:Subject:Date:From;
        b=i5JvSfrWqBfM3mTt9hjjCWnhTFSQrC7k4E6og3PlYyeMoRpROeAiKCNuvTLgmUAkq
         lIeM6doEav28KuMoZV/Nw3sV5lJPVh9uIumUFtKW3z5i9NUg22XPfJXfg1aaDcARJX
         OzAPWhPxlXbylVumWvUbpdohjhxcpS5cjS4mut5oJVI9idwbXv9ron25FfE3Sc+LLv
         HIc/JggaSPWIiEg4XkT1hSgog71P+WdDj9igY+9XkV1nxxwsgaMuN6o3M0rQLtZhd1
         pu4LOzzLiEZQ0vg+bku32i0YHi/jXTNXUfm9KCB7VA8N5P82B3lg+VApRHi/t96HxI
         xSMicgHbP/LyQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/4] staging: iio: DMA alignment fixes.
Date:   Sun,  7 Aug 2022 16:12:14 +0100
Message-Id: <20220807151218.656881-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

When I introduced IIO_DMA_MINALIGN and applied it to all the drivers
in drivers/iio I said I'd swing by the few remaining staging drivers
at a later date. This set fixes those staging/iio drivers.

Note that no one has been very active on these drivers for some time.
They do however support parts that are still available (and I have
at least one of them) so I think it's worth keeping them around for now.
Perhaps the necessary cleanup work can be done against emulation or
road test or we can get parts for anyone interested in doing the necessary
work.

Anyhow, upshot is that it's unlikely anyone will feel ownership of these
drivers enough to review this series so if anyone has time a quick
glance over it would be much appreciated!

Thanks,

Jonathan

Jonathan Cameron (4):
  staging: iio: frequency: ad9832: Fix alignment for DMA safety
  staging: iio: frequency: ad9834: Fix alignment for DMA safety
  staging: iio: meter: ade7854: Fix alignment for DMA safety
  staging: iio: resolver: ad2s1210: Fix alignment for DMA safety

 drivers/staging/iio/frequency/ad9832.c  | 2 +-
 drivers/staging/iio/frequency/ad9834.c  | 2 +-
 drivers/staging/iio/meter/ade7854.h     | 2 +-
 drivers/staging/iio/resolver/ad2s1210.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.37.1

