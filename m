Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2D58CD4A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiHHSFB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 14:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbiHHSFA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 14:05:00 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0411ABBD;
        Mon,  8 Aug 2022 11:04:58 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d8so2433398qkk.1;
        Mon, 08 Aug 2022 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=iKTl1boGXs81S0XIZGy9zuT1guUTlkRSt68bNtAyj48=;
        b=I1giIXQaXzxH7goOQX5E/XNsipIYPuw8rQam8eTB35oVRAp1WJs1nUSQXCxU5Kj/Ms
         Mr8nKe4A3xA7orOG4APqoOrzzVYZjsbCOnem5ZnZYAkGRtRUev054yPmEPsSsbVGN+b4
         8P6YqLmqOU5YQkGgmY5YKUNxd55gsihSVg0H/8d0l5PNRvhN/X0Wuma3Zgtz0pHmXKqv
         a+JVOCG2Np3fNNpyi0SWhFamI48pFOcXMRY0L7g/TPBovXWQqYCqSV+dLDbJ15G+KLk/
         5TGQi129z584uijis3a0oKfMC9Q7czqEnAUZc2U18fYtgV0IsEZYedX2mdxvDujaHoYp
         ClIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=iKTl1boGXs81S0XIZGy9zuT1guUTlkRSt68bNtAyj48=;
        b=221DgUaBnGVTS0uD1hK+I56pr0MdSzn4cgz1swvU93Jgb9pqExzLgLVM1X6AgaKUfz
         cLY3OnRi6rs6OE4SdqIiv84g6HK936wwSV03PMO5SQaH0NTsIYSopYUK9E8Cwo0eomDR
         45UVZICctBPHTYIwq0m0zVCNHvpIu8bDmUBmzPYOlG2dc2z05qVVBd3ff68x0WZYhAKQ
         weedw/L69kDXOCyl9UJv0XvnWxaWPskIlJQrIx1M3Brw/FVzQw7dR6rh84wxdJQ6kK3h
         PivUhV7c0WWFir2gnJHj3wUYGIdUsaJ2ad4PCIg5ml2Io04fwns010iev7XMVaSc0z/W
         aFyw==
X-Gm-Message-State: ACgBeo0NvXXV6j3T5nIiB7G87zhm2JknpKD6CZcBTixMOYRyYBPFSjXv
        xO9CGBX7O8WgmkKbzd2MsktwwFTg8Xf0zaA8mDk=
X-Google-Smtp-Source: AA6agR4a8AS6ZBY7Z9sWtHuV87khvS3reFLLGtpNLhyD4PMToqruZflY6B1UOYmD7cykvxPVLd9qSltfW+ghkgL6MQE=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr14918080qko.383.1659981897015; Mon, 08
 Aug 2022 11:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
 <202208081346.EWHUWCSa-lkp@intel.com> <CAHp75VecMvtHwkA6=JxHbX0oeRg+-fXNraggBCaOxqhf9WUdzQ@mail.gmail.com>
 <YvEy9uq49ZiBHtFd@dev-arch.thelio-3990X>
In-Reply-To: <YvEy9uq49ZiBHtFd@dev-arch.thelio-3990X>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 20:04:20 +0200
Message-ID: <CAHp75VePJ2iKDx0Sj5SErW4nfpx-9KrN3c5yRFyfwgpfnMCkEg@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] iio: magnetometer: yas530: Introduce "chip_info" structure
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Jonathan Cameron <jic23@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 8, 2022 at 5:59 PM Nathan Chancellor <nathan@kernel.org> wrote:
> On Mon, Aug 08, 2022 at 01:18:06PM, +0200, Andy Shevchenko wrote:
> > On Mon, Aug 8, 2022 at 7:40 AM kernel test robot <lkp@intel.com> wrote:
> >
> > ...
> >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initialize=
r element is not a compile-time constant
> > >                    .product_name =3D yas5xx_product_name[yas530],
> > >                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    1 error generated.
> >
> > What?!
> >
> > The yas530 is a part of the enum, how come that compiler can't see
> > this? Looks like a Clang bug.
>
> That is not what clang is complaining about here, you'll see the same
> error even if you used '0', '1', or '2' here:
>
>   drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initializer ele=
ment is not a compile-time constant
>                   .product_name =3D yas5xx_product_name[0],
>                                   ^~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
>
> It is complaining that the initializer element
> ('yas5xx_product_name[yas530]', rather than just 'yas530') is not
> constant, which is a true complaint if I am reading C11 standard 6.6.7
> correctly.
>
> GCC 8+ has chosen to accept const structures as constant expressions in
> designated initializers, which it is allowed to do per 6.6.10. Nick did
> have a patch to try and match this behavior in clang but the work that
> was requested doesn't seem to be trivial so it was never finalized:
> https://reviews.llvm.org/D76096
>
> You'll see the same error with GCC 7:
>
>   drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initializer ele=
ment is not constant
>      .product_name =3D yas5xx_product_name[yas530],
>                      ^~~~~~~~~~~~~~~~~~~
>   drivers/iio/magnetometer/yamaha-yas530.c:933:19: note: (near initializa=
tion for =E2=80=98yas5xx_chip_info_tbl[0].product_name=E2=80=99)
>   drivers/iio/magnetometer/yamaha-yas530.c:938:19: error: initializer ele=
ment is not constant
>      .product_name =3D yas5xx_product_name[yas532],
>                      ^~~~~~~~~~~~~~~~~~~
>   drivers/iio/magnetometer/yamaha-yas530.c:938:19: note: (near initializa=
tion for =E2=80=98yas5xx_chip_info_tbl[1].product_name=E2=80=99)
>   drivers/iio/magnetometer/yamaha-yas530.c:943:19: error: initializer ele=
ment is not constant
>      .product_name =3D yas5xx_product_name[yas533],
>                      ^~~~~~~~~~~~~~~~~~~
>   drivers/iio/magnetometer/yamaha-yas530.c:943:19: note: (near initializa=
tion for =E2=80=98yas5xx_chip_info_tbl[2].product_name=E2=80=99)

> > >    930  static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] =
=3D {
> > >    931          [yas530] =3D {
> > >    932                  .devid =3D YAS530_DEVICE_ID,
> > >  > 933                  .product_name =3D yas5xx_product_name[yas530]=
,
> > >    934                  .version_name =3D yas5xx_version_names[yas530=
],

Would then

  .product_name =3D "YAS530 MS-3E",
  .version_names =3D { "A", "B" },

work?

Jakob, note 's' in the field name as well.

> > >    935          },
> > >    936          [yas532] =3D {
> > >    937                  .devid =3D YAS532_DEVICE_ID,
> > >    938                  .product_name =3D yas5xx_product_name[yas532]=
,
> > >    939                  .version_name =3D yas5xx_version_names[yas532=
],
> > >    940          },
> > >    941          [yas533] =3D {
> > >    942                  .devid =3D YAS532_DEVICE_ID,
> > >    943                  .product_name =3D yas5xx_product_name[yas533]=
,
> > >    944                  .version_name =3D yas5xx_version_names[yas533=
],
> > >    945          },
> > >    946  };

--=20
With Best Regards,
Andy Shevchenko
