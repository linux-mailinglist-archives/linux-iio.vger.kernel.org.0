Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D4368B051
	for <lists+linux-iio@lfdr.de>; Sun,  5 Feb 2023 15:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBEOm1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Feb 2023 09:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBEOm0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 09:42:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A031C31B
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 06:42:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C99AB80B22
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 14:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29955C433EF;
        Sun,  5 Feb 2023 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675608142;
        bh=e3UcuKEkhhkvDaY4UQ1PB/Da3PyANfOZjcEcuYjekhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qlv2TJ7YPQrjZbSctWmy4eohrq8k2jcJAweZ9xbN1wYXDR9XV+JKjuywSdTqQo18q
         2aBTFcvTVhFeTijw05yE8pLDmmHuwkNw8XgGaIV/PU51t3wFOZEc9q0v3m5IqGd/oL
         xUG5BdWfcu8eXxi01koSp1NpmbO9ADYE6/p0TUTHxfGKEHxWhSjZMjs6qAQ0zvKxkI
         kVPidlfr7r/6pRhMYGCc1zUflKfc3skdmuf/3vUYpE1JasWdjhw3XTyKoDPUqNB/qZ
         p0IRF5dXiCmgnQ19EfgdF08hbjmWwYRrPPmfCFGvYhQHvcjQSHlBSHwDijPZeD0DYz
         N53TNgvN/uAkw==
Date:   Sun, 5 Feb 2023 14:56:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: kionix-kx022a: Remove the unused member
 g_range
Message-ID: <20230205145624.03785425@jic23-huawei>
In-Reply-To: <7b2be002-aef7-f7b2-0e7e-9666d4179a52@gmail.com>
References: <cover.1674996464.git.mehdi.djait.k@gmail.com>
        <e884d53fed0d8322d8be1de2593d4f5f8975af9c.1674996464.git.mehdi.djait.k@gmail.com>
        <7b2be002-aef7-f7b2-0e7e-9666d4179a52@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Jan 2023 10:17:00 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 1/29/23 15:37, Mehdi Djait wrote:
> > The g_range member of the driver data struct is not used and
> > should therefore be removed  
> 
> Well spotted, thanks.
> 
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>  
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied
> 
> > ---
> >   drivers/iio/accel/kionix-kx022a.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> > index 1d3af42ec0e1..bb43cb0acce4 100644
> > --- a/drivers/iio/accel/kionix-kx022a.c
> > +++ b/drivers/iio/accel/kionix-kx022a.c
> > @@ -162,7 +162,6 @@ struct kx022a_data {
> >   	int inc_reg;
> >   	int ien_reg;
> >   
> > -	unsigned int g_range;
> >   	unsigned int state;
> >   	unsigned int odr_ns;
> >     
> 

