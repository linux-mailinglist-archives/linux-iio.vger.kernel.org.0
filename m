Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48C6414AE8
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 15:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhIVNoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhIVNoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 09:44:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F0AC061756
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 06:42:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y28so12309938lfb.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPSajnxuOhudE0ZK2ykXAKztLCIX6iswgpYQXOQqzio=;
        b=J7J/eOjZ4Vlpqic1wgRut9TkgmnPMFV9OS6XCBJLPQDvmwqVGWmiN4MlCzhTwPUqN7
         180/uulmQiac2+5S08c9vqqitXlgFSgK+Z0hBJR7XKy8EwI2UrnpIqvA1OsfOtoQiKM3
         l9pD7nud0ukUBZwiIloc08i2agCGBlGEV2jjtRKhPOW3uV38LlbDw1fX3heiaTFGY6QW
         1YZ8VerX9QIOnvhJo3+graf+tStjR03guBKscK/grdwt/dbx6TmRZ3o4s6QKeFYPfBYo
         ZfgWOYHpZaxwvx3gIzvvABaWtn3NbnWP1bvaCd0Rhx5n25c9b0p0sE1T4LcoOIwCjyVU
         KuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPSajnxuOhudE0ZK2ykXAKztLCIX6iswgpYQXOQqzio=;
        b=dgSzfvb9sV2ZnSbFKTDqJfRsTU/KVICPqFLspfIOEwflWGKZmCun1nL5i/zukZO+lq
         UhjWenDFyc2MYBq2cvOxCBO2kglFwlKwcYma5gDSE2P78aIuET3r8GK97vTUe2yb6cE7
         aR5e2QIFx8Mwi6ye8WzFxJt+i49IjIT9pURadPIGYug576id3fLaFI0HRcc6HobVPKVy
         XDGyiZtl5mnKrraAYisNvL+nH4Qzlx7PC+bgLq3vf8m2IJawOfo0qOh6e7NyWBbsCijl
         yBMjt/3xmGXTTF/Z6HxpIIUeMJbHz8eBIjyKJ5mouORCMbi8Jj9f9NNyfsSIykDmu8yy
         3wKw==
X-Gm-Message-State: AOAM533F4Yml/UASlRyS6JjAzRz7rtyutBlPcG99WGlBRafKI9Oo9lwc
        gvacPsMJXPnZGCM3WS7Njwxlgss3PJPou1zfOPU42VZgHi8=
X-Google-Smtp-Source: ABdhPJw00Ow2Ub1/OFobs+JVBYbi+VPEwOd376Mx0EXEa1JDzL6oF31EGT6GeESkCoemrzSTwdtfEePl0wscBgPQTxI=
X-Received: by 2002:ac2:514e:: with SMTP id q14mr28189146lfd.154.1632318116105;
 Wed, 22 Sep 2021 06:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
 <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se> <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
 <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com> <73d0ede5-8a35-7e3e-e685-235f39ea28e7@axentia.se>
In-Reply-To: <73d0ede5-8a35-7e3e-e685-235f39ea28e7@axentia.se>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 22 Sep 2021 10:41:44 -0300
Message-ID: <CAOMZO5Ds8hUc1=Jv6YHgNUnvGH0JWB1yX0sMccoUVcZ6tyyTKw@mail.gmail.com>
Subject: Re: Reading ADC that comes from a multiplexer
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Wed, Sep 22, 2021 at 9:53 AM Peter Rosin <peda@axentia.se> wrote:

> I think that's because the "parent" channel (i.e. <&adc 4> in your case)
> is referring to a node that is not providing any iio channels at all.
>
> Just because you added "#io-channel-cells = <1>;" to that node, does not
> make it so. The driver has to support it as well.

I tried to use the same approach as in arch/arm/boot/dts/am5729-beagleboneai.dts
as per your suggestion:

--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -139,6 +139,23 @@
                spdif-out;
                status = "disabled";
        };
+
+       adcmux: mux-controller {
+               compatible = "gpio-mux";
+               #mux-control-cells = <0>;
+               mux-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>,
+                           <&gpio3 30 GPIO_ACTIVE_HIGH>,
+                           <&gpio3 26 GPIO_ACTIVE_HIGH>;
+       };
+
+       adc-mux {
+               compatible = "io-channel-mux";
+               io-channels = <&adc0 4>;
+               io-channel-names = "parent";
+               mux-controls = <&adcmux>;
+               channels = "chan0", "chan1", "chan2", "chan3",
+                           "chan4", "chan5", "chan6", "chan7";
+       };
 };

 &audmux {
@@ -362,6 +379,11 @@
                        compatible = "st,stmpe-adc";
                        /* forbid to use ADC channels 3-0 (touch) */
                        st,norequest-mask = <0x0F>;
+                       adc0: iio-device {
+                               #io-channel-cells = <1>;
+                               iio-channels = <&adc0 4>, <&adc0 5>,
<&adc0 6>, <&adc0 7>;
+                               iio-channel-names = "adc4", "adc5",
"adc6", "adc7";
+                       };
                };
        };
 };

but still the parent channel cannot be found.

So I don't have the DT properly describing the ADC to the mux relationship yet.

Thanks for your patience,

Fabio Estevam
