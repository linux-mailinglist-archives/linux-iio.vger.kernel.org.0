Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64AC6767EE
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jan 2023 19:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjAUSEO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Jan 2023 13:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAUSEO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2023 13:04:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05168A70
        for <linux-iio@vger.kernel.org>; Sat, 21 Jan 2023 10:04:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB66CB8091D
        for <linux-iio@vger.kernel.org>; Sat, 21 Jan 2023 18:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D21C433EF;
        Sat, 21 Jan 2023 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674324250;
        bh=p9yF+N3qGlNpuvw08vOhda9CljIYXj503xJxwqNBEBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OkiSpxDyI7jURp5B+AAhy8kqiOmHb2Oh/+MxKtz7U4mSglME+V6fRBMurXfnTg23/
         lOJXpmdV/yjc4jMCd7m/Fxi62sBTXwB6GC68l8yUm+nevRaMpOT0Zc8FXuP+7nMcuA
         tinLRKHRZdvbbJhp/uPp5AwaILYf5e9Tn1K2X93AhqvBRpmm3BrKTejjagmkFI5Lj9
         BbtmEAaMwhy9OArTngZIBq5RLdBeWQkZwJc+ACojZwVIxjSYkagUVJPNnuRUnwKs7v
         hFC02Gae2qevluwoovXivcj8/gI9/A+cMKp+DJIqzW22B17FdqS776VX/DwzdkP/Xs
         pMTICKrEuRC5w==
Date:   Sat, 21 Jan 2023 18:17:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe De Muyter <Philippe.DeMuyter@macq.eu>
Cc:     lorenzo@kernel.org, linux-iio@vger.kernel.org,
        Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH v2 0/2] iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs
 entry to gyro channel.
Message-ID: <20230121181756.69ffeab7@jic23-huawei>
In-Reply-To: <1673874434-30750-1-git-send-email-Philippe.DeMuyter@macq.eu>
References: <1673874434-30750-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Mon, 16 Jan 2023 14:07:12 +0100
Philippe De Muyter <Philippe.DeMuyter@macq.eu> wrote:

> From: Philippe De Muyter <phdm@macqel.be>
> 
> 
> A simple patch to add the missing 'mount_matrix' sysfs entry for the gyro
> channel of the st_lsm6dsx 6-axes devices.
> 
> v2: use 'shub' in the renaming
Series applied to the togreg branch of iio.git and initially pushed out
as testing for 0-day to work it's magic.

Thanks,

Jonathan

> 
> Philippe De Muyter (2):
>   iio: imu: st_lsm6dsx: fix naming of 'struct iio_info' in
>     st_lsm6dsx_shub.c.
>   iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry to gyro channel.
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 +++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 12 ++++++------
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 

