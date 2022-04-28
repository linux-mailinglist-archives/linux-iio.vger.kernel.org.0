Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC4513C2A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Apr 2022 21:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiD1Tkm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Apr 2022 15:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351454AbiD1Tkl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2022 15:40:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11BFAC93D
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 12:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 824E6B82F9E
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 19:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF3BC385A0;
        Thu, 28 Apr 2022 19:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651174643;
        bh=igRmVEiBraxE3aq3Sa0eE+GptGraV5NJ/ZOM6sTukI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ImwYrwVvkZ94Zlz9EGd+JaZQJ2SkEQCc6TD0rBY7q9ENSPXsa04W9T+QXAKEIIp4v
         BqKYk1SLyFHB2xJBpEB7QyD4gJBLFZ7iZrHxBAjXMIpWiEtMHM8iDXjHXbd65TiOkf
         7dM8PiE5vXXwfmkFBlgWs7KTXIybHqgd+TT2eOnQpI7VoY/mr4YeKivC94+PvXt6AA
         8Qibwu3i/HHzoU+Lc96SYkJk1waO/tNq5CIeQpeatfLnyAR+cd3sCtTZnk2owrqTDR
         wQ0+GfusBXqyjo34ITzN+N0x0bUXPocLJxIj6EQlv5WcuJg3zFOOR7MzOK+I5QreCj
         hqmGSdXNBfDRw==
Date:   Thu, 28 Apr 2022 20:45:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] iio: gyro: mpu3050: Make mpu3050_common_remove() return
 void
Message-ID: <20220428204535.21a5a506@jic23-huawei>
In-Reply-To: <CACRpkdZJ0ay5rTt5kqeh8UrKEOjJCDOuHvJaauVshcTOni6ijw@mail.gmail.com>
References: <20220425191735.59032-1-u.kleine-koenig@pengutronix.de>
        <CACRpkdZJ0ay5rTt5kqeh8UrKEOjJCDOuHvJaauVshcTOni6ijw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Apr 2022 22:11:01 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Apr 25, 2022 at 9:17 PM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > This function (up to now) returns zero unconditionally, so there isn't
> > any benefit of returning a value. Make it return void to be able to see
> > at a glance that the return value of mpu3050_i2c_remove is always zero.
> >
> > This patch is a preparation for making i2c remove callbacks return void.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =
=20
>=20
> Makes sense.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Yours,
> Linus Walleij

Applied. Thanks,

Jonathan
