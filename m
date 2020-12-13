Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5222D9048
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 20:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLMTwM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 14:52:12 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:59121 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgLMTwM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2020 14:52:12 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 23558200002;
        Sun, 13 Dec 2020 19:51:30 +0000 (UTC)
Date:   Sun, 13 Dec 2020 20:51:29 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio:pressure:ms5637: introduce hardware
 differentiation
Message-ID: <20201213195129.GN1781038@piout.net>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
 <20201209234857.1521453-3-alexandre.belloni@bootlin.com>
 <20201213171237.4dfe58f5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213171237.4dfe58f5@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 13/12/2020 17:12:37+0000, Jonathan Cameron wrote:
> >  static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 };
> >  /* String copy of the above const for readability purpose */
> >  static const char ms5637_show_samp_freq[] = "960 480 240 120 60 30";
> > @@ -128,6 +133,7 @@ static const struct iio_info ms5637_info = {
> >  
> >  static int ms5637_probe(struct i2c_client *client)
> >  {
> > +	const struct ms_tp_data *data = device_get_match_data(&client->dev);
> 
> As a follow up to the earlier fun with greybus etc, have to jump through
> some hoops to have a fallback here if we have a firmware type that can't
> do get_match_data driver/base/sw_node.c is the one greybus is using.
> 
> We have drivers that don't do this because frankly I didn't know about it
> until a month or two ago.  However, I'm not keen to introduce any
> more.
> 

Couldn't greybus be fixed in that regard? Using the i2c_device_id has
been deprecated for a while now.

what we could do is only provide ms5803 support when there is an
of_node. So this doesn't break the ABI and doesn't break greybus and at
the same time doesn't unnecessarily add complexity to the probe for
something that will probably never be used.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
