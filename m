Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D562281B2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGUOLb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 10:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGUOLb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 10:11:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5AC0619DA;
        Tue, 21 Jul 2020 07:11:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so1636800pjd.3;
        Tue, 21 Jul 2020 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HegLuYZPFFSazhaMow4ETM/dSjExzGWrhJw29Et5Fac=;
        b=X0WITuCz3faYxv4JwbjHKtqa6l7jbD2qmRJ6fnNjKSupg9b/oScWl4yxyp62ZGd44q
         RK5uoB3zIxFdVX1FJfnwrUyikoPSHKw6DP0hfCO1DPuOuQdy4Scm7NoJjnb+HrrKBOAQ
         o8x2s8WzJSWG8OMq5sjeIdH1jB6MEJ50Ykl3w3EVJxXaQ2F9lTFtHNawyB7X5k13WGzZ
         3RwhizhBaKw5fbPruu1wso+4slrJ5W5Fligt5zNVWTVdNg6Eb7kYZqZaUPkkED00lmX6
         gydbG+ASbqDRQ+E91Lrq50CGq4NDFjSUmCSy0dCNazwWDLGmkRtFXoHVBa1it5wcZGNy
         EURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HegLuYZPFFSazhaMow4ETM/dSjExzGWrhJw29Et5Fac=;
        b=tz+cqJW9FRkvdkPcW+R2ZYE9rz6aXx/unGtwtQM8Ox4keCT/pdyI0kQTbJypK0Q/do
         L9Dlfyv2xDEtl+Jxjm5fN8Zf9EjEpHIeKHt+4UxAC23Q1EN0cP46FBIwrlFebZsgXMLE
         f2KfrPpWmEwvUFi/udLDpweN7NjgIkAqGfK5x+yHM/h3+ddYZNMe5MqwX15MQgbDQ70B
         /LufQC/ophFjQ8tJBzqGv36ZgsevgQEjW+08ueICMcY6aD5GqguhCLHLcii/Vx33WPRZ
         w9JagbFcHd/zBjIi07JFQ9J2l+lj6FpRPeQEi1YOdfsOpxfRjsbkRechAQWIvay6fbkV
         RB1A==
X-Gm-Message-State: AOAM533GKUS8GfIQ2m90pNLU145pxEQv0dkudnwMa2lpOheTd5VXlzi0
        rY28b1o/lIMjN0VOUWhSzmwfIuuv
X-Google-Smtp-Source: ABdhPJwL/KFf3AtboRoDEc1lXf4RRc7fnqSVpItq3LVQX7y7KS7tVvRE2eHjkwxDBiZikN9NkOjXhg==
X-Received: by 2002:a17:90a:6983:: with SMTP id s3mr4980465pjj.55.1595340690522;
        Tue, 21 Jul 2020 07:11:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n22sm3285232pjq.25.2020.07.21.07.11.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 07:11:29 -0700 (PDT)
Date:   Tue, 21 Jul 2020 07:11:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v2 4/4] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
Message-ID: <20200721141128.GA130724@roeck-us.net>
References: <20200720202243.180230-1-linux@roeck-us.net>
 <20200720202243.180230-5-linux@roeck-us.net>
 <401aec54-ff21-7e0f-85dc-e32435df2672@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401aec54-ff21-7e0f-85dc-e32435df2672@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Enric,

On Tue, Jul 21, 2020 at 01:29:01PM +0200, Enric Balletbo i Serra wrote:
> Hi Guenter,
> 
> Thank you for work on this. Cc'ing Gwendal as he has a deep knowledge of the EC
> and their errors.

The series is now also available in Gerrit at
	https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2306731/3
for integration/testing into ChromeOS.

Thanks,
Guenter

> 
> On 20/7/20 22:22, Guenter Roeck wrote:
> > The EC reports a variety of error codes. Most of those, with the exception
> > of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> > error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
> > to Linux error codes to report a more meaningful error to the caller to aid
> > debugging.
> > 
> > Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > Cc: Prashant Malani <pmalani@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: No change
> > 
> > Notes:
> >     I would welcome feedback on the error code translations.
> >     Can we do better ?
> > 
> >     -ENOTSUPP is not a recommended error code, and checkpatch complains
> >     about it. It is used in existing code, so I did not change it, but it
> >     might be worthwhile exploring if we can find a better error code to
> >     report "version not supported". Possible candidates might be EPROTOTYPE,
> >     ENOPROTOOPT, EPROTONOSUPPORT, EPFNOSUPPORT, or EAFNOSUPPORT. I don't
> >     see a direct match, but NFS reports -EPROTONOSUPPORT for unsupported
> >     protocol versions.
> > 
> >  drivers/platform/chrome/cros_ec_proto.c | 37 +++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index 3e745e0fe092..10aa9e483d35 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> >  }
> >  EXPORT_SYMBOL(cros_ec_cmd_xfer);
> >  
> > +static const int cros_ec_error_map[] = {
> > +	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
> > +	[EC_RES_ERROR] = -EIO,
> 
> nit -EREMOTEIO? To make explicit that the error is "remote" from the host.
> Although -EIO seems to be more generic.
> 
> > +	[EC_RES_INVALID_PARAM] = -EINVAL,
> > +	[EC_RES_ACCESS_DENIED] = -EACCES,
> > +	[EC_RES_INVALID_RESPONSE] = -EPROTO,
> > +	[EC_RES_INVALID_VERSION] = -ENOTSUPP,
> 
> +1 for EPROTONOSUPPORT to match with EC_RES_INVALID_VERSION
> 
> > +	[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
> > +	[EC_RES_IN_PROGRESS] = -EINPROGRESS,
> > +	[EC_RES_UNAVAILABLE] = -ENODATA,
> > +	[EC_RES_TIMEOUT] = -ETIMEDOUT,
> > +	[EC_RES_OVERFLOW] = -EOVERFLOW,
> > +	[EC_RES_INVALID_HEADER] = -EBADR,
> > +	[EC_RES_REQUEST_TRUNCATED] = -EBADR,
> > +	[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
> > +	[EC_RES_BUS_ERROR] = -EFAULT,
> > +	[EC_RES_BUSY] = -EBUSY,
> 
> Although the name matches, I'm wondering if we should use -EAGAIN instead as per
> EC documentation:
> 
>   EC_RES_BUSY - Up but too busy. Should retry.
> 
> hmm, however, for the audio codec, for example, this seems to have a slightly
> different meaning and retry is not what we want, so let's do direct translation
> and stay with -EBUSY.
> 
> > +	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
> > +	[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
> > +	[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
> > +	[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
> > +};
> > +
> >  /**
> >   * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
> >   * @ec_dev: EC device.
> > @@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
> >   *
> >   * Return:
> >   * >=0 - The number of bytes transferred
> > - * -ENOTSUPP - Operation not supported
> > - * -EPROTO - Protocol error
> > + * <0 - Linux error code
> >   */
> >  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >  			    struct cros_ec_command *msg)
> > @@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >  	ret = cros_ec_cmd_xfer(ec_dev, msg);
> >  	if (ret < 0) {
> >  		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> > -	} else if (msg->result == EC_RES_INVALID_VERSION) {
> > -		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
> > -			msg->result);
> > -		return -ENOTSUPP;
> >  	} else if (msg->result != EC_RES_SUCCESS) {
> > -		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
> > -		return -EPROTO;
> > +		if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg->result])
> > +			ret = cros_ec_error_map[msg->result];
> > +		else
> > +			ret = -EPROTO;
> > +		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n", msg->result, ret);
> >  	}
> >  
> >  	return ret;
> > 
