Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49D81ADEED
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbgDQOCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 10:02:52 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:26341 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730563AbgDQOCv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Apr 2020 10:02:51 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 493d8S57sjz9Y;
        Fri, 17 Apr 2020 16:02:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1587132169; bh=9HG35kq9POqQPp85q7Ip7G1WFp9uIz6IyMcDk5ZEYHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qnA1XbxkTkpsQvg84PlkBbGc0rMtNtXehiFZZHS7m/ZjvLnjNbGJE9AYq20k9kY7k
         9rSrO4htYAqggZ8Dzg0uLeE2fSKGCqPaV6/NlnkHcNkRq5T5UwIlq5Pzcuwa16px8a
         mqdrxHestHS09pyxavJDldTwQAvgNeYsi9Bzty3HOMN34o2gOeNSg4nQVvk3lpxGA3
         2A7lC/pWp/iE33bFSGO5DG9FGAQiCNrb9PT51g/NdK+QCeXIPrBi0EV/I/+X5O6lTQ
         AbBaYvXv+9dJnVPJfYxOR3C0+GJSpo3bjPZnYAylMXprU59iqyLABkRuyPUHXLX6B7
         qa4TmW5GEQmuA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 17 Apr 2020 16:02:46 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 2/3 v3] iio: magnetometer: ak8974: Break out measurement
Message-ID: <20200417140246.GA18337@qmqm.qmqm.pl>
References: <20200417114020.31291-1-linus.walleij@linaro.org>
 <20200417114020.31291-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200417114020.31291-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 01:40:19PM +0200, Linus Walleij wrote:
> This breaks out the measurement code to its own function
> so we can handle this without swirling it up with the
> big switch() statement inside ak8974_read_raw().
> 
> Keep a local s16 helper variable for the signed value
> coming out of the measurement before assigning it to the
> integer *val. The local variable makes the code easier
> to read and the compiler will optimize it if possible.
[...]
> +static int ak8974_measure_channel(struct ak8974 *ak8974, unsigned long address,
> +				  int *val)
> +{
> +	__le16 hw_values[3];
> +	int ret;
> +	s16 outval;
[...]
> +	/*
> +	 * This explicit cast to (s16) is necessary as the measurement
> +	 * is done in 2's complement with positive and negative values.
> +	 * The follwing assignment to *val will then convert the signed
> +	 * s16 value to a signed int value.
> +	 */
> +	outval = (s16)le16_to_cpu(hw_values[address]);
> +	*val = outval;

The intermediate 'outval' is not needed. What you describe in the
comment is a normal C integer promotion rule, so I would leave the
comment out, too. IOW, this is equivalent to:

*val = (s16)le16_to_cpu(...);

Otherwise:
Reviewed-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
