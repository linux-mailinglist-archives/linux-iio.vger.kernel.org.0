Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CD5BB882
	for <lists+linux-iio@lfdr.de>; Sat, 17 Sep 2022 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIQNbC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Sep 2022 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQNbB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Sep 2022 09:31:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BFF3057C
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 06:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 96B36CE0A3C
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 13:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D123C433D6;
        Sat, 17 Sep 2022 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663421455;
        bh=T9RrD4hapQvrvsjLRfnVPZ3bwcnNEoZybhAVcquxut4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qZgUyfv5i2vdcw+m3K9PmGeAgSk+AVsK8m1VbAki4PwZGU9Eu3WMqYeIv6qQQ8EaU
         cvwDPbH/12vJ3OBdqn7kf7tJ/PaxViG39Y/do3rY4NPOw2cBk/48lroE9NQh6TxGAS
         VGAr4sTKnqj9TZSzr1dUBuv+x/qx0za9I4rspxA4pcflo2+/Q87v3roq1wjA+QOjWH
         xe8vYlRJVtkoFJ5CZVO/ryOnw2zgMDOwBe9f//Knv0T+7iQmouTS6R0w5E3q3UM9Y8
         7KyQjwOJ97MACGb1YZWhYd1iiC4EM3VnaNUFoW3+jpKFbgOrOodcQUesWM8t4mW8pF
         SSo5GzvxPUZPQ==
Date:   Sat, 17 Sep 2022 14:30:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     jagathjog1996@gmail.com, Alexander Potapenko <glider@google.com>,
        linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: accel: bma400: Add support for single and
 double tap events
Message-ID: <20220917143058.70a3c3ec@jic23-huawei>
In-Reply-To: <YyM2X3SbeD2ZYoKu@kili>
References: <YyM2X3SbeD2ZYoKu@kili>
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

On Thu, 15 Sep 2022 17:27:43 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Hello Jagath Jog J,
> 
> The patch 961db2da159d: "iio: accel: bma400: Add support for single
> and double tap events" from Aug 31, 2022, leads to the following
> Smatch static checker warning:
> 
> 	drivers/iio/accel/bma400_core.c:1287 bma400_tap_event_en()
> 	error: uninitialized symbol 'field_value'.
> 
> drivers/iio/accel/bma400_core.c
>     1242 static int bma400_tap_event_en(struct bma400_data *data,
>     1243                                enum iio_event_direction dir, int state)
>     1244 {
>     1245         unsigned int mask, field_value;
>                                     ^^^^^^^^^^^^
> This is uninitialized.
> 
>     1246         int ret;
>     1247 
>     1248         /*
>     1249          * Tap interrupts can be configured only in normal mode.
>     1250          * See table in section 4.3 "Power modes - performance modes" of
>     1251          * datasheet v1.2.
>     1252          */
>     1253         if (data->power_mode != POWER_MODE_NORMAL)
>     1254                 return -EINVAL;
>     1255 
>     1256         /*
>     1257          * Tap interrupts are operating with a data rate of 200Hz.
>     1258          * See section 4.7 "Tap sensing interrupt" in datasheet v1.2.
>     1259          */
>     1260         if (data->sample_freq.hz != 200 && state) {
>     1261                 dev_err(data->dev, "Invalid data rate for tap interrupts.\n");
>     1262                 return -EINVAL;
>     1263         }
>     1264 
>     1265         ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
>     1266                                  BMA400_S_TAP_MSK,
>     1267                                  FIELD_PREP(BMA400_S_TAP_MSK, state));
>     1268         if (ret)
>     1269                 return ret;
>     1270 
>     1271         switch (dir) {
>     1272         case IIO_EV_DIR_SINGLETAP:
>     1273                 mask = BMA400_S_TAP_MSK;
>     1274                 set_mask_bits(&field_value, BMA400_S_TAP_MSK,
>                                        ^^^^^^^^^^^^
> Smatch ought to print a warning here but these macros use a bunch of
> *(&(*(&field_value))) permutations that confuse Smatch.  Smatch does
> not print a warning if you're just taking the address of a variable.
> 
> This initializes BIT(3)?  I believe that KMSan will detect this as a bug
> an issue a warning here.
> 
>     1275                               FIELD_PREP(BMA400_S_TAP_MSK, state));
>     1276                 break;
>     1277         case IIO_EV_DIR_DOUBLETAP:
>     1278                 mask = BMA400_D_TAP_MSK;
>     1279                 set_mask_bits(&field_value, BMA400_D_TAP_MSK,
>     1280                               FIELD_PREP(BMA400_D_TAP_MSK, state));
>     1281                 break;
>     1282         default:
>     1283                 return -EINVAL;
>     1284         }
>     1285 
>     1286         ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG, mask,
> --> 1287                                  field_value);  
> 
> This uses BIT(3).  The function only cares about BIT(3) but the other
> bits are uninitialized.
> 
>     1288         if (ret)
>     1289                 return ret;
>     1290 
>     1291         set_mask_bits(&data->tap_event_en_bitmask, mask, field_value);
>     1292 
>     1293         return 0;
>     1294 }
> 
> regards,
> dan carpenter

Agreed. It's not a bug as such because the other bits are never used, but
it certainly hard for checkers to reason about.

Obvious 'fix' is just set the initial value to 0.

I'll send a patch. 

