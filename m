Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55F36D693
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 13:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbhD1Lew (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 07:34:52 -0400
Received: from first.geanix.com ([116.203.34.67]:37684 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239480AbhD1Leu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Apr 2021 07:34:50 -0400
Received: from [192.168.64.189] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 1A30C46624E;
        Wed, 28 Apr 2021 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619609642; bh=+ALyxD6Sf6qrcr9jrAtVqYrSCxVEPnnw9zaYyB13Mak=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=NBoP/kGpFANfWlB6NwxQoT+d1OCqoEklTz1wNB30NmFdg9LBczcIevdyA5oXWOUMw
         azziMa5tiRCeJ45QgpHfoGmwW+kduoB1DHzvTPkVrsTB7745XUyF+kDR+xRtVFjL7E
         5zjxOtMkES2jqeicopdlBPICFaI9S5CUL7kl/K+2/N24/fpm+s9e0XdiPWWy/cvrho
         4NxEbmaKMZbJ51jZ4olQE0V+DcQbe7pR4jMCriIFtG0CyFFxyct6EsWnztzIs5cbTk
         sdzoxAII+ZQ0FNz4unAJKiSceCB3WDRV4BQ3j5k8TtLUgiF7YTvSFjxHqbyZAFshPg
         OsnTU71xv8ISg==
Subject: Re: [PATCH v3 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF
 accelerometers
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20210428080107.3584120-1-sean@geanix.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <9b42101e-a48e-d01e-4cd3-51f5ebfcf7d7@geanix.com>
Date:   Wed, 28 Apr 2021 13:34:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428080107.3584120-1-sean@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 28/04/2021 10.01, Sean Nyekjaer wrote:
> |static int fxls8962af_read_raw(struct iio_dev *indio_dev, + struct 
> iio_chan_spec const *chan, + int *val, int *val2, long mask) +{ + 
> struct fxls8962af_data *data = iio_priv(indio_dev); + int ret; + + 
> switch (mask) { + case IIO_CHAN_INFO_RAW: + ret = 
> iio_device_claim_direct_mode(indio_dev); + if (ret) + return ret; + + 
> switch (chan->type) { + case IIO_TEMP: + ret = 
> fxls8962af_get_temp(data, val); + break; + case IIO_ACCEL: + ret = 
> fxls8962af_get_axis(data, chan, val); + break; + default: + ret = 
> -EINVAL; + } + + iio_device_release_direct_mode(indio_dev); + return ret;|
|Maybe I should remove iio_device_claim_direct_mode() and release(),
there is actually nothing in the datasheet that block us from reading 
temp and raw
axis data with streaming enabled to the internal fifo.
We have a use-case for reading temperature data while streaming 
accelerometer data.

Could I just check for ||iio_buffer_enabled||() and skip the drdy and 
power_on/off in
||fxls8962af_get_temp() and ||fxls8962af_get_axis()||?

/Sean
|
