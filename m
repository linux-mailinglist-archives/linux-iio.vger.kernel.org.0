Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0651550587
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiFROrG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiFROrF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 10:47:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9592A15A10;
        Sat, 18 Jun 2022 07:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 483E7B8013C;
        Sat, 18 Jun 2022 14:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B30C3411A;
        Sat, 18 Jun 2022 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655563621;
        bh=lZsuDutq65O36oEGSVhec4PnKDAT0Ouu573eSFys25U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IC0ZbAJr51Y+Hi0HXmx6BeAjM21YG+SeexrNU8uM5jmbT8LWV357GILmoT+tjE2WU
         a5qA/ZnGkaUr1phuONyYaY6JusVbJRMB2IlOUND1DNMN6j5ozh4FlXEt4vSNSW6H3C
         XkxQ1Zjs0cuMJmNxhjnlXzfRkBPeaGq3yQN4geJZxSuoBTPeDPJtQUECCAQyhYF6CV
         ObrmsB2XYY++y0d8diYOvsmV0hcrLwHAzvDrI+/KZ20d9G2VreRRGrDmw1U33eRdIY
         ZMV5FixnNTOSoiOL5NgqUZzSHeFC/tVLf1uAgSJg8dawtdYaM2CKJOly2rec+eMA+g
         5rJWJT5oExveA==
Date:   Sat, 18 Jun 2022 15:56:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 5/8] iio: magnetometer: yas530: Change data type of
 calibration coefficients
Message-ID: <20220618155618.18996d0c@jic23-huawei>
In-Reply-To: <18f223776f6942d52af2e41dd10160e220a23311.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <18f223776f6942d52af2e41dd10160e220a23311.1655509425.git.jahau@rocketmail.com>
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

On Sat, 18 Jun 2022 02:13:13 +0200
Jakob Hauser <jahau@rocketmail.com> wrote:

> This is a preparation for adding YAS537 variant.
> 
> YAS537 uses other data types on the calibration coefficients [1] than YAS530 [2]
> and YAS532 [3].
> 
> On YAS537, at least for a4 and a7 this could matter because 8-bit unsigned data
> from the register gets stored into a signed data type, therefore this should be
> 8-bit as well.
> 
> For YAS530/532, on the other hand, it doesn't seem to matter. The size of a2-a9
> and k is smaller than 8-bit at extraction, also the applied math is low. And
> Cx/Cy1/Cy2, now being defined as signed 16-bit, are extracted as unsigned 8-bit
> and undergo only minor math.
Ok. If this is harmless to existing drivers fair enough, though my personal
inclination would have been to take the easier approach of making the
new variant sign extend on variable load (sign_extend_32() and similar)
just so we didn't need to check the older parts weren't affected.

Thanks,

Jonathan

> 
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L76-L78
> [2] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas_mag_driver-yas530.c#L526-L527
> [3] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L76-L77
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index 9b45a550f31e..c6f5f25793c4 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -103,9 +103,11 @@ struct yas5xx_calibration {
>  	s32 r[3];
>  	u32 f[3];
>  	/* Temperature compensation calibration */
> -	s32 Cx, Cy1, Cy2;
> +	s16 Cx, Cy1, Cy2;
>  	/* Misc calibration coefficients */
> -	s32 a2, a3, a4, a5, a6, a7, a8, a9, k;
> +	s8  a2, a3, a4, a6, a7, a8;
> +	s16 a5, a9;
> +	u8  k;
>  	/* clock divider */
>  	u8 dck;
>  };

