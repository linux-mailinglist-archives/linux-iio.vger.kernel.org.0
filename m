Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6D591BBB
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbiHMPvL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbiHMPvK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 11:51:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62385F96
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 08:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFAC7B80860
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 15:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A186C433C1;
        Sat, 13 Aug 2022 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660405865;
        bh=ly0j3vekBB5v8YYLvUgkRNBz1xbrRZEMXesBSTaVWdk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mzen7ahm+iuh4LBmy7zjCtGo6J4CLk5wqis5z9ewg5eyxNhrXHed5R91jOej8sJuW
         wLuJtOCK1V2Svq5bDQyFgTm3Y9UIgIHfQkUr9ZWuPdoWNhHGu1D2qAk6ycm3OTYZDL
         /N89I6DUaX0O+Zkh9fCnYBsy9Bslywx4bUd3pmXlaeG+g899OMoALVEnqjoQNsrebX
         bolVZ2S31IPdbmaATSA2KIkIKo66w0sUCGk9DTXGvTgX0L2BdiakATQCIv+AFh2b8u
         OrC0uMtjMf6/P0V5rwf7H2JrR+A57WpNwXwYN3g2jaACzWJ5bezkJJLA5kGyU7Q2Dd
         UaTgAI+rX5NBA==
Date:   Sat, 13 Aug 2022 17:01:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/4] staging: iio: DMA alignment fixes.
Message-ID: <20220813170134.77e08da6@jic23-huawei>
In-Reply-To: <CAHp75VejHmUx_PkoKfijcmVdZWdEvXtKwVWTTPy9uadB559FcA@mail.gmail.com>
References: <20220807151218.656881-1-jic23@kernel.org>
        <CAHp75VejHmUx_PkoKfijcmVdZWdEvXtKwVWTTPy9uadB559FcA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Aug 2022 11:20:32 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Aug 7, 2022 at 5:37 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > When I introduced IIO_DMA_MINALIGN and applied it to all the drivers
> > in drivers/iio I said I'd swing by the few remaining staging drivers
> > at a later date. This set fixes those staging/iio drivers.
> >
> > Note that no one has been very active on these drivers for some time.
> > They do however support parts that are still available (and I have
> > at least one of them) so I think it's worth keeping them around for now.
> > Perhaps the necessary cleanup work can be done against emulation or
> > road test or we can get parts for anyone interested in doing the necessary
> > work.
> >
> > Anyhow, upshot is that it's unlikely anyone will feel ownership of these
> > drivers enough to review this series so if anyone has time a quick
> > glance over it would be much appreciated!  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> for non-commented patches.
> 
Thanks, patches 2-4 applied. v2 of patch one to be posted shortly.

Jonathan


