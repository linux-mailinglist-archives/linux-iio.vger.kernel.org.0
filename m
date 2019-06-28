Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E5C5A1A9
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfF1RBt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 13:01:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45321 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfF1RBs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 13:01:48 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so13921138ioc.12
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2019 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jekRiyXby/ZNHvnRLwy0otLYNAMVnEOWk6Q0hHIP03c=;
        b=jDt+2wbFWKv8S3taFNa0rh6QRpyE8hsvXmRKA4qfFd0xOFZys/zV0ydUWASnn5WEtV
         XrYg+yEJqyLK1upIptYifp2BuG9RyYoYKsjaH0agWUPYOU6azmWCKyq1jnnDT1cPMyKs
         j0BgnApGi3Taf8xfEHeZAUGEtyw2dLpjg5TdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jekRiyXby/ZNHvnRLwy0otLYNAMVnEOWk6Q0hHIP03c=;
        b=H3FJZwCQEKPzkPIB+6VUZaTByEkA/mvKiZRs5yQqVHDAvCQGsGb+Xa1U3rCGjSNIU8
         +1xh+OPsccmrWLxJDC2ANV2MKN+fMzV4/InMk+zx8CKQVXw1zStgM8A6Oc3fVVkZxOGL
         VHTOHJCD6h8JpfrbEhSeLmBRZn4cD+nXaTOJHYOVS+kvnRQU8YdFe0r0MYDXROZ8GTha
         7q6QDr8Djxat5/ZLkYuRLiKkajhfhCmb7lCmtIpfRL05UPqW/wJSqtJU8MrKGGEeZnS9
         L0eQFbezLX5iZb7yq+uNr3stBz8dRtNSC7vkmPUmW3g+CfY+QpogM93hM1XYCABqtlPZ
         /aEQ==
X-Gm-Message-State: APjAAAWxEWN79WmtAXAEo/oj2hKuP0Y/R5543u08UTsD74+3snuNiRJt
        e084ypxle5utUL+z9NzaVzJjdfOzHzshGI56L50vPQ==
X-Google-Smtp-Source: APXvYqzpL9wAKentjGIEFBMqJlm2688B0OlFLpgqBB54Jf+U1HvM6TgX+N4wFeX3Jf4VseQEvxKVUtv0sk3OftZQSss=
X-Received: by 2002:a5e:8518:: with SMTP id i24mr11744200ioj.149.1561741307842;
 Fri, 28 Jun 2019 10:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561642224.git.fabien.lahoudere@collabora.com>
 <4724b46665d919cae0ea3b60e334053b0b17d686.1561642224.git.fabien.lahoudere@collabora.com>
 <f8df78b4-8ae9-f292-cf70-ef682a4a47f4@collabora.com> <CAPUE2ut=imx=mhV_iyMwaYmfkFJ0zw3Jvsbxf+TbfqV1Sa_WJw@mail.gmail.com>
 <0af8a4bc994b4e90cb0d079d1c7f105dd2a60e32.camel@collabora.com> <b0820d4d-fe21-95bc-fde6-08613a33525b@collabora.com>
In-Reply-To: <b0820d4d-fe21-95bc-fde6-08613a33525b@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 28 Jun 2019 10:01:36 -0700
Message-ID: <CAPUE2uvRPPEgiCwQc=Qf8aOMo8c6+J4p-dL8Sm0FVLB39Kf9TQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 28, 2019 at 6:46 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Fabien, Gwendal,
>
> On 28/6/19 13:37, Fabien Lahoudere wrote:
> > Le jeudi 27 juin 2019 =C3=A0 14:59 -0700, Gwendal Grignou a =C3=A9crit =
:
> >> On Thu, Jun 27, 2019 at 8:59 AM Enric Balletbo i Serra
> >> <enric.balletbo@collabora.com> wrote:
> >>> Hi,
> >>>
> >>> cc'ing Doug, Gwendal and Enrico that might be interested to give a
> >>> review.
> >>>
> >>> This patch can be picked alone without 2/2, an is needed to have
> >>> cros-ec-sensors
> >>> legacy support on ARM (see [1] and [2])
> >>>
> >>> Jonathan, as [1] and [2] will go through the chrome-platform tree
> >>> if you don't
> >>> mind I'd also like to carry with this patch once you're fine with
> >>> it.
> >>>
> >>> Thanks,
> >>> ~ Enric
> >>>
> >>> [1] https://patchwork.kernel.org/patch/11014329/
> >>> [2] https://patchwork.kernel.org/patch/11014327/
> >>>
> >>> On 27/6/19 16:04, Fabien Lahoudere wrote:
> >>>> This patch adds a function to determine which version of the
> >>>> protocol is used to communicate with EC.
> >>>>
> >>>> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> >>>> Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> >>>
> >>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>>
> >>>> ---
> >>>>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 36
> >>>> ++++++++++++++++++-
> >>>>  1 file changed, 35 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git
> >>>> a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >>>> b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >>>> index 130362ca421b..2e0f97448e64 100644
> >>>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >>>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >>>> @@ -25,6 +25,31 @@ static char *cros_ec_loc[] =3D {
> >>>>       [MOTIONSENSE_LOC_MAX] =3D "unknown",
> >>>>  };
> >>>>
> >>>> +static int cros_ec_get_host_cmd_version_mask(struct
> >>>> cros_ec_device *ec_dev,
> >>>> +                                          u16 cmd_offset, u16
> >>>> cmd, u32 *mask)
> >>>> +{
> >>>> +     int ret;
> >>>> +     struct {
> >>>> +             struct cros_ec_command msg;
> >>>> +             union {
> >>>> +                     struct ec_params_get_cmd_versions params;
> >>>> +                     struct ec_response_get_cmd_versions resp;
> >>>> +             };
> >>>> +     } __packed buf =3D {
> >>>> +             .msg =3D {
> >> add
> >> .version =3D 0,
> >> As the variable is coming from the stack, the version should be set.
> >>>> +                     .command =3D EC_CMD_GET_CMD_VERSIONS +
> >>>> cmd_offset,
> >>>> +                     .insize =3D sizeof(struct
> >>>> ec_response_get_cmd_versions),
> >>>> +                     .outsize =3D sizeof(struct
> >>>> ec_params_get_cmd_versions)
> >>>> +                     },
> >>>> +             .params =3D {.cmd =3D cmd}
> >>>> +     };
> >>>> +
> >>>> +     ret =3D cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> >>>> +     if (ret >=3D 0)
> >> It should be > 0: when the command is a success, it returns the
> >> number
> >> of byte in the response buffer. When don't expect =3D=3D 0  here, beca=
use
> >> when successful, EC_CMD_GET_CMD_VERSIONS will return a mask.
> >>>> +             *mask =3D buf.resp.version_mask;
> >>>> +     return ret;
> >>>> +}
> >>>> +
> >>>>  int cros_ec_sensors_core_init(struct platform_device *pdev,
> >>>>                             struct iio_dev *indio_dev,
> >>>>                             bool physical_device)
> >>>> @@ -33,6 +58,8 @@ int cros_ec_sensors_core_init(struct
> >>>> platform_device *pdev,
> >>>>       struct cros_ec_sensors_core_state *state =3D
> >>>> iio_priv(indio_dev);
> >>>>       struct cros_ec_dev *ec =3D dev_get_drvdata(pdev->dev.parent);
> >>>>       struct cros_ec_sensor_platform *sensor_platform =3D
> >>>> dev_get_platdata(dev);
> >>>> +     u32 ver_mask;
> >>>> +     int ret;
> >>>>
> >>>>       platform_set_drvdata(pdev, indio_dev);
> >>>>
> >>>> @@ -47,8 +74,15 @@ int cros_ec_sensors_core_init(struct
> >>>> platform_device *pdev,
> >>>>
> >>>>       mutex_init(&state->cmd_lock);
> >>>>
> >>>> +     ret =3D cros_ec_get_host_cmd_version_mask(state->ec,
> >>>> +                                             ec->cmd_offset,
> >>>> +                                             EC_CMD_MOTION_SENSE
> >>>> _CMD,
> >>>> +                                             &ver_mask);
> >>>> +     if (ret < 0)
> >> Use:
> >> if (ret <=3D 0 || ver_mask =3D=3D 0) {
> >> In case the EC is really old or misbehaving, we don't want to set an
> >> invalid version later.
> >
> > To not return a positive value on error if ret >=3D 0 and ver_mask =3D =
0
> > I would prefer this:
> >
> >       if (ret <=3D 0)
> >               return ret;
> >
> >       if (ver_mask =3D=3D 0)
> >               return -EIO;
> >
> > Let me know if I am wrong
> >
>
> Ok, after discussing with Fabien I think I understood all this and I was
> confused. So the thing is that some very old EC sets the version_mask to =
0 and
> the communication succeeds. I think all this deserves a comment in the co=
de for
> dummies like me :-)
Looking into the code, when the command is successful, the EC would
return 4 and a valid ver_mask, otherwise ret would -EPROTO (EC answers
INVALID_PARAM).

So the original code will work as is. Thanks for your help about C
[partial] Initialization.

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>

>
> Thanks,
> ~ Enric
>
> >>>> +
>  return ret;
> >>>> +
> >>>>       /* Set up the host command structure. */
> >>>> -     state->msg->version =3D 2;
> >>>> +     state->msg->version =3D fls(ver_mask) - 1;;
> >>>>       state->msg->command =3D EC_CMD_MOTION_SENSE_CMD + ec-
> >>>>> cmd_offset;
> >>>>       state->msg->outsize =3D sizeof(struct
> >>>> ec_params_motion_sense);
> >>>>
> >>>>
> >
