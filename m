Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3435F452D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 16:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJDOJP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 10:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJDOJO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 10:09:14 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E155F7F1
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 07:09:13 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id z18so8557706qvn.6
        for <linux-iio@vger.kernel.org>; Tue, 04 Oct 2022 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=k5qgEwmlmu6XfbxksdbQVs3dR7U1LRK27qi7hYRrulk=;
        b=aI9/RjvLMMZI7wMwAJpv6hZvMrUpHfzqg+UrfCD3zYxJARyK/Z75x4H6U12gEt+PS+
         LQw5KE6rT0O5kFPMKBHUb9CoRTxrY3MLgUDYKTtX7w//Fd2YB3LJM9nP79HW+iug7k22
         BDL3kqZmx7iOmiqcceXJ4M+XyhSUPbfcimOSfIu6dMvu6oW7w1ZXHmVVBfuWkStx3fM2
         qwLKhRuP/ca9+EQKeHg+1I2dTZkY/di0lSzEy7QbrVKZuSTnicCULJyHDPF5bWb122b2
         P6zfde4/8Krdur9bprfn+ovn+PPTysO2VX6CG7tHrzmCz74eY6N65r0ziMYyZItzYoNN
         Bo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k5qgEwmlmu6XfbxksdbQVs3dR7U1LRK27qi7hYRrulk=;
        b=fltduopQIaINCObAcRqWVGVioseuIna0QUjUfFMseboFSG3SadbFMPV1OjFkYmf0oH
         r2K8qt7FIp419HeRGx8eselseZdTHeFR4uK9nNF6ymZ+yHYxrjLSyS31YzY6xRoU3Urt
         gq/0jfe/ByGdYUG+2EVAM0269444FrOpbMcy713xD8GpAJWwk/X4QE1CP+xjN483oATb
         4pAtHPHNw6Lpx2nN8Ho23MkY+IL6BTZfpBPxWHaNia4cUCeF/n1aCsn3B6KSedrJIZb0
         lRToHD/cERxORXG35mmY0dO+HWbNXcbasc02DoDWAJ8o+iIcUxH3L0DHb55qra+oZW21
         QJOA==
X-Gm-Message-State: ACrzQf28pA4tdWpuNK7spVwfT+kGhyoojcIBuSzVj0mLq88odgV06kK+
        kUe+HNqbjpv0isTRcEfHtbAewXwYXjPYLHl0/3w=
X-Google-Smtp-Source: AMsMyM6Y9zW6zpA4T8ZHHnNC32h6dXOzM3iXU64FXvn10v2xWFUT4q4TMqc3XT+4240HQYvt1z6bIY0FhvCMohwPHuw=
X-Received: by 2002:a05:6214:3011:b0:4b1:be7e:3f93 with SMTP id
 ke17-20020a056214301100b004b1be7e3f93mr1027074qvb.48.1664892552392; Tue, 04
 Oct 2022 07:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221004134909.1692021-1-nuno.sa@analog.com> <20221004134909.1692021-14-nuno.sa@analog.com>
In-Reply-To: <20221004134909.1692021-14-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Oct 2022 17:08:35 +0300
Message-ID: <CAHp75VfmMWonUV1jahbAmBZJixfdxA=ZAm-NNt7XiO+RDbupyg@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] iio: core: introduce iio_device_{claim|release}_buffer_mode()
 APIs
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
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

On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> These APIs are analogous to iio_device_claim_direct_mode() and
> iio_device_release_direct_mode() but, as the name suggests, with the
> logic flipped. While this looks odd enough, it will have at least two
> users (in following changes) and it will be important to move the iio
> mlock to the private struct.

...

> +int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
> +{
> +       mutex_lock(&indio_dev->mlock);
> +
> +       if (iio_buffer_enabled(indio_dev))

Do you need to annotate these two APIs to make sparse happy about
locking balance?

(Try to run `make W=3D1 C=3D1 ...` with your patches and look if any new
warnings appear.)

> +               return 0;
> +
> +       mutex_unlock(&indio_dev->mlock);
> +       return -EBUSY;
> +}

...

> +void iio_device_release_buffer_mode(struct iio_dev *indio_dev)
> +{
> +       mutex_unlock(&indio_dev->mlock);
> +}

--=20
With Best Regards,
Andy Shevchenko
