Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9431BFFF3
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD3PRh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 11:17:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38686 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgD3PRh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 11:17:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id r66so5522099oie.5;
        Thu, 30 Apr 2020 08:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fjzMhEl6DixnD6Ud42uOUBVbnbP/FrTZx3ydAp8GMlo=;
        b=n03yLGDsQZQsBhH5OzVvAILlnaN7fMlzZy7y7PCZ8pVW4aN/ZS5Z1cgEH0KtHBxOQv
         CH4DGKRsZeLS05eQF92l1Dr7FxxD60CQRaJzb+VTCYHmizIkBjD6RPdX4CQqtPLJN2tz
         zQDbnyyLN0PfxKZpcQBNVk8zZaaE8yKlpR+zc669eRk5Zo7QKojpEPztxNvUTpr3LU0x
         lqeGwPV8jtTdbiTert9Kk9JL+SSe5YeyHD88dCjMz0/xlXYLUA9tPKqds0tZcQ8U7fAS
         r5MTs6uPToG8srApwhLsae/vnZbX3p4UgZbAhfEAuKjEaphQBIf+rbzcFsnxn8Xk5oTZ
         Gycg==
X-Gm-Message-State: AGi0PuY5+wqZ9eW/XhKg9zoMUT8yLzpqRd+5h63yUBx0vuLx9Vg7EvlX
        BDPp74jGDtdk+lRo7sLM3N0vcB4=
X-Google-Smtp-Source: APiQypK3HrEOUCUWFpbmVh3vKBdCcG6lxN2kZtfNs37VzLikdReR1AP6xUZ2FEUd8hKY7izU0JcwZw==
X-Received: by 2002:aca:cf4a:: with SMTP id f71mr1985901oig.111.1588259856424;
        Thu, 30 Apr 2020 08:17:36 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g94sm42331otg.74.2020.04.30.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:17:35 -0700 (PDT)
Received: (nullmailer pid 19754 invoked by uid 1000);
        Thu, 30 Apr 2020 15:17:34 -0000
Date:   Thu, 30 Apr 2020 10:17:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Chris Ruehl <chris.ruehl@gtsys.com.hk>, devicetree@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: DAC extension for ltc2634-12/10/8
Message-ID: <20200430151734.GA19701@bogus>
References: <20200420042612.27752-1-chris.ruehl@gtsys.com.hk>
 <20200420042612.27752-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420042612.27752-3-chris.ruehl@gtsys.com.hk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 12:26:07 +0800, Chris Ruehl wrote:
> This patch add support for Analog Devices (Linear Technology)
> LTC2634 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
> The SPI functionality based on them from LTC2632 therefor
> add the definitions only and update the Kconfig.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> v5:
> -add Acked-by
> v4:
> -hide version from commit text
> v3:
> -Consistens decimal separator in help text
> v2:
> -Send the documentation fix in a extra patch
> -Kconfig simplify the driver description, details to the help text
> -ltc2632.txt add to this patch-set (prepare to convert to yaml)
>  .../devicetree/bindings/iio/dac/ltc2632.txt   |  8 ++-
>  drivers/iio/dac/Kconfig                       |  6 +-
>  drivers/iio/dac/ltc2632.c                     | 60 +++++++++++++++++++
>  3 files changed, 70 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
