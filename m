Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F674FAF15
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiDJQxw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 12:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiDJQxu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 12:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5A113EB3;
        Sun, 10 Apr 2022 09:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B01261139;
        Sun, 10 Apr 2022 16:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D91C385A1;
        Sun, 10 Apr 2022 16:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649609499;
        bh=czdwW7pfgBR6Ee2W4AiYbqSyE13e93HvLRJsq9W6umw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTsFEIsBuRG3FbCxDhLLQyVqZHTmNeVJitRpOz7hn9ORBlmEuG+ZNMnwNr7Ddzru+
         zv5tdwS444+6Jn/n6LV8HP+ujh4yK19j9Bws5p6LVvLfVwbIMK7xS3ZX+Q+xIKXL2z
         PRSd7r+WhDUG1u5g4yMCvq+RyoKLE+16YpRCh8oRsNF0li1yD7aQs49xiIoWKzVUQo
         SYjHpTrN0PvLanlNKu72nbCsXgc1N1k1aOA1LmGmPdiGYCyaNgijQTtklTI3g5odMq
         C2pDxvyPMFFRUhugHkNg1a18VPEblLZwfEkIHXoraipv8+1f/5fImz+OgGaRbFq06A
         9PeF7UF8ZFPXg==
Date:   Sun, 10 Apr 2022 17:59:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 0/2] ad3552r change maintainer and update MAINTAINERS
Message-ID: <20220410175930.2c80dbc3@jic23-huawei>
In-Reply-To: <20220404085000.249423-1-nuno.sa@analog.com>
References: <20220404085000.249423-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Apr 2022 10:49:58 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> After the bug report in [1], it came to my attention that the maintainer
> for this driver is outdated as Mihail Chindris moved from ADI. As such,
> change the maintainer to myself. On top of this, I then realized there
> was no entry for this driver in MAINTAINERS so add one.
>=20
> [1]: https://lore.kernel.org/all/20220106103553.GA26440@kili/
>=20
> Nuno S=C3=A1 (2):
>   dt-bindings: iio: dac: change ad3552r maintainer
>   MAINTAINERS: add ad3552r
>=20
>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml          | 2 +-
>  MAINTAINERS                                               | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20

Series applied to the togreg branch of iio.git an pushed out as testing
so 0-day can poke other stuff I have on that branch.

Thanks,

Jonathan
