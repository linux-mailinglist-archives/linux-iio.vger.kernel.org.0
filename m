Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CF5155E64
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGSr1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 13:47:27 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35990 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGSr1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2020 13:47:27 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so424153iln.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2020 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9MsQAQcEEzH1CAd4TAuwFn4Rri9pVxiX2YvDtDQNMg=;
        b=alcfltJxUHLeOXy7aVUPs/ndaolCFvJZZMbfpwc0I2TdOkKpxKp20bO90qIO317i/R
         FLuQjpayP9Jyyd3hXbgTORhN7wuQ8DDOKR2MJHexgB4ptL+p1pD19qhiU8jxkZ4OYIZ2
         zDMxLB9GQr+ePvA2QXx3H6oFH3Q7aK/BMfxzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9MsQAQcEEzH1CAd4TAuwFn4Rri9pVxiX2YvDtDQNMg=;
        b=dCN81S4yuMpAmgGOSlMe+NwGMrhl1EJXDO+7iaM735uvOvWZRHZ64x8qPFe9aKQvy3
         q4IOK57g8Y+63eCy4Dshi9g1e7dV8lSBFYBiI7t1lw0imzP2LEfwr/YCC+lFfBmlzCsT
         /WGZRPH2VgGiNGmet4U7d8u+OuDRQOOrasMb+digAfGW+Qs61AuGtD0N/poF6sMlXuSV
         Tvs9AUrQn38QZMD9XxZXx8shVVSE4pszCoPX/wuMLSYYMM8OMnd/IbiyNL19Gf5s3Zbb
         6WP0jbCIDOOBET2cRBlgjSRFY+WhCrpD/WSe7HYbaESbfqoTj9GEgU2wQOwFqR9ZERs7
         44tg==
X-Gm-Message-State: APjAAAWlGQrqqH8iHq7yFa/jX8zJp4rFgwf8MNcgB2L7OymFkKuEFK/c
        7G/Iq+S42hSnmcElWYrkgdWkiXyrj2YdQDEsS8LP+w==
X-Google-Smtp-Source: APXvYqwkaBJC+M6eP8LP4dm+tzp8gjr2ykKOn2Rbhn9endggrXK3Q9OMd7Izng9h13khUZovBYh7c4QETZE6Ypfn2dg=
X-Received: by 2002:a92:8309:: with SMTP id f9mr840293ild.50.1581101246455;
 Fri, 07 Feb 2020 10:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20200205190028.183069-1-pmalani@chromium.org> <20200205190028.183069-11-pmalani@chromium.org>
 <20200206121753.7b809631@archlinux> <671a55aa-1e5e-4e21-4a62-55db4dee368a@collabora.com>
 <CACeCKad4zp9O7WAPu5S1rmUDwkzWLjk_1i7YtPvXUG=nDvkYAA@mail.gmail.com>
In-Reply-To: <CACeCKad4zp9O7WAPu5S1rmUDwkzWLjk_1i7YtPvXUG=nDvkYAA@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 7 Feb 2020 10:47:15 -0800
Message-ID: <CAPUE2usO-Ny61+wEdTcwR3b+RgGjeQ4Jb24UeF8siscqFQ5ogQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] iio: cros_ec: Use cros_ec_cmd()
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 6, 2020 at 10:50 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Enric,
>
> Thanks for taking a look at the patch. Please see my response inline:
>
> On Thu, Feb 6, 2020 at 5:45 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi Prashant,
> >
> > On 6/2/20 13:17, Jonathan Cameron wrote:
> > > On Wed,  5 Feb 2020 11:00:13 -0800
> > > Prashant Malani <pmalani@chromium.org> wrote:
> > >
> > >> Replace cros_ec_cmd_xfer_status() with cros_ec_cmd()
> > >> which does the message buffer setup and cleanup.
> > >>
> > >> For one other usage, replace the cros_ec_cmd_xfer_status() call with a
> > >> call to cros_ec_cmd_xfer(), in preparation for the removal of the former
> > >> function.
> > >>
> > >> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > >
> > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > >> ---
> > >>
> > >> Changes in v2:
> > >> - Updated to use new function name and parameter list.
> > >> - Used C99 element setting to initialize param struct.
> > >> - For second usage, replaced cros_ec_cmd_xfer_status() with
> > >>   cros_ec_cmd_xfer() which is functionally similar.
> > >>
> > >>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 25 +++++++------------
> > >>  1 file changed, 9 insertions(+), 16 deletions(-)
> > >>
> > >> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > >> index d3a3626c7cd834..94e22e7d927631 100644
> > >> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > >> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > >> @@ -30,24 +30,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> > >>                                           u16 cmd_offset, u16 cmd, u32 *mask)
> > >>  {
> > >>      int ret;
> > >> -    struct {
> > >> -            struct cros_ec_command msg;
> > >> -            union {
> > >> -                    struct ec_params_get_cmd_versions params;
> > >> -                    struct ec_response_get_cmd_versions resp;
> > >> -            };
> > >> -    } __packed buf = {
> > >> -            .msg = {
> > >> -                    .command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> > >> -                    .insize = sizeof(struct ec_response_get_cmd_versions),
> > >> -                    .outsize = sizeof(struct ec_params_get_cmd_versions)
> > >> -                    },
> > >> -            .params = {.cmd = cmd}
> > >> +    struct ec_params_get_cmd_versions params = {
> > >> +            .cmd = cmd,
> > >>      };
> > >> +    struct ec_response_get_cmd_versions resp = {0};
> > >>
> > >> -    ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> > >> +    ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> > >> +                      &params, sizeof(params), &resp, sizeof(resp), NULL);
> > >>      if (ret >= 0)
> > >> -            *mask = buf.resp.version_mask;
> > >> +            *mask = resp.version_mask;
> > >>      return ret;
> > >>  }
> > >>
> > >> @@ -171,9 +162,11 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
> > >>
> > >>      memcpy(state->msg->data, &state->param, sizeof(state->param));
> > >>
> > >> -    ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> > >> +    ret = cros_ec_cmd_xfer(state->ec, state->msg);
> > >>      if (ret < 0)
> > >>              return ret;
> > >> +    else if (state->msg->result != EC_RES_SUCCESS)
> > >> +            return -EPROTO;
> > >>
> >
> > There is no way to use the new cros_ec_cmd here?
When the EC does not support sensor fifo,
cros_ec_motion_send_host_cmd() is on the data path. For instance, it
is called 2 times every 10ms by chrome to calculate the lid angle. I
would be reluctant to call malloc. Given it is well encapsulated into
the sensor stack. Does it make sense to call cros_ec_cmd_xfer
directly?

Gwendal.
>
> I think it is doable. From looking at the code I felt the factors we
> need to be careful about are:
> - The function cros_ec_motion_send_host_cmd() is called from a few
> other files, each of which set up the struct cros_ec_command
> differently (reference:
> https://elixir.bootlin.com/linux/latest/ident/cros_ec_motion_send_host_cmd)
> - It is not clear to me how readability will be affected by making the
> change to cros_ec_cmd().
>
> Due to the above two factors, but primarily because I wanted to avoid
> making such an involved large change in this 17 patch series, I
> reasoned it would be better to make the transition to cros_ec_cmd()
> for these files in a separate patch/series.
> My plan after this patch series is to work on this driver(perhaps we
> can eliminate cros_ec_motion_send_host_cmd() itself?), and then remove
> cros_ec_cmd_xfer() usage.
>
> WDYT?
>
> Best regards,
>
>
> >
> >
> > >>      if (ret &&
> > >>          state->resp != (struct ec_response_motion_sense *)state->msg->data)
> > >
