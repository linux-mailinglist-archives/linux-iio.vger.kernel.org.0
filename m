Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17D758CBBB
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiHHP74 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbiHHP7z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 11:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5604315713;
        Mon,  8 Aug 2022 08:59:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E95E96108A;
        Mon,  8 Aug 2022 15:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95761C433C1;
        Mon,  8 Aug 2022 15:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659974393;
        bh=Z53zG6cwPszYMRBJabN7oSlgPt8lpZ7x+FSQmyyFDUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCfbmwUe7iaiTW+EWQhXvzJsolUZNxsRviWkmW6HGvu9uraXyNRdoLV0TB7bjUjL6
         1sxcZQDro9h/8RwZR5ZDZAj6dKZaD6vKK2J4xxcqSFLoLK5a01OdCvLW0Ke4bmCw79
         /G1aOSgJCgBTQ/HKbgkBCXai9kB+ZqsW4iIxlu6CFClFXVfgnQi6JRAa3FqvKz5DQg
         0NPEbqrUwV33NDfNrtlTHx53yMSWxqUr4bY7eDdGckhz0an/lDOxiE9VMBnYlpfcsj
         qc8wzALJS0jAZM/N7oVkdpQyfEQrhKztUgw3M0JmK2Y/Bz5bePSBNF3N0wkv/o0V7u
         eTTRyGGYeMi4Q==
Date:   Mon, 8 Aug 2022 08:59:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Jonathan Cameron <jic23@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 09/14] iio: magnetometer: yas530: Introduce
 "chip_info" structure
Message-ID: <YvEy9uq49ZiBHtFd@dev-arch.thelio-3990X>
References: <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
 <202208081346.EWHUWCSa-lkp@intel.com>
 <CAHp75VecMvtHwkA6=JxHbX0oeRg+-fXNraggBCaOxqhf9WUdzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VecMvtHwkA6=JxHbX0oeRg+-fXNraggBCaOxqhf9WUdzQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Mon, Aug 08, 2022 at 01:18:06PM, +0200, Andy Shevchenko wrote:
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

That is not what clang is complaining about here, you'll see the same
error even if you used '0', '1', or '2' here:

  drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initializer element is not a compile-time constant
                  .product_name = yas5xx_product_name[0],
                                  ^~~~~~~~~~~~~~~~~~~~~~
  1 error generated.

It is complaining that the initializer element
('yas5xx_product_name[yas530]', rather than just 'yas530') is not
constant, which is a true complaint if I am reading C11 standard 6.6.7
correctly.

GCC 8+ has chosen to accept const structures as constant expressions in
designated initializers, which it is allowed to do per 6.6.10. Nick did
have a patch to try and match this behavior in clang but the work that
was requested doesn't seem to be trivial so it was never finalized:
https://reviews.llvm.org/D76096

You'll see the same error with GCC 7:

  drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initializer element is not constant
     .product_name = yas5xx_product_name[yas530],
                     ^~~~~~~~~~~~~~~~~~~
  drivers/iio/magnetometer/yamaha-yas530.c:933:19: note: (near initialization for ‘yas5xx_chip_info_tbl[0].product_name’)
  drivers/iio/magnetometer/yamaha-yas530.c:938:19: error: initializer element is not constant
     .product_name = yas5xx_product_name[yas532],
                     ^~~~~~~~~~~~~~~~~~~
  drivers/iio/magnetometer/yamaha-yas530.c:938:19: note: (near initialization for ‘yas5xx_chip_info_tbl[1].product_name’)
  drivers/iio/magnetometer/yamaha-yas530.c:943:19: error: initializer element is not constant
     .product_name = yas5xx_product_name[yas533],
                     ^~~~~~~~~~~~~~~~~~~
  drivers/iio/magnetometer/yamaha-yas530.c:943:19: note: (near initialization for ‘yas5xx_chip_info_tbl[2].product_name’)

Cheers,
Nathan

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
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
