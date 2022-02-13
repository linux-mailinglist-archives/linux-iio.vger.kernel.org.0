Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946DA4B3D48
	for <lists+linux-iio@lfdr.de>; Sun, 13 Feb 2022 21:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbiBMULX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Feb 2022 15:11:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbiBMULX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Feb 2022 15:11:23 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3614A912
        for <linux-iio@vger.kernel.org>; Sun, 13 Feb 2022 12:11:16 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s24so15456538oic.6
        for <linux-iio@vger.kernel.org>; Sun, 13 Feb 2022 12:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=haS2wAFTF4LYkWgTobEez2BzhQa+N8kYiRyHjcuTHYs=;
        b=Qc+SYPF1VlrF664pmDRMLgeHuwUZoNcGOKON5ODQqVlGItv7rI2NWLEpIfYXtN/wUY
         jUqISdI4eAZz7zAidPhujHNDbAP/FlebJP/K+9utaqPtzRIu3CEyl/WJ2rFY84moFCcc
         ZepS92v6C5pSvCBrBu0+kzzvpQr8NpKwYTwhP38ePs5RCYTP3rjMHyyef1iHtdX7FRcH
         57u+vmAkgLK6Wp17TJNHfF/omTPlPHJCeKa0kNGKJCcJDfaie3/D+hoz/yMSNbePxIc6
         xH1Jc61Q6wxJqfPjYSu/N4pUBXtyDjwAGClToxkg1cL6exc0+aWnwH5KOemqjI3keb9v
         6HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=haS2wAFTF4LYkWgTobEez2BzhQa+N8kYiRyHjcuTHYs=;
        b=xQtaQJNuXCiY7Aq4CxiNcufhdCYyfvxFqv73vNrdyKIzLuajbY8/BI1I/sXICWhU+z
         CBFGqZW9WtB19imBDf7ghjVvC7YrSh5sV2+zfBtJyZBRgXfn2ilKF8ND+15NeiQbBDFY
         lJCu4I4heHM5u8lWGBGkE+SY+pea4x8591UVWQ7S6IhADoMHizrNaFh7S3dQZA0KZJdE
         nOfq8RTwjgOb+G0or2mIGDXpQhKtJesRMescKluuyhrIhByQS9BxHHDUsp3ND1oR1UXN
         jlvwEQ+8Jt9cOgElGCBx8Yk35rmHRqBzmTPJI/USNWYaKtzG/3+RYzp22+aTeiXlBU9R
         FJTA==
X-Gm-Message-State: AOAM530TKn770cnvdkifn06wbYY00vZTyVHxGI4u07wl75G4Y6lkjbLt
        v/WUlo5gVQ6wmbbdq1z3tBtoBTJH7kE=
X-Google-Smtp-Source: ABdhPJz57rgCsHtD0kfrMkySLO9Gd9kwgUJHLtJ/AiSWeOf7+eRYrFR9sxxI1D016mwod1CyeyHp4Q==
X-Received: by 2002:aca:bbc1:: with SMTP id l184mr4181976oif.190.1644783076082;
        Sun, 13 Feb 2022 12:11:16 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b7a:7b00:70e:e3d5:be94:991])
        by smtp.gmail.com with ESMTPSA id t4sm11933208oie.14.2022.02.13.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 12:11:15 -0800 (PST)
Date:   Sun, 13 Feb 2022 17:11:11 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hennerich@marsc.168.1.7,
        Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 00/20] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <Ygll3yGIjH7NOFx/@marsc.168.1.7>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/06, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Changes since v2:
> All in response to Marcelo Schmitt doing a really detailed review and
> testing against the QEMU model.
> 
> - Moved elements of patch 2 to patch 5 to avoid missing defines.
> - Patch 6: Amend ordering to avoid updated software cached values until the
>   hardware write has succeeded.
> - Patch 12 Fixed wrong callbacks in no_irq case
> - Patch 14: Changed all numeric properties to u32 to avoid needing to
>   specify bit depth in dts.
> - Patch 14: Typo fix.
> - Patch 15: New Patch to drop the handling of partial aux alert channels as
>   it is buggy (and always was). Anyone wanting to bring this back will
>   hopefully have hardware to test as it will be fiddly.
> - Patch 15 (old number, now 16). Update dt bindings to drop the
>   adi,temp-alert-last-chan given new patch 15 drops the support.
> - New Patch 18: Change cb_mask software cache to not include the offset of 2
>   and instead apply that only when writing the registers.
> - New Patch 19: More conservative timings to allow 105 degree Centigrade
>   operation.
> - Patch 20 is moving the new code so obviously all the above apply to that
>   as well!

I had another look into this set (including the new patches), and it seems all good. :)
Also, thanks for clarifying my doubts about the driver on the previous thread.
So,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
for the whole series.

It will be nice to see another driver getting out of staging. :D

Thanks,

Marcelo

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
> cost even if it becomes unavailable sometime soon.
> 
> There are lots of things we could do after this set to improved the driver
> and make things more flexible, but it should basically 'just work'
> 
> Anyhow, as normal for staging graduations, last patch has rename detection
> turned off so that people can easily see what I am proposing we move
> out of staging.
> 
> All comments welcome and thanks to Marcelo for reviewing this beast!
> 
> Thanks,
> 
> Jonathan
> 
> 
> Jonathan Cameron (20):
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
>   staging:iio:adc:ad7280a: Drop buggy support for early termination of
>     AUX alert.
>   dt-bindings:iio:adc:ad7280a: Add binding
>   iio:adc:ad7280a: Document ABI for cell balance switches
>   staging:iio:adc:ad7280a: Remove shift from cb_mask state cache.
>   staging:iio:adc:ad7280a: Use more conservative delays to allow 105C
>     operation.
>   iio:adc:ad7280a: Move out of staging
> 
>  .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   13 +
>  .../bindings/iio/adc/adi,ad7280a.yaml         |   77 ++
>  drivers/iio/adc/Kconfig                       |   11 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ad7280a.c                     | 1111 +++++++++++++++++
>  drivers/staging/iio/adc/Kconfig               |   11 -
>  drivers/staging/iio/adc/Makefile              |    1 -
>  drivers/staging/iio/adc/ad7280a.c             | 1044 ----------------
>  drivers/staging/iio/adc/ad7280a.h             |   37 -
>  9 files changed, 1213 insertions(+), 1093 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
>  create mode 100644 drivers/iio/adc/ad7280a.c
>  delete mode 100644 drivers/staging/iio/adc/ad7280a.c
>  delete mode 100644 drivers/staging/iio/adc/ad7280a.h
> 
> -- 
> 2.35.1
> 
