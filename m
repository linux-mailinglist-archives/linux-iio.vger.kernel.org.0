Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D658C768
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbiHHLSr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiHHLSo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:18:44 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D603DDF31;
        Mon,  8 Aug 2022 04:18:43 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d8so1533218qkk.1;
        Mon, 08 Aug 2022 04:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Qo8m4+JaUBO8TwCYugZyrFg+A5kM5JeZCqY5kQmlmyU=;
        b=Pir+jptX8VRJ8EVAtD6tXT5+75IX0KYzsXb9bbzvlPsJI4v1ChlsSUQ7ERx7dk3IiD
         6Vyxl01O5eQ+gdH+SLwH5mCCzJk2nG3uFaUOCVQhIDdhFiRP/7/+c97MbodXqF0X55Cu
         PM/DcIRZOcUy+MYek5vf88HN1bDpUcETG98sx61TJhRbn6Qcx3U+s2smusNgAgbjdsjw
         96GZKaN4vc8R1s2kk7ysdIh7IcO98gKfWd/EYa9EsgSblJ7s7+LlrSRfkpTS51KVAdYZ
         Qwym4B0UhzOJtiYK3E7kR5jhR5RchxKxhdf1dSCteua13+7/D5TlUWMILmQcY7M8DCtk
         +d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Qo8m4+JaUBO8TwCYugZyrFg+A5kM5JeZCqY5kQmlmyU=;
        b=ddx2oI6X0krNtkzIxRwePlsyyNqjAH/lq7H5aRICbRLNxMm4eQF1YVbU5VEzlQvGZT
         TxKbxvuSllfsTMy90x5zkowl2KN7okUQ7FNq41PiVwaZ1HthrqJE4g9Jm+2YguG5vVkC
         R4Kplxiv+9jr4YG9eHq5Mjwe6JaDH/5yQb7Q28n8A/Lii8qi5wzVib/An5ktgg/Z+/2K
         KK5oR1eOFTiHGWIU1DcGzkbG94FTyFVX5Ci8C1/hqbfv+2BRX/b9vzb9DiGqqhJc0ABz
         7PoF6HCRQSGjTUlFIq03rCwd+Qsub6/fYWugCyog8uCHuwGpM57/9PgRSsx4flUIZ4U0
         ob3A==
X-Gm-Message-State: ACgBeo2106K3d3wpEzsgrSWYLwWD1RQVfZvGPlGz++xMgSMtKTP1SNPq
        iDNonIYFE0rzUQOiWS6gl3nGgf+602U5sJCbZ0U=
X-Google-Smtp-Source: AA6agR4MPB6bchiE70z1ZxXE04FW0qRuKvTFfYUPlSOk6YpjiOc5I+b4ZgbaiH5i6eC9sCOplXqIf1+FTgSZmM9/U2g=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr13544878qko.383.1659957522822; Mon, 08
 Aug 2022 04:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
 <202208081346.EWHUWCSa-lkp@intel.com>
In-Reply-To: <202208081346.EWHUWCSa-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:18:06 +0200
Message-ID: <CAHp75VecMvtHwkA6=JxHbX0oeRg+-fXNraggBCaOxqhf9WUdzQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] iio: magnetometer: yas530: Introduce "chip_info" structure
To:     kernel test robot <lkp@intel.com>
Cc:     Jakob Hauser <jahau@rocketmail.com>,
        Jonathan Cameron <jic23@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 8, 2022 at 7:40 AM kernel test robot <lkp@intel.com> wrote:

...

> All errors (new ones prefixed by >>):
>
> >> drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initializer element is not a compile-time constant
>                    .product_name = yas5xx_product_name[yas530],
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 error generated.

What?!

The yas530 is a part of the enum, how come that compiler can't see
this? Looks like a Clang bug.

>    930  static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>    931          [yas530] = {
>    932                  .devid = YAS530_DEVICE_ID,
>  > 933                  .product_name = yas5xx_product_name[yas530],
>    934                  .version_name = yas5xx_version_names[yas530],
>    935          },
>    936          [yas532] = {
>    937                  .devid = YAS532_DEVICE_ID,
>    938                  .product_name = yas5xx_product_name[yas532],
>    939                  .version_name = yas5xx_version_names[yas532],
>    940          },
>    941          [yas533] = {
>    942                  .devid = YAS532_DEVICE_ID,
>    943                  .product_name = yas5xx_product_name[yas533],
>    944                  .version_name = yas5xx_version_names[yas533],
>    945          },
>    946  };

-- 
With Best Regards,
Andy Shevchenko
