Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3DA6397A2
	for <lists+linux-iio@lfdr.de>; Sat, 26 Nov 2022 19:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKZSYr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Nov 2022 13:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZSYq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2022 13:24:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0B11A22A
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 10:24:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A547B80064
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 18:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D192FC433D6;
        Sat, 26 Nov 2022 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669487083;
        bh=yYuFNTxISR1fY/WuInsVYkyeQoQD2eQtb89y2kmvKNo=;
        h=Date:From:To:Subject:From;
        b=SWEZOzbvj57shXBszq9ewf1V+2jDJL5/emDZ7o//U75NmmXq1GrjeW8g/kzhJIYB0
         NMxzt9JK/jbeJiN1E5HdX52pG+GM5tYrVHm2l7BaJUiXk0EjpFHlxWsCuYk6fcrwx1
         jgMwiMSVslukfnzoA/yzTW6k5ATsY55PZnVpWX2FK1iOd95y4YLLPUWW0OF1bTrFyj
         OEbXXVa7Me1nCg/RpBKVp6OIxCta1iEZAzdwsYodLNj5yF7MRC26kV40AOARJzKG+3
         dfqeDzJl0nD+kCun1s2dCQdtlxeKkhT3WzgXOqer54bq3tq4N0q14aXMoOMWtwban6
         uY576SigKulkg==
Date:   Sat, 26 Nov 2022 18:37:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 4th set of IIO fixes for 6.1
Message-ID: <20221126183721.0fad0779@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 398e3479874f381cca8726ca5d8a31e1bf35a3cd:

  dt-bindings: iio: adc: Remove the property "aspeed,trim-data-valid" (2022-11-14 20:20:19 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.1d

for you to fetch changes up to 86fdd15e10e404e70ecb2a3bff24d70356d42b36:

  iio: fix memory leak in iio_device_register_eventset() (2022-11-16 19:14:37 +0000)

----------------------------------------------------------------
4th set of IIO fixes for 6.1

Single patch fixing a memory leak in an error path.
Fine to queue either for 6.2 if too late for 6.1

----------------------------------------------------------------
Zeng Heng (1):
      iio: fix memory leak in iio_device_register_eventset()

 drivers/iio/industrialio-event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
