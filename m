Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C861726AD04
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgIOTIO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:08:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34673 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgIOTHx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:07:53 -0400
Received: by mail-io1-f66.google.com with SMTP id m17so5385386ioo.1;
        Tue, 15 Sep 2020 12:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Y16bvKZinRXd7Mogu3amzTwmp9Gpvrpir3JmsBborA=;
        b=H958xeD28GpprwMWlSRxAGzeo3Jqs9nFiO+exPPW9lSD/4GPojAFgSaAoXSYDXirp6
         ARghp2ZmiaxK9geZRAoX0xhaxqKtPdjpmqKzGLV7NEfm8LCEO98unG52V2F363IDTW0F
         qtIV7oQbmfx/0A7RYPTDuW+E3ltsj25FcvGDEaryArUvekv98v+Pj6yF4uY60IDXlasn
         jF1mqxBxBQ9jeVN62nwxCffQMypW9T5A77XHv7cUX10b+oRlLYHyOu8flFvZv02KRVNe
         +DcJn2htZeZkO6PbMMgBTZzBQ4Q0sDNiLqUYirzhqG/8sGchXIc/MuwTAq2S4vxC42Hn
         91Mg==
X-Gm-Message-State: AOAM530TWk7KJH5bOpVgU8kyqIirEYLw5i7gDQfWLi3A+Pwd9tvwW7Bp
        j5i9ISrrigJd4ih7GR4rNA==
X-Google-Smtp-Source: ABdhPJyWBqibVGqXxMVRhBe7ylEQnaoavrAc4ZUwqeNIyAZnlzzZFfvsN3uWUipcoQOvZrCFMGpGzA==
X-Received: by 2002:a5e:c017:: with SMTP id u23mr16033127iol.139.1600196872359;
        Tue, 15 Sep 2020 12:07:52 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i13sm4467428ile.33.2020.09.15.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:07:51 -0700 (PDT)
Received: (nullmailer pid 2324678 invoked by uid 1000);
        Tue, 15 Sep 2020 19:07:50 -0000
Date:   Tue, 15 Sep 2020 13:07:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Joachim Eastwood <manabian@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 09/20] dt-bindings:iio:adc:nxp,lpc1850-adc yaml
 conversion
Message-ID: <20200915190750.GA2324625@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-10-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-10-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:35 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Most of the description in the original doc is effectively boilerplate
> and does not bring much value so I have not carried it over into the yaml.
> 
> Added #io-channel-cells to simplify use of channels on this ADC by
> consumer drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> ---
>  .../bindings/iio/adc/lpc1850-adc.txt          | 20 ------
>  .../bindings/iio/adc/nxp,lpc1850-adc.yaml     | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
