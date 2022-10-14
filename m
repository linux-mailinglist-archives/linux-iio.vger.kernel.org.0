Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5FF5FE979
	for <lists+linux-iio@lfdr.de>; Fri, 14 Oct 2022 09:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJNHYr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Oct 2022 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJNHYn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2022 03:24:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1958D63A7
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2022 00:24:41 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id jr1so3197191qtb.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2022 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=guXsNvunppVc9WWPiCDXMbZ55lmfscZRL3+k5ViV9No=;
        b=oUsQIAOiDc9y41fuV+L7s+WM/p3Q61/2Dnxn688nE2CqTH0uCcstpSKfByFHA78F+d
         l0Jd7Ibdy+zlNJ9yeUlf4hH/SWERQ8sQgro+Og9GEKOHGUQngTHQ2WK1apmXfj7luXjT
         +kDSCGhGu+zDLhPTLA9zgsCRFVk2Jed+lW1baX+/+Td8OV+U/F63Cbdca8Ppv0QdLpuB
         n5suh65nbDD7VRWarfniOC/sOA0qSy/BV5iFa2tYc7Y56cWhnzmR41oa3Qb97AhZknUD
         wwmf8rEcni44ROfAJYeoJEOLJi6og1jxgMl2806+/aVLr5UpujCp42rxsno34UPDECIT
         TWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guXsNvunppVc9WWPiCDXMbZ55lmfscZRL3+k5ViV9No=;
        b=YidGXiKpiCJBxAW9hhxEz7WZ7oHeEv0XCHobMp9KHANxD2PM3qyW6pYB9qsr/+tKEw
         5G+qzHFv3LWpnN8kSrLUfucuTZ+uDK8GyFK9inNSUEY3IIx9vj0BqnLjggEhnym2NGL5
         bg+WFjzYxZlWuqgUzWx+b6gz9dwL9ZGoDHP+CKUMBAEwkHINEYjbR+qgFh5wKpMqzWFA
         QCmU+o10SeVZ1Qq5gsQA16frk1fnjZBqC/yTpLf9WHc2nYroYQLJP1AMbDL+ZLiQjbsX
         DQ6ply7J5oAz2uULqaAdURoFNIxNi1jBaPSyQEMU0LjhGUZkHksTd5TRGB69QbE2urBi
         vyGw==
X-Gm-Message-State: ACrzQf1+cCiyScFwbLvTvIJqegkvzgtE80LxV4g7SkPd/ON44x8db5uO
        gmqXZHa1a8syadp4r8MVlt4=
X-Google-Smtp-Source: AMsMyM7gMIH996fPil0I2eH6kEfzrcR7fJOfL5qMY+5BrnG0S7Swr4k4YGgxRpFyQLhQYDs/Z/bWVw==
X-Received: by 2002:ac8:5cc3:0:b0:35c:e1b3:78c5 with SMTP id s3-20020ac85cc3000000b0035ce1b378c5mr3078874qta.228.1665732280128;
        Fri, 14 Oct 2022 00:24:40 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id bs10-20020a05620a470a00b006b615cd8c13sm1711743qkb.106.2022.10.14.00.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 00:24:39 -0700 (PDT)
Message-ID: <fccf3f41b32e881eb79ee78852fa40a62b134c00.camel@gmail.com>
Subject: Re: [PATCH v3 3/4] iio: health: max30102: do not use internal
 iio_dev lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com,
        Chen-Yu Tsai <wens@csie.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Date:   Fri, 14 Oct 2022 09:25:59 +0200
In-Reply-To: <20221012204556.7648df2e@xps-13>
References: <20221012151620.1725215-1-nuno.sa@analog.com>
         <20221012151620.1725215-4-nuno.sa@analog.com>
         <20221012204556.7648df2e@xps-13>
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

On Wed, 2022-10-12 at 20:45 +0200, Miquel Raynal wrote:
> Hi Nuno,
>=20
> nuno.sa@analog.com=C2=A0wrote on Wed, 12 Oct 2022 17:16:19 +0200:
>=20
> > The pattern used in this device does not quite fit in the
> > iio_device_claim_direct_mode() typical usage. In this case, we want
> > to
> > know if we are in buffered mode or not to know if the device is
> > powered
> > (buffer mode) or not. And depending on that max30102_get_temp()
> > will
> > power on the device if needed. Hence, in order to keep the same
> > functionality, we try to:
> >=20
> > 1. Claim Buffered mode;
> > 2: If 1) succeeds call max30102_get_temp() without powering on the
> > =C2=A0=C2=A0 device;
> > 3: Release Buffered mode;
> > 4: If 1) fails, Claim Direct mode;
> > 5: If 4) succeeds call max30102_get_temp() with powering on the
> > device;
> > 6: Release Direct mode;
> > 7: If 4) fails, goto to 1) and try again.
> >=20
> > This dance between buffered and direct mode is not particularly
> > pretty
> > (as well as the loop introduced by the goto statement) but it does
> > allow
> > us to get rid of the mlock usage while keeping the same behavior.
>=20
> What about adding a TODO comment saying something like: "this comes
> from static analysis and helped dropping mlock access, but someone
> with
> the device needs to figure out if we can simplify this dance"?
> Because
> the reason behind all this is that we don't want to risk breaking the
> driver, but perhaps a simpler approach would work, right?
>=20

Hi Miquel,

AFAIU, either the device is powered (when buffer mode enabled) and we
can do the reading or it's not and we need to power it on/off
"manually" while making sure we don't race against enable/disabling
buffers. This "dance" is needed mainly to make sure that we grab
'mlock' one way or another... The other way would be to use some
specific device lock together with a flag (as discussed) but as
discussed with Jonathan we decided to go down this road... So,
honestly, I don't really see the necessity of "marking" this code with
a TODO but of course if someone comes in with something simpler, great
:).

Anyways, as I said, I'm not really keen in spinning a new version to
add this comment so I will defer the decision to Jonathan :) =20

Thanks for the help!
- Nuno S=C3=A1

