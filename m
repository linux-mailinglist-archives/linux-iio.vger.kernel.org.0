Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904B1472C9F
	for <lists+linux-iio@lfdr.de>; Mon, 13 Dec 2021 13:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhLMMvS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Dec 2021 07:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhLMMvS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Dec 2021 07:51:18 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECF7C061574
        for <linux-iio@vger.kernel.org>; Mon, 13 Dec 2021 04:51:18 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id n15so15065824qta.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Dec 2021 04:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vmBu/p+Q40av/nZzrzuyBXPS6qj+Dsiit3wBAwUqD80=;
        b=MZIls8+c3cjJniuWFhf3yrjHlMNDb7UnT/a6up/sfuYcxuy9WzvVeODk4F9ANVOCn1
         557jdp3kPxK9MfU5YYjGZfE4uC2n9+3YIqIlDUwu3xo9t0fgW483hIP2RBJd83SK+etC
         gEG/GHXWAGR+PxqFcvDtzAe1caFCao4oapYgm/9HoWG6wXKE1z5/uAkFozFIosmkG9jy
         gv/9Uz9ae+5GxfenAkF4c16xmg/b+AIUabRRdSZ9xrkHMb6v7C22HBc+WJgitXz2BfA3
         SDgAzw9DehuDf94HVrN/ekk2nmUdJFPaR5JpsrYE3gaDxUHmonSfOMCoJ2ouv4mF1Nn5
         1OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vmBu/p+Q40av/nZzrzuyBXPS6qj+Dsiit3wBAwUqD80=;
        b=6DYNJKPocWfVH9CFwuiRFwpAqgQIgVRR3fsrbueum7HHnA61voD4/unI7iM9AZL2r8
         mko6eenmZw7wBIz/I7yMoXiXjUDVM0I8CWFstG7LHSf+k6QEIE6IUF3WgAjyWvo5WN4t
         Su8ggkhvv7p3E1qbdOI+w5z+o4PW2bF2UVHf93u9GEC7lPo4J141ey9S3XTrSksrAN3O
         98EyykC7968bkbxI7URA2xpfLXvMJPfya0KfVULHY61mAeYBwT3m+6k5yJV0oQ8nloA8
         WZrqKM7AR0DaeZVDUShVB2KutlOqas7iH0M/dvuuuySsjmRQcwfsaiKvdO/FTxtedYdc
         szFQ==
X-Gm-Message-State: AOAM530MqE/zGIweBuB8WwLoGvUIIoU8w2CnxDtAztiAI9boKUsp/HzL
        YfGARAKFnTt+4hyck8gGCS0=
X-Google-Smtp-Source: ABdhPJzU6eWbV7Cjpoc8sg2EtpKZ7m4RnwJEzv3/CKiTcJhfA7c1oJPGPqHmbm6Gd4pBtpyiF0Iobw==
X-Received: by 2002:a05:622a:64e:: with SMTP id a14mr44966393qtb.496.1639399877296;
        Mon, 13 Dec 2021 04:51:17 -0800 (PST)
Received: from marsc.168.1.7 ([2804:d57:1505:900:9e70:8954:9f0b:ad76])
        by smtp.gmail.com with ESMTPSA id j14sm5958723qkp.28.2021.12.13.04.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:51:17 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:51:12 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/17] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <YbdBwDllp+BB/Pei@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> v2: Picked up Rob's tag for the binding
>     Rebase and a trivial white space tidy up.
> 
> Marcelo expressed interest in reviewing this one, but given it's
> been a while I'm resending in the hope that someone else will have
> time to take a look. Obviously if anyone wants to try the emulation
> that's great but fundamental thing I'm looking for here is review of
> the final patch as that has the whole driver in it.
> 
I've been spending some time with this part's datasheet to provide a proper
review of this series. This has been on my TODO list for a while now. For now
I've got patches 1 and 2 only. The good news is that now I'm giving priority to
this so will send the review for the rest along this week.

> Note we don't require perfection for staging graduations, so futher
> cleanup can be delayed until it's out of staging.
> The interesting stuff here is anything related to the ABI as that
> is pretty much fixed once it's out of staging.  Obviously any
> feedback welcome.
> 
> v1 cover letter.
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
>  .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   13 +
>  .../bindings/iio/adc/adi,ad7280a.yaml         |   87 ++
>  drivers/iio/adc/Kconfig                       |   11 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ad7280a.c                     | 1116 +++++++++++++++++
>  drivers/staging/iio/adc/Kconfig               |   11 -
>  drivers/staging/iio/adc/Makefile              |    1 -
>  drivers/staging/iio/adc/ad7280a.c             | 1044 ---------------
>  drivers/staging/iio/adc/ad7280a.h             |   37 -
>  9 files changed, 1228 insertions(+), 1093 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
>  create mode 100644 drivers/iio/adc/ad7280a.c
>  delete mode 100644 drivers/staging/iio/adc/ad7280a.c
>  delete mode 100644 drivers/staging/iio/adc/ad7280a.h
> 
> -- 
> 2.34.1
> 
