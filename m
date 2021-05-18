Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2910838748C
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 11:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347077AbhERJDR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 05:03:17 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:13880 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242344AbhERJDQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 05:03:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621328502; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OsCquE7FF2x9wEXCIm0cwxKUBx9QmA81Hw5FsGFc0VdJlRsIpDPytQmyiWS6RPBHoB
    YdXthFERYeSP5kk/SCT9x3SGEd7IZ7ToHfGqk8ltQ7MrT37p64dYt5yM9GOTzHYMDc3D
    B1Fe0Bu/p/t9A9lPy6/8BGOEISIH3lGweQGCLJvXlIkWaW4lbv2CI5DXWKuhZ50UD999
    KejQtcIf0WnLFudTuci0tUJ/QND1yCdIraDOgTyQaBGPBs2MGtT4Q3+UZqwX250+OGPO
    RFILhAWax0xby8SrIaaaekOfKRzX5VpSYVuzsE2rVsU+nT6GNYlB05DXzztYXBxpkixv
    uyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621328502;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=r6unr2TijJ9d9viQNy0PTbecy1oLf70L2hiaIyvjwL0=;
    b=OkTtbjX4eEQnqXeTzpL7RJ+hIBdn+orNYIRYUiErLWPOGgo3Ltak6cUnD+FXtVEa7y
    IFLf23ZUE8sd0NPJaVFELFO/0/T15VeUSgBv4aXdpZhPNkCi06e48vSymB5/jbfx6RwV
    LEr3EX/1JMVnPgbZrXU9jaLU90i9rvcrfm8Il0i5kkZz0kG4k2vZrIoR6ysiK0v6r4HK
    IqLY1Lkr8KODIXW5d6R+w0eeVKk3Te7TowLPyZfaLH4r/FdvwcPru8CY0OwiMLpCmp/p
    AoDM4rJaIfvG1EnOb5iVwdoP0g1hwDuSkqqbayM8yyiv+Ymvdl417GiJ7XRVZ8R4ELQs
    2mlA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621328502;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=r6unr2TijJ9d9viQNy0PTbecy1oLf70L2hiaIyvjwL0=;
    b=EMotBmxfhZc9z5Yshy2eNPqwJSZHPdWvvW/Iw5FwnNo6c4hTGNQg1P15vlpYgHfv8b
    1Th5vM4nTwSS7mjhf4a88Pq5AKccXcXAzTD12iRBixcFAR/SNhKe+tA2ApDBKO06OjXY
    PH08NXKogde7BIWkT+Z2XnILaDniSilcX8MR39VAtAGjFw9xlJ8EHJb2ulfsNWAG4IGA
    TmsSwwt7Rvr3fzeERMx+GD9MrSCzoEZuVMRVKc1O/K5gfA/QL+3IS640QL1Fa533PQJ2
    uxH6DAcHiIOjb0ttz3Ng7OIu/bVUpc8KTf1Ntk7fzAXph1Il6BFgjG6rdMT5vRcL5qWv
    4CsA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/Da4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id f01503x4I91f0Zy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 May 2021 11:01:41 +0200 (CEST)
Date:   Tue, 18 May 2021 11:01:37 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH 4/5 v2] iio: magnetometer: st_magn: Support mount matrix
Message-ID: <YKOCcQNfJ1t7YmGB@gerhold.net>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
 <20210517233322.383043-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517233322.383043-4-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Tue, May 18, 2021 at 01:33:21AM +0200, Linus Walleij wrote:
> Add support to read and present the mounting matrix on ST magnetometers.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - New patch because why not.

Thanks for patching the other ST drivers as well!
That reminds me about something I was thinking about when I was making
the changes a week ago. :)

> ---
>  drivers/iio/magnetometer/st_magn_core.c | 64 ++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 71faebd07feb..fa587975cb85 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -53,51 +53,74 @@
>  #define ST_MAGN_3_OUT_Y_L_ADDR			0x6a
>  #define ST_MAGN_3_OUT_Z_L_ADDR			0x6c
>  
> +static const struct iio_mount_matrix *
> +st_magn_get_mount_matrix(const struct iio_dev *indio_dev,
> +			 const struct iio_chan_spec *chan)
> +{
> +	struct st_sensor_data *mdata = iio_priv(indio_dev);
> +
> +	return &mdata->mount_matrix;
> +}
> +
> +static const struct iio_chan_spec_ext_info st_magn_mount_matrix_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_magn_get_mount_matrix),
> +	{ },
> +};
> +

I'm not sure if this is worth it (or even a particularly good idea),
but we could share this function and struct in st_sensors_core.c
since it's exactly the same for st_accel/magn/gyro AFAICT.
(It just operates on the common struct st_sensor_data).

This could be done with a macro like ST_SENSORS_LSM_CHANNELS_MOUNT_MATRIX(...)
(maybe a bit long and clumsy) instead of _EXT(...) and pointing to
a struct iio_chan_spec_ext_info somewhere in st_sensors_core.c.

The disadvantage however is that st_accel/magn/gyro couldn't add other
(sensor-specific) ext_info later. Not sure if that is realistic though.

I wasn't entirely sure myself that's why I went with the _EXT(...)
instead (especially since I only wanted to patch st_accel).
Just wanted to mention it :)

Stephan
