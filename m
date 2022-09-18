Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840D95BBEA6
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiIRP3d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRP3X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 11:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF711810;
        Sun, 18 Sep 2022 08:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9816C61531;
        Sun, 18 Sep 2022 15:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E137C433C1;
        Sun, 18 Sep 2022 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663514962;
        bh=SqII8RWmHqTCuhy0RR1lgr/BKN5AZ4j2RKrCloAyvL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kv0uyYXLoUQG960i8vSa4xEEPOh3+g92UppdM1uqJMkieJ/RVsWtt1IYFl6ByQ0na
         yCUoLDeOjB8NIu9erY6gY5zKqkxWDN9jUb2l9PDS6UAMzndYWtf8Mf5zLPsXvH34id
         0yBA69Dg8bm7Ind6WIE408p+XPksOaOit+91OnAAq2cx8qfvca67++KvxOL/0c5aTw
         jj29NKkWqQxUVisoYDFETN+CQaMX+GQi4tuqf3kHL7CiZ9V9hzuUKh8MQOYIoQZTwC
         Dqcn5MxDuZxnJXSZf2SryDHU4RwdfdIiQ0f9H9OKWSRrRvRPBWnwucO0n50hd4C0+x
         3LWIVHmko9G+w==
Date:   Sun, 18 Sep 2022 16:29:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: Re: [PATCH 0/2] add support for LSM6DSTX
Message-ID: <20220918162925.3c4f5e09@jic23-huawei>
In-Reply-To: <cover.1663262890.git.lorenzo@kernel.org>
References: <cover.1663262890.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 15 Sep 2022 19:34:58 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support for LSM6DSTX IMU mems sensor
> https://www.st.com/resource/en/datasheet/lsm6dstx.pdf

Looks trivial enough that I've queued it up on my togreg branch and
pushed out as testing for 0-day to take a look.

I will be rebasing that tree shortly for other reasons, so a bit 
of time for reviews to still come in before this hits a non rebasing
tree.

Thanks,

Jonathan

> 
> Lorenzo Bianconi (2):
>   iio: imu: st_lsm6dsx: add support to LSM6DSTX
>   dt-bindings: iio: imu: st_lsm6dsx: add lsm6dstx device bindings
> 
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
>  drivers/iio/imu/st_lsm6dsx/Kconfig                        | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c            | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 7 ++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               | 5 +++++
>  7 files changed, 23 insertions(+), 3 deletions(-)
> 

