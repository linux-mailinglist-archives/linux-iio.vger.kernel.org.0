Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2644375DD74
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jul 2023 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGVQej (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jul 2023 12:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGVQei (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jul 2023 12:34:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57CE2704;
        Sat, 22 Jul 2023 09:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69AC960B9B;
        Sat, 22 Jul 2023 16:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DB3C433C8;
        Sat, 22 Jul 2023 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690043676;
        bh=Rjv82HPBqLpoIriZnJoOzq7od/Ud/TXCnVgSSt38dvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tlb+0GZ7GsPDBJ1ohVXB7HNmpEulVpeA6M015YXENM0boPRImRcsWW5NmANK4km0o
         CYqdfOuV5AfT8y/0pUecG1sVNoWd6s5xFYbwS2ct3UGwW8JBw1gTthKaNgmIfF/LHO
         6xi3mnELlHxGf8leZHuGHhXaiswXaqpA29quHckIpROsvNGvSNSNKbd6mhtl0/XyEQ
         OQRqQb/MXeDA9ERMJ2roLmqa7Frd7eSrYfgJcSbPueSUlM35krX55QX67RIaDS/b9a
         gQhIo9MZYETXr41ejP3/kSOF0PHl5dqixnayYISvvKsK63txy8ESkxXzY87ez4xMV6
         2i/tPdxBmAx7w==
Date:   Sat, 22 Jul 2023 17:34:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: admv1013: propagate errors from
 regulator_get_voltage()
Message-ID: <20230722173433.2174734f@jic23-huawei>
In-Reply-To: <ce75aac3-2aba-4435-8419-02e59fdd862b@moroto.mountain>
References: <ce75aac3-2aba-4435-8419-02e59fdd862b@moroto.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jul 2023 10:02:18 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The regulator_get_voltage() function returns negative error codes.
> This function saves it to an unsigned int and then does some range
> checking and, since the error code falls outside the correct range,
> it returns -EINVAL.
> 
> Beyond the messiness, this is bad because the regulator_get_voltage()
> function can return -EPROBE_DEFER and it's important to propagate that
> back properly so it can be handled.
> 
> Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/admv1013.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
> index 9bf8337806fc..8c8e0bbfc99f 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -344,9 +344,12 @@ static int admv1013_update_quad_filters(struct admv1013_state *st)
>  
>  static int admv1013_update_mixer_vgate(struct admv1013_state *st)
>  {
> -	unsigned int vcm, mixer_vgate;
> +	unsigned int mixer_vgate;
> +	int vcm;
>  
>  	vcm = regulator_get_voltage(st->reg);
> +	if (vcm < 0)
> +		return vcm;
>  
>  	if (vcm < 1800000)
>  		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;

