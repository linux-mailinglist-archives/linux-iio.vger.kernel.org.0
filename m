Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF01158428
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 21:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBJUON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 15:14:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41714 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgBJUON (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 15:14:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so5441062qtr.8
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2020 12:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOMDnWavIn15dDLzVnJqPByv88cNrnShVSn42nE2Ul4=;
        b=HQ2foQgsPGuH93b0J3aA0JfgOaRBI95d2lPmnuULyLqjd501YRWEF2cEAH2gDIyYJn
         T9TiziE/h8jicdzpAIAFZzer7hMgD2paePNC0WP6deD5xT8/TVaKaOMcmxX5R4z7rq41
         mDKYg7f30ystPbsgrSGG1jbhd3N26mpkisLo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOMDnWavIn15dDLzVnJqPByv88cNrnShVSn42nE2Ul4=;
        b=YoRlXF7sbrOLWWkTu2/suVWBG5ETty3Vb0lN6Dk3Bukc7WojZGbjMfnrZJyLVSLMxf
         /C6zl3S9du3nxVWcxx2yKvY5BLJzfOE2tWXJMh+Se+1NWKCDNKgFho3aDfE5vAA1x/US
         eD9kuFha6QUpOkvpmCRLKe73yVd8h8Jl6vq9cvry0ChRVyBQ3jX2kZ5RO0UfF61/ziW/
         uA5559e4lhyj+dZI3482wZLYnEPPre+OMQNc/VUnur1zIjcIyWIHEb+rqb9dvE53yUKL
         1qDXKxLSxJO0wAZGK92br9uCRZdl0DRZaweILoFM/2wH4gO+J5Bc+WNb7RRqq1uF9fVA
         IOog==
X-Gm-Message-State: APjAAAWWlbkMg1Aw2oAo359VruLyPEIxndDfW8G00l8JnCU70ElVjZG+
        3PPfUNzBDSRGKxN/hWlomAyroyDwBGHjh+KIL7ECoA==
X-Google-Smtp-Source: APXvYqxHtFTIxiqMhf3eBXEYmAHwMXyMZm/cUSbfieBcuA6QYCTh8X6r0WUL43Mtoz3hz7iK4koxYiYeWIDtp5knvtA=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr11556042qtj.117.1581365651838;
 Mon, 10 Feb 2020 12:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20200205190028.183069-1-pmalani@chromium.org> <20200205190028.183069-11-pmalani@chromium.org>
 <20200206121753.7b809631@archlinux> <671a55aa-1e5e-4e21-4a62-55db4dee368a@collabora.com>
 <CACeCKad4zp9O7WAPu5S1rmUDwkzWLjk_1i7YtPvXUG=nDvkYAA@mail.gmail.com>
 <CAPUE2usO-Ny61+wEdTcwR3b+RgGjeQ4Jb24UeF8siscqFQ5ogQ@mail.gmail.com> <2ebc4e17-df7a-d5c2-f657-16d06e402bd4@collabora.com>
In-Reply-To: <2ebc4e17-df7a-d5c2-f657-16d06e402bd4@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 10 Feb 2020 12:14:01 -0800
Message-ID: <CACeCKafG35Di+SU2i=DD09tUyFvq0wyDOLj5J1fUhnds3bTeDg@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] iio: cros_ec: Use cros_ec_cmd()
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
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

Hi All (trimming most code parts of the thread for the sake of brevity),

Thanks for listing the points Enric, Please see my notes inline:

On Mon, Feb 10, 2020 at 3:03 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal, Prashant et all
>
> On 7/2/20 19:47, Gwendal Grignou wrote:
> > On Thu, Feb 6, 2020 at 10:50 AM Prashant Malani <pmalani@chromium.org> wrote:
> >>
> >> Hi Enric,
> >>
> >> Thanks for taking a look at the patch. Please see my response inline:
....
> >>>>> @@ -171,9 +162,11 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
> >>>>>
> >>>>>      memcpy(state->msg->data, &state->param, sizeof(state->param));
> >>>>>
> >>>>> -    ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> >>>>> +    ret = cros_ec_cmd_xfer(state->ec, state->msg);
> >>>>>      if (ret < 0)
> >>>>>              return ret;
> >>>>> +    else if (state->msg->result != EC_RES_SUCCESS)
> >>>>> +            return -EPROTO;
> >>>>>
> >>>
> >>> There is no way to use the new cros_ec_cmd here?
> > When the EC does not support sensor fifo,
> > cros_ec_motion_send_host_cmd() is on the data path. For instance, it
> > is called 2 times every 10ms by chrome to calculate the lid angle. I
> > would be reluctant to call malloc. Given it is well encapsulated into
> > the sensor stack. Does it make sense to call cros_ec_cmd_xfer
> > directly?
> >
>
> Thanks Gwendal for pointing this, it makes totally sense, and I suspect this can
> happen on other cases.
>
> Just to make clear, my concern is not about not using the new 'cros_ec_cmd'
> here, is about changing 'cros_ec_cmd_xfer_status' for 'cros_ec_cmd_xfer'. Also,
> my other concern is how useful is the new 'cros_ec_cmd' replacing what we have
> now if cannot replace all current uses.
>
> My points of view are this:
>
> * Actually we have cros_ec_cmd_xfer and cros_ec_cmd_xfer_status, use the second
> one is better, in fact, we tried to move all the cros_ec_cmd_xfer to the _status
> version in the past because makes the code and error handling cleaner. So I'm
> reticent to get back to use cros_ec_cmd_xfer instead of cros_ec_cmd_xfer_status.
>
> * The users of the cros-ec protocol sometimes they mallocing/freeing at runtime,
> and sometimes they don't. IMHO *non* mallocing/freeing is usually better, more
> efficient and faster. Would be nice to standardize this.

I think we should look at latency (I am assuming that is one of the
concerns Gwendal was referring to).
We should certainly do more rigorous measurements, but I did a crude
measurement across a devm_kzalloc() used on one of the EC commands
inside platform/chrome for struct EC command:
- Used ktime_get_ns() to record time before and after the devm_kzalloc()
- Used ktime_sub to subtract the "after" and "before" values:

        struct cros_ec_command *msg;
        int ret;
+       ktime_t start, end, diff;

+       start = ktime_get_ns();
        msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
+       end = ktime_get_ns();
        if (!msg)
                return -ENOMEM;

+       diff = ktime_sub(end, start);
+       printk("%s(): TEST: kzalloc took: %lld\n", __func__, ktime_to_ns(diff));

On an i5 1.6 GHz system, across 16 call measurements I got the
following latency values (in ns):
- Count, N:16
- Average: 72.375
- Std. Dev : 28.768
- Max: 143
- Min:  51

Are these values significant for the various call-sites? I think the
driver authors might be able to comment better there (unfortunately I
don't have enough context for each case).
Of course there will be other overhead (memcpy) but I think this is a
good starting point for the discussion.
(My apologies if this measurement method is incorrect/inaccurate.)

>
> * If we want to introduce a new 'cros_ec_cmd', this should make the code cleaner
> and ideally should be the way we tell the users they should use to communicate
> with the cros-ec and not open coding constantly. Ideally, should be a
> replacement of all current 'cros_ec_cmd_xfer*' versions.

As I mentioned previously, I think all calls of cros_ec_cmd_xfer() can
be converted to use cros_ec_cmd() (especially since the new API has a
*result pointer),
but I think it should be staged out a bit more (since cases like iio:
cros_ec driver require non-trivial refactoring which I think is better
in a patch/series).

>
> * If 'cros_ec_cmd' *cannot* replace all the cases, it should be clear to the
> user in which cases he should use this function and in which cases shouldn't use
> this function.

This seems like a good compromise, but my expectation is that if there
is a "fast" and "slow" version of the same functionality, developers
would be inclined to use the "fast" version always?


> * Finally, what pointed Gwendal, what's the best approach to send commands to
> the EC by default, is better use dynamic memory? or is better use the stack? is
> it always safe use the stack? is always efficient use allocated memory?
>
> As you can see I have a lot of questions still around, but taking in
> consideration that this will be an important change I think that makes sense
> spend some time discussing it.
>
> What do you think?
>
> Enric
>
>
> > Gwendal.
> >>
> >> I think it is doable. From looking at the code I felt the factors we
> >> need to be careful about are:
> >> - The function cros_ec_motion_send_host_cmd() is called from a few
> >> other files, each of which set up the struct cros_ec_command
> >> differently (reference:
> >> https://elixir.bootlin.com/linux/latest/ident/cros_ec_motion_send_host_cmd)
> >> - It is not clear to me how readability will be affected by making the
> >> change to cros_ec_cmd().
> >>
> >> Due to the above two factors, but primarily because I wanted to avoid
> >> making such an involved large change in this 17 patch series, I
> >> reasoned it would be better to make the transition to cros_ec_cmd()
> >> for these files in a separate patch/series.
> >> My plan after this patch series is to work on this driver(perhaps we
> >> can eliminate cros_ec_motion_send_host_cmd() itself?), and then remove
> >> cros_ec_cmd_xfer() usage.
> >>
> >> WDYT?
> >>
> >> Best regards,
> >>
> >>
> >>>
> >>>
> >>>>>      if (ret &&
> >>>>>          state->resp != (struct ec_response_motion_sense *)state->msg->data)
> >>>>
