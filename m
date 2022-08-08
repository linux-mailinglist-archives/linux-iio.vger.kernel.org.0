Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA758C77E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiHHLY5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHHLYz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:24:55 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7AEDF93;
        Mon,  8 Aug 2022 04:24:54 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id mk9so6085769qvb.11;
        Mon, 08 Aug 2022 04:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bebjkEu/2RtpzlLSCENPsZbQJUlDS0rYB/TyG6UnNbA=;
        b=ZEENe9jAyGJr7LcwsagGW7sgUrXkkIYYVaYWX2VRnNbSPotG4APfiO0gwtKLKxztXG
         tsLtn5wFxzUAErbqdLDSpQu81NDF7/1Y72KYD7/mJWHOxYwW2Fp7XnCXcZBEIcvtenME
         2Wt1vEVteeiHDGu24ceDOvBgGJxLp2PopDZdogli7MCUEn++M3yJipsUGEH0K9rsorL6
         /ZX5Jzqh5xKkaskYdhVCpiCRgHQ3Dk/xe176iu0HCVOufrqXVZCx+sl5x5SEVqX+SFZ/
         Zj78WVLNSMRvReDCPdQ0Cd9ebCq8y9UXBiTqwpvPTdRNuOJuBFFJ1V0LDNJfKQOHLd5A
         RaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bebjkEu/2RtpzlLSCENPsZbQJUlDS0rYB/TyG6UnNbA=;
        b=Au56hj/TpTA3Bmcx6gysvifh6YO/rZ1DgNEPk2/CBfRO20/BWSm2CLczZafpHbHYID
         Fa86HSm5kuKp0S2sgEYxN6/0N1PW51PzMRTesvM1L1SbUfJ5sHPylJCEVYTn8Wv4kgq2
         0SB2zkDo/UK+yRSC0djViTvNJojdZdRG7M/QPEdzFR69LhSU63exsQmMj/SfFBDkxXht
         kx0Pxk9ICWqZaZUeabYOVPnPagSz3nFu50d1gA9R8wprhsV3lcpWgonhAIyvECMkvThX
         RsBB9f7x/nZuLhBnq/ksA+w98/FFvuI4Woy1zDR5AEaqaig93NEHWq7ymWkRwZeN7RY7
         x6uQ==
X-Gm-Message-State: ACgBeo0ba4GU9rnwJH4N+01f7pUc69X+HvmjblEgbrJRsMJJv94j1iZx
        nmsfFc5P9zsa6xCwD/zBP7DxZtpZous0RXV9NGY=
X-Google-Smtp-Source: AA6agR5b9TU3myq3WlLGqEHuTqv5fOuqcyVNntRR95IfrJghUij9L87Ygd29nhaXz22WtMG8ZI00HIHPC66SClnPtAk=
X-Received: by 2002:ad4:5cc3:0:b0:474:8dda:dfb6 with SMTP id
 iu3-20020ad45cc3000000b004748ddadfb6mr15416031qvb.82.1659957893856; Mon, 08
 Aug 2022 04:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
 <202208081346.EWHUWCSa-lkp@intel.com> <CAHp75VecMvtHwkA6=JxHbX0oeRg+-fXNraggBCaOxqhf9WUdzQ@mail.gmail.com>
In-Reply-To: <CAHp75VecMvtHwkA6=JxHbX0oeRg+-fXNraggBCaOxqhf9WUdzQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:24:17 +0200
Message-ID: <CAHp75VfARgxj0iSq_WPHH5Jq9iYoW3uL5mz7E4kYOdzTLbYvJw@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] iio: magnetometer: yas530: Introduce "chip_info" structure
To:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

+Cc: clang people

On Mon, Aug 8, 2022 at 1:18 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Aug 8, 2022 at 7:40 AM kernel test robot <lkp@intel.com> wrote:
>
> ...
>
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initializer element is not a compile-time constant
> >                    .product_name = yas5xx_product_name[yas530],
> >                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    1 error generated.
>
> What?!
>
> The yas530 is a part of the enum, how come that compiler can't see
> this? Looks like a Clang bug.
>
> >    930  static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
> >    931          [yas530] = {
> >    932                  .devid = YAS530_DEVICE_ID,
> >  > 933                  .product_name = yas5xx_product_name[yas530],
> >    934                  .version_name = yas5xx_version_names[yas530],
> >    935          },
> >    936          [yas532] = {
> >    937                  .devid = YAS532_DEVICE_ID,
> >    938                  .product_name = yas5xx_product_name[yas532],
> >    939                  .version_name = yas5xx_version_names[yas532],
> >    940          },
> >    941          [yas533] = {
> >    942                  .devid = YAS532_DEVICE_ID,
> >    943                  .product_name = yas5xx_product_name[yas533],
> >    944                  .version_name = yas5xx_version_names[yas533],
> >    945          },
> >    946  };

-- 
With Best Regards,
Andy Shevchenko
