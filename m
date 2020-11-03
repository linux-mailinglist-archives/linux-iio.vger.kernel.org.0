Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294862A3A76
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 03:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgKCCbt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 21:31:49 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:40916 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgKCCbs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 21:31:48 -0500
Received: by mail-oo1-f65.google.com with SMTP id p73so3862720oop.7;
        Mon, 02 Nov 2020 18:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y0dMtyQLIv1YDgilMg8+DplEC929CLT/6BJTmngbST0=;
        b=fSjuLy2I6I0NIAcpzkAofrIEHLhAwo5Q8Aj1VtHbuF1CpJbeGd9nlYlVo/m9l+88u3
         XmPXIOvPNrPRQQuqWOP+JvL2w/WWbMPqWsOT3kS2SdVj7NGGIFHZ7YBU091NlR2Lhwed
         V23tqUDOUwbFileKbYSQOTxuzZV3scVmwgGkE2VkJ5lT1c6l+Y+P9bB5D6c7ipFV+lO3
         UsFwucXnbrK4KrQvYUAT8vGaLU8jcwGf0nics1FubWNSW/4UEdwqPNazaKmeEICDadVm
         x+sciL2W54TPyomuP01PGz90KkdimGEO3BU7FdXD9f5pryoAUSVsS6tUx1YhfRvNZHan
         6Hog==
X-Gm-Message-State: AOAM5301YY7wotf8iagls3wxBFrqTCGMQS6DY+uz65E4QtyTqgweCifc
        2wS9c+0XRaTuxbrrzOMeqwdxYRbp1w==
X-Google-Smtp-Source: ABdhPJwRPJsmdYOHiZj+K+eToTaRnzo6b+5hyfYKpYtWmN5RVUGUdhe9MXcAXm20nen7/WJoPaCY0A==
X-Received: by 2002:a4a:c4c7:: with SMTP id g7mr13707631ooq.50.1604370707939;
        Mon, 02 Nov 2020 18:31:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p21sm4051748oto.21.2020.11.02.18.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:31:47 -0800 (PST)
Received: (nullmailer pid 693069 invoked by uid 1000);
        Tue, 03 Nov 2020 02:31:46 -0000
Date:   Mon, 2 Nov 2020 20:31:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/3] dt-bindings:iio:adc: Convert generic ADC channel
 binding to yaml
Message-ID: <20201103023146.GA692453@bogus>
References: <20201031182423.742798-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031182423.742798-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:24:20PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This channel binding is not yet that heavily used, though that will slowly
> change now we have a standard binding.  There are more properties coming
> for this binding in the near future.
> 
> This series converts the channel binding itself then leverages it to
> reduce repitition and improve consistency in a couple of drivers.
> 
> One thing to note is that we have similar defintion for DACs but so
> far there are no generic properties.
> 
> Jonathan Cameron (3):
>   dt-bindings:iio:adc: convert adc.txt to yaml
>   dt-bindings:iio:adc:adi,ad7124: Use the new adc.yaml channel binding
>   dt-bindings:iio:adc:adi,ad7292: Use new adc.yaml binding for channels.

For the series:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
>  .../devicetree/bindings/iio/adc/adc.txt       | 23 -----------
>  .../devicetree/bindings/iio/adc/adc.yaml      | 38 +++++++++++++++++++
>  .../bindings/iio/adc/adi,ad7124.yaml          | 14 +++----
>  .../bindings/iio/adc/adi,ad7292.yaml          |  8 ++--
>  4 files changed, 47 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.yaml
> 
> -- 
> 2.28.0
> 
