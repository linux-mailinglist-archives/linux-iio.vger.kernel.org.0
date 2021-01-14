Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C782F6A8E
	for <lists+linux-iio@lfdr.de>; Thu, 14 Jan 2021 20:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbhANTJg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Jan 2021 14:09:36 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:37457 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbhANTJg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jan 2021 14:09:36 -0500
Received: by mail-oi1-f177.google.com with SMTP id l207so7054795oib.4;
        Thu, 14 Jan 2021 11:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MathmbIX76TOVK7rzTxHRBsc0xi/9wiOfMG+xrLSnO4=;
        b=P5+TWX9CCzAPV9o3nM5b6eBXDBBeX5O49EtpiRvhZEDN1IuEw8irPFsbSit1FCCzaP
         J8gah/kPD7leTSlJ+4qd/2gTGOfXEipPrEeWt315YNujBVMpm+NHCUiB14A5wJONYETn
         RkTfcGLyp0gsM4L39xIQ/4tgZaNlfuXcobTRYKj5ojrttAEVtrK48wJriGZQRRQzxDcK
         +I4g8h0WxeyCZzJ1RzAx6v1DnVySs1tuybfrtuGqwvZuNG6McXH7jP3iJjdleqrN6gnH
         wXU5oSVZ+J8tWWuDyckaHR/DLMm0uRHyKE0/7MPFDnTQQR3+JA7hPWdpcdRUiFFWkuxF
         JDLA==
X-Gm-Message-State: AOAM532mrJ2/zL1E41T/I5QcAgD1BAwsff0gKlvghI2F7OAqFxEcxx/N
        PwYtXMOlqHlr8gWbC3w9UKgDp4pUOQ==
X-Google-Smtp-Source: ABdhPJx9HSEYTrhMQ7SS5lQQTscuAjb5zvwpHMAH18J3KB+p4AHfGytZI5Kz0Rbl5NrTUAJD8gJgUQ==
X-Received: by 2002:aca:743:: with SMTP id 64mr3682867oih.60.1610651335553;
        Thu, 14 Jan 2021 11:08:55 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p28sm1239989ota.14.2021.01.14.11.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:08:54 -0800 (PST)
Received: (nullmailer pid 3389049 invoked by uid 1000);
        Thu, 14 Jan 2021 19:08:53 -0000
Date:   Thu, 14 Jan 2021 13:08:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: trivial-devices: reorder memsic
 devices
Message-ID: <20210114190853.GA3388986@robh.at.kernel.org>
References: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
 <20210109231148.1168104-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109231148.1168104-2-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 Jan 2021 00:11:43 +0100, Alexandre Belloni wrote:
> Reorder memsic compatible strings alphabetically
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
