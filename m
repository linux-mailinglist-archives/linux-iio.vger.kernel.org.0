Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209425469DC
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbiFJPxf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349386AbiFJPxU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 11:53:20 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3D92C110;
        Fri, 10 Jun 2022 08:53:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c83so7717437qke.3;
        Fri, 10 Jun 2022 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yhiWlIGhbuZmmSfDVxbp8Dfh9EAKlh+Pg7Cz8rcIYp8=;
        b=jGMORZ2t0/US8hVh5+7ZmIZriYNuhSM6OIGyulLhTB7H0gQkSmPJYSB5xLPS7d22aP
         D+tz/mT5y4gtZtMFdJ954oID+mstf9COy6e93A5nnpuQFllAdJj5o8yIwMdUjHpqvalL
         lFh9G5kAf21MS2Dr6EZE+AHHdYotrT29w1su/Ldqu/ukHHqLipCwDAKwvN/GYw2u3dIz
         sKWYfoJLxjyVTRnGgzvKwImY72wft0H6epKkKr2FJoHFgGQzxhZkEi9nxjT+kdqp1B2t
         VGVO/ogDyl7OgUDIhtK2S8mzdsKJv4TeoUwFCSzSYu0HHPVfZoFj1E++fPponlge746g
         5sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yhiWlIGhbuZmmSfDVxbp8Dfh9EAKlh+Pg7Cz8rcIYp8=;
        b=H8dczrRMbe6JEoI0q8gfIWk/r73cDnlGgV1bE9NJTLgv/lXh450Zx5Ka2oIc7c/pIu
         MIbj8oJvymnWWJ7z6ppDsJw6X6RYLRyo2VQ7ADSpYxQPO2O+DJYraeWdETsRNMF7zJpZ
         HzYiZjgUmUbcejybSSgVmLTVhS9rJmnFLMlniIjg1D6z6BvybNq7FSKbKD8j0f/c2zMV
         qtTjuT2vSfpNq/+N/yOWm5KcdPHoWBpsNOJGP4eC/cCQV3gzlVlY3GjNCxbahDnT9eq4
         Lo4VXsiTJPe/itu8rvg3wIYuJ+S7a5SPbhjy77TVWBmuie18y6Tv/z3E6Bmy7+JROvfi
         t38w==
X-Gm-Message-State: AOAM532QRfwDkyTeIV7DelSQm1WM4s3XjHK8VSYuzwn/1bJqxAHICO3a
        bZL68bs4+EMpBzJsWlvVbbQ=
X-Google-Smtp-Source: ABdhPJzRextq/3cg41qdTg/dMr4D8hpI+nm7RgN1SE+Jb+3+lwY6nJSL58jBT92WELa3x3rvHmk61g==
X-Received: by 2002:a37:4454:0:b0:69f:c339:e2dc with SMTP id r81-20020a374454000000b0069fc339e2dcmr29221348qka.771.1654876397181;
        Fri, 10 Jun 2022 08:53:17 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id j74-20020a37a04d000000b006a7284e5741sm3245028qke.54.2022.06.10.08.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 08:53:16 -0700 (PDT)
Date:   Fri, 10 Jun 2022 11:53:13 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-imx@nxp.com, linux-renesas-soc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 34/34] iio: inkern: fix coding style warnings
Message-ID: <YqNo6U8r80aNFzUr@spruce>
References: <20220610084545.547700-1-nuno.sa@analog.com>
 <20220610084545.547700-35-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610084545.547700-35-nuno.sa@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 10, 2022 at 10:45:45AM +0200, Nuno Sá wrote:
> Just cosmetics. No functional change intended...
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/inkern.c | 64 ++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 7eb536560ded..526519cefcb9 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -45,13 +45,13 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  	int i = 0, ret = 0;
>  	struct iio_map_internal *mapi;
>  
> -	if (maps == NULL)
> +	if (!maps)
>  		return 0;
>  
>  	mutex_lock(&iio_map_list_lock);
> -	while (maps[i].consumer_dev_name != NULL) {
> +	while (!maps[i].consumer_dev_name) {

Shouldn't this be?:
while (maps[i].consumer_dev_name) {

Thanks,
Joe
>  		mapi = kzalloc(sizeof(*mapi), GFP_KERNEL);
> -		if (mapi == NULL) {
> +		if (!mapi) {
>  			ret = -ENOMEM;
>  			goto error_ret;
>  		}
> @@ -69,7 +69,6 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  }
>  EXPORT_SYMBOL_GPL(iio_map_array_register);
>  
> -
>  /*
>   * Remove all map entries associated with the given iio device
>   */
> @@ -163,7 +162,7 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
>  
>  	idev = bus_find_device(&iio_bus_type, NULL, iiospec.fwnode,
>  			       iio_dev_node_match);
> -	if (idev == NULL) {
> +	if (!idev) {
>  		fwnode_handle_put(iiospec.fwnode);
>  		return -EPROBE_DEFER;
>  	}
> @@ -196,7 +195,7 @@ static struct iio_channel *fwnode_iio_channel_get(struct fwnode_handle *fwnode,
>  		return ERR_PTR(-EINVAL);
>  
>  	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
> -	if (channel == NULL)
> +	if (!channel)
>  		return ERR_PTR(-ENOMEM);
>  
>  	err = __fwnode_iio_channel_get(channel, fwnode, index);
> @@ -293,7 +292,7 @@ static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev)
>  
>  	/* NULL terminated array to save passing size */
>  	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
> -	if (chans == NULL)
> +	if (!chans)
>  		return ERR_PTR(-ENOMEM);
>  
>  	/* Search for FW matches */
> @@ -318,7 +317,7 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
>  	struct iio_channel *channel;
>  	int err;
>  
> -	if (name == NULL && channel_name == NULL)
> +	if (!name && !channel_name)
>  		return ERR_PTR(-ENODEV);
>  
>  	/* first find matching entry the channel map */
> @@ -333,11 +332,11 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
>  		break;
>  	}
>  	mutex_unlock(&iio_map_list_lock);
> -	if (c == NULL)
> +	if (!c)
>  		return ERR_PTR(-ENODEV);
>  
>  	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
> -	if (channel == NULL) {
> +	if (!channel) {
>  		err = -ENOMEM;
>  		goto error_no_mem;
>  	}
> @@ -349,7 +348,7 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
>  			iio_chan_spec_from_name(channel->indio_dev,
>  						c->map->adc_channel_label);
>  
> -		if (channel->channel == NULL) {
> +		if (!channel->channel) {
>  			err = -EINVAL;
>  			goto error_no_chan;
>  		}
> @@ -441,7 +440,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  	int mapind = 0;
>  	int i, ret;
>  
> -	if (dev == NULL)
> +	if (!dev)
>  		return ERR_PTR(-EINVAL);
>  
>  	chans = fwnode_iio_channel_get_all(dev);
> @@ -465,7 +464,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  
>  	/* NULL terminated array to save passing size */
>  	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
> -	if (chans == NULL) {
> +	if (!chans) {
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
> @@ -479,7 +478,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  		chans[mapind].channel =
>  			iio_chan_spec_from_name(chans[mapind].indio_dev,
>  						c->map->adc_channel_label);
> -		if (chans[mapind].channel == NULL) {
> +		if (!chans[mapind].channel) {
>  			ret = -EINVAL;
>  			goto error_free_chans;
>  		}
> @@ -541,14 +540,14 @@ struct iio_channel *devm_iio_channel_get_all(struct device *dev)
>  EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
>  
>  static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
> -	enum iio_chan_info_enum info)
> +			    enum iio_chan_info_enum info)
>  {
>  	int unused;
>  	int vals[INDIO_MAX_RAW_ELEMENTS];
>  	int ret;
>  	int val_len = 2;
>  
> -	if (val2 == NULL)
> +	if (!val2)
>  		val2 = &unused;
>  
>  	if (!iio_channel_has_info(chan->channel, info))
> @@ -560,9 +559,10 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>  					vals, &val_len, info);
>  		*val = vals[0];
>  		*val2 = vals[1];
> -	} else
> +	} else {
>  		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
>  					chan->channel, val, val2, info);
> +	}
>  
>  	return ret;
>  }
> @@ -573,7 +573,7 @@ int iio_read_channel_raw(struct iio_channel *chan, int *val)
>  	int ret;
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (chan->indio_dev->info == NULL) {
> +	if (!chan->indio_dev->info) {
>  		ret = -ENODEV;
>  		goto err_unlock;
>  	}
> @@ -592,7 +592,7 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
>  	int ret;
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (chan->indio_dev->info == NULL) {
> +	if (!chan->indio_dev->info) {
>  		ret = -ENODEV;
>  		goto err_unlock;
>  	}
> @@ -606,7 +606,8 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
>  EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
>  
>  static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
> -	int raw, int *processed, unsigned int scale)
> +						 int raw, int *processed,
> +						 unsigned int scale)
>  {
>  	int scale_type, scale_val, scale_val2;
>  	int offset_type, offset_val, offset_val2;
> @@ -639,7 +640,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  	}
>  
>  	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
> -					IIO_CHAN_INFO_SCALE);
> +				      IIO_CHAN_INFO_SCALE);
>  	if (scale_type < 0) {
>  		/*
>  		 * If no channel scaling is available apply consumer scale to
> @@ -684,19 +685,19 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  }
>  
>  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
> -	int *processed, unsigned int scale)
> +				 int *processed, unsigned int scale)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>  	int ret;
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (chan->indio_dev->info == NULL) {
> +	if (!chan->indio_dev->info) {
>  		ret = -ENODEV;
>  		goto err_unlock;
>  	}
>  
>  	ret = iio_convert_raw_to_processed_unlocked(chan, raw, processed,
> -							scale);
> +						    scale);
>  err_unlock:
>  	mutex_unlock(&iio_dev_opaque->info_exist_lock);
>  
> @@ -711,7 +712,7 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
>  	int ret;
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (chan->indio_dev->info == NULL) {
> +	if (!chan->indio_dev->info) {
>  		ret = -ENODEV;
>  		goto err_unlock;
>  	}
> @@ -737,7 +738,7 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>  	int ret;
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (chan->indio_dev->info == NULL) {
> +	if (!chan->indio_dev->info) {
>  		ret = -ENODEV;
>  		goto err_unlock;
>  	}
> @@ -815,7 +816,7 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
>  	int type;
>  
>  	ret = iio_read_avail_channel_attribute(chan, vals, &type, length,
> -					 IIO_CHAN_INFO_RAW);
> +					       IIO_CHAN_INFO_RAW);
>  
>  	if (ret >= 0 && type != IIO_VAL_INT)
>  		/* raw values are assumed to be IIO_VAL_INT */
> @@ -899,7 +900,7 @@ int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
>  	/* Need to verify underlying driver has not gone away */
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (chan->indio_dev->info == NULL) {
> +	if (!chan->indio_dev->info) {
>  		ret = -ENODEV;
>  		goto err_unlock;
>  	}
> @@ -926,7 +927,7 @@ int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
>  	int ret;
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (chan->indio_dev->info == NULL) {
> +	if (!chan->indio_dev->info) {
>  		ret = -ENODEV;
>  		goto err_unlock;
>  	}
> @@ -960,9 +961,8 @@ unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
>  }
>  EXPORT_SYMBOL_GPL(iio_get_channel_ext_info_count);
>  
> -static const struct iio_chan_spec_ext_info *iio_lookup_ext_info(
> -						const struct iio_channel *chan,
> -						const char *attr)
> +static const struct iio_chan_spec_ext_info *
> +iio_lookup_ext_info(const struct iio_channel *chan, const char *attr)
>  {
>  	const struct iio_chan_spec_ext_info *ext_info;
>  
> -- 
> 2.36.1
> 
