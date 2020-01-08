Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D401348AD
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2020 17:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgAHQ6Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jan 2020 11:58:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38912 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgAHQ6Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2020 11:58:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id a67so3238514oib.6
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2020 08:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AWmgSsfRzvwSL0sYtWV5JPk31n0xrdke8dXDCuRYCJA=;
        b=rhnq6cl6Vm+eCc1ZxrlX4w5DeYPytWXJu6YVDgo0ByHtoZ0I918tUAPCo6qKS1lHQt
         5o2J33fErNeRx05/FNX513elKYBjUN06Drip1MFdXpNAsXkCutGFjNhpeG8FRbbl1oTa
         wcWa8f/J2nRwluYSkxEv9m04R/so9ZaFP38yirfi7Xej15ZWoGDcjZDgY70FIdRmTafO
         s9vrhLvbGUcwKdyxUMEiafAT2XD3gQTNEf9W1/4WDeJHWDbwR/8wyMao0Vc6Ie2isnDe
         H4m4hDnOnFX1Vh8PKHAZDgGCS0CujvujsgFgWgW2RpR6H4twiEag0VvDJ5bYVMjaiVOK
         a1GA==
X-Gm-Message-State: APjAAAWE01ZiQNJaNNcS2AorKpWySYQRy6Y1fGNzg4HIRph/ovTi58e4
        M6edNRS0NFWzVBOjJO2l9dMH3o0=
X-Google-Smtp-Source: APXvYqxb1FnkoDn5BRrj1mzvkIyO9DbhaPQUP8FDWbDlww/vScsuGht5VU1JhSWOS6qdRpd/WVyivA==
X-Received: by 2002:aca:4dd6:: with SMTP id a205mr3677746oib.43.1578502695347;
        Wed, 08 Jan 2020 08:58:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w27sm1280578oti.65.2020.01.08.08.58.14
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:58:14 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:58:13 -0600
Date:   Wed, 8 Jan 2020 10:58:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, rpi-receiver@htl-steyr.ac.at,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: devantech-srf04.yaml: add pm feature
Message-ID: <20200108165813.GA4472@bogus>
References: <20200102172749.v7ufupd32ytf7jda@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102172749.v7ufupd32ytf7jda@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 02, 2020 at 06:27:51PM +0100, Andreas Klinger wrote:
> Add GPIO line and startup time for usage of power management
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/devantech-srf04.yaml          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> index 4e80ea7c1475..b3fcb3b79485 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> @@ -51,6 +51,22 @@ properties:
>        the time between two interrupts is measured in the driver.
>      maxItems: 1
>  
> +  power-gpios:
> +    description:
> +      Definition of the GPIO for power management of connected peripheral
> +      (output).
> +      This GPIO can be used by the external hardware for power management.
> +      When the device gets suspended it's switched off and when it resumes
> +      it's switched on again. After some period of inactivity the driver
> +      get suspended automatically (autosuspend feature).
> +    maxItems: 1
> +
> +  startup-time-ms:

Why isn't this implied by the compatible string? 

> +    $ref: /schemas/types.yaml#/definitions/uint32

You can drop this for standard units. 

0-2^32 is valid?

> +    description:
> +      This is the startup time the device needs after a resume to be up and
> +      running.
> +
>  required:
>    - compatible
>    - trig-gpios
> -- 
> 2.11.0
