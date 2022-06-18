Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE155056D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiFROJ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbiFROIr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 10:08:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A7C2735;
        Sat, 18 Jun 2022 07:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8178B80A2B;
        Sat, 18 Jun 2022 14:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ED4C3411A;
        Sat, 18 Jun 2022 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655561324;
        bh=VtXf63KgLtr5IA1INMzI+NXdXdKDkS8xgWUivtRwKg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jnCXqiHO0ojW3Oj92dnVO0uSD9L4UO7oXWXmdsB5E6hNNz064Ek7fLRbkKbGJwT9e
         Otg4sN7B6kQvh8ZwufZhPEaCMH64ss7L6B3U16srwu0eF3+n9bkjK/qeD6vW8cyX6t
         y71fSSEcgXPXKgWzOxC7x2NyV4B4XirovspGHrEUInv5DjuoeUB8ZQuf9w0K2uq4nS
         i8F5A5h+ZC7yqR01B/ElJFm0mjzZGOqprBwb/rQfEWts9q3Y1XgYGAGUIoRJJPR+ve
         +8jVYyE05sS6qUtLzoN72EUZbq9LeMmX4mVFvuO+1D7cIHcuVZCfo2nE+yfQ/uwkWf
         ouVx6l9LiXMvg==
Date:   Sat, 18 Jun 2022 15:18:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/8] iio: magnetometer: yas530: Change data type of
 hard_offsets to signed
Message-ID: <20220618151800.0616c21f@jic23-huawei>
In-Reply-To: <dd6fe7f67e2f8c917aabd6eb0e0deccc660b48c2.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <dd6fe7f67e2f8c917aabd6eb0e0deccc660b48c2.1655509425.git.jahau@rocketmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Jun 2022 02:13:09 +0200
Jakob Hauser <jahau@rocketmail.com> wrote:

> The "hard_offsets" are currently unsigned u8 but they should be signed as they
> can get negative. They are signed in function yas5xx_meaure_offsets() and in the
> Yamaha drivers [1][2].
> 
> [1] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas.h#L156
> [2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L91
> 
> Fixes: de8860b1ed47 ("iio: magnetometer: Add driver for Yamaha YAS530")
> Cc: Linus Walleij <linus.walleij@linaro.org>

Trivial but it's nice to clean out CC if you also have a tag from the person.
All the automation will generally send emails to anyone who has given a tag
so the CC doesn't add anything at this point

I try to drop cases of this when applying patches, but if it's done by
the submitter it makes my life a little easier!

Thanks,

Jonathan


> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index b2bc637150bf..40192aa46b04 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -132,7 +132,7 @@ struct yas5xx {
>  	unsigned int version;
>  	char name[16];
>  	struct yas5xx_calibration calibration;
> -	u8 hard_offsets[3];
> +	s8 hard_offsets[3];
>  	struct iio_mount_matrix orientation;
>  	struct regmap *map;
>  	struct regulator_bulk_data regs[2];

