Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3F59951
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfF1LhO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 07:37:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53744 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF1LhO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 07:37:14 -0400
Received: from laptop (unknown [IPv6:2a01:e34:ee7d:73d0:5796:7015:7f6:aeeb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 02577285642;
        Fri, 28 Jun 2019 12:37:10 +0100 (BST)
Message-ID: <0af8a4bc994b4e90cb0d079d1c7f105dd2a60e32.camel@collabora.com>
Subject: Re: [PATCH 1/2] iio: common: cros_ec_sensors: determine protocol
 version
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     kernel@collabora.com, Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>
Date:   Fri, 28 Jun 2019 13:37:07 +0200
In-Reply-To: <CAPUE2ut=imx=mhV_iyMwaYmfkFJ0zw3Jvsbxf+TbfqV1Sa_WJw@mail.gmail.com>
References: <cover.1561642224.git.fabien.lahoudere@collabora.com>
         <4724b46665d919cae0ea3b60e334053b0b17d686.1561642224.git.fabien.lahoudere@collabora.com>
         <f8df78b4-8ae9-f292-cf70-ef682a4a47f4@collabora.com>
         <CAPUE2ut=imx=mhV_iyMwaYmfkFJ0zw3Jvsbxf+TbfqV1Sa_WJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le jeudi 27 juin 2019 à 14:59 -0700, Gwendal Grignou a écrit :
> On Thu, Jun 27, 2019 at 8:59 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> > Hi,
> > 
> > cc'ing Doug, Gwendal and Enrico that might be interested to give a
> > review.
> > 
> > This patch can be picked alone without 2/2, an is needed to have
> > cros-ec-sensors
> > legacy support on ARM (see [1] and [2])
> > 
> > Jonathan, as [1] and [2] will go through the chrome-platform tree
> > if you don't
> > mind I'd also like to carry with this patch once you're fine with
> > it.
> > 
> > Thanks,
> > ~ Enric
> > 
> > [1] https://patchwork.kernel.org/patch/11014329/
> > [2] https://patchwork.kernel.org/patch/11014327/
> > 
> > On 27/6/19 16:04, Fabien Lahoudere wrote:
> > > This patch adds a function to determine which version of the
> > > protocol is used to communicate with EC.
> > > 
> > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> > 
> > Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> > > ---
> > >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 36
> > > ++++++++++++++++++-
> > >  1 file changed, 35 insertions(+), 1 deletion(-)
> > > 
> > > diff --git
> > > a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > index 130362ca421b..2e0f97448e64 100644
> > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > @@ -25,6 +25,31 @@ static char *cros_ec_loc[] = {
> > >       [MOTIONSENSE_LOC_MAX] = "unknown",
> > >  };
> > > 
> > > +static int cros_ec_get_host_cmd_version_mask(struct
> > > cros_ec_device *ec_dev,
> > > +                                          u16 cmd_offset, u16
> > > cmd, u32 *mask)
> > > +{
> > > +     int ret;
> > > +     struct {
> > > +             struct cros_ec_command msg;
> > > +             union {
> > > +                     struct ec_params_get_cmd_versions params;
> > > +                     struct ec_response_get_cmd_versions resp;
> > > +             };
> > > +     } __packed buf = {
> > > +             .msg = {
> add
> .version = 0,
> As the variable is coming from the stack, the version should be set.
> > > +                     .command = EC_CMD_GET_CMD_VERSIONS +
> > > cmd_offset,
> > > +                     .insize = sizeof(struct
> > > ec_response_get_cmd_versions),
> > > +                     .outsize = sizeof(struct
> > > ec_params_get_cmd_versions)
> > > +                     },
> > > +             .params = {.cmd = cmd}
> > > +     };
> > > +
> > > +     ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> > > +     if (ret >= 0)
> It should be > 0: when the command is a success, it returns the
> number
> of byte in the response buffer. When don't expect == 0  here, because
> when successful, EC_CMD_GET_CMD_VERSIONS will return a mask.
> > > +             *mask = buf.resp.version_mask;
> > > +     return ret;
> > > +}
> > > +
> > >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> > >                             struct iio_dev *indio_dev,
> > >                             bool physical_device)
> > > @@ -33,6 +58,8 @@ int cros_ec_sensors_core_init(struct
> > > platform_device *pdev,
> > >       struct cros_ec_sensors_core_state *state =
> > > iio_priv(indio_dev);
> > >       struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
> > >       struct cros_ec_sensor_platform *sensor_platform =
> > > dev_get_platdata(dev);
> > > +     u32 ver_mask;
> > > +     int ret;
> > > 
> > >       platform_set_drvdata(pdev, indio_dev);
> > > 
> > > @@ -47,8 +74,15 @@ int cros_ec_sensors_core_init(struct
> > > platform_device *pdev,
> > > 
> > >       mutex_init(&state->cmd_lock);
> > > 
> > > +     ret = cros_ec_get_host_cmd_version_mask(state->ec,
> > > +                                             ec->cmd_offset,
> > > +                                             EC_CMD_MOTION_SENSE
> > > _CMD,
> > > +                                             &ver_mask);
> > > +     if (ret < 0)
> Use:
> if (ret <= 0 || ver_mask == 0) {
> In case the EC is really old or misbehaving, we don't want to set an
> invalid version later.

To not return a positive value on error if ret >= 0 and ver_mask = 0  
I would prefer this:

	if (ret <= 0)
		return ret;

	if (ver_mask == 0)
		return -EIO;

Let me know if I am wrong

> > > +             return ret;
> > > +
> > >       /* Set up the host command structure. */
> > > -     state->msg->version = 2;
> > > +     state->msg->version = fls(ver_mask) - 1;;
> > >       state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec-
> > > >cmd_offset;
> > >       state->msg->outsize = sizeof(struct
> > > ec_params_motion_sense);
> > > 
> > > 

