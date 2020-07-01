Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B579321024B
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jul 2020 05:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgGADE5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGADE5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 23:04:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C18C061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 20:04:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so22242697wrn.3
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLtS6Wl7safhhZxHe3vVwSQB+yrO3mf2F7wF6Yw4fG0=;
        b=KbaEO652xuoW+WWFjpVvbpU4iiOyR2q6HIhzph64pNfR28SnPEpOFpnm6Pk89a8e+W
         JAT3VG+sxB93nRQWpM+YDaZC3sSDFSCoU5dk3T3WCGVYQHSqG/ilxyomaVpY/q1N34lV
         B+gHoDj3TK7UiAVNnqeMeaz6KV1E7YtT91g384zDSd5THbqX7FIIiYz9AUvhFvXCyEcS
         koF1erQ2cVBTMQoBov9q6qC9wb0V16djKfjkQh7Ehd391Jz1koRhZU9LSpKSCDcHbW0T
         DH+x3H+qlggoe+5dm3Pu7I9g+Gsok4hhkE7WJI7M9k5HbiWhe0lP2G9BE3vMQNX5nIkx
         T9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLtS6Wl7safhhZxHe3vVwSQB+yrO3mf2F7wF6Yw4fG0=;
        b=ZlDH0M4WaED+T7HgFnsrYUny1Ud6dIHnkT60Yke7l9CPhv2wgm1s/sqh4+uKgx0h1D
         tUALrmMLhbjl2qovQSIWd+fYlfqy8G4/7ksKmxFoHlSTEnEqEME1oehTQ3bAdxVD387Z
         RaaEzGWnTXFsIiUX5AvbCeVT8u4t6ma6BxfMS/Ksdb80lbVOWDNL2qrwAvHO6rSREYLs
         SHU45KjciRGQgM0ZiHzzLqBGwW3oYeYUw0tzUbqo11Cu134PRyoTEtu8umBrikmX3o9U
         uTlaH46GKlVEXr7dPucTQxJYHML2nuJWpfmhKOefZLFG+WflDmPFoNNVR8RAulWHsp7B
         Lnjg==
X-Gm-Message-State: AOAM531wC8/Y08jKS/92rINHbUEWvQVSGOtJICehuBgc9h7ZvY+5CAOg
        Fs6kh9Vxl21/B1z5zbb57dhx+rE06K2xn1nWUEUsbw==
X-Google-Smtp-Source: ABdhPJwTrmy+YsfHh6wkihsWhfoWsE3KVKSECWn1liJ/rlHC2aq2YGRFMe9yCLw77V28tEsajrievYBesO5qreNpbAk=
X-Received: by 2002:adf:dd81:: with SMTP id x1mr24362897wrl.7.1593572694204;
 Tue, 30 Jun 2020 20:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200630070552.1110864-1-davidgow@google.com> <20200630110654.00001d40@Huawei.com>
In-Reply-To: <20200630110654.00001d40@Huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 1 Jul 2020 11:04:42 +0800
Message-ID: <CABVgOSnOo4iauOBGpJUZ4NRihCUU-1vue8hajZTCKAcH98_Lrw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Specify IOMEM dependency for adi-axi-adc driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 30, 2020 at 6:07 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 30 Jun 2020 00:05:52 -0700
> David Gow <davidgow@google.com> wrote:
>
> > The Analog Devices AXI ADC driver uses the devm_ioremap_resource
> > function, but does not specify a dependency on IOMEM in Kconfig. This
> > causes a build failure on architectures without IOMEM, for example, UML
> > (notably with make allyesconfig).
> >
> > Fix this by making CONFIG_ADI_AXI_ADC depend on CONFIG_IOMEM.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> Hi David,
>
> Could you confirm what the build error is?  I thought the stubs added in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1bcbfbfdeb
> were meant to allow us to avoid having lots of depends on IOMEM lines for the
> few architectures who don't support it.

No worries:
/usr/bin/ld: drivers/iio/adc/adi-axi-adc.o: in function `adi_axi_adc_probe':
torvalds-linux/drivers/iio/adc/adi-axi-adc.c:415: undefined reference
to `devm_platform_ioremap_resource'

Alas, the devm_platform_ioremap_resource function isn't handled by the
UML stubs: it all seems to be in drivers/base/platform.c and
lib/devres.c, behind #ifdef HAS_IOMEM.

In any case, improving IOMEM support for UML (at least for the KUnit
test case, which is my use case) is something I'd like to do. There
are only three drivers[1,2] upstream at the moment which fail to build
as-is, though, so it seemed worth trying to fix them in the meantime.
That being said, I tried just getting rid of the few #ifdef HAS_IOMEMs
around the various devm_*_ioremap functions, and everything seems to
be working... So maybe that's a false dependency given the various
stubs (at least on UML). I used this (hideously hacky) patch:

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c0d0a5490ac6..b6f08c88e2b6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -61,7 +61,7 @@ struct resource *platform_get_resource(struct
platform_device *dev,
}
EXPORT_SYMBOL_GPL(platform_get_resource);

-#ifdef CONFIG_HAS_IOMEM
+#if 1//def CONFIG_HAS_IOMEM
/**
 * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
 *                                         platform device and get resource
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..35c21af33b93 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -115,7 +115,7 @@ obj-y += math/ crypto/

obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
-obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
+obj-y += iomap_copy.o devres.o
obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o

---

If this seems to work more broadly, I may try to clean it up and post
it for broader review.

Cheers,
-- David
