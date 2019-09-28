Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFC9C123C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2019 23:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfI1VeE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Sep 2019 17:34:04 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:47082 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfI1VeD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2019 17:34:03 -0400
Received: by mail-yw1-f67.google.com with SMTP id 201so2141918ywn.13
        for <linux-iio@vger.kernel.org>; Sat, 28 Sep 2019 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=klP0d8/IOPN/GKmBdE27iCbNXKnKt8seS+HMeOtEhb8=;
        b=hJBxU82wBUdQsgVar+wsEtRKctm4XEf7IxNBfpV8GFufSbamPItp0Jem6ED27wAJnS
         zwgCI1pEpPp1Z7X6s+vuWid6QZnawTKcoMMZloAbItsLJg/uSpTdi4R95lPo4U41+98h
         G5h9+moLfcswyEgOe1s8nL58Pgv2+i/BMJGFvXNxQomkNbXvu6YWSrgdDHYfhQFjK4F+
         i7ANhgefYcIT4l4k+XOFuIBZYtxE9MTRm+tP/qoVMCeWzVR1QsB8QhZbN2d9cRYxT6PX
         6sAPkDK/QlVbi9jY5wmg9NHlXr6/anUA1qNlMC/wgO9UVtEaAxafRY4dFAyp/6sWuU7V
         9K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=klP0d8/IOPN/GKmBdE27iCbNXKnKt8seS+HMeOtEhb8=;
        b=aoHNK15s1YNcm12BYGpNbsjU49VabbgzCEvoiKlW/gJvykMjwrftVJoOit4ALgxqw1
         fYkFRolzzZHOtSzSUBjlfzhusc2Q9pItDTu5g+rEBfgrtA+4OE1SVgI0AcLnk9X90N6X
         crsJu8XJkoYaT2DwPWFgsat+Sz5RGgDt/+NPE9M/4xii3glKF2kDd2YxY1COWlXqb/36
         PLHu+apenKaZk7wQKiYmIoNM/nD33BchG0HayTxrCu8IGK9E7eJNH114est87+XfGeYm
         iJMd9z6ZBZm1akThGXHxSTJmBi4UK23YLsOfytgJZmwFA+uS4t3fLbROnxoQp0eVaLNW
         djNg==
X-Gm-Message-State: APjAAAWPAsOq+Z6Ix0Thc+nobIYa9WBWCwt73Zfk97PU5JAEVp6dirOA
        iyNstcKabXdrVg5/hhDiRl4=
X-Google-Smtp-Source: APXvYqz5FtnHQF9DYVYd5nOYjphe/EhzdvCdT/xx6ALm/5SxKPQTQ3O2ipa6gs/t0j2L1RsVutHR4g==
X-Received: by 2002:a81:178f:: with SMTP id 137mr7904983ywx.487.1569706442889;
        Sat, 28 Sep 2019 14:34:02 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g81sm1544063ywa.46.2019.09.28.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 14:34:01 -0700 (PDT)
Date:   Sat, 28 Sep 2019 17:33:48 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-iio@vger.kernel.org, jic23@jic23.retrosnub.co.uk,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP
 Encoder
Message-ID: <20190928213348.GA4693@icarus>
References: <20190917114403.GA8368@icarus>
 <20190919080305.960198-1-felipe.balbi@linux.intel.com>
 <20190919080305.960198-2-felipe.balbi@linux.intel.com>
 <20190922233538.GA3119@icarus>
 <e24965be-3b0b-7f5e-bc5b-e2fb09ce6d19@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e24965be-3b0b-7f5e-bc5b-e2fb09ce6d19@lechnology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 24, 2019 at 04:46:57PM -0500, David Lechner wrote:
> On 9/22/19 6:35 PM, William Breathitt Gray wrote:
> > On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:
> >> Add support for Intel PSE Quadrature Encoder
> >>
> >> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> >> ---
> >>
> >> Changes since v1:
> >> 	- Many more private sysfs files converted over to counter interface
> >>
> >>
> >> How do you want me to model this device's Capture Compare Mode (see
> >> below)?
> > 
> > Hi Felipe,
> > 
> > I'm CCing Fabien and David as they may be interested in the timestamps
> > discussion. See below for some ideas I have on implementing this.
> > 
> 
> Could be an interesting read (thread from my first counter driver):
> 
> https://lore.kernel.org/linux-iio/1b913919-beb9-34e7-d915-6bcc40eeee1d@lechnology.com/
> 
> What would be useful to me is something like the buffer feature in iio
> where a timestamp is associated with a count and stored in a buffer so that
> we can look at a window of all values recorded in the last 20ms. Being able
> to access this via mmap would be very helpful for performance (running on
> 300MHz ARM). Anything to do with timestamps in sysfs is probably not useful
> unless it is a rare event, like a watchdog timeout.

I'm CCing Jonathan Cameron since I'm not familiar with how IIO handles
timestamps and buffers. I don't want to reinvent something that is
working well, so hopefully we can reuse the IIO timestamp design for the
Counter subsystem.

I would argue that a human-readable timestamps printout is useful for
certain applications (e.g. a tally counter attached to a fault line: a
human administrator will be able to review previous fault times).
However as you point out, a low latency operation is necessary for
performance critical applications.

Although you are correct that mmap is a good low latency operation to
get access to a timestamp buffer, I'm afraid giving direct access to
memory like that will lead to many incompatible representations of
timestamp data (e.g. variations in endianness, signedness, data size,
etc.). I would like a standardized representation for this data that
userspace applications can expect to receive and interpret, especially
when time is widely represented as an unsigned integer.

Felipe suggested the creation of a counter_event structure so that users
can poll on an attribute. This kind of behavior is useful for notifying
users of interrupts and other events, but I think we should restrict the
use of the read call on these sysfs attributes to just human-readable
data. Instead, perhaps ioctl calls can be used to facilitate binary data
transfers.

For example, we can define a COUNTER_GET_TIMESTAMPS_IOCTL ioctl request
that returns a counter_timestamps structure with a timestamps array
populated:

        struct counter_timestamps{
                size_t num_timestamps;
        	unsigned int *timestamps;
        }

That would allow quick access to the timestamps data, while also
restricting it to a standard representation that all userspace
applications can follow and interpret. In addition, this won't interfer
with polling, so users can still wait for an interrupt and then decide
whether they want to use the slower human-readable printout (via read)
or the faster binary data access (via ioctl).

William Breathitt Gray
