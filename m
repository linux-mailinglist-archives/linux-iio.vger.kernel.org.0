Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC714AB063
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 16:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbiBFPsv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 10:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBFPsu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 10:48:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EABC06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 07:48:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EC1661172
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 15:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B21FC340E9;
        Sun,  6 Feb 2022 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644162528;
        bh=nYiqi0EP0a+NkBBI3UTEbb/T6jSq74lDxmNf4H9pSn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dnmpAfKfO0SuuJvJ28YJzEgQwvWSZWhDgR4K6b1zVI3Jya01+sAGBrX9KtpZozZ4l
         AZd8s2idHVvcuGMS0/H6EtmoiezcVf+u/8NKtZqUUktGRgXCEv6gczpTRd6zOIOXUO
         TQ99Wb34Lm51hfowGRSiPRFCZY25j72ZZZ4XmeVd3NEZ9ItuGjmKjzTY5l3z8skjuC
         /zdpSNG6zXKHOe3F8wi24ltP80YrAJCBbAU/h72sVixuq3uqnl6YuKRtsbVyV1OMsU
         QTplPMIO1xOqisPBwItMowfw28buY94UCbWJXDLZvjfXrRe+ZpAkIvavXtm6KQql2U
         +yq9qC91o2P8w==
Date:   Sun, 6 Feb 2022 15:55:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 07/12] iio: st_sensors: Use
 iio_device_claim/release_direct_mode() when relevant
Message-ID: <20220206155520.6cca376b@jic23-huawei>
In-Reply-To: <20220202140208.391394-8-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
        <20220202140208.391394-8-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Feb 2022 15:02:03 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The st_sensors_core driver hardcodes the content of the
> iio_device_claim_direct_mode() and iio_device_release_direct_mode()
> helpers. Let's get rid of this handcrafted implementation and use the
> proper core helpers instead. Additionally, this lowers the tab level
> (which is always good) and prevents the use of the ->currentmode
> variable which is not supposed to be used like this anyway.
> 
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../iio/common/st_sensors/st_sensors_core.c   | 32 +++++++++----------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index d0419234a747..e61622e3bc85 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -559,28 +559,26 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
>  	int err;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> -	mutex_lock(&indio_dev->mlock);
> -	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> -		err = -EBUSY;
> +	err = iio_device_claim_direct_mode(indio_dev);
> +	if (err)
> +		return err;
> +
> +	err = st_sensors_set_enable(indio_dev, true);
> +	if (err < 0)
>  		goto out;
> -	} else {
> -		err = st_sensors_set_enable(indio_dev, true);
> -		if (err < 0)
> -			goto out;
>  
> -		mutex_lock(&sdata->odr_lock);
> -		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
> -		err = st_sensors_read_axis_data(indio_dev, ch, val);
> -		mutex_unlock(&sdata->odr_lock);
> -		if (err < 0)
> -			goto out;
> +	mutex_lock(&sdata->odr_lock);

This is problematic I think as the lock taken around getting sdata->odr
in set_sensors_set_enable() but then dropped briefly before being
reacquired here.  If someone sneaks a write in that window, it
looks like we might sleep for the wrong amount of time because sdata->odr
has changed.  I think you need to hold the lock across the whole
enable/read/disable cycle (disable probably not necessary but it
would be more obviously correct if we did hold it across that as well).

Clearly this actually got introduced in the earlier patch but diff
wasn't showing a wide enough bit of code so I missed it.

Note it is fairly common to use iio_device_claim_direct_mode() to
prevent data rate changes whilst doing buffered capture as that tends
to make the data messy and can lead to skipped samples etc.  Doing
that would have the side effect of closing the race.
It is a bit undocumented though in the sense that I don't think
we have ever stated that iio_device_claim_direct_mode() will block
against another iio_device_claim_direct_mode() so accesses are
serialized.  So better to have the local lock enforce the
necessary serialization.  Whilst I doubt we will change the
implementation of iio_device_claim_direct_mode() any time
soon you never know.

Thanks,

Jonathan


> +	msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
> +	err = st_sensors_read_axis_data(indio_dev, ch, val);
> +	mutex_unlock(&sdata->odr_lock);
> +	if (err < 0)
> +		goto out;
>  
> -		*val = *val >> ch->scan_type.shift;
> +	*val = *val >> ch->scan_type.shift;
>  
> -		err = st_sensors_set_enable(indio_dev, false);
> -	}
> +	err = st_sensors_set_enable(indio_dev, false);
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	iio_device_release_direct_mode(indio_dev);
>  
>  	return err;
>  }

