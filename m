Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61BFD16B72B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 02:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgBYB1C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Feb 2020 20:27:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44781 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgBYB1C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2020 20:27:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so4784972plo.11
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2020 17:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tXtCRq6N50TMVHBgGX7wVHtQFncGCBj7Je/zO9FJX0E=;
        b=RUqKHO73+u5YoiIoWgGGDqR9gEZ1CQOlfWYfH9fub5W4NVGh2fjjoxumHjE6fDkfKk
         Xu8gk0Dn1v3vw6yoem0PG1HCste03F0tnFahYu1KCNviPSmts6+CakN/4FHRV48cSx3h
         hk900b2chyn0e5DQ+ngn4sKqTeax8tx/UfGdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tXtCRq6N50TMVHBgGX7wVHtQFncGCBj7Je/zO9FJX0E=;
        b=FBpNlDuH6FZUotXw8uheBNO/1NBIetLvCly3X/tJeJv/nOAeVpdfE9ayWuIlSIECGW
         6C1qHGQdSryTvTEQNtfC4XNv0JUwCTIN/s77M+z45Vq67zJMiohAfeOyg57bBdVp5gwP
         DFcxWm2EVAzQ/0jTIqcjTp25j04JQM40slFwl2iAL1y0OWDY37ssjdOMoeUb1uucrw88
         mQbWfnbvIU/YPrFJlTSNeHGFK9AVbNvRPciHx9AxOR0iHxpWk67TDPA9cYEH4Ahn6qLd
         TGNqVF9BAAXjS9I+ED8MRdDYuT5K92gEfgi/iSOX2TrKQRBrcnKZ8yoRmwfc6RqghBLq
         MkHg==
X-Gm-Message-State: APjAAAU0Q8590r6OLnQefWBKLWYRMsrVk/H59ZOdq6Pq84TVzEPB/rq4
        ar6JzhFW9BP8tZmEyJfvjQRo/A==
X-Google-Smtp-Source: APXvYqzTo6wv4ZlB7haxfVEzTLEqXbypHLZ9mkpUtmaqyVn1c9X3k2XK/IQaCoJdpzy4TasArkRjVw==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr2174890pjt.67.1582594021382;
        Mon, 24 Feb 2020 17:27:01 -0800 (PST)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id 196sm14604143pfy.86.2020.02.24.17.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 17:27:00 -0800 (PST)
Date:   Mon, 24 Feb 2020 17:26:58 -0800
From:   Prashant Malani <pmalani@chromium.org>
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
Subject: Re: [PATCH v2 10/17] iio: cros_ec: Use cros_ec_cmd()
Message-ID: <20200225012658.GB11971@google.com>
References: <20200205190028.183069-1-pmalani@chromium.org>
 <20200205190028.183069-11-pmalani@chromium.org>
 <20200206121753.7b809631@archlinux>
 <671a55aa-1e5e-4e21-4a62-55db4dee368a@collabora.com>
 <CACeCKad4zp9O7WAPu5S1rmUDwkzWLjk_1i7YtPvXUG=nDvkYAA@mail.gmail.com>
 <CAPUE2usO-Ny61+wEdTcwR3b+RgGjeQ4Jb24UeF8siscqFQ5ogQ@mail.gmail.com>
 <2ebc4e17-df7a-d5c2-f657-16d06e402bd4@collabora.com>
 <CACeCKafG35Di+SU2i=DD09tUyFvq0wyDOLj5J1fUhnds3bTeDg@mail.gmail.com>
 <20200218183004.GA184561@google.com>
 <3e6c4ffc-5f7d-7b25-0a5a-d293fa6dd4d4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6c4ffc-5f7d-7b25-0a5a-d293fa6dd4d4@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 20, 2020 at 05:07:00PM +0100, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> Could you base your next series on top of [1]. Also, if you can give your
> feedback and test those, would be much appreciated ;-)

Sure Enric, I will attempt to rebase on top of [1] this week. I'll
update you once this is done. Thanks!

-Prashant
> 
> BTW, I think you need to fix your sendmail as the series are not threaded and
> appear as independent patches in patchwork, which is a bit hard to follow.
> 
> Thanks,
>  Enric
> 
> [1] https://lore.kernel.org/patchwork/cover/1197210/
> 
> 
> On 18/2/20 19:30, Prashant Malani wrote:
> > Hi All,
> > 
> > Just thought I'd ping this thread since it's been a week since the last
> > email.
> > 
> > On Mon, Feb 10, 2020 at 12:14:01PM -0800, Prashant Malani wrote:
> >> Hi All (trimming most code parts of the thread for the sake of brevity),
> >>
> >> Thanks for listing the points Enric, Please see my notes inline:
> >>
> >> On Mon, Feb 10, 2020 at 3:03 AM Enric Balletbo i Serra
> >> <enric.balletbo@collabora.com> wrote:
> >>>
> >>> Hi Gwendal, Prashant et all
> >>>
> >>> On 7/2/20 19:47, Gwendal Grignou wrote:
> >>>> On Thu, Feb 6, 2020 at 10:50 AM Prashant Malani <pmalani@chromium.org> wrote:
> >>>>>
> >>>>> Hi Enric,
> >>>>>
> >>>>> Thanks for taking a look at the patch. Please see my response inline:
> >> ....
> >>>>>>>> @@ -171,9 +162,11 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
> >>>>>>>>
> >>>>>>>>      memcpy(state->msg->data, &state->param, sizeof(state->param));
> >>>>>>>>
> >>>>>>>> -    ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> >>>>>>>> +    ret = cros_ec_cmd_xfer(state->ec, state->msg);
> >>>>>>>>      if (ret < 0)
> >>>>>>>>              return ret;
> >>>>>>>> +    else if (state->msg->result != EC_RES_SUCCESS)
> >>>>>>>> +            return -EPROTO;
> >>>>>>>>
> >>>>>>
> >>>>>> There is no way to use the new cros_ec_cmd here?
> >>>> When the EC does not support sensor fifo,
> >>>> cros_ec_motion_send_host_cmd() is on the data path. For instance, it
> >>>> is called 2 times every 10ms by chrome to calculate the lid angle. I
> >>>> would be reluctant to call malloc. Given it is well encapsulated into
> >>>> the sensor stack. Does it make sense to call cros_ec_cmd_xfer
> >>>> directly?
> >>>>
> >>>
> >>> Thanks Gwendal for pointing this, it makes totally sense, and I suspect this can
> >>> happen on other cases.
> >>>
> >>> Just to make clear, my concern is not about not using the new 'cros_ec_cmd'
> >>> here, is about changing 'cros_ec_cmd_xfer_status' for 'cros_ec_cmd_xfer'. Also,
> >>> my other concern is how useful is the new 'cros_ec_cmd' replacing what we have
> >>> now if cannot replace all current uses.
> >>>
> >>> My points of view are this:
> >>>
> >>> * Actually we have cros_ec_cmd_xfer and cros_ec_cmd_xfer_status, use the second
> >>> one is better, in fact, we tried to move all the cros_ec_cmd_xfer to the _status
> >>> version in the past because makes the code and error handling cleaner. So I'm
> >>> reticent to get back to use cros_ec_cmd_xfer instead of cros_ec_cmd_xfer_status.
> >>>
> >>> * The users of the cros-ec protocol sometimes they mallocing/freeing at runtime,
> >>> and sometimes they don't. IMHO *non* mallocing/freeing is usually better, more
> >>> efficient and faster. Would be nice to standardize this.
> >>
> >> I think we should look at latency (I am assuming that is one of the
> >> concerns Gwendal was referring to).
> >> We should certainly do more rigorous measurements, but I did a crude
> >> measurement across a devm_kzalloc() used on one of the EC commands
> >> inside platform/chrome for struct EC command:
> >> - Used ktime_get_ns() to record time before and after the devm_kzalloc()
> >> - Used ktime_sub to subtract the "after" and "before" values:
> >>
> >>         struct cros_ec_command *msg;
> >>         int ret;
> >> +       ktime_t start, end, diff;
> >>
> >> +       start = ktime_get_ns();
> >>         msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> >> +       end = ktime_get_ns();
> >>         if (!msg)
> >>                 return -ENOMEM;
> >>
> >> +       diff = ktime_sub(end, start);
> >> +       printk("%s(): TEST: kzalloc took: %lld\n", __func__, ktime_to_ns(diff));
> >>
> >> On an i5 1.6 GHz system, across 16 call measurements I got the
> >> following latency values (in ns):
> >> - Count, N:16
> >> - Average: 72.375
> >> - Std. Dev : 28.768
> >> - Max: 143
> >> - Min:  51
> >>
> >> Are these values significant for the various call-sites? I think the
> >> driver authors might be able to comment better there (unfortunately I
> >> don't have enough context for each case).
> >> Of course there will be other overhead (memcpy) but I think this is a
> >> good starting point for the discussion.
> >> (My apologies if this measurement method is incorrect/inaccurate.)
> > 
> > Any thoughts / comments here?
> > 
> > On an overall note, I think keeping cros_ec_cmd_xfer() and cros_ec_cmd()
> > might be a good starting point.
> > 
> > In this way, we are not introducing any extra function. Also, we can
> > begin converting the cros_ec_cmd_xfer() use cases (a few call-sites may
> > need to be investigated from a latency perspective). The
> > cros_ec_cmd_xfer() conversions are better handled in separate patch
> > series.
> > 
> > Best regards,
> > 
> > -Prashant
> >>
> >>>
> >>> * If we want to introduce a new 'cros_ec_cmd', this should make the code cleaner
> >>> and ideally should be the way we tell the users they should use to communicate
> >>> with the cros-ec and not open coding constantly. Ideally, should be a
> >>> replacement of all current 'cros_ec_cmd_xfer*' versions.
> >>
> >> As I mentioned previously, I think all calls of cros_ec_cmd_xfer() can
> >> be converted to use cros_ec_cmd() (especially since the new API has a
> >> *result pointer),
> >> but I think it should be staged out a bit more (since cases like iio:
> >> cros_ec driver require non-trivial refactoring which I think is better
> >> in a patch/series).
> >>
> >>>
> >>> * If 'cros_ec_cmd' *cannot* replace all the cases, it should be clear to the
> >>> user in which cases he should use this function and in which cases shouldn't use
> >>> this function.
> >>
> >> This seems like a good compromise, but my expectation is that if there
> >> is a "fast" and "slow" version of the same functionality, developers
> >> would be inclined to use the "fast" version always?
> >>
> >>
> >>> * Finally, what pointed Gwendal, what's the best approach to send commands to
> >>> the EC by default, is better use dynamic memory? or is better use the stack? is
> >>> it always safe use the stack? is always efficient use allocated memory?
> >>>
> >>> As you can see I have a lot of questions still around, but taking in
> >>> consideration that this will be an important change I think that makes sense
> >>> spend some time discussing it.
> >>>
> >>> What do you think?
> >>>
> >>> Enric
> >>>
> >>>
> >>>> Gwendal.
> >>>>>
> >>>>> I think it is doable. From looking at the code I felt the factors we
> >>>>> need to be careful about are:
> >>>>> - The function cros_ec_motion_send_host_cmd() is called from a few
> >>>>> other files, each of which set up the struct cros_ec_command
> >>>>> differently (reference:
> >>>>> https://elixir.bootlin.com/linux/latest/ident/cros_ec_motion_send_host_cmd)
> >>>>> - It is not clear to me how readability will be affected by making the
> >>>>> change to cros_ec_cmd().
> >>>>>
> >>>>> Due to the above two factors, but primarily because I wanted to avoid
> >>>>> making such an involved large change in this 17 patch series, I
> >>>>> reasoned it would be better to make the transition to cros_ec_cmd()
> >>>>> for these files in a separate patch/series.
> >>>>> My plan after this patch series is to work on this driver(perhaps we
> >>>>> can eliminate cros_ec_motion_send_host_cmd() itself?), and then remove
> >>>>> cros_ec_cmd_xfer() usage.
> >>>>>
> >>>>> WDYT?
> >>>>>
> >>>>> Best regards,
> >>>>>
> >>>>>
> >>>>>>
> >>>>>>
> >>>>>>>>      if (ret &&
> >>>>>>>>          state->resp != (struct ec_response_motion_sense *)state->msg->data)
> >>>>>>>
