Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77760150F61
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 19:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgBCSbw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 13:31:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46604 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgBCSbw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2020 13:31:52 -0500
Received: by mail-qt1-f196.google.com with SMTP id e25so12195692qtr.13
        for <linux-iio@vger.kernel.org>; Mon, 03 Feb 2020 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlJt1RiO81e7P3yRWgqDnoTsmNPSDYYXglDd92vCpc0=;
        b=a60F4YUaAujZToMiPj7ZBCWk1cMWXfRWoYpvpk8FMEotfXvsHLbET07JaHiUOMni7F
         B4MHEjIc6yThMKWCm1WtSzGpUPIpaFq10iKz6c8w+23kq1d6dvF7OcoRqx+urX1iZ363
         JO1f8r1dB0rrzN4AfxmwOTQ5bfyFlsR59Q+cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlJt1RiO81e7P3yRWgqDnoTsmNPSDYYXglDd92vCpc0=;
        b=QLsWfY6hNEZycRcLtkyVlRZliZxPss9VT249D+MyqK2w9y8eE1CWX2B5aaxhgJRIQV
         QTWpRuGL2fffpDS8qjLtMiWvcPfX/o0QE6RRp2sdK8aVxRhNY/ZGY91fAD0FLpZTSAF5
         L9h3GucKIJjAL7K/NZ/tg5eIocappDC1jDwrPWjOnrbpRbYarx+W4sPmJHyXJSTvOHa7
         0TRXS8WBGZRLc6imqfMc7kwm7e44olKQg7vKbj1FdAtyHpIntB3HVwt33uogwaWpQADT
         r9e3wyOxxz2M3ATH0Jx/IAh9Is9o6nFpvppR0D8ZSk8hg7ws5KXlbvLNNDuqpaEBm2KX
         Psjw==
X-Gm-Message-State: APjAAAXYTLMTV+AY+Dbdmn2eqC0dxeYGnwaxraVGgxdkUzQIkfa03ktz
        GsncMIhfivqc1yQiWX0hoyjrSn1heAr/fCHZ77hDKA==
X-Google-Smtp-Source: APXvYqy2h6nEDah2MZvJC4JmmML6fPXzAxAdT0HN5eQTGblj5DPRfMD9eCGz4B2oy5GZa04ThR+ca0fJjWaYDQNGXro=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr24772228qtj.117.1580754711280;
 Mon, 03 Feb 2020 10:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20200130203106.201894-1-pmalani@chromium.org> <20200130203106.201894-11-pmalani@chromium.org>
 <20200202094342.108849ab@archlinux>
In-Reply-To: <20200202094342.108849ab@archlinux>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 3 Feb 2020 10:31:40 -0800
Message-ID: <CACeCKacjecNRnQ=YRVZjtuZvZmvd_=wd7MGb22bmWyRm8+-0oA@mail.gmail.com>
Subject: Re: [PATCH 10/17] iio: cros_ec: Use cros_ec_send_cmd_msg()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan, Thanks for the comments. Please see responses inline.

On Sun, Feb 2, 2020 at 1:43 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 30 Jan 2020 12:30:54 -0800
> Prashant Malani <pmalani@chromium.org> wrote:
>
> > Replace cros_ec_cmd_xfer_status() with cros_ec_send_cmd_msg()
> > which does the message buffer setup and cleanup.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> In a series like this, make sure that patch 1 with the actual code being
> pulled out is sent to everyone.  Looking at what we have here, this
> doesn't seem to fit well at all for one case, and I'm can't say the
> other case shows much advantage either.

Sorry about that. I'll be sure to add maintainers to Patch 1 in the
next versions.
I tried to follow : https://lwn.net/Articles/585782/ , but I think the
script might not be suited to this use case.
>
> Jonathan
>
> > ---
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 43 +++++++++----------
> >  1 file changed, 21 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 81a7f692de2f37..f92032e97a84d7 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -31,24 +31,16 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> >                                            u16 cmd_offset, u16 cmd, u32 *mask)
> >  {
> >       int ret;
> > -     struct {
> > -             struct cros_ec_command msg;
> > -             union {
> > -                     struct ec_params_get_cmd_versions params;
> > -                     struct ec_response_get_cmd_versions resp;
> > -             };
> > -     } __packed buf = {
> > -             .msg = {
> > -                     .command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> > -                     .insize = sizeof(struct ec_response_get_cmd_versions),
> > -                     .outsize = sizeof(struct ec_params_get_cmd_versions)
> > -                     },
> > -             .params = {.cmd = cmd}
> > -     };
> > -
> > -     ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> > +     struct ec_params_get_cmd_versions params = {0};
> > +     struct ec_response_get_cmd_versions resp = {0};
> > +
> > +     params.cmd = cmd;
> Use c99 element setting to set this directly rather than zeroing
> explicitly then setting the element.
>
> Something like.
>
> struct ec_params_get_cmde_versions params = {
>         .cmd = cmd;
> };
Noted.
>
> > +     ret = cros_ec_send_cmd_msg(ec_dev, 0,
> > +                                EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> > +                                &params, sizeof(params),
> > +                                &resp, sizeof(resp));
> >       if (ret >= 0)
> > -             *mask = buf.resp.version_mask;
> > +             *mask = resp.version_mask;
> >       return ret;
> >  }
> >
> > @@ -164,15 +156,22 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
> >                                u16 opt_length)
> >  {
> >       int ret;
> > +     struct cros_ec_command *msg = state->msg;
>
> With this change the code becomes less readable and needs a comment to explain
> why it is doing something odd.   Either you need to figure out how to
> make this fit properly such that the comment is not needed, or leave
> the code alone.
Noted. Perhaps we can use cros_ec_cmd_xfer() instead of
cros_ec_cmd_xfer_status(). That I think will
keep readability the same and remove the need for comments.
>
> >
> >       if (opt_length)
> > -             state->msg->insize = min(opt_length, state->ec->max_response);
> > +             msg->insize = min(opt_length, state->ec->max_response);
> >       else
> > -             state->msg->insize = state->ec->max_response;
> > +             msg->insize = state->ec->max_response;
> >
> > -     memcpy(state->msg->data, &state->param, sizeof(state->param));
> > -
> > -     ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> > +     /*
> > +      * In order to not disrupt the usage of struct cros_ec_command *msg,
> > +      * which is defined higher up in the call stack, we pass in its
> > +      * members to cros_ec_send_cmd_msg, instead of removing it at all
> > +      * calling locations.
> > +      */
> > +     ret = cros_ec_send_cmd_msg(state->ec, msg->version, msg->command,
> > +                                &state->param, sizeof(state->param),
> > +                                msg->data, msg->insize);
> >       if (ret < 0)
> >               return ret;
> >
>
