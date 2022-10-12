Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4155FCA0E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Oct 2022 19:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJLRty (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Oct 2022 13:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJLRtw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 13:49:52 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCCC13D09
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 10:49:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i9so11392239qvo.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfLxdqnnh0d/6BCOLRProKERjFayNi0GJ0Rv9EWEt34=;
        b=WAb4g/kwIEEwbhbnWqgwC5/H9Xgf6P8cZD/8VgwmHtkgPj1jWPsHjBcQpuzdFJMP+1
         v6h73qupXsKbcMzx9p8CpGuBM2/wCnyRdJ2b1EXJIri8751zhaA414FY1aXmaejbDLGf
         syOdMp9xUfkO9Rnnofo0wjr3BAa+VHjwNZ+WCTbd7r21d9ecbbJLgaEuCGr24/m1b8or
         geikeIop6WLnPp3Ethyhk619TFr27VfcMVj2djZ0gik1ncN/ZTSNHgWjHt/xD32N6UPn
         POFTPnkFxWemyJdoVUvllbMS38yQyx1I3fm2zMgj78WoQeU4FY+EmFyPIqZfN+CF6IMF
         OcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfLxdqnnh0d/6BCOLRProKERjFayNi0GJ0Rv9EWEt34=;
        b=bYoswR0f7H+G+Uu/OJuDur7qI0ed/2YaN6S6JorE5gWxebynJ+vq8BGjrFnpiTUen6
         Lbk1zgDpxsEuuT7QIz3mkwtaiDWX/VRnf1s8y+y+LJVs8COxgv/jV6sqjfc5xRk3F1Pa
         SDGdFymT348N77Hp+elYZCf2IL/+fbbBWFHpU+4MmWMdjdYczVQCZcRU65tAPl228Iet
         U2l1lQCf7SK+92jTUKom/VEIsH0r9ElP6h6xMByntUuMcF6isd1XLPy+4APy5b8zpb+s
         UtljpJ5340fBd4V1331+NDpvfIonnA9ZSPDielcud4i9EfCWbQVFk7xEBnpONjpw05Mu
         9xTw==
X-Gm-Message-State: ACrzQf0rb5FNMXNCOZpk1tzanGfhwnlgaIitZnKbPHd4dRNrpXL4z2Qp
        QABh5clA2aMyObY4WaA/PXDiEWMe/DQ34XOojN8=
X-Google-Smtp-Source: AMsMyM4ZhWmQqY8/dfke1Qoar92HAbwtO9L1ek/Awy2la1XHak6/Y0uDCrEofraFCtkZ++U6JFUMRLP7wWAibHkOjCI=
X-Received: by 2002:a05:6214:300c:b0:4b3:cefd:fae0 with SMTP id
 ke12-20020a056214300c00b004b3cefdfae0mr20928091qvb.48.1665596989653; Wed, 12
 Oct 2022 10:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221012151620.1725215-1-nuno.sa@analog.com>
In-Reply-To: <20221012151620.1725215-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Oct 2022 20:49:13 +0300
Message-ID: <CAHp75VcUaSaAQ5Gs32bmpUyROqRLjMuDykdKp34p+2DYsovSPw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Make 'mlock' really private
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com,
        Chen-Yu Tsai <wens@csie.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 12, 2022 at 6:15 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> This patchset cleans all the drivers directly using the iio_device 'mlock=
'.
> This lock is private and should not be used outside the core (or by using
> proper helpers).
>
> Most of the conversions where straight, but there are some that really ne=
ed
> extra looking. Mainly patches [13/15] and [14/15] were a bit hacky since
> iio_device_claim_direct_mode() does not fit 100%. The reason is that we
> want to check if the device is buffering and do something if it is (in
> which case the API return -EBUSY and released the lock. I just used a
> combinations of locks to get around this (hopefully I did not messed up).
>
> Note that this series was only compiled tested using allyesconfig for
> ARM. I ran 'git grep' to make sure there were no more users of 'mlock'.
> Hopefully I covered them all...

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I haven't seen any serious issues, some small ones regarding spelling,
indentation and comment are per individual patches.

> v2:
>
> [PATCH 1-8, 10-12/16]
>  * Mention the inclusion of mutex.h in the commit message.
>
> [PATCH 1-8, 10, 12/16]
>  * Initialize mutex as late as possible.
> Note that [PATCH 11/16] was not included since the code to do so was not
> direct enough. Would need to get a pointer to the private struture
> outside of scmi_alloc_iiodev() to do it. While not hard, the added change=
s
> in the code is not really worth it (IMO of course).
>
> [PATCH 1/16]
>  * Refactored the commit message a bit. I guess this one will still needs
> more discussion...
>
> [PATCH 9/16]
>  * New patch to add an helper function to read the samples.
>
> [PATCH 13/16]
>  * New patch to introduce iio_device_{claim|release}_buffer_mode() APIs.
>
> [PATCH 14/16]
>  * Make use of the new iio_device_{claim|release}_buffer_mode() helpers
>
> [PATCH 15/16]
>  * Make use of the new iio_device_{claim|release}_buffer_mode() helpers
> in combination with claim_direct_mode(). This is needed so that we make s=
ure
> we always get one of the modes (and hence the iio_dev lock) to safely cal=
l
> max30102_get_temp(). Note that I'm not particular "happy" with the code b=
ut
> OTOH, it does not look as bad as I thought :). Anyways, if there are no
> complains with it, I'm ok to leave it as-is. Otherwise, I think we can th=
ink
> on the flag approach (briefly discussed in the first series).
>
> v3:
>
> [PATCH 1/4]
>  * fix 'make W=3D1' warning about prototypes mismatch.
>
> [PATCH 2/4]
>  * improved commit message to explain why we are shadowing error codes.
>
> [PATCH 4/4]
>  * minor English fix on the commit message (as suggested by Andy).
>
> Nuno S=C3=A1 (4):
>   iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs
>   iio: health: max30100: do not use internal iio_dev lock
>   iio: health: max30102: do not use internal iio_dev lock
>   iio: core: move 'mlock' to 'struct iio_dev_opaque'
>
>  drivers/iio/TODO                   |  3 --
>  drivers/iio/health/max30100.c      |  9 ++---
>  drivers/iio/health/max30102.c      | 19 +++++++---
>  drivers/iio/industrialio-buffer.c  | 29 ++++++++-------
>  drivers/iio/industrialio-core.c    | 58 +++++++++++++++++++++++++-----
>  drivers/iio/industrialio-event.c   |  4 +--
>  drivers/iio/industrialio-trigger.c | 12 +++----
>  include/linux/iio/iio-opaque.h     |  2 ++
>  include/linux/iio/iio.h            |  5 ++-
>  9 files changed, 97 insertions(+), 44 deletions(-)
>
> --
> 2.38.0
>


--=20
With Best Regards,
Andy Shevchenko
