Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6279F1C8
	for <lists+linux-iio@lfdr.de>; Wed, 13 Sep 2023 21:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjIMTOl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Sep 2023 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjIMTOk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Sep 2023 15:14:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17681999
        for <linux-iio@vger.kernel.org>; Wed, 13 Sep 2023 12:14:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63019C433C8;
        Wed, 13 Sep 2023 19:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694632476;
        bh=YZya9epXUQ0v+ZdwiX4HYVy1f07xWRxSsdgU5W62FLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YXIHCNMUR9YtrMod5tP8+3JPdr3aSvBP6F4LwYXn5HH4dKfyC7NmdJlDstZGsH56f
         09IZD2wicdl4tsP922BGSZQYZTXWupcG+DSn/V1ckXzwafhFDAcq3pCJeExu7n6Y74
         Ya9AHWUb/AmZaO2EpUfsrxtuG99/u29k4sYMUzKCWj5NA9vU7pOUV+nR1EMh7t4BBz
         E/cqyUU8WIqH/T29LKPntstd+da8nCj2JQ1CdKVz/b82WRz2F2ADyXpIGGpR1uY0/v
         XUnJU+2Q9vM4wxthStOTnIrLTD0Rf/i0NdAUSsB57ksn5y95ZKvvpuZtswAv7E4/II
         dNJRjWcrFVAUQ==
Date:   Wed, 13 Sep 2023 20:14:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ad4310: Replace devm_clk_register() with
 devm_clk_hw_register()
Message-ID: <20230913201428.23427df7@jic23-huawei>
In-Reply-To: <0556d0fd2a99c2b1e64a76e94907232827b7f9c8.camel@gmail.com>
References: <20230910140903.551081-1-lars@metafoo.de>
        <0556d0fd2a99c2b1e64a76e94907232827b7f9c8.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Sep 2023 11:00:22 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2023-09-10 at 07:09 -0700, Lars-Peter Clausen wrote:
> > The devm_clk_register() is deprecated and devm_clk_hw_register() should=
 be
> > used as a replacement.
> >=20
> > Switching to the clk_hw interface also allows to use the built-in device
> > managed version of registering the clock provider. The non-clk_hw inter=
face
> > does not have a device managed version.
> >=20
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20

Applied with all the normal stuff about first pushing out as testing etc...

Jonathan
