Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45E83B0B86
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jun 2021 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhFVRim (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Jun 2021 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVRim (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jun 2021 13:38:42 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B638C061574;
        Tue, 22 Jun 2021 10:36:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o6so6232601qkh.4;
        Tue, 22 Jun 2021 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zStx7piADl+l65PWbMM4TKMoh0TDURz0qm5Waha0vmI=;
        b=EQa7eNyCLAAOs5+jWSbYSfFEl2PFlhs9NTX3v0a1jFPg02gG5WsmP3S4rsKxM13xeq
         E9s3D0k93HlKuEwEzp1UcvcyDG7QesjYnAQb5gew1OThq7+1pBfR4lioOFtyMHaWp7wo
         fywIS/sjD8sVblFsAuclySmoJiosSwzMBnNRi2YTYItKJwkcsfQ+vVrdnQh1gQk0I9Jl
         cNBKeaJJFh4KuVBOUXP04y8ZIzIjviuIBNowSgUZWXGftDSDs5aGKG9PuvLrubIfpXpe
         b+h8Ttp4uMCc13ceqPISTSzjBmdhAlnUFX71Z8RlldzTT2gflNC9BcXrIXHsCw0nYGh8
         AAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zStx7piADl+l65PWbMM4TKMoh0TDURz0qm5Waha0vmI=;
        b=HCTCXfb05kZEAwv6tTRI9/UoUdAhT+pWAdAIl6OTOBExs5nhzsOLKoxC37hhy0GWsD
         lDof3rgf/WzEGgt197+suHyQdn+AKI7tneswqi+y9dqcKGAPzmCAub+SLQsy41yFCIux
         K54v2vLtwQP6b/+Bq8v3BZWTbPU9MOqlQznDKDahGT1+irVhra4yesujpwBLXGm0PJG4
         YufmNr4MMkVIVEX++KeoNlieCcH4CsEQH0iDWx88lsQp3r/D2Iei3fPLtaeRUHcDQAyS
         9On4kZPXNtlBXySm4mF558AbCakZ1dccSevaSc3goF2UHBE31bjiD3/m/dWqyi3W1TLq
         mCgQ==
X-Gm-Message-State: AOAM530rcIpJTQ27SOa2sTBYhkQRDMHjLsS2TaPGQtVqIC4glQJh/1o/
        pz0TNfzVtAQeA/SPzs+X6DM=
X-Google-Smtp-Source: ABdhPJyW3LjIo8WfhP56QAdoS4/dFxorrsN76q4vDPWRo1b1SeCOBjhkB0yyXm8gZeDLZgMVzH8gjw==
X-Received: by 2002:a37:6703:: with SMTP id b3mr5591932qkc.107.1624383384943;
        Tue, 22 Jun 2021 10:36:24 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:933:eb00:4f35:a781:9a0c:3ae7])
        by smtp.gmail.com with ESMTPSA id q3sm1874521qkn.15.2021.06.22.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 10:36:24 -0700 (PDT)
Date:   Tue, 22 Jun 2021 14:36:17 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/17] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <YNIfkaRZtWIXPbAj@marsc.168.1.7>
References: <20210614113507.897732-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey Jonathan,

On 06/14, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Hi All,
> 
> This one proved an interesting diversion.
> 
> Work done against a somewhat hacked up QEMU emulation of 3 daisy chained
> ad7280a devices (18 channels).  Note that the emulation isn't complete
> but does do chaining, CRC, and readout of channels etc in a fashion that
> worked with the original driver (up to the bug in patch 1) and continues
> to work with the updated version. I've not intention to upstream the
> emulation (as would need to make it more completed and flexible), but
> happy to share it with anyone who is interested.

I'm interested in seeing your device emulation with QEMU.
I was looking at the ad7150 emulation you shared earlier this year but had
some trouble getting the i2c slave created.

Being able to see it running, I may feel more confident to provide a review
for this set :)

Regards,

Marcelo
> 
> I briefly flirted with posting a patch to just drop the driver entirely,
> but the part is still available and it looked like fun + isn't going
> to greatly impact maintainability of the subsystem long term so is low
> cost even if it goes obsolete sometime soonish.
> 
> There are lots of things we could do after this set to improved the driver
> and make things more flexible, but it should basically 'just work'
> 
> Anyhow, as normal for staging graduations, last patch has rename detection
> turned off so that people can easily see what I am proposing we move
> out of staging.
> 
> Jonathan Cameron (17):
>   staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
>   staging:iio:adc:ad7280a: Register define cleanup.
>   staging:iio:adc:ad7280a: rename _read() to _read_reg()
>   staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
>   staging:iio:adc:ad7280a: Use bitfield ops to managed fields in
>     transfers.
>   staging:iio:adc:ad7280a: Switch to standard event control
>   staging:iio:adc:ad7280a: Standardize extended ABI naming
>   staging:iio:adc:ad7280a: Drop unused timestamp channel.
>   staging:iio:adc:ad7280a: Trivial comment formatting cleanup
>   staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
>   staging:iio:adc:ad7280a: Cleanup includes
>   staging:iio:ad7280a: Reflect optionality of irq in ABI
>   staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
>   staging:iio:adc:ad7280a: Use device properties to replace platform
>     data.
>   dt-bindings:iio:adc:ad7280a: Add binding
>   iio:adc:ad7280a: Document ABI for cell balance switches
>   iio:adc:ad7280a: Move out of staging
> 
>  .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   14 +
>  .../bindings/iio/adc/adi,ad7280a.yaml         |   87 ++
>  drivers/iio/adc/Kconfig                       |   11 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ad7280a.c                     | 1116 +++++++++++++++++
>  drivers/staging/iio/adc/Kconfig               |   11 -
>  drivers/staging/iio/adc/Makefile              |    1 -
>  drivers/staging/iio/adc/ad7280a.c             | 1044 ---------------
>  drivers/staging/iio/adc/ad7280a.h             |   37 -
>  9 files changed, 1229 insertions(+), 1093 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
>  create mode 100644 drivers/iio/adc/ad7280a.c
>  delete mode 100644 drivers/staging/iio/adc/ad7280a.c
>  delete mode 100644 drivers/staging/iio/adc/ad7280a.h
> 
> -- 
> 2.32.0
> 
