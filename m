Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8026767EC
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jan 2023 19:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjAUSBy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Jan 2023 13:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAUSBx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2023 13:01:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487361BE
        for <linux-iio@vger.kernel.org>; Sat, 21 Jan 2023 10:01:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FFA060B61
        for <linux-iio@vger.kernel.org>; Sat, 21 Jan 2023 18:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F393C433EF;
        Sat, 21 Jan 2023 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674324111;
        bh=tDUOLi1qx7iw7BdnC4uL88LyNMshpitXBaUulmxog5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zx4Gdg1oei/6QmmLed+lOKrprBcCW6UX37FXVwIqy1LyhIMy7AUTJQxeaqB00DwGn
         eJqIxGUVAIpj3ZdjM51LWO3T/WpoLih1SK+LFwIsA/B6QXWxCkCMUt8crckn0+7pxG
         2NPQivJn0J5VKy1As8Od/fkVB8IH4W2KHDi8644VFZoyqyIrSdeTKdFO9xOqqCTDO7
         HoYpiXi5us1yW4iUZ5Gdx+tJRyRBXZhFFoRrhpMJ30jde/i4O6+EqArkAi/STG8T5o
         D03kKkwEdE7JxEpTO5Q6oN6VGJkB2GGtrw/u3hECWjHNVnE6l7AW4vCw8Ih47GhRod
         mhE5JSU0GqpUg==
Date:   Sat, 21 Jan 2023 18:15:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 0/4] iio: imu: fxos8700: fix bugs about ODR and
 changes for a good readability
Message-ID: <20230121181536.479e2169@jic23-huawei>
In-Reply-To: <20230118074227.1665098-1-carlos.song@nxp.com>
References: <20230118074227.1665098-1-carlos.song@nxp.com>
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

On Wed, 18 Jan 2023 15:42:23 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> Hi, Jonathan. Thank you for the suggestion. In patch 1, I use
> regmap_write to modify the value of the register. And in patch 2,
> I use regmap_update_bits instead of regmap_get and regmap_write
> for a good readability. Other patches have not been changed.
> 
> Carlos Song (4):
>   iio: imu: fxos8700: fix incorrect ODR mode readback
>   iio: imu: fxos8700: fix failed initialization ODR mode assignment
>   iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
>   iio: imu: fxos8700: fix MAGN sensor scale and unit
> 
>  drivers/iio/imu/fxos8700_core.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 

Series applied to the fixes-togreg branch of iio.git and marked
for stable inclusion.

Thanks,

Jonathan
