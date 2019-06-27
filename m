Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB80058D74
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2019 23:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfF0V7e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jun 2019 17:59:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44779 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfF0V7e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jun 2019 17:59:34 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so8124187iob.11
        for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2019 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaSEBp6Yhtxm8oRt3JYTn5K/8+0bJg82hFF0+xAXHy8=;
        b=eUeAq0DtkDIPxxvGHcp8prWEDPFYZfy5O0uXbCr+418Ik/+rKt42eqxHOpQbuYGhLt
         VDg5HT/6dbGQZL+Dinh1JXGusovtQj2FHhwx7GB0ZF5nDGqoEomfbqCBtMxOi3GDD81A
         ZpcbquExEShYsKCAdOOLauoFqte9EofLYGThQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaSEBp6Yhtxm8oRt3JYTn5K/8+0bJg82hFF0+xAXHy8=;
        b=RSCDE7VG2ZTBAgpC3FS8XvjdluKYxSMtrvvV4bECvT66M2A0OMQX68ANvLpo6O/Ggs
         8BuP9MRSMQRW0YN2BrYf0Ike64ObSx1P2IFHZbJ8oEJC+hYC1KrZwZrk2tN3EvY4rvjS
         Pu6V4/eXplj4YXLA8WlVHYloXZNKOKVQBQeMMaawEp9vstoIpt7fFBg4mfeEW3F4SA/n
         K6WN+SNEYu282IDGjXS/Ni3yd8jukgK0Q9Ch/PsNzCIaoZ5bdETxaw/JGSooYnGSFPNy
         FD2uaForgGusKkTTqnVeS9P+F/pVMirZWL63eJl19kHVoUPGsIBLKnE3YX7XslbRrKhy
         oV0Q==
X-Gm-Message-State: APjAAAURHMcvA1V1hBO92ypjsNC1chy3u7Utb9iR3zILGNkQI3iiZmkY
        OdbhzouPdQhqhamE0Oa3fMher1EloQ5+7zfFS3f+6Q==
X-Google-Smtp-Source: APXvYqyKad9J3h3Dp8aw2zqC6WqVToenx5Jd5isuEZnDmtZ57r14RAxzm8lwfP0NOAQnUQ1zG9fLHCzhCPO6+LfIXUA=
X-Received: by 2002:a6b:8f93:: with SMTP id r141mr7315209iod.145.1561672773497;
 Thu, 27 Jun 2019 14:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561642224.git.fabien.lahoudere@collabora.com>
 <4724b46665d919cae0ea3b60e334053b0b17d686.1561642224.git.fabien.lahoudere@collabora.com>
 <f8df78b4-8ae9-f292-cf70-ef682a4a47f4@collabora.com>
In-Reply-To: <f8df78b4-8ae9-f292-cf70-ef682a4a47f4@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 27 Jun 2019 14:59:22 -0700
Message-ID: <CAPUE2ut=imx=mhV_iyMwaYmfkFJ0zw3Jvsbxf+TbfqV1Sa_WJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: common: cros_ec_sensors: determine protocol version
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        kernel@collabora.com, Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 27, 2019 at 8:59 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> cc'ing Doug, Gwendal and Enrico that might be interested to give a review.
>
> This patch can be picked alone without 2/2, an is needed to have cros-ec-sensors
> legacy support on ARM (see [1] and [2])
>
> Jonathan, as [1] and [2] will go through the chrome-platform tree if you don't
> mind I'd also like to carry with this patch once you're fine with it.
>
> Thanks,
> ~ Enric
>
> [1] https://patchwork.kernel.org/patch/11014329/
> [2] https://patchwork.kernel.org/patch/11014327/
>
> On 27/6/19 16:04, Fabien Lahoudere wrote:
> > This patch adds a function to determine which version of the
> > protocol is used to communicate with EC.
> >
> > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> > ---
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 36 ++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 130362ca421b..2e0f97448e64 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -25,6 +25,31 @@ static char *cros_ec_loc[] = {
> >       [MOTIONSENSE_LOC_MAX] = "unknown",
> >  };
> >
> > +static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> > +                                          u16 cmd_offset, u16 cmd, u32 *mask)
> > +{
> > +     int ret;
> > +     struct {
> > +             struct cros_ec_command msg;
> > +             union {
> > +                     struct ec_params_get_cmd_versions params;
> > +                     struct ec_response_get_cmd_versions resp;
> > +             };
> > +     } __packed buf = {
> > +             .msg = {
add
.version = 0,
As the variable is coming from the stack, the version should be set.
> > +                     .command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> > +                     .insize = sizeof(struct ec_response_get_cmd_versions),
> > +                     .outsize = sizeof(struct ec_params_get_cmd_versions)
> > +                     },
> > +             .params = {.cmd = cmd}
> > +     };
> > +
> > +     ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> > +     if (ret >= 0)
It should be > 0: when the command is a success, it returns the number
of byte in the response buffer. When don't expect == 0  here, because
when successful, EC_CMD_GET_CMD_VERSIONS will return a mask.
> > +             *mask = buf.resp.version_mask;
> > +     return ret;
> > +}
> > +
> >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                             struct iio_dev *indio_dev,
> >                             bool physical_device)
> > @@ -33,6 +58,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >       struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> >       struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
> >       struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> > +     u32 ver_mask;
> > +     int ret;
> >
> >       platform_set_drvdata(pdev, indio_dev);
> >
> > @@ -47,8 +74,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >
> >       mutex_init(&state->cmd_lock);
> >
> > +     ret = cros_ec_get_host_cmd_version_mask(state->ec,
> > +                                             ec->cmd_offset,
> > +                                             EC_CMD_MOTION_SENSE_CMD,
> > +                                             &ver_mask);
> > +     if (ret < 0)
Use:
if (ret <= 0 || ver_mask == 0) {
In case the EC is really old or misbehaving, we don't want to set an
invalid version later.
> > +             return ret;
> > +
> >       /* Set up the host command structure. */
> > -     state->msg->version = 2;
> > +     state->msg->version = fls(ver_mask) - 1;;
> >       state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> >       state->msg->outsize = sizeof(struct ec_params_motion_sense);
> >
> >
