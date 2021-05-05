Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFF8373CE4
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 16:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhEEODI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhEEODI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 10:03:08 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976AEC06174A;
        Wed,  5 May 2021 07:02:11 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id d21so2236208oic.11;
        Wed, 05 May 2021 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VFGUpVbhSw2/apyC9vepkbb02Glfo5sSVvaD/S5XelI=;
        b=BF0reEh8p2C7kPm3xF2TxZ9/y8dDAQFHOLsKdOfzCmKkv0Q/bcGvQXH+n3kTDJy5uF
         s9jCSmcEabM2Y8AzfVZtDBWhQilY1Eo2NYBQDb7D/pK/vx2C3TqLDRXn+1eKJCP49rpo
         XlfNYvaHbFTNh4iDXprEf0kg3NuAqV95lamDDkmQLH+3gEDfVF6QqqYPQJnXqaf/jDKa
         D+UK3IE4tKidZ5ia5Al84ABtbqLt7B8B6BcrD08becofqDsBrKQDQeZO1juFoDW/6gcE
         VICDbES917LojWzvtwbIlQckaqaRmEt1VElxTM+Sb4m8ySMiuVzd/yidoKpQOp4iSviq
         flHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VFGUpVbhSw2/apyC9vepkbb02Glfo5sSVvaD/S5XelI=;
        b=pk6nS+O7KvuApX+au9OqL8zq8xF4f4O2UNcnPm2jDo5XNkLz1DKdURCzR0OBhX6dFG
         mYigTqpcd9z3YSlzx+MRMkjJ1g6Q08PslttkyRIELeKqSqdc0lPMOa1L8xyqx83oO4lr
         0gNRXRknlKwe0gpV7UKjdjbKejHW2AG2+/rxXX2/S+BMEThY6UILu/3/wp1dIoNEcGO0
         /bKUFIM/WOBZ/bS+8TBbG1ukPxGAB1fzLtthZkM8nSyekewbW4X31eC/LuPwS1LTVjWJ
         FgvnaWOHQr20lo8zLQfueICtWn1GeX1b9li0m7+46qLzvpv4Lg/QPbl9QbCaGd7rr/eb
         1xdA==
X-Gm-Message-State: AOAM533kCMgtQZWn9yq6pffQDe3jCSBmWe32gfxKpHLXnkMrJju3YaCO
        S0X/yEDMM+o2iyyFhqsYKGE=
X-Google-Smtp-Source: ABdhPJxEC7lqRByZwhnDwtCicpYXYi3RSPguymT8sqxrRM6pFIjhHauDX3g4O5qyQJV7I7xvS1v8ew==
X-Received: by 2002:a05:6808:51:: with SMTP id v17mr6982333oic.132.1620223331018;
        Wed, 05 May 2021 07:02:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15sm1494501otl.23.2021.05.05.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 07:02:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 May 2021 07:02:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 4/4] hwmon: vcnl3020: add hwmon driver for intrusion
 sensor
Message-ID: <20210505140208.GA1913659@roeck-us.net>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
 <20210430152419.261757-5-i.mikhaylov@yadro.com>
 <20210430163831.GA3163069@roeck-us.net>
 <8dbdf071f9f2041b92cabfa417487a3ec3e9647e.camel@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dbdf071f9f2041b92cabfa417487a3ec3e9647e.camel@yadro.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 04, 2021 at 10:46:53PM +0300, Ivan Mikhaylov wrote:
> On Fri, 2021-04-30 at 09:38 -0700, Guenter Roeck wrote:
> > On Fri, Apr 30, 2021 at 06:24:19PM +0300, Ivan Mikhaylov wrote:
> > > Intrusion status detection via Interrupt Status Register.
> > > 
> > > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > 
> > I think this should, if at all, be handled using the
> > iio->hwmon bridge (or, in other words, require a solution
> > which is not chip specific).
> 
> Thanks a lot for suggestion, it's actually looks what's needed here instead of
> this driver. Anyways, there is no IIO_PROXIMITY support inside supported types
> in iio_hwmon.c. Should I add additional case inside this driver for
> IIO_PROXIMITY type?
> 
> > I am also not sure if "proximity" is really appropriate to use
> > for intrusion detection in the sense of hardware monitoring.
> > This would require a proximity sensor within a chassis, which
> > would be both overkill and unlikely to happen in the real world.
> > "Intrusion", in hardware monitoring context, means "someone
> > opened the chassis", not "someone got [too] close".
> > 
> 
> I'm not sure either but it exists :) And it's exactly for this purpose:
> "someone opened the chassis", "how near/far is cover?".
> 

The cost for VCNL3020, for a full reel with 3,300 chips, is $1.17 per chip
at Mouser. A mechanical switch costs a couple of cents. A single proximity
sensor won't cover all parts of a chassis; one would likely need several
chips to be sure that are no blind spots (if that is even possible - I don't
think it is in any of my PC chassis due to mechanical limitations). This
is on top of programming, which would be sensitive to generating false
alarms (or missing alarms, for that matter). That sounds quite impractical
and expensive to me. I'd really like to see the actual use case where a
proximity sensor (or set of proximity sensors) is used for intrusion
detection in the sense of hardware monitoring - not just the technical
possibility of doing so, but an actual use case (as in "this vendor,
in this chassis, is doing it").

Thanks,
Guenter
