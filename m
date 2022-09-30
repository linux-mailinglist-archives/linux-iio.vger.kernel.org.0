Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA7B5F0833
	for <lists+linux-iio@lfdr.de>; Fri, 30 Sep 2022 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiI3KDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Sep 2022 06:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiI3KD2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2022 06:03:28 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E5DE2CD3
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2022 03:03:24 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id z18so2294587qvn.6
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2022 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=iQqXgr+4YepRHf5MCkYU6O/jwsUQ9T5ainHxb7iM9i8=;
        b=UPkltYBuAXyB4MSvRfTaRXkSGTXUCp8YorMZlcDDO0ubsdnJRKFwB3PpUAxSFtm/M2
         6ZDek0f7m8QUuh89t2RYXodCFISGTT+IYHl/7EYderLges97lwhvTpAQC3GkmCKXL/K+
         PjAlcUnrPIcoOhEyZbetlMgX7lDx65Vdvg60zR1AiteeuCMz9TOjjeDHn29z5DdhIzvQ
         DQ7RlfWTsLYmdaRdrVQ+yRmCiJ5CEIOxn+U/vc0mFLJMA0j9UUy6Z1zsVwL4fdLU/lCw
         P5lhLewWXYLpMc1DK9BnzpUEV98rOxOubqIo/OhbsS+UGVHpi0RuzafuFnO+CezwC/M0
         AK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=iQqXgr+4YepRHf5MCkYU6O/jwsUQ9T5ainHxb7iM9i8=;
        b=cdi6dmP8O+JfC5DYM25Ztr7beCmwc+ZHWhXvWbkQq5iXAfNqgychuRdNW/+2TLv/q4
         VjoKtYIBVx85+kQKDGIpVh5e/CASev7fGy4e7iIGOfFCqnQklEZO+uQqd9hwIAPZiNaT
         zCWKqxi7xY0uCbHSJJvT/kDid0OdgF4VWu+Qew6muWxLoptM9YwnPxTwYKdSVg/rJ6qz
         CpRtxq0rP++L3YSjZsmRN6AdcnQgCaC9QPShooKnxykD/GTzRZhqPHeBmWG4a2pyLeHI
         6RXjjkHID9yd3WXLCD7vMO7XYXMnuiK5FPv0JXXbeu5WgePQSehg4bfvApSZ5x85AISh
         eyqQ==
X-Gm-Message-State: ACrzQf0H5WX03FKOm/dTn5he9VnWoBhqHyYW+BLrNU6LZr69WD6KGs4T
        ucgT5nmaeGHLRdzQmVAIedw=
X-Google-Smtp-Source: AMsMyM7gteQgf8eFvijooshAhE+MKquJs8M2jlrI42yG3DNEqfFJesHyQ7u4AQI8DGi9Oe8FfVAzWA==
X-Received: by 2002:a05:6214:224b:b0:4af:b412:2269 with SMTP id c11-20020a056214224b00b004afb4122269mr3997334qvc.54.1664532203236;
        Fri, 30 Sep 2022 03:03:23 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id b8-20020ac844c8000000b0035d57445127sm1484058qto.47.2022.09.30.03.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:03:22 -0700 (PDT)
Message-ID: <d41b131df565e7c7d6083ebbd7de0346c46b9e23.camel@gmail.com>
Subject: Re: [PATCH 14/15] iio: health: max30102: do not use internal
 iio_dev lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Date:   Fri, 30 Sep 2022 12:04:39 +0200
In-Reply-To: <20220924165417.46a1fc44@jic23-huawei>
References: <20220920112821.975359-1-nuno.sa@analog.com>
         <20220920112821.975359-15-nuno.sa@analog.com>
         <20220924165417.46a1fc44@jic23-huawei>
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

On Sat, 2022-09-24 at 16:54 +0100, Jonathan Cameron wrote:
> On Tue, 20 Sep 2022 13:28:20 +0200
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > The pattern used in this device does not quite fit in the
> > iio_device_claim_direct_mode() typical usage. In this case,
> > iio_buffer_enabled() was being used not to prevent the raw access
> > but to decide whether or not the device needs to be powered on
> > before.
> > If buffering, then the device is already on. To guarantee the same
> > behavior, a combination of locks is being used:
> >=20
> > 1. Use iio_device_claim_direct_mode() to check if direct mode can
> > be
> > claimed and if we can, then we keep it until the reading is done
> > (which
> > also means the device will be powered on and off);
> > 2. If already buffering, we need to make sure that buffering is not
> > disabled (and hence, powering off the device) while doing a raw
> > read. For
> > that, we can make use of the local lock that already exists.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Obviously same dance in here as the related previous patch. So same
> solution
> needs adopting.=C2=A0 I just thought I'd reply to make sure we didn't
> forget to
> cover them both :)
>=20
>=20
Hi Jonathan,

So I was working on v2 in the morning and went with your
iio_device_claim_buffer_mode() approach... And bah, well it works like
a charm in the previous patch, it fails in this one:

-               mutex_lock(&indio_dev->mlock);
-               if (!iio_buffer_enabled(indio_dev))
+               if (iio_device_claim_buffer_mode(indio_dev)) {
                        ret =3D max30102_get_temp(data, val, true);
-               else
+               } else {
                        ret =3D max30102_get_temp(data, val, false);
-               mutex_unlock(&indio_dev->mlock);
-               if (ret)
+                       iio_device_release_buffer_mode(indio_dev);
+               }
+               if(ret)
                        return ret;


Note that if we are not in buffered mode we won't get mlock and call
max30102_get_temp(data, val, true) without any lock. While it's very
unlikely for someone, in the meantime, to enable the buffer and then
disable it, it's still racy and possible (at least in theory).

So, I'm thinking again on the flag approach... Just check my comment
(in the previous patch) about it being refcounted. I mean, I might be
missing something, but if we need a refcount, I would say things would
be already (potentially) broken, right?

With this step back, I'm planning on a v2 in the beginning of the week
after we have this sorted out (and I guess we need to settle things
also in the ad799x patch)

- Nuno S=C3=A1

