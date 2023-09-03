Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9218790D64
	for <lists+linux-iio@lfdr.de>; Sun,  3 Sep 2023 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbjICSE3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Sep 2023 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjICSE3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2023 14:04:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FB1DF;
        Sun,  3 Sep 2023 11:04:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf55a81eeaso1617235ad.0;
        Sun, 03 Sep 2023 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693764265; x=1694369065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee/3hlXRZIaJVPE2zhwt71URwtmHV6mucybKD81AfEg=;
        b=kYaXKOtSgYYutr/3gkv0djwYshK+ECv9lkz2W4sp1Necp+rsYX4zoUHVClLzKVlK4+
         S2oiV9Qxz7RvqGhibpVW+x8nXPyC8gmnHwnZ8JXIwEUuRhxEa7WIl/1IKqImJ8hegpXZ
         N1zsuBEK7JAHesQyV5oh+36FCBR6iTRSIVwFK+C0eb9RfJIbr4U0E2/5jVOYb1yk8E1C
         z36HaUwqJwHm3sByuK3+tw4QNvdLDZ6+eYi/gTJq7tEpWBtTeRgkeoWRosEDyExvY5Fj
         eLfW8M0phpO/u7z9DGqfJYN0fvDpi5K24mRsUvZ0ovmTJr2V9u0+jekNVlAuEHwcu0KN
         1sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693764265; x=1694369065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ee/3hlXRZIaJVPE2zhwt71URwtmHV6mucybKD81AfEg=;
        b=e6XynMqfwhcYsFRWCzdprjlEK/UhamNd99WQwgnvRZLGI8H8m1n12b/H7Gc04oBcue
         qK3ZqKv1yLSfeBd6xmJWynY1rA+lHdEuK36EKF+7Wta/8tlsTuXLt5It650OeTkhV13m
         xIW4kTEEyDzqKELaxztbZZIJT2w4Mu/4JaVJMVDxIxj58D6d0acxMN8YCmGaFg1mxqEn
         0vjhc6ass0pc0prZa5+ZsCNQZFS6lqt+URCQ8Rx+tEXIcONGbJpkeL11AXzcImBAuRk7
         hSlNVeZI0tqUrSX2C9OvYO718UPEyRDzaUEKIcBkdhqH9F6/OvCX90L7btMwju92spvs
         OgBg==
X-Gm-Message-State: AOJu0Yz1x+CkEBB4ieo9hdeH4dVUUMqYuS0m9G+4cfCcxxasY/HJzjVG
        A7MzFsvfu2MEWDHq3vFeMp8=
X-Google-Smtp-Source: AGHT+IG9fjM74F18bgzQQ3ahAdybvZ4+SffiFXWeHpZ0+rt8xktOOMAZ/ok779aWyfjxQwTU0WQeLQ==
X-Received: by 2002:a17:902:f7cd:b0:1c0:8044:750b with SMTP id h13-20020a170902f7cd00b001c08044750bmr5903407plw.47.1693764265355;
        Sun, 03 Sep 2023 11:04:25 -0700 (PDT)
Received: from localhost.localdomain ([45.64.12.149])
        by smtp.gmail.com with ESMTPSA id jf10-20020a170903268a00b001bbb25dd3a7sm6142712plb.187.2023.09.03.11.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 11:04:24 -0700 (PDT)
From:   Mighty <bavishimithil@gmail.com>
To:     linus.walleij@linaro.org
Cc:     jic23@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
        linux-iio@vger.kernel.org, peda@axentia.se, stable@vger.kernel.org
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
Date:   Sun,  3 Sep 2023 23:34:17 +0530
Message-Id: <20230903180417.22-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220524075448.140238-1-linus.walleij@linaro.org>
References: <20220524075448.140238-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 28, 2023 at 11:48 PM Jonathan Cameron <jic23@kernel.org> wrote:

> 2) If the channel has a horrible non linear and none invertable conversion
>    to standard units and events support the you might need PROCESSED to
>    provide the useful value, but RAW to give you clue what the current value
>    is for setting an event (light sensors are usual place we see this).

In this very specific case yes, it is being used as a current sense shunt for a light+prox sensor (gp2ap002), so I do think that it might be case 2 instead of 3. But with no other devices using the twl6030/32 gpadc for any features it could also be due to it not being updated like case 3. Also the fact that the adc would break in cases when its not just a light sensor as well, we just dont have any such devices yet.
I'm pretty lost at how the code handles RAW and PROCESSED anyways, cant seem to find a proper rescaler. Ideally BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) should be there in it, but since SCALE isnt used anywhere in the driver it wouldnt break any functionality, but it would lose logic. We'd have to look into the working of the gpadc again to understand how the factors fit in there.

Regards,
Mithil

