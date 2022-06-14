Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EB954AEC4
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiFNKtl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355788AbiFNKtR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 06:49:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC1549253;
        Tue, 14 Jun 2022 03:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E926121B;
        Tue, 14 Jun 2022 10:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A14BC3411B;
        Tue, 14 Jun 2022 10:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655203755;
        bh=roWnZoctTuO7EfRC+YTK7DM+q3/Q15Ivpx5/o2MsL/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lgKkXvQ7vFPgU7uuUI/p6W6E3A4F2Es47erkQFgDJCGTZYZ59LM3yJUm2Rqez8U9C
         cTuk8Pj7LghPfcwUX7FWRLbCUo9RuBfGIE1nkxkHduH7mwnnnDFnV3ZwxNK5+33iLW
         R5Rq6fdZvJ9oASjg7kBgEqRZLcr3LL4QLOSW6fiSWlxW7I4UpmzqFXWiKn5lJHVPyp
         RodDEmWCY1xDNdMDSZ3NINa4oPt3cwF7jfyVN30D+e0yEdqWI34lD2odnGbI2LPWjx
         +9Iios17uWARa7bekWizGOAXxiwT40wlsUF+K8sDEptJlF6xBl00Mhh59uL82e3SHn
         4uUPhZctZCloA==
Date:   Tue, 14 Jun 2022 11:58:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] proximity: vl53l0x: Handle the VDD regulator
Message-ID: <20220614115824.289aebce@jic23-huawei>
In-Reply-To: <20220614114853.340e9c36@jic23-huawei>
References: <20220523175344.5845-1-markuss.broks@gmail.com>
        <CKKOCWP2NYO5.GH08U776B1KU@otso>
        <20220612095333.1479464c@jic23-huawei>
        <13033502.uLZWGnKmhe@g550jk>
        <20220614114853.340e9c36@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jun 2022 11:48:53 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 12 Jun 2022 11:28:22 +0200
> Luca Weiss <luca@z3ntu.xyz> wrote:
> 
> > Hi Jonathan,
> > 
> > On Sonntag, 12. Juni 2022 10:53:33 CEST Jonathan Cameron wrote:  
> > > On Wed, 08 Jun 2022 12:18:52 +0200
> > > 
> > > "Luca Weiss" <luca.weiss@fairphone.com> wrote:    
> > > > Hi Markuss,
> > > > 
> > > > On Mon May 23, 2022 at 7:53 PM CEST, Markuss Broks wrote:    
> > > > > Handle the regulator supplying the VDD pin of VL53L0X.
> > > > > 
> > > > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > > > ---
> > > > > 
> > > > >  drivers/iio/proximity/vl53l0x-i2c.c | 37 +++++++++++++++++++++++++++++
> > > > >  1 file changed, 37 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/iio/proximity/vl53l0x-i2c.c
> > > > > b/drivers/iio/proximity/vl53l0x-i2c.c index 12a3e2eff464..8581a873919f
> > > > > 100644
> > > > > --- a/drivers/iio/proximity/vl53l0x-i2c.c
> > > > > +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> > > > > @@ -43,6 +43,7 @@
> > > > > 
> > > > >  struct vl53l0x_data {
> > > > >  
> > > > >  	struct i2c_client *client;
> > > > >  	struct completion completion;
> > > > > 
> > > > > +	struct regulator *vdd_supply;
> > > > > 
> > > > >  };
> > > > >  
> > > > >  static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
> > > > > 
> > > > > @@ -192,10 +193,31 @@ static const struct iio_info vl53l0x_info = {
> > > > > 
> > > > >  	.read_raw = vl53l0x_read_raw,
> > > > >  
> > > > >  };
> > > > > 
> > > > > +static void vl53l0x_power_off(void *_data)
> > > > > +{
> > > > > +	struct vl53l0x_data *data = _data;
> > > > > +
> > > > > +	regulator_disable(data->vdd_supply);
> > > > > +}
> > > > > +
> > > > > +static int vl53l0x_power_on(struct vl53l0x_data *data)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = regulator_enable(data->vdd_supply);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	usleep_range(3200, 5000);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > 
> > > > >  static int vl53l0x_probe(struct i2c_client *client)
> > > > >  {
> > > > >  
> > > > >  	struct vl53l0x_data *data;
> > > > >  	struct iio_dev *indio_dev;
> > > > > 
> > > > > +	int error;
> > > > > 
> > > > >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > > >  	if (!indio_dev)
> > > > > 
> > > > > @@ -210,6 +232,21 @@ static int vl53l0x_probe(struct i2c_client *client)
> > > > > 
> > > > >  				     I2C_FUNC_SMBUS_BYTE_DATA))
> > > > >  		
> > > > >  		return -EOPNOTSUPP;
> > > > > 
> > > > > +	data->vdd_supply = devm_regulator_get_optional(&client->dev,     
> > "vdd");  
> > > > > +	if (IS_ERR(data->vdd_supply))
> > > > > +		return dev_err_probe(&client->dev, PTR_ERR(data-    
> > >vdd_supply),    
> > > > > +				     "Unable to get VDD     
> > regulator\n");  
> > > > 
> > > > It looks like this optional regulator is not actually optional.
> > > > 
> > > > [    1.919995] vl53l0x-i2c 1-0029: error -ENODEV: Unable to get VDD
> > > > regulator
> > > > 
> > > > When using devm_regulator_get instead, a dummy regulator gets returned
> > > > which I think is what we want here:
> > > > 
> > > > [    1.905518] vl53l0x-i2c 1-0029: supply vdd not found, using dummy
> > > > regulator
> > > > 
> > > > Can you fix this up or should I send a patch?    
> > > 
> > > Hi Luca,
> > > 
> > > Please send a patch.    
> > 
> > Which commit sha can I use for Fixes: here?
> > Based your togreg[0] branch currently shows "Age: 20 hours" I guess it was 
> > rebased recently?  
> 
> It was rebased onto rc1 as you noticed.
> 
> In theory it is now stable, assuming nothing nasty shows up.
> Fixes tag doesn't matter strongly given both will go into mainline via
> the same pull request, so maybe just skip adding one to make my life
> easier :)
The 'in theory stable' bit lasted a few more mins as I had a patch
I'd otherwise needed to have done a messy revert for.

So definitely safer to skip the Fixes tag for this, though I do
have scripts that check them and should in theory fix it up
if it is based on stale version of togreg.  It's just fiddly
to do.

Thanks
Jonathan


> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Regards
> > Luca
> > 
> > [0]https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg
> >   
> > > 
> > > Jonathan
> > >     
> > > > Regards
> > > > Luca
> > > >     
> > > > > +
> > > > > +	error = vl53l0x_power_on(data);
> > > > > +	if (error)
> > > > > +		return dev_err_probe(&client->dev, error,
> > > > > +				     "Failed to power on the     
> > chip\n");  
> > > > > +
> > > > > +	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off,
> > > > > data);
> > > > > +	if (error)
> > > > > +		return dev_err_probe(&client->dev, error,
> > > > > +				     "Failed to install poweroff     
> > action\n");  
> > > > > +
> > > > > 
> > > > >  	indio_dev->name = "vl53l0x";
> > > > >  	indio_dev->info = &vl53l0x_info;
> > > > >  	indio_dev->channels = vl53l0x_channels;    
> > 
> > 
> > 
> >   
> 

