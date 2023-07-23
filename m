Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A625C75E0A1
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jul 2023 11:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGWJMv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jul 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWJMv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2023 05:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DAFB1;
        Sun, 23 Jul 2023 02:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C08660C1F;
        Sun, 23 Jul 2023 09:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CCEC433C9;
        Sun, 23 Jul 2023 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690103569;
        bh=fxQ7hYVlRmNMdyWc3BmTpTiycrR9DU8+HR2sikk1ihM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LqCe85uOxAKVzu7FBWDX9Cvk6Ub9P8kdfNEWG8Kxqr7TN7fqmo7Kjh5QBVtJRs0fO
         baZX7/WdXijTKh9hzfvXke2VVczaA3iEQnI2omtL2DnkKX5L3aSV6YvK9pcthBz2Vk
         iaehf/PoMqPpXLYG6BB13PO/rlMweKQVJKEzVjwIMQEg69QlSZk9AWN1M7IV0IL/Uz
         Bjh4gkAnIyRyL8WfF4OlqJ02QXn4pAExVhaAd6OOHqjKDriVD74DUMETjKYrlAuVHe
         NSbfN1roy7DjVZGtuMQVVIbi9fdCW1/u9AGczkwQOoyJ9ho1yxUKCZ0NsMSs2KafDg
         teyFCRN5zZW5w==
Date:   Sun, 23 Jul 2023 10:12:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] iio: potentiometer: mcp4531: Use
 i2c_get_match_data()
Message-ID: <20230723101246.61a88724@jic23-huawei>
In-Reply-To: <20230722182350.5e671c45@jic23-huawei>
References: <20230721080153.179274-1-biju.das.jz@bp.renesas.com>
        <20230722182350.5e671c45@jic23-huawei>
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

On Sat, 22 Jul 2023 18:23:50 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 21 Jul 2023 09:01:53 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> 
> > Replace device_get_match_data() and i2c_match_id() by i2c_get_match
> > _data() by making similar I2C and DT-based matching table.
> > 
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Added similar similar I2C and DT-based matching table.
> >  * Dropped error check as all tables have data pointers.
> > 
> > Note:
> >  This patch is only compile tested.  
> 
> LGTM.
> 
> Applied to the togreg branch of iio.git and pushed out as testing to see
> if 0-day can find anything we missed.
> 
Dropped given comment on .name = 
in the other patch applies here as well.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/potentiometer/mcp4531.c | 138 ++++++++++++++--------------
> >  1 file changed, 70 insertions(+), 68 deletions(-)
> > 
> > diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> > index c513c00c8243..6b251b7acb60 100644
> > --- a/drivers/iio/potentiometer/mcp4531.c
> > +++ b/drivers/iio/potentiometer/mcp4531.c
> > @@ -206,72 +206,76 @@ static const struct iio_info mcp4531_info = {
> >  	.write_raw = mcp4531_write_raw,
> >  };
> >  
> > +#define MCP4531_ID_TABLE(name, cfg) {				\
> > +	name, .driver_data = (kernel_ulong_t)&mcp4531_cfg[cfg],	\
> > +}
> > +
> >  static const struct i2c_device_id mcp4531_id[] = {
> > -	{ "mcp4531-502", MCP453x_502 },
> > -	{ "mcp4531-103", MCP453x_103 },
> > -	{ "mcp4531-503", MCP453x_503 },
> > -	{ "mcp4531-104", MCP453x_104 },
> > -	{ "mcp4532-502", MCP453x_502 },
> > -	{ "mcp4532-103", MCP453x_103 },
> > -	{ "mcp4532-503", MCP453x_503 },
> > -	{ "mcp4532-104", MCP453x_104 },
> > -	{ "mcp4541-502", MCP454x_502 },
> > -	{ "mcp4541-103", MCP454x_103 },
> > -	{ "mcp4541-503", MCP454x_503 },
> > -	{ "mcp4541-104", MCP454x_104 },
> > -	{ "mcp4542-502", MCP454x_502 },
> > -	{ "mcp4542-103", MCP454x_103 },
> > -	{ "mcp4542-503", MCP454x_503 },
> > -	{ "mcp4542-104", MCP454x_104 },
> > -	{ "mcp4551-502", MCP455x_502 },
> > -	{ "mcp4551-103", MCP455x_103 },
> > -	{ "mcp4551-503", MCP455x_503 },
> > -	{ "mcp4551-104", MCP455x_104 },
> > -	{ "mcp4552-502", MCP455x_502 },
> > -	{ "mcp4552-103", MCP455x_103 },
> > -	{ "mcp4552-503", MCP455x_503 },
> > -	{ "mcp4552-104", MCP455x_104 },
> > -	{ "mcp4561-502", MCP456x_502 },
> > -	{ "mcp4561-103", MCP456x_103 },
> > -	{ "mcp4561-503", MCP456x_503 },
> > -	{ "mcp4561-104", MCP456x_104 },
> > -	{ "mcp4562-502", MCP456x_502 },
> > -	{ "mcp4562-103", MCP456x_103 },
> > -	{ "mcp4562-503", MCP456x_503 },
> > -	{ "mcp4562-104", MCP456x_104 },
> > -	{ "mcp4631-502", MCP463x_502 },
> > -	{ "mcp4631-103", MCP463x_103 },
> > -	{ "mcp4631-503", MCP463x_503 },
> > -	{ "mcp4631-104", MCP463x_104 },
> > -	{ "mcp4632-502", MCP463x_502 },
> > -	{ "mcp4632-103", MCP463x_103 },
> > -	{ "mcp4632-503", MCP463x_503 },
> > -	{ "mcp4632-104", MCP463x_104 },
> > -	{ "mcp4641-502", MCP464x_502 },
> > -	{ "mcp4641-103", MCP464x_103 },
> > -	{ "mcp4641-503", MCP464x_503 },
> > -	{ "mcp4641-104", MCP464x_104 },
> > -	{ "mcp4642-502", MCP464x_502 },
> > -	{ "mcp4642-103", MCP464x_103 },
> > -	{ "mcp4642-503", MCP464x_503 },
> > -	{ "mcp4642-104", MCP464x_104 },
> > -	{ "mcp4651-502", MCP465x_502 },
> > -	{ "mcp4651-103", MCP465x_103 },
> > -	{ "mcp4651-503", MCP465x_503 },
> > -	{ "mcp4651-104", MCP465x_104 },
> > -	{ "mcp4652-502", MCP465x_502 },
> > -	{ "mcp4652-103", MCP465x_103 },
> > -	{ "mcp4652-503", MCP465x_503 },
> > -	{ "mcp4652-104", MCP465x_104 },
> > -	{ "mcp4661-502", MCP466x_502 },
> > -	{ "mcp4661-103", MCP466x_103 },
> > -	{ "mcp4661-503", MCP466x_503 },
> > -	{ "mcp4661-104", MCP466x_104 },
> > -	{ "mcp4662-502", MCP466x_502 },
> > -	{ "mcp4662-103", MCP466x_103 },
> > -	{ "mcp4662-503", MCP466x_503 },
> > -	{ "mcp4662-104", MCP466x_104 },
> > -	{}
> > +	MCP4531_ID_TABLE("mcp4531-502", MCP453x_502),
> > +	MCP4531_ID_TABLE("mcp4531-103", MCP453x_103),
> > +	MCP4531_ID_TABLE("mcp4531-503", MCP453x_503),
> > +	MCP4531_ID_TABLE("mcp4531-104", MCP453x_104),
> > +	MCP4531_ID_TABLE("mcp4532-502", MCP453x_502),
> > +	MCP4531_ID_TABLE("mcp4532-103", MCP453x_103),
> > +	MCP4531_ID_TABLE("mcp4532-503", MCP453x_503),
> > +	MCP4531_ID_TABLE("mcp4532-104", MCP453x_104),
> > +	MCP4531_ID_TABLE("mcp4541-502", MCP454x_502),
> > +	MCP4531_ID_TABLE("mcp4541-103", MCP454x_103),
> > +	MCP4531_ID_TABLE("mcp4541-503", MCP454x_503),
> > +	MCP4531_ID_TABLE("mcp4541-104", MCP454x_104),
> > +	MCP4531_ID_TABLE("mcp4542-502", MCP454x_502),
> > +	MCP4531_ID_TABLE("mcp4542-103", MCP454x_103),
> > +	MCP4531_ID_TABLE("mcp4542-503", MCP454x_503),
> > +	MCP4531_ID_TABLE("mcp4542-104", MCP454x_104),
> > +	MCP4531_ID_TABLE("mcp4551-502", MCP455x_502),
> > +	MCP4531_ID_TABLE("mcp4551-103", MCP455x_103),
> > +	MCP4531_ID_TABLE("mcp4551-503", MCP455x_503),
> > +	MCP4531_ID_TABLE("mcp4551-104", MCP455x_104),
> > +	MCP4531_ID_TABLE("mcp4552-502", MCP455x_502),
> > +	MCP4531_ID_TABLE("mcp4552-103", MCP455x_103),
> > +	MCP4531_ID_TABLE("mcp4552-503", MCP455x_503),
> > +	MCP4531_ID_TABLE("mcp4552-104", MCP455x_104),
> > +	MCP4531_ID_TABLE("mcp4561-502", MCP456x_502),
> > +	MCP4531_ID_TABLE("mcp4561-103", MCP456x_103),
> > +	MCP4531_ID_TABLE("mcp4561-503", MCP456x_503),
> > +	MCP4531_ID_TABLE("mcp4561-104", MCP456x_104),
> > +	MCP4531_ID_TABLE("mcp4562-502", MCP456x_502),
> > +	MCP4531_ID_TABLE("mcp4562-103", MCP456x_103),
> > +	MCP4531_ID_TABLE("mcp4562-503", MCP456x_503),
> > +	MCP4531_ID_TABLE("mcp4562-104", MCP456x_104),
> > +	MCP4531_ID_TABLE("mcp4631-502", MCP463x_502),
> > +	MCP4531_ID_TABLE("mcp4631-103", MCP463x_103),
> > +	MCP4531_ID_TABLE("mcp4631-503", MCP463x_503),
> > +	MCP4531_ID_TABLE("mcp4631-104", MCP463x_104),
> > +	MCP4531_ID_TABLE("mcp4632-502", MCP463x_502),
> > +	MCP4531_ID_TABLE("mcp4632-103", MCP463x_103),
> > +	MCP4531_ID_TABLE("mcp4632-503", MCP463x_503),
> > +	MCP4531_ID_TABLE("mcp4632-104", MCP463x_104),
> > +	MCP4531_ID_TABLE("mcp4641-502", MCP464x_502),
> > +	MCP4531_ID_TABLE("mcp4641-103", MCP464x_103),
> > +	MCP4531_ID_TABLE("mcp4641-503", MCP464x_503),
> > +	MCP4531_ID_TABLE("mcp4641-104", MCP464x_104),
> > +	MCP4531_ID_TABLE("mcp4642-502", MCP464x_502),
> > +	MCP4531_ID_TABLE("mcp4642-103", MCP464x_103),
> > +	MCP4531_ID_TABLE("mcp4642-503", MCP464x_503),
> > +	MCP4531_ID_TABLE("mcp4642-104", MCP464x_104),
> > +	MCP4531_ID_TABLE("mcp4651-502", MCP465x_502),
> > +	MCP4531_ID_TABLE("mcp4651-103", MCP465x_103),
> > +	MCP4531_ID_TABLE("mcp4651-503", MCP465x_503),
> > +	MCP4531_ID_TABLE("mcp4651-104", MCP465x_104),
> > +	MCP4531_ID_TABLE("mcp4652-502", MCP465x_502),
> > +	MCP4531_ID_TABLE("mcp4652-103", MCP465x_103),
> > +	MCP4531_ID_TABLE("mcp4652-503", MCP465x_503),
> > +	MCP4531_ID_TABLE("mcp4652-104", MCP465x_104),
> > +	MCP4531_ID_TABLE("mcp4661-502", MCP466x_502),
> > +	MCP4531_ID_TABLE("mcp4661-103", MCP466x_103),
> > +	MCP4531_ID_TABLE("mcp4661-503", MCP466x_503),
> > +	MCP4531_ID_TABLE("mcp4661-104", MCP466x_104),
> > +	MCP4531_ID_TABLE("mcp4662-502", MCP466x_502),
> > +	MCP4531_ID_TABLE("mcp4662-103", MCP466x_103),
> > +	MCP4531_ID_TABLE("mcp4662-503", MCP466x_503),
> > +	MCP4531_ID_TABLE("mcp4662-104", MCP466x_104),
> > +	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, mcp4531_id);
> >  
> > @@ -368,9 +372,7 @@ static int mcp4531_probe(struct i2c_client *client)
> >  	i2c_set_clientdata(client, indio_dev);
> >  	data->client = client;
> >  
> > -	data->cfg = device_get_match_data(dev);
> > -	if (!data->cfg)
> > -		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
> > +	data->cfg = i2c_get_match_data(client);
> >  
> >  	indio_dev->info = &mcp4531_info;
> >  	indio_dev->channels = mcp4531_channels;  
> 

