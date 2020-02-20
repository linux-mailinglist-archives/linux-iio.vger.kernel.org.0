Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1649716686F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2020 21:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgBTUfq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Feb 2020 15:35:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38737 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgBTUfq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2020 15:35:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so4967544oth.5;
        Thu, 20 Feb 2020 12:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KLnJ2EE9HqdFMPyrdHWAOuSgD0DwRRaG+D+VHL9b57U=;
        b=SJ2Cpo4KA6Slb7rS7qPsvImvqFIn/XSx9nsgRYcEZ0wcDC/9EJIxK2/LAQJopw7noV
         HwyPyoHw8UlMICpGbl89lrnR4oc0bA3fMd/TirB3ar+/NgprWD/cNSGeqsmYL53e1Vv7
         oyennKyzJvCmw+wOqqCGzdOQ7cmUTGbtSLPbDcIz/LrCrhFVSSsMKs0PsThSHM2cs0KP
         vh1D2uP9r+8fwUwTsOfpPmTFVvClM8/vChYCImVFozHQIYQl57+rw/VDC6eSb5Khthz3
         uHMGQmaBntaL+KUnnJ9bO8hFQubBYlaOYMFW/cW5oJwjjGJSRvzIMEUV//7CHtGw8LkR
         rERg==
X-Gm-Message-State: APjAAAUZXg9q6VvxalYF/VtF3rU6cOHBpihVF4MkT0fcLzatJ8Nw/var
        IeKTrqvsFb5uhxKb9OOO/w==
X-Google-Smtp-Source: APXvYqzQH1PDEUlkxlXZKR+oblsgRN0d0bEGqr3qPtpW3gEw37fTDHySMP/2voWU7bjHwF7y7XO48w==
X-Received: by 2002:a9d:74c4:: with SMTP id a4mr25941884otl.119.1582230945309;
        Thu, 20 Feb 2020 12:35:45 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p184sm129046oic.40.2020.02.20.12.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:35:44 -0800 (PST)
Received: (nullmailer pid 16012 invoked by uid 1000);
        Thu, 20 Feb 2020 20:35:43 -0000
Date:   Thu, 20 Feb 2020 14:35:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 3/5] dt-bindings: iio: adc: add bindings doc for AXI ADC
 driver
Message-ID: <20200220203543.GA15406@bogus>
References: <20200220150317.1864-1-alexandru.ardelean@analog.com>
 <20200220150317.1864-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220150317.1864-3-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Feb 2020 17:03:15 +0200, Alexandru Ardelean wrote:
> This change adds the bindings documentation for the AXI ADC driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/adc/adi,axi-adc.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dt.yaml: axi-adc@44a00000: 'dma-names' does not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1241489
Please check and re-submit.
