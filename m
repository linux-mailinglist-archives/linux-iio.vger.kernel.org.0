Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77E02A3A7A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 03:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgKCCfE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 21:35:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39749 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCCfE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 21:35:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id z16so9473595otq.6;
        Mon, 02 Nov 2020 18:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KNJMu2yACG+bHyAnNOjUeJvR+4QELKtVjegGmgtoKtU=;
        b=V5ixOuqglKABXjYDpac9MRVDkuavpilv1bpq/dpXcsvh3dSo0tmAkdZhaJVlzA+U9G
         8hq7bxGYKxoXvPW8i2F35bYiHPx7pT8TwcRqtzZ8IfVtq4q5Z7KuhvbVA7y5dbwqQdiA
         O0xml2HF6ulaxjdZ++xlKE6CRsIPkzo0xJzS/pBtZ3h8sWKaGK/6PTmZmouH+gS34Ad/
         AJG+Xo7UyN7LnId/H3Q4ErqGQgsBKzBR3Qnwyd2850cMEo7BA0/IcLLq+Ib3v70QRV/V
         9QVe0fpnDS9WtWKjqwfgqg3xx68jtW794r87HhkWeJVIpp4jDq75V2/o/eT/RYW4AlDY
         M0Bw==
X-Gm-Message-State: AOAM532YRCNq7Rbpn6V0jjJIIhfcIsmk2KKQeFLxMw7S0kekw1e2HmQv
        Re2+s+xOCKa0o5EnTVPKTCBvjWXBsA==
X-Google-Smtp-Source: ABdhPJy1YkDt7tHVOHDJnHi5BGt6br4AnKN0UnU+dlWuo9AkhsxTFRw+78NGGkDEHiXJtclm6mulaw==
X-Received: by 2002:a9d:2182:: with SMTP id s2mr14269568otb.328.1604370903100;
        Mon, 02 Nov 2020 18:35:03 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l11sm569723oti.75.2020.11.02.18.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:35:02 -0800 (PST)
Received: (nullmailer pid 697358 invoked by uid 1000);
        Tue, 03 Nov 2020 02:35:01 -0000
Date:   Mon, 2 Nov 2020 20:35:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/7] dt-bindings:iio: Move to trivial-devices.yaml from
 txt files.
Message-ID: <20201103023501.GA693302@bogus>
References: <20201031182922.743153-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031182922.743153-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:29:15PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Rather than convert this group of bindings to yaml, let us just add
> them to trivial-devices.yaml.
> 
> It is more than possible that we may need to give some of these their own
> files at somepoint in the future (for example due to additional of
> channel provider bindings for the potentiometers) but for now there seems
> to be little advantage to keeping them separate.
> 
> Jonathan Cameron (7):
>   dt-bindings:iio:chemical:sensirion,sgp30: Move to
>     trivial-bindings.yaml
>   dt-bindings:iio:chemical:bosch,bme180: Move to trivial devices
>   dt-bindings:iio:potentiometer:maxim,ds1803 move to trivial devices.
>   dt-bindings:iio:potentiometer:maxim,max5481 move to trivial devices
>   dt-bindings:iio:light:renesas,isl29501: Move to trivial devices.
>   dt-bindings:iio:magnetometer:memsic,mmc35240: move to
>     trivial-devices.yaml
>   dt-bindings:iio:accel:domintech,dmard06: Move to trivial-devices.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

> 
>  .../devicetree/bindings/iio/accel/dmard06.txt | 19 ------------
>  .../bindings/iio/chemical/bme680.txt          | 11 -------
>  .../bindings/iio/chemical/sensirion,sgp30.txt | 15 ----------
>  .../bindings/iio/light/renesas,isl29501.txt   | 13 --------
>  .../bindings/iio/magnetometer/mmc35240.txt    | 13 --------
>  .../bindings/iio/potentiometer/ds1803.txt     | 21 -------------
>  .../bindings/iio/potentiometer/max5481.txt    | 23 --------------
>  .../devicetree/bindings/trivial-devices.yaml  | 30 +++++++++++++++++++
>  8 files changed, 30 insertions(+), 115 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
> 
> -- 
> 2.28.0
> 
