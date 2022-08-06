Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3758B628
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiHFOgk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiHFOgj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 10:36:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED86DFBE
        for <linux-iio@vger.kernel.org>; Sat,  6 Aug 2022 07:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A212B8047E
        for <linux-iio@vger.kernel.org>; Sat,  6 Aug 2022 14:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6C7C433D7;
        Sat,  6 Aug 2022 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659796596;
        bh=IWSLPKEzLKcrcy/6Bda/9b8hMkNn3lWk1rxVlRzzCZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lP/eo639FxXNySo2DmuD1tO7sGb5uhBOfFeuzB/k7AJ0XE5y8nx53NDzNc5+fF6mU
         hn1+6uOPd3ZbLhRwJk7mT6tBBto/5S6QJv+wIXPHnptfYbaeUfr9gQYLeVprIo92fY
         v+uQn4p7WYaEcPchuoHxyU8T+ik/KZ7wEtPK0BzJ17JuMgBW4gAvNPim1BBto7UY0y
         vpNO5Oo5cJuiVVzQsM6bylXcG1jLnSanZ5Z125h/vrqqaz8PxB0FyGEwWUTPaW2+nc
         YkECBGQYumD0sp+q/Pm/M4PtsgrmHBf2/fG7tJPrxxHUo2VSA9Ske9WWLzne/D0J4z
         219xz8romL1yQ==
Date:   Sat, 6 Aug 2022 15:46:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: add NULL pointer checks to iio device
 additional/removal
Message-ID: <20220806154656.4aa6ad9f@jic23-huawei>
In-Reply-To: <CAHp75VegV4YiY5WZ8SXmK9DCS1msKpmAykgYTskkHi+Zfx-U_g@mail.gmail.com>
References: <20220803115720.89848-1-matt.ranostay@konsulko.com>
        <CAHp75VeBSxHK_Nf+PSvRtACeszGeomUyK8Cx1V1FpFiSS013Cw@mail.gmail.com>
        <CAHp75VegV4YiY5WZ8SXmK9DCS1msKpmAykgYTskkHi+Zfx-U_g@mail.gmail.com>
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

On Wed, 3 Aug 2022 20:00:24 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 3, 2022 at 7:57 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Aug 3, 2022 at 2:04 PM Matt Ranostay <matt.ranostay@konsulko.com> wrote:  
> > >
> > > Check if __iio_device_register and iio_device_unregister indio_dev
> > > parameter isn't a NULL pointer.  
> 
> A couple more things:
> - make sure you include all maintainers and reviewers (you may use my
> "smart" script [1] for that)
> - explain why you are doing this change
> 

Agreed. I'm not sure of the reasoning for doing this.
I'd also expect to see it as part of a series where we might pass NULL to these
functions.

Thanks,

Jonathan


> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
> 

