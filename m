Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBDC290BFB
	for <lists+linux-iio@lfdr.de>; Fri, 16 Oct 2020 21:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403931AbgJPTAL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Oct 2020 15:00:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32869 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403821AbgJPTAK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2020 15:00:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id t15so3419878otk.0;
        Fri, 16 Oct 2020 12:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hDEoP7FMq0WgomEPshsxE41alACngxyEdgyV/rIqrc0=;
        b=IUY3r2ZnYROVNb01ZB2mHJ1TzrtpSX85J6jBvFL0Zii+pzaHH6903tGSGjiF3TQPrd
         GDTwVQ9q6ZeM5c4uajxG2dru2JfE4mzrDWfCc6H7labwgOCHKuEnvP1cW4FMPbIUsQTf
         xasZNK6SCtnlfm4BcgDX4T8QiiqKhF2QAhyc9e5J7Yb+SWC7zC3Gudma9w7okq9oI4G1
         /p5Rrt0tyU1150CULN2u6bovU1qY1+iuZnAkbZukAOzG6Jbvnf8zcW0SZvLmx8mLbbU+
         HTunc0fQCHT1XQkxGkvKEDV1oRoARTjGJ57nPbIagGRsCwSHhor3E9Ty8gGWiYcp4SJs
         w63w==
X-Gm-Message-State: AOAM530uOHa1mLYwQGn38U1XSqKR5fKKN/Vf8/8s5ShW2bhYa91WEwOn
        RMZA8CKDldRViZvuIR73sQ==
X-Google-Smtp-Source: ABdhPJzBGIzrSRGe2l6O+wuW+VliwMyNB+8qIapEk34TQEBDDez2EU0Dd43Mgz9opDA2tUw97Hb8eQ==
X-Received: by 2002:a05:6830:1bd2:: with SMTP id v18mr3464627ota.42.1602874809870;
        Fri, 16 Oct 2020 12:00:09 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l13sm1207737otj.54.2020.10.16.12.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 12:00:08 -0700 (PDT)
Received: (nullmailer pid 1743765 invoked by uid 1000);
        Fri, 16 Oct 2020 18:57:07 -0000
Date:   Fri, 16 Oct 2020 13:57:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: fxas21002c: convert bindings to yaml
Message-ID: <20201016185707.GA1743713@bogus>
References: <20201014104926.688666-1-rmfrfs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014104926.688666-1-rmfrfs@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Oct 2020 11:49:26 +0100, Rui Miguel Silva wrote:
> Convert fxas21002c gyroscope sensor bindings documentation to
> yaml schema, remove the textual bindings document and update MAINTAINERS entry.
> 
> Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
> ---
> v1 -> v2:
>    Jonathan Cameron:
>        https://lore.kernel.org/linux-iio/20201013153431.000052c9@huawei.com/
>        - remove Unit from tittle
>        - reword interrupts description
>        - drop interrupt-name description
>        - add spi example and bindings
>        - remove vddxx from required list
> 
>  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 ------
>  .../iio/gyroscope/nxp,fxas21002c.yaml         | 95 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 96 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
