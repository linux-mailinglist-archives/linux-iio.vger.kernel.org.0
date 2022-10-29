Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5268612243
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ2LNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2LNr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:13:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC3AB9D
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A9ACB80B4D
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BF4C433D6;
        Sat, 29 Oct 2022 11:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667042024;
        bh=pkwSQHB+iCK+pE4qR4St8p/ohputNflVEFRl6sfN7Xw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KzcW0bzBsV2nph7G2dpwJnHBvDQNQvD/psX/+GP3DGoFjLjvzlD27QcpM/+YinuIY
         rfxQsb+o6DeoODNcY6NxBg+bw5MaF95+usa6TDqUhsYIZnzT+jHVH5EtryvOoqo3xL
         HDqO14ujBzzIjTAvrzKsLPq/HJd/IvlZMX8NM3T8CbSa1OciqmqSWexxcpgjf1iokm
         Ts16CkhrkJ9+02snNuf7IfzSxPtMl0CT/T83dpmwsIqgS5ze0lQu9B48eiw3E1rXjz
         3v2LOYD2eHaUbzkbb+JiJqih2chsbgme5qpfzntdiEafau7Z/maKhTGLVQ9qu69u2q
         QwGTKd8M5zpPA==
Date:   Sat, 29 Oct 2022 12:25:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: accel: bma400: Ensure VDDIO is enable defore
 reading the chip ID.
Message-ID: <20221029122540.5c31d6c3@jic23-huawei>
In-Reply-To: <Y1vUI9ppqVkoEuuv@dlrobertson.com>
References: <20221002144133.3771029-1-jic23@kernel.org>
        <Y1vUI9ppqVkoEuuv@dlrobertson.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Oct 2022 13:07:47 +0000
Dan Robertson <dan@dlrobertson.com> wrote:

> On Sun, Oct 02, 2022 at 03:41:33PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The regulator enables were after the check on the chip variant, which was
> > very unlikely to return a correct value when not powered.
> > Presumably all the device anyone is testing on have a regulator that
> > is already powered up when this code runs for reasons beyond the scope
> > of this driver. Move the read call down a few lines.
> > 
> > Fixes: 3cf7ded15e40 ("iio: accel: bma400: basic regulator support")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Dan Robertson <dan@dlrobertson.com>
> 
> Thanks for catching this!

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> Cheers,
> 
>  - Dan

