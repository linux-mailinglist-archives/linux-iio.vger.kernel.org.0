Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAE0187239
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 19:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbgCPSXL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 14:23:11 -0400
Received: from www381.your-server.de ([78.46.137.84]:39600 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbgCPSXK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 14:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M7ml/Y4gDZjel4sRH32iDPtQppbmjBMK4zkw++HJBF0=; b=U81rN3TZfipi2EFc5vAjnlQVfp
        avCVc4cUmvOv8fSdHFTPVEj2qrOpx7JJUlVTvVLwoxNwbUY/4t0fqn2dqVKPoelH/L54y7Ij6Sli9
        Nv5D+IsLVpcC8zcjoOsbs0hiGF8VEg3XxcCICM1zEh8ipt2TsGhLUZjSb8aoBAcAZdhgw0Ybjh7AN
        nWeNJhkJrIA90f/6vHBB84wWkLBBmKL3miWDYU5/eNo0Cw0D+0QnfwAFZnahXBkfr/4tifX/r82SJ
        hiGIXjs6Rsy9IWSGoJoDgdp1ntAIj8TCRBnkOpcu2fvczOP8DbbSdmeluHKTatYfZKkTgZcEjd+Tt
        ltBCRERg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jDuOF-0004KC-09; Mon, 16 Mar 2020 19:23:03 +0100
Received: from [93.104.121.61] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jDuOE-000HJ7-Lf; Mon, 16 Mar 2020 19:23:02 +0100
Subject: Re: [PATCH v2 3/4] iio: vcnl4000: Export near level property for
 proximity sensor
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1584380360.git.agx@sigxcpu.org>
 <5566fe01df933d3281f058666e2147cb97b38126.1584380360.git.agx@sigxcpu.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c787921f-c412-4986-14ea-e31b531d3d5b@metafoo.de>
Date:   Mon, 16 Mar 2020 19:23:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5566fe01df933d3281f058666e2147cb97b38126.1584380360.git.agx@sigxcpu.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25753/Mon Mar 16 14:05:55 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/16/20 6:46 PM, Guido Günther wrote:
> [...]
> +static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
> +					uintptr_t priv,
> +					const struct iio_chan_spec *chan,
> +					char *buf)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%u\n", data->near_level);
> +}
> +
> +static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
> +	{
> +		.name = "near_level",

Generally having properties with a underscore in them breaks generic 
parsing of the property name by userspace applications. This is because 
we use underscores to separate different components (type, modifier, 
etc.) of the attribute from each other.

Do you think calling this "nearlevel" would work?

I know there are existing bad examples of properties that use an 
underscore, but we should try to limit introducing new ones.

> +		.shared = IIO_SEPARATE,
> +		.read = vcnl4000_read_near_level,
> +	},
> +	{ /* sentinel */ }
> +};
> +
>   static const struct iio_chan_spec vcnl4000_channels[] = {
>   	{
>   		.type = IIO_LIGHT,
> @@ -350,6 +371,7 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
>   	}, {
>   		.type = IIO_PROXIMITY,
>   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.ext_info = vcnl4000_ext_info,
>   	}
>   };
>   
> @@ -439,6 +461,10 @@ static int vcnl4000_probe(struct i2c_client *client,
>   	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
>   		data->chip_spec->prod, data->rev);
>   
> +	if (device_property_read_u32(&client->dev, "near-level",
> +				     &data->near_level) < 0)
> +		data->near_level = 0;
> +
>   	indio_dev->dev.parent = &client->dev;
>   	indio_dev->info = &vcnl4000_info;
>   	indio_dev->channels = vcnl4000_channels;


