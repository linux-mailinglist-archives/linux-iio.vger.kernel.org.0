Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213F6550506
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiFRNLl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 09:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiFRNLk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 09:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9A17079
        for <linux-iio@vger.kernel.org>; Sat, 18 Jun 2022 06:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08B2160B97
        for <linux-iio@vger.kernel.org>; Sat, 18 Jun 2022 13:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1924C3411A;
        Sat, 18 Jun 2022 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655557897;
        bh=eLZj0TBzW6kjVFOhmlMgqKyUQcYLNqcUvNu5rXRrGd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PTmQwS4Wsd0oV0sexU5zDQqyuMwmaI/3+L6sJXWufkr1u/w6JMumcm2NoO7og5q7I
         kDmj0hzksxlDAmlRnLcCGNzPmqherAHWztw8xXclGz52NO/T1o0zLMHoYRb2li8s6c
         TkcIzraPKAE+00LssCJ5w26NRQpkq4vhrTumkly1Z4Bp/qwSK55X3Bo1TNCz878XhX
         srjzAiaq3NNVBi+2N0JGWTzFqMOV8QLruGUCOAiIeKJV6SwcldjFyzjw2c9loMktQq
         /Mud0KNZV7Z0N5RgkzknZJmGbBIBTPGy0AWM+Dl5yK0/us8bjKEdMqPshtOUbtHgGS
         yGCkOw1VW8xhA==
Date:   Sat, 18 Jun 2022 14:20:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 0/4] 3rd set of IIO export namespaces.
Message-ID: <20220618142054.4571f2f4@jic23-huawei>
In-Reply-To: <20220604155306.422937-1-jic23@kernel.org>
References: <20220604155306.422937-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  4 Jun 2022 16:53:02 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Changes since v1:
> - Rebase (bit of fuzz in patches 1 and 4)

If anyone has time to take a quick look through this lot and sanity
check I haven't done anything stupid it would be much appreciated.

Disadvantage of being the maintainer is there isn't anyone else you
can moan about when no one reviews your patches. Of course I never
moan about other maintainers and I'm sure no one ever moans
about me :)

>=20
> I sent v1 out in Feb and only got review on one patch (which I've since
> applied - thanks Nuno).
>=20
> Looking for a quick sanity check of these 4 that remain from anyone who
> has the time.  Whilst this is mechanical stuff, I've made enough dumb
> mistakes in such patches over the years that I still like to get a second
> set of eyes on them if at all possible!=20
>=20
> Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
>=20
> Jonathan Cameron (4):
>   iio: imu: bmi160: Move exported symbols to IIO_BMI160 namespace
>   iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace
>   iio: chemical: sps30: Move symbol exports into IIO_SPS30 namespace
>   iio: adc: qcom-vadc: Move symbol exports to IIO_QCOM_VADC namespace
>=20
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
>  drivers/iio/adc/qcom-spmi-adc5.c     |  1 +
>  drivers/iio/adc/qcom-spmi-vadc.c     |  1 +
>  drivers/iio/adc/qcom-vadc-common.c   | 16 ++++++++--------
>  drivers/iio/chemical/sps30.c         |  2 +-
>  drivers/iio/chemical/sps30_i2c.c     |  1 +
>  drivers/iio/chemical/sps30_serial.c  |  1 +
>  drivers/iio/imu/bmi160/bmi160_core.c |  6 +++---
>  drivers/iio/imu/bmi160/bmi160_i2c.c  |  1 +
>  drivers/iio/imu/bmi160/bmi160_spi.c  |  1 +
>  drivers/iio/pressure/bmp280-core.c   |  2 +-
>  drivers/iio/pressure/bmp280-i2c.c    |  1 +
>  drivers/iio/pressure/bmp280-regmap.c |  4 ++--
>  drivers/iio/pressure/bmp280-spi.c    |  1 +
>  14 files changed, 24 insertions(+), 15 deletions(-)
>=20

