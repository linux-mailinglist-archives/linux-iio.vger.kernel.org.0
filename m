Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67926494E0
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 16:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLKPe0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 10:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiLKPeZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 10:34:25 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A6DEF5
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 07:34:24 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-142b72a728fso5686845fac.9
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 07:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5oJxjmX82DjVpraQBNUyzowQsKuzvu+2SV1es+lGak=;
        b=Cd+Ak1UQ/n+UuPp28hbU1RgbH0ZUFcxE6LJ4o6jzCSRwC+0+r8A9Rs1K9Fyk3dTiS7
         TpjxuULPu6/h4rx0nLNzgVfjpWl8LIxBJZdpoC23QhUvtX1AHBT0q+itXb4m3pw2OKha
         nQDNHo86bgJQNggkNKDxA2i0/d3iFqLOfFoPojWGpccw8k8UHOTObNqFS8rOpU01lHUV
         gD8dciFqd+1fMK+lYwaZ96UuyUZ4KX7Ah1T/rzJoS3laV2uVzr4qY5TmrO3D4Wmj9rgK
         riwIGpFeA2Hw9FEyksQycv3Ow4o+ZFt9SyfQ7uFXXcNWxuSm66R2BgWeasfsJa4zIHaE
         n63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5oJxjmX82DjVpraQBNUyzowQsKuzvu+2SV1es+lGak=;
        b=V+6MYpALIyFEeiHHXu2Zmg7Pmv0ZNn2IyJMUGuvteykhuVNsQku23TX/Lf0AXOL6dX
         /2v0alpuoj7fS7UoBgpyH5nwGm8VAMvAXHX8LgEG5LjTgiA11NPrFqKWVuQnFV5M43I/
         ic1uKGjjTZ9LMwADtYlZQZVhp9MtA2sWyaQ4yiAAqw4TSLBBCwjc4yPqnjfbaPtZa8CW
         aZHFOJe9NW51RO/4jhJ3wdoleyJ8K+hfTKxXhXlnoz4tNASaAaXKt9o9qDmbKPcOPPx2
         1Pyqh/Y7dO9BA4E5Gf17rFZ1F0nlul3EiTW6JRt6cpYqjNgfay2hc7KheDfu/rY8IXqL
         rrBA==
X-Gm-Message-State: ANoB5pmy4F3YfKRG7RqKKsTFaiEwmR4HTzTzIWPrWbJWTEOuva5vhLkz
        QViKmtqVceEhNZq5Nqaxbd4nlh/lyLmcQJW1
X-Google-Smtp-Source: AA0mqf5HQZxg2gYWAfkvxxPZu1vFXclv66kGLUZE37eMK7UJDIcY+Hl9Lu3JNjHyrRLb1eBK5OS2aA==
X-Received: by 2002:a05:6870:78e:b0:13b:cce:3d5d with SMTP id en14-20020a056870078e00b0013b0cce3d5dmr7866139oab.12.1670772863154;
        Sun, 11 Dec 2022 07:34:23 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d7-20020a9d51c7000000b0066d2fc495a4sm3118197oth.48.2022.12.11.07.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 07:34:22 -0800 (PST)
Date:   Sun, 11 Dec 2022 10:34:19 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 3/5] Documentation: ABI: sysfs-bus-counter: add
 cascade_counts_enable and external_input_phase_clock_select
Message-ID: <Y5X4e+GVLhaTB97N@fedora>
References: <20221210102110.443043-1-biju.das.jz@bp.renesas.com>
 <20221210102110.443043-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+YpP0AasSOaO01/k"
Content-Disposition: inline
In-Reply-To: <20221210102110.443043-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--+YpP0AasSOaO01/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 10, 2022 at 10:21:08AM +0000, Biju Das wrote:
> +What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select
> +KernelVersion:	6.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute selects the external clock pin for phase
> +		counting mode of counter X.

Hi Biju,

Remove the "This attribute" from the description, and capitalize the
word "counter": "Selects the external clock pin for phase counting mode
of Counter X."

> +What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_available

At some point in the future I should combine the *_available blocks, but
right now they're separated between Count and Signal configurations.
This external_input_phase_clock_select_available is a device-level
configuration so it'll need its own block as well, such as the
following.

What:           /sys/bus/counter/devices/counterX/external_input_phase_clock_select_available
KernelVersion:  6.3
Contact:        linux-iio@vger.kernel.org
Description:
                Discrete set of available values for the respective device
                configuration are listed in this file.

> +What:		/sys/bus/counter/devices/counterX/cascade_counts_enable
> +KernelVersion:	6.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute indicates the cascading of counts on
> +		counter X.

Similar to before, remove the "This attribute" from the description, and
capitalize "counts" and "counter": "Indicates the cascading of Counts on
Counter X."

William Breathitt Gray

--+YpP0AasSOaO01/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY5X4ewAKCRC1SFbKvhIj
K44dAQCE1vItDzfBBNSj2FW0694XubwzcnWz7L0G1sZCIRWtIwEA35bTNzbJDM1T
V3MRVW7n4bEciA5MskUC+Flp5udy7gk=
=+/qZ
-----END PGP SIGNATURE-----

--+YpP0AasSOaO01/k--
