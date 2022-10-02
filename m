Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F2D5F230A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 14:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJBMUl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJBMUk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 08:20:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96C1C12D;
        Sun,  2 Oct 2022 05:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C89760EAA;
        Sun,  2 Oct 2022 12:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D22C433C1;
        Sun,  2 Oct 2022 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664713238;
        bh=fhWqrDjJnZcxrV0/bumyzoTKxFfcdByj9ZkQrhL4KKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nfooSx8JVW9ir/raXrESI24CV959vfVbMWcr/lUAys7wnIZ7CNafnfVza6PW6GVxy
         JPWLB9QhMD94z9k14tKO23LjqvGdFWbFx6rFf91WKAGgmPWotkud2ljMayhfEdu6c0
         752ifXBpPiF101DoDG6j+bFq5q4Cp7sEIuDdsBRR6RRUDsI1lns6zwUsrrepFnoIno
         uulIp+4lUfn+NrUC6zKHIGdnjXMHRylmBxKBAbtGLqSxTjoobVzas5x5Ilvw2j2KQE
         803ykGwyj/WqduNzTdvQJVGknHD0ImUeLt2UO8oZ79PjPY3U9dBmt/oQ0FjP2hb8Cq
         L/V9IBb4VGKew==
Date:   Sun, 2 Oct 2022 13:20:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3911: fix sizeof() vs ARRAY_SIZE() bug
Message-ID: <20221002132053.113f595f@jic23-huawei>
In-Reply-To: <YzGKolEWAZ0Z/fQf@gmail.com>
References: <YzFsjY3xLHUQMjVr@kili>
        <YzGKolEWAZ0Z/fQf@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Sep 2022 13:18:58 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Hi,
> 
> Good catch.
> Too bad I missed it.
> 
> /Marcus
> 
> On Mon, Sep 26, 2022 at 12:10:37PM +0300, Dan Carpenter wrote:
> > This code uses sizeof() instead of ARRAY_SIZE() so it reads beyond the
> > end of the mcp3911_osr_table[] array.
> > 
> > Fixes: 6d965885f4ea ("iio: adc: mcp3911: add support for oversampling ratio")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>  
> 
> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied to the fixes-togreg branch of iio.git, but I'm not going to push that
tree out until Linus takes the char-misc-next pull request as otherwise I'll make
a mess of linux-next as the trees will effectively merge out of normal order.

Jonathan

> 
> > ---
> >  drivers/iio/adc/mcp3911.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > index b35fd2c9c3c0..015a9ffdb26a 100644
> > --- a/drivers/iio/adc/mcp3911.c
> > +++ b/drivers/iio/adc/mcp3911.c
> > @@ -248,7 +248,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
> >  		break;
> >  
> >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > -		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
> > +		for (int i = 0; i < ARRAY_SIZE(mcp3911_osr_table); i++) {
> >  			if (val == mcp3911_osr_table[i]) {
> >  				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
> >  				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
> > -- 
> > 2.35.1
> >   

