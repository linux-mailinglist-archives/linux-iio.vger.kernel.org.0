Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745F86EBF86
	for <lists+linux-iio@lfdr.de>; Sun, 23 Apr 2023 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDWMn7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Apr 2023 08:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDWMn7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Apr 2023 08:43:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305B10C6
        for <linux-iio@vger.kernel.org>; Sun, 23 Apr 2023 05:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0FEF60DF8
        for <linux-iio@vger.kernel.org>; Sun, 23 Apr 2023 12:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9619C433EF;
        Sun, 23 Apr 2023 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682253837;
        bh=ghEZ8PCdNUx1N3sL+g/P3RbX4qjb4FxNdoTBi3lckV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u34JVo3WomZLACqYBj95p4PSR/OXsS1M4kI3IPNuNV3wsXmjrtDabFjozJyAQcqZx
         pQgTSxAWdcleRlJsTMYbKaN32uHhDIyLVNOU2d6TsL/JTENgFlIDPilnqOHWkXWgew
         jpZ1/bneptsoSK6jsODJgNa7vFY6EGnFF+m/ElfS1qKS8s1j070Y3F2XCsXquJi/Ip
         xyCvls9DQxmEGf5yPYLxUTEkImFmGtfaWa08As5YA4902ECBhL0WW+l5HojylDulvQ
         9YU2Br6/Ug8/gJQYM+a4pm7zfS3lonVa7FhpdpqFbCkTX1FeEX6szOCzl5Nu0mo7JL
         aNtOoi9hg3V/g==
Date:   Sun, 23 Apr 2023 13:59:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     lars@metafoo.de, alexandre.torgue@foss.st.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] iio: adc: stm32-adc: add debug info if dt uses
 legacy channel config
Message-ID: <20230423135933.2dfb540b@jic23-huawei>
In-Reply-To: <20230421083858.2613289-1-sean@geanix.com>
References: <20230421083858.2613289-1-sean@geanix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Apr 2023 10:38:58 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Since nearly all stm32 dt's are using the legacy adc channel config,
> we should warn users about using it.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
This is far enough (I think) from the code touched in the fixes
(I'm waiting for review from Olivier for those) that I can merge
it through a different branch.   So taken this one for the togreg branch of
iio.git - initially pushed out as testing for 0-day to take a poke at it.

Thanks,

Jonathan

> ---
> Changes since v1:
>  - Changed dev_warn -> dev_dbg
> 
>  drivers/iio/adc/stm32-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 1aadb2ad2cab..e179b6611e4d 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1993,6 +1993,8 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
>  	int num_channels = 0, ret;
>  
> +	dev_dbg(&indio_dev->dev, "using legacy channel config\n");
> +
>  	ret = device_property_count_u32(dev, "st,adc-channels");
>  	if (ret > adc_info->max_channels) {
>  		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");

