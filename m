Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7F1198635
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 23:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgC3VQj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 17:16:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44363 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgC3VQi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 17:16:38 -0400
Received: by mail-io1-f68.google.com with SMTP id r25so7605596ioc.11;
        Mon, 30 Mar 2020 14:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tkKJxOuJOygZAD90Xqr7W823Gleu+iZSPyiLdvcI/vY=;
        b=ZnMxueZrPM6UgZpBoYdasOyXr97MzBdDi/MIJEP6p0KzwF9LJGpL3m0Zt0zS7roOH6
         luJi49dBsYp2Qn6NfRZ3QtdbZ3XxabuPiWUcTJ2KkgRdOhUEsliTvOu2b3Lf8zoM9pRZ
         Nru8oPl2nI8wF7z8BAQKr3KwU/d20mG/m6d7W0hBi9C+k8GPg5ar3Pg//brrdUq+1gLF
         U52mH7wmVRomLojHB6+mdbuIfM/vHee7JWVlm2n0ExmQBXho0sAIgKpXK5TRQPokXcC3
         Ex+iCayaJmm1QyuFx0me5hbw1QWTqVXkPkJi390X4V3OUe5u4/mZvZfTNiudD88uwMD2
         3frA==
X-Gm-Message-State: ANhLgQ2gUFTTlUoWFwcXplS2SC+xydXb1dpa1ZN/pfB+dAnWjNPZquJM
        fE0Smzxt3or3n4blZt4KGw==
X-Google-Smtp-Source: ADFU+vt8NcKzJ1ZQ+zYRamd2iQqQrwipjvEDCqGiJNp01E3XeT/iw5c9GD4EIlYsyre+AvLvjpMojQ==
X-Received: by 2002:a05:6602:2406:: with SMTP id s6mr12557183ioa.76.1585602997824;
        Mon, 30 Mar 2020 14:16:37 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c28sm5270849ilf.26.2020.03.30.14.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:16:36 -0700 (PDT)
Received: (nullmailer pid 3903 invoked by uid 1000);
        Mon, 30 Mar 2020 21:16:35 -0000
Date:   Mon, 30 Mar 2020 15:16:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: ad7291: add binding
Message-ID: <20200330211635.GA3708@bogus>
References: <20200317135649.8876-1-michael.auchter@ni.com>
 <20200317145113.12413-1-michael.auchter@ni.com>
 <20200317145113.12413-2-michael.auchter@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317145113.12413-2-michael.auchter@ni.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Mar 2020 09:51:13 -0500, Michael Auchter wrote:
> Add device-tree binding for ADI AD7291 ADC.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
>  .../bindings/iio/adc/adi,ad7291.yaml          | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
