Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302205B9D8B
	for <lists+linux-iio@lfdr.de>; Thu, 15 Sep 2022 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIOOlS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Sep 2022 10:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiIOOlA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2022 10:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E4CF7
        for <linux-iio@vger.kernel.org>; Thu, 15 Sep 2022 07:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B79062269
        for <linux-iio@vger.kernel.org>; Thu, 15 Sep 2022 14:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81661C433D6;
        Thu, 15 Sep 2022 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663252716;
        bh=HYLAZC3cEmrK4aWVhGVaCsLrBbMGmkuK0ohk4GjutcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H7jJQUApyMQeltc1GtlL66AwjkdUyMx5VfUd6h9KttmGguyP8MOz8v538lx+Mj17w
         EGQ5dI6uhhvzsch5YmqWVw3HO7QpK7mfrSGM6vRisQQ290ACJhIenQlTI+E+r0+wSq
         tioUlrkoKjqiNq5TVpjEB51PuP2xZdV0RjRVe19CEjWsAHV3hlx1YM9/LCnUvYEyNt
         gnpS8gWtS2STJL8ZhNGDiTItkWuSd4vUcV+NLQ3Xt0kV3bm2tQk1CtiT/WRiIv34QT
         A0Uxrj3tniv/F1Oc0D18zfgfTCIOkk7C3HvGeUfBHyJ7W5k0MxSTPd1jS3ARxdxfum
         3jzhXSTMFnPbg==
Date:   Thu, 15 Sep 2022 15:38:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/2] ad5593r fix read protocol
Message-ID: <20220915153836.7f8ef80e@jic23-huawei>
In-Reply-To: <20220913073413.140475-1-nuno.sa@analog.com>
References: <20220913073413.140475-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Sep 2022 09:34:11 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This patchset fixes the read protocol since it needs a STOP condition
> between address write and data read.
>=20
> The second change is trivial and only adds an i2c functionality check.

Given we are late in the cycle, I've queued this up for the next merge
window, with a stable tag for the first paatch so it'll get backported
after the merge window.

Thanks,

Jonathan


>=20
> Michael Hennerich (1):
>   iio: dac: ad5593r: Fix i2c read protocol requirements
>=20
> Nuno S=C3=A1 (1):
>   iio: dac: ad5593r: add check for i2c functionality
>=20
>  drivers/iio/dac/ad5593r.c | 48 +++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
>=20

