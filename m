Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EEA4B3CC2
	for <lists+linux-iio@lfdr.de>; Sun, 13 Feb 2022 19:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiBMSFe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Feb 2022 13:05:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiBMSFe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Feb 2022 13:05:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB635F8D2
        for <linux-iio@vger.kernel.org>; Sun, 13 Feb 2022 10:05:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA9061232
        for <linux-iio@vger.kernel.org>; Sun, 13 Feb 2022 18:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4485C004E1;
        Sun, 13 Feb 2022 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644775527;
        bh=CCtjpAp/2wmDmKWZsQ58YuqSk8zKqH/ZNvKnrFrFKjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dV6LT5TAnhHg/EpX8kVQB/jlJfCMRwFCK0vd9nUazZxceJNZkJz9WjOPKMcVZUL1H
         hxhZz0GeUbG99EHL4GFLSaTNoz7ePTLcpybqxeRm098OAFWYhUBBWKN6MQaXZ388VO
         KA8fVLzH5NT+bOfqeh1Z3IwmUUpX5Vtxe9kbPrMzUuwmRpMXbjVpxmEPLmhET3KtVH
         GOM25fl/Xwu4hbJiPhdTwftDX7YTuCZnV4ss9WCPzMIJ7FxUE4gyCHDr7pAIlC3Wa+
         Pp9RuK+bNpCBsdsnlPvv12z0EY5l0eSa4e0sfBCeDwpuoNsYVLh2TQE/qTcYb6i0TX
         XNSZVpZp9EOvA==
Date:   Sun, 13 Feb 2022 18:12:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: mma8452: Add support for the "mount-matrix"
 device property
Message-ID: <20220213181209.68d593b0@jic23-huawei>
In-Reply-To: <20220208124336.511884-2-hdegoede@redhat.com>
References: <20220208124336.511884-1-hdegoede@redhat.com>
        <20220208124336.511884-2-hdegoede@redhat.com>
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

On Tue,  8 Feb 2022 13:43:36 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Add support for the standard "mount-matrix" device property to
> the mma8452 driver.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Change of plan. Both patches now applied to the togreg branch of iio.git
as you mentioned in v2 discussion that you don't need this until
5.18 and it saves me juggling patches taking different routes.

> ---
> Note this applies on top of the following recent patch from me:
> "iio: mma8452: Fix probe failing when an i2c_device_id is used"
> ---
>  drivers/iio/accel/mma8452.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 0528717d9f44..590d9431e1bd 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -104,6 +104,7 @@
>  struct mma8452_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> +	struct iio_mount_matrix orientation;
>  	u8 ctrl_reg1;
>  	u8 data_cfg;
>  	const struct mma_chip_info *chip_info;
> @@ -1190,6 +1191,20 @@ static const struct attribute_group mma8452_event_attribute_group = {
>  	.attrs = mma8452_event_attributes,
>  };
>  
> +static const struct iio_mount_matrix *
> +mma8452_get_mount_matrix(const struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info mma8452_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, mma8452_get_mount_matrix),
> +	{ }
> +};
> +
>  #define MMA8452_FREEFALL_CHANNEL(modifier) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
> @@ -1228,6 +1243,7 @@ static const struct attribute_group mma8452_event_attribute_group = {
>  	}, \
>  	.event_spec = mma8452_transient_event, \
>  	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
> +	.ext_info = mma8452_ext_info, \
>  }
>  
>  #define MMA8652_CHANNEL(axis, idx, bits) { \
> @@ -1249,6 +1265,7 @@ static const struct attribute_group mma8452_event_attribute_group = {
>  	}, \
>  	.event_spec = mma8452_motion_event, \
>  	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
> +	.ext_info = mma8452_ext_info, \
>  }
>  
>  static const struct iio_chan_spec mma8451_channels[] = {
> @@ -1546,6 +1563,10 @@ static int mma8452_probe(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> +	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(data->vdd_reg))
>  		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),

