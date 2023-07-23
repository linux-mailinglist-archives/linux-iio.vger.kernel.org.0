Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B280D75E09E
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jul 2023 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGWJMU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jul 2023 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWJMT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2023 05:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B0712D;
        Sun, 23 Jul 2023 02:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CFC160C37;
        Sun, 23 Jul 2023 09:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53267C433C8;
        Sun, 23 Jul 2023 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690103537;
        bh=UgoT0HNi+kZfSC3ql4lb/066tYS2NXzg58w2dAeWlkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DmAthh8/4hBDEEkXt+SbuqDKCehKH4LvWGjm8Y1wiUELiHDl6f1zPE5ZGeO3ggfb5
         Hm0v5oDpFezJ6jnBsKSBypQFo5xoCDts1LilT4SXwBY4iKUeaWcZK3SjSDZUQ+tC6V
         QNA0QnSpm1Gqci2q2mq3SblPifIZ5ykd7smRpkxanyiM3rq/hlf6pSEFXW0lGY8pw9
         kjcl88MTok/JD72qsLkZWiJ+DNNdy5wwUoi9zCDU/pWVQ9iKYBam+Oss+5FzXekQZs
         HMCXDs+cTS3IsHDXe8SX3QPWw1vMozo+LS4q0RKtihNZvDYksEA8d3kjxw3KEfvDEw
         0VglTlnyJioVw==
Date:   Sun, 23 Jul 2023 10:12:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use
 i2c_get_match_data()
Message-ID: <20230723101213.66dbae9e@jic23-huawei>
In-Reply-To: <OS0PR01MB592290B83D0EEA1928DB4D2A863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
        <6e5a099e-57bb-7eb3-212b-494b5c30e4d7@axentia.se>
        <OS0PR01MB592290B83D0EEA1928DB4D2A863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 23 Jul 2023 06:12:20 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi Peter Rosin,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use
> > i2c_get_match_data()
> > 
> > Hi!
> > 
> > 2023-07-21 at 09:16, Biju Das wrote:  
> > > Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> > > _data() by making similar I2C and DT-based matching table.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v1->v2:
> > >  * Added similar similar I2C and DT-based matching table.
> > >  * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
> > >  * Dropped error check as all tables have data pointers.
> > >
> > > Note:
> > >  This patch is only compile tested.
> > > ---
> > >  drivers/iio/potentiometer/mcp4018.c | 34
> > > +++++++++++++++--------------
> > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/iio/potentiometer/mcp4018.c
> > > b/drivers/iio/potentiometer/mcp4018.c
> > > index 89daecc90305..b064e86ecce8 100644
> > > --- a/drivers/iio/potentiometer/mcp4018.c
> > > +++ b/drivers/iio/potentiometer/mcp4018.c
> > > @@ -99,20 +99,24 @@ static const struct iio_info mcp4018_info = {
> > >  	.write_raw = mcp4018_write_raw,
> > >  };
> > >
> > > +#define MCP4018_ID_TABLE(name, cfg) {				\
> > > +	name, .driver_data = (kernel_ulong_t)&mcp4018_cfg[cfg],	\
> > > +}  
> > 
> > It is inconsistent to have a named field for .driver_data but not for
> > .name. Also, I dislike the cast and wonder if the trivial simplification
> > in probe() is really worth this churn when that ugly cast is needed?   
> 
> It saving lines of code and better than, &mcp4018_cfg[i2c_match_id(mcp4018_id, client)>driver_data]; right??
> 
> 
> >The
> > reason the two tables differ and do not both have pointers already is
> > precisely my dislike for that cast.  
> 
> > 
> > Anyway, something like this instead? Or _name instead of id?
> > Whatever...  
> 
> OK, will use _name.
I dropped previous version of this and the other patch (as comment applies
there as well) from the togreg branch of iio.git



> 
> > 
> > #define MCP4018_ID_TABLE(id, cfg) {				\
> > 	.name = id,						\
> > 	.driver_data = (kernel_ulong_t)&mcp4018_cfg[cfg],	\
> > }
> >   
> > > +
> > >  static const struct i2c_device_id mcp4018_id[] = {
> > > -	{ "mcp4017-502", MCP4018_502 },
> > > -	{ "mcp4017-103", MCP4018_103 },
> > > -	{ "mcp4017-503", MCP4018_503 },
> > > -	{ "mcp4017-104", MCP4018_104 },
> > > -	{ "mcp4018-502", MCP4018_502 },
> > > -	{ "mcp4018-103", MCP4018_103 },
> > > -	{ "mcp4018-503", MCP4018_503 },
> > > -	{ "mcp4018-104", MCP4018_104 },
> > > -	{ "mcp4019-502", MCP4018_502 },
> > > -	{ "mcp4019-103", MCP4018_103 },
> > > -	{ "mcp4019-503", MCP4018_503 },
> > > -	{ "mcp4019-104", MCP4018_104 },
> > > -	{}
> > > +	MCP4018_ID_TABLE("mcp4017-502", MCP4018_502),
> > > +	MCP4018_ID_TABLE("mcp4017-103", MCP4018_103),
> > > +	MCP4018_ID_TABLE("mcp4017-503", MCP4018_503),
> > > +	MCP4018_ID_TABLE("mcp4017-104", MCP4018_104),
> > > +	MCP4018_ID_TABLE("mcp4018-502", MCP4018_502),
> > > +	MCP4018_ID_TABLE("mcp4018-103", MCP4018_103),
> > > +	MCP4018_ID_TABLE("mcp4018-503", MCP4018_503),
> > > +	MCP4018_ID_TABLE("mcp4018-104", MCP4018_104),
> > > +	MCP4018_ID_TABLE("mcp4019-502", MCP4018_502),
> > > +	MCP4018_ID_TABLE("mcp4019-103", MCP4018_103),
> > > +	MCP4018_ID_TABLE("mcp4019-503", MCP4018_503),
> > > +	MCP4018_ID_TABLE("mcp4019-104", MCP4018_104),
> > > +	{ /* sentinel */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, mcp4018_id);
> > >
> > > @@ -157,9 +161,7 @@ static int mcp4018_probe(struct i2c_client  
> > *client)  
> > >  	i2c_set_clientdata(client, indio_dev);
> > >  	data->client = client;
> > >
> > > -	data->cfg = device_get_match_data(dev);
> > > -	if (!data->cfg)
> > > -		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)-
> > >driver_data];
> > > +	data->cfg = i2c_get_match_data(client);  
> > 
> > NULL-check here? I know the original i2c_match_id call is not checked
> > for non-matches, but that feels like a simpler function than
> > i2c_get_match_data. And less prone to changes.
> > 
> > Same comments of course applies to the mcp4531 patch as well.  
> 
> Some subsystem people doesn't want error check as all tables have data pointers. See [1]
> 
> [1] https://lore.kernel.org/linux-renesas-soc/20230717145623.473cffca@booty/
> 
> I am leaving subsystem maintainer to take final word on this.

I'm fine either way. It seems unlikely any changes to that function will introduce
a path for a NULL return if there isn't one there today, but you never know I guess.
However we don't normally spend too much effort protecting against potential
future new return values.

> 
> The new API is very simple [2]
> [2] https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/i2c/i2c-core-base.c#L124
> 
> Cheers,
> Biju
> 
> > >
> > >  	indio_dev->info = &mcp4018_info;
> > >  	indio_dev->channels = &mcp4018_channel;  

