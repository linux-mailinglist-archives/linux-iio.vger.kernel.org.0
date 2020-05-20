Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925DB1DABD9
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgETHUZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETHUV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:20:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C38C061A0E;
        Wed, 20 May 2020 00:20:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b6so2559354qkh.11;
        Wed, 20 May 2020 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KJJ3CIQ3eS61c6M1oqeo99mJ8m4fWRgRHozAzbIZeNM=;
        b=LRZrq5BEyc8bsZPFvTw8/Wu6UQ/FDzriYjDgYmAilB1y/RnF4cqCKzpQeaFqngy6NK
         M83IoTQsHmgJKX25w0U3tspNjEpLwBukbNEVx4TFGfz3TQNU9X8AtcYqjHTXM7u20HYY
         zdL3fLf5nf+gLLahG8Mi+prKatIT+GSuC3pZm4ehhSAIj6nOCU1gGqpptlPVyNodhd5K
         fcLKfWPjf3ytMkzqMSa5zB1X6z6KbXoM6B6rZa9PizgBFIQqEwj9s3t+cD8DGkb0OquZ
         OShh/t7JGj65Nf1aFV+nVnIQs4TeaPpUeQGt5+t1nJAXcgpH0SZKftobuDPV5zCo+1/B
         7DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJJ3CIQ3eS61c6M1oqeo99mJ8m4fWRgRHozAzbIZeNM=;
        b=sP8G53OTN6ZDf52w8F1Vznu4z64re8W7G39v3IkdTd0xg8rH6aYrEwSbwJ7kqo7kuQ
         xPb0+gi9m7OUYFIvVeJou1iMw+fwoGdIfJ0MAPMGWfDiVn+UFbjyQnNyVg1ZKxeAsRf+
         WlGQ5AESlS59IZ57ipcArUOIu689aySWOaBzkNJaLxW6X7ECwbRKZ5vw9FJ095Y3Hlbq
         DNl0U6LnmoqRMWh3HtSfaT82e2/wiPQ2lBUQKVVZ5a8B5IZPoPZJbLi6YBjY2FwcPCkq
         vxo1Ei9zHe6cuUr4SMcNFKKI+/wTHAGlOLPRbz6NOyGuNOMohsI6HgTWf5iRgppsxZuo
         zdEg==
X-Gm-Message-State: AOAM532D5SVjii/57ou+OuwZ3d1blAWru63bM2P3H+2c5uBtRyh8KX0E
        p4RFfvs8y7GGAdvE8kWrQXY=
X-Google-Smtp-Source: ABdhPJxEm+ebMl1NpyyksnKC0RvO58VE9kJ94OYNhzvdAI2zttvffrHTV4nrp9WEfore2u7EJ0s7aw==
X-Received: by 2002:a05:620a:1524:: with SMTP id n4mr3381252qkk.490.1589959220413;
        Wed, 20 May 2020 00:20:20 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id j188sm754003qkd.118.2020.05.20.00.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 00:20:19 -0700 (PDT)
Date:   Wed, 20 May 2020 09:20:16 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 4/4] iio: imu: bmi160: added mount-matrix support
Message-ID: <20200520072016.GE3361@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-5-jonathan.albrieux@gmail.com>
 <20200519185711.00003308@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519185711.00003308@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 06:57:11PM +0100, Jonathan Cameron wrote:
> On Tue, 19 May 2020 09:51:00 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > Add mount-matrix binding support. As chip could have different orientations
> > a mount matrix support is needed to correctly translate these differences
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> Hi Jonathan,
> 
> Looks good to me. I'll pick this up once 1-3 are tidied up and
> we have a device tree review in for the binding doc.  I'm rubbish
> at reviewing those as Rob will certify so may well have missed something!
> 
> Jonathan
> 
>

Thank you! I'm going to work on suggestions now,

Best regards,
Jonathan Albrieux
 
> 
> > ---
> >  drivers/iio/imu/bmi160/bmi160.h      |  1 +
> >  drivers/iio/imu/bmi160/bmi160_core.c | 20 ++++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> > index 923c3b274fde..a82e040bd109 100644
> > --- a/drivers/iio/imu/bmi160/bmi160.h
> > +++ b/drivers/iio/imu/bmi160/bmi160.h
> > @@ -9,6 +9,7 @@ struct bmi160_data {
> >  	struct regmap *regmap;
> >  	struct iio_trigger *trig;
> >  	struct regulator_bulk_data supplies[2];
> > +	struct iio_mount_matrix orientation;
> >  };
> >  
> >  extern const struct regmap_config bmi160_regmap_config;
> > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> > index 9bbe0d8e6720..78c8ca962359 100644
> > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> > @@ -110,6 +110,7 @@
> >  		.storagebits = 16,				\
> >  		.endianness = IIO_LE,				\
> >  	},							\
> > +	.ext_info = bmi160_ext_info,				\
> >  }
> >  
> >  /* scan indexes follow DATA register order */
> > @@ -265,6 +266,20 @@ static const struct  bmi160_odr_item bmi160_odr_table[] = {
> >  	},
> >  };
> >  
> > +static const struct iio_mount_matrix *
> > +bmi160_get_mount_matrix(const struct iio_dev *indio_dev,
> > +			const struct iio_chan_spec *chan)
> > +{
> > +	struct bmi160_data *data = iio_priv(indio_dev);
> > +
> > +	return &data->orientation;
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info bmi160_ext_info[] = {
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmi160_get_mount_matrix),
> > +	{ }
> > +};
> > +
> >  static const struct iio_chan_spec bmi160_channels[] = {
> >  	BMI160_CHANNEL(IIO_ACCEL, X, BMI160_SCAN_ACCEL_X),
> >  	BMI160_CHANNEL(IIO_ACCEL, Y, BMI160_SCAN_ACCEL_Y),
> > @@ -840,6 +855,11 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> >  		return ret;
> >  	}
> >  
> > +	ret = iio_read_mount_matrix(dev, "mount-matrix",
> > +				    &data->orientation);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = bmi160_chip_init(data, use_spi);
> >  	if (ret)
> >  		return ret;
> 
> 
