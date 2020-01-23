Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4285A146CD6
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2020 16:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAWPaF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jan 2020 10:30:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44868 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAWPaF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jan 2020 10:30:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so3055890otj.11;
        Thu, 23 Jan 2020 07:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YHqBGj/ukTPkl69zvdBgkmcYaLWB1N0Qj6YD43sxU/8=;
        b=QiVdXJGObleBcBNIEaA1pbFxONW2u86/MusGQU6g9mImTAT2BHsg4IIKpWCm/cYBEa
         uwIGutMcaFCxfphsVV/vUdFuAcYPjwsAwuYgQr9wcY+orXQs2BGfE1AJuzKtoVIfX6ic
         8Pa88apJ6B+7vX/Qxl2MbGzBYpOVzt+GyLq20Ew2aWzYLDR7mU+VPnLaaozfd+kb0Qjb
         Gg9swqYG5Eg9LYmQ7g2vH/SSovebmkjwQjwp2n4N4JGUt2qYcHSXhpZ89By+RUOtweKO
         +w7PbKq7ECW+YFUVNxsJh+4n16aW/rXB+Cw/M30Y7RMRIRuNv7W+WUCLI//qM7gBq4vS
         560w==
X-Gm-Message-State: APjAAAVHvriC6GwCTb89rN40GmuKGhlH1BUs8xjWRjrdmXiQpx3P5pN5
        i9DEvxWjdABzl2TNzSqVyQ==
X-Google-Smtp-Source: APXvYqxkWG8AeF8EXXnGTWZ4IdGe6xCc6yw9d5YQpXCkxvBsnWb6O8ACMvnxGdINcohg5IvNyDKtDQ==
X-Received: by 2002:a05:6830:4ca:: with SMTP id s10mr11737763otd.268.1579793404638;
        Thu, 23 Jan 2020 07:30:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p24sm891368oth.28.2020.01.23.07.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:30:04 -0800 (PST)
Received: (nullmailer pid 12956 invoked by uid 1000);
        Thu, 23 Jan 2020 15:30:02 -0000
Date:   Thu, 23 Jan 2020 09:30:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     jic23@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com, lars@metafoo.de,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: stm32: convert dfsdm to json-schema
Message-ID: <20200123153002.GA14241@bogus>
References: <20200123083432.21997-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123083432.21997-1-olivier.moysan@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 23, 2020 at 09:34:31AM +0100, Olivier Moysan wrote:
> Convert the STM32 DFSDM bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
> The DT check still returns some warnings on this bindings:
> dfsdm@4400d000: filter@4: 'st,adc-channels' is a required property
> dfsdm@4400d000: filter@5: 'st,adc-channels' is a required property ...
> 
> These warnings occur because some disabled nodes do not provides the
> required properties. These nodes are included from SoC DT,
> and do not provides by default the properties which are board dependent.

We handle disabled nodes, but not when they are child nodes.

> As workaround in DFSDM yaml bindings, the properties
> (like st,adc-channels) could be defined as required,
> only for the nodes which are in enabled state.

We should handle this in the tooling, not the schemas. I entered an 
issue to track this[1].

> ---
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt   | 135 -------
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 332 ++++++++++++++++++
>  2 files changed, 332 insertions(+), 135 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml

Applied.

[1] https://github.com/devicetree-org/dt-schema/issues/32
