Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE73675B7C6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 21:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGTTRR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 15:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGTTRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 15:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E022128;
        Thu, 20 Jul 2023 12:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9EB661C12;
        Thu, 20 Jul 2023 19:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF68C433CC;
        Thu, 20 Jul 2023 19:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689880628;
        bh=tCNh0v0IoK+dh/W2p9QHlGg5owGUajIFF72fFRnwqeQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CQhdhkPruaa8A5qhHvU+yOzS5yglZeiIMhsyZBn2s4pLHz6LcELOxxxjp0k45Ja+E
         3tfBhMgcwCS7QVJlJBL7Z+X5cI2IladTtGBO6Dc9Sa2BJxhiRJs8WEdvZj9GXITKcw
         1wS7umld+A9MzuSSAsKNBUUMEpISIKrkBDqamhPRBE+/FdcaBYLTkW93/cYKtdo0ea
         UlQAMGIstTW5A14BYgompyQlqLj9i7CAmUEeXOTrqvE4IAEgc0OVBwXq68d/WL66hl
         n2FugmyzfPH8NxlJ8gWLrS87Ijen/y9R0RLlf7C5y2I440yH8W3agSZ5dCGiqBDtac
         O+35ri73h1obw==
Date:   Thu, 20 Jul 2023 20:17:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: potentiometer: mcp4018: Use i2c_get_match_data
Message-ID: <20230720201701.0fb3a948@jic23-huawei>
In-Reply-To: <OS0PR01MB592223598B7DECC648947436863AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
        <20230716175218.130557-5-biju.das.jz@bp.renesas.com>
        <OS0PR01MB592223598B7DECC648947436863AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 Jul 2023 18:10:13 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi All,
> 
> I would like to drop this patch, as this driver does not have similar
> I2C and DT-based matching table.

Could make it so they do ;)

Jonathan

> 
> Cheers,
> Biju
> 
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Sunday, July 16, 2023 6:52 PM
> > To: Peter Rosin <peda@axentia.se>; Jonathan Cameron <jic23@kernel.org>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lars-Peter Clausen
> > <lars@metafoo.de>; linux-iio@vger.kernel.org; Geert Uytterhoeven
> > <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-  
> > lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org  
> > Subject: [PATCH 4/4] iio: potentiometer: mcp4018: Use i2c_get_match_data
> > 
> > Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> > _data() as we have similar I2C and DT-based matching table.
> > 
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/iio/potentiometer/mcp4018.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/potentiometer/mcp4018.c
> > b/drivers/iio/potentiometer/mcp4018.c
> > index 89daecc90305..a5d902845a1c 100644
> > --- a/drivers/iio/potentiometer/mcp4018.c
> > +++ b/drivers/iio/potentiometer/mcp4018.c
> > @@ -157,9 +157,9 @@ static int mcp4018_probe(struct i2c_client *client)
> >  	i2c_set_clientdata(client, indio_dev);
> >  	data->client = client;
> > 
> > -	data->cfg = device_get_match_data(dev);
> > +	data->cfg = i2c_get_match_data(dev);
> >  	if (!data->cfg)
> > -		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)-  
> > >driver_data];  
> > +		return -ENODEV;
> > 
> >  	indio_dev->info = &mcp4018_info;
> >  	indio_dev->channels = &mcp4018_channel;
> > --
> > 2.25.1  
> 

