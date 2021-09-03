Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02D14002E5
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 18:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349906AbhICQGt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 12:06:49 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45661 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349877AbhICQGt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 12:06:49 -0400
Received: by mail-ot1-f50.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso7077026otv.12;
        Fri, 03 Sep 2021 09:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l0iP5JJE35ZYuQbK+af2NVnrw5T8/CIq2PpEDrl/wgI=;
        b=cZrP0svCROTmCQMnJx39JRfOrLzA01FQGSwHbdYiWnOv2oCMIGiUMBVQHxWanAuYqm
         ulSsCIE4umFojxa4RSJeTG2jYMWKhJ3CWrFfdRwa/bH/KE0l5/W9/qFv3vK30TVJeSSH
         aQuKaloDChPSKe9kExkDYZXk8eQBulsyQf+xVlhvn44Bmq5XDvRJnmqkR3Zh97NIYbVe
         Na73Bbb44uj1BSEKgoWtmGpu1rNgGMfypwrWYyi8b5oxFDM3i7CRrG+x7EtOKSow9Smn
         PlyN0eA+s5TXEsWVm1sihpy1FgJD3LnqvLABMToLjn3Wl/owny82o1G/Q+ACX84Q9FeR
         bGeQ==
X-Gm-Message-State: AOAM531yadocuaVcrq552nIDN3DY3555gY5gu0QaKlZ1pVk2bJ90I2b/
        FDfApUsMJdQV3wRO3jXs+w==
X-Google-Smtp-Source: ABdhPJxPXAwNcuTVCNipDZcHpn9gMAFUSAPv4e7EAwdcq2R3yUvO8vkzMFVQeGXC8h3qbDef3E34gw==
X-Received: by 2002:a05:6830:238a:: with SMTP id l10mr3771066ots.333.1630685148671;
        Fri, 03 Sep 2021 09:05:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x1sm1024309otu.8.2021.09.03.09.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:05:47 -0700 (PDT)
Received: (nullmailer pid 3023292 invoked by uid 1000);
        Fri, 03 Sep 2021 16:05:46 -0000
Date:   Fri, 3 Sep 2021 11:05:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     bcousson@baylibre.com, Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        devicetree@vger.kernel.org,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-omap@vger.kernel.org, Jason Reeder <jreeder@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 02/46] dt-bindings: mfd: ti,am3359-tscadc: Add a yaml
 description for this MFD
Message-ID: <YTJH2lMu3QPMn8T8@robh.at.kernel.org>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
 <20210902215144.507243-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902215144.507243-3-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 02 Sep 2021 23:51:00 +0200, Miquel Raynal wrote:
> There is a very light description of this MFD in a text file dedicated
> to a touchscreen controller (which is one of the two children of the
> MFD). Here is now a complete yaml description.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/mfd/ti,am3359-tscadc.yaml        | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
