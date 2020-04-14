Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9419C1A8E02
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440781AbgDNVtx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 17:49:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40458 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440744AbgDNVt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 17:49:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id i27so1319218ota.7;
        Tue, 14 Apr 2020 14:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W/TjB1Q11sWTVzxLeidMUrAAsdNgT3xJMiLjw9v2R1Y=;
        b=MPh3Sim2/01iwfsDoElu6jVkOc7pPeAsUzvjOklfu0MBzbdRkR0x+dhXsbld8YnRDY
         Ml4MdshDyWm+ANOjy8th4mU4vPeI/b27wupihGHtnErprzitIXh8KSlWyI7brt03iQab
         jK0q/OcQ1/3ybvH+o95gL7SMXMqJYt11EmSEXdtWUOge4w086ByGSriE7uIm+5J/PMlG
         p4VizC99W1SPiLoBhri9zt0UbdVQrXHJB/W2lZOxrzCIv7RGXWnsi0LG7OSUWE0w8hrc
         9LCKfaXlEinSncaMfSXwpHNETQsFYOSgkWusR5jRBu6itM4KkskK2UVzKHS9RAkqqs37
         FmYg==
X-Gm-Message-State: AGi0PuZF1yvWAtO/Q7qOmV92vMmORAyNBNcOymUPvnTWuVhGvYYSMDK1
        56uebtE9PsemItiKDIp2DA==
X-Google-Smtp-Source: APiQypKEw4vNsyU9jnKpwrMnQzU8dMbD4t8KlH0bzOZ8rj/tBp5ezy6hGDMteBlIXMz2K417RWitKA==
X-Received: by 2002:a9d:364b:: with SMTP id w69mr20010075otb.289.1586900964885;
        Tue, 14 Apr 2020 14:49:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm325327otq.41.2020.04.14.14.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:49:24 -0700 (PDT)
Received: (nullmailer pid 21079 invoked by uid 1000);
        Tue, 14 Apr 2020 21:49:23 -0000
Date:   Tue, 14 Apr 2020 16:49:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: iio: Introduce common properties for
 iio sensors
Message-ID: <20200414214923.GA21041@bogus>
References: <cover.1586094535.git.agx@sigxcpu.org>
 <8b91f0b7fa76ca4b2f3cdc251411829f71f8d810.1586094535.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b91f0b7fa76ca4b2f3cdc251411829f71f8d810.1586094535.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 Apr 2020 15:50:29 +0200, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> Introduce a file for common properties of iio sensors. So far this
> contains the new proximity-near-level property for proximity sensors
> that indicates when an object should be considered near.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../devicetree/bindings/iio/common.yaml       | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
