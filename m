Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866504B3CB4
	for <lists+linux-iio@lfdr.de>; Sun, 13 Feb 2022 19:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiBMSDV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Feb 2022 13:03:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiBMSDV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Feb 2022 13:03:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41275A5AB
        for <linux-iio@vger.kernel.org>; Sun, 13 Feb 2022 10:03:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ADC1B80B3E
        for <linux-iio@vger.kernel.org>; Sun, 13 Feb 2022 18:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094D3C004E1;
        Sun, 13 Feb 2022 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644775392;
        bh=FVYiwIWX+2GqYpEFDWdABKBJzc+I29W0K/0LbSEoUcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lzukzh255pRh6wSJRre8c2JAZfU3VyKfX29r1oOrsF96OgFxCosqmSAL4u13SU70B
         mGmgYHtFpj44p/FQPORw6rDnND54Xy5F2OMDI9aTmwwrHKmGj1uVy9qiK8bhsNttce
         gItYfJnFYod4hwy97L39OdkKyvQXwwkHJ3c8xNDBpgPQbJegAnCUsLLSlAAioCYJxt
         gMrklcF/Qn0jr8uLVqylVazGBkSaxuQ9j28Jv/wpjQhsZDMq+2AkXQrwZLfRwLCnsx
         HoEzMbkJDreVc1Pm7j7/vs6Jejyt9Q3K5s09LJorPEh/5xWn37RSeu0MFsABru0kie
         mBm5N+rf5FEMA==
Date:   Sun, 13 Feb 2022 18:09:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: mma8452: Fix probe failing when an
 i2c_device_id is used
Message-ID: <20220213180953.380fdb54@jic23-huawei>
In-Reply-To: <3c271a63-62e4-033c-6285-b8695aea7d07@redhat.com>
References: <20220207103419.309032-1-hdegoede@redhat.com>
        <20220207212238.5dc88f44@jic23-huawei>
        <3c271a63-62e4-033c-6285-b8695aea7d07@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Feb 2022 23:55:09 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/7/22 22:22, Jonathan Cameron wrote:
> > On Mon,  7 Feb 2022 11:34:18 +0100
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> >> The mma8452_driver declares both of_match_table and i2c_driver.id_table
> >> match-tables, but its probe() function only checked for of matches.
> >>
> >> Add support for i2c_device_id matches. This fixes the driver not loading
> >> on some x86 tablets (e.g. the Nextbook Ares 8) where the i2c_client is
> >> instantiated by platform code using an i2c_device_id.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> > We've lost the fixes tag from the v1 discussion.   
> 
> Ah right, so that would be:
> 
> Fixes: c3cdd6e48e35 ("iio: mma8452: refactor for seperating chip specific data")
> 
> I'll add that for v3.
> 
> >> ---
> >> Changes in v2:
> >> - Fix the following smatch warning:
> >>   drivers/iio/accel/mma8452.c:1595 mma8452_probe() error: we previously assumed 'id' could be null (see line 1536)
> >>   Reported-by: kernel test robot <lkp@intel.com>
> >>   Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >>  drivers/iio/accel/mma8452.c | 25 ++++++++++++++++---------
> >>  1 file changed, 16 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> >> index 64b82b4503ad..eaa236cfbabb 100644
> >> --- a/drivers/iio/accel/mma8452.c
> >> +++ b/drivers/iio/accel/mma8452.c
> >> @@ -1523,12 +1523,7 @@ static int mma8452_probe(struct i2c_client *client,
> >>  	struct iio_dev *indio_dev;
> >>  	int ret;
> >>  	const struct of_device_id *match;
> >> -
> >> -	match = of_match_device(mma8452_dt_ids, &client->dev);
> >> -	if (!match) {
> >> -		dev_err(&client->dev, "unknown device model\n");
> >> -		return -ENODEV;
> >> -	}
> >> +	const char *compatible;
> >>  
> >>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> >>  	if (!indio_dev)
> >> @@ -1537,7 +1532,19 @@ static int mma8452_probe(struct i2c_client *client,
> >>  	data = iio_priv(indio_dev);
> >>  	data->client = client;
> >>  	mutex_init(&data->lock);
> >> -	data->chip_info = match->data;
> >> +
> >> +	if (id) {
> >> +		compatible = id->name;
> >> +		data->chip_info = &mma_chip_info_table[id->driver_data];
> >> +	} else {
> >> +		match = of_match_device(mma8452_dt_ids, &client->dev);
> >> +		if (!match) {
> >> +			dev_err(&client->dev, "unknown device model\n");
> >> +			return -ENODEV;
> >> +		}
> >> +		compatible = match->compatible;  
> > 
> > Won't this be "fsl,mma8452" or similar when we want "mma8452"?
> > That doesn't matter for the dev_info() but it does matter for
> > indio_dev->name which is part of the userspace ABI.  
> 
> If we hit the "else" path then yes, this will be e.g. "fsl,mma8452"
> but note how indio_dev->name was previously unconditionally set
> to id->name. This did not cause a NULL ptr deref because the i2c-core
> sets client->name by using of_modalias_node() which strips the
> "fsl," vendor-prefix.
> 
> client->name being just "mma8452" means that the id pointer will
> be non NULL even for of-instantiated i2c-clients, instead it
> will point to the "mma8452" i2c_device_id so we will hit the
> if (id) {} path even for of-instantiated i2c-client.
> 
> The only case where we can hit the else is if there is an
> entry added to the mma8452_dt_ids[] array which is not present
> in the mma8452_id[] array, which atm is not the case
> (which is confirmed by the lack of bug reports about NULL ptr
> derefs).
> 
> Note that since client->name matches on of the mma8452_id[]
> entries the entire mma8452_dt_ids[] array + the else path
> could be completely dropped and things will still work
> through a fallback on only using the mma8452_id[] array.
> 
> But AFAIK the preferred method for of enumerated clients
> is to use of-matches.
> 
> So ideally I guess we would do something like this:
> 
> match = of_match_device(mma8452_dt_ids, &client->dev);
> if (match) {
>         compatible = match->compatible;
>         data->chip_info = match->data;
> } else if (id) {
>         compatible = id->name;
>         data->chip_info = &mma_chip_info_table[id->driver_data];
> } else {
> 	dev_err(&client->dev, "unknown device model\n");
> 	return -ENODEV;
> }
> 
> And then for indio_dev->name do:
> 
> indio_dev->name = client->name;
> 
> Since that has the vendor-prefix stripped, just like the old
> id->name to which it used to be set.
> 
> > Probably easiest way to work around this is to just put the names
> > as an extra entry in the mma_chip_info_table[] so they can
> > be trivially retrieved in either path.
> > Sure it's duplication of a string but they are pretty small and
> > it makes for less special casing in the code.
> > 
> > However, looking again at this code I noticed that you haven't
> > actually introduced the fact that id->name wouldn't be set which
> > made me remind myself of how the i2c-core-of.c code works.
> > It has a quirk.  It will actually always provide the id via
> > the following path:
> > 
> > of_i2c_register_device()  
> > -> of_i2c_get_board_info()
> >   -> info->type set in of_modalias_node to the part of the compatible after the comma.  
> > 
> > Then
> > of_i2c_register_device()  
> > -> of_i2c_new_client_device()  
> >   which copies info->type into client->name
> > 
> > Then via i2c_device_probe() for the i2c bus the probe is
> > called with an i2c_match_id(driver->id_table, client)
> > to provide the id parameter.
> > 
> > So for devicetree you won't hit your else above as if (id)
> > will also pass (which is why the id->name before was working).
> > 
> > This path is dropped if we ever move to the probe_new() callback
> > but for now I think it will just work.
> > 
> > Now, what to do about this.. In similar cases we do
> > if (client->dev.of_node) {
> >  of option.
> > } else {
> >  id option
> > }
> > though this is mostly because people don't feel confident
> > the i2c id path will always work for device tree just because
> > (assuming I followed it through correctly) it works today.  
> 
> I should have read on before replying to your initial remark
> right away, oops. Right as we both say id will be set even for
> of-matches, but only when the of_match and the old i2c_client_id
> match tables both have an entry for the model.
> 
> > Now for ACPI there isn't such a path so when we move to
> > generic device properties we can't assume id is anything other
> > than NULL. Note that this driver hasn't previously been converted
> > to generic fw properties because of the absence of a suitable
> > fwnode_irq_get_by_name() but Andy pointed out this week that
> > we now have one available:
> > https://lore.kernel.org/all/YflfEpKj0ilHnQQm@smile.fi.intel.com/
> > https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?h=i2c/alert-for-acpi&id=ca0acb511c21738b32386ce0f85c284b351d919e
> > 
> > Given that conversion is likely to happen shortly I'd like to
> > use the pattern above rather than temporarily relying on
> > the struct i2c_device_id always being available.  
> 
> Hmm, I see, yes my proposed:
> 
> 	indio_dev->name = client->name;
> 
> trick will not work once ACPI also comes into play and I see
> that e.g. the bmc150-accel driver already gets the indio_dev->name
> from the chip_info_table[] in the ACPI case, so I will prepare
> a v3 doing so.
> 
> I guess that makes this more 5.18 material then 5.17 though,
> but that is fine the platform code instantiating an old
> fashioned i2c-client relying on i2c_client_id matching
> won't land till 5.18 either.
Ah. IN that case I'll yank v3 from the fixes branch over to
the one for next cycle and can apply patch 2 as well.

Thanks,

J
> 
> Regards,
> 
> Hans
> 
> 
> 
> >> +		data->chip_info = match->data;
> >> +	}
> >>  
> >>  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> >>  	if (IS_ERR(data->vdd_reg))
> >> @@ -1581,11 +1588,11 @@ static int mma8452_probe(struct i2c_client *client,
> >>  	}
> >>  
> >>  	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
> >> -		 match->compatible, data->chip_info->chip_id);
> >> +		 compatible, data->chip_info->chip_id);
> >>  
> >>  	i2c_set_clientdata(client, indio_dev);
> >>  	indio_dev->info = &mma8452_info;
> >> -	indio_dev->name = id->name;
> >> +	indio_dev->name = compatible;
> >>  	indio_dev->modes = INDIO_DIRECT_MODE;
> >>  	indio_dev->channels = data->chip_info->channels;
> >>  	indio_dev->num_channels = data->chip_info->num_channels;  
> >   
> 

