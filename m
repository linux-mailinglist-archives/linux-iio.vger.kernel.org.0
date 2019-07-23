Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D270DE0
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2019 02:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfGWAHZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 20:07:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41758 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387583AbfGWAHZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 20:07:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so18157707pff.8;
        Mon, 22 Jul 2019 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7DvfcmR3HRt1GiqujqN60j+e4zw/ET/PYxhQp6rxgDs=;
        b=b3+xWlfyRKcpjr2yqvFuIbWCx21Of3v3AmXP8+9O8O6BAL4ykDWNO02HY6JFXHS/35
         Ob/Q9KBML7qQb8A0QRMYpTTpp0LljFtTsOnph3/8qwE42SMI5ZupJg+ZZk/3LsOyPF4k
         EKtKRjSLUWuUNCorNwGR3nMDyiyTTOLzAlUJYvxhKmEqCX+zSiu1tmVla7DOYo3t8fEZ
         sOIVKyZtcC/4hdEdJvBxWXlZpLNg3eVwYlQylLAosT0E+IVN5b4OieqcX/BXG0H/WcSh
         X5RjTfiE3fJhcKv9e+RTX7jHgTX0fTDEeaTd58p9H9ZU8kEZ+dOwUgsydRkCsZvBO6XB
         l+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7DvfcmR3HRt1GiqujqN60j+e4zw/ET/PYxhQp6rxgDs=;
        b=KZPvYK7wjaO/A9LRLw8b5p8G3YvfTL3vXUSTBV4WwdMSrGmsAUF3dMdgRoN9IooDB3
         BxaVDcPJyNdrGkxXf1lZ2O39iHscLclLqHmBke8LaNFutAndSj78Q7jWD+64QPCTOME4
         PAjY8YdpbWUvBqVVphcp/IbERbErkHmLZnAs+KVb7l23BZqFJMEeG8PY8NoUIpux/cJw
         ZRSJKq8tMLBbDQfXES0puiLQjuoFGOkUIdZLnF0RGzyELzOum0kseLNEghllrGSFJ8xF
         BR11I97k9nbUQSI6dogcuehss0Cb/35ABrHFAtTZPKbVvixFbveMinHkFb7Akl79GDfn
         Ugsw==
X-Gm-Message-State: APjAAAVrGgU1BlXzO1u3nFC4LWMryvcPiQDai9uB4rZxkMy1N6GF3PCG
        5hV+yrzMoXHI9lm7KApYILI=
X-Google-Smtp-Source: APXvYqwIZuGg655vG3rjA4fQLDewJ4SVCsCKMcnNHISz9B3Dr+0SaQHIZOh++E1tBUIHGNSPlNEH7g==
X-Received: by 2002:a65:6294:: with SMTP id f20mr75862457pgv.349.1563840444268;
        Mon, 22 Jul 2019 17:07:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l31sm66492360pgm.63.2019.07.22.17.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 17:07:23 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:07:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Dirk Eibach <eibach@gdsys.de>
Subject: Re: [PATCH] hwmon: Remove ads1015 driver
Message-ID: <20190723000722.GB31309@roeck-us.net>
References: <1562004758-13025-1-git-send-email-linux@roeck-us.net>
 <20190722223944.GA9166@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722223944.GA9166@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 22, 2019 at 04:39:44PM -0600, Rob Herring wrote:
> On Mon, Jul 01, 2019 at 11:12:38AM -0700, Guenter Roeck wrote:
> > A driver for ADS1015 with more functionality is available in the iio
> > subsystem.
> > 
> > Remove the hwmon driver as duplicate. If the chip is used for hardware
> > monitoring, the iio->hwmon bridge should be used.
> > 
> > Cc: Dirk Eibach <eibach@gdsys.de>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Current plan is to queue this removal for v5.4 (not v5.3) in the hwmon
> > tree.
> > 
> >  .../devicetree/bindings/hwmon/ads1015.txt          |  73 -----
> >  .../devicetree/bindings/iio/adc/ads1015.txt        |  73 +++++
> 
> I assume no change or I should review it again?
> 
It is identical.

> Acked-by: Rob Herring <robh@kernel.org>
> 
Thanks,
Guenter

> >  Documentation/hwmon/ads1015.rst                    |  90 ------
> >  Documentation/hwmon/index.rst                      |   1 -
> >  MAINTAINERS                                        |   8 -
> >  drivers/hwmon/Kconfig                              |  10 -
> >  drivers/hwmon/Makefile                             |   1 -
> >  drivers/hwmon/ads1015.c                            | 324 ---------------------
> >  drivers/iio/adc/Kconfig                            |   2 +-
> >  9 files changed, 74 insertions(+), 508 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/hwmon/ads1015.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ads1015.txt
> >  delete mode 100644 Documentation/hwmon/ads1015.rst
> >  delete mode 100644 drivers/hwmon/ads1015.c
