Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1E6614E7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 13:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAHMLL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 07:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAHMLJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 07:11:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3AA10FC2
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 04:11:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D1C0B802C5
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 12:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4940CC433D2;
        Sun,  8 Jan 2023 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673179866;
        bh=AQJgqHh3ikUGj1LgnAotNM/aZoyrxK1pHPl93ZrsdTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R/ZEmLF9DqWzxfU7oedeCSEln8zB2RYw76xeNGBMOC089VuTDFTmc5QcAGIX9T/TE
         wP4yRJoXLhzAKX38RBjRQDFL6r90jXUO7B6GdHXj2XWV1AQwv93qILMQ4ra2IHp1gA
         wN5W69m9Tl3Q2Grw7TUmHrxBndyXGXTihkk5a7vb1MAJZKAWRxqCM1/mGR5nF4rnlX
         SEIR988AGg5pAhqN1KTfUtY9/cWTQZ6RBYJnKGEUH9AmwcncoJJ15lqtvrHtWSuugr
         0aQDzc+Ko5m9tk0plurWNzm1KOnQN2D7NpYP56ezy2opMogUOujZJ0mV/TIG2zSM10
         ImDvO8v4PSpXA==
Date:   Sun, 8 Jan 2023 12:24:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, demisrael@gmail.com
Subject: Re: [PATCH] iio: hid: fix the retval in
 [accel|gyro]_3d_capture_sample
Message-ID: <20230108122434.24c71555@jic23-huawei>
In-Reply-To: <80a61ea3eb5d00febdaf24ab27e3301fd8c70f74.camel@intel.com>
References: <80a61ea3eb5d00febdaf24ab27e3301fd8c70f74.camel@intel.com>
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

On Mon, 02 Jan 2023 20:51:27 +0200
Dmitry Perchanov <dmitry.perchanov@intel.com> wrote:

> From d12f607f83c0bdae6529d8cfbb0cf17f8920c380 Mon Sep 17 00:00:00 2001
> From: Dmitry Perchanov <dmitry.perchanov@intel.com>
> Date: Tue, 13 Dec 2022 17:44:01 +0200
> Subject: [PATCH] iio: hid: fix the retval in [accel|gyro]_3d_capture_sample
> 
> Return value should be zero for success.
> This was forgotten for timestamp feature.
> Verified on RealSense cameras.
> 
> Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
Hi Dmitry,

I've taken this as it stands (needed to do a bit of hand editing to get
git to accept your email).  However, if you fancy doing some cleanup
it would be better still if these functions just returned directly in each
arm of the switch statement.  Drop the final return and the compiler
will moan if any path is not covered...

Applied to the fixes-togreg branch of iio.git and marked for stable inclusion.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c | 1 +
>  drivers/iio/gyro/hid-sensor-gyro-3d.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index a2def6f93..5eac7ea19 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -280,6 +280,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
>  			hid_sensor_convert_timestamp(
>  					&accel_state->common_attributes,
>  					*(int64_t *)raw_data);
> +		ret = 0;
>  	break;
>  	default:
>  		break;
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 8f0ad022c..698c50da1 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -231,6 +231,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
>  		gyro_state->timestamp =
>  			hid_sensor_convert_timestamp(&gyro_state->common_attributes,
>  						     *(s64 *)raw_data);
> +		ret = 0;
>  	break;
>  	default:
>  		break;

