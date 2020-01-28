Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B8114BDB1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1Q23 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 11:28:29 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35098 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgA1Q23 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2020 11:28:29 -0500
Received: by mail-yb1-f193.google.com with SMTP id q190so7015937ybq.2;
        Tue, 28 Jan 2020 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vWO3OeAiXfzyZ72erBieMqPl2Y7Lzm8L2Ifg8da5JF8=;
        b=rJxO2RNLPTuUjUV6vNl6RrKOgkIULVcpTeDb5UXy1n8sg8ySQOc7Za1RqxjYEtOpy1
         l+YKLwRyZRo1Kd7LIQ8FZMv93PL8prVs6LIDHAg1t61cwz2VS7EyOosBZV6B5eIW5cKq
         xZRz8k11atcP+qHTnO3OvcRwvEh4TPOV1J8cyA1QJJvTeV5uhSM3uNZ87nKXZrFH8jOI
         bI1mZ7X/4qahrKdpYcNVWVbZs+l7XApPPHhUvBsoTSdKD72z6j+uxRi6zgcYcv73lgGl
         8I5oIF0yYsh7MdHdHvpykJhyPEaK6gY5ewYAZg+oqxfyUYXFIguooTwo/A4c731Lkpo2
         3jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vWO3OeAiXfzyZ72erBieMqPl2Y7Lzm8L2Ifg8da5JF8=;
        b=QcW9gXzKCpESzobklb/s4t/LV+2CGrxxR9eKVwOrNl2diaDxee70pp45hbstQd/mHR
         TDBNBsZPHukxugYDz4W+JXaOqoetjoviWofuOsQlyDUOoCKMe990qJtW009oSkjT84p+
         UomL0u2m2wvjicVsEBXAn7xWZfUEyitolHxbm7GaCXsXjUF7NVbcoFFaQ6u7yoLD/mty
         qJcI1pgtpBuLi1/8qtJhM24uXB1hmyDFVkvoyCm4Hguj/UjqzlzX+YuQxxnuk+Fqfr1s
         LPBXRXZBr4covhEv/s4LsatzIFfYT/V/Aj7hmx24ZTikl+Mc4mHgO0/R9WUAuG7XqUCY
         fM0w==
X-Gm-Message-State: APjAAAXKUIRGSlGD4VpbcOPRK+P0VXzTG36zmF9/TDe63EuDllCYiWFn
        jKePbYinYsHWJ5x4bJKuXdI=
X-Google-Smtp-Source: APXvYqzOLkzHKv5oWgTQCM3ZnUJPrHo2htc+ZoRkBhlHJpbO8trg30c+OjsJHmcvIDqswrYLDhvi5Q==
X-Received: by 2002:a25:420c:: with SMTP id p12mr18270892yba.86.1580228907943;
        Tue, 28 Jan 2020 08:28:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x131sm662380ywd.54.2020.01.28.08.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jan 2020 08:28:27 -0800 (PST)
Date:   Tue, 28 Jan 2020 08:28:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: vcnl3020 hwmon/proximity driver
Message-ID: <20200128162825.GA3322@roeck-us.net>
References: <cb21d1285e04a8a7a3817398629431f69aeebf2f.camel@yadro.com>
 <0e2f88e3-b7d3-9dd2-50ce-011be09d53c9@roeck-us.net>
 <347fa610ef61d311486fa9eed66be3a4243a4459.camel@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347fa610ef61d311486fa9eed66be3a4243a4459.camel@yadro.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 28, 2020 at 06:31:55PM +0300, Ivan Mikhaylov wrote:
> On Tue, 2020-01-28 at 05:22 -0800, Guenter Roeck wrote:
> > On 1/28/20 3:31 AM, Ivan Mikhaylov wrote:
> > > Hello, I want to make driver for vcnl3020 but not sure where should I put
> > > it.
> > > It's similar to vcnl40xx series which is already in iio/light/vcnl4000.c
> > > but it perfectly fits with hwmon intrusion detection concept
> > > (intrusion[0-*]_alarm), so I'm a little bit confused.
> > > 
> > > vcnl3020 - proximity sensor which mostly using for intrusion detection
> > > vcnl4020 - light and proximity sensor
> > > 
> > > Doc's links:
> > > https://www.vishay.com/docs/84150/vcnl3020.pdf
> > > https://www.vishay.com/docs/83476/vcnl4020.pdf
> > > 
> > > That's what I think about possible ways:
> > > 
> > > 1. just iio/proximity/vcnl3020.c
> > > 2. extend functionality inside vcnl4000.c with ifdefs and dts stuff and
> > > maybe
> > >     rename it with generalization inside
> > > 3. hwmon driver for intrusion detection inside drivers/hwmon
> > > 4. both iio/proximity/vcnl3020.c and hwmon/vcnl3020.c
> > >     Example: hwmon/wm8350-hwmon.c + mfd/wm8350-core.c
> > >     So, just make proximity driver, do the depend in Kconfig for hwmon
> > > driver
> > >     on proximity driver and use proximity driver calls if would be needed.
> > > 
> > 
> > "intrusion" in the context of hardware monitoring is for chassis intrusion,
> > not for intrusion into an area. This driver should reside in iio.
> > 
> > Thanks,
> > Guenter
> 
> Guenter,
> that's what I meant about intrusion, sorry for being inaccurate. This proximity
> sensor can be used as chassis intrusion detector, that's why I mentioned about
> hwmon and possible interface for such thing.
> 

This is most definitely not a common use case for such a chip. Similar,
one might argue that a light sensor could be used for chassis intrusion
detection, or a movement sensor (after all, moving a chassis could be
considered "intrusion", especially if it is a server chassis). Sure,
technically one can use pretty much anything for "intrusion detection",
but it is hard to imagine this as actual use case. This is made worse by
the need for calibration - one would need to be able to determine what
exactly defines "intrusion", and that would have to be chassis or even
board specific and can not be hardcoded. This is way out of scope for
a hardware monitoring driver.

If you indeed choose such an approach in your company's systems, please
use an iio driver.

Thanks,
Guenter
