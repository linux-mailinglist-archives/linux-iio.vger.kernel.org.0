Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD256959A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 01:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiGFXFa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jul 2022 19:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiGFXF3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jul 2022 19:05:29 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0684827FD5
        for <linux-iio@vger.kernel.org>; Wed,  6 Jul 2022 16:05:29 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n74so56108yba.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Jul 2022 16:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2exSkh2yGhKnkqwDYBJbAtduzdeOqtY6/Feeg62tAwg=;
        b=knOe7XhzEMdFFG1x9iJPRizUV7caT6AtdaTGYfnn1zzJGIXcLCVktFA7PpFT1FQg2u
         2aVoUjb19Hwyy50qiiqudVVhfPEW3dJZq4rjLBs2GsEoqrGCyQntR7GsEMOuyRm2tmCo
         mPlOC4hNNHSyjxZkshtFZpSuuHVC34PqWO1LgdJz2hlapXac6YOOf7/fMClg3I9ixm9Q
         H2vbs4qWSX9bT8x9UBTpP6vVG6H+kHWWnUUrjrp3bqGExut+oUDsA4vVmWLFF/HP0JoM
         MjgxVd4+uzak9fXjV+yARTU9uW1qXBMuF9Sv2drzUa+kt9CzN+ce5ayJ1/SNJ11THwLY
         Sy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2exSkh2yGhKnkqwDYBJbAtduzdeOqtY6/Feeg62tAwg=;
        b=tTTvWlRsxjbvwKZDUIPtkN4v2KutL9roHwRGYOdSn00clG0YqDIy/VJonVVLh0Qq9R
         rbJe7zdHciYj0/wTR6f9fOPz+6EjPN+lvUOI8ledOBHfAgE2Cvgum3gWOKpL1nwhVRnv
         G1YrRgkTmSyEI5pj7wVhmbAA/S4/dlJCP7KO3px3sjdCOvgeSfiL4UJ/OiggYP2rwF5j
         lmd01TxIuxq+ah7ktlq7ljJPMrSP5W0QfTiIPtgRKHkEbGM6hgWFef3WDrJ790jkfxND
         eLqFpQf9RRiMQ+aVoyPm6l9p66SFDU8jyHo3XsuZqkbV3CVtfI/jzZ7/4AYKl6d7poZS
         Cx/Q==
X-Gm-Message-State: AJIora99oZ2M10KDHYzTIvVmjUr2iu+amd+zB5Seu92cnKThoZXVXnhu
        EwQUvgiMBB+pGG7fnFvnU5+yw9ugtkgmmQk8YoR6HQ==
X-Google-Smtp-Source: AGRyM1uE1XkoL9djWnEhDRERfBoX5iSXbERDyp5+IRYtmo1qecKs/NomDPPqxrEpKTIOa+E/5l5Y90GsHw/oHFPLfUU=
X-Received: by 2002:a25:6cc5:0:b0:66e:6606:74fe with SMTP id
 h188-20020a256cc5000000b0066e660674femr16353788ybc.291.1657148728207; Wed, 06
 Jul 2022 16:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de> <YqxOl8W2yzp9CcBP@smile.fi.intel.com>
 <CACRpkdbeQ_67V3jkw_-KfTwe54TxrK_LA7N8Nwj1qEpTELN9dQ@mail.gmail.com>
 <ad7e53d1bd2448b4971af65483fe3542@intel.com> <CACRpkda63TNWLdTjY+_xxXb4df4qCZi1EaXL3pXK=+Hon-0RLQ@mail.gmail.com>
 <20220705031635.GA14199@sol> <7d72f1ef363a4003b5209d68a88f30a9@intel.com>
In-Reply-To: <7d72f1ef363a4003b5209d68a88f30a9@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Jul 2022 01:05:16 +0200
Message-ID: <CACRpkdYxverx-KsG9URrh5qkEFXDknZKCE6RM555mjOuC--vMg@mail.gmail.com>
Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
To:     "Hall, Christopher S" <christopher.s.hall@intel.com>
Cc:     Kent Gibson <kent.gibson@iinet.net.au>,
        "william.gray@linaro.org" <william.gray@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 6, 2022 at 7:52 AM Hall, Christopher S
<christopher.s.hall@intel.com> wrote:

> > My first thought was that you could extend the SET_VALUES ioctl but,
> > while we have reserved space for future use in most of the ioctls it
> > turns out we overlooked sets and gets, so you would be looking at a new
> > ioctl.  And you need to keep in mind how the SET_VALUES ioctl would
> > interact with it (Linus' point).
>
> I think we worked around this in a previous patchset by disallowing
> (return error) the 'set' method. The pin/pad is assigned (by mux
> configured in BIOS) to either GPIO or Timed I/O logic and both cannot be
> used simultaneously.

And we know it will always be like that? What about other systems
that are not your specific x86 box and that go and implement this
API? I don't think this should be handled in the driver but in the
gpiolib.

> I think we could do this with a two ioctls:
>
> struct lineevent_trigger {
>         clockid_t clkid; /* We may want to select another clock */

Now you also need an ioctl to list the available clock IDs and
possibly their characteristics. Userspace can't just assume things
here.

>         struct timespec trigger;
> } ltrig_spec;

You also need to specify which event you are triggering, right?
If it is a rising edge or a falling edge. I suspect you can just reuse
the event IDs from the existing incoming events:

/**
 * enum gpio_v2_line_event_id - &struct gpio_v2_line_event.id values
 * @GPIO_V2_LINE_EVENT_RISING_EDGE: event triggered by a rising edge
 * @GPIO_V2_LINE_EVENT_FALLING_EDGE: event triggered by a falling edge
 */
enum gpio_v2_line_event_id {
        GPIO_V2_LINE_EVENT_RISING_EDGE  = 1,
        GPIO_V2_LINE_EVENT_FALLING_EDGE = 2,
};

This is a simple __u32 id; in the ioctl struct.

> struct lineevent_trigger_periodic {
>         clockid_t clkid;
>         struct timespec trigger;
>         struct timespec period;
> } ltrig_spec;

Needs the same things as above, but I'm sceptical about this one.
To me it seems like some fancy clock divider and then it should just
use the clk framework, I think I already remarked on this.

How is a periodic trigger with 50/50 duty cycle that cannot be changed
and derived from a certain clock different from a good old clock divider?
Externally routed clocks and clock dividers are not new.

I don't see what business this has in the GPIO library other than that
some hardware designer put these things together.

This would be relevant if you could set the duration of the pulse train,
such as "send 50 pulses then stop", so it can be used for things
such as stepper motors but apparently it can't? Especially not with
this ABI.

Yours,
Linus Walleij
