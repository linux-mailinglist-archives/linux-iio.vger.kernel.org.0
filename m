Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CC35BBEA3
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIRP0P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIRP0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 11:26:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2EC11810
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 08:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0381B8104A
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 15:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED933C433C1;
        Sun, 18 Sep 2022 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663514771;
        bh=S2rdJKs28UpDvY31sBuIrleKVNyseU81nhrs3pFsJ8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QYCaG+HXCk6dpN2uGe370tgnPaOw4NmlsZoZyCTvBAHGbSaHSFgw5ARkrfPrLNFIf
         YhwRYB10v1tW9GCvKCReBTQkHHagyVNnQ5o9eaaq+Zom3LEj+DhcnasM5oXryLPrAK
         xyJpFXsoIhU2VaXYTv21NYY8VK3uo+3KwTt/ECSUi9pm6uLObH4StU4P/vAU9yzNMw
         IDeoH7X4M6ukk3I37gYYnNH6zOgetoKwjOIpMcvOsPQWCz/NRs3Eud7IwJrB8Ul7Ju
         iWRFHpLqFZ7EdxfKuBPM0TeyPLcfXScV923PX1aIvSwSctOTKh5pBLXjIcOKKn7Btr
         WxHX1V3yCBW0Q==
Date:   Sun, 18 Sep 2022 16:26:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v4 3/3] Documentation: ABI: testing: add max11410 doc
Message-ID: <20220918162614.4def922c@jic23-huawei>
In-Reply-To: <20220908144924.205547-4-Ibrahim.Tilki@analog.com>
References: <20220908144924.205547-1-Ibrahim.Tilki@analog.com>
        <20220908144924.205547-4-Ibrahim.Tilki@analog.com>
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

On Thu, 8 Sep 2022 17:49:24 +0300
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding documentation for Analog Devices max11410 adc userspace sysfs.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

I debated a bit with myself when reviewing the driver this time on whether
we wanted
filter_notchY_en or as you have it filterY_notch_en

It's a bit similar to channel naming in which we potentially allow
in_accel0_x_raw
in_accel1_x_raw
in_accel0_y_raw

or
in_accel0_x_raw
in_accel1_x_raw
in_accel2_y_raw

etc depending on whether the index is considered global across all modifiers
or not.  We decided long ago that either was fine as they are uniquely
identifiable either by channel index, or by index + modifier.

Anyhow, upshot is I'm fine with the ordering you have here - but if anyone
else has time to take a look and comment on why one option is better than
the other that would be great.

Thanks,

Jonathan
 

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-max11410          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max11410 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
> new file mode 100644
> index 000000000..2a53c6b37
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
> @@ -0,0 +1,13 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_filterY_notch_en
> +Date:		September 2022
> +KernelVersion:  6.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Enable or disable a notch filter.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_filterY_notch_center
> +Date:		September 2022
> +KernelVersion:  6.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Center frequency of the notch filter in Hz.

