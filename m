Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E5461A117
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 20:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKDTf0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 15:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKDTfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 15:35:25 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3496145092
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 12:35:24 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g129so5195141pgc.7
        for <linux-iio@vger.kernel.org>; Fri, 04 Nov 2022 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi3uLXH+szzqTxRSWVS63wUkqoaeAU4TkZNAaOvVK+s=;
        b=aWx+oPO+Srbo1w+pEL6tCCG2kMxu7Owtr3UvsxPEkOsAPbsNEoWsMP/nloh4Xfxmjt
         yAPc0edxVQcVDqNuzsSO7GcAU0weBGcazqHv85VCQxprA0/+UVoKiaaE+p7ftEd7g2sC
         TGxq/1cx5xFlVcjBZr75s1UfKRd0G0E9umQIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi3uLXH+szzqTxRSWVS63wUkqoaeAU4TkZNAaOvVK+s=;
        b=Dr4zkottzVan2XBw5f8b2QUSufcLkIzDvsTxZsad2S3FVzZB7LbDsS48G3V95ye+WY
         +O4M1/R5YdjeMi6sTnrvm9pus6B2tDVq2pVpd8sL22WJWqfXkKDeqvNv4y4EKxWrtYyk
         u9shXUq91OpYDnqybdBJMIabPLpRS/zgYqhtTzK2FIL2R0dEs1sSvFpn7yxhlNSIwHQ4
         1RDw3ds3fUHLMWcXJtcuKEGHfSU69lpKoLxQcigatsI8ZYbyuKCl3fY2TQOHlzzdHsno
         o9Tky6GbP1+bxg2aMN8uSWtvYTxm8Xms9kXwKwjvR3tB5GFD1C4F6nedgxxubCAbPmoM
         SEMA==
X-Gm-Message-State: ACrzQf2/ra67aG8nacW49VC8NTv6u8tM7Um63gLg8yFYDA7uRpegOSGD
        KZI6QEQjjH1vW7ZWagUNnOQ2MA==
X-Google-Smtp-Source: AMsMyM7t+PovjIzz0bK0Dmex/GB5uaGqzigeaTOQYl4Zm0s+THtQgtXB0FMtorvOI4GBtIiH/aigqg==
X-Received: by 2002:a05:6a00:4508:b0:56d:8afe:b7c1 with SMTP id cw8-20020a056a00450800b0056d8afeb7c1mr25958465pfb.29.1667590523697;
        Fri, 04 Nov 2022 12:35:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i16-20020a632210000000b0043a18cef977sm109241pgi.13.2022.11.04.12.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:35:23 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 4 Nov 2022 12:35:22 -0700
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: mlx90632_probe(): Error handling issues
Message-ID: <202211041235.FB1AF7F6F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221104 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Thu Nov 3 21:42:26 2022 +0000
    c83d3e5ca97f ("iio: temperature: mlx90632 Add runtime powermanagement modes")

Coverity reported the following:

*** CID 1527134:  Error handling issues  (CHECKED_RETURN)
drivers/iio/temperature/mlx90632.c:1270 in mlx90632_probe()
1264     	mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
1265     	mlx90632->interaction_ts = jiffies; /* Set initial value */
1266
1267     	pm_runtime_get_noresume(&client->dev);
1268     	pm_runtime_set_active(&client->dev);
1269
vvv     CID 1527134:  Error handling issues  (CHECKED_RETURN)
vvv     Calling "devm_pm_runtime_enable" without checking return value (as is done elsewhere 21 out of 24 times).
1270     	devm_pm_runtime_enable(&client->dev);
1271     	pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
1272     	pm_runtime_use_autosuspend(&client->dev);
1273     	pm_runtime_put_autosuspend(&client->dev);
1274
1275     	return devm_iio_device_register(&client->dev, indio_dev);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527134 ("Error handling issues")
Fixes: c83d3e5ca97f ("iio: temperature: mlx90632 Add runtime powermanagement modes")

Thanks for your attention!

-- 
Coverity-bot
