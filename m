Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317D34E9CD4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbiC1QrW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243502AbiC1QrI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 12:47:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2724BF5
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 09:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61015B81171
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 16:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8382C004DD;
        Mon, 28 Mar 2022 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648485900;
        bh=VGIWk7rs3RQrrYM2WRoEdQLm6HwaP6qG6SQrcn4WACM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dUShQrL6QB/QJxTA9K4ww+TiqcIw1oqxpBIdI91yTrCk3abLhrHzWePM92g9c/8+T
         YMx0XaaQn+wMfqwj0fIAIPESdCKHAo/EXOggN80C6P+rPOlZ+joB7l1l2iKFy0oU1S
         GrNAzMpjEOh2T5VFviTGBTgwvyQo1K7yz5R/3JTVmnyoxj46bylUhznOPus7Z0uNir
         HRgrySLCEC4xcQT6jF8ukhMRDxcdEdE4ZB9qi1W0+xHE2YChV7iJxwELq9rrD69F1u
         IC2KyrMDHJhWFaYQEfAikSfsVeOkl1hcLwzg1NoYnOnWL4pKz0ajyQxy6vKzIepkyv
         eIb9sPOR34Lzw==
Date:   Mon, 28 Mar 2022 17:52:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 10/10] iio: adc: ti-ads1015: Switch to read_avail
Message-ID: <20220328175237.46f624ab@jic23-huawei>
In-Reply-To: <2a5699df-51b0-de6f-6651-b0e0eefd8667@denx.de>
References: <20220322220210.207454-1-marex@denx.de>
        <20220322220210.207454-10-marex@denx.de>
        <20220327161835.5c661300@jic23-huawei>
        <2a5699df-51b0-de6f-6651-b0e0eefd8667@denx.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Mon, 28 Mar 2022 02:31:32 +0200
Marek Vasut <marex@denx.de> wrote:

> On 3/27/22 17:18, Jonathan Cameron wrote:
> > On Tue, 22 Mar 2022 23:02:10 +0100
> > Marek Vasut <marex@denx.de> wrote:
> >   
> >> Replace sysfs attributes with read_avail() callback. This also permits
> >> removal of ads1115_info, since the scale attribute tables are now part
> >> of chip data.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Cc: Andy Shevchenko <andy@kernel.org>
> >> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> >> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > Sorry, I didn't catch your question on v3 about why I was advocating
> > signed.
> > 
> > You are passing pointers to those arrays as signed in the
> > read_avail.
> > 
> > Obviously you can 'get away with it' because the values are small
> > positive numbers and hence in 2's complement the data representation
> > will be the same.  Not pretty though so my inclination would
> > be to keep them signed everywhere.
> > 
> > If you are fine with that change I can change it whilst applying if
> > nothing else comes up in review.  
> 
> I'm fine with it, although I did switch them all to unsigned int in this 
> V4 (unless I'm missing something still).

You switched to unsigned int, but...

+static int ads1015_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct ads1015_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_FRACTIONAL_LOG2;
+		*vals =  data->chip->scale;

This then uses them as signed integers.  Which as mentioned is
technically not a bug, but that's only because the numbers
are small..  So better to go signed throughout.


+		*length = data->chip->scale_len;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = data->chip->data_rate;
+		*length = data->chip->data_rate_len;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
