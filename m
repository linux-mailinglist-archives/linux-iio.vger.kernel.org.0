Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 864B918C466
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 01:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTAuf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 20:50:35 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46819 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCTAue (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 20:50:34 -0400
Received: by mail-il1-f194.google.com with SMTP id e8so4051983ilc.13;
        Thu, 19 Mar 2020 17:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIgBKo47qYh1ltKrOIVcfZGETZW4lrwbdraIDGu2L+o=;
        b=lcIPMMxnvIrjPjFadLl0jlC14s/o+O4wxtimErLvfzuJGxmD7KgxOJFp1AhJz8/wyx
         jjGxNUAU4SFVCZgIAYtRbpxogXWX2Aoe1K98YExmNHEtglFHmWGvHcnuuA7kMAyNiOFg
         VdLLtiPuWyPfUaF3VOjiRxCb4tDwLhBJKxKox5kjqgJ8PHm7GrlEzgZl/gaAnFn2Slul
         DY5Sx6E4J/BvbmGgdywm4bUdJ2PVCVJF6/RtrtzyFZ6A6SL2J8Ph88+wAs38708nfzsj
         CLoyWqXtSiGnvUtxYZKyaM761uoyVL6IJXo5beSsNxwc6LsOBHVnW03A2sK2cFkHv4hM
         lxRw==
X-Gm-Message-State: ANhLgQ1AvAX+0zbtnLy06tl60sIM6Nz8eLelfP8R5bTpRC+9HI9njLbr
        y7m+KxSFJ7DFY7RfcMisVg==
X-Google-Smtp-Source: ADFU+vtc12zSQEr8dU7QzVWAXBveDLrgBvT/blJ+xBw3+740Pr8yQxQiJWGjcRejm+oijNCZjWV3qA==
X-Received: by 2002:a92:3a0b:: with SMTP id h11mr6016731ila.4.1584665433815;
        Thu, 19 Mar 2020 17:50:33 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n29sm1425773ila.86.2020.03.19.17.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:50:33 -0700 (PDT)
Received: (nullmailer pid 31867 invoked by uid 1000);
        Fri, 20 Mar 2020 00:50:31 -0000
Date:   Thu, 19 Mar 2020 18:50:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org,
        Laszlo.Nagy@analog.com, Andrei.Grozav@analog.com,
        Michael.Hennerich@analog.com, Istvan.Csomortani@analog.com,
        Adrian.Costina@analog.com, Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v10 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Message-ID: <20200320005031.GA31806@bogus>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
 <20200316155035.25500-9-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316155035.25500-9-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 17:50:35 +0200, Alexandru Ardelean wrote:
> This change adds the binding doc for the AD9467 ADC.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad9467.yaml          | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
