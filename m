Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B633D4333
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 00:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhGWWTR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 18:19:17 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:42693 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGWWTQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 18:19:16 -0400
Received: by mail-io1-f50.google.com with SMTP id h1so4353052iol.9;
        Fri, 23 Jul 2021 15:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5gEKd3Fad6TqaBypsKNNpsl+jcWqb14IonY6bXeZtE=;
        b=MURPnKAUJW0cz9demrjBiHF9PyGy6CgU+5IEzMYCAFzlc8sG24K0/+BCLa713bJSUZ
         sA1MKNqhsOdA25J5EbwgUABfbAaWydX/WWdaG2AL61/WWeE0ThpJLJxCV+gkUgsK9hbT
         yC3Iq5YyVWPWgPaOvVAvO6VZtpiPc3QLwR1wRxQYT0WmHkXB9vX832ihQtTmGRZBXszh
         Q9YJ9MPiRj7wJu8MQcUoEHsvPvA3jPgViiVtr04zVi2aLAOz1u/CuuNKmRHWky1KPllW
         UZySQuhHk2Sr2RPiz1vC/HE07dZeF688fGLd9N7sxyIPfsfgyp8w4Pl4TJc7B2xAL5rD
         RBfQ==
X-Gm-Message-State: AOAM532ARCUDxYgSArieDy5isBo6nkcvlyl4pL0Muiu8D/pqU9UD2dTc
        j8e70TEzGC3/rtJ1pTPm9Q==
X-Google-Smtp-Source: ABdhPJykl4eXcutRiAPLU7jS43PLV/5/TVz0P3/jHWuoidixDBFGseFP8h1CwQH1axS0YPIXDPk0rw==
X-Received: by 2002:a02:331e:: with SMTP id c30mr6042474jae.94.1627081189345;
        Fri, 23 Jul 2021 15:59:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g20sm17160248ilk.81.2021.07.23.15.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:59:48 -0700 (PDT)
Received: (nullmailer pid 2764250 invoked by uid 1000);
        Fri, 23 Jul 2021 22:59:46 -0000
Date:   Fri, 23 Jul 2021 16:59:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     devicetree@vger.kernel.org, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Subject: Re: [PATCH v6 13/13] dt-bindings: iio: afe: add bindings for
 temperature transducers
Message-ID: <20210723225946.GA2764216@robh.at.kernel.org>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-14-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721030613.3105327-14-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Jul 2021 23:06:13 -0400, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly.
> This binding describe one case, the measurement of a temperature
> through a temperature transducer (either voltage or current).
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-transducer.yaml       | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
