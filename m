Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179D35F50ED
	for <lists+linux-iio@lfdr.de>; Wed,  5 Oct 2022 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJEIg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Oct 2022 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJEIgX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2022 04:36:23 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF11733C1
        for <linux-iio@vger.kernel.org>; Wed,  5 Oct 2022 01:36:22 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ay9so9561012qtb.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Oct 2022 01:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=4yc2ManKI3PnZHl6D22lOOBNCms+IQgL/VUKb/ICEEY=;
        b=k3WIqDF57Vvae0mBn1OwAGPYLXdLq/9KxmaStFTtzdetMnkTBOr+TSHx1zA0idUE6/
         /zioDi9N8NXZBSr7ROkVLBahdePDBgw56YkwzK9kCeHNLqijBXQof32Biw/wS+0CkHZ3
         UfQecVco3TBJIQk3xGSs3PDTtzBP3EiaN8UZ27uVrqT1k+ULfITNAUqeoiSkKsWVclc3
         +2ZxKmFVbAlfop4jsaHkXzdV0Qs18fPRM6Xq+YnAKc6BmPsqu1rCAzhwuy3hJqViPGbN
         H9zZImsxCV9H3wmbTbO0aFsXmBjiIsgU3SoeF9sUNIx1KExak7DQiJOn5Ffo5tLOfAkI
         /NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=4yc2ManKI3PnZHl6D22lOOBNCms+IQgL/VUKb/ICEEY=;
        b=5SuQJsPWyJjHwC2UsSwPTCTNWauEyGp4rUFdzhz+Xuaay8zUKjQm+a+p8xHmtOoGZ4
         4k3ELNP50Zn+1GBYrCge9pLNcVqOt0hLWV6RxfeFw4Q49lZBRsqBWNOnPyfFcq/nfNZV
         vjU9tmEHMY1IMLPNCtT876IJSCXAec+v4NVutJ457fmjbQVJ4GeIfqyy4916uCBV+mkD
         4VyT0NMoBEgt/N1rP/rirzWb6BnDxJuuNmyMup61YWo1GiaaqJuBS7lkgeYyBGeGGr5q
         MsLRv2J1etg2HvewgmujyHA1S52TdyXlmne2jpnmp1G+BH8pVT0pHsp6j2gYPJH1C3bm
         NLTw==
X-Gm-Message-State: ACrzQf0dKpfBJTyGaOe6rRNYYR9tZeQcL3lzTbyb3M1gkzvxnDajACB+
        jZY90w85F7QeDpJvEm2j1xw=
X-Google-Smtp-Source: AMsMyM7YhR4mT2T8jkP88VsfBjDaKhiJx1QVUwb6XT51xZ3yYitgB7ulQA2cbACPeldCXQSGlQtQ9A==
X-Received: by 2002:a05:622a:652:b0:38f:1b14:3e6d with SMTP id a18-20020a05622a065200b0038f1b143e6dmr2653358qtb.152.1664958981646;
        Wed, 05 Oct 2022 01:36:21 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id g4-20020ac81244000000b0039014fd4b9bsm1314649qtj.47.2022.10.05.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 01:36:20 -0700 (PDT)
Message-ID: <609d7e50d76a2a2aa2bbaddfed8a846c91854065.camel@gmail.com>
Subject: Re: [PATCH v2 13/16] iio: core: introduce
 iio_device_{claim|release}_buffer_mode() APIs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Wed, 05 Oct 2022 10:37:39 +0200
In-Reply-To: <CAHp75VfmMWonUV1jahbAmBZJixfdxA=ZAm-NNt7XiO+RDbupyg@mail.gmail.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
         <20221004134909.1692021-14-nuno.sa@analog.com>
         <CAHp75VfmMWonUV1jahbAmBZJixfdxA=ZAm-NNt7XiO+RDbupyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2022-10-04 at 17:08 +0300, Andy Shevchenko wrote:
> On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > These APIs are analogous to iio_device_claim_direct_mode() and
> > iio_device_release_direct_mode() but, as the name suggests, with
> > the
> > logic flipped. While this looks odd enough, it will have at least
> > two
> > users (in following changes) and it will be important to move the
> > iio
> > mlock to the private struct.
>=20
> ...
>=20
> > +int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&indio_dev->mlock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_buffer_enabled(indio_dev)=
)
>=20
> Do you need to annotate these two APIs to make sparse happy about
> locking balance?
>=20
> (Try to run `make W=3D1 C=3D1 ...` with your patches and look if any new
> warnings appear.)

make W=3D1 C=3D1 drivers/iio/industrialio-core.o
#  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  CC      drivers/iio/industrialio-core.o
  CHECK   drivers/iio/industrialio-core.c
drivers/iio/industrialio-core.c: note: in included file (through
include/linux/bitops.h, include/linux/kernel.h):
./include/asm-generic/bitops/generic-non-atomic.h:30:9: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:31:9: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:33:10: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:33:16: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:28:1: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:39:9: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:40:9: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:42:10: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:42:16: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:37:1: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:57:9: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:58:9: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:60:10: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:60:15: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:55:1: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:75:9: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:76:9: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:77:9: warning:
unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:79:10: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:79:14: warning:
unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:79:20: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:80:17: warning:
unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:80:23: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:80:9: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:73:1: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:95:9: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:96:9: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:97:9: warning:
unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:99:10: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:99:14: warning:
unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:99:21: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:100:17: warning:
unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:100:23: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:100:9: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:93:1: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:107:9: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:108:9: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:109:9: warning:
unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:111:10: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:111:14: warning:
unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:111:20: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:112:17: warning:
unreplaced symbol 'old'
./include/asm-generic/bitops/generic-non-atomic.h:112:23: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:112:9: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:105:1: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:128:9: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:121:1: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:168:9: warning:
unreplaced symbol 'p'
./include/asm-generic/bitops/generic-non-atomic.h:169:9: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:170:9: warning:
unreplaced symbol 'val'
./include/asm-generic/bitops/generic-non-atomic.h:172:19: warning:
unreplaced symbol 'val'
./include/asm-generic/bitops/generic-non-atomic.h:172:25: warning:
unreplaced symbol 'mask'
./include/asm-generic/bitops/generic-non-atomic.h:172:9: warning:
unreplaced symbol 'return'
./include/asm-generic/bitops/generic-non-atomic.h:166:1: warning:
unreplaced symbol 'return'
drivers/iio/industrialio-core.c:2100: warning: expecting prototype for
iio_device_claim_buffered_mode(). Prototype was for
iio_device_claim_buffer_mode() instead

Don't really see anything odd in here... Am I missing something?=20

Anyways, I guess you mean annotations as __acquires() and
__releases()... Well, this API is pretty much analogous to
iio_device_claim_direct_mode() which also don't have such annotations.
Thus, I would say to add them (if we are going too) in a future patch
to both APIs...

Also fine with adding them now if Jonathan feels it's necessary.

- Nuno S=C3=A1=20

